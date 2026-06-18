// Class Imports
import Task from "./classes/taskclass.js";
import Mission from "./classes/missionclass.js";

// Event Listeners for NUI Callbacks 
$(document).ready(function(){
    window.addEventListener('message', function( event ) {

        if (event.data.action == 'openMissionUI') {
            app.openMissionUI(event.data.missionData, event.data.configurations);
        } else if (event.data.action == 'updateMissionStatus') {
            app.missionsById[event.data.missionID].i_status = event.data.newStatus;
        } else if (event.data.action == 'updateTaskStatus') {
            app.missionsById[event.data.missionID].t_tasks[event.data.taskID].i_status = event.data.newStatus;
        } else if (event.data.action == 'updateTaskProgress') {
            app.missionsById[event.data.missionID].t_tasks[event.data.taskID].i_progress = event.data.newProgress;
        } else if (event.data.action == 'addNewMission') {
            app.addMission(event.data.missionData);
        } else if (event.data.action == 'syncMissionTimers') {
            app.resyncMissionTimers(event.data.timers);
        } else if (event.data.action == 'closeMissionUI') {
            app.closeMissionUI();
        } else if (event.data.action == 'npcDialog') {
            showNpcDialog(event.data);
        }

    });

    $(document).keyup(function (e) {
        if (e.key === "Escape") {
            $.post('http://dl_missions/escape', JSON.stringify({}));
        }
    });

});

let npcDialogTimer = null;

function showNpcDialog(data) {
    const overlay = document.getElementById('npc-dialog-overlay');
    const title = document.getElementById('npc-dialog-title');
    const text = document.getElementById('npc-dialog-text');

    if (!overlay || !title || !text) {
        return;
    }

    const message = String(data.message || '').trim();
    const duration = Number(data.duration) || 5000;

    if (!message) {
        hideNpcDialog();
        return;
    }

    title.textContent = data.title || 'Mission';
    text.textContent = message;

    clearTimeout(npcDialogTimer);
    overlay.style.display = 'flex';

    requestAnimationFrame(() => {
        overlay.classList.add('is-visible');
    });

    npcDialogTimer = setTimeout(() => {
        hideNpcDialog();
    }, Math.max(duration, 2500));
}

function hideNpcDialog() {
    const overlay = document.getElementById('npc-dialog-overlay');

    if (!overlay) {
        return;
    }

    overlay.classList.remove('is-visible');
    clearTimeout(npcDialogTimer);

    npcDialogTimer = setTimeout(() => {
        overlay.style.display = 'none';
    }, 250);
}


// Vue App Initialization
const app = new Vue({
    el: '#page-wrapper',
    data() {
        return {
            missions: [], // List of Mission Class Objects -> Array
            missionsById: {}, // HashMap with Mission ID as Key and Mission Class Object as Value
            selectedMissionID: -1, // Currently Selected Mission Class Object
            timerInterval: null,  // NEU: Timer Reference hinzufügen
            configurations: {
                inventoryItemsImagePath: "nui://vorp_inventory/html/img/items/",
                translations: {}
            },
            resettingMission: false
        }   
    },
    computed: {
        missionsList: function(){
            return this.missions;
        },
        selectedMission: function(){
            return this.missionsById[this.selectedMissionID];
        },
        selectedMissionTasks: function(){
            return this.selectedMission ? Object.values(this.selectedMission.t_tasks) : [];
        },
        missionImage(){
            return this.getMissionImage(this.selectedMission?.s_missionImage);
        },
        showMissionTestTools() {
            return false;
        }
    },
    methods: {
        // Open Mission UI and Populate with Missions
        openMissionUI: function(missionData, configurations){

            app.cleanUpUIData();

            this.configurations = configurations || {};

            for (let mission of missionData){
                this.addMission(mission);
            }

            this.sortMissions();

            this.selectedMissionID =  this.missions[0]?.i_id || -1;
            if (this.selectedMissionID == -1){
                console.log("No missions available to display.");
                // Post to Client Lua to Close Mission UI
                return;
            }

            // Start Mission Timers 
            this.startUpdateTimers();

            // Display the Mission UI (Implementation depends on your HTML/CSS)
            $("#page-wrapper").fadeIn(function(){
                $("#mission-details .mission_tasks").mCustomScrollbar();
                $("#active-missions #active-missions-list").mCustomScrollbar();
            });

        },
        addMission: function(mission){
            let tasks = [];
            for (let task of mission.tasks){
                let taskObj = new Task(task.id, task.title, task.description, task.status, task.type, task.progress, task.targetAmount);
                tasks[task.id] = taskObj;
            }

            const missionObj = new Mission(
                mission.id, 
                mission.title, 
                mission.description, 
                mission.status, 
                mission.type, 
                mission.missionImage, 
                mission.reward, 
                tasks,
                mission.sequentialTasks, 
                mission.timeLeft
            );

            // Zu Array hinzufügen (für sortierte Liste)
            this.missions.push(missionObj);
            
            // Zu HashMap hinzufügen (für schnellen Zugriff)
            this.missionsById[mission.id] = missionObj;

        },
        changeDetailMission: function(missionID){

            $("#mission-details .mission_tasks").mCustomScrollbar("destroy");

            this.selectedMissionID = missionID;

            this.$nextTick(() => {
                setTimeout(() => {
                    $("#mission-details .mission_tasks").mCustomScrollbar(); 
                }, 100);
            });

        },
        sortMissions: function(){
            this.missions.sort((a, b) => {
                const aIsStory = (a.s_type === "StoryMission");
                const bIsStory = (b.s_type === "StoryMission");
                
                // Story zuerst
                if (aIsStory && !bIsStory) return -1;
                if (!aIsStory && bIsStory) return 1;
                
                // Beide Story → Alphabetisch
                if (aIsStory && bIsStory) {
                    return a.s_title.localeCompare(b.s_title);
                }
                
                // Timer Check
                const aHasTimer = (a.timeLeft && !a.t_timeLeft.expired);
                const bHasTimer = (b.timeLeft && !b.t_timeLeft.expired);
                
                if (aHasTimer && !bHasTimer) return -1;
                if (!aHasTimer && bHasTimer) return 1;
                
                // Beide Timer → Kürzeste zuerst
                if (aHasTimer && bHasTimer) {
                    return a.t_timeLeft.overall_seconds - b.t_timeLeft.overall_seconds;
                }
                
                // Beide kein Timer → Alphabetisch
                return a.s_title.localeCompare(b.s_title);
            });
        
        },
        getMissionImage: function(imageName){
            if (!imageName || typeof imageName !== "string" || imageName.trim() === "") {
                return null;
            }

            return `images/taskimages/${imageName}`;
        },
        getItemImage: function(itemName){
            return this.configurations.inventoryItemsImagePath + itemName + ".png";
        },
        getAlternativeItemImage: function(event){
            const img = event.target
            if (img.src.endsWith(".png")) {
                img.src = img.src.replace(".png", ".jpg")
            } else {
                img.src = this.configurations.inventoryItemsImagePath + "unknown.png"
            }
        },

        isClosedStoryPath: function(mission) {
            return mission && mission.s_type === "StoryMission" && mission.i_status == 3;
        },

        missionFailedLabel: function(mission) {
            if (this.isClosedStoryPath(mission)) {
                return this.configurations.translations.ui_pathclosed || "Path Closed";
            }

            return this.configurations.translations.ui_failed || "Failed";
        },

        missionStatusClass: function(mission) {
            return this.isClosedStoryPath(mission) ? "mission-path-closed" : "mission-failed";
        },

        requestMissionReset: function(mission) {
            if (!mission || this.resettingMission) {
                return;
            }

            const label = mission.s_title || 'this mission';
            const confirmed = window.confirm(`Reset "${label}" for this character? This is for testing and cannot be undone.`);

            if (!confirmed) {
                return;
            }

            this.resettingMission = true;

            $.post('http://dl_missions/shadyResetMission', JSON.stringify({
                missionId: mission.i_id,
                title: mission.s_title
            }), () => {
                $.post('http://dl_missions/escape', JSON.stringify({}));
                this.resettingMission = false;
            }).fail(() => {
                this.resettingMission = false;
            });
        },

        removeMissionFromUI: function(missionID) {
            this.missions = this.missions.filter((mission) => mission.i_id !== missionID);
            delete this.missionsById[missionID];
            this.selectedMissionID = this.missions[0]?.i_id || -1;

            if (this.selectedMissionID == -1) {
                $.post('http://dl_missions/escape', JSON.stringify({}));
            }
        },

        isTaskLocked: function(task, taskIndex) {
            
            // No mission selected? Not locked
            if (!this.selectedMission) {
                return false;
            }
            
            // Mission is not sequential? Never locked
            if (!this.selectedMission.b_sequentialTasks) {
                return false;
            }
            
            // Task is completed? Not locked (show as completed)
            if (task.i_status == 2) {
                return false;
            }
            
            // Task is active? Check if previous tasks are completed
            if (task.i_status == 1) {
                
                // Check all previous tasks
                const tasksArray = this.selectedMissionTasks;
                
                for (let i = 0; i < taskIndex; i++) {
                    // If any previous task is NOT completed, current task is locked
                    if (tasksArray[i].i_status != 2) {
                        return true;  // ✅ Task is locked!
                    }
                }
                
                // All previous tasks completed? Task is unlocked
                return false;
            }
            
            // Other status (failed, etc.)? Show as locked
            return true;
        },

        // JS Timer Manager
        startUpdateTimers: function(){
            if (this.timerInterval) {
                clearInterval(this.timerInterval);
            }
            this.timerInterval = setInterval(() => {
                this.updateLocalTimers();
            }, 1000);
        },
        updateLocalTimers: function(){
            for (let missionID in this.missions) {
                let mission = this.missions[missionID];

                if (mission.t_timeLeft && !mission.t_timeLeft.expired) {
                    mission.t_timeLeft.overall_seconds--;

                    if (mission.t_timeLeft.overall_seconds <= 0) {
                        mission.t_timeLeft.overall_seconds = 0;
                        mission.t_timeLeft.expired = true;
                    }

                    mission.t_timeLeft.time_format = this.formatTime(mission.t_timeLeft.overall_seconds);

                }

            }
        },
        resyncMissionTimers: function(timers){

            if (!timers) return;

            for (let missionId in timers) {
                if (this.missionsById[missionId]) {
                    let luaTime = timers[missionId];
                    let jsTime = this.missionsById[missionId].t_timeLeft;

                    if (!luaTime || typeof luaTime.remainingSeconds !== 'number') {
                        continue;
                    }

                    // Check if a drift exists 
                    if (jsTime && typeof jsTime.overall_seconds === 'number'){
                        const drift = jsTime.overall_seconds - luaTime.remainingSeconds;
                        // If drift is greater than 1 seconds, resync the timer
                        if (Math.abs(drift) > 1) {
                            console.log(`Resyncing timer for Mission ID ${missionId}. Drift: ${drift} seconds.`);
                            this.missionsById[missionId].t_timeLeft.overall_seconds = luaTime.remainingSeconds;
                            this.missionsById[missionId].t_timeLeft.time_format = this.formatTime(luaTime.remainingSeconds);
                        }
                    }

                }
            }

        },
        formatTime: function(seconds){
            if (seconds <= 0) return "00:00";
            
            let days = Math.floor(seconds / 86400);
            let hours = Math.floor((seconds % 86400) / 3600);
            let minutes = Math.floor((seconds % 3600) / 60);
            let secs = seconds % 60;
            
            if (days > 0) {
                return `${days}d ${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
            }
            
            if (hours > 0) {
                return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
            }
            
            return `${String(minutes).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
        },

        cleanUpUIData: function(){
            this.missions = [], // List of Mission Class Objects -> Array
            this.missionsById = {}, // HashMap with Mission ID as Key and Mission Class Object as Value
            this.selectedMissionID = -1, // Currently Selected Mission Class Object
            this.timerInterval = null,  // NEU: Timer Reference hinzufügen
            this.configurations = {
                inventoryItemsImagePath: "nui://vorp_inventory/html/img/items/",
                translations: {}
            },
            this.resettingMission = false
        },

        // Close Mission UI
        closeMissionUI: function(){

            // Stop Timer Updates
            if (this.timerInterval) {
                clearInterval(this.timerInterval);
                this.timerInterval = null;
            }

            // Hide the Mission UI (Implementation depends on your HTML/CSS)
            $("#page-wrapper").fadeOut(function(){
                // Clear Missions Data from Cache
                app.cleanUpUIData();
            });
        }

    }
});

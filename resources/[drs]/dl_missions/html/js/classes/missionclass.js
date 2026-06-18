import Task from "./taskclass.js";

export default class Mission{
    constructor(id, title, description, status, type, imageName, reward, tasks, sequential, timeLeft){
        this.i_id = id;
        this.s_title = title;
        this.s_description = description;
        this.i_status = status;
        this.s_type = type;
        this.s_missionImage = imageName;
        this.t_reward = reward;
        this.t_tasks = tasks || [];
        this.b_sequentialTasks = sequential;
        this.t_timeLeft = timeLeft;
    }
}
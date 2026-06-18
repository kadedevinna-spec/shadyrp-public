-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         M-DELIVERIES - ENGLISH LOCALE (en)                    ║
-- ║                                                               ║
-- ║  Edit the strings on the right side freely.                   ║
-- ║  Do NOT change the key names on the left side.                ║
-- ╚═══════════════════════════════════════════════════════════════╝

Locales["en"] = {

    -- ═══════════════ COMMON TITLES ═══════════════
    t_error                     = "Error",
    t_warning                   = "Warning",
    t_info                      = "Info",
    t_success                   = "Success",

    -- ═══════════════ AMBUSH TITLES ═══════════════
    t_ambush_survived           = "Ambush Survived",
    t_escaped                   = "Escaped",
    t_ambush                    = "AMBUSH!",
    t_escaping                  = "Escaping",
    t_gang_fled                 = "Gang Fled",
    t_failed                    = "Failed",
    t_survived                  = "Survived",
    t_time_bonus                = "Time Bonus",
    t_mission_failed            = "Mission Failed",

    -- ═══════════════ DELIVERY TITLES ═══════════════
    t_map_updated               = "Map Updated",
    t_delivery_progress         = "Delivery Progress",
    t_stop_complete             = "Stop Complete",
    t_delivery                  = "Delivery",
    t_delivery_started          = "Delivery Started",
    t_delivery_complete         = "Delivery Complete",
    t_delivery_status           = "Delivery Status",
    t_delivery_info             = "Delivery Information",
    t_collect_packages          = "Collect Packages",
    t_left_delivery             = "Left Delivery",
    t_wagon_required            = "Wagon Required",
    t_no_mission                = "No Mission",
    t_no_wagon                  = "No Wagon",
    t_ready_to_deliver          = "Ready to Deliver",
    t_package_loaded            = "Package Loaded",

    -- ═══════════════ WAGON TITLES ═══════════════
    t_wagon_unstuck             = "Wagon Unstuck",
    t_wagon_status              = "Wagon Status",
    t_wagon_seized              = "Wagon Seized!",
    t_wagon_seized_srv          = "Wagon Seized",
    t_wagon_impounded           = "Wagon Impounded",
    t_wagon_cargo               = "Wagon Cargo",
    t_wagon_updated             = "Wagon Updated",
    t_replacing_horse           = "Replacing Horse",
    t_repairing                 = "Repairing",
    t_repaired                  = "Repaired",
    t_no_horse                  = "No Horse",

    -- ═══════════════ MISSION TITLES ═══════════════
    t_mission_resume_failed     = "Mission Resume Failed",
    t_mission_resumed           = "Mission Resumed",
    t_mission_transferred       = "Mission Transferred",
    t_mission_status            = "Mission Status",
    t_mission_cancelled         = "Mission Cancelled",
    t_operation_failed          = "Operation Failed",
    t_cannot_start              = "Cannot Start Mission",
    t_cannot_reset              = "Cannot Reset",

    -- ═══════════════ TIMER TITLES ═══════════════
    t_timer                     = "Timer",
    t_time_remaining            = "Time Remaining",
    t_cooldown_active           = "Cooldown Active",
    t_on_cooldown               = "On Cooldown",
    t_too_far                   = "Too Far",

    -- ═══════════════ PACKAGE TITLES ═══════════════
    t_placement                 = "Placement",
    t_package_system            = "Package System",

    -- ═══════════════ LAW TITLES ═══════════════
    t_witness                   = "Witness!",
    t_witness_fleeing           = "Witness Fleeing",
    t_witness_silenced          = "Witness Silenced",
    t_witness_escaped           = "Witness Escaped!",
    t_smuggling_alert           = "Smuggling Alert",
    t_alert                     = "Alert",
    t_searching                 = "Searching...",
    t_inspection_complete       = "Inspection Complete",
    t_already_inspected         = "Already Inspected",
    t_illegal_cargo             = "ILLEGAL CARGO DETECTED",
    t_evidence_access           = "Evidence Access",
    t_evidence_seized           = "Evidence Seized",
    t_evidence_confiscated      = "Evidence Confiscated",
    t_evidence_complete         = "Evidence Complete",
    t_evidence_delivered        = "Evidence Delivered",
    t_already_seized            = "Already Seized",
    t_empty                     = "Empty",

    -- ═══════════════ GROUP / POSSE TITLES ═══════════════
    t_smuggler                  = "Smuggler",
    t_leadership_transferred    = "Leadership Transferred",
    t_posse_mission_started     = "Posse Mission Started",
    t_cannot_leave              = "Cannot Leave",
    t_member_left               = "Member Left",

    -- ═══════════════ ECONOMY TITLES ═══════════════
    t_items_returned            = "Items Returned",
    t_bonus_item                = "Bonus Item",
    t_payment_received          = "Payment Received",
    t_deposit_refunded          = "Deposit Refunded",
    t_deposit_lost              = "Deposit Lost",
    t_missing_crates            = "Missing Crates",
    t_missing_items             = "Missing Items",
    t_missing_moonshine         = "Missing Moonshine",
    t_hemp_packaged             = "Hemp Packaged",
    t_moonshine_packaged        = "Moonshine Packaged",
    t_mixed_cargo_packaged      = "Mixed Cargo Packaged",
    t_reputation_too_low        = "Reputation Too Low",
    t_rep_gained                = "Reputation Gained",
    t_rep_lost                  = "Reputation Lost",
    t_items_packaged            = "Items Packaged",
    t_already_carrying          = "Already Carrying",
    t_all_loaded                = "All Loaded",
    t_inventory_full            = "Inventory Full",
    t_payment                   = "Payment",

    -- ═══════════════ AMBUSH MESSAGES ═══════════════
    m_ambush_survived           = "You've defeated all the outlaws!",
    m_escaped_outlaws           = "You've managed to escape the outlaws",
    m_ambush_warning            = "You sense danger ahead...",
    m_ambush_start              = "AMBUSH! Defend the wagon!",
    m_escaping                  = "You're getting away from the gang... stay far enough for 5 minutes to escape",
    m_escaped_no_bonus          = "You escaped from the gang! Continue your smuggling run, but you won't get the ambush survival bonus",
    m_gang_fled                 = "The remaining gang members have fled",
    m_wagon_stolen              = "The gang made off with your wagon!",
    m_escaped_continue          = "You escaped from the gang! Continue your smuggling run",
    m_ambush_survived_msg       = "You fought off the ambush!",
    m_time_bonus_ambush         = "+%d minutes for clearing the ambush",
    m_mission_failed_horses     = "The gang has taken your wagon! The horses are dead and you couldn't defend it.",
    m_wagon_stolen_default      = "The gang has stolen your wagon!",

    -- ═══════════════ DELIVERY MARKER MESSAGES ═══════════════
    m_map_updated_stop          = "Route set to stop %d of %d",
    m_map_updated_return        = "Route set to return point",
    m_package_delivered_more    = "Package delivered! %d more needed at this stop",
    m_time_bonus_delivery       = "+%d minutes added to complete the delivery",
    m_proceed_to_stop           = "Proceed to stop %d/%d (%d packages needed)",

    -- ═══════════════ LAW ALERT MESSAGES (CLIENT) ═══════════════
    m_witnessed                 = "A witness spotted your illegal cargo!",
    m_witness_fleeing           = "The witness is fleeing to report you!",
    m_witness_silenced          = "You silenced the witness before they could report.",
    m_witness_escaped           = "The witness escaped and alerted the law!",
    m_smuggling_alert_msg       = "Suspicious wagon reported",
    m_suspicious_activity       = "Suspicious activity",

    -- ═══════════════ MISSION MESSAGES ═══════════════
    m_cannot_start_mission      = "Failed to start mission",
    m_mission_resume_failed     = "Your wagon could not be found. The mission has been lost.",
    m_mission_resumed           = "Your delivery mission has been restored. Your wagon is marked on the map.",
    m_mission_failed_generic    = "The delivery mission has failed",
    m_mission_failed_timeout    = "You ran out of time! The wagon has been impounded.",
    m_mission_failed_law        = "Law enforcement has confiscated your cargo and impounded the wagon. Your smuggling run has failed.",

    -- ═══════════════ PACKAGE SYSTEM MESSAGES ═══════════════
    m_cannot_reset              = "You cannot reset the package system during an active delivery. Complete or abandon your mission first.",
    m_pkg_failed_start          = "Failed to start carrying package",
    m_already_carrying_pkg      = "You're already carrying a package!",
    m_one_at_a_time             = "You can only carry one package at a time!",
    m_invalid_pkg_config        = "Invalid package configuration for: %s",
    m_anim_not_exist            = "Animation dictionary does not exist: %s",
    m_failed_load_anim          = "Failed to load animation for carrying",
    m_failed_load_prop          = "Failed to load prop model",
    m_failed_create_prop        = "Failed to create prop",
    m_failed_placement_mode     = "Failed to enter placement mode",
    m_cannot_place              = "Cannot place here",
    m_failed_place              = "Failed to place package",
    m_invalid_pkg               = "Invalid package",
    m_not_carrying              = "You're not carrying a package",
    m_preview_cancelled         = "Preview cancelled",
    m_no_preview                = "No active preview to cancel",

    -- ═══════════════ SMUGGLING MESSAGES ═══════════════
    m_invalid_location          = "Invalid location or run data",
    m_active_operation          = "You already have an active smuggling operation",
    m_spawn_blocked             = "Something is blocking the wagon spawn area.",
    m_collect_packages          = "Take %d packages from the foreman and load them into the wagon.",
    m_prepare_failed            = "Failed to prepare the wagon. Your items have been returned.",
    m_mission_start_failed      = "Mission start failed - check console",
    m_failed_spawn_wagon        = "Failed to spawn wagon - invalid model",
    m_another_blocking          = "Another delivery wagon is blocking the spawn area. Please wait for them to leave.",
    m_someone_blocking          = "Someone is standing in the wagon spawn area. Ask them to move.",
    m_wagon_init_failed         = "Wagon failed to initialize properly. Please try again.",
    m_wagon_destroyed           = "The wagon was destroyed! Operation failed",
    m_wagon_damaged             = "WARNING: Wagon is heavily damaged!",
    m_delivery_started          = "Packages were loaded \226\128\148 delivery route is now active.",
    m_wagon_unstuck             = "Wagon was stuck and has been unfrozen. Load packages and they will be counted. Use /wagonunstuck if issues persist.",
    m_wagon_unstuck_started     = "Wagon unfrozen and delivery started!",
    m_wagon_unfrozen_packages   = "Wagon has been unfrozen. Packages: %d/%d",
    m_wagon_returned            = "Wagon returned. Talk to the foreman to complete your delivery.",
    m_left_delivery             = "You have left the group delivery",
    m_no_active_to_cancel       = "No active delivery to cancel",
    m_delivery_completed        = "Delivery completed successfully!",
    m_delivery_cancelled        = "Delivery cancelled",
    m_no_active_to_complete     = "No active delivery to complete",
    m_return_foreman            = "Return the wagon to the foreman first",
    m_complete_all_first        = "You must complete all deliveries first",
    m_wagon_must_be_nearby      = "The wagon must be nearby to complete the delivery",
    m_delivery_complete         = "Return to the foreman with the wagon to collect your payment!",
    m_no_delivery               = "You don't have an active delivery",
    m_no_delivery_talk          = "You don't have an active delivery. Talk to a foreman to start one.",
    m_timer_not_started         = "Timer hasn't started yet - load all packages first",
    m_timer_stopped             = "Timer stopped - return wagon to complete delivery",
    m_no_time_limit             = "No time limit on this mission",
    m_time_remaining            = "%d:%02d remaining",
    m_cooldown_next             = "Next mission available in:\n%s",
    m_cooldown_illegal          = "You must wait %s before accepting another smuggling contract",
    m_cooldown_legal            = "You must wait %s before accepting another delivery contract",
    m_no_wagon_exists           = "Your delivery wagon doesn't exist",
    m_time_label                = "Time: ",

    -- ═══════════════ TARGET ZONE MESSAGES ═══════════════
    m_no_evidence               = "You are not carrying any evidence!",
    m_failed_deliver_evidence   = "Failed to deliver evidence package",
    m_leadership_transferred    = "%s is now the posse leader and has taken over the mission.",
    m_mission_transferred       = "You've taken over the delivery mission. Complete the delivery!",
    m_wagon_not_registered      = "Wagon not properly registered",
    m_no_horse                  = "Bring a horse within 15m of the wagon first!",
    m_wagon_not_found           = "Wagon not found",
    m_no_wagon_access           = "You don't have access to this wagon",
    m_too_far                   = "Bring the wagon closer to a delivery location (within %dm)",
    m_no_active_job             = "No active delivery job",
    m_no_more_packages          = "No more packages available",
    m_not_carrying_pkg          = "You are not carrying a package!",
    m_no_wagon_nearby           = "No wagon found nearby",
    m_move_closer               = "Move closer to the wagon",
    m_already_inspecting        = "Already inspecting a wagon",
    m_not_authorized            = "You are not authorized to inspect cargo",
    m_searching_cargo           = "Searching wagon cargo...",
    m_nothing_to_search         = "Nothing to search.",
    m_no_cargo_info             = "No wagon cargo information available",
    m_already_inspected         = "This wagon has already been thoroughly searched. Nothing of interest found.",
    m_evidence_access           = "You can now open the wagon storage to examine the illegal cargo.\nUse 'Seize Wagon' to take it to your office as evidence.",
    m_wagon_seized_player       = "Law enforcement has seized your delivery wagon! Your mission is at risk.",
    m_evidence_seized           = "Take evidence from the wagon and deliver it to %s.\nA route has been set on your map.",
    m_evidence_confiscated      = "Successfully confiscated: %s\nThe wagon will be impounded.",
    m_evidence_complete         = "All evidence has been delivered and logged.\nYou may now impound the wagon.",
    m_wagon_good                = "Wagon is in good condition (%d%%)",
    m_wagon_no_repairs          = "Wagon doesn't need repairs",
    m_horse_attached            = "Your horse is still attached and alive!",
    m_horse_dead_detached       = "Your horse is dead or detached! Use 'Replace Wagon Horse' on the wagon.",
    m_already_replacing         = "Already replacing horse, please wait...",
    m_horse_own_wagon           = "Can only replace horse on your active delivery wagon",
    m_bring_horse_15            = "Bring an alive horse within 15 meters of the wagon first",
    m_bring_horse_8             = "Bring an alive horse within 8 meters of the wagon first",
    m_attaching_horses          = "Attaching fresh horses to wagon...",
    m_failed_load_wagon         = "Failed to load wagon model",
    m_failed_spawn_replacement  = "Failed to spawn replacement wagon",
    m_fresh_horses              = "Fresh horses attached!",
    m_fresh_horses_seized       = "Fresh horses attached to the seized wagon!",
    m_wagon_repair_access       = "Could not access wagon for repair",
    m_repairing_wagon           = "Repairing wagon... Please wait.",
    m_wagon_repaired            = "Wagon has been fully repaired!",
    m_horse_dead_replace        = "Your horse is dead! Use 'Replace Horse' to get a new one.",
    m_wagon_no_longer           = "Wagon no longer exists",
    m_wrong_stop                = "Not at the correct delivery stop",
    m_failed_deliver_pkg        = "Failed to deliver package",
    m_ready_to_deliver          = "All packages loaded! Follow the waypoint to delivery locations.",
    m_package_loaded            = "Packages: %d/%d loaded",
    m_delivery_data_notfound    = "Delivery data not found",
    m_no_delivery_stops         = "No delivery stops configured",
    m_could_not_check_wagon     = "Could not check wagon status",

    -- ═══════════════ LAW ALERTS SERVER MESSAGES ═══════════════
    m_inspect_first             = "You must inspect this wagon first and find illegal cargo",
    m_wagon_inv_not_registered  = "Wagon inventory not registered",
    m_inspect_first_seize       = "You must inspect this wagon and find illegal cargo first",
    m_already_seized            = "This wagon has already been seized as evidence",
    m_wagon_seized_evidence     = "Wagon seized as evidence. Bring it to your office to confiscate the cargo.",
    m_unload_info               = "Use 'Unload Evidence' to remove packages one at a time.",
    m_wagon_not_seized          = "This wagon has not been seized",
    m_wagon_inv_not_found       = "Wagon inventory not found",
    m_no_evidence_wagon         = "No more evidence in the wagon",
    m_invalid_office            = "Invalid office location",
    m_not_close_enough          = "You're not close enough to the evidence drop-off",
    m_evidence_complete_srv     = "All evidence has been delivered and logged. You may now impound the wagon.",
    m_evidence_delivered        = "Dropped off 1x %s. %d package(s) remaining in the wagon.",
    m_carry_deliver_info        = "Take evidence from the wagon, carry it, and deliver it at the law office.",
    m_unload_all_first          = "You must unload all evidence before impounding the wagon. %d package(s) remain.",
    m_wagon_impounded           = "The wagon has been impounded and all evidence secured.",

    -- ═══════════════ SERVER MAIN MESSAGES ═══════════════
    m_must_complete_all         = "You must complete all deliveries first (%d/%d packages)",
    m_operation_failed          = "Delivery operation failed",
    m_items_returned            = "Your items have been returned since the wagon couldn't be spawned.",
    m_bonus_item                = "You received %dx %s",
    m_payment_received          = "You earned $%s for the delivery",
    m_deposit_taken             = "A security bond of $%.2f has been collected",
    m_deposit_refunded          = "Your security bond of $%.2f has been returned",
    m_deposit_lost              = "Your security bond of $%.2f has been forfeited",
    m_deposit_insufficient      = "You need at least $%.2f to post the required bond",
    m_missing_crates            = "You need %d empty crates. You only have %d.",
    m_missing_items             = "You don't have enough %s. Need %d more.",
    m_hemp_packaged             = "Foreman packs %d cured hemp into %d crates",
    m_missing_moonshine         = "You need enough moonshine to fill %d more crates. Check your inventory!",
    m_missing_moonshine_b       = "You need enough moonshine to fill %d more crates.",
    m_moonshine_packaged        = "Foreman packs %s into %d crates",
    m_mixed_packaged            = "Foreman packs your hemp and moonshine into %d crates total",
    m_reputation_too_low        = "Your reputation isn't high enough",
    m_items_packaged            = "Foreman packages your %s (%dx)",
    m_posse_started             = "Your posse leader has started a delivery mission. Follow them!",
    m_cannot_leave_leader       = "As the mission leader, you must abandon the mission to end it for everyone",
    m_member_left               = "%s has left the delivery",
    m_wagon_updated             = "The delivery wagon has been repaired/replaced",
    m_put_down_pkg              = "Put down your current package first",
    m_all_pkg_taken             = "All %d packages have already been taken",
    m_all_pkg_taken_b           = "All packages have been taken from the foreman",
    m_inventory_full            = "You cannot carry this package. Your inventory is full or you've reached the stack limit.",
    m_wagon_cargo               = "Packages loaded: %d / %d",
    m_no_pkg_to_load            = "You don't have a package to load",
    m_wagon_inv_not_ready       = "Wagon inventory not ready yet. Try again in a moment.",
    m_no_active_job_wagon       = "No active delivery job for this wagon",
    m_no_packages_wagon         = "No packages in wagon",
    m_admin_cancelled           = "An admin has cancelled your delivery.",
    m_admin_payment             = "An admin gave you $%.2f.",

    -- ═══════════════ CONFIG MESSAGE BLOCKS ═══════════════
    -- GroupMissions
    m_group_invite_sent         = "Invitation sent to %s",
    m_group_invite_received     = "%s invited you to join their delivery group",
    m_group_joined              = "%s joined the group",
    m_group_left                = "%s left the group",
    m_group_full                = "Group is full (max %d members)",
    m_group_not_leader          = "Only the group leader can do this",
    m_group_level_too_low       = "You need to be level %d to lead a group",
    m_group_mission_started     = "Group mission started! Follow the leader.",
    m_group_mission_complete    = "Group mission complete! Rewards distributed.",

    -- MissionCooldown
    m_cooldown_wait             = "You must wait before accepting another mission",
    m_cooldown_applied          = "You can accept another mission in %s",

    -- StreakCooldown
    m_streak_cooldown           = "You've been working hard. Take a break and come back in a bit.",
    m_streak_cooldown_applied   = "Streak cooldown active \226\128\148 you can accept another delivery in %s",

    -- ForemanCooldown
    m_foreman_busy              = "This foreman already has an active operation underway. Try again later or visit a different foreman.",

    -- MissionAvailability
    m_legal_unavailable         = "Delivery operations are currently unavailable",
    m_illegal_unavailable       = "Smuggling runs only operate under cover of darkness",
    m_all_missions_disabled     = "All delivery operations are currently suspended",
    m_legal_disabled            = "Delivery operations are currently suspended",
    m_illegal_disabled          = "Smuggling runs are currently suspended",
    m_illegal_locked            = "You haven't proven yourself trustworthy enough for my... special contracts. Build your reputation first.",
    m_no_work                   = "No work available at the moment",

    -- Requirements
    m_insufficient_items        = "You don't have enough %s. Need %d more.",
    m_items_taken               = "Foreman packages your %s (%dx)",
    m_requirements_not_met      = "This job requires you to provide the cargo first",
    m_reputation_too_low_cfg    = "Your reputation isn't high enough for this type of work",
    m_insufficient_crates       = "You need %d empty crates. You only have %d.",
    m_crates_taken              = "Foreman takes %d crates for packaging",
    m_hemp_packaged_cfg         = "Foreman packs %d cured hemp into %d crates",
    m_moonshine_packaged_cfg    = "Foreman packs your %s into %d crates",
    m_mixed_packaged_cfg        = "Foreman packs your hemp and moonshine into %d crates total",

    -- LawAlerts
    m_law_alert_received        = "Illegal activity reported!",
    m_not_enough_law            = "Not enough law enforcement to attempt this",
    m_jurisdiction_crossed      = "You've entered %s territory - stay alert!",
    m_law_nearby                = "You sense law enforcement nearby...",

    -- ═══════════════ NUI (JAVASCRIPT) STRINGS ═══════════════
    nui_delivery_foreman        = "Delivery Foreman",
    nui_unknown_region          = "Unknown Region",
    nui_packages                = "packages",
    nui_stops                   = "stops",
    nui_crates                  = "crates",
    nui_hemp_crates             = "Hemp Crates",
    nui_moonshine_crates        = "Moonshine Crates",
    nui_deposit_notice          = "New haulers are required to post a $%s security bond to guarantee the safe transport of cargo. This sum shall be returned in full upon successful completion of the contract.",
    nui_unavailable             = "Unavailable",
    nui_accept_contract         = "Accept Contract",
    nui_missing_items           = "Missing Required Items",
    nui_night_work              = "Night Work",
    nui_freight_contract        = "Freight Contract",
    nui_abandon_contract        = "Abandon Contract",
    nui_return_to               = "Return to ",
    nui_adjust_cuts             = "Drag a slider to adjust cuts. Others will adjust automatically to total 100%.",
    nui_payment_set             = "Payment split set by the posse leader. Your cut is shown above.",
    nui_no_nearby_players       = "No folks nearby. Check back when others are around.",
    nui_current_contract        = "Current Contract",
    nui_cannot_accept           = "Cannot accept this mission",
    nui_return_foreman_title    = "You must return to the foreman who gave you this contract to abandon it",
    nui_original_foreman        = "original foreman",

    -- ── NUI: Navigation tabs ────────────────────────────────────────────────
    nui_tab_jobs                = "Jobs",
    nui_tab_active              = "Active",
    nui_tab_group               = "Posse",
    nui_tab_stats               = "Stats",
    nui_tab_guide               = "Guide",

    -- ── NUI: Jobs tab ───────────────────────────────────────────────────────
    nui_category_legal          = "Available Deliveries",
    nui_category_illegal        = "Special Deliveries",
    nui_no_contracts            = "No contracts available at this time.",
    nui_no_contracts_sub        = "Check back later or try another foreman.",

    -- ── NUI: Header stats bar ───────────────────────────────────────────────
    nui_stat_label_deliveries   = "Deliveries",
    nui_stat_label_earnings     = "Earnings",
    nui_stat_label_rep          = "Rep",

    -- ── NUI: Risk levels ────────────────────────────────────────────────────
    nui_risk_high               = "High Risk",
    nui_risk_moderate           = "Moderate",
    nui_risk_low                = "Low Risk",

    -- ── NUI: Active job tab ─────────────────────────────────────────────────
    nui_label_contract_type     = "Contract Type",
    nui_label_total_cargo       = "Total Cargo",
    nui_label_destinations      = "Destinations",
    nui_label_payment           = "Payment",
    nui_label_cargo_bonus       = "Cargo Protection Bonus",
    nui_delivery_progress       = "Delivery Progress",
    nui_btn_complete_delivery   = "Complete Delivery",
    nui_no_active_contract      = "No active contract",
    nui_no_active_sub           = "Accept a job from the Available Work tab to get started.",

    -- ── NUI: Statistics tab card labels ─────────────────────────────────────
    nui_stat_total_standing     = "Total Standing",
    nui_stat_total_deliveries   = "Total Deliveries",
    nui_stat_successful         = "Successful",
    nui_stat_money_earned       = "Money Earned",
    nui_stat_failed             = "Failed Deliveries",
    nui_stat_success_rate       = "Success Rate",
    nui_stat_posse_missions     = "Posse Missions",

    -- ── NUI: Posse tab ──────────────────────────────────────────────────────
    nui_posse_title             = "Delivery Posse",
    nui_posse_description       = "Round up some hands for cooperative deliveries. Set payment splits for your posse!",
    nui_posse_info_split        = "Posse leader sets the money split",
    nui_posse_info_rep          = "All hands earn the same reputation",
    nui_posse_level_req         = "Any driver can form a posse",
    nui_btn_form_posse          = "Form Posse",
    nui_your_posse              = "Your Delivery Posse",
    nui_payment_split           = "Payment Split",
    nui_nearby_folks            = "Nearby Folks",
    nui_btn_leave_posse         = "Leave Posse",
    nui_btn_disband_posse       = "Disband Posse",

    -- ── NUI: Job details modal ──────────────────────────────────────────────
    nui_choose_your_load        = "Choose Your Load",
    nui_label_cargo             = "Cargo",
    nui_label_risk_level        = "Risk Level",
    nui_payment_breakdown       = "Payment Breakdown",
    nui_base_pay                = "Base Pay",
    nui_risk_premium            = "Risk Premium",
    nui_min_guarantee           = "Minimum Guarantee",
    nui_total_payment           = "Total Payment",
    nui_required_items          = "Required Items",
    nui_security_bond_title     = "Security Bond Required",
    nui_btn_back                = "Back",

    -- ── NUI: Abandon modal ──────────────────────────────────────────────────
    nui_abandon_title           = "Abandon Contract?",
    nui_abandon_confirm_text    = "Are you sure you want to abandon this contract? You will forfeit any payment and may lose reputation with this foreman.",
    nui_btn_keep_working        = "Keep Working",
    nui_btn_abandon             = "Abandon",

    -- ── NUI: Profile modal ──────────────────────────────────────────────────
    nui_profile_title           = "Profile Picture",
    nui_profile_description     = "Enter an image URL to set your profile picture.",
    nui_profile_url_label       = "Image URL",
    nui_profile_url_placeholder = "Paste image URL here...",
    nui_btn_clear               = "Clear",
    nui_btn_cancel              = "Cancel",
    nui_btn_save                = "Save",

    -- ── NUI: Guide tab ──────────────────────────────────────────────────────
    nui_guide_title             = "Freight Hauler's Handbook",
    nui_guide_how_title         = "How It Works",
    nui_guide_how_body          = "Speak with any <strong>Delivery Foreman</strong> across the frontier to pick up a contract. You'll be given a wagon loaded with cargo and a destination — haul it there safely to collect your pay. Contracts range from simple single-stop runs to multi-stop routes across the territory.",
    nui_guide_steps_title       = "The Job, Step by Step",
    nui_guide_step1             = "Accept a contract from the <strong>Jobs</strong> tab",
    nui_guide_step2             = "Load the packages onto your wagon",
    nui_guide_step3             = "Follow the route to each drop-off point",
    nui_guide_step4             = "Unload cargo at the destination and collect payment",
    nui_guide_terrain_title     = "A Word on Terrain",
    nui_guide_terrain_body      = "Not all roads are created equal, partner. Easier territory like <strong>Saint Denis</strong> and <strong>Annesburg</strong> offer smoother rides but lighter pay — the foreman doesn't need to sweeten the deal when the roads do the work. Rougher country like <strong>Strawberry</strong> and <strong>Tumbleweed</strong> with their narrow passes and steep trails will test your skill, but the foreman pays better for the trouble. Pick a route that suits your experience — or your ambition.",
    nui_guide_rep_title         = "Reputation",
    nui_guide_rep_body          = "Every successful delivery builds your standing with that foreman. Higher reputation unlocks bigger wagons, multi-stop contracts, and eventually access to more <em>specialized</em> work. Failing a job or losing cargo will cost you standing.",
    nui_guide_posse_col_title   = "Riding with a Posse",
    nui_guide_posse_col_body    = "Any driver can form a <strong>Delivery Posse</strong> and split jobs with their crew. The leader sets each hand's cut of the pay. Everyone earns the same reputation — strength in numbers on dangerous roads.",
    nui_guide_repair_title      = "Wagon Repair",
    nui_guide_repair_body       = "If your wagon takes damage during a delivery, you can repair it on the spot. Look at the wagon and use the <strong>Repair Wagon</strong> option.",
    nui_guide_repair_step1      = "Gather the required repair materials",
    nui_guide_repair_step2      = "Check your wagon's health with <strong>Check Wagon Status</strong>",
    nui_guide_repair_step3      = "Materials are refunded if you cancel the repair",
    nui_guide_horse_title       = "Horse Replacement",
    nui_guide_horse_body        = "If your draft horse dies or becomes detached during a delivery, you can replace it with another horse.",
    nui_guide_horse_step1       = "Find any horse nearby (wild, tamed, or your own)",
    nui_guide_horse_step2       = "Lead or lasso it within <strong>15 meters</strong> of your wagon",
    nui_guide_horse_step3       = "Use the <strong>Replace Wagon Horse</strong> option on the wagon",
    nui_guide_horse_step4       = "Your cargo transfers automatically to the new wagon",
    nui_guide_tip1              = "Drive steady — cargo takes damage from rough handling",
    nui_guide_tip2              = "Multi-stop routes pay more per package than single runs",
    nui_guide_tip3              = "Keep your wagon on the road — off-trail driving risks tipping",
    nui_guide_tip4              = "Carry repair materials with you — you never know when you'll need them",

    m_rep_gained                = "+%d Reputation",
    m_rep_lost                  = "%d Reputation",

    m_illegal_cargo_found="Found: %s\nSmells like %s!",
    m_delivery_status_detail="Stop %d/%d: %d/%d packages delivered\nTotal: %d/%d packages",

    -- ═══════════════ TARGET / INTERACTION LABELS ═══════════════
    label_talk_foreman          = "Talk to Foreman",
    label_take_package          = "Take Package",
    label_load_package          = "Load Package",
    label_open_wagon_cargo      = "Open Wagon Cargo",
    label_repair_wagon          = "Repair Wagon",
    label_replace_horse         = "Replace Wagon Horse",
    label_check_wagon_status    = "Check Wagon Status",
    label_deliver_package       = "Deliver Package",
    label_delivery_status       = "Check Delivery Status",
    m_job_restricted            = "Your current job does not have access to deliveries.",

    -- ═══════════════ REGION NAMES (for NUI header) ═══════════════
    nui_region_new_hanover      = "New Hanover Region",
    nui_region_saint_denis      = "Saint Denis Region",
    nui_region_strawberry       = "Strawberry Region",
    nui_region_tumbleweed       = "Tumbleweed Region",
    nui_region_valentine        = "Valentine Region",
    nui_region_rhodes           = "Rhodes Region",
    nui_region_blackwater       = "Blackwater Region",

    -- ═══════════════ MISSION DESCRIPTIONS (pipe-delimited) ═══════════════
    -- Story element lists (comma-separated) — used by legal/illegal template descriptions
    desc_legal_clients          = "the general store,a ranch owner,the railway office,a mining company,the town doctor,the hotel,a wealthy landowner,the lumber mill,the sheriff's office,a church congregation,the telegraph office,a cattle baron,the local tailor,a photography studio",
    desc_legal_goods            = "supplies,provisions,equipment,medicine,tools,fabric,hardware,foodstuffs,machinery parts,books,furniture,agricultural supplies,mining equipment,weapons,leather goods,glassware,clothing,canned goods",
    desc_legal_reasons          = "They're running low on stock.|There's a big event coming up.|Winter is approaching and they need to stock up.|The previous shipment was lost.|Business has been good and they need more.|A special order came in from a customer.|They're expanding their operation.|The regular supplier let them down.",
    desc_illegal_contacts       = "a discreet buyer,an underground fence,a corrupt official,a rival gang,a desperate farmer,a shady bartender,an anonymous benefactor,a foreign trader,a railroad worker,a saloon owner in debt,a crooked banker,a mysterious stranger",
    desc_illegal_goods          = "moonshine,contraband weapons,stolen goods,forged documents,smuggled whiskey,illegal gambling equipment,banned substances,black market medicine,counterfeit money,stolen artwork",
    desc_illegal_warnings       = "Keep your head down and don't draw attention.|Stick to the back roads - eyes are everywhere.|Word is there's trouble out on the trails - stay sharp.|Rival outfits might try to jump the cargo.|This is off the books - you were never here.|Don't go asking questions about the cargo.|The buyer spooks easy - be discreet.|There's folks looking for this cargo - watch your back.",

    -- Legal description templates ({packages}, {stops}, {client}, {Client}, {goods}, {Goods}, {reason})
    desc_legal_templates        = "Deliver {packages} crates of {goods} to {client} across {stops} locations. {reason}|{Client} has ordered {packages} packages of {goods}. Deliver to {stops} stops. {reason}|Transport {packages} units of {goods} to {stops} destinations for {client}.|{Goods} {packages} crates need delivering to {stops} locations for {client}.",

    -- Illegal description templates ({packages}, {stops}, {contact}, {Contact}, {goods}, {warning})
    desc_illegal_templates      = "Deliver {packages} crates of {goods} to {contact} across {stops} locations. {warning}|Move {packages} packages to {contact} at {stops} drop points. {warning}|{Contact} needs {packages} units of {goods} delivered to {stops} locations. {warning}|Transport {packages} crates of {goods}. {stops} stops total. {warning}",

    -- Hemp descriptions (customizable = no placeholders, fixed = {packages}/{stops})
    desc_hemp_custom            = "I've got buyers all over the region for cured hemp. How many crates can you bring me? The more you load up, the more we both make.|Hemp's in high demand right now. Bring me what you've got packed in crates and I'll line up the buyers. You decide how big the haul is.|Got contacts hungry for dried hemp. Tell me how much you're looking to move — I'll arrange the drop-offs and handle the payouts.|Every crate of hemp you bring me means another buyer. Load up as many as you can manage and I'll make sure they find good homes.|The market for cured hemp is wide open. You set the quantity, I'll set the route. More product means more stops, but better pay.|I can move as much hemp as you can supply. Pack your crates and tell me how heavy you want this run to be.",
    desc_hemp_fixed             = "Got a buyer who needs {packages} crates of cured hemp moved to {stops} drop-offs. You bring the product, I handle the rest.|Lined up {packages} buyers for dried hemp across {stops} locations. Pack your own crates and get moving.|A contact out yonder wants {packages} crates of hemp delivered to {stops} spots. Bring your supply and keep it quiet.|I found {packages} outlets for cured hemp. {stops} stops along the backroads — you supply the goods, they pay on delivery.|There's demand for {packages} crates of hemp at {stops} drop points. Load up your stash and haul it out.|Fella down south is buying hemp in bulk — {packages} crates across {stops} locations. You provide the product.",

    -- Moonshine descriptions
    desc_moonshine_custom       = "Plenty of thirsty folk out there looking for shine. How many crates are you bringing me? I'll find buyers for every last bottle.|Moonshine's selling like water in a drought. Tell me how much you've got and I'll arrange the deliveries. You set the pace.|I've got a list of names wanting 'shine — as long as your arm. Bring me what you can and we'll split the profits fair.|Every crate of moonshine you bring is money in your pocket. Load up your wagon and tell me how much you're hauling tonight.|The demand for shine never dries up. You decide how big this run is — more bottles, more stops, better pay.|Got buyers spread across the territory. How much moonshine can you supply? I'll match every crate with a contact.",
    desc_moonshine_fixed        = "Got {packages} thirsty buyers lined up for moonshine across {stops} spots. Bring your shine and don't let a drop spill.|Arranged {packages} deliveries of moonshine to {stops} locations along the river. You supply the bottles.|There's {packages} buyers with names on 'em waiting for shine. {stops} stops, back roads only — bring your own stock.|Found a market for {packages} crates of moonshine at {stops} locations. Pack your 'shine and move fast.|Contacts are thirsty — {packages} crates of moonshine needed across {stops} drop-offs. You brew it, I sell it.|I've got {packages} orders for 'shine at {stops} spots across the county. Bring your supply, stick to the dirt roads.",

    -- Mixed descriptions
    desc_mixed_custom           = "Got buyers wanting both hemp and moonshine. Bring me what you can of each — more product means more stops and better pay for you.|Mixed orders today. Some contacts want hemp, others want shine. Tell me how much of each you're bringing and I'll work out the route.|I can move hemp and moonshine both — demand's strong for the pair. You decide the split. Load up and let's talk numbers.|Full roster of contacts — some for hemp, some for 'shine. How heavy you want each side of the load? You set it, I'll sell it.|Hemp and moonshine are both moving fast. Bring me what you've got of each and I'll make sure every crate finds a buyer.|Double the product, double the opportunity. Tell me how much hemp and how much shine you're looking to move tonight.",
    desc_mixed_fixed            = "Big orders today — {packages} crates of hemp and moonshine going to {stops} buyers. Bring your stock.|Mixed demand: {packages} crates needed across {stops} spots. Some want hemp, others want shine — you supply both.|I've got {packages} buyers lined up — some for hemp, some for moonshine. {stops} locations, bring your goods.|Full roster of orders — {packages} crates across {stops} drops. Pack your hemp and 'shine, I've got the buyers.|Contacts want {packages} mixed crates at {stops} stops. Hemp for some, moonshine for others — you bring the product.|Lined up {packages} orders for hemp and moonshine both. {stops} drops across the territory — supply's on you.",

    -- Fallback descriptions (pipe-delimited, {packages}/{stops})
    desc_fallback_illegal       = "Move {packages} crates to {stops} drop points along the back trails. Keep your head down.|Haul {packages} packages out to {stops} locations off the beaten path.|Deliver {packages} crates of goods to {stops} contacts. Stay off the main roads.|Handle {packages} crates across {stops} stops. No paper trail.",
    desc_fallback_legal_low     = "Deliver {packages} packages to {stops} locations along an established route.|Transport {packages} crates of general goods to {stops} destinations.|Complete {packages} package deliveries across {stops} stops. Standard freight work.",
    desc_fallback_legal_mid     = "Move {packages} valuable packages to {stops} locations. Handle with care.|Transport {packages} crates through moderately traveled routes to {stops} stops.|Deliver {packages} packages to {stops} destinations. Some road hazards expected.",
    desc_fallback_legal_high    = "Haul {packages} high-value packages through {stops} remote locations. Stay alert.|Transport {packages} crates of premium goods to {stops} stops. Route may be dangerous.|Complete {packages} deliveries across {stops} locations in rough territory.",
    desc_risk_warnings          = "High risk of ambush.|Bandits have been spotted on this route.|Exercise extreme caution.|Consider bringing backup.",

    -- ═══════════════ NUI: ADDITIONAL TRANSLATABLE STRINGS ═══════════════
    -- Progress section (Active tab)
    nui_loaded                  = "Loaded:",
    nui_delivered_label         = "Delivered:",

    -- Quantity summary (Job details modal)
    nui_total_label             = "Total:",
    nui_est_pay                 = "Est. Pay:",

    -- Tooltips & status messages
    nui_law_blocked             = "Not available for law enforcement",
    nui_night_only_browse       = "Missions available at night (7:30pm–6am) — browse to see what's coming",
    nui_requires_level          = "Requires Level %s (you're %s)",
    nui_requires_level_short    = "Requires Level %s",
    nui_cannot_accept_view      = "Cannot accept — view details",
    nui_cannot_accept_now       = "Cannot accept missions at this time",
    nui_cooldown_prefix         = "Cooldown:",
    nui_change_profile          = "Click to change profile picture",

    -- Requirement labels
    nui_or                      = "or",
    nui_moonshine_any_type      = "Moonshine",
    nui_moonshine_any_type_hint = "(any type — pick one)",
    nui_cured_hemp              = "Cured Hemp",

    -- Active job details
    nui_defeated_attackers      = "Defeated %s/%s attackers",
    nui_stat_level_format       = "Level (%s)",
    nui_default_rank_title      = "Greenhorn",
    nui_ready                   = "Ready!",

    -- Posse UI
    nui_posse_count             = "%s/%s Posse",
    nui_posse_leader            = "Posse Leader",
    nui_posse_hand              = "Hand",
    nui_posse_formed            = "Posse formed successfully!",
    nui_group_level_required    = "Requires Level %s to lead a group (You are Level %s)",

    -- Invite states
    nui_invite                  = "Invite",
    nui_sending                 = "Sending...",
    nui_sent                    = "Sent",
    nui_invited                 = "Invited",

    -- Disabled reason strings (Lua-side)
    nui_block_group_leader      = "Your group leader has an active mission",
    nui_block_group_member      = "A group member has an active mission",
    nui_block_active_mission    = "You already have an active mission",
    nui_cooldown_active         = "Cooldown active",
    nui_night_only_short        = "Only available at night (after 7:30pm)",
}
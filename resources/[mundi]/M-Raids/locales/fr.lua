Locales['fr'] = {

    -- =====================================================================
    -- GENERAL
    -- =====================================================================
    prompt_start_raid        = 'Commencer le raid',
    prompt_open_loot         = 'Ouvrir le coffre',
    prompt_loot_searching    = 'Fouille du coffre...',    prompt_talk              = 'Parler',
    prompt_disable_alarm     = "Désactiver l'Alarme",
    prompt_search_loot_chest = 'Fouiller le Coffre',
    prompt_inspect_vault     = 'Inspecter le Coffre-fort',
    prompt_search_vault      = 'Fouiller le Coffre-fort',
    prompt_place_dynamite    = 'Poser la Dynamite',
    prompt_interact_wagon    = 'Interagir avec la Diligence',
    prompt_route_informant   = 'Indicateur de Route',
    prompt_reading_map       = 'Lecture des plans de route...',
    prompt_pick_up           = 'Ramasser %s',
    -- =====================================================================
    -- TRAVEL / APPROACH
    -- =====================================================================
    travel_go_to_location    = "Rendez-vous à l'emplacement indiqué pour commencer.",
    travel_timeout           = 'Vous avez mis trop de temps à atteindre la zone.',

    -- =====================================================================
    -- RAID FLOW
    -- =====================================================================
    area_clear               = 'La zone est sécurisée.',
    area_disturbance         = 'Quelque chose ne va pas dans cette zone.',
    area_command_taken       = 'Vous avez pris le contrôle de la zone.',

    cavalry_incoming         = 'Des renforts arrivent.',
    wave_incoming            = 'Vague %d en approche.',
    raid_failed_abandoned    = "Le raid a échoué. Personne n'en est sorti.",
    law_fled                 = "Leur chef s'est enfui.",
    raid_resumed             = 'Raid repris ! Vous vous êtes reconnecté.',
    raid_resumed             = 'Raid repris ! Vous vous êtes reconnecté.',

    -- =====================================================================
    -- HOST / PARTY
    -- =====================================================================
    now_host                 = 'Vous dirigez maintenant le raid.',
    host_transferred         = 'Commandement du raid transmis (%s).',
    missing_required_item    = 'Il vous faut : %s',

    -- =====================================================================
    -- LOOT CHESTS
    -- =====================================================================
    loot_chest_locked        = "Le verrou est bloqué. Essayez autre chose.",
    loot_chest_not_found     = 'Vous ne trouvez pas le coffre.',
    loot_chest_empty         = 'Le contenant est vide.',
    loot_chest_looted        = 'Ce coffre a déjà été pillé.',
    loot_chest_not_yet       = "La zone n'est pas assez sécurisée pour piller.",
    loot_too_far             = 'Approchez-vous du coffre.',
    loot_found_cash          = 'Trouvé $%s.',
    loot_found_moneybag      = "Trouvé un sac d'argent valant $%s.",
    loot_found_item          = 'Trouvé : %s.',
    loot_found_nothing       = "Il n'y avait rien qui vaille la peine d'être pris.",

    -- =====================================================================
    -- LOCKPICK
    -- =====================================================================
    lockpick_need_item       = 'Vous avez besoin d\'un %s pour tenter cela.',
    lockpick_broke           = 'Votre %s s\'est cassé. Vous aurez besoin d\'un remplacement.',

    -- =====================================================================
    -- VAULT
    -- =====================================================================
    vault_place_dynamite     = 'Posez la dynamite sur le coffre-fort.',
    vault_fuse_lit           = 'Mèche allumée ! Dégagez !',
    vault_moved_away         = 'Vous vous êtes éloigné de la mèche.',
    vault_blown_open         = 'Le coffre-fort a sauté !',
    vault_searching          = 'Fouille du coffre-fort...',
    vault_need_dynamite      = 'Vous avez besoin de dynamite pour ouvrir ce coffre-fort.',
    vault_cancelled          = 'Pose de dynamite annulée.',

    -- =====================================================================
    -- ALARM
    -- =====================================================================
    alarm_disabled           = "Alarme neutralisée.",
    alarm_failed             = "Impossible de désactiver l'alarme.",

    -- =====================================================================
    -- SERVER CHECKS
    -- =====================================================================
    check_spawn_failed       = 'Échec de la génération pour le modèle : %s. Consultez les journaux du serveur.',
    check_invalid_location   = "Cet emplacement n'est pas valide.",
    check_not_your_fight     = "Ce n'est pas votre combat.",
    check_raid_active        = 'Un autre raid est déjà en cours.',
    check_cooldown           = 'Le %s est encore en recharge. %s minutes restantes.',
    check_too_far            = 'Vous devez être plus proche pour démarrer un raid.',
    check_friendly_job       = "Votre métier vous tient à l'écart de ça.",
    check_not_enough_law     = 'Pas assez de shérifs dans les parages. Revenez plus tard.',
    check_ownership_error    = "Certaines entités n'ont pas pu être transférées.",
    check_ownership_ok       = 'Transfert de propriété terminé.',
    check_reinforcements     = 'Renforts ennemis en approche !',
    check_boundary_occupied  = "La zone est occupée. Dégagez-la avant d'attaquer.",
    check_too_many_law       = "Trop de badges dans les parages. Revenez quand c'est plus calme.",
    check_jurisdiction_active = 'Un autre raid est déjà actif dans cette juridiction (%s). Attendez la fin.',
    check_cooldown_area      = 'Les gardes de %s sont en alerte maximale. Revenez dans %d minutes.',
    check_need_item          = "Vous avez besoin d'un %s pour démarrer ce raid.",
    check_not_enough_law_count = "Pas assez de forces de l'ordre en ligne. Ce raid nécessite %d officiers %s (%d en ligne).",
    check_boundary_occupied  = "La zone est occupée. Dégagez-la avant d'attaquer.",
    check_too_many_law       = "Trop de badges dans les parages. Revenez quand c'est plus calme.",
    check_jurisdiction_active = 'Un autre raid est déjà actif dans cette juridiction (%s). Attendez la fin.',
    check_cooldown_area      = 'Les gardes de %s sont en alerte maximale. Revenez dans %d minutes.',
    check_need_item          = "Vous avez besoin d'un %s pour démarrer ce raid.",
    check_not_enough_law_count = "Pas assez de forces de l'ordre en ligne. Ce raid nécessite %d officiers %s (%d en ligne).",

    -- =====================================================================
    -- MINIGAME ERRORS
    -- =====================================================================
    minigame_unavailable     = "Le système de mini-jeu n'est pas disponible.",
    minigame_error           = 'Une erreur est survenue dans le mini-jeu.',
    minigame_timeout         = 'Le mini-jeu a expiré.',

    -- =====================================================================
    -- BANK WAGON
    -- =====================================================================
    bw_already_active        = 'Vous avez déjà un vol de diligence en cours.',
    bw_no_route_info         = "Ce contact n'a pas d'informations sur les routes.",
    bw_no_jurisdiction       = 'Vous devez être dans une juridiction pour utiliser ce plan. Actuellement dans : %s',
    bw_no_routes             = 'Aucune route disponible à %s.',
    bw_anim_failed           = "Échec du chargement de l'animation. Réessayez.",
    bw_prop_failed           = "Échec du chargement de l'objet. Réessayez.",
    bw_invalid_route         = 'Route sélectionnée invalide.',
    bw_route_unavailable     = "Cette route n'est pas disponible à votre emplacement actuel.",
    bw_admin_cooldown_bypass = '[Admin] Recharge ignorée.',
    bw_spawn_failed          = "Le fourgon n'a pas pu apparaître. Vos plans de route ont été restitués.",
    bw_no_moneybag           = "Vous n'avez pas de sac d'argent.",
    bw_takeover              = "Vous avez pris le contrôle d'un vol de diligence !",

    -- =====================================================================
    -- FOURGON BANCAIRE — notifications criminelles
    -- =====================================================================
    bw_criminal_cancelled       = 'Vol annulé.',
    bw_criminal_missing_item    = 'Vous avez besoin des Plans de Route pour démarrer ce vol.',
    bw_criminal_route_cooldown  = 'Cette route a été attaquée récemment. Attendez encore %d minutes.',
    bw_wagon_spotted            = "Fourgon bancaire repéré ! Allez à l'interception !",
    bw_missing_dynamite         = 'Vous avez besoin de dynamite pour faire sauter le fourgon !',
    bw_wagon_moved              = 'Fourgon déplacé - placement annulé !',
    bw_fuse_active              = 'Mèche allumée - dégagez !',
    bw_criminal_wagon_destroyed = 'Le fourgon a été détruit avant que vous puissiez le piller !',
    bw_wagon_escaped            = "Le fourgon s'est échappé !",
    bw_heat_dissipating         = "Le métal du fourgon est trop chaud ! Attendez qu'il refroidisse. (%d secondes restantes)",
    bw_heat_dissipated          = 'Le métal a refroidi. Vous pouvez maintenant préparer la dynamite !',
    bw_preparing_dynamite       = 'Préparation des charges explosives...',
    bw_dynamite_ready           = 'Dynamite préparée et placée !',
    bw_loot_collected           = 'Récupéré %dx %s',
    bw_loot_taken               = "Quelqu'un a déjà pris ça !",

    -- =====================================================================
    -- FOURGON BANCAIRE — forces de l'ordre
    -- =====================================================================
    bw_law_alert_initial        = '~r~Fourgon bancaire sous attaque !~s~',
    bw_law_alert_update         = '~y~Dernière position :~s~ %s',
    bw_law_at_destination       = '~y~Fourgon à destination ! Descendez pour terminer la livraison.',
    bw_law_delivery_complete    = '~g~Livraison terminée ! La Banque Centrale vous félicite. Excellent travail.',
    bw_law_wagon_recovered      = '~g~Fourgon bancaire récupéré !~s~ Livrez-le à la destination marquée.',
    bw_law_delivered_criminal   = '~r~Échec !~s~ Le fourgon a atteint sa destination.',
    bw_law_delivered_npc        = 'Le fourgon bancaire a atteint sa destination sans encombre.',
    bw_law_wagon_destroyed      = "Le fourgon a été détruit avant d'atteindre sa destination.",

    -- =====================================================================
    -- FOURGON BANCAIRE — proximité / spawn / gameplay
    -- =====================================================================
    bw_en_route                 = 'Fourgon bancaire en route. Suivez-le sur la carte.',
    bw_nearby                   = 'Fourgon bancaire proche !',
    bw_spawned                  = 'Fourgon bancaire apparu !',
    bw_guards_spotted           = '~r~Les gardes vous ont repéré !',
    bw_wagon_destroyed_early    = 'Le fourgon a été détruit !',
    bw_escorts_lost             = 'Vous avez semé les escortes ! Préparez la dynamite.',
    bw_guards_eliminated        = 'Gardes éliminés ! Attendez %d secondes le temps que le fourgon refroidisse.',
    bw_guards_enough            = 'Assez de gardes éliminés ! Attendez %d secondes le temps que le fourgon refroidisse.',
    bw_placement_died           = 'Placement interrompu - vous êtes mort !',
    bw_placement_movement       = 'Placement annulé - mouvement détecté.',
    bw_placement_interrupted    = 'Placement annulé - action interrompue.',

    -- =====================================================================
    -- FOURGON BANCAIRE — restriction / admin
    -- =====================================================================
    bw_law_denial               = "La tentation est grande, mais vous feriez mieux de rester à l'écart.",
    bw_fence_not_allowed        = 'Cette opération est réservée - votre métier ne vous qualifie pas.',
    bw_admin_end_all            = 'Tous les vols de fourgons bancaires ont été terminés.',
    bw_admin_end_one            = 'Le vol du fourgon bancaire #%d a été terminé.',

    -- =====================================================================
    -- RAIDS — liste de métiers
    -- =====================================================================
    check_allowed_jobs          = 'Ce raid est réservé - votre métier ne vous qualifie pas.',

    -- =====================================================================
    -- ADMIN / DEBUG
    -- =====================================================================
    admin_no_permission      = "Vous n'avez pas la permission de faire cela.",
    admin_active_raids       = 'Raids actifs : %s',
    admin_wave_triggered     = 'Vague suivante déclenchée pour le raid %s.',
    admin_wave_usage         = 'Utilisation : /testraidwave <raidId>',
    admin_loot_unlocked      = 'Butin déverrouillé pour le raid %s.',
    admin_raid_ended         = 'Raid %s terminé.',
    admin_cooldown_reset     = 'Recharge réinitialisée pour : %s',
    admin_cooldown_reset_all = 'Toutes les recharges réinitialisées.',
}
Locales['fr'] = {
    -- Général
    ['checking_player']       = 'Vérification du joueur...',
    ['steam_required']        = 'Un identifiant Steam est requis pour rejoindre ce serveur.',
    ['no_permission']         = 'Vous n\'avez pas la permission de faire cela.',
    ['player_not_found']      = 'Joueur introuvable.',
    ['no_reason']             = 'Aucune raison fournie.',
    ['invalid_usage']         = 'Utilisation de commande invalide.',

    -- Messages de bannissement
    ['banned_message']        = 'Vous êtes banni de ce serveur.',
    ['reason']                = 'Raison',
    ['expires']               = 'Expire',
    ['permanent']             = 'Permanent',
    ['ban_appeal']            = 'Vous pouvez faire appel de ce bannissement sur le Discord du serveur.',
    ['no_active_ban']         = 'Aucun bannissement actif trouvé pour ce joueur.',

    -- Actions administrateur
    ['kicked_by_admin']       = 'Vous avez été expulsé par un administrateur.',
    ['player_kicked']         = 'Le joueur %s a été expulsé.',
    ['player_banned']         = 'Le joueur %s a été banni.',
    ['player_unbanned']       = 'Le joueur a été débanni.',
    ['you_were_warned']       = 'Vous avez reçu un avertissement',
    ['player_warned']         = 'Le joueur %s a été averti.',
    ['player_frozen']         = 'Le joueur %s a été gelé.',
    ['player_unfrozen']       = 'Le joueur %s a été dégelé.',
    ['you_are_frozen']        = 'Vous avez été gelé par un administrateur.',
    ['you_are_unfrozen']      = 'Vous avez été dégelé.',
    ['you_were_revived']      = 'Vous avez été réanimé par un administrateur.',
    ['spectate_started']      = 'Vous observez maintenant. Appuyez sur Retour pour arrêter.',
    ['spectate_stopped']      = 'Observation terminée.',

    -- Utilisation des commandes
    ['usage_kick']            = 'Utilisation: /gkick [id] [raison]',
    ['usage_ban']             = 'Utilisation: /gban [id] [durée] [raison]',
    ['usage_unban']           = 'Utilisation: /gunban [identifiant_steam]',
    ['usage_warn']            = 'Utilisation: /gwarn [id] [raison]',
    ['usage_goto']            = 'Utilisation: /ggoto [id]',
    ['usage_bring']           = 'Utilisation: /gbring [id]',
    ['usage_report']          = 'Utilisation: /report [message]',
    ['usage_preport']         = 'Utilisation: /preport [id_joueur] [raison]',

    -- Signalements
    ['report_submitted']      = 'Signalement soumis. Un administrateur le vérifiera prochainement.',
    ['report_cooldown']       = 'Veuillez patienter avant de soumettre un autre signalement.',

    -- Anti-triche
    ['kicked_anticheat']      = 'Vous avez été retiré par le système anti-triche.',
    ['detection_teleport']    = 'Téléportation détectée',
    ['detection_speedhack']   = 'Speed hack détecté',
    ['detection_godmode']     = 'Mode dieu détecté',
    ['detection_explosion']   = 'Spam d\'explosions détecté',
    ['detection_eventspam']   = 'Spam d\'événements détecté',
    ['detection_resource']    = 'Ressource non autorisée détectée',
    ['detection_blacklisted'] = 'Événement sur liste noire déclenché',
    ['detection_money']       = 'Anomalie monétaire détectée',
    ['detection_item_dupe']   = 'Duplication d\'objet suspectée',

    -- Alertes
    ['alert_economy_anomaly'] = 'Anomalie économique: %s a reçu %s de manière inattendue.',
    ['alert_item_duplication']= 'Duplication possible d\'objet: %s a reçu %sx %s.',
    ['alert_chat_spam']       = 'Spam de chat détecté de %s.',
    ['alert_new_resource']    = 'Nouvelle ressource démarrée: %s',
    ['alert_resource_stopped']= 'Ressource arrêtée: %s',
    ['alert_player_flagged']  = 'Le joueur %s a été signalé: %s',
    ['alert_large_txn']       = 'Grande transaction détectée: %s - %s %s',

    -- Tableau de bord
    ['dashboard_title']       = 'Tableau de bord M-ServerGuard',
    ['players_online']        = 'Joueurs en ligne',
    ['peak_players']          = 'Joueurs maximum',
    ['total_unique']          = 'Joueurs uniques totaux',
    ['active_bans']           = 'Bannissements actifs',
    ['detections_today']      = 'Détections aujourd\'hui',
    ['alerts_today']          = 'Alertes aujourd\'hui',
    ['economy_txns']          = 'Transactions économiques',
    ['total_resources']       = 'Ressources totales',

    -- Divers
    ['server_guard_started']  = 'M-ServerGuard v%s initialisé — Framework: %s',
    ['database_initialized']  = 'Tables de base de données initialisées.',
    ['resources_scanned']     = '%s ressources analysées (%s catégories).',
    ['daily_summary']         = 'Résumé quotidien généré.',
    ['data_cleanup']          = 'Nettoyage des anciennes données terminé (%s jours de rétention).',

    -- Screening
    ['screening_steam']        = 'Vérification du compte Steam...',
    ['screening_alts']         = 'Vérification de l\'historique du compte...',
    ['screening_denied']       = 'Connexion refusée : votre compte a été signalé par notre système de sécurité. Contactez un administrateur si vous pensez qu\'il s\'agit d\'une erreur.',
}

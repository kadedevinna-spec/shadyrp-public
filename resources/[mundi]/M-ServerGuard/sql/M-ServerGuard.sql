-- ============================================================
-- M-ServerGuard Database Setup
-- Author: Mundi
-- Version: 1.0.0
-- ============================================================
-- Run once on fresh install, or let the script auto-create tables.
-- Compatible with MySQL 8+
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS mguard_players (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100) UNIQUE,
        discord VARCHAR(100),
        license VARCHAR(100),
        ip VARCHAR(45),
        xbl VARCHAR(100),
        live VARCHAR(100),
        fivem VARCHAR(100),
        tokens TEXT,
        player_name VARCHAR(100),
        char_name VARCHAR(100),
        char_identifier VARCHAR(100),
        player_group VARCHAR(50) DEFAULT 'user',
        first_seen DATETIME DEFAULT CURRENT_TIMESTAMP,
        last_seen DATETIME DEFAULT CURRENT_TIMESTAMP,
        total_playtime INT DEFAULT 0,
        total_sessions INT DEFAULT 0,
        money BIGINT DEFAULT 0,
        gold BIGINT DEFAULT 0,
        risk_score INT DEFAULT 0,
        trust_score INT DEFAULT -1,
        is_banned TINYINT DEFAULT 0,
        is_whitelisted TINYINT DEFAULT 1,
        notes TEXT,
        INDEX idx_discord (discord),
        INDEX idx_license (license),
        INDEX idx_char (char_identifier)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_sessions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        player_name VARCHAR(100),
        char_identifier VARCHAR(100),
        join_time DATETIME DEFAULT CURRENT_TIMESTAMP,
        leave_time DATETIME,
        duration_seconds INT DEFAULT 0,
        ip VARCHAR(45),
        leave_reason VARCHAR(255),
        INDEX idx_steam (steam),
        INDEX idx_join (join_time),
        INDEX idx_char (char_identifier)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_economy_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        char_identifier VARCHAR(100),
        player_name VARCHAR(100),
        transaction_type VARCHAR(20),
        currency_type VARCHAR(20),
        amount DECIMAL(15,2),
        balance_before DECIMAL(15,2),
        balance_after DECIMAL(15,2),
        source_resource VARCHAR(100),
        source_event VARCHAR(200),
        target_steam VARCHAR(100),
        target_name VARCHAR(100),
        reason VARCHAR(500),
        flagged TINYINT DEFAULT 0,
        flag_reason VARCHAR(255),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_type (transaction_type),
        INDEX idx_flagged (flagged),
        INDEX idx_created (created_at),
        INDEX idx_char (char_identifier)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_item_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        char_identifier VARCHAR(100),
        player_name VARCHAR(100),
        action VARCHAR(30),
        item_name VARCHAR(100),
        item_label VARCHAR(200),
        quantity INT,
        metadata TEXT,
        source_resource VARCHAR(100),
        source_event VARCHAR(200),
        flagged TINYINT DEFAULT 0,
        flag_reason VARCHAR(255),
        counterparty_steam VARCHAR(100) NULL,
        counterparty_name VARCHAR(100) NULL,
        transfer_id VARCHAR(36) NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_item (item_name),
        INDEX idx_action (action),
        INDEX idx_flagged (flagged),
        INDEX idx_created (created_at),
        INDEX idx_transfer (transfer_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_detections (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        player_name VARCHAR(100),
        detection_type VARCHAR(50),
        severity VARCHAR(20),
        details TEXT,
        metadata TEXT,
        action_taken VARCHAR(50),
        resolved TINYINT DEFAULT 0,
        resolved_by VARCHAR(100),
        resolved_at DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_type (detection_type),
        INDEX idx_severity (severity),
        INDEX idx_resolved (resolved),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_bans (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        discord VARCHAR(100),
        license VARCHAR(100),
        ip VARCHAR(45),
        tokens TEXT,
        player_name VARCHAR(100),
        char_name VARCHAR(100),
        banned_by VARCHAR(100),
        banned_by_name VARCHAR(100),
        reason VARCHAR(500),
        ban_type VARCHAR(20) DEFAULT 'permanent',
        expiry_date DATETIME,
        is_active TINYINT DEFAULT 1,
        appeal_status VARCHAR(20) DEFAULT 'none',
        appeal_reason TEXT,
        appeal_date DATETIME,
        unbanned_by VARCHAR(100),
        unbanned_at DATETIME,
        unban_reason VARCHAR(255),
        previous_bans INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        txadmin_action_id VARCHAR(64) DEFAULT NULL,
        ban_source VARCHAR(32) DEFAULT 'manual',
        ban_category VARCHAR(50) DEFAULT 'uncategorised',
        community_status VARCHAR(20) DEFAULT 'none',
        community_submitted_at DATETIME NULL,
        INDEX idx_steam (steam),
        INDEX idx_active (is_active),
        INDEX idx_appeal (appeal_status),
        INDEX idx_created (created_at),
        INDEX idx_community (community_status)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_admin_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        admin_steam VARCHAR(100),
        admin_name VARCHAR(100),
        admin_group VARCHAR(50),
        action VARCHAR(100),
        target_steam VARCHAR(100),
        target_name VARCHAR(100),
        details TEXT,
        severity VARCHAR(20) DEFAULT 'medium',
        ip_address VARCHAR(45),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_admin (admin_steam),
        INDEX idx_action (action),
        INDEX idx_target (target_steam),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_alerts (
        id INT AUTO_INCREMENT PRIMARY KEY,
        alert_type VARCHAR(50),
        severity VARCHAR(20),
        title VARCHAR(255),
        message TEXT,
        player_steam VARCHAR(100),
        player_name VARCHAR(100),
        metadata TEXT,
        acknowledged TINYINT DEFAULT 0,
        acknowledged_by VARCHAR(100),
        acknowledged_at DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_type (alert_type),
        INDEX idx_severity (severity),
        INDEX idx_ack (acknowledged),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_chat_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        player_name VARCHAR(100),
        message TEXT,
        is_command TINYINT DEFAULT 0,
        channel VARCHAR(50) DEFAULT 'global',
        flagged TINYINT DEFAULT 0,
        flag_reason VARCHAR(255),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_command (is_command),
        INDEX idx_flagged (flagged),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_resource_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        resource_name VARCHAR(100),
        action VARCHAR(20),
        category VARCHAR(50),
        triggered_by VARCHAR(100),
        details VARCHAR(500),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_resource (resource_name),
        INDEX idx_action (action),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_server_metrics (
        id INT AUTO_INCREMENT PRIMARY KEY,
        player_count INT DEFAULT 0,
        max_players INT DEFAULT 0,
        total_money DECIMAL(20,2) DEFAULT 0,
        total_gold DECIMAL(20,2) DEFAULT 0,
        total_items INT DEFAULT 0,
        resource_count INT DEFAULT 0,
        uptime_seconds INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_daily_summary (
        id INT AUTO_INCREMENT PRIMARY KEY,
        summary_date DATE UNIQUE,
        peak_players INT DEFAULT 0,
        unique_players INT DEFAULT 0,
        total_sessions INT DEFAULT 0,
        total_playtime_hours DECIMAL(10,2) DEFAULT 0,
        total_money_earned DECIMAL(20,2) DEFAULT 0,
        total_money_spent DECIMAL(20,2) DEFAULT 0,
        total_gold_earned DECIMAL(20,2) DEFAULT 0,
        total_gold_spent DECIMAL(20,2) DEFAULT 0,
        items_created INT DEFAULT 0,
        items_removed INT DEFAULT 0,
        detections_count INT DEFAULT 0,
        bans_issued INT DEFAULT 0,
        kicks_issued INT DEFAULT 0,
        alerts_count INT DEFAULT 0,
        chat_messages INT DEFAULT 0,
        commands_used INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_date (summary_date)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_player_positions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        x FLOAT,
        y FLOAT,
        z FLOAT,
        heading FLOAT,
        speed FLOAT DEFAULT 0,
        health INT DEFAULT 0,
        nearby_players TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_death_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        victim_steam VARCHAR(100),
        victim_name VARCHAR(100),
        killer_steam VARCHAR(100),
        killer_name VARCHAR(100),
        weapon_hash BIGINT,
        weapon_name VARCHAR(100),
        distance FLOAT,
        victim_x FLOAT,
        victim_y FLOAT,
        victim_z FLOAT,
        is_pvp TINYINT DEFAULT 0,
        zone VARCHAR(64) NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_victim (victim_steam),
        INDEX idx_killer (killer_steam),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_resources (
        id INT AUTO_INCREMENT PRIMARY KEY,
        resource_name VARCHAR(100) UNIQUE,
        category VARCHAR(50),
        author VARCHAR(100),
        version VARCHAR(50),
        description VARCHAR(500),
        status VARCHAR(20) DEFAULT 'started',
        first_seen DATETIME DEFAULT CURRENT_TIMESTAMP,
        last_seen DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_category (category),
        INDEX idx_status (status)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_whitelist (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100) UNIQUE,
        discord VARCHAR(100),
        player_name VARCHAR(100),
        added_by VARCHAR(100),
        added_by_name VARCHAR(100),
        status VARCHAR(20) DEFAULT 'active',
        reason VARCHAR(500),
        last_login DATETIME NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_status (status)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_custom_teleports (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        category VARCHAR(50) DEFAULT 'Custom',
        x FLOAT,
        y FLOAT,
        z FLOAT,
        created_by VARCHAR(100),
        is_active TINYINT DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_active (is_active)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_reports (
        id INT AUTO_INCREMENT PRIMARY KEY,
        reporter_steam VARCHAR(100),
        reporter_name VARCHAR(100),
        report_type VARCHAR(30) DEFAULT 'other',
        priority VARCHAR(20) DEFAULT 'medium',
        title VARCHAR(255),
        description TEXT,
        target_steam VARCHAR(100),
        target_name VARCHAR(100),
        status VARCHAR(20) DEFAULT 'open',
        claimed_by VARCHAR(100),
        claimed_by_name VARCHAR(100),
        claimed_at DATETIME,
        resolved_by VARCHAR(100),
        resolved_by_name VARCHAR(100),
        resolved_at DATETIME,
        resolution TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_status (status),
        INDEX idx_reporter (reporter_steam),
        INDEX idx_type (report_type),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_report_messages (
        id INT AUTO_INCREMENT PRIMARY KEY,
        report_id INT,
        sender_steam VARCHAR(100),
        sender_name VARCHAR(100),
        sender_role VARCHAR(20) DEFAULT 'player',
        message TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_report (report_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_admin_chat (
        id INT AUTO_INCREMENT PRIMARY KEY,
        sender_steam VARCHAR(100),
        sender_name VARCHAR(100),
        sender_group VARCHAR(50),
        message VARCHAR(500),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_web_tokens (
        id INT AUTO_INCREMENT PRIMARY KEY,
        token VARCHAR(128) UNIQUE,
        steam VARCHAR(100),
        admin_name VARCHAR(100),
        admin_group VARCHAR(50),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        expires_at DATETIME,
        last_used DATETIME NULL,
        INDEX idx_token (token),
        INDEX idx_steam (steam),
        INDEX idx_expires (expires_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_warnings (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        player_name VARCHAR(100),
        warned_by VARCHAR(100),
        warned_by_name VARCHAR(100),
        reason VARCHAR(500),
        severity VARCHAR(20) DEFAULT 'medium',
        is_active TINYINT DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_active (is_active),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_blips (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        blip_hash BIGINT DEFAULT 0,
        x FLOAT,
        y FLOAT,
        z FLOAT,
        scale FLOAT DEFAULT 0.2,
        color INT DEFAULT 0,
        is_active TINYINT DEFAULT 1,
        visible_to VARCHAR(50) NULL DEFAULT NULL,
        created_by VARCHAR(100),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_active (is_active)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_admin_roles (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100) UNIQUE,
        player_name VARCHAR(100),
        admin_group VARCHAR(50) DEFAULT 'helper',
        discord VARCHAR(100),
        assigned_by VARCHAR(100),
        resolved_reports INT DEFAULT 0,
        play_time INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_group (admin_group)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_screening (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        discord VARCHAR(100),
        trust_score INT DEFAULT 100,
        flags TEXT,
        steam_profile_name VARCHAR(200),
        steam_created INT,
        steam_visibility INT,
        vac_bans INT DEFAULT 0,
        game_bans INT DEFAULT 0,
        community_ban TINYINT DEFAULT 0,
        days_since_last_ban INT,
        alt_matches TEXT,
        previous_bans_here INT DEFAULT 0,
        action_taken VARCHAR(50),
        cached_until DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_score (trust_score),
        INDEX idx_created (created_at),
        INDEX idx_cached (cached_until)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_item_watchlist (
        id INT AUTO_INCREMENT PRIMARY KEY,
        item_name VARCHAR(100),
        item_label VARCHAR(200),
        alert_type VARCHAR(30) DEFAULT 'server_total',
        threshold INT DEFAULT 100,
        time_window_hours INT DEFAULT 24,
        per_player TINYINT DEFAULT 0,
        target_players TEXT NULL,
        notes TEXT NULL,
        enabled TINYINT DEFAULT 1,
        created_by VARCHAR(100),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        last_triggered DATETIME,
        trigger_count INT DEFAULT 0,
        INDEX idx_item (item_name),
        INDEX idx_enabled (enabled)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_item_transfers (
        id INT AUTO_INCREMENT PRIMARY KEY,
        from_steam VARCHAR(100),
        from_name VARCHAR(100),
        to_steam VARCHAR(100),
        to_name VARCHAR(100),
        item_name VARCHAR(100),
        item_label VARCHAR(200),
        quantity INT DEFAULT 1,
        source_resource VARCHAR(100),
        flagged TINYINT DEFAULT 0,
        flag_reason VARCHAR(255),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_from (from_steam),
        INDEX idx_to (to_steam),
        INDEX idx_item (item_name),
        INDEX idx_flagged (flagged),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_proximity_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam_a VARCHAR(100),
        name_a VARCHAR(100),
        steam_b VARCHAR(100),
        name_b VARCHAR(100),
        duration_seconds INT DEFAULT 0,
        loc_x FLOAT,
        loc_y FLOAT,
        loc_z FLOAT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_a (steam_a),
        INDEX idx_b (steam_b),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_money_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(64) NOT NULL,
        char_name VARCHAR(128),
        action VARCHAR(16) NOT NULL,
        amount DECIMAL(12,2) NOT NULL,
        balance_after DECIMAL(12,2),
        source VARCHAR(64),
        target_steam VARCHAR(64),
        target_name VARCHAR(128),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_steam (steam),
        INDEX idx_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_pending_actions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100) NOT NULL,
        player_name VARCHAR(100),
        action_type VARCHAR(50) NOT NULL,
        action_data TEXT,
        queued_by VARCHAR(100),
        queued_by_name VARCHAR(100),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        executed_at DATETIME NULL,
        status VARCHAR(20) DEFAULT 'pending',
        INDEX idx_steam (steam),
        INDEX idx_status (status)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_script_actions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        steam VARCHAR(100),
        resource_name VARCHAR(100),
        event_name VARCHAR(200),
        count INT DEFAULT 0,
        window_start DATETIME,
        window_end DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_sa_steam (steam),
        INDEX idx_sa_resource (resource_name),
        INDEX idx_sa_created (created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_runtime_settings (
        id INT AUTO_INCREMENT PRIMARY KEY,
        setting_key VARCHAR(100) UNIQUE NOT NULL,
        setting_value TEXT,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX idx_key (setting_key)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Performance Indexes
CREATE INDEX IF NOT EXISTS idx_ban_tokens_prefix ON mguard_bans(tokens(100));
CREATE INDEX IF NOT EXISTS idx_item_dupe_check    ON mguard_item_log(steam, item_name, action, created_at);
CREATE INDEX IF NOT EXISTS idx_player_risk        ON mguard_players(risk_score);

-- Additional tables (auto-created at startup by the resource if not present)
CREATE TABLE IF NOT EXISTS mguard_player_notes (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    steam         VARCHAR(100) NOT NULL,
    player_name   VARCHAR(100),
    note_text     TEXT NOT NULL,
    added_by      VARCHAR(100),
    added_by_name VARCHAR(100),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_steam (steam)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_community_sync (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    steam       VARCHAR(100),
    license     VARCHAR(100),
    status      VARCHAR(20) NOT NULL DEFAULT 'pending',
    player_name VARCHAR(100),
    reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_cs_steam   (steam),
    INDEX idx_cs_license (license),
    INDEX idx_cs_status  (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mguard_script_events (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    steam         VARCHAR(64)  NOT NULL,
    player_name   VARCHAR(128),
    resource_name VARCHAR(128),
    event_name    VARCHAR(256),
    detail        TEXT,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_se_steam   (steam),
    INDEX idx_se_created (created_at),
    INDEX idx_se_res     (resource_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS mguard_connections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    steam VARCHAR(100) NOT NULL,
    player_name VARCHAR(100),
    ip VARCHAR(45),
    connected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    disconnected_at DATETIME NULL,
    duration_seconds INT NULL,
    leave_reason VARCHAR(255) NULL,
    INDEX idx_steam (steam),
    INDEX idx_connected (connected_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;SET FOREIGN_KEY_CHECKS = 1;

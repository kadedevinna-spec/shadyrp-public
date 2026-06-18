-- MX-Ranch — schema (also created automatically when the resource starts)

CREATE TABLE IF NOT EXISTS ranches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    owner VARCHAR(128) NULL,
    job VARCHAR(64) NOT NULL DEFAULT 'rancher',
    npc_position TEXT NOT NULL,
    ranch_position TEXT NOT NULL,
    radius FLOAT NOT NULL DEFAULT 100,
    price INT NOT NULL DEFAULT 0,
    balance BIGINT NOT NULL DEFAULT 0,
    is_owned TINYINT(1) NOT NULL DEFAULT 0,
    created_by VARCHAR(128) NULL,
    created_at INT UNSIGNED NOT NULL,
    wander_radius FLOAT NULL,
    webhook_url VARCHAR(500) NOT NULL DEFAULT '',
    UNIQUE KEY uq_ranches_name (name),
    INDEX idx_ranches_owner (owner),
    INDEX idx_ranches_owned (is_owned)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS ranch_animals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ranch_id INT NOT NULL,
    type VARCHAR(32) NOT NULL,
    weight FLOAT NOT NULL DEFAULT 0,
    health FLOAT NOT NULL DEFAULT 100,
    hunger FLOAT NOT NULL DEFAULT 100,
    thirst FLOAT NOT NULL DEFAULT 100,
    growth FLOAT NOT NULL DEFAULT 0,
    experience FLOAT NOT NULL DEFAULT 0,
    last_walk_ms BIGINT UNSIGNED NOT NULL DEFAULT 0,
    position TEXT NOT NULL,
    home_position TEXT NULL,
    is_sick TINYINT(1) NOT NULL DEFAULT 0,
    last_product_time INT UNSIGNED NOT NULL DEFAULT 0,
    outfit_preset SMALLINT UNSIGNED NULL,
    comfort FLOAT NOT NULL DEFAULT 75,
    last_care_ms BIGINT UNSIGNED NOT NULL DEFAULT 0,
    wander_radius FLOAT NULL,
    INDEX idx_animals_ranch (ranch_id),
    CONSTRAINT fk_animals_ranch FOREIGN KEY (ranch_id) REFERENCES ranches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS ranch_structures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ranch_id INT NOT NULL,
    type VARCHAR(32) NOT NULL,
    animal_type VARCHAR(32) NULL,
    food_level FLOAT NOT NULL DEFAULT 0,
    water_level FLOAT NOT NULL DEFAULT 0,
    position TEXT NOT NULL,
    INDEX idx_struct_ranch (ranch_id),
    CONSTRAINT fk_struct_ranch FOREIGN KEY (ranch_id) REFERENCES ranches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS ranch_workers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ranch_id INT NOT NULL,
    identifier VARCHAR(128) NOT NULL,
    worker_name VARCHAR(128) NULL,
    role_level INT NOT NULL DEFAULT 1,
    UNIQUE KEY uq_worker_ranch (ranch_id, identifier),
    INDEX idx_workers_ranch (ranch_id),
    CONSTRAINT fk_workers_ranch FOREIGN KEY (ranch_id) REFERENCES ranches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS ranch_droppings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ranch_id INT NOT NULL,
    position TEXT NOT NULL,
    created_at INT UNSIGNED NOT NULL,
    INDEX idx_drop_ranch (ranch_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

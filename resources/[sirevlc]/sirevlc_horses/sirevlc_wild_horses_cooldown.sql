CREATE TABLE IF NOT EXISTS sirevlc_wild_horses_cooldown (
    identifier VARCHAR(60) NOT NULL,
    charid INT NOT NULL,
    cooldown INT NOT NULL DEFAULT 0,
    timestamp DATETIME NOT NULL,
    PRIMARY KEY (identifier, charid));
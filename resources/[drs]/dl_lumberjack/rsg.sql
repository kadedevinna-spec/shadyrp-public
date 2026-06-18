ALTER TABLE players ADD lumberxp varchar(255) NOT NULL DEFAULT("0.00");

CREATE TABLE dl_lumberjack (
	  id int NOT NULL AUTO_INCREMENT,
    treemodel varchar(255),
    plantedTime varchar(255),
    timeToGrowth varchar(255),
    coords varchar(255),
    PRIMARY KEY(id)
);

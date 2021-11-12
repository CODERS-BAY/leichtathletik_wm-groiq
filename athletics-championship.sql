DROP DATABASE IF EXISTS athletics_championship;
CREATE DATABASE athletics_championship;
USE athletics_championship;

CREATE TABLE nation
(
    nid   INT PRIMARY KEY AUTO_INCREMENT,
    nname VARCHAR(32) NOT NULL
);
CREATE TABLE city
(
    cid   INT PRIMARY KEY AUTO_INCREMENT,
    nid   INT         NOT NULL,
    cname VARCHAR(32) NOT NULL,
    FOREIGN KEY (nid)
        REFERENCES nation (nid)
);
CREATE TABLE location
(
    lid     INT PRIMARY KEY AUTO_INCREMENT,
    cid     INT         NOT NULL,
    address VARCHAR(64) NOT NULL,
    FOREIGN KEY (cid)
        REFERENCES city (cid)
);

CREATE TABLE discipline
(
    did   INT PRIMARY KEY AUTO_INCREMENT,
    dname VARCHAR(32) NOT NULL
);

CREATE TABLE helper
(
    hid        INT PRIMARY KEY AUTO_INCREMENT,
    hname      VARCHAR(64) NOT NULL,
    is_referee BOOLEAN     NOT NULL
);

CREATE TABLE eventx
(
    eid        INT PRIMARY KEY AUTO_INCREMENT,
    referee    INT COMMENT 'referee (may be decided later)',
    did        INT       NOT NULL,
    lid        INT COMMENT 'location (may be decided later)',
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'may be decided later',
    FOREIGN KEY (referee)
        REFERENCES helper (hid),
    FOREIGN KEY (did)
        REFERENCES discipline (did),
    FOREIGN KEY (lid)
        REFERENCES location (lid)
);

CREATE TABLE stewardship
(
    eid              INT,
    hid              INT,
    steward_position VARCHAR(64) NOT NULL,
    FOREIGN KEY (eid) REFERENCES eventx (eid),
    FOREIGN KEY (hid) REFERENCES helper (hid),
    PRIMARY KEY (hid, eid)
);

-- backlog: checks for handling referees and stewards

CREATE TABLE athlete
(
    aid   INT PRIMARY KEY AUTO_INCREMENT,
    aname VARCHAR(64) NOT NULL,
    nid   INT         NOT NULL,
    FOREIGN KEY (nid)
        REFERENCES nation (nid)
);

CREATE TABLE participation
(
    eid        INT,
    aid        INT,
    bib_number INT NOT NULL COMMENT 'supposing bib number is decided at registration',
    UNIQUE (eid, aid),
    UNIQUE (eid, bib_number),
    FOREIGN KEY (eid)
        REFERENCES eventx (eid),
    FOREIGN KEY (aid)
        REFERENCES athlete (aid),
    PRIMARY KEY (eid, aid)
);

CREATE TABLE result
(
    eid     INT,
    aid     INT,
    score   DECIMAL(8, 2) NOT NULL,
    ranking INT COMMENT 'nullable because only decided at end of event',
    FOREIGN KEY (eid, aid)
        REFERENCES participation (eid, aid),
    PRIMARY KEY (eid, aid)
);




drop database if exists athletics_championship;
create database athletics_championship;
use athletics_championship;

CREATE TABLE nation (
    nid INT PRIMARY KEY AUTO_INCREMENT,
    nname VARCHAR(32)
);
CREATE TABLE city (
    cid INT PRIMARY KEY AUTO_INCREMENT,
    nid INT,
    cname VARCHAR(32),
    FOREIGN KEY (nid)
        REFERENCES nation (nid)
);
CREATE TABLE location (
    lid INT PRIMARY KEY AUTO_INCREMENT,
    cid INT,
    address VARCHAR(64),
    FOREIGN KEY (cid)
        REFERENCES city (cid)
);

CREATE TABLE discipline (
    did INT PRIMARY KEY AUTO_INCREMENT,
    dname VARCHAR(32)
);

CREATE TABLE helper (
    hid INT PRIMARY KEY AUTO_INCREMENT,
    hname VARCHAR(64),
    is_referee BOOLEAN
);

CREATE TABLE sports_event (
    eid INT PRIMARY KEY AUTO_INCREMENT,
    referee INT,
    did INT,
    lid INT,
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (referee)
        REFERENCES helper (hid),
    FOREIGN KEY (did)
        REFERENCES discipline (did),
    FOREIGN KEY (lid)
        REFERENCES location (lid)
);

create table stewardship (
	eid int,
    hid int,
    steward_position varchar(64),
    foreign key (eid) references sports_event (eid),
    foreign key (hid) references helper (hid),
    primary key (hid, eid)
);

-- backlog: checks for handling referees and stewards

CREATE TABLE athlete (
    aid INT PRIMARY KEY AUTO_INCREMENT,
    aname VARCHAR(64),
    nid INT,
    FOREIGN KEY (nid)
        REFERENCES nation (nid)
);

CREATE TABLE participation (
    eid INT,
    aid INT,
    bib_number INT,
    UNIQUE (eid , aid),
    UNIQUE (eid , bib_number),
    FOREIGN KEY (eid)
        REFERENCES sports_event (eid),
    FOREIGN KEY (aid)
        REFERENCES athlete (aid),
    PRIMARY KEY (eid , aid)
);

CREATE TABLE result (
    eid INT,
    aid INT,
    score DECIMAL(8 , 2 ),
    place INT,
    FOREIGN KEY (eid , aid)
        REFERENCES participation (eid , aid),
    PRIMARY KEY (eid , aid)
);



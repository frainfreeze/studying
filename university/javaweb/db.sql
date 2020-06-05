DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS purchase;
DROP TABLE IF EXISTS access_log;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  pwd TEXT NOT NULL,
  full_name TEXT,
  user_address TEXT,
  postcode TEXT,
  city TEXT,
  phone TEXT
);

CREATE TABLE purchase (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  item TEXT NOT NULL,
  purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  purchase_type TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE access_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ip TEXT,
  txt TEXT,
  FOREIGN KEY (user_id) REFERENCES user (id)
);

insert into user (email,pwd,full_name,user_address,postcode,city,phone) values ('None','None','None','None','None','None','None');
insert into user (email,pwd,full_name,user_address,postcode,city,phone) values ('tom@tom.com','tomtoms','','','','','');
insert into purchase (user_id, item, purchase_type) values (1,'palacinka','pouzece');
insert into access_log (user_id, ip, txt) values (1, '198.168.8.1', 'test log');
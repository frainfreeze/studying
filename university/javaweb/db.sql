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
  purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id INTEGER NOT NULL,
  purchase_type TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE item (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  purchase_id INTEGER NOT NULL,
  item TEXT NOT NULL,
  amount TEXT NOT NULL,
  total TEXT NOT NULL,
  FOREIGN KEY (purchase_id) REFERENCES purchase (id)
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
insert into purchase (user_id, purchase_type) values (2,'pouzece');
insert into item (purchase_id, item, amount, total) values (1,"Palacinka","10", "19");
insert into item (purchase_id, item, amount, total) values (1,"Tortilja","9", "11");
insert into item (purchase_id, item, amount, total) values (1,"Eura","300000000", "152");
insert into access_log (user_id, ip, txt) values (1, '198.168.8.1', 'test log');

.print All purchases:
select u.email, p.purchase_date, p.purchase_type, i.item, i.amount from purchase as p 
    inner join item as i 
        on i.purchase_id = p.id
    inner join user as u
        on p.user_id = u.id;

.print \nAll orders for user tom@tom.com:
select u.email, p.purchase_date, p.purchase_type, sum(i.total) from purchase as p 
    inner join item as i 
        on i.purchase_id = p.id
    inner join user as u
        on p.user_id = u.id
    where u.email = "tom@tom.com";
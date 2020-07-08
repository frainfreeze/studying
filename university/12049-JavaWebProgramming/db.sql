DROP TABLE IF EXISTS access_log CASCADE;
DROP TABLE IF EXISTS usr CASCADE;
DROP TABLE IF EXISTS item CASCADE;
DROP TABLE IF EXISTS purchase CASCADE;

CREATE TABLE usr (
                     id serial primary key,
                     email TEXT UNIQUE NOT NULL,
                     pwd TEXT NOT NULL,
                     full_name TEXT,
                     user_address TEXT,
                     postcode TEXT,
                     city TEXT,
                     phone TEXT
);

CREATE TABLE purchase (
                          id serial primary key,
                          purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          user_id INTEGER NOT NULL,
                          purchase_type TEXT NOT NULL,
                          FOREIGN KEY (user_id) REFERENCES usr (id)
);

CREATE TABLE item (
                      id serial primary key,
                      purchase_id INTEGER NOT NULL,
                      item TEXT NOT NULL,
                      amount TEXT NOT NULL,
                      total TEXT NOT NULL,
                      FOREIGN KEY (purchase_id) REFERENCES purchase (id)
);

CREATE TABLE access_log (
                            id serial primary key,
                            user_id INTEGER NOT NULL,
                            created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            ip TEXT,
                            txt TEXT,
                            FOREIGN KEY (user_id) REFERENCES usr (id)
);

insert into usr (email,pwd,full_name,user_address,postcode,city,phone) values ('None','None','None','None','None','None','None');
insert into usr (email,pwd,full_name,user_address,postcode,city,phone) values ('tom@tom.com','tomtoms','','','','','');
insert into purchase (user_id, purchase_type) values (2,'pouzece');
insert into item (purchase_id, item, amount, total) values (1,'Palacinka','10', '19');
insert into item (purchase_id, item, amount, total) values (1,'Tortilja','9', '11');
insert into item (purchase_id, item, amount, total) values (1,'Eura','300000000', '152');
insert into access_log (user_id, ip, txt) values (1, '198.168.8.1', 'test log');

--select u.email, p.purchase_date, p.purchase_type, i.item, i.amount from purchase as p
--    inner join item as i
--        on i.purchase_id = p.id
--    inner join usr as u
--        on p.user_id = u.id;
--
--select u.email, p.purchase_date, p.purchase_type, sum(i.total) from purchase as p
--    inner join item as i
--        on i.purchase_id = p.id
--    inner join usr as u
--        on p.user_id = u.id
--    where u.email = "tom@tom.com";
--
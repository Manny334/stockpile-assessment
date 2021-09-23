
CREATE DATABASE wordpress;

CREATE USER wordpress@localhost IDENTIFIED BY 'my1234';

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
    -> ON wordpress.*
    -> TO wordpress@localhost;


FLUSH PRIVILEGES;


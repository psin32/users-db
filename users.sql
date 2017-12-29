# In production you would almost certainly limit the replication user must be on the follower (slave) machine,
# to prevent other clients accessing the log from other machines. For example, 'replicator'@'follower.acme.com'.
#
# However, this grant is equivalent to specifying *any* hosts, which makes this easier since the docker host
# is not easily known to the Docker container. But don't do this in production.
#
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator' IDENTIFIED BY 'replpass';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'prashant' IDENTIFIED BY 'abcd1234';

# Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE members;
GRANT ALL PRIVILEGES ON members.* TO 'mysqluser'@'%';

# Switch to this database
USE members;

CREATE TABLE users (
      users_id bigint(20) NOT NULL AUTO_INCREMENT,
      field1 varchar(255) DEFAULT NULL,
      field2 varchar(255) DEFAULT NULL,
      field3 varchar(255) DEFAULT NULL,
      language_id int(11) DEFAULT NULL,
      lastsession timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      profiletype varchar(255) DEFAULT NULL,
      registertype varchar(255) NOT NULL,
      registration timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      registrationupdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      username varchar(255) NOT NULL,
      PRIMARY KEY (users_id)
);

CREATE TABLE userreg (
      id bigint(20) NOT NULL AUTO_INCREMENT,
      lastpasswordresetdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      password varchar(255) NOT NULL,
      passwordexpired int(11) DEFAULT '0',
      passwordretries int(11) DEFAULT '0',
      users_id bigint(20) NOT NULL,
      PRIMARY KEY (id),
      FOREIGN KEY (users_id) REFERENCES users (users_id)
);

CREATE TABLE address (
      address_id bigint(20) NOT NULL AUTO_INCREMENT,
      address1 varchar(255) DEFAULT NULL,
      address2 varchar(255) DEFAULT NULL,
      address3 varchar(255) DEFAULT NULL,
      addresstype varchar(255) NOT NULL,
      city varchar(255) DEFAULT NULL,
      country varchar(255) DEFAULT NULL,
      email1 varchar(255) NOT NULL,
      email2 varchar(255) DEFAULT NULL,
      field1 varchar(255) DEFAULT NULL,
      field2 varchar(255) DEFAULT NULL,
      field3 varchar(255) DEFAULT NULL,
      firstname varchar(255) DEFAULT NULL,
      isprimary int(11) NOT NULL DEFAULT '0',
      lastcreate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      lastname varchar(255) DEFAULT NULL,
      phone1 varchar(255) DEFAULT NULL,
      phone2 varchar(255) DEFAULT NULL,
      selfaddress int(11) NOT NULL DEFAULT '0',
      state varchar(255) DEFAULT NULL,
      status varchar(255) NOT NULL,
      title varchar(255) DEFAULT NULL,
      zipcode varchar(255) DEFAULT NULL,
      users_id bigint(20) NOT NULL,
      PRIMARY KEY (address_id),
      FOREIGN KEY (users_id) REFERENCES users (users_id)
);
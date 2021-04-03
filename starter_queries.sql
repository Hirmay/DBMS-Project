CREATE DATABASE mwdb;

CREATE TABLE Person(
    person_id varchar(10) PRIMARY KEY,
    firstname varchar(20) NOT NULL,
    lastname varchar(20) NOT NULL,
    birthyear int,
    age int,
    gender varchar(10)
);

CREATE TABLE Production_company(
    company_name varchar(50) PRIMARY KEY,
    headquarter varchar(40)
);

CREATE TABLE ott_platform(
    platform_name varchar(20) Primary KEY
);

CREATE TABLE movie(
    movie_id varchar(10) PRIMARY KEY,
    title varchar(40) NOT NULL,
    production_cost int,
    genre varchar(10),
    rating float CHECK(rating>0 and rating <=10),
    release_date Date,
    platform varchar(20),
    director varchar(10),
    FOREIGN KEY (director) REFERENCES Person(person_id),
    FOREIGN KEY (platform) REFERENCES ott_platform(platform_name)
);

CREATE TABLE db_user(
    email varchar(50) PRIMARY KEY,
    username varchar(20) UNIQUE,
    firstname varchar(20) NOT NULL, 
    lastname varchar(20) NOT NULL
);

CREATE TABLE review(
    review_id varchar(10) PRIMARY KEY,
    posted_on Date,
    content varchar(1000),
    up_votes int,
    movie_id varchar(10),
    email varchar(10),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (email) REFERENCES db_user(email)
);

CREATE TABLE movie_produced_by(
    company_name varchar(50),
    movie_id varchar(10),
    PRIMARY KEY (company_name, movie_id),
    FOREIGN KEY (company_name) REFERENCES Production_company(company_name),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

CREATE TABLE movie_cast(
    movie_id varchar(10),
    person_id varchar(10),
    role varchar(40),
    PRIMARY KEY (movie_id, person_id, role),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE tv_show(
    show_id varchar(10) PRIMARY KEY,
    title varchar(40) NOT NULL,
    rating int CHECK(rating>0 and rating <=10),
    seasons int,
    release_year int,
    end_year int CHECK(release_year<end_year),
    genre varchar(10),
    platform varchar(20),
    FOREIGN KEY (platform) REFERENCES ott_platform(platform_name)
);

CREATE TABLE show_produced_by(
    company_name varchar(50),
    show_id varchar(10),
    PRIMARY KEY (company_name, show_id),
    FOREIGN KEY (company_name) REFERENCES Production_company(company_name),
    FOREIGN KEY (show_id) REFERENCES tv_show(show_id)
);

CREATE TABLE show_cast(
    show_id varchar(10),
    person_id varchar(10),
    role varchar(40),
    PRIMARY KEY (show_id, person_id, role),
    FOREIGN KEY (show_id) REFERENCES tv_show(show_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

-- DROP TABLE show_cast;
-- DROP TABLE show_produced_by;
-- DROP TABLE tv_show;
-- DROP TABLE movie_cast;
-- DROP TABLE movie_produced_by;
-- DROP TABLE review;
-- DROP TABLE user;
-- DROP TABLE movie;
-- DROP TABLE ott_platform;
-- DROP TABLE Production_company;
-- DROP TABLE Person;

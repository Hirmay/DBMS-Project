COPY Production_company(company_name, headquarter)
FROM 'C:\General_T\College\Fourth Sem\DBMS\Project\Internet-Movies-Data-Base\Data\production_company.csv'
DELIMITER ','
CSV HEADER;



COPY celebrity(person_id, firstname, lastname, birthyear, age, gender)
FROM 'C:\General_T\College\Fourth Sem\DBMS\Project\Internet-Movies-Data-Base\Data\celebrity.csv'
DELIMITER ','
CSV HEADER;



COPY movie(movie_id, title, production_cost, rating, rated, release_date, platform, likes, runtime, director)
FROM 'C:\General_T\College\Fourth Sem\DBMS\Project\Internet-Movies-Data-Base\Data\movie.csv'
DELIMITER ','
CSV HEADER;


COPY movie_genre(movie_id, genre)
FROM 'C:\General_T\College\Fourth Sem\DBMS\Project\Internet-Movies-Data-Base\Data\movie_genre.csv'
DELIMITER ','
CSV HEADER;


COPY movie_cast(movie_id, person_id, role)
FROM 'C:\General_T\College\Fourth Sem\DBMS\Project\Internet-Movies-Data-Base\Data\movie_cast.csv'
DELIMITER ','
CSV HEADER;


COPY movie_produced_by(company_name, movie_id)
FROM 'C:\General_T\College\Fourth Sem\DBMS\Project\Internet-Movies-Data-Base\Data\movie_produced_by.csv'
DELIMITER ','
CSV HEADER;


INSERT INTO celebrity (person_id, firstname, lastname, birthyear, gender) VALUES(501, 'Tom', 'Holland', 1990, 'Male'); 
INSERT INTO celebrity (person_id, firstname, lastname, birthyear, gender) VALUES(502, 'Robert', 'Doweny Jr.', 1980, 'Male'); 


insert into abusive_words(words) values('fuck');
insert into abusive_words(words) values('fucking');
insert into abusive_words(words) values('motherfucker');
insert into abusive_words(words) values('fucker');
insert into abusive_words(words) values('ass');
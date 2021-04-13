CREATE TABLE filtered_movies(
	movie_id varchar(10)
);

CREATE OR REPLACE PROCEDURE filter_movies(
	released_after date default '1000-01-01', 
	released_before date default CURRENT_DATE,
	gen varchar(10) default '',
 	min_rating float default 0,
	max_rating float default 10,
	plat varchar(20) default ''
)
LANGUAGE plpgsql
AS $$
DECLARE
	r_movie record;
BEGIN
	delete from filtered_movies;
	for r_movie in select distinct movie_genre.movie_id from movie_genre, movie 
	 where(
		 movie.release_date >= released_after 
		 and movie.release_date<= released_before 
		 and movie_genre.movie_id = movie.movie_id 
		 and (movie_genre.genre = gen or gen ='') 
		 and movie.rating >= min_rating 
		 and movie.rating <= max_rating 
		 and (contains(movie.platform,plat) or plat = '')
	  ) loop
	  insert into filtered_movies(movie_id) VALUES (r_movie.movie_id);
	end loop;
END $$;

CALL filter_movies('1000-01-01', CURRENT_DATE, 'Crime', 0, 10, '');
select * from filtered_movies;
------------------------------------------------------

CREATE OR REPLACE PROCEDURE search_movie(dob DATE, movie_title varchar(100))
LANGUAGE plpgsql
AS $$
DECLARE
	r_movie record;
	cnt int;
	len int := LENGTH(movie_title);
	movie_len int;
begin
  if is_adult(dob) then 
	for r_movie in select * from movie loop
		if contains(r_movie.title,movie_title) then 
			raise notice '%', r_movie.title;
		end if;
	end loop;
  else
	for r_movie in select * from movie where (movie.rated = 'PG-13') loop
		if contains(r_movie.title,movie_title) then 
			raise notice '%', r_movie.title;
		end if;
	end loop;
  end if;
end 
$$;

CALL search_movie('2000-11-11','Lord');

------------------------------------------------------------

CREATE OR REPLACE PROCEDURE search_celeb(celeb_name varchar(100))
LANGUAGE plpgsql
AS $$
DECLARE
	compare varchar(100);
	r_celeb record;
	len int := LENGTH(celeb_name);
	compLen int;
	cnt int;
begin
	for r_celeb in select * from celebrity loop
	  compare := CONCAT(r_celeb.firstname,' ', r_celeb.lastname);
	  if contains(compare,celeb_name) then 
		raise notice '%', compare;
	  end if;
	end loop;
end $$;

CALL search_celeb('Tim');

---------------------------------------------------
CREATE OR REPLACE PROCEDURE celeb_movies(celeb_id varchar(100), dob DATE)
LANGUAGE plpgsql
AS $$
DECLARE
	r_movie record;
begin
	for r_movie in select * from movie, movie_cast where 
	(movie.movie_id = movie_cast.movie_id and movie_cast.person_id = celeb_id) loop
	  if r_movie.rated = 'R' then 
		if is_adult(dob) then 
		  raise notice '%', r_movie.title;
		end if;
	  else 
	  	raise notice '%', r_movie.title;
	  end if;
	end loop;
end $$;

CALL celeb_movies('2','2000-11-11');

-----------------display movie reviews ----------------------------------
CREATE OR REPLACE PROCEDURE display_movie_reviews(movie_ID varchar(10))
LANGUAGE plpgsql
AS $$
DECLARE
	r_movie record;
begin
	for r_movie in select * from movie_review where movie_ID = movie_id loop
	  -- display
	end loop;
end $$;

-------------------display movie details-------------------------------------

CREATE OR REPLACE PROCEDURE display_movie_details(movie_ID varchar(10))
LANGUAGE plpgsql
AS $$
DECLARE
	r_movie record;
begin
	for r_movie in select * from movie where movie_ID = movie_id loop
	  --display everything
	  if CURRENT_DATE < r_movie.release_date then
		EXECUTE PROCEDURE display_movie_review(movie_ID);
	  end if; 
	end loop;
end $$;

-----------------add to wishlist--------------

CREATE OR REPLACE PROCEDURE add_to_wishlist(username varchar(20), movie_ID varchar(10))
LANGUAGE plpgsql
AS $$
DECLARE
begin
	insert into wishlist (username, movie_ID);
end $$;


-----------------display wishlist ------------------------------------

CREATE OR REPLACE PROCEDURE display_wishlist(userName varchar(20))
LANGUAGE plpgsql
AS $$
DECLARE
	r_wishlist record;
begin
	for r_wishlist in select * from wishlist where wishlist.username = userName loop
		-- display using r_wishlist.movie_id
	end loop;
end $$;

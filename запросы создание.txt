create table if not exists genre (
	id serial primary key,
	name varchar(60) not null unique
);

create table if not exists artist (
	id serial primary key,
	name varchar(60) not null
);


create table if not exists artist_genre(
	id serial primary key,
	genre_id integer not null references genre(id),
	artist_id integer not null references artist(id)
);

create table if not exists album (
	id serial primary key,
	name varchar(60) not null,
	releaseDate date not null
);

create table artist_album (
    primary key(album_id, artist_id),
    album_id integer references Album(id) not null,
    artist_id integer references Artist(id) not null
);

create table if not exists track (
	id serial primary key,
	name varchar(60) not null,
	trackLength numeric(3,2) not null,
	album_id integer references album(id) 
);

create table if not exists collections(
	id serial primary key,
	name varchar(60) not null,
	release_year date  not null
);

create table track_collection (
    primary key(track_id, collections_id),
    track_id integer references track(id) not null,
    collections_id integer references collections(id) not null
);
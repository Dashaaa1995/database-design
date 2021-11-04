--название и год выхода альбомов, вышедших в 2018 году
SELECT  name, releasedate FROM album
WHERE releasedate BETWEEN '2018-01-01' AND '2018-12-31';

--название и продолжительность самого длительного трека;
SELECT name, tracklength FROM track
 WHERE tracklength = (SELECT MAX(tracklength) FROM track);

--название треков, продолжительность которых не менее 3,5 минуты
SELECT  name FROM track
WHERE tracklength >= 3.50;

--названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name FROM collections
WHERE release_year BETWEEN '2018-01-01' AND '2020-12-31';

--исполнители, чье имя состоит из 1 слова;
SELECT name FROM artist
WHERE name NOT LIKE '%% %%';

--название треков, которые содержат слово "мой"/"my".
SELECT name FROM track
WHERE name LIKE '%%my%%';
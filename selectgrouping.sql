--1. количество исполнителей в каждом жанре:
SELECT g.name, COUNT(a.name)
FROM genre AS g
LEFT JOIN artist_genre AS gm ON g.id = gm.genre_id
LEFT JOIN artist AS a ON gm.artist_id = a.id
GROUP BY g.name
ORDER BY  COUNT(a.name) DESC


--2. количество треков, вошедших в альбомы 2019-2020 годов:
SELECT t.name, a.releasedate
FROM album AS a
LEFT JOIN track AS t ON t.album_id = a.id
WHERE (a.releasedate >= '2019-01-01') AND (a.releasedate <= '2020-12-31')


--3. средняя продолжительность треков по каждому альбому:
SELECT a.name, AVG(t.tracklength)
FROM album AS a
LEFT JOIN track AS t ON t.album_id = a.id
GROUP BY a.name
ORDER BY AVG(t.tracklength)



--4. все исполнители, которые не выпустили альбомы в 2020 году:

SELECT distinct art.name
FROM artist AS art
WHERE art.name NOT IN (
    SELECT distinct art.name
    FROM artist as art
   LEFT JOIN artist_album AS alb ON art.id = alb.artist_id
   LEFT JOIN album AS a on a.id = alb.album_id
    WHERE a.releasedate >='2020-01-01' AND  a.releasedate<='2020-12-31'
	GROUP BY art.name
)
order by art.name



--5. названия сборников, в которых присутствует конкретный исполнитель (Киркоров):
SELECT DISTINCT c.name
FROM collections AS c
LEFT JOIN track_collection AS ct ON c.id = ct.collections_id
LEFT JOIN track AS t ON t.id = ct.track_id
LEFT JOIN album AS alb ON alb.id = t.album_id
LEFT JOIN artist_album AS ara ON ara.album_id = alb.id
LEFT JOIN artist AS a on a.id = ara.artist_id
WHERE a.name like '%%Киркоров%%'
ORDER BY c.name



--6. название альбомов, в которых присутствуют исполнители более 1 жанра:

SELECT a.name
FROM album AS a
LEFT JOIN artist_album AS ara ON a.id = ara.album_id
LEFT JOIN artist AS art ON art.id = ara.artist_id
LEFT JOIN artist_genre AS ag ON art.id = ag.artist_id
LEFT JOIN genre AS g ON g.id = ag.genre_id
GROUP BY a.name
HAVING COUNT(distinct g.name) > 1
ORDER  BY a.name


--7. наименование треков, которые не входят в сборники:

SELECT t.name
FROM track AS t
LEFT JOIN track_collection AS ct on t.id = ct.track_id
WHERE ct.track_id is null




--8. исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько):

SELECT art.name, t.tracklength
FROM track AS t
LEFT JOIN album AS a ON a.id = t.album_id
LEFT JOIN  artist_album AS  ara ON ara.album_id = a.id
LEFT JOIN artist AS art ON art.id = ara.artist_id
GROUP BY art.name, t.tracklength
HAVING t.tracklength = (SELECT min(tracklength) FROM track)
ORDER BY art.name

SELECT art.name, t.tracklength
FROM track AS t
LEFT JOIN album AS a ON a.id = t.album_id
LEFT JOIN  artist_album AS  ara ON ara.album_id = a.id
LEFT JOIN artist AS art ON art.id = ara.artist_id
GROUP BY art.name, t.tracklength
HAVING t.tracklength = (SELECT max(tracklength) FROM track)
ORDER BY art.name


--9. название альбомов, содержащих наименьшее количество треков:

SELECT distinct a.name
FROM album AS a
LEFT JOIN track AS t on t.album_id = a.id
WHERE t.album_id IN (
    SELECT album_id
    FROM track
     GROUP BY album_id
    HAVING count(id) = (
        SELECT count(id)
        FROM track
             GROUP BY album_id
        LIMIT 1
    )
)
ORDER BY a.name
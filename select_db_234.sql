/*название и год выхода альбомов, вышедших в 2018 году;*/
SELECT name, year_of  FROM album
where year_of = 2018;

/*название и продолжительность самого длительного трека;*/
SELECT name, duration FROM songs
order by duration desc 
limit 1;

/*название треков, продолжительность которых не менее 3,5 минуты;*/
SELECT name  FROM songs
where duration >= 3.5*60;

/*названия сборников, вышедших в период с 2018 по 2020 год включительно;*/
SELECT name, year_of  FROM collection
where year_of BETWEEN 2018 and 2021;

/*исполнители, чье имя состоит из 1 слова;*/
SELECT name  FROM bands
where name not like '% %';

/*название треков, которые содержат слово "мой"/"my".*/
SELECT name FROM songs
WHERE LOWER(name) like '%my%' or LOWER(name) like '%мой%';

/*количество исполнителей в каждом жанре;*/
SELECT g.name, COUNT(band_id) FROM genreband gb
LEFT JOIN genre g ON gb.genre_id = g.id
GROUP BY g.name;

/*количество треков, вошедших в альбомы 2019-2020 годов;*/
SELECT COUNT(s.id) FROM songs s
LEFT JOIN album a ON s.album_id = a.id
where a.year_of between 2019 and 2020;

/*средняя продолжительность треков по каждому альбому;*/
SELECT a.name, avg(s.duration) FROM songs s
LEFT JOIN album a ON s.album_id = a.id
group by a.id;

/*все исполнители, которые не выпустили альбомы в 2020 году;*/
select name from bands b2 
except
select b.name from bandalbum ba
join album a on a.id = ba.album_id
join bands b on b.id = ba.band_id 
where a.year_of = 2020

/*названия сборников, в которых присутствует конкретный исполнитель (выберите сами);*/
SELECT distinct coll.name FROM collection coll 
JOIN songcollection sc ON sc.collection_id  = coll.id 
join songs s on s.id = sc.song_id 
join album a on a.id = s.album_id 
join bandalbum ba on ba.album_id = a.id 
join bands b on b.id = ba.band_id
where b.name = 'Megadeth'

/*название альбомов, в которых присутствуют исполнители более 1 жанра;*/
select a.name, count(g.name) from album a 
join bandalbum ba on ba.album_id = a.id 
join bands b on b.id = ba.band_id 
join genreband gb on gb.band_id = b.id 
join genre g on g.id = gb.genre_id 
group by a.name 
having count(g.name) > 1

/*наименование треков, которые не входят в сборники;*/
select s.name from songs s
left join songcollection sc on sc.song_id = s.id 
where sc.collection_id is null 

/*исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);*/
SELECT s.name from songs s
where s.duration = (select MIN(duration) FROM songs);

/*название альбомов, содержащих наименьшее количество треков.*/
select a.name, count(s.id)  from album a
join songs s on s.album_id = a.id 
group by a.id 
having count(s.id) = 
	(select count(s.id)  from album a 
	join songs s on s.album_id = a.id 
	group by a.id 
	order by count(s.id)
	limit 1)


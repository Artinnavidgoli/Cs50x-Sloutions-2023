SELECT name FROM songs WHERE artist_id = (SELECT id FROM artists WHERE name = 'Post Malone');

-- SELECT songs.name FROM songs JOIN artists ON songs.artist_id = artists.id WHERE artists.name = 'Post Malone';

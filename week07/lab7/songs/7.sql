SELECT SUM(energy) / COUNT(energy) FROM songs WHERE artist_id = (SELECT id FROM artists WHERE name = 'Drake');

-- SELECT SUM(energy) / COUNT(energy) FROM songs JOIN artists ON songs.artist_id = artists.id WHERE artists.name = 'Drake';

/*
If pressed for time, though, some of the more interesting clean-ups involve these shows:

Brooklyn Nine-Nine
Game of Thrones
Grey’s Anatomy
It’s Always Sunny in Philadelphia
Parks and Recreation
The Office
*/

UPDATE shows SET title = 'Brooklyn Nine-Nine' WHERE title LIKE 'B%99' OR title LIKE 'b%99';

UPDATE shows SET title = 'Game of Thrones' WHERE title LIKE 'GoT';

UPDATE shows SET title = 'Grey''s Anatomy' WHERE title LIKE 'Grey''s%';

UPDATE shows SET title = 'It''s Always Sunny in Philadelphia' WHERE title LIKE '%Always Sunny in%';

UPDATE shows SET title = 'Parks and Recreation' WHERE title LIKE 'Parks and Rec';

UPDATE shows SET title = 'The Office' WHERE title LIKE '_he__ffice' OR title = 'Office';

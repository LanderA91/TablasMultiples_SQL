CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
	email VARCHAR,
	name VARCHAR,
	lastname VARCHAR,
	rol VARCHAR
	);
	
	INSERT INTO users (email,name,lastname,rol)
	VALUES ('johnsmith@example.com', 'John', 'Smith', 'administrador');
	INSERT INTO users(email,name,lastname,rol)
	VALUES ('alicechang@example.com','Alice', 'Chang', 'usuario');
	INSERT INTO users(email,name,lastname,rol)
	VALUES ('sandrabellini@example.com', 'Sandra', 'Bellini', 'usuario');
	INSERT INTO users(email,name,lastname,rol)
	VALUES ('liliancranston@example.com','Lilian', 'Cranston', 'usuario');
	INSERT INTO users(email,name,lastname,rol)
	VALUES ('iananderson@example.com', 'Ian', 'Anderson', 'usuario');
	
	CREATE TABLE IF NOT EXISTS posts (
	id SERIAL PRIMARY KEY,
	title VARCHAR,
	content TEXT,
	date_created TIMESTAMP,
	date_updated TIMESTAMP,
	destacado BOOLEAN,
	user_id INT
	);
	
INSERT INTO posts(title,content,date_created,date_updated,destacado,user_id)
VALUES ('Title 1','Content 1','2023-06-22 09:00:00','2023-06-22 09:30:00',TRUE,1);
INSERT INTO posts(title,content,date_created,date_updated,destacado,user_id)
VALUES ('Title 2','Content 2','2023-06-22 10:00:00','2023-06-22 11:00:00',FALSE,1);
INSERT INTO posts(title,content,date_created,date_updated,destacado,user_id)
VALUES ('Title 3','Content 3','2023-06-22 12:00:00','2023-06-22 14:00:00',FALSE,5);
INSERT INTO posts(title,content,date_created,date_updated,destacado,user_id)
VALUES ('Title 4','Content 4','2023-06-22 15:00:00','2023-06-22 16:00:00',TRUE,4);
INSERT INTO posts(title,content,date_created,date_updated,destacado,user_id)
VALUES ('Title 5','Content 5','2023-06-22 17:00:00','2023-06-22 19:00:00',FALSE,NULL);

CREATE TABLE IF NOT EXISTS comments (
	id SERIAL PRIMARY KEY,
	content TEXT,
	date_created TIMESTAMP,
	user_id INT,
	post_id INT
	)

INSERT INTO comments (content,date_created,user_id,post_id)
VALUES('Comment 1','2023-06-22 10:00:00',1,1);
INSERT INTO comments (content,date_created,user_id,post_id)
VALUES('Comment 2','2023-06-22 10:15:00',2,1);
INSERT INTO comments (content,date_created,user_id,post_id)
VALUES('Comment 3','2023-06-22 10:20:00',3,1);
INSERT INTO comments (content,date_created,user_id,post_id)
VALUES('Comment 4','2023-06-22 11:30:00',1,2);
INSERT INTO comments (content,date_created,user_id,post_id)
VALUES('Comment 5','2023-06-22 11:45:00',2,2);

SELECT u.name,u.email,p.title AS post_title,p.content AS post_content FROM users u JOIN posts p ON u.id=p.user_id;

SELECT p.id, p.title, p.content
FROM posts p
JOIN users u ON p.user_id=u.id
WHERE u.rol='administrador';

SELECT u.id,u.email,COUNT(P.id) AS post_qty
FROM users u
LEFT JOIN posts p ON u.id=p.user_id
GROUP BY u.id,u.email
ORDER BY u.id ASC;


SELECT u.email
FROM users u
INNER JOIN (
	SELECT user_id,COUNT(*) as num_posts
	FROM posts
	GROUP BY user_id
	ORDER BY num_posts DESC
	LIMIT 1
) p ON u.id=p.user_id


SELECT u.name, MAX(p.date_created) as last_post_date
FROM users u
JOIN posts p ON u.id=p.user_id
GROUP BY u.name;

SELECT p.title, p.content, comment_qty
FROM posts p
INNER JOIN (
SELECT post_id, COUNT(*) as comment_qty
FROM comments c
GROUP BY post_id
ORDER BY comment_qty DESC
LIMIT 1
)
c ON p.id=c.post_id;


SELECT p.title AS post_title, p.content AS post_content, c.content AS 
comment_content, u.email
FROM posts p
JOIN comments c ON p.id=c.post_id
JOIN users u ON c.user_id=u.id;

SELECT date_created, content, user_id FROM comments as c JOIN users as u ON
c.user_id = u.id WHERE c.date_created = (SELECT MAX(date_created) FROM comments
WHERE user_id = u.id);


SELECT u.email
FROM users u
LEFT JOIN comments c on u.id=c.user_id
GROUP BY u.email
HAVING COUNT (c.id)=0;





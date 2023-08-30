CREATE TABLE "categories" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(30) NOT NULL
);

CREATE TABLE "course_videos" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" varchar(100) NOT NULL,
  "url" varchar(300) NOT NULL,
  "courses_id" int NOT NULL
);

CREATE TABLE "courses" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" varchar(300) NOT NULL,
  "description" varchar(1500) NOT NULL,
  "level" varchar(30) NOT NULL,
  "teacher" int NOT NULL
);

CREATE TABLE "roles" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(15) NOT NULL
);

CREATE TABLE "users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(30) NOT NULL,
  "email" varchar(60) NOT NULL,
  "password" varchar(20) NOT NULL,
  "age" int NOT NULL,
  "role_id" int NOT NULL
);

CREATE TABLE "courses_categories" (
  "course_id" int NOT NULL,
  "category_id" int NOT NULL
);

CREATE TABLE "users_courses" (
  "user_id" int NOT NULL,
  "course_id" int NOT NULL
);

ALTER TABLE "users_courses" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("teacher") REFERENCES "users" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "course_videos" ADD FOREIGN KEY ("courses_id") REFERENCES "courses" ("id");

INSERT INTO categories (name) VALUES ('Back End'), ('Front End');

INSERT INTO roles (name) VALUES ('Admin'), ('Student'), ('Teacher'); 

INSERT INTO users (name, email, password, age, role_id) VALUES 
('Jose Zarate', 'email1@example.com', 'password', 20, 1),
('Mariana Palma', 'email2@example.com', 'password123', 21, 2),
('Ian Rosas', 'teacher@example.com', 'password1234', 33, 3),
('Benjamin Flores', 'teacher2@example.com', 'password12345', 27, 3);

INSERT INTO courses (title, description, level, teacher) VALUES
('Node Js', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'Beginner', 3),
('React', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'Intermediate', 4);

INSERT INTO course_videos (title, url, courses_id) VALUES
('Modelo Entidad Relacion', 'https://us02web.zoom.us/rec/share/vAbMr3jTKOkpfiLHTf19Sqk_j20pT8bxkkYZaIWF6tnnQsGkajaHAlnTw31hmw4O.vmINeLTD4NmFjOQw', 1),
('Joins', 'https://us02web.zoom.us/rec/share/duxvGx7vDD5LzJ3916OFSkZ1rMz6PZech5E0XP1LszfCRE-BLeXkL5HtzVIpWipm.r8WqAdizXPZd5ZQB', 1);

INSERT INTO courses_categories (course_id, category_id) VALUES (1, 1), (2, 2);

INSERT INTO users_courses (user_id, course_id) VALUES (1, 1), (3, 1);

SELECT u.id, u.name, u.age, r.name, ca.name, c.title, c.level, c.teacher, cv.title 
FROM users u
JOIN roles r ON u.role_id = r.id 
JOIN users_courses uc ON u.id = uc.user_id
JOIN courses c ON  uc.course_id = c.id
JOIN courses_categories cc ON c.id = cc.course_id
JOIN categories ca ON cc.category_id = ca.id
JOIN course_videos cv ON c.id = cv.courses_id
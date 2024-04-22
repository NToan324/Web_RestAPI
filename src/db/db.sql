-- Tạo cơ sở dữ liệu nếu chưa có
CREATE DATABASE IF NOT EXISTS social_media;

USE social_media;

-- Tạo bảng 'USERS'
CREATE TABLE USERS (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255),
    bio TEXT,
    birthday DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo bảng 'POSTS'
CREATE TABLE POSTS (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    total_likes INT DEFAULT 0,
    image VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- Tạo bảng 'COMMENTS'
CREATE TABLE COMMENTS (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- Tạo bảng 'LIKES'
CREATE TABLE LIKES (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- Chèn dữ liệu mẫu cho bảng USERS
INSERT INTO USERS (name, email, password, avatar, bio, birthday)
VALUES 
    ('User Name', 'user@example.com', 'password', 'avatar1.jpg', 'Lorem ipsum dolor sit amet.', '1990-01-01'),
    ('Jane Smith', 'jane@example.com', 'password2', 'avatar2.jpg', 'Consectetur adipiscing elit.', '1985-05-15'),
    ('Alice Johnson', 'alice@example.com', 'password3', 'avatar3.jpg', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '1995-11-20'),
    ('Bob Brown', 'bob@example.com', 'password4', 'avatar4.jpg', 'Ut enim ad minim veniam.', '1980-09-10'),
    ('Emily Taylor', 'emily@example.com', 'password5', 'avatar5.jpg', 'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '1998-03-25'),
    ('Michael Clark', 'michael@example.com', 'password6', 'avatar6.jpg', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', '1992-07-12'),
    ('Sarah White', 'sarah@example.com', 'password7', 'avatar7.jpg', 'Excepteur sint occaecat cupidatat non proident.', '1987-12-05'),
    ('David Wilson', 'david@example.com', 'password8', 'avatar8.jpg', 'Sunt in culpa qui officia deserunt mollit anim id est laborum.', '1983-04-30'),
    ('Olivia Martinez', 'olivia@example.com', 'password9', 'avatar9.jpg', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '1991-06-18'),
    ('James Lee', 'james@example.com', 'password10', 'avatar10.jpg', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '1989-08-22');

-- Chèn dữ liệu mẫu cho bảng POSTS
INSERT INTO POSTS (user_id, content, image)
VALUES 
    (1, 'This is the content of post 1.', 'image1.jpg'),
    (2, 'This is the content of post 2.', 'image2.jpg'),
    (3, 'This is the content of post 3.', 'image3.jpg'),
    (4, 'This is the content of post 4.', 'image4.jpg'),
    (5, 'This is the content of post 5.', 'image5.jpg'),
    (6, 'This is the content of post 6.', 'image6.jpg'),
    (7, 'This is the content of post 7.', 'image7.jpg'),
    (8, 'This is the content of post 8.', 'image8.jpg'),
    (9, 'This is the content of post 9.', 'image9.jpg'),
    (10, 'This is the content of post 10.', 'image10.jpg');

-- Chèn dữ liệu mẫu cho bảng COMMENTS
INSERT INTO COMMENTS (post_id, user_id, comment)
VALUES 
    (1, 2, 'Nice post!'),
    (1, 3, 'Great content!'),
    (2, 4, 'Awesome!'),
    (2, 5, 'Love it!'),
    (3, 6, 'Amazing post!'),
    (3, 7, 'Keep it up!'),
    (4, 8, 'Wonderful!'),
    (4, 9, 'Fantastic!'),
    (5, 10, 'Excellent!'),
    (5, 1, 'Brilliant!');

-- Chèn dữ liệu mẫu cho bảng LIKES
INSERT INTO LIKES (post_id, user_id)
VALUES 
    (1, 3),
    (1, 5),
    (2, 2),
    (3, 4),
    (4, 1),
    (5, 6),
    (6, 7),
    (7, 8),
    (8, 9),
    (9, 10);
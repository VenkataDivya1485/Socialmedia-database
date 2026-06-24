create database socialmedia_database

create table Users (
    user_id Int primary key auto_increament,
    user_name varchar(50) unique not null,
    email_id varchar(100) unique not null,
    user_password varchar(255) not null,
    joined_date date default current_date);

select *
from users

create table Posts (
    post_id Int primary key auto_increament,
    user_id Int not null,
    content text not null,
    media_url varchar(255),
    posted_at timestamp default current_timestamp,
    foreign key (user_id) references Users(user_id));

select *
from posts

create table Comments (
    comment_id Int primary key auto_increament,
    post_id Int not null,
    user_id Int not null,
    content text not null,
    commented_at timestamp default current_timestamp,
    foreign key (post_id) references Posts(post_id),
    foreign key (user_id) references Users(user_id));

select *
from comments

create table Post_Likes (
    post_id Int,
    user_id Int,
    like_date timestamp default current_timestamp,
    reaction_type varchar(20),
    status varchar(20),
    primary key (post_id, user_id),
    foreign key (post_id) references Posts(post_id),
    foreign key (user_id) references Users(user_id));

select *
from post_likes

create table Connections (
    follower_id Int,
    followed_id Int,
    status varchar(20) default 'accepted',
    connection_date timestamp default current_timestamp,
    connection_type varchar(20),
    primary key (follower_id, followed_id),
    foreign key (follower_id) references Users(user_id),
    foreign key (followed_id) references Users(user_id));

select *
from connections

insert into Users (user_name, email_id, user_password)
values
('Divya', 'divya@gmail.com', 'divya123'),
('Rahul', 'Rahul@gmail.com', 'Rahul123'),
('Sneha', 'Sneha@gmail.com', 'Sneha123'),
('Arjun', 'Arjun@gmail.com', 'Arjun123'),
('Priya', 'priya@gmail.com', 'priya123');

insert into Users (user_name, email_id, user_password)
values
('Kiran', 'kiran@gmail.com', 'kiran123'),
('Meera', 'meera@gmail.com', 'meera123'),
('Vikram', 'vikram@gmail.com', 'vikram123'),
('Anjali', 'anjali@gmail.com', 'anjali123'),
('Rohit', 'rohit@gmail.com', 'rohit123');

select *
from users

insert into Posts (user_id, content, media_url)
values
(1, 'Enjoying my first day on Social Media!', 'divya_post.jpg'),
(2, 'Learning SQL and database concepts.', 'rahul_post.jpg'),
(3, 'Had a wonderful day with friends.', 'sneha_post.jpg'),
(4, 'Working on my ARTWORK.', 'arjun_post.jpg'),
(5, 'Weekend vibes are the best!', 'priya_post.jpg'),
(26, 'Reading a new technology book.', 'kiran_post.jpg'),
(27, 'Nature photography is my hobby.', 'meera_post.jpg'),
(28, 'Completed my workout today.', 'vikram_post.jpg'),
(29, 'Exploring new places this summer.', 'anjali_post.jpg'),
(30, 'Happy to connect with everyone here!', 'rohit_post.jpg');

delete from posts
where post_id between 31 and 50;

select *
from posts

insert into Comments (post_id, user_id, content) 
values
(21, 2, 'Welcome to the platform Divya!'),
(22, 3, 'SQL is really interesting.'),
(23, 4, 'Glad you had a great day!'),
(24, 5, 'Good luck with your artwork.'),
(25, 26, 'Enjoy your weekend!');

insert into Comments (post_id, user_id, content) 
values
(26, 27, 'Which book are you reading?'),
(27, 28, 'Beautiful photography!'),
(28, 29, 'Keep up the good work.'),
(29, 30, 'Have fun exploring!'),
(30, 1, 'Nice to connect with you too.');

select *
from comments 

insert into Post_Likes (post_id, user_id, reaction_type, status)
values
(21, 2, 'Like', 'Active'),
(22, 3, 'Love', 'Active'),
(23, 4, 'Like', 'Inactive'),
(24, 5, 'Love', 'Active'),
(25, 26, 'Like', 'Active');

insert into Post_Likes (post_id, user_id, reaction_type, status)
values
(26, 27, 'Love', 'Active'),
(27, 28, 'Like', 'Inctive'),
(28, 29, 'Love', 'Active'),
(29, 30, 'Like', 'Active'),
(30, 1, 'Love', 'Active');

select *
from post_likes

insert into Connections (follower_id, followed_id, status, connection_type)
values
(1, 2, 'accepted', 'Friend'),
(2, 3, 'accepted', 'Friend'),
(3, 4, 'accepted', 'Follow'),
(4, 5, 'pending', 'Friend'),
(5, 26, 'accepted', 'Follow'),
(26, 27, 'accepted', 'Friend'),
(27, 28, 'accepted', 'Follow'),
(28, 29, 'pending', 'Friend'),
(29, 30, 'accepted', 'Follow'),
(30, 1, 'accepted', 'Friend');

select *
from connections

#limit

select *
from connections
limit 6;

select *
from users
limit 8;

#distinct

select distinct post_id
from posts

select distinct follower_id
from connections

select distinct reaction_type
from post_likes

#order by 

select *
from posts
order by media_url asc

select *
from posts
order by post_id desc 


#count

select count(content)
from comments

#like

select *
from users
where user_name like "%ya";

select *
from posts
where content like "%art%";

#group by

select user_name, count(*) as total_users
from users
group by user_name;

select reaction_type, count(*) as total_reactions
from post_likes
group by reaction_type;

#join and group by

select Posts.post_id, Users.user_name, Posts.content, Posts.posted_at
from Posts
join Users on Posts.user_id = Users.user_id;

#inner join

select U.user_name, P.post_id, P.content, P.posted_at
from Users U
inner join Posts P
ON U.user_id = P.user_id;

select U.user_name, P.post_id, C.content AS comment
from Comments C
inner join Users U
ON C.user_id = U.user_id
inner join Posts P
ON C.post_id = P.post_id;

#left join

select U.user_name, P.post_id, P.content
from users u
left join Posts P
ON U.user_id = P.user_id;

select U.user_name, PL.post_id, PL.reaction_type
from Users U
left join Post_Likes PL
ON U.user_id = PL.user_id;

#right join

select U.user_name, P.post_id, P.content
from Users U
right join Posts P
ON U.user_id = P.user_id;

select U.user_name, PL.post_id, PL.reaction_type
from Users U
right join Post_Likes PL
ON U.user_id = PL.user_id;










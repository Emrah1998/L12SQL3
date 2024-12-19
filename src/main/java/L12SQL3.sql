CREATE TABLE authors (
                         id BIGSERIAL PRIMARY KEY,
                         about TEXT,
                         nick VARCHAR(255),
                         email VARCHAR(255),
                         github VARCHAR(255),
                         created_at TIMESTAMP DEFAULT now(),
                         updated_at TIMESTAMP
);

CREATE TABLE posts (
                       id BIGSERIAL PRIMARY KEY,
                       title VARCHAR(255),
                       content TEXT,
                       image_url VARCHAR(255),
                       created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE author_posts (
                       author_id INT REFERENCES authors(id),
                       post_id INT REFERENCES posts(id),
                       PRIMARY KEY (author_id, post_id)
);




CREATE TABLE subscribers (
                             id SERIAL PRIMARY KEY,
                             email VARCHAR(255) NOT NULL
);




ALTER TABLE authors
    ADD CONSTRAINT unique_nick_email UNIQUE (nick, email);




CREATE TABLE tags (
                      id SERIAL PRIMARY KEY,
                      tag VARCHAR(255)
);

CREATE TABLE post_tags (
                      post_id INT REFERENCES posts(id),
                      tag_id INT REFERENCES tags(id),
                      PRIMARY KEY (post_id, tag_id)
);


CREATE INDEX tags_tag_index ON tags(tag);



CREATE VIEW authors_posts_view AS
SELECT
    a.nick AS author_nick,
    p.title AS post_title,
    p.created_at AS post_created_at
FROM
    authors a
        JOIN
    author_posts ap ON a.id = ap.author_id
        JOIN
    posts p ON p.id = ap.post_id;




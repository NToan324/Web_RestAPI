<?php

class Post
{
    private $conn;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    // TODO: post class, modify function args if needed
    public function findAll()
    {
        $stmt = $this->conn->query("SELECT * FROM posts");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function findById($post_id)
    {
        $stmt = $this->conn->prepare("SELECT * FROM posts WHERE post_id = ?");
        $stmt->execute([$post_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function create($user_id, $content, $image = null)
    {
        $stmt = $this->conn->prepare("INSERT INTO posts (user_id, content, image) VALUES (?, ?, ?)");
        $stmt->execute([$user_id, $content, $image]);
        return $this->conn->lastInsertId();
    }

    public function delete($post_id)
    {
        $stmt = $this->conn->prepare("DELETE FROM posts WHERE post_id = ?");
        return $stmt->execute([$post_id]);
    }

    public function like($post_id, $user_id) {
        // Increase total_likes column in the posts table
        $stmt = $this->conn->prepare("UPDATE posts SET total_likes = total_likes + 1 WHERE post_id = ?");
        $stmt->execute([$post_id]);

        // Add a like to the likes table
        $like = new Like($this->conn);
        $like->create($post_id, $user_id);
    }

    public function unlike($post_id, $user_id)
    {
        $stmt = $this->conn->prepare("UPDATE posts SET total_likes = total_likes - 1 WHERE post_id = ?");
        return $stmt->execute([$post_id]);

        $like = new Like($this->conn);
        $like->delete($post_id, $user_id);
    }

    public function comment($post_id, $user_id, $content)
    {
        $stmt = $this->conn->prepare("INSERT INTO comments (post_id, user_id, content) VALUES (?, ?, ?)");
        return $stmt->execute([$post_id, $user_id, $content]);
    }

    public function deleteComment($comment_id)
    {
        $stmt = $this->conn->prepare("DELETE FROM comments WHERE comment_id = ?");
        return $stmt->execute([$comment_id]);
    }

    // and more function for modify post
}

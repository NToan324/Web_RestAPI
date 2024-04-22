<?php

class User
{
    private $conn;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    // Get user by ID
    public function getById($id)
    {
        $query = "SELECT * FROM users WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Get user by name
    public function findByEmail($email)
    {
        $query = "SELECT * FROM users WHERE email = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$email]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Insert new user
    public function create($name, $email, $password)
    {
        try {
            $user = $this->findByEmail($email);

            if ($user) {
                throw new Exception('Email is already taken');
            }

            $query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            $stmt = $this->conn->prepare($query);
            $success = $stmt->execute([$name, $email, $password]);

            if (!$success) {
                throw new Exception("Failed to create user");
            }

            return array($name, $email, $password);
            
        } catch (PDOException $e) {
            throw $e;
        } catch (Exception $e) {
            throw $e;
        }
    }


    // Delete user by ID
    public function delete($id)
    {
        $query = "DELETE FROM users WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$id]);
    }

    // Authenticate user
    public function authenticate($email, $password)
    {
        // Check if email is empty
        if (empty($email)) {
            throw new \InvalidArgumentException("Username cannot be empty");
        }

        // Get user by email
        $user = $this->findByEmail($email);

        // Check if user exists
        if (!$user) {
            throw new \Exception("User not found");
        }

        // Verify password
        // if (!password_verify($password, $user["password"])) {
        if (!($password === $user["password"])) {
            throw new \Exception("Incorrect password");
        }

        // Authentication successful, return user details
        return $user;
    }
}

package com.dao.interfaces;

import java.util.ArrayList;
import com.dao.model.User;

/**
 * Interface for User Data Access Object (DAO).
 * Provides methods to perform CRUD operations on User objects.
 */
public interface UserDAO {

    /**
     * Inserts a new user into the database.
     * 
     * @param user the User object to be inserted
     * @return the number of rows affected (1 if successful, 0 otherwise)
     */
    int insert(User user);

    /**
     * Fetches all users from the database.
     * 
     * @return an ArrayList of User objects representing all users in the database
     */
    ArrayList<User> fetchAll();

    /**
     * Fetches a user from the database by their unique ID.
     * 
     * @param userId the unique ID of the user to fetch
     * @return the User object with the specified ID, or null if not found
     */
    User fetchOne(int userId);

    /**
     * Updates the password of a specific user.
     * 
     * @param userId the unique ID of the user whose password needs to be updated
     * @param password the new password for the user
     * @return the number of rows affected (1 if successful, 0 otherwise)
     */
    int update(int userId, String password);

    /**
     * Deletes a user from the database by their unique ID.
     * 
     * @param userId the unique ID of the user to be deleted
     * @return the number of rows affected (1 if successful, 0 otherwise)
     */
    int delete(int userId);

    /**
     * Fetches a user from the database by their email.
     * 
     * @param email the email of the user to fetch
     * @return the User object with the specified email, or null if not found
     */
    User fetchByEmail(String email);
}

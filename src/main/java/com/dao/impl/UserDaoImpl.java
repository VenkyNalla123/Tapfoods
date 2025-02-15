package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.dao.dbutil.DBConnection;
import com.dao.interfaces.UserDAO;
import com.dao.model.User;

public class UserDaoImpl implements UserDAO {

    private static Connection connection;
    private static final String FETCH_ALL_QUERY = "SELECT * FROM user";
    private static final String INSERT_QUERY = "INSERT INTO user(username, password, email, address) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_PASSWORD_QUERY = "UPDATE user SET password = ? WHERE userid = ?";
    private static final String FETCH_BY_ID_QUERY = "SELECT * FROM user WHERE userid = ?";
    private static final String DELETE_QUERY = "DELETE FROM user WHERE userid = ?";
    private static final String FETCH_BY_EMAIL_QUERY = "SELECT * FROM user WHERE email = ?";

    static {
        connection = DBConnection.connect(); // Initialize database connection
    }

    @Override
    public int insert(User user) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(INSERT_QUERY);
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getAddress());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public ArrayList<User> fetchAll() {
        Statement statement = null;
        ResultSet resultSet = null;
        ArrayList<User> userList = new ArrayList<>();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(FETCH_ALL_QUERY);
            userList = extractUsersFromResultSet(resultSet);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    @Override
    public User fetchOne(int userId) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(FETCH_BY_ID_QUERY);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();
            ArrayList<User> userList = extractUsersFromResultSet(resultSet);
            return userList.isEmpty() ? null : userList.get(0);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int update(int userId, String newPassword) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_PASSWORD_QUERY);
            preparedStatement.setString(1, newPassword);
            preparedStatement.setInt(2, userId);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(int userId) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(DELETE_QUERY);
            preparedStatement.setInt(1, userId);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public User fetchByEmail(String email) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(FETCH_BY_EMAIL_QUERY);
            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();
            ArrayList<User> userList = extractUsersFromResultSet(resultSet);
            return userList.isEmpty() ? null : userList.get(0);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private ArrayList<User> extractUsersFromResultSet(ResultSet resultSet) {
        ArrayList<User> userList = new ArrayList<>();
        try {
            while (resultSet.next()) {
                User user = new User(
                    resultSet.getString("username"),
                    resultSet.getString("password"),
                    resultSet.getString("email"),
                    resultSet.getString("address")
                );
                user.setUserid(resultSet.getInt("userid"));
                if (resultSet.getTimestamp("created_date") != null) {
                    user.setCreatedDate(resultSet.getTimestamp("created_date").toLocalDateTime());
                }
                if (resultSet.getTimestamp("lastLogindate") != null) {
                    user.setLastLoginDate(resultSet.getTimestamp("lastLogindate").toLocalDateTime());
                }
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
}

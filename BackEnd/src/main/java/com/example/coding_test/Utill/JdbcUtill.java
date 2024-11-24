package com.example.coding_test.Utill;

import java.sql.*;
import java.util.*;

public class JdbcUtill {

    // 커넥션
    private static Connection getConnection(JdbcConstructor dbInfo) throws Exception {
        return DriverManager.getConnection(dbInfo.dbUrl, dbInfo.dbUser, dbInfo.dbPassword);
    }


    // Select Query
    public static List<Object> listExecuteQuery(String sql, Object... params) {
        List<Object> result = new ArrayList<>();
        JdbcConstructor dbInfo = new JdbcConstructor();

        try (Connection connection = getConnection(dbInfo)) {
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) { // PreparedStatement는 내부에서 관리
                // 파라미터 바인딩
                for (int i = 0; i < params.length; i++) {
                    preparedStatement.setObject(i + 1, params[i]);
                }

                // 결과 처리
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    int columnCount = resultSet.getMetaData().getColumnCount();

                    while (resultSet.next()) {
                        Map<String,String> row = new HashMap<>();
                        for (int i = 1; i <= columnCount; i++) {
                            String columnName = resultSet.getMetaData().getColumnName(i); // 컬럼 이름 가져오기
                            String columnValue = resultSet.getString(i); // 컬럼 값 가져오기
                            row.put(columnName, columnValue);
                        }
                        result.add(row);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver failed !! : " + e);
        } catch (SQLException e) {
            System.out.println("JDBC SQLException !! : " + e);
        } catch (Exception e) {
            System.out.println("JDBC Exception !! : " + e);
        }
        return result;
    }


    public static Map<String,String> mapExecuteQuery(String sql, Object... params){
        Map<String,String> result = new HashMap<>();

        JdbcConstructor dbInfo = new JdbcConstructor();

        try  {
            Connection connection = getConnection(dbInfo);
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            
            // 파라미터 바인딩
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
                preparedStatement.getParameterMetaData();
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            // 결과 처리
            int columnCount = resultSet.getMetaData().getColumnCount();
            while (resultSet.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = resultSet.getMetaData().getColumnName(i); // 컬럼 이름 가져오기
                    String columnValue = resultSet.getString(i); // 컬럼 값 가져오기
                    result.put(columnName, columnValue);
                }
            }

        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver failed !! : " + e);
        } catch (SQLException e) {
            System.out.println("JDBC SQLException !! : " + e);
        } catch (Exception e) {
            System.out.println("JDBC Exception !! : " + e);
        }
        return result;
    }

    public static int intExecuteQuery(String sql){
        int result = 0;

        JdbcConstructor dbInfo = new JdbcConstructor();

        try {
            Connection connection = getConnection(dbInfo);
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            result = preparedStatement.executeUpdate();

        }catch (Exception e){
            System.out.println("Insert Error !! " + e);
        }

        return result;


    }


}


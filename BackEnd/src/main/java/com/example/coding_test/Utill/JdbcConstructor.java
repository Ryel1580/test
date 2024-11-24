package com.example.coding_test.Utill;

public class JdbcConstructor {
    String dbDriver;
    // DB URL
    // IP:PORT/스키마
    String dbUrl;
    // DB ID/PW
    String dbUser;
    String dbPassword;

    public JdbcConstructor(){
        this.dbDriver   = "com.mysql.jdbc.Driver";
        this.dbUrl      = "jdbc:mysql://127.0.0.1:3306/study";
        this.dbUser     = "ADMIN";
        this.dbPassword = "0000";
    }

}

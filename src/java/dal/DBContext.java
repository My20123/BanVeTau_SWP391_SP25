/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author tra my
 */
public class DBContext {

    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
    private final String serverName = "localhost";
    private final String dbName = "prj_train";
    private final String portNumber = "3306";
    private final String user = "root";
    private final String password = "khanh123";
    public static void main(String[] args) {
        try {
            System.out.println(new DBContext().getConnection());
        } catch (Exception e) {
        }
    }
}
 
//Class.forName("com.mysql.cj.jdbc.Driver");
//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/prj_train","root", "12345678");

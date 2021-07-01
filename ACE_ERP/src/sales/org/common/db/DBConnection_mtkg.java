/*******************************************************************************
 * 1.Ŭ����   �� : DBConnection.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� :
 * 7.�� �� �� �� :  2006-05-09
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2006-05-09      ;
 * @author
 * @version 1.0 2006-05-09
 ******************************************************************************/

package sales.org.common.db;

import java.sql.*;

import sales.org.common.db.Connection;

public class DBConnection_mtkg{
    private static java.sql.Connection conn;

    private DBConnection_mtkg(){
        super();
    }

    public static Connection getConnection()
    {
        try{

        //DB2 JDBC Driver loading
        String dburl = "jdbc:as400://IP address/SALES";		//���� ������ IP�� �־�� ��.
        String dbuser = "SALES";
        String dbpass = "SALE";
        Class.forName("com.ibm.as400.access.AS400JDBCDriver"); //JDBC driver �ε�

        //get Connection
        conn = DriverManager.getConnection(dburl, dbuser, dbpass);
        }catch(SQLException se){
            System.out.println("DB Conn SQLException ==> "+se);
            se.printStackTrace();

        }catch(Exception e){
            System.out.println("DB Conn Exception ==> "+e);
            e.printStackTrace();
        }
        return new Connection(conn);
    }

}
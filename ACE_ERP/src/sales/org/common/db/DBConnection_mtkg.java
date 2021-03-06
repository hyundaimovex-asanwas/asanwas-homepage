/*******************************************************************************
 * 1.클래스   명 : DBConnection.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 :
 * 7.작 성 일 자 :  2006-05-09
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
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
        String dburl = "jdbc:as400://IP address/SALES";		//여기 서버의 IP를 넣어야 함.
        String dbuser = "SALES";
        String dbpass = "SALE";
        Class.forName("com.ibm.as400.access.AS400JDBCDriver"); //JDBC driver 로딩

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
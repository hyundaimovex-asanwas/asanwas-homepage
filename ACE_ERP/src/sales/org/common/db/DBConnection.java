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
import javax.naming.*;
import javax.sql.DataSource;


public class DBConnection{
    private static java.sql.Connection conn;

    private DBConnection(){
        super();
    }

    public static Connection getConnection()
    {
        try{

       
        //JNDI connection 호출 : import javax.naming.*; 필요
        Context initContext = (Context) new InitialContext();
    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
    	conn = ds.getConnection();
        //JNDI connection 호출
    
        
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
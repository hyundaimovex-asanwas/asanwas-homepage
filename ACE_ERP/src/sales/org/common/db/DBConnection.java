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

       
        //JNDI connection ȣ�� : import javax.naming.*; �ʿ�
        Context initContext = (Context) new InitialContext();
    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
    	conn = ds.getConnection();
        //JNDI connection ȣ��
    
        
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
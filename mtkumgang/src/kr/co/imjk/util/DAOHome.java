package kr.co.imjk.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.co.imjk.lib.Header;
import kr.co.imjk.lib.db.DBHandler;
import kr.co.imjk.lib.exception.DBConnectionFailedException;
import kr.co.imjk.lib.exception.DbException;


/**
 *
 * DAOHome.java
 *
 * DBConnectionManager�� ���� Connection ��ü�� �ְ� �޴� ������ �ַ� �ϴ� Ŭ����
 *
 * @ author : ������
 * @ modifier : jeong hwa, Kim <br>
 * @ e-mail : sim11@miraenet.com
 * @ create-date : 2001-07-25
 * @ modify-date : 2003-10-21
 *
 */
public class DAOHome{

    /**
     * 
     * @uml.property name="connMgr"
     * @uml.associationEnd 
     * @uml.property name="connMgr" multiplicity="(1 1)"
     */
    private DBHandler connMgr;

    
    public DAOHome(){
		connMgr =DBHandler.getInstance();
    }
  
    /**
     * DBConnectionManager �� ���� Connection ��ü�� ����
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *
     */ 
    public Connection getConnection() throws DBConnectionFailedException{
        return getConnection(Header.DB_SID[0], true);
    }

    public Connection getConnection(String poolName) throws DBConnectionFailedException{
        return getConnection(poolName, true);
    }
    
    public Connection getConnection(boolean isAutoCommit) throws DBConnectionFailedException{
        return getConnection(Header.DB_SID[0], isAutoCommit);
    }
            
    public Connection getConnection(String poolName, boolean isAutoCommit) throws DBConnectionFailedException{
        Connection con = null;
        
        /*
         * Context initContext = (Context) new InitialContext();
    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
    	conn = ds.getConnection();*/
        
        try{
            con = connMgr.getConnection(poolName);
            if(con != null && con.getAutoCommit() != isAutoCommit){
                con.setAutoCommit(isAutoCommit);
            }
        }catch(SQLException _ignored){
            System.out.println(Util.getStackTrace(_ignored));
        }
        if(con == null){
            throw new DBConnectionFailedException();  
        }
        return con;
    }

    /**
     * Connection ��ü�� DBConnectonManager�� �ݳ�
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *     
     */
    public void freeConnection(Connection con){
        freeConnection(con, null);
    }

    public void freeConnection(Connection con, Statement stmt){
        try{
            if(stmt != null) stmt.close();
            if(con != null){
                if(!con.getAutoCommit())
                    con.setAutoCommit(true);
                connMgr.freeConnection(con);
            }
        }catch(SQLException _ignored){
        }
    }    

    /**
     * DataBase ĳ���ͼ¿� �°� ��ȯ�Ͽ� ���ڿ��� ����
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *     
     */
    public String encode(String str){
        return encode(str, Header.DB_SID[0]);
    }
         
    public String encode(String str, String poolName){
        return Encoder.setDb(str, poolName);
    }
    
    /**
     * DataBase�� ���� KSC5601�� ��ȯ�Ͽ� ���ڿ��� ����
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *     
     */
    public String decode(String str){
        return decode(str, Header.DB_SID[0]);
    }
    
    public String decode(String str, String poolName){
        if(poolName == null)
            return str;
        return Encoder.getDb(str, poolName);
    }
      
    /**  
     * Exception �� �߻��Ͽ����� DbException �� �ϰ������� ����
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *     
     */
    public void newDbException(String msg) throws DbException{
        throw new DbException(msg);
    }
    
    public void newDbException(Throwable e) throws DbException{
        throw new DbException(e);
    }
     
    /**
     * Statement , PreparedStatement Resource Close
     *
     * @ author : ������ 
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *     
     */ 
    public void release(Statement stmt){
        try{
            if(stmt != null)           
                stmt.close();
        }catch(SQLException _ignored){}
    }

    /**
     * ResultSet, PreparedStatement Resource Close
     *
     * @ author : ������ 
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2004-04-16
     *     
     */ 
    public void release(ResultSet rs, Statement  stmt){
        try{
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
            
        }catch(SQLException _ignored){}
    }
    /**
     * RollBack �Ҷ� SQLException�� �˻����� �ʱ� ���� �޼ҵ�
     *
     * @ author : ������ 
     * @ e-mail : sim11@miraenet.com
     * @ create-date : 2001-07-25
     *     
     */
    public void rollback(Connection con){
        try{
            if(con != null)           
                con.rollback();
        }catch(SQLException _ignored){}
    }
    
    /**
     * �ܼ� UPDATE ������ ���� <br>
     * - ������ �ڵ� �ݿ� - setAutoCommit(true)<br>
     * - Connection �� Default�� ù��° Pool���� ���� <br>
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */
    public synchronized int execQuery(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return executeUpdate(Header.DB_SID[0], sql);
    }
    
    // Connection �� ���ڷ� ���� Pool������ DBPool ���� ������
    public synchronized int executeUpdate(String poolName, String sql)  
        throws SQLException, DBConnectionFailedException, Exception{
        Connection con = getConnection(poolName, true);
        int process = 0;
        try{
            process = executeUpdate(con, sql);
        }finally{
            freeConnection(con);
        }
        return process;
    }
        
    public synchronized int executeUpdate(Connection con, String sql) throws SQLException, Exception{
        Statement stmt = null;
        int process = 0;
        try{
            stmt = con.createStatement();
            process = stmt.executeUpdate(sql);
            stmt.close();
        }finally{
            if(stmt != null) stmt.close();
        }
        return process;
    }
    
    /**
     * String ���� �����ϴ� �ܼ� SELECT ������ ���� <br>
     * - Connection �� Default�� ù��° Pool���� ���� <br>
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */    
    public String executeQuery(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return executeQuery(Header.DB_SID[0], sql);
    }
    
    //  Connection �� ���ڷ� ���� Pool������ DBPool ���� ������ 
    public String executeQuery(String poolName, String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        Connection con = getConnection(poolName);
        String result = null;
        try{
            result = executeQuery(con, poolName, sql);
        }finally{
            freeConnection(con);
        }
        return result;
    }
    
    public String executeQuery(Connection con, String poolName, String sql) throws SQLException, Exception{
        Statement stmt = null;
        ResultSet rs = null;
        String result = null;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            if(rs.next()){
                result = decode(rs.getString(1), poolName);
            }
            rs.close();
            stmt.close();
        }finally{
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
        }
        return result;
    }
    
    /**
     * String[]�� �����ϴ� �ܼ� SELECT ������ ���� <br>
     * - Connection �� Default�� ù��° Pool���� ���� <br>
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */
    public String[] getRecord(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return getRecord(Header.DB_SID[0], sql);
    }
    
    //  Connection �� ���ڷ� ���� Pool������ DBPool ���� ������
    public String[] getRecord(String poolName, String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        Connection con = getConnection(poolName);
        String result [] = null;
        try{
            result = getRecord(con, poolName, sql);
        }finally{
            freeConnection(con);
        }
        return result;
    } 
    
    public String[] getRecord(Connection con, String poolName, String sql) throws SQLException, Exception{
        Statement stmt = null;
        ResultSet rs = null;
        String result [] = null;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();            
            if(rs.next()){
                result = new String[columnCount];
                for(int i=0; i<columnCount; i++){
                    Object o = rs.getObject(i+1);
                    if(o != null) result[i] = decode(o.toString(), poolName);
                }
            }
            rs.close();
            stmt.close();
        }finally{
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
        }
        return result;
    }     
    
    /**
     * �������� ���ڵ���� String[] �� Collection ��� ���� <br>
     * ���� �÷��� �ϳ��ۿ� ���� ���ڵ���̶�� String���� Collection�� ��� �����Ѵ�<br>
     * - Connection �� Default�� ù��° Pool���� ���� <br>
     *
     * @ author : ������
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */
    public Collection getRecordSet(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return executeRecordSet(Header.DB_SID[0], sql);
    }
    
    //  Connection �� ���ڷ� ���� Pool������ DBPool ���� ������
    public Collection executeRecordSet(String poolName, String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        Connection con = getConnection(poolName);
        Collection result = null;
        try{
            result = getRecordSet(con, poolName, sql);
        }finally{
            freeConnection(con);
        }
        return result;
    }

    public Collection getRecordSet(Connection con, String poolName, String sql) throws SQLException, Exception{
        Statement stmt = null;
        ResultSet rs = null;
        Collection result = new ArrayList();
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            while(rs.next()){
                if(columnCount > 1){
                    String [] values = new String[columnCount];
                    for(int i=0; i<columnCount; i++){
                        Object o = rs.getObject(i+1);
                        if(o != null) values[i] = decode(o.toString(), poolName);
                    }
                    result.add(values);
                }else{
                    result.add(decode(rs.getString(1).toString(), poolName));
                }
            }
            rs.close();
            stmt.close();
        }finally{
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
        }
        return result; 
    }    
}
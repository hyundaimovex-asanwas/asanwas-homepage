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
 * DBConnectionManager로 부터 Connection 객체를 주고 받는 역할을 주로 하는 클래스
 *
 * @ author : 심재진
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
     * DBConnectionManager 로 부터 Connection 객체를 리턴
     *
     * @ author : 심재진
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
     * Connection 객체를 DBConnectonManager에 반납
     *
     * @ author : 심재진
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
     * DataBase 캐릭터셋에 맞게 변환하여 문자열을 리턴
     *
     * @ author : 심재진
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
     * DataBase로 부터 KSC5601로 변환하여 문자열을 리턴
     *
     * @ author : 심재진
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
     * Exception 이 발생하였을때 DbException 을 일괄적으로 던짐
     *
     * @ author : 심재진
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
     * @ author : 심재진 
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
     * @ author : 임형수 
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
     * RollBack 할때 SQLException을 검사하지 않기 위한 메소드
     *
     * @ author : 심재진 
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
     * 단순 UPDATE 쿼리를 실행 <br>
     * - 수행결과 자동 반영 - setAutoCommit(true)<br>
     * - Connection 은 Default로 첫번째 Pool명을 넣음 <br>
     *
     * @ author : 심재진
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */
    public synchronized int execQuery(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return executeUpdate(Header.DB_SID[0], sql);
    }
    
    // Connection 은 인자로 받은 Pool명으로 DBPool 에서 꺼내옴
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
     * String 형을 리턴하는 단순 SELECT 쿼리를 실행 <br>
     * - Connection 은 Default로 첫번째 Pool명을 넣음 <br>
     *
     * @ author : 심재진
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */    
    public String executeQuery(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return executeQuery(Header.DB_SID[0], sql);
    }
    
    //  Connection 은 인자로 받은 Pool명으로 DBPool 에서 꺼내옴 
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
     * String[]을 리턴하는 단순 SELECT 쿼리를 실행 <br>
     * - Connection 은 Default로 첫번째 Pool명을 넣음 <br>
     *
     * @ author : 심재진
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */
    public String[] getRecord(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return getRecord(Header.DB_SID[0], sql);
    }
    
    //  Connection 은 인자로 받은 Pool명으로 DBPool 에서 꺼내옴
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
     * 여러개의 레코드셋을 String[] 로 Collection 담아 리턴 <br>
     * 만약 컬럼이 하나밖에 없는 레코드셋이라면 String으로 Collection에 담아 리턴한다<br>
     * - Connection 은 Default로 첫번째 Pool명을 넣음 <br>
     *
     * @ author : 심재진
     * @ e-mail : sim11@miraenet.com 
     * @ create-date : 2001-08-03
     *     
     */
    public Collection getRecordSet(String sql) 
        throws SQLException, DBConnectionFailedException, Exception{
        return executeRecordSet(Header.DB_SID[0], sql);
    }
    
    //  Connection 은 인자로 받은 Pool명으로 DBPool 에서 꺼내옴
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
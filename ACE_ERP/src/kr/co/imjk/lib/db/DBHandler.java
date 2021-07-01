package kr.co.imjk.lib.db;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.co.imjk.lib.Header;
import kr.co.imjk.util.Util;


public class DBHandler {

    private static DBHandler instance;
    private static DataSource ds;

    /**
     * 
     * @uml.property name="instance"
     */
    //Singleton class
    static synchronized public DBHandler getInstance() {
        if (instance == null) {
            instance = new DBHandler();
        }
        return instance;
    }

    private DBHandler() {}

    public Connection getConnection(String lookupName)
        throws java.sql.SQLException {
        Connection con = null;
        try {
            if (ds == null) {
                javax.naming.Context ctx = new InitialContext();
                ds = (javax.sql.DataSource) ctx.lookup(lookupName);
                try {
                    if (ctx != null) {
                        ctx.close();
                    }
                } catch (Exception e) {
                    throw new SQLException("context close exception..");
                }
            }
            con = ds.getConnection();
        } catch (Exception e) {
            System.out.println(Util.getStackTrace(e));
            throw new SQLException(e.toString());
        } finally {
            
        }        
        return con;
    }

    /**
     * multiple connection return
     */
    public Connection getConnection(String poolname, boolean isAutoCommit)
        throws java.sql.SQLException {
        Connection con = getConnection(poolname);
        if(con != null){
            con.setAutoCommit(isAutoCommit);
        }
        return con;
    }

    
    /**
     * default connection return
     */
    public Connection getConnection()
        throws java.sql.SQLException {
        return getConnection(Header.DB_SID[0]);
    }
    
    /**
     * logical connection close
     */
    public void freeConnection(Connection con) {
        try {
            con.close();
        } catch (SQLException se) {
        }
    }

    public void rollback(Connection con) {
        try {
            if (con != null)
                con.rollback();
        } catch (Exception _ignored) {}
    }
}

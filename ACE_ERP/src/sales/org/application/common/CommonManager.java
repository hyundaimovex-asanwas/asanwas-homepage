/*******************************************************************************
 * 1.Ŭ����   �� : CommonManager.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
 * @version 1.0 2004-03-30
 ******************************************************************************/

//Ŀ�ؼ� ����  sales.org.common.db.DBConnection.java
package sales.org.application.common;

import java.sql.SQLException;

import sales.org.common.db.Connection;
import sales.org.common.db.DBConnection;		// ��! ���⼭ Ŀ�ؼ� ������ �մϴ�.
import sales.org.common.db.DBConnection2;
import sales.org.common.log.LogUtil;
import sales.org.util.CalendarUtil;


public class CommonManager {
    protected boolean isCommit;
    protected Connection conn;
    protected CalendarUtil cal;

    public CommonManager() {
        cal = new CalendarUtil();
    }

    public Connection getConnection() {
        if (conn == null) {
            try {
                conn = DBConnection.getConnection();
                LogUtil.debug("Connection get:"+conn.toString());
            } catch (Exception e) {
                LogUtil.error(e);
            }
        }

        if (conn != null) {
            try {
                this.isCommit = conn.getAutoCommit();
                conn.setAutoCommit(false);
            } catch (SQLException e) {
                LogUtil.error(e);
            }
        }
        return conn;
    }

    public Connection getConnection2() {
        if (conn == null) {
            try {
                conn = DBConnection2.getConnection();
                LogUtil.debug("Connection get:"+conn.toString());
            } catch (Exception e) {
                LogUtil.error(e);
            }
        }

        if (conn != null) {
            try {
                this.isCommit = conn.getAutoCommit();
                conn.setAutoCommit(false);
            } catch (SQLException e) {
                LogUtil.error(e);
            }
        }
        return conn;
    }

    public void commit() {
        if (conn != null) {
            try {
                conn.commit();
            } catch (SQLException e) {
                LogUtil.error(e);
            }
        }
    }

    public void rollback() {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException e) {
                LogUtil.error(e);
            }
        }
    }

    public void error(Exception e){
        rollback();
        LogUtil.error(e);
    }

    public void checkUpdate(int check1,int check2){
        if(check1 == check2){
            commit();
        }else{
            rollback();
        }
    }

    public void checkUpdate(long check1,long check2){
        if(check1 == check2){
            commit();
        }else{
            rollback();
        }
    }

    public void close() {
        if (conn != null) {
            try {
                conn.setAutoCommit(isCommit);
            } catch (SQLException e) {
                LogUtil.error(e);
            }
            try {
                LogUtil.debug("Connection close:"+conn.toString());
                conn.close();
                conn = null;
            } catch (SQLException e) {
                LogUtil.error(e);
            }
        }
    }
}
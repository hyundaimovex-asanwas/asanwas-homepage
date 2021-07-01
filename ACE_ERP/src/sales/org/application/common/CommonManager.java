/*******************************************************************************
 * 1.클래스   명 : CommonManager.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2004-03-30
 ******************************************************************************/

//커넥션 정보  sales.org.common.db.DBConnection.java
package sales.org.application.common;

import java.sql.SQLException;

import sales.org.common.db.Connection;
import sales.org.common.db.DBConnection;		// 아! 여기서 커넥션 설정을 합니다.
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
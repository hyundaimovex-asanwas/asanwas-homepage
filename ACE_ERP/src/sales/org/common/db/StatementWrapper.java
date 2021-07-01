/** *******************************************************************************
 *  KTF CASS 프로젝트
 * *******************************************************************************
 * 
 * 1.클래스   명 : StatementWrapper.java
 * 2.클래스 개요 : 
 * 3.관련 테이블 : 
 * 4.관련 클래스 : 
 * 5.관련 페이지 : 
 * 6.작   성  자 : 김택균
 * 7.작 성 일 자 : 2004-05-10
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-05-10      ; 
 * @author 김택균
 * @version 1.0 2004-05-10
 * *****************************************************************************
*/

package sales.org.common.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Statement;

/** 
 * <pre>
 * 
 *  [사용방법]
 * 
 * </pre>
 */
public class StatementWrapper implements Statement {


	Statement stmt;

	public StatementWrapper(Statement stmt){
		this.stmt = stmt;
	}
	

	/* (비Javadoc)
	 * @see java.sql.Statement#executeQuery(java.lang.String)
	 */
	public ResultSet executeQuery(String sql) throws SQLException {
		return stmt.executeQuery(sql);
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String)
	 */
	public int executeUpdate(String sql) throws SQLException {
		return stmt.executeUpdate(sql);
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#close()
	 */
	public void close() throws SQLException {
		stmt.close();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getMaxFieldSize()
	 */
	public int getMaxFieldSize() throws SQLException {
		return stmt.getMaxFieldSize();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setMaxFieldSize(int)
	 */
	public void setMaxFieldSize(int max) throws SQLException {
		stmt.setMaxFieldSize(max);
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getMaxRows()
	 */
	public int getMaxRows() throws SQLException {
		return stmt.getMaxRows();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setMaxRows(int)
	 */
	public void setMaxRows(int max) throws SQLException {
		stmt.setMaxRows(max);
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setEscapeProcessing(boolean)
	 */
	public void setEscapeProcessing(boolean enable) throws SQLException {
		stmt.setEscapeProcessing(enable);
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getQueryTimeout()
	 */
	public int getQueryTimeout() throws SQLException {
		return stmt.getQueryTimeout();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setQueryTimeout(int)
	 */
	public void setQueryTimeout(int seconds) throws SQLException {
		stmt.setQueryTimeout(seconds);
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#cancel()
	 */
	public void cancel() throws SQLException {
		stmt.cancel();
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getWarnings()
	 */
	public SQLWarning getWarnings() throws SQLException {
		return stmt.getWarnings();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#clearWarnings()
	 */
	public void clearWarnings() throws SQLException {
		stmt.clearWarnings();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setCursorName(java.lang.String)
	 */
	public void setCursorName(String name) throws SQLException {
		stmt.setCursorName(name);
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String)
	 */
	public boolean execute(String sql) throws SQLException {
		return stmt.execute(sql);
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getResultSet()
	 */
	public ResultSet getResultSet() throws SQLException {
		return stmt.getResultSet();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getUpdateCount()
	 */
	public int getUpdateCount() throws SQLException {
		return stmt.getUpdateCount();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getMoreResults()
	 */
	public boolean getMoreResults() throws SQLException {
		return stmt.getMoreResults();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setFetchDirection(int)
	 */
	public void setFetchDirection(int direction) throws SQLException {
		stmt.setFetchDirection(direction);
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getFetchDirection()
	 */
	public int getFetchDirection() throws SQLException {
		return stmt.getFetchDirection();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#setFetchSize(int)
	 */
	public void setFetchSize(int rows) throws SQLException {
		stmt.setFetchSize(rows);
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getFetchSize()
	 */
	public int getFetchSize() throws SQLException {
		return stmt.getFetchSize();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getResultSetConcurrency()
	 */
	public int getResultSetConcurrency() throws SQLException {
		return stmt.getResultSetConcurrency();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getResultSetType()
	 */
	public int getResultSetType() throws SQLException {
		return stmt.getResultSetType();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#addBatch(java.lang.String)
	 */
	public void addBatch(String sql) throws SQLException {
		stmt.addBatch(sql);
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#clearBatch()
	 */
	public void clearBatch() throws SQLException {
		stmt.clearBatch();
		
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#executeBatch()
	 */
	public int[] executeBatch() throws SQLException {
		return stmt.executeBatch();
	}

	/* (비Javadoc)
	 * @see java.sql.Statement#getConnection()
	 */
	public Connection getConnection() throws SQLException {
		return stmt.getConnection();
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#getMoreResults(int)
	 */
	public boolean getMoreResults(int arg0) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return false;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#getGeneratedKeys()
	 */
	public ResultSet getGeneratedKeys() throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return null;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String, int)
	 */
	public int executeUpdate(String arg0, int arg1) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return 0;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String, int[])
	 */
	public int executeUpdate(String arg0, int[] arg1) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return 0;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String, java.lang.String[])
	 */
	public int executeUpdate(String arg0, String[] arg1) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return 0;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String, int)
	 */
	public boolean execute(String arg0, int arg1) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return false;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String, int[])
	 */
	public boolean execute(String arg0, int[] arg1) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return false;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String, java.lang.String[])
	 */
	public boolean execute(String arg0, String[] arg1) throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return false;
	}


	/* (비Javadoc)
	 * @see java.sql.Statement#getResultSetHoldability()
	 */
	public int getResultSetHoldability() throws SQLException {
		// TODO 자동 생성된 메소드 스텁
		return 0;
	}
}

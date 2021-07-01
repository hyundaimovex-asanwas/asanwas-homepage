/** *******************************************************************************
 *  KTF CASS ������Ʈ
 * *******************************************************************************
 * 
 * 1.Ŭ����   �� : StatementWrapper.java
 * 2.Ŭ���� ���� : 
 * 3.���� ���̺� : 
 * 4.���� Ŭ���� : 
 * 5.���� ������ : 
 * 6.��   ��  �� : ���ñ�
 * 7.�� �� �� �� : 2004-05-10
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-05-10      ; 
 * @author ���ñ�
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
 *  [�����]
 * 
 * </pre>
 */
public class StatementWrapper implements Statement {


	Statement stmt;

	public StatementWrapper(Statement stmt){
		this.stmt = stmt;
	}
	

	/* (��Javadoc)
	 * @see java.sql.Statement#executeQuery(java.lang.String)
	 */
	public ResultSet executeQuery(String sql) throws SQLException {
		return stmt.executeQuery(sql);
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String)
	 */
	public int executeUpdate(String sql) throws SQLException {
		return stmt.executeUpdate(sql);
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#close()
	 */
	public void close() throws SQLException {
		stmt.close();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getMaxFieldSize()
	 */
	public int getMaxFieldSize() throws SQLException {
		return stmt.getMaxFieldSize();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setMaxFieldSize(int)
	 */
	public void setMaxFieldSize(int max) throws SQLException {
		stmt.setMaxFieldSize(max);
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getMaxRows()
	 */
	public int getMaxRows() throws SQLException {
		return stmt.getMaxRows();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setMaxRows(int)
	 */
	public void setMaxRows(int max) throws SQLException {
		stmt.setMaxRows(max);
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setEscapeProcessing(boolean)
	 */
	public void setEscapeProcessing(boolean enable) throws SQLException {
		stmt.setEscapeProcessing(enable);
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getQueryTimeout()
	 */
	public int getQueryTimeout() throws SQLException {
		return stmt.getQueryTimeout();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setQueryTimeout(int)
	 */
	public void setQueryTimeout(int seconds) throws SQLException {
		stmt.setQueryTimeout(seconds);
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#cancel()
	 */
	public void cancel() throws SQLException {
		stmt.cancel();
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getWarnings()
	 */
	public SQLWarning getWarnings() throws SQLException {
		return stmt.getWarnings();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#clearWarnings()
	 */
	public void clearWarnings() throws SQLException {
		stmt.clearWarnings();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setCursorName(java.lang.String)
	 */
	public void setCursorName(String name) throws SQLException {
		stmt.setCursorName(name);
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String)
	 */
	public boolean execute(String sql) throws SQLException {
		return stmt.execute(sql);
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getResultSet()
	 */
	public ResultSet getResultSet() throws SQLException {
		return stmt.getResultSet();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getUpdateCount()
	 */
	public int getUpdateCount() throws SQLException {
		return stmt.getUpdateCount();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getMoreResults()
	 */
	public boolean getMoreResults() throws SQLException {
		return stmt.getMoreResults();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setFetchDirection(int)
	 */
	public void setFetchDirection(int direction) throws SQLException {
		stmt.setFetchDirection(direction);
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getFetchDirection()
	 */
	public int getFetchDirection() throws SQLException {
		return stmt.getFetchDirection();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#setFetchSize(int)
	 */
	public void setFetchSize(int rows) throws SQLException {
		stmt.setFetchSize(rows);
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getFetchSize()
	 */
	public int getFetchSize() throws SQLException {
		return stmt.getFetchSize();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getResultSetConcurrency()
	 */
	public int getResultSetConcurrency() throws SQLException {
		return stmt.getResultSetConcurrency();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getResultSetType()
	 */
	public int getResultSetType() throws SQLException {
		return stmt.getResultSetType();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#addBatch(java.lang.String)
	 */
	public void addBatch(String sql) throws SQLException {
		stmt.addBatch(sql);
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#clearBatch()
	 */
	public void clearBatch() throws SQLException {
		stmt.clearBatch();
		
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#executeBatch()
	 */
	public int[] executeBatch() throws SQLException {
		return stmt.executeBatch();
	}

	/* (��Javadoc)
	 * @see java.sql.Statement#getConnection()
	 */
	public Connection getConnection() throws SQLException {
		return stmt.getConnection();
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#getMoreResults(int)
	 */
	public boolean getMoreResults(int arg0) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return false;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#getGeneratedKeys()
	 */
	public ResultSet getGeneratedKeys() throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return null;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String, int)
	 */
	public int executeUpdate(String arg0, int arg1) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return 0;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String, int[])
	 */
	public int executeUpdate(String arg0, int[] arg1) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return 0;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#executeUpdate(java.lang.String, java.lang.String[])
	 */
	public int executeUpdate(String arg0, String[] arg1) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return 0;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String, int)
	 */
	public boolean execute(String arg0, int arg1) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return false;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String, int[])
	 */
	public boolean execute(String arg0, int[] arg1) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return false;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#execute(java.lang.String, java.lang.String[])
	 */
	public boolean execute(String arg0, String[] arg1) throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return false;
	}


	/* (��Javadoc)
	 * @see java.sql.Statement#getResultSetHoldability()
	 */
	public int getResultSetHoldability() throws SQLException {
		// TODO �ڵ� ������ �޼ҵ� ����
		return 0;
	}
}

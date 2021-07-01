/*******************************************************************************
 * 1.클래스   명 : PreparedStatementWrapper.java
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

package sales.org.common.db;

import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Array;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Date;
//import java.sql.ParameterMetaData;
import java.sql.PreparedStatement;
import java.sql.Ref;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Calendar;


public class PreparedStatementWrapper extends StatementWrapper implements PreparedStatement {
	PreparedStatement pstmt;

	public PreparedStatementWrapper(PreparedStatement pstmt){
		super(pstmt);
		this.pstmt = pstmt;
	}

	public void close() throws SQLException {
		pstmt.close();
	}

	public ResultSet executeQuery() throws SQLException {
		return pstmt.executeQuery();
	}

	public int executeUpdate() throws SQLException {
		return pstmt.executeUpdate();
	}

	public void setNull(int parameterIndex, int sqlType) throws SQLException {
		pstmt.setNull(parameterIndex, sqlType);
	}

	public void setBoolean(int parameterIndex, boolean x) throws SQLException {
		pstmt.setBoolean(parameterIndex, x);
	}

	public void setByte(int parameterIndex, byte x) throws SQLException {
		pstmt.setByte(parameterIndex,x);
	}

	public void setShort(int parameterIndex, short x) throws SQLException {
		pstmt.setShort(parameterIndex,x);
	}

	public void setInt(int parameterIndex, int x) throws SQLException {
		pstmt.setInt(parameterIndex,x);
	}

	public void setLong(int parameterIndex, long x) throws SQLException {
		pstmt.setLong(parameterIndex,x);
	}

	public void setFloat(int parameterIndex, float x) throws SQLException {
		pstmt.setFloat(parameterIndex,x);
	}

	public void setDouble(int parameterIndex, double x) throws SQLException {
		pstmt.setDouble(parameterIndex,x);
	}

	public void setBigDecimal(int parameterIndex, BigDecimal x) throws SQLException {
		pstmt.setBigDecimal(parameterIndex,x);
	}

	public void setString(int parameterIndex, String x) throws SQLException {
		pstmt.setString(parameterIndex,x);
	}

	public void setBytes(int parameterIndex, byte[] x) throws SQLException {
		pstmt.setBytes(parameterIndex,x);
	}

	public void setDate(int parameterIndex, Date x) throws SQLException {
		pstmt.setDate(parameterIndex,x);
	}

	public void setTime(int parameterIndex, Time x) throws SQLException {
		pstmt.setTime(parameterIndex,x);
	}

	public void setTimestamp(int parameterIndex, Timestamp x) throws SQLException {
		pstmt.setTimestamp(parameterIndex,x);
	}

	public void setAsciiStream(int parameterIndex, InputStream x, int length) throws SQLException {
		pstmt.setAsciiStream(parameterIndex,x, length);
	}

	public void setUnicodeStream(int parameterIndex, InputStream x, int length) throws SQLException {
		pstmt.setUnicodeStream(parameterIndex,x, length);
	}

	public void setBinaryStream(int parameterIndex, InputStream x, int length) throws SQLException {
		pstmt.setBinaryStream(parameterIndex,x, length);
	}

	public void clearParameters() throws SQLException {
		pstmt.clearParameters();
	}

	public void setObject(int parameterIndex, Object x, int targetSqlType, int scale) throws SQLException {
		pstmt.setObject(parameterIndex,x, targetSqlType, scale);
	}

	public void setObject(int parameterIndex, Object x, int targetSqlType) throws SQLException {
		pstmt.setObject(parameterIndex,x, targetSqlType);
	}

	public void setObject(int parameterIndex, Object x) throws SQLException {
		pstmt.setObject(parameterIndex,x);
	}

	public boolean execute() throws SQLException {
		return pstmt.execute();
	}

	public void addBatch() throws SQLException {
		pstmt.addBatch();
	}

	public void setCharacterStream(int parameterIndex, Reader reader, int length) throws SQLException {
		pstmt.setCharacterStream(parameterIndex,reader, length);
	}

	public void setRef(int i, Ref x) throws SQLException {
		pstmt.setRef(i,x);
	}

	public void setBlob(int i, Blob x) throws SQLException {
		pstmt.setBlob(i,x);
	}

	public void setClob(int i, Clob x) throws SQLException {
		pstmt.setClob(i,x);
	}

	public void setArray(int i, Array x) throws SQLException {
		pstmt.setArray(i,x);
	}

	public ResultSetMetaData getMetaData() throws SQLException {
		return pstmt.getMetaData();
	}

	public void setDate(int parameterIndex, Date x, Calendar cal) throws SQLException {
		pstmt.setDate(parameterIndex,x, cal);
	}

	public void setTime(int parameterIndex, Time x, Calendar cal) throws SQLException {
		pstmt.setTime(parameterIndex,x, cal);
	}

	public void setTimestamp(int parameterIndex, Timestamp x, Calendar cal) throws SQLException {
		pstmt.setTimestamp(parameterIndex,x, cal);
	}

	public void setNull(int paramIndex, int sqlType, String typeName) throws SQLException {
		pstmt.setNull(paramIndex,sqlType, typeName);
	}

/*******************************************************************************
 * JDK 1.4에 추가된 것
 ******************************************************************************/
/*
	public void setURL(int parameterIndex, URL x) throws SQLException {
		pstmt.setURL(parameterIndex,x);
	}

	public ParameterMetaData getParameterMetaData() throws SQLException {
		return pstmt.getParameterMetaData();
	}
	*/
}

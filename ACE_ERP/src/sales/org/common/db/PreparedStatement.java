/*******************************************************************************
 * 1.클래스   명 : PreparedStatement.java
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

import java.io.Reader;
import java.io.StringReader;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Vector;

public class PreparedStatement extends PreparedStatementWrapper {

	Vector pstmtList = new Vector();

	String m_sql;

	public PreparedStatement(java.sql.PreparedStatement pstmt) {
		super(pstmt);
	}

	public PreparedStatement(java.sql.Connection conn,String sql) throws SQLException {
		super(conn.prepareStatement(sql));
		m_sql = sql;
	}

	public void setString(int i, String param) throws SQLException {
		pstmtList.addElement((String) ("'" + param + "'"));
		super.setString(i, param);
	}

	public void setSetCharacterStream(int i, String param) throws SQLException {
		pstmtList.addElement((String) ("'" + param + "'"));
		super.setCharacterStream(i, new StringReader(param), param.length());
	}

	public void setSetCharacterStream(int i, Reader reader, int length) throws SQLException {
		pstmtList.addElement((String) ("'" + reader.toString() + "'"));
		super.setCharacterStream(i, reader, length);
	}

	public void setDouble(int i, double param) throws SQLException {
		pstmtList.addElement(new Double(param));
		super.setDouble(i, param);
	}

	public void setFloat(int i, float param) throws SQLException {
		pstmtList.addElement(new Float(param));
		super.setFloat(i, param);
	}

	public void setInt(int i, int param) throws SQLException {
		pstmtList.addElement(new Integer(param));
		super.setInt(i, param);
	}

	public void setLong(int i, long param) throws SQLException {
		pstmtList.addElement(new Long(param));
		super.setLong(i, param);
	}

	public void setDate(int i, Date param) throws SQLException {
		pstmtList.addElement(param);
		super.setDate(i, param);
	}

	public void setTime(int i, Time param) throws SQLException {
		pstmtList.addElement(param);
		super.setTime(i, param);
	}

	public void setTimestamp(int i, Timestamp param) throws SQLException {
		pstmtList.addElement(param);
		super.setTimestamp(i, param);
	}

	public void setSql(String sql) {
		this.m_sql = sql;
	}

	public ResultSet executeQuery() throws SQLException {
		return super.executeQuery();
	}

	public int executeUpdate() throws SQLException {
		return super.executeUpdate();
	}

	public String toString() {
		int seq = 0;
		StringBuffer buf = new StringBuffer();
		String tempSql = new String(this.m_sql);

		for (int i; (i = tempSql.indexOf("?")) >= 0;) {
			buf.append(tempSql.substring(0, i));
			if(pstmtList.elementAt(seq) == null || pstmtList.elementAt(seq).equals(null)){
				buf.append("");
			}else{
				buf.append((pstmtList.elementAt(seq)).toString());
			}
			tempSql = tempSql.substring(i + "?".length());
			seq++;
		}
		buf.append(tempSql);
		return buf.toString();
	}
}

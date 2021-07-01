/*********************************************************************************
 *  하나은행 데이터 이전
 * *******************************************************************************
 *
 * 1.클래스   명 : DataBaseUtil.java
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
 * *****************************************************************************
 */

package sales.org.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class DataBaseUtil {
	/**
	 * 유형별 Data Type 선언
	 */
	static String TYPE_T = "Timestamp";

	static String TYPE_R = "double   ";

	static String TYPE_I = "long     ";

	static String TYPE_S = "String   ";

	/**
	 * 유형별 getMethod 선택
	 */
	static String GET_T = "getTimestamp(";

	static String GET_R = "getDouble(   ";

	static String GET_I = "getLong(     ";

	static String GET_S = "getString(   ";

	/**
	 * 유형별 setMethod 선택
	 */
	static String SET_T = "setTimestamp(";

	static String SET_R = "setDouble(   ";

	static String SET_I = "setLong(     ";

	static String SET_S = "setString(   ";

	/**
	 * 유형별 전역변수 지정
	 */
	ResultSetMetaData rsmd;

	PreparedStatement pstmt;

	String tableName;

	String fileFlag;

	int maxSize;

	int MaxSizeSiteID;

	private DataBaseUtil() {
	}

	/**
	 * 생성자
	 */
	public DataBaseUtil(Connection conn, String tableName) {
		rsmd = getMetaData(conn, tableName);
		this.tableName = tableName;
		this.maxSize = getMaxColSize();
		this.MaxSizeSiteID = getMaxColSizeSiteID();
	}

	public DataBaseUtil(Connection conn, String tableName, String fileFlag) {
		rsmd = getMetaData(conn, tableName);
		this.tableName = tableName;
		this.fileFlag = fileFlag;
		this.maxSize = getMaxColSize();
		this.MaxSizeSiteID = getMaxColSizeSiteID();
	}

	/**
	 * 특정테이블을 DTO로 처리
	 */
	public String tableToDTO() {

		StringBuffer ret = new StringBuffer();
		ret.append(makeVars() + "\n")
		.append(makeGetMethod() + "\n")
		.append(makeSetMethod() + "\n")
		.append(makeSiteID() + "\n")
		.append(tableToSelectJavaSQL() + "\n")
		.append(tableToJavaGet())
		.append(tableToInsertJavaSQL())
		.append(tableToJavaSet());
		return ret.toString();
	}

	/**
	 * 특정테이블을 DTO 파일로 처리
	 */
	public void tableToDTOFile() {
		if (StringUtil.isNotNull(fileFlag)) {
			OutUtil.setOutFile(fileFlag + "_" + tableName + ".java", "KSC5601");
		} else {
			OutUtil.setOutFile(tableName + ".java", "KSC5601");
		}
		OutUtil.println(makeVars());
		OutUtil.println(makeGetMethod());
		OutUtil.println(makeSetMethod());
		OutUtil.println(makeSiteID());
		OutUtil.println(tableToSelectJavaSQL());
		OutUtil.println(tableToJavaGet());
		OutUtil.println(tableToInsertJavaSQL());
		OutUtil.println(tableToJavaSet());
		OutUtil.close();
	}

	/**
	 * 메타데이터 반환
	 */
	public ResultSetMetaData getMetaData(Connection conn, String tableName) {
		try {
			pstmt = conn.prepareStatement("SELECT * FROM " + tableName);
			pstmt.execute();
			rsmd = pstmt.getMetaData();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rsmd;
	}

	/**
	 * PrepareStatement 반환
	 */
	public void close() {
		if (pstmt != null) {
			{
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	/**
	 * 컬럼명 최대 길이 반환
	 */
	public int getMaxColSize() {
		int tmpSize = 0;
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (tmpSize <= rsmd.getColumnName(i).length()) {
						tmpSize = rsmd.getColumnName(i).length();
					}
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return tmpSize;
	}

	public int getMaxColSizeSiteID() {
		int tmpSize = 0;
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("CHAR")
							&& rsmd.getPrecision(i) == 9) {
						if (tmpSize <= rsmd.getColumnName(i).length()) {
							tmpSize = rsmd.getColumnName(i).length();
						}
					}
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return tmpSize;
	}

	/**
	 * 전체선택 SQL 구문 반환
	 */
	public String tableToSelectSQL() {
		StringBuffer sql = new StringBuffer();
		try {
			if (rsmd != null) {
				sql.append("SELECT\n");
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (i != rsmd.getColumnCount()) {
						sql.append(rsmd.getColumnName(i) + ",");
					} else {
						sql.append(rsmd.getColumnName(i) + "\n");
					}
					if (MathUtil.isMultiple(i, 5) && i != rsmd.getColumnCount()) {
						sql.append("\n");
					}
				}
				sql.append("FROM " + tableName);
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return sql.toString();
	}

	/**
	 * 전체선택 StringBuffer구문 반환
	 */
	public String tableToSelectJavaSQL() {
		StringBuffer sql = new StringBuffer();
		try {
			if (rsmd != null) {
				sql.append("sql.append(\"SELECT \");\n");
				sql.append("sql.append(\"");
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (i != rsmd.getColumnCount()) {
						sql.append(rsmd.getColumnName(i) + ",");
					} else {
						sql.append(rsmd.getColumnName(i) + " \");\n");
					}
					if (MathUtil.isMultiple(i, 5) && i != rsmd.getColumnCount()) {
						sql.append("\");\n");
						sql.append("sql.append(\"");
					}
				}
				sql.append("sql.append(\"FROM " + tableName + "\");\n");
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return sql.toString();
	}

	/**
	 * 전체입력 SQL 구문 반환
	 */
	public String tableToInsertSQL() {
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		try {
			if (rsmd != null) {
				sql1.append("INSERT INTO " + tableName + "(\n");
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (i != rsmd.getColumnCount()) {
						sql1.append(rsmd.getColumnName(i) + ",");
						sql2.append("?,");
					} else {
						sql1.append(rsmd.getColumnName(i) + "\n");
						sql2.append("?)");
					}
					if (MathUtil.isMultiple(i, 5) && i != rsmd.getColumnCount()) {
						sql1.append("\n");
						sql2.append("\n");
					}
				}
				sql1.append("FROM " + tableName);
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return sql1.toString() + "\n)VALUES(\n" + sql2.toString() + "\n";
	}

	/**
	 * 전체입력 StringBuffer구문 반환
	 */
	public String tableToInsertJavaSQL() {
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		try {
			if (rsmd != null) {
				sql1.append("sql.append(\"INSERT INTO " + tableName + "(\");\n");
				sql1.append("sql.append(\"");
				sql2.append("sql.append(\"");
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (i != rsmd.getColumnCount()) {
						sql1.append(rsmd.getColumnName(i) + ",");
						sql2.append("?,");
					} else {
						sql1.append(rsmd.getColumnName(i) + "\");");
						sql2.append("?)\");");
					}
					if (MathUtil.isMultiple(i, 5) && i != rsmd.getColumnCount()) {
						sql1.append("\");\n");
						sql1.append("sql.append(\"");
						sql2.append("\");\n");
						sql2.append("sql.append(\"");
					}
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return sql1.toString() + "\nsql.append(\")VALUES(\");\n" + sql2.toString() + "\n";
	}

	/**
	 * rs를 DTO에 셋하는 구문 반환
	 */
	public String tableToJavaGet() {
		StringBuffer dto = new StringBuffer();
		String tmpObj = "";
		String tmpPad = "";
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (Integer.toString(i).substring(Integer.toString(i).length() - 1)
							.equals("1")) {
						dto.append("\n" + "//Setting Line " + i + "\n");
					}
					// Setting Line 1
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("DATE")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIME")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIMESTAMP")) {
						tmpObj = GET_T + "\"" + rsmd.getColumnName(i).toUpperCase() + "\""
								+ ",cal.getCalendar()));\n";
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("NUMBER")) {
						if (rsmd.getScale(i) > 0) {
							tmpObj = GET_R + "\"" + rsmd.getColumnName(i).toUpperCase()
									+ "\"" + "));\n";
						} else {
							tmpObj = GET_I + "\"" + rsmd.getColumnName(i).toUpperCase()
									+ "\"" + "));\n";
						}
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("INT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("INTEGER")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_I)) {
						tmpObj = GET_I + "\"" + rsmd.getColumnName(i).toUpperCase() + "\""
								+ "));\n";
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("FLOAT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_R)) {
						tmpObj = GET_R + "\"" + rsmd.getColumnName(i).toUpperCase() + "\""
								+ "));\n";
					} else {
						tmpObj = GET_S + "\"" + rsmd.getColumnName(i).toUpperCase() + "\""
								+ "));\n";
					}
					if (maxSize - rsmd.getColumnName(i).length() > 0) {
						tmpPad = StringUtil.paddingLeft("", " ", maxSize
								- rsmd.getColumnName(i).length());
					} else {
						tmpPad = "";
					}
					dto.append("dto.set"
							+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
							+ rsmd.getColumnName(i).toLowerCase().substring(1) + "(" + tmpPad
							+ "rs." + tmpObj);
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dto.toString();
	}

	/**
	 * DTO를 pstmt에 셋하는 구문 반환
	 */
	public String tableToJavaSet() {
		StringBuffer dto = new StringBuffer();
		String tmpObj = "";
		String tmpPad = "";
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("DATE")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIME")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIMESTAMP")) {
						tmpObj = SET_T;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("NUMBER")) {
						if (rsmd.getScale(i) > 0) {
							tmpObj = SET_R;
						} else {
							tmpObj = SET_I;
						}
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("INT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("INTEGER")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_I)) {
						tmpObj = SET_I;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("FLOAT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_R)) {
						tmpObj = SET_R;
					} else {
						tmpObj = SET_S;
					}
					if (Integer.toString(rsmd.getColumnCount()).length()
							- Integer.toString(i).length() > 0) {
						tmpPad = StringUtil.paddingLeft("", " ", Integer.toString(
								rsmd.getColumnCount()).length()
								- Integer.toString(i).length());
					} else {
						tmpPad = "";
					}
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("CHAR")
							&& rsmd.getPrecision(i) == 9) {
						dto.append("pstmt." + tmpObj + i + tmpPad + "," + "dto.getC"
								+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
								+ rsmd.getColumnName(i).toLowerCase().substring(1) + "());\n");
						dto.append("//pstmt." + tmpObj + i + tmpPad + "," + "dto.get"
								+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
								+ rsmd.getColumnName(i).toLowerCase().substring(1) + "());\n");
					} else {
						dto.append("pstmt." + tmpObj + i + tmpPad + "," + "dto.get"
								+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
								+ rsmd.getColumnName(i).toLowerCase().substring(1) + "());\n");
					}
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dto.toString();
	}

	/**
	 * 변수명 선언 부분 생성
	 */
	public String makeVars() {
		StringBuffer dto = new StringBuffer();
		String tmpObj = "";
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("DATE")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIME")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIMESTAMP")) {
						tmpObj = TYPE_T;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("NUMBER")) {
						if (rsmd.getScale(i) > 0) {
							tmpObj = TYPE_R;
						} else {
							tmpObj = TYPE_I;
						}
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("INT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("INTEGER")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_I)) {
						tmpObj = TYPE_I;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("FLOAT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_R)) {
						tmpObj = TYPE_R;
					} else {
						tmpObj = TYPE_S;
					}
					dto.append("private " + tmpObj + " "
							+ rsmd.getColumnName(i).toLowerCase() + ";\n");
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dto.toString();
	}

	/**
	 * get Method 생성
	 */
	public String makeGetMethod(int maxSize) {
		StringBuffer dto = new StringBuffer();
		String tmpObj = "";
		String tmpPad = "";
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("DATE")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIME")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_T)) {
						tmpObj = TYPE_T;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("NUMBER")) {
						if (rsmd.getScale(i) > 0) {
							tmpObj = TYPE_R;
						} else {
							tmpObj = TYPE_I;
						}
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("INT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("INTEGER")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_I)) {
						tmpObj = TYPE_I;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("FLOAT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_R)) {
						tmpObj = TYPE_R;
					} else {
						tmpObj = TYPE_S;
					}
					if (maxSize - rsmd.getColumnName(i).length() > 0) {
						tmpPad = StringUtil.paddingLeft("", " ", maxSize
								- rsmd.getColumnName(i).length());
					} else {
						tmpPad = "";
					}
					dto.append("public " + tmpObj + " get"
							+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
							+ rsmd.getColumnName(i).toLowerCase().substring(1) + "(){"
							+ tmpPad + "return this." + rsmd.getColumnName(i).toLowerCase()
							+ ";}\n");
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dto.toString();
	}

	public String makeGetMethod() {
		return makeGetMethod(0);
	}

	/**
	 * set Method 생성
	 */
	public String makeSetMethod() {
		StringBuffer dto = new StringBuffer();
		String tmpObj = "";
		String tmpPad = "";
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("DATE")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("TIME")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_T)) {
						tmpObj = TYPE_T;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("NUMBER")) {
						if (rsmd.getScale(i) > 0) {
							tmpObj = TYPE_R;
						} else {
							tmpObj = TYPE_I;
						}
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("INT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase("INTEGER")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_I)) {
						tmpObj = TYPE_I;
					} else if (rsmd.getColumnTypeName(i).equalsIgnoreCase("FLOAT")
							|| rsmd.getColumnTypeName(i).equalsIgnoreCase(TYPE_R)) {
						tmpObj = TYPE_R;
					} else {
						tmpObj = TYPE_S;
					}
					if (maxSize - rsmd.getColumnName(i).length() > 0) {
						tmpPad = StringUtil.paddingLeft("", " ", maxSize
								- rsmd.getColumnName(i).length());
					} else {
						tmpPad = "";
					}
					dto.append("public void set"
							+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
							+ rsmd.getColumnName(i).toLowerCase().substring(1) + "(" + tmpPad
							+ tmpObj + " in){this." + rsmd.getColumnName(i).toLowerCase()
							+ "=in;}\n");
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dto.toString();
	}

	/**
	 * 사이트 ID 변환 생성
	 */
	public String makeSiteID() {
		StringBuffer dto = new StringBuffer();
		String tmpObj = "";
		String tmpPad = "";
		try {
			if (rsmd != null) {
				for (int i = 1; i < rsmd.getColumnCount() + 1; i++) {
					if (rsmd.getColumnTypeName(i).equalsIgnoreCase("CHAR")
							&& rsmd.getPrecision(i) == 9) {
						if (maxSize - rsmd.getColumnName(i).length() > 0) {
							tmpPad = StringUtil.paddingLeft("", " ", maxSize
									- rsmd.getColumnName(i).length());
						} else {
							tmpPad = "";
						}
						dto.append("public String getC"
								+ rsmd.getColumnName(i).toUpperCase().substring(0, 1)
								+ rsmd.getColumnName(i).toLowerCase().substring(1) + "(){"
								+ tmpPad + "return transferSiteID(this."
								+ rsmd.getColumnName(i).toLowerCase() + ");}\n");
					}
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dto.toString();
	}
}
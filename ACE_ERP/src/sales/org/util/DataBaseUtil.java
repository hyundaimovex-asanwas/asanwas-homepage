/*********************************************************************************
 *  �ϳ����� ������ ����
 * *******************************************************************************
 *
 * 1.Ŭ����   �� : DataBaseUtil.java
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
 * *****************************************************************************
 */

package sales.org.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class DataBaseUtil {
	/**
	 * ������ Data Type ����
	 */
	static String TYPE_T = "Timestamp";

	static String TYPE_R = "double   ";

	static String TYPE_I = "long     ";

	static String TYPE_S = "String   ";

	/**
	 * ������ getMethod ����
	 */
	static String GET_T = "getTimestamp(";

	static String GET_R = "getDouble(   ";

	static String GET_I = "getLong(     ";

	static String GET_S = "getString(   ";

	/**
	 * ������ setMethod ����
	 */
	static String SET_T = "setTimestamp(";

	static String SET_R = "setDouble(   ";

	static String SET_I = "setLong(     ";

	static String SET_S = "setString(   ";

	/**
	 * ������ �������� ����
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
	 * ������
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
	 * Ư�����̺��� DTO�� ó��
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
	 * Ư�����̺��� DTO ���Ϸ� ó��
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
	 * ��Ÿ������ ��ȯ
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
	 * PrepareStatement ��ȯ
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
	 * �÷��� �ִ� ���� ��ȯ
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
	 * ��ü���� SQL ���� ��ȯ
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
	 * ��ü���� StringBuffer���� ��ȯ
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
	 * ��ü�Է� SQL ���� ��ȯ
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
	 * ��ü�Է� StringBuffer���� ��ȯ
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
	 * rs�� DTO�� ���ϴ� ���� ��ȯ
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
	 * DTO�� pstmt�� ���ϴ� ���� ��ȯ
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
	 * ������ ���� �κ� ����
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
	 * get Method ����
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
	 * set Method ����
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
	 * ����Ʈ ID ��ȯ ����
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
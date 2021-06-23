/**
 * �ۼ��� : 2005-01-25
 * �ۼ��� : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Properties;
import java.util.StringTokenizer;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * @author �ֻ��
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class EJBStringUtil 
{
	private final static String DEFAULT_UNI_CODESET = "8859_1";
	private final static String DEFAULT_LOCAL_CODESET = "KSC5601";
	private final static boolean ENCODING_VERBOSE = true;

	public String convEnc(String input)
	{
		String result = "";
		if(input == null)
		{
			return result;
		}
		Properties aProperties = new Properties();
		try
		{
			InputStream aStream = this.getClass().getResourceAsStream("/server.properties");
			aProperties.load(aStream);
		}catch(IOException e)
		{
			e.printStackTrace();
		} 
		if(aProperties.get("server").equals("tomcat"))
		{
			result = input;
		}else
		{
			try
			{
				result = new String(input.getBytes(EJBStringUtil.DEFAULT_UNI_CODESET), EJBStringUtil.DEFAULT_UNI_CODESET);
			} catch (UnsupportedEncodingException e1)
			{
				e1.printStackTrace();
			}
		}
		return result;
	}
	/**
	* String�� int Ÿ������ �����
	* 
	* @param String
	* @return int
	*/
	public static int toInt(String str) {
		return Integer.parseInt(str);
	}

	/**
	 * String���� ���� ���� ��� ""�� �����ش�.
	 * 
	 * @param str
	 * @return
	 */
	public static String checkNull(String str) {
		if (str == null)
			return "";
		return str;
	}

	/**
	* convert int to String
	* @param int i
	* @return String
	*/
	public static String toString(int i) {
		return i + "";
	}

	/**
	* convert String boolean to boolean
	* @param String bool
	* @ return boolean
	*/
	public static boolean toBoolean(String bool) {
		//return (bool != null || ( bool.toLowerCase() ).equals("true")) ? true : false;

		return (Boolean.valueOf(bool)).booleanValue();
	}

	public static String getLineSeparator() {
		return getSystemProperty("line.separator", "\n");
	}

	public static String getSystemProperty(String name) {
		return System.getProperty(name);
	}

	public static String getSystemProperty(String name, String def) {
		return System.getProperty(name, def);
	}

	/**
	* String left right trim
	* @param String str
	* @return String
	*/
	public static String stringTrim(String str) {
		if (str == null)
			return "";
		return str.trim();
	}

	/**
	* String left trim
	* @param String str
	* @return String
	*/
	public static String stringLTrim(String str) {
		if (str == null)
			return "";

		while (str.startsWith(" ")) {
			str = str.substring(1, str.length());
		}
		return str;
	}

	/**
	* String right trim
	* 
	* @param String str
	* @return String
	*/
	public static String stringRTrim(String str) {
		if (str == null)
			return "";

		while (str.endsWith(" ")) {
			str = str.substring(0, str.length() - 1);
		}
		return str;
	}

	/**
	* String left padding
	* @param String str
	* @param char padChar : padded character
	* @param int padLen : padded length
	* @return String
	*/
	public static String stringLPad(String str, char padChar, int padLen) {
		while (str.length() < padLen) {
			str = padChar + str;
		}

		return str;
	}

	/**
	* String right padding
	* @param String str
	* @param char padChar : padded character
	* @param int padLen : padded length
	* @return String
	*/
	public static String stringRPad(String str, char padChar, int padLen) {
		while (str.length() < padLen) {
			str = str + padChar;
		}

		return str;
	}

	/**
	* �־��� ��ġ�� �ڸ��� ��ŭ "0" �� ���� ��Ʈ���� ������� Static �޼ҵ�
	* @param size	��Ʈ������ ��ȯ �� ��ü �ڸ� ��
	* @param num	��Ʈ������ ��ȯ �� ��ġ
	* @return String	ex) "0001", "0000210"
	*/
	public static String padNumber(int size, long num) {
		String s = "";
		for (int j = size - 1; j >= 0; j--) {
			long l1 = (long) Math.pow(10D, j);
			long l2 = num / l1;
			s = s + l2;
			num -= l2 * l1;
		}

		return s;
	}
	
	/**
	 * ���ڸ� õ������ "," �����ڸ� �߰��Ͽ� ��ȯ
	 * @param amount 
	 * @return String ex)"1,234","200,324"
	 */
	public static String getAmount( String amount )
	{
		String convertedAmount = "";
		if( amount != null && amount.length() != 0 )
		{
			StringBuffer buffer = new StringBuffer();
			for( int i = 0; i < amount.length(); i++ )
			{
				int j = ( amount.length() - ( i + 1 ) ) % 3;
				if( i != ( amount.length() - 1 ) && j == 0 )
				{
					buffer.append( amount.charAt( i ) );
					buffer.append( "," );
				}
				else
				{
					buffer.append( amount.charAt( i ) );
				}
			}
			convertedAmount = buffer.toString();
		}
		else
		{
			convertedAmount = " ";
		}
		return convertedAmount;
	}
	
	/**
	* convert local code code set to unicode code set
	* @param String localStr
	* @return String
	*/
	public static String toUniCode(String localStr)
		throws UnsupportedEncodingException {
		if (localStr == null)
			return null;

		if (ENCODING_VERBOSE) {
			return convertCodeSet(
				localStr,
				DEFAULT_LOCAL_CODESET,
				DEFAULT_UNI_CODESET);
		}

		return localStr;
	}

	/**
	* convert unicode code set to local code code set
	* @param String uniStr
	* @return String
	*/
	public static String toLocalCode(String uniStr)
		throws UnsupportedEncodingException {
		if (uniStr == null) {
			return null;
		}

		if (ENCODING_VERBOSE) {
			return convertCodeSet(
				uniStr,
				DEFAULT_UNI_CODESET,
				DEFAULT_LOCAL_CODESET);
		}

		return uniStr;
	}

	public static String convertCodeSet(
		String src,
		String fromCodeSet,
		String toCodeSet)
		throws UnsupportedEncodingException {
		if (src == null)
			return null;

		return new String(src.getBytes(fromCodeSet), toCodeSet);
	}

	/**
	* @param String no
	* @param String
	*/
	public static String makeMoneyType(String no) {
		if (no == null || no.trim().length() == 0)
			return "";

		int index = no.indexOf(".");
		if (index == -1) {
			return makeMoneyType(Long.parseLong(no));
		} else {
			return (
				makeMoneyType(Long.parseLong(no.substring(0, index)))
					+ no.substring(index, no.length()));
		}
	}

	/**
	* @param String no
	* @param String
	*/
	public static String makeMoneyType(int no) {
		return (makeMoneyType((new Integer(no)).longValue()));
	}
	/**
	* @param long no
	* @param String
	*/
	public static String makeMoneyType(long no) {
		return NumberFormat.getInstance().format(no);
	}
	/**
	* @param double no
	* @param String
	*/
	public static String makeMoneyType(double no) {
		return NumberFormat.getInstance().format(no);
	}
	/**
	* @param float no
	* @param String
	*/
	public static String makeMoneyType(float no) {
		return (makeMoneyType((new Float(no)).doubleValue()));
	}

	/**
	* convert html specail charater
	* @param String strHtml
	* @return String
	*/
	public static String convertHTML(String strHtml) {
		if (strHtml == null)
			return "";

		char[] arrStat = strHtml.toCharArray();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < arrStat.length; i++) {
			switch (arrStat[i]) {
				case '\n' :
					sb.append("<br>");
					break;

				case '\t' :
					sb.append("&nbsp;&nbsp;&nbsp;");
					break;

				case '\"' :
					sb.append("&quot;");
					break;

				case '<' :
					sb.append("&lt;");
					break;

				case '>' :
					sb.append("&gt;");
					break;

				case ' ' :
					sb.append("&nbsp;");
					break;

				case '&' :
					sb.append("&amp;");
					break;

				default :
					sb.append(arrStat[i]);
			}
		}

		return sb.toString();
	}

	/**
	* convert html specail charater(use in textbox)
	* @param String strHtml
	* @return String
	*/
	public static String convertHTML2(String strHtml) {
		if (strHtml == null)
			return "";

		char[] arrStat = strHtml.toCharArray();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < arrStat.length; i++) {
			switch (arrStat[i]) {
				case '\t' :
					sb.append("&nbsp;&nbsp;&nbsp;");
					break;

				case '\"' :
					sb.append("&quot;");
					break;

				case '<' :
					sb.append("&lt;");
					break;

				case '>' :
					sb.append("&gt;");
					break;

				case ' ' :
					sb.append("&nbsp;");
					break;

				case '&' :
					sb.append("&amp;");
					break;

				default :
					sb.append(arrStat[i]);
			}
		}

		return sb.toString();
	}

	/**
	* comma separated String --> String array
	* @param String str
	* @return String[]
	*/
	public static String[] getTokenArray(String str) {
		return getTokenArray(str, ",");
	}
	/**
	* special String separated String --> String array
	* @param String str
	* @param String strDelim
	* @return String[]
	*/
	public static String[] getTokenArray(String str, String strDelim) {
		if (str == null || str.length() == 0)
			return null;
		StringTokenizer st = new StringTokenizer(str, strDelim);

		String[] arrToken = new String[st.countTokens()];
		for (int i = 0; i < arrToken.length; i++)
			arrToken[i] = st.nextToken();

		return (arrToken.length == 0) ? null : arrToken;
	}

	public static String truncateString(String str, int truncLen) {
		return truncateString(str, truncLen, "...");
	}

	public static String truncateString(
		String str,
		int truncLen,
		String lastStr) {
		if (str == null)
			return str;

		int len = str.length();
		if (len <= truncLen)
			return str;

		return str.substring(0, truncLen) + ((lastStr == null) ? "" : lastStr);
	}

	public static String makeTildFileName(
		String filename,
		int namelength,
		int extensionlength) {
		if (filename.indexOf(".") == -1) {
			if (filename.length() > namelength)
				return filename.substring(0, namelength) + "~";
		} else {
			String fname = getFileName(filename);
			String fext = getFileExtension(fname);

			if (fname.length() > namelength)
				fname = fname.substring(0, namelength) + "~";
			if (fext.length() > (extensionlength + 1))
				fext = fext.substring(0, extensionlength + 1) + "~";

			return (fname + "." + fext);
		}

		return filename;

	}

	public static String getFileName(String filename) {
		if (filename == null || filename.length() == 0)
			return filename;

		if (filename.indexOf(".") == -1)
			return filename;

		return filename.substring(0, filename.lastIndexOf("."));
	}

	public static String getFileExtension(String filename) {
		if (filename == null)
			return null;

		int len = filename.length();
		if (len == 0)
			return filename;

		int last = filename.lastIndexOf(".");
		if (last == -1)
			return filename;

		return filename.substring(last + 1, len);
	}

	/**
	* �ش� ��ü�� �޽���� get �޽�带 ȣ���Ͽ�<br>
	* �޽�� �̸��� �� ���� line �������� ��´�.
	* @param obj
	* @return get method return value
	* @exception java.lang.exception(java.lang.IllegalAccessException, java.lang.InvocationTargetException)
	*/
	public static String toString(Object obj) throws Exception {
		//		try
		//		{
		Class cls = obj.getClass();
		Method[] mt = cls.getMethods();

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < mt.length; i++) {
			if (mt[i].getName().startsWith("get")) {
				sb.append(mt[i].getName());
				sb.append(" : ");
				sb.append(mt[i].invoke(obj, null));
				if (i < mt.length - 1)
					sb.append("\n");
			}
		}

		return sb.toString();
	}

	/**
	* ��ü ���ڵ� ����, �� �������� ����Ʈ�� ���ڵ� ������ �޾� ��ü ������ ������ ����Ѵ�.
	* @param rowCount ��ü ���ڵ� ����
	* @param rowPerPage �� �������� ����Ʈ�� ���ڵ� ����
	* @return int ��ü ������ ����
	*/
	public static int getTotalPage(int rowCount, int rowPerPage) {
		return ((int) (Math.ceil(rowCount / rowPerPage)))
			+ ((rowCount % rowPerPage) > 0 ? 1 : 0);
	}

	/**
	* �ش� ���ڿ����� Ư�� ���ڸ� �����Ѵ�.
	* <code>StringUtil.removeChar(&quot;1,234,567,890&quot;, ',');</code> -- &quot;1234567890&quot;
	* <code>StringUtil.removeChar(&quot;2001-01-01&quot;, '-');</code> -- &quot;20010101&quot;
	* <code>StringUtil.removeChar(&quot;1 2 3 4 5 6 7 8 9 0&quot;, ' ');</code> -- &quot;1234567890&quot;
	* @param str
	* @param rmChar ������ ����
	* @return String
	*/
	public static String removeChar(String str, char rmChar) {
		if (str == null || str.indexOf(rmChar) == -1)
			return str;

		StringBuffer sb = new StringBuffer();
		char[] arr = str.toCharArray();
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] != rmChar)
				sb.append(arr[i]);
		}

		return sb.toString();
	}

	/**
	* �ش� ���ڿ����� Ư�� ���ڵ��� �����Ѵ�.
	* <code>
	* char[] arr = {'-',' ',':'};<br>
	* StringUtil.removeChar(&quot;2001-01-01 10:10:10&quot;, arr);<br>
	* </code> -- &quot;20010101101010&quot;
	* @param str
	* @param rmChar ������ ����
	* @return String
	*/
	public static String removeChar(String str, char[] rmChar) {
		if (str == null || rmChar == null)
			return str;

		char[] arr = str.toCharArray();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < arr.length; i++) {
			boolean bFlag = true;
			for (int k = 0; k < rmChar.length; k++) {
				if (arr[i] == rmChar[k]) {
					bFlag = false;
					break;
				}
			}
			if (bFlag)
				sb.append(arr[i]);
		}

		return sb.toString();
	}

	/**
	* SQL ���� ���ڿ� ����� 
	* <code>
	* StringUtil.setSqlStr(sqlWhere, sqlAdd);<br>
	* </code>
	* @param slqWhere ���� ���ǹ�
	* @param sqlAdd   �߰��� ���ǹ�
	* @return StringBuffer ���ǹ�
	*/
	public static StringBuffer makeSqlWhere(
		StringBuffer sqlWhere,
		String sqlAdd) {
		if (sqlWhere.length() == 0)
			return sqlWhere.append(" WHERE ").append(sqlAdd);
		else
			return sqlWhere.append(" AND ").append(sqlAdd);
	}
	public static String makeSqlWhere(String sqlWhere, String sqlAdd) {
		if (sqlWhere.length() == 0)
			return sqlWhere = sqlWhere + " WHERE " + sqlAdd;
		else
			return sqlWhere = sqlWhere + " AND " + sqlAdd;
	}

	/**
	*  Data�� ��ȯ�Ͽ� ����(request.getParameter ��� Ȱ��) 
	* <code>
	* StringUtil.getData(paramStr, defaultStr);<br>
	* </code>
	* @param String paramStr 	  ��ȯ�� ���� ���ڿ�
	* @param String defaultStr    default Value(String)
	* @return String ��ȯ�� ���ڿ�
	*/
	public static String getData(String paramStr, String defaultStr) {
		if (paramStr == null || paramStr.trim().length() == 0)
			return defaultStr;
		else
			return paramStr.trim();
	}

	/**
	*  Data�� ��ȯ�Ͽ� ����(request.getParameter ��� Ȱ��)
	* <code>
	* StringUtil.getData(paramStr, defaultStr, formatStr);<br>
	* </code>
	* @param String paramStr 	  ��ȯ�� ���� ���ڿ�
	* @param String defaultStr    default Value(String)
	* @param String formatStr     ��ȯ�� format����
	* @return String ��ȯ�� ���ڿ�
	*/
	public static String getData(
		String paramStr,
		String defaultStr,
		String formatStr) {
		if (paramStr == null || paramStr.trim().length() == 0)
			return defaultStr;

		DecimalFormat df = new DecimalFormat(formatStr);

		try {
			return df.format(Long.parseLong(paramStr.trim()));
		} catch (Exception e) {
			throw new IllegalArgumentException(
				paramStr
					+ "ParamData is not Number format! Checked ParameterValues... ");
		}

	}

	/**
	*  Data�� ��ȯ�Ͽ� ����(request.getParameter ��� Ȱ��)
	* <code>
	* StringUtil.getData(sqlWhere, sqlAdd);<br>
	* </code>
	* @param String paramStr 	  ��ȯ�� ���� ���ڿ�
	* @param String defaultInt    default Value(int)
	* @return int ��ȯ�� ����
	*/
	public static int getData(String paramStr, int defaultInt) {

		if (paramStr == null || paramStr.trim().length() == 0)
			return defaultInt;

		try {
			return Integer.parseInt(paramStr.trim());
		} catch (Exception e) {
			throw new IllegalArgumentException(
				paramStr
					+ "ParamData is not Number format! Checked ParameterValues... ");
		}

	}
	/**
	* ���ڿ��� �� ���̿��� ���� ���ڿ� ����, ������ ���� ��ŭ �նǴ� ���ʿ� ������ ��("0", �Ǵ� space)�� ä�� ����
	* (���ڿ��� ���̸� ä���� ������� �� ��� Ȱ��)
	* <code>
	* StringUtil.getData(sqlWhere, sqlAdd);<br>
	* </code>
	* @param String str 	 	�� ���ڿ�
	* @param int	strLen    	���ϵ� ���ڿ� �ѱ���
	* @param char 	setChar    	ä���� ����
	* @param int	gubun    	ä���� ���ڰ� �ǹ��ڿ��� �� �Ǵ� �� (1 : ��, 2 : ��)
	* @return int �ѱ��̸� ä�� ���ڿ�
	*/
	public static String getDataMake(
		String str,
		int strLen,
		char setChar,
		int gubun) {
		if (str == null)
			str = "";
		else
			str = str.trim();

		if (str.length() >= strLen)
			return str;

		// �ѱ��� ��ŭ�� StringBuffer�� ����
		StringBuffer setStr = new StringBuffer(strLen);
		String result = null;

		try {
			//������ ��ŭ setChar�� ä���.
			for (int i = str.length(); i < strLen; i++) {
				setStr.append(setChar);
			}

			//�տ� ä�� ��� //
			if (gubun == 2) {
				result = setStr.append(str).toString();
				//�ڿ� ���� ��� //
			} else if (gubun == 1) {
				result = str + setStr.toString();
			}

			//System.out.println("str[" + str + "]  strLen[" + strLen + "] setChar[" + setChar + "]" + result);

			return result;

		} catch (Exception e) {
			throw new IllegalArgumentException(
				str + "str is not Number format! Checked ParameterValues... ");
		}
	}

	/**
	* ��ȭ��ȣ ���� ���� 
	* <code>
	* FdsUtil.getPhoneNo(str);<br>
	* </code>
	* @param  String str    ��ȭ��ȣ ��ü ���ڿ�
	* @return String 		���Ŀ� ���� ��ȭ��ȣ
	*/
	// add ekchoi (2001.11.20)
	public static String getPhoneNo(String str) {
		if (str == null || str.trim().length() == 0)
			return "";
		if (str.trim().length() < 7)
			return str;

		str = str.trim();

		StringBuffer telNo = new StringBuffer();
		StringBuffer pureNo = new StringBuffer();

		// ���ڸ� ��ȭ��ȣ�� ���� ����.. //
		for (int i = 0; i < str.length(); i++) {
			char tmp = str.charAt(i);

			if (tmp == '0'
				|| tmp == '1'
				|| tmp == '2'
				|| tmp == '3'
				|| tmp == '4'
				|| tmp == '5'
				|| tmp == '6'
				|| tmp == '7'
				|| tmp == '8'
				|| tmp == '9') {
				pureNo.append(String.valueOf(tmp));
			}
		}

		if (pureNo.length() < 7)
			return str;
		// �ڵ��� ��ȣ //
		if (pureNo.substring(0, 2).equals("01")) {
			telNo.append(pureNo.substring(0, 3)).append("-");
			telNo.append(pureNo.substring(3, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		// ������ȣ ���� - ����
		else if (pureNo.substring(0, 2).equals("02")) {
			telNo.append(pureNo.substring(0, 2)).append("-");
			telNo.append(pureNo.substring(2, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		// ������ȣ ����
		else if (pureNo.substring(0, 1).equals("0")) {
			telNo.append(pureNo.substring(0, 3)).append("-");
			telNo.append(pureNo.substring(3, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		// ������ȣ ����
		else {
			telNo.append(pureNo.substring(0, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		return String.valueOf(telNo);
	}

	/**
	* ��ȭ��ȣ ���� 
	* <code>
	* FdsUtil.getTelNo(str);<br>
	* </code>
	* @param  String str    ��ȭ��ȣ ��ü ���ڿ�
	* @return String 		���� ��ȭ��ȣ�� ����
	*/
	// add ekchoi (2001.11.20)
	public static String getPhoneNo1(String str) {
		if (str == null || str.trim().length() == 0)
			return "";
		if (str.trim().length() < 7)
			return str;

		str = str.trim();

		StringBuffer pureNo = new StringBuffer();

		// ���ڸ� ��ȭ��ȣ�� ���� ����.. //
		for (int i = 0; i < str.length(); i++) {
			char tmp = str.charAt(i);

			if (tmp == '0'
				|| tmp == '1'
				|| tmp == '2'
				|| tmp == '3'
				|| tmp == '4'
				|| tmp == '5'
				|| tmp == '6'
				|| tmp == '7'
				|| tmp == '8'
				|| tmp == '9') {
				pureNo.append(String.valueOf(tmp));
			}
		}
		return String.valueOf(pureNo);
	}
	/**
	* �ݾ� ���� ���� , Dollar ���� �߰� 
	* <code>
	* FdsUtil.makeMoneyType(no, gubun);<br>
	* </code>
	* @param String no
	* @param String gubun 	����/�ؿ� ����
	* @return String 		���Ŀ� ���� ȭ��
	*/
	// add ekchoi (2001.12.21)
	public static String makeMoneyType(String no, String gubun) {
		if (no == null || no.trim().length() == 0)
			return "";

		int index = no.indexOf(".");
		if (index == -1) {
			if (gubun.equals("O"))
				return makeDollarType(no);
			else
				return makeMoneyType(Long.parseLong(no));
		} else {
			if (gubun.equals("O"))
				return (makeDollarType(no));
			else
				return (
					makeMoneyType(Long.parseLong(no.substring(0, index)))
						+ no.substring(index, no.length()));
		}
	}

	/**
	* �ݾ� ���� ���� , Dollar ���� �߰� 
	* <code>
	* FdsUtil.makeDollarType(no);<br>
	* </code>	
	* @param String no	�ݾ�
	* @param String		�޷��ݾ�
	*/
	// add ekchoi (2001.12.21)
	public static String makeDollarType(String no) {
		String result = "";

		if (no.length() >= 3) {
			result =
				NumberFormat.getInstance().format(
					Long.parseLong(no.substring(0, no.length() - 2)))
					+ "."
					+ no.substring(no.length() - 2);
		} else {
			result = "0." + no;
		}
		return result;
	}

	/**
	* �ش� ���ڿ����� Ư�� ���ڿ��� ��ü�Ѵ�.
	* @param str  		��ü���ڿ�
	* @param insteadStr	ã�� ���ڿ�
	* @param changeStr	��ü ���ڿ�
	* @return String
	*/
	// add ekchoi (2002.01.15)
	public static String replaceString(
		String str,
		String insteadStr,
		String changeStr) {
		if (str == null || str.indexOf(insteadStr) == -1)
			return str;

		StringBuffer sb = new StringBuffer();
		char[] arr = str.toCharArray();

		int sPos = 0;
		int ePos = 0;
		int add = insteadStr.length();

		for (int i = 0; i < str.length(); i++) {
			sPos = str.indexOf(insteadStr, ePos);
			if (sPos >= 0) {
				sb.append(str.substring(ePos, sPos));
				sb.append(changeStr);
				ePos = sPos + add;
				i = ePos;
			} else {
				sb.append(str.substring(ePos));
				break;
			}
		}
		return sb.toString();
	}

	/**
	* �ش� ���ڿ����� Ư�� ���ڸ� ��ü�Ѵ�.
	* @param str  		��ü���ڿ�
	* @param insteadCharã�� ����
	* @param changeChar	��ü ����
	* @return String
	*/
	// add ekchoi (2002.01.15)
	public static String replaceChar(
		String str,
		char insteadChar,
		char changeChar) {
		if (str == null || str.indexOf(insteadChar) == -1)
			return str;

		StringBuffer sb = new StringBuffer();
		char[] arr = str.toCharArray();

		for (int i = 0; i < arr.length; i++) {
			if (arr[i] == insteadChar)
				sb.append(changeChar);
			else
				sb.append(arr[i]);
		}

		return sb.toString();
	}
	/**
	* �빮�ڷ� �����ϴ� �޼���
	* @param  str  		��ü���ڿ�
	* @return String	�빮�ڷ� ����� ���ڿ�
	*/
	public static String upperString(String str) {
		return str.toUpperCase();
	}
	/**
	* �ҹ��ڷ� �����ϴ� �޼���
	* @param str  		��ü���ڿ�
	* @return String	�ҹ��ڷ� ����� ���ڿ�
	*/
	public static String lowerString(String str) {
		return str.toLowerCase();
	}
	/**
	* Ư�� ���ڿ��� ���ԵǾ� �ִ��� üũ�ϴ� �޼���
	* @param	target		��ü���ڿ�
	* @param	tokenStr	üũ�� Ư�� ���ڿ�
	* @return	boolean		true : ����, false : �������� ����
	*/
	public static boolean isContains(String target, String tokenStr) {
		return (target.indexOf(tokenStr) != -1) ? true : false;
	}
	/**
	* Ư�� ���ڿ��� � ���ԵǾ� �ִ��� üũ�ϴ� �޼���
	* @param	target		��ü���ڿ�
	* @param	tokenStr	üũ�� Ư�� ���ڿ�
	* @return	int			Ư�� ���ڿ� ���� Ƚ��
	*/
	public static int getOccurTimes(String target, String tokenStr) {
		int count = 0;
		int tokenStr_size = tokenStr.length();
		int sPos = 0;
		int ePos = 0;

		for (int i = 0; i < target.length(); i++) {
			sPos = target.indexOf(tokenStr, ePos);
			if (sPos > 0) {
				/** sPos �� ó������ üũ ����. */
				ePos = (sPos + tokenStr_size);
				i = ePos;
				count++;
			}
		}
		return count;
	}
	/**
	* Ư�� ���ڿ��� �����ϴ��� üũ�ϴ� �޼���
	* @param	target		��ü���ڿ�
	* @param	tokenStr	üũ�� Ư�� ���ڿ�
	* @return	boolean		true : Ư�� ���ڿ��� ����, false : Ư�� ���ڿ��� �������� ����
	*/
	public static boolean isStartWith(String target, String prefix) {
		return target.startsWith(prefix);
	}
	/**
	* Ư�� ���ڿ��� ����Ǵ��� üũ�ϴ� �޼���
	* @param	target		��ü���ڿ�
	* @param	tokenStr	üũ�� Ư�� ���ڿ�
	* @return	boolean		true : Ư�� ���ڿ��� ����, false : Ư�� ���ڿ��� �������� ����
	*/
	public static boolean isEndWith(String target, String suffix) {
		return target.endsWith(suffix);
	}
	/**
	* �ֹε�� ��ȣ�� ǥ���ϴ� �޼���('-' ����)
	* @param	no		�ֹε�� ��ȣŸ������ ������ ���ڿ�
	* @return	String	�ֹε�� ��ȣ�� ����� ���ڿ�
	*/
	public static String getJuminNo(String no) {
		if (no.length() != 13)
			return null;

		return (no.substring(0, 6) + "-" + no.substring(6));
	}

	/**
	* �����ȣ�� ǥ���ϴ� �޼���('-' ����)
	* @param	no			�����ȣŸ������ ������ ���ڿ�	
	* @return	String		�����ȣ�� ����� ���ڿ�
	*/
	public static String getZipCode(String no) {
		if (no.trim().length() != 6)
			return null;

		return (no.substring(0, 3) + "-" + no.substring(3));
	}
	/**
	* �ֹι�ȣ���� ���̸� �˾ƿ��� �޼���
	* @param	jumin		�ֹε�Ϲ�ȣ
	* @return	int			����
	*/
	public static int getAge(String jumin) {
		String year = DateUtil.getYear();

		int yearInt = Integer.parseInt(year);
		int y = Integer.parseInt(year.substring(2));
		int juYear = Integer.parseInt(jumin.substring(0, 2));
		int age = 0;
		if (y > juYear)
			age = y - juYear;
		else {
			juYear += 1900;
			age = yearInt - juYear;
		}
		return age;
	}
	/**
	* �ֹι�ȣ���� ������ �˾ƿ��� �޼���
	* @param	jumin		�ֹε�Ϲ�ȣ
	* @return	String		���� (���� : Man, ���� : Woman)
	*/
	public static String getSex(String jumin) {
		int jumin_length = jumin.length();
		char flag = jumin.charAt(jumin_length - 7);

		return (flag == '1') ? "Man" : "Woman";
	}
	/**
	* �ֹι�ȣ���� ������ �˾ƿ��� �޼���
	* @param	String		���ι�ȣ(10�ڸ� ����)
	* @return	String		���ι�ȣ(-�� ���Ե� ����)
	*/
	public static String getBusiNo(String no) {
		if (no == null || no.length() != 10)
			return "";

		return (
			no.substring(0, 3)
				+ "-"
				+ no.substring(3, 5)
				+ "-"
				+ no.substring(5));
	}

	//======================= ��ó�� �޼��� =============================

	/**
	* DB �۾� �� NULL ���� ���ϵ� ��� Ư�� ���ڷ� ��ü�Ͽ� �ִ� �޼ҵ�
	*
	* @param     p_strSource    null ó�� ��� ����
	* @param	 p_strConv     	p_strSource �� null�� ��� ��ü�� ���ڿ�
	* @return    ��ü�� ����
	*/
	public static String nvl(String p_strSource, String p_strConv) {
		return ((p_strSource == null) || (p_strSource.equals("null")))
			? p_strConv
			: p_strSource.trim();
	}

	/**
	* DB �۾� �� NULL ���̳� null string(����)�� ���ϵ� ��� Ư�� ���ڷ� ��ü�Ͽ� �ִ� �޼ҵ�
	*
	* @param     p_strSource    null ó�� ��� ����
	* @param	 p_strConv     	p_strSource �� null�� ��� ��ü�� ���ڿ�
	* @return    ��ü�� ����
	*/
	public static String nvl2(String p_strSource, String p_strConv) {
		String strSource = "";

		if ((p_strSource == null) || p_strSource.equals("null")) {
			return p_strConv;
		} else {
			strSource = p_strSource.trim();
			if (strSource.equals("") && strSource.length() <= 0) {
				return p_strConv;
			}
		}

		return p_strSource.trim();
	}

	/**
	* DB �۾� �� NULL ���� ���ϵ� ��� ���� ���ڷ� ��ü�Ͽ� �ִ� �޼ҵ�
	* �Ķ����(null ó�� �����)�� null �Ǵ� ���ڿ� "null" �� ��� ������ �����Ѵ�.
	* null �Ǵ� "null" �� �ƴ� ��� trim()�� ���� ���ڿ��� ���ϵȴ�.
	*
	* @param     p_strSource    null ó�� ��� ����
	* @return    p_strSource �� null �̸� ���� ����, �׷��� ������
	*/
	public static String nullToSpace(String p_strSource) {
		String strSource = "";

		if ((p_strSource == null) || p_strSource.equals("null")) {
			return "";
		} else {
			strSource = p_strSource.trim();
			if (strSource.equals("") && strSource.length() <= 0) {
				return "";
			}
		}
		return p_strSource.trim();
	}

	/**
	*
	* ���ڿ��� trim()�Ͽ� return �Ѵ�.(equals()�� ���� �߻��Ҷ� ���)
	*
	* @param		strSrc, strFind, strReplace
	*
	* @return		String
	*
	*/
	public static String trimString(String str)
	{
		String strTmp;
		if (str==null || str=="")
			strTmp = "";
		else
			strTmp = str.trim();

		return strTmp;
	}

	/**
	*
	* ���ڿ����� Ư�� ���ڸ� ã�� Decimal������ �����Ͽ� return �Ѵ�.
	*
	* @param		strText
	*
	* @return		String
	*
	*/
	public static String convert(String strText) {
		String strInput;
		StringBuffer strOutput = new StringBuffer("");
		String convert;
		char strTmp;
		int nCount;

		if (strText==null)
		{
			strText="";
		}

		strInput = strText;
		nCount = strInput.length();

		for (int i = 0; i < nCount; i++ ) {

			strTmp = strInput.charAt(i);

			if (strTmp == '<')
				strOutput.append("&lt;");
			else if (strTmp == '>')
				strOutput.append("&gt;");
			else if (strTmp == '&')
				strOutput.append("&amp;");
			else if (strTmp == (char)37)
				strOutput.append("&#37;");
			else if (strTmp == (char)34)
				strOutput.append("&quot;");
			else if (strTmp == (char)39)
				strOutput.append("&#39;");
			else if (strTmp == '#')
				strOutput.append("&#35;");
			else if (strTmp == '\n')
				strOutput.append("<br>");
			else
				strOutput.append(strTmp);

		}

		convert = strOutput.toString();
		return convert;

	}

	/**
	*
	* ���ڿ����� Ư�� ���ڸ� ã�� Decimal������ �����Ͽ� return �Ѵ�.
	*
	* @param		strText
	*
	* @return		String
	*
	*/
	public static String convertNoEnter(String strText) {
		String strInput;
		StringBuffer strOutput = new StringBuffer("");
		String convert;
		char strTmp;
		int nCount;

		if (strText==null)
		{
			strText="";
		}

		strInput = strText;
		nCount = strInput.length();

		for (int i = 0; i < nCount; i++ ) {

			strTmp = strInput.charAt(i);

			if (strTmp == '<')
				strOutput.append("&lt;");
			else if (strTmp == '>')
				strOutput.append("&gt;");
			else if (strTmp == '&')
				strOutput.append("&amp;");
			else if (strTmp == (char)37)
				strOutput.append("&#37;");
			else if (strTmp == (char)34)
				strOutput.append("&quot;");
			else if (strTmp == (char)39)
				strOutput.append("&#39;");
			else if (strTmp == '#')
				strOutput.append("&#35;");
			else
				strOutput.append(strTmp);

		}

		convert = strOutput.toString();
		return convert;

	}

	public static String convertForView(String strText)
	{
		String strInput;
		StringBuffer strOutput = new StringBuffer("");
		String convert;
		char strTmp;
		int nCount;

		if (strText==null)
		{
			strText="";
		}

		strInput = strText;
		nCount = strInput.length();

		for (int i = 0; i < nCount; i++ ) {

			strTmp = strInput.charAt(i);

			if (strTmp == '<')
				strOutput.append("&lt;");
			else if (strTmp == '>')
				strOutput.append("&gt;");
			else if (strTmp == '&')
				strOutput.append("&amp;");
			else if (strTmp == (char)37)
				strOutput.append("&#37;");
			else if (strTmp == (char)34)
				strOutput.append("&quot;");
			else if (strTmp == (char)39)
				strOutput.append("&#39;");
			else if (strTmp == '#')
				strOutput.append("&#35;");
			else if (strTmp == '\n')
				strOutput.append("<br>");
			else if (strTmp == ' ')
				strOutput.append("&nbsp;") ;
			else
				strOutput.append(strTmp);

		}

		convert = strOutput.toString();
		return convert;

	}

	/** �ڹ� ��ũ��Ʈ ������ ó���� ��� < > �� ���� ó��
	*/
	public static String convertForScript(String strText)
	{
		if(strText == null || strText.length() == 0)
		{
			return "";
		}
		return escapHTML(convertForView(strText));
	}

	public static String escapHTML(String html)
	{
		if(html == null || html.length() == 0)
		{
			return "";
		}

		if((html.indexOf('<') == -1) &&
		   (html.indexOf('>') == -1) &&
		   (html.indexOf('&') == -1) &&
		   (html.indexOf('\'') == -1)) {
			return html;
		}

		int len = html.length();
		StringBuffer sb = new StringBuffer(html.length());
		for(int i = 0 ; i < len ; i++) {
			char c = html.charAt(i);
			if('<' == c) {
				sb.append("&lt;");
			} else if('>' == c) {
				sb.append("&gt;");
			} else if('&' == c) {
				sb.append("&amp;");
			} else if('\'' == c) {
				sb.append("&amp;&#35;39;");
			} else {
				sb.append(c);
			}
		}

		return sb.toString();
	}

	/**
	 * �� ���ڿ������� Ȯ���Ѵ�
	 *
	 * @param str �� ���ڿ����� Ȯ���� ���ڿ�
	 * @return true/false
	 */
	public static boolean isEmpty(String str) {
		if(str == null || str.trim().length() == 0) return true;
		else return false;
	}

	/**
	 * null array���� Ȯ��
	 *
	 * @param str String[]
	 * @return true/false
	 */
	public static boolean isNullArray(String[] str) {
		if(str == null || str.length == 0 || str[0] == null) return true;
		else return false;
	}

	/**
	 * ���ڿ��� ���� ���ڿ����� Ȯ��
	 *
	 * @param str String
	 * @return true/false
	 */
	public static boolean isNumber(String str) {
		if(str == null || str.trim().length() == 0) return false;
		for(int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			if(c < '0' || c > '9') return false;
		}
		return true;
	}


	/**
	 * ������ �� ���е� �ѱ�, ���� ���� ���ڿ��� ���ϴ� ��� Ÿ������ ��ȯ�Ѵ�.
	 *
	 * @param String str ó���� ���ڿ�("�ѱ�" + ������ + "����" ����)
	 * @param boolean isLocale ������ ���ڿ�(true - ����, false - ����)
	 * @param String delim ������
	 * @param String ó�����
	 */
	public static String getLocaleString(String str, String delim, boolean isLocal)
	{
		if(str == null || str.length() == 0 || delim == null || delim.length() == 0)
		{
			return "";
		}


		int index = str.indexOf(delim);

		if(index < 0)
		{
			return "";
		}

		if(isLocal)
		{
			return str.substring(0, index);
		}
		else
		{
			return str.substring(index + 1, str.length());
		}
	}

	/**
	 * ������ �� ���е� �ѱ�, ���� ���� ���ڿ��� ���ϴ� ��� Ÿ������ ��ȯ�Ѵ�.
	 *
	 * @param String str ó���� ���ڿ�("�ѱ�" + ������ + "����" ����)
	 * @param String delim ������
	 * @param String locale �α����� ������� locale
	 * @param String ó�����
	 */
	public static String getLocaleString(String str, String delim, String locale)
	{
		if(str == null || str.length() == 0 || delim == null || delim.length() == 0)
		{
			return "";
		}


		int index = str.indexOf(delim);

		if(index < 0)
		{
			return str;
		}

		if(locale == null || locale.length() < 2 || locale.substring(0,2).equals(DEFAULT_UNI_CODESET) == false)
		{
			return nullValue(str.substring(0, index), "");
		}
		else
		{
			return nullValue(str.substring(index + 1, str.length()), "");
		}
	}
		/**
	*
	* ���ڸ� ���ϴ� ���� ��ŭ���� ������ ū�� Ȯ�� �Ͽ�
	* Ŭ ��쿡�� ���ϴ� ���� ��ŭ ���ڸ� �ڸ��� ���ڿ� �ڿ� ...�߰��Ͽ� ���ڿ��� return �Ѵ�.
	*
	* @param		szInput, nLen
	*
	* @return		String
	*
	*/
	public static String showStringByLength(String szInput, int nLen)
	{
		String szLeft = trimString(szInput);
		for(int i = 1; i <= szInput.length(); i++)
		{
			szLeft = szInput.substring(0, i);
			if (lengthOfString(szLeft) > nLen)
			{
				szLeft = szInput.substring(0, i-1);
				szLeft = szLeft + "...";
				break;
			}
		}
		return szLeft;
	}

	/**
	*
	* ���ڿ��� ���̸� ���Ѵ�. �����϶��� 1�� �ѱ��϶��� 2�� ���̿� �߰�����
	* ���ڿ� ���̸� return �Ѵ�.
	*
	* @param		szAllText
	*
	* @return		int
	*
	*/
	private static int lengthOfString(String szAllText) {
		char szEach;
		int nLen = 0;
		szAllText = trimString(szAllText);
		for(int i = 0; i < szAllText.length(); i++) {
			szEach = szAllText.charAt(i);
			if (0 <= szEach && szEach <= 255)
				nLen += 1;
			else
				nLen += 2;
		}
		return nLen;
	}

	/** ���ڿ��� null �Ǵ� ���̰� 0�� ��� �ٸ� ���ڷ� ��ȯ�Ѵ�
	*/
	public static String nullValue(String str, String nullStr)
	{
		if(str == null || str.trim().length() == 0)
		{
			return nullStr;
		}
		else
		{
			return str;
		}
	}

	/** html�� ���� �Է°����� format���� �����Ѵµ� ���
	*/
	public static String TagToEscapeChar(String aTextVal)
	{
		if ( aTextVal == null || aTextVal.equals("")) return "";

		StringBuffer buf = new StringBuffer();
		char[] c = aTextVal.toCharArray();
		int len = c.length;
		for ( int i=0; i < len; i++) {
			if      ( c[i] == '&' ) buf.append("&amp;");
			else if ( c[i] == '<' ) buf.append("&lt;");
			else if ( c[i] == '>' ) buf.append("&gt;");
			else if ( c[i] == '"' ) buf.append("&quot;");
			else if ( c[i] == '\'') buf.append("&#039;");
			else buf.append(c[i]);
		}
		return buf.toString();
	}

	/**
	 * ���ڿ����� Ư�� ���ڿ��� ġȯ�Ѵ�.
	 * @return the translated string.
	 * @param source String ��ȯ�� ���ڿ�
	 * @param keyStr String ġȯ ��� ���ڿ�
	 * @param toStr String ġȯ�� ���ڿ�
	 * ���� ���, 123456-7890123��� ���ڿ� str�� 1234567890123 �������� �ٲٰ� �ʹٸ�,
	 * replaceStr( str, "-", "") �� ȣ���Ѵ�.
	 */
	public static String replaceStr(String source, String keyStr, String toStr) {
		if (source == null) return null;
		int startIndex = 0;
		int curIndex = 0;
		StringBuffer result = new StringBuffer();

		while ( ( curIndex = source.indexOf(keyStr, startIndex) ) >= 0) {
			result.append(source.substring(startIndex, curIndex))
				  .append(toStr);
			startIndex = curIndex + keyStr.length();
		}

		if (startIndex <= source.length() )
			result.append(source.substring(startIndex, source.length()));

		return result.toString();

	}

	/**
	 * ���ڿ����� Ư�� ���ڿ��� ġȯ�Ѵ�.
	 * ���ڿ� �迭�� ���ʴ�� ġȯ�ϵ�
	 * �� �̻� �迭 ���� ������ space 1ĭ���� ġȯ�Ѵ�.
	 * @return the translated string.
	 * @param source String ��ȯ�� ���ڿ�
	 * @param keyStr String ġȯ ��� ���ڿ�
	 * @param toStr String[] ġȯ�� ���ڿ� �迭
	 */
	public static String replaceStr(String source, String keyStr, String[] toStr) {
		if (source == null) return null;
		int startIndex = 0;
		int curIndex = 0;
		int i = 0;
		StringBuffer result = new StringBuffer();
		String specialString = null;

		while ( ( curIndex = source.indexOf(keyStr, startIndex) ) >= 0) {
			if (i < toStr.length )
				specialString = toStr[i++];
			else
				specialString = " ";
			result.append(source.substring(startIndex, curIndex))
				  .append(specialString);
			startIndex = curIndex + keyStr.length();
		}

		if (startIndex <= source.length() )
			result.append(source.substring(startIndex, source.length()));

		return result.toString();
	}
	// ���� ÷������ �̸��� Ư�� ����
	final static String[] cOriginal = { "#", "'","%", "$", "&", "@", " ", "+","="};
	// ��ġ�� ���ڿ�
	final static String[] cOreplaced = {"<��>","<��>","<��>","<��>","<��>","<��>","<��>", "<��>","<��>"};

	public static String encodeFileName (String filename) {
		for(int i =0; i < cOriginal.length; i++) {
			filename = replaceStr(filename, cOriginal[i], cOreplaced[i]);
		}
		return filename;
	}
	public static String decodeFileName (String filename) {
		for(int i =0; i < cOriginal.length; i++) {
			filename = replaceStr(filename, cOreplaced[i], cOriginal[i]);
		}
		return filename;
	}

	/** SQL���� �˻����� Keyword�� �Ѿ���� ���� Ư�����ڸ� ��ȯ�Ѵ�.*/
	public static String convertSql(String srchValue)
	{
		if(srchValue == null || srchValue.length() == 0)
		{
			return "";
		}

		StringBuffer srchValueBuffer = new StringBuffer() ;

		for(int i = 0 ; i < srchValue.length() ; i++)
		{
			if(srchValue.charAt(i) == '\'')
			{
				srchValueBuffer.append("''") ;
			}
			else if(srchValue.charAt(i) == '&')
			{
				srchValueBuffer.append("\\&") ;
			}
			else if(srchValue.charAt(i) == '|')
			{
				srchValueBuffer.append("\\|") ;
			}
			else
			{
				srchValueBuffer.append(srchValue.charAt(i)) ;
			}
		}

		return srchValueBuffer.toString() ;
	}
	
	/**
	 * Base64 encode
	 * 2004/10/18 �ּ���
	 * @param str
	 * @return
	 */
	public static String encodeBase64(String str)
	{
		BASE64Encoder encoder = new BASE64Encoder();
		String result = "";
		byte[] bytes;

		bytes = str.getBytes();
		result = encoder.encode(bytes);
		return result;
	}

	/**
	 * Base64 decode
	 * 2004/10/18 �ּ���
	 * @param str
	 * @return
	 */
	public static String decodeBase64(String str)
	{
		BASE64Decoder decoder = new BASE64Decoder();
		String result = "";
		byte[] bytes;

		try
		{
			bytes = decoder.decodeBuffer(str);
			result = new String(bytes);
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return result;
	}
}

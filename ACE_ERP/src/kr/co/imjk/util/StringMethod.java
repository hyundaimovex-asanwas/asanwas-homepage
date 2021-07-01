package kr.co.imjk.util;

public class StringMethod
{
	/**
	* 문자열 치환 메소드
	*/
	public static String replace(String str, String strOld, String strNew) throws NullPointerException
	{

		if(str == null || str.equals(""))
			str = "\n";

		for(int index = 0 ;(index = str.indexOf(strOld, index)) >= 0; index += strNew.length())
			str = str.substring(0,index) + strNew + str.substring(index + strOld.length());


		return str;
	}
	/**
		널체크
	*/
	public static String nullCheck(String str)
	{
		if(str == null)
			str = "";

		return str;
	}

	/**
		숫자 널이경우 0으로 셋팅
	*/
	public static String nullToZero(String str)
	{

		if(str == null)
			str = "0";

		return str;
	}
}

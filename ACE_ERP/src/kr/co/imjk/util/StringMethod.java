package kr.co.imjk.util;

public class StringMethod
{
	/**
	* ���ڿ� ġȯ �޼ҵ�
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
		��üũ
	*/
	public static String nullCheck(String str)
	{
		if(str == null)
			str = "";

		return str;
	}

	/**
		���� ���̰�� 0���� ����
	*/
	public static String nullToZero(String str)
	{

		if(str == null)
			str = "0";

		return str;
	}
}

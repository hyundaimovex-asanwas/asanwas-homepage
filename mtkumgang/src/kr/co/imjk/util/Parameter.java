package kr.co.imjk.util;

public class Parameter{
	/**
		�Ķ���͸� �޾Ƽ� int������ ��ȯ�� ����
	*/
	public static int getInt(String val){
		int intVal = 0;
		if(val==null || val.equals("")){
			intVal = 0;
		}else{
			intVal = Integer.parseInt(val);
		}
		return intVal;
	}
	/**
		�Ķ���͸� �޾Ƽ� ����� ��üũ�� ����
	*/
	public static String getString(String val){
		String strVal = "";
		if(val==null || val.equals("")){
			strVal = "";
		}else{
			strVal = val;
		}
		return strVal;
	}
}

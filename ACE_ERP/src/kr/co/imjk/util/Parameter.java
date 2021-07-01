package kr.co.imjk.util;

public class Parameter{
	/**
		파라메터를 받아서 int형으로 변환후 리턴
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
		파라메터를 받아서 공백및 널체크후 리턴
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

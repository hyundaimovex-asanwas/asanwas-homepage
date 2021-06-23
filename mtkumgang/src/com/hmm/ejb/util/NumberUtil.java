/**
 * 작성일 : 2005-01-25
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.util;

import java.text.FieldPosition;
import java.text.NumberFormat;
import java.util.StringTokenizer;

/**
 * <PRE>
 * Filename : NumberUtil.java
 * Class    : ns.common.util.NumberUtil
 * Comment  : 올림, 반올림, 내림, 유효한 숫자인가?,% 반환 하는 클래스<BR>
 * </PRE>
 * @version 1.0 
 * @author  : 2003.11.17 김태호
*/

public class NumberUtil {

	/**
	 * 넘겨받은 숫자를 원하는 자리수에서 올림을 하는 메서드
	 * ex) 123.456 의 숫자에서 소수점 두번째자리( 5 )에서 올림을 하고 싶을때
	 *     double value = 123.456
	 *     WDLNumberUtil.getCeil(value, -2)
	 *     양수 두번째 자리에서 ( 2 ) 에서 올림을 하고 싶을때
	 *     WDLNumberUtil.getCeil(value, 2)
	 * @param	value	올림을 하고자 하는 값
	 *			digit	몇번째 자리에서 올림을 하고 싶은지를 결정하는 자리수
	 *					소수점을 기준으로 양수 첫째자리 1, 둘째자리 2
	 *					소수점을 기준으로 소수 첫째자리 -1, 둘째자리 -2
	 * @return	double	올림된 값
	 */
	public static double getCeil(double value, int digit){
		String count = "1";
		int start = 0;
		int absDigit = Math.abs(digit);
	
		if(digit < 0) 
			start = 1;

		for(int i=start ; i < absDigit ; i++){
			count += "0";
		}
		int mul = Integer.parseInt(count);

		double result = 0;
		double round = 0;
		
		if(digit >= 0){
			round = Math.ceil(value/mul);
			result = round*mul;
		}else{
			round = Math.ceil(value*mul);
			result = round/mul;
		}		
		return result;
	}	
	/**
	 * 넘겨받은 숫자를 원하는 자리수에서 반올림을 하는 메서드
	 * ex) 123.456 의 숫자에서 소수점 두번째자리( 5 )에서 반올림을 하고 싶을때
	 *     double value = 123.456
	 *     WDLNumberUtil.getRound(value, -2)
	 *     양수 두번째 자리에서 ( 2 ) 에서 반올림을 하고 싶을때
	 *     WDLNumberUtil.getRound(value, 2)
	 * @param	value	반올림을 하고자 하는 값
	 *			digit	몇번째 자리에서 반올림을 하고 싶은지를 결정하는 자리수
	 *					소수점을 기준으로 양수 첫째자리 1, 둘째자리 2
	 *					소수점을 기준으로 소수 첫째자리 -1, 둘째자리 -2
	 * @return	double	반올림된 값
	 */
	public static double getRound(double value, int digit){
		String count = "1";
		int start = 0;
		int absDigit = Math.abs(digit);

		if(digit < 0)
			start = 1;

		for(int i=start ; i < absDigit ; i++){
			count += "0";
		}
		int mul = Integer.parseInt(count);

		double result = 0;
		double round = 0;

		if(digit >= 0){
			round = Math.round(value/mul);
			result = round*mul;
		}else{
			round = Math.round(value*mul);
			result = round/mul;
		}
		return result;
	}

	public static String getRound(String value){
		if(value == null || value.trim().equals("")){
			return null;
		}
		try{
			double v = Double.parseDouble(value);

			v = NumberUtil.getRound(v, -4);

			return v+"";
		}catch(NumberFormatException nfe){}

		return null;
	}
	
	/**
	 * 넘겨받은 숫자를 원하는 자리수에서 버림을 하는 메서드
	 * ex) 123.456 의 숫자에서 소수점 두번째자리( 5 )에서 버림을 하고 싶을때
	 *     double value = 123.456
	 *     WDLNumberUtil.getFloor(value, -2)
	 *     양수 두번째 자리에서 ( 2 ) 에서 버림을 하고 싶을때
	 *     WDLNumberUtil.getRound(value, 2)
	 * @param	value	버림을 하고자 하는 값
	 *			digit	몇번째 자리에서 버림을 하고 싶은지를 결정하는 자리수
	 *					소수점을 기준으로 양수 첫째자리 1, 둘째자리 2
	 *					소수점을 기준으로 소수 첫째자리 -1, 둘째자리 -2
	 * @return	double	버림된 값
	 */
	public static double getFloor(double value, int digit){
		String count = "1";
		int start = 0;
		int absDigit = Math.abs(digit);

		if(digit < 0) 
			start = 1;

		for(int i=start ; i < absDigit ; i++){
			count += "0";
		}
		int mul = Integer.parseInt(count);

		double result = 0;
		double round = 0;
		
		if(digit >= 0){
			round = Math.floor(value/mul);
			result = round*mul;
		}else{
			round = Math.floor(value*mul);
			result = round/mul;
		}		
		return result;
	}	
	/**
	 * 유효숫자인지를 체크하는 메서드
	 * 문자에 +,- 기호 또는 ","가 붙어 있어도 숫자로 인식한다. 
	 * @param	num		유효숫자인지를 체크하기 위한 파라미터
	 * @return	boolean	true : 유효숫자, false : 숫자아님
	 */
	public static boolean isNumber(String num){
		boolean pointFlag = true;

		if(num == null || num.trim().length() == 0) return false;

		for(int i=0 ; i < num.trim().length() ; i++){
			char temp = num.charAt(i);
			
			if(temp == '.' && pointFlag){
				pointFlag = false;
				continue;
			}

			if( i == 0 && (temp == '-' || temp == '+' || (temp >= '0' && temp <= '9')))
				continue;		
	
			if(temp == ',') continue;		// 문자에 , 허용..
			
			if(temp == '.' && !pointFlag)
				return false;		
			
			if(!(temp >= '0' && temp <= '9'))
				return false;							
		}
		return true;
	}
	/**
	 * % 로 계산한 후 원하는 자리에서 반올림해서 넘겨주는 메서드
	 * ex) 276 에서 37.4 가 차지하는 비율을 소수점 두자리까지 해서 % 리턴하게 할 경우
	 *	   double fir = 37.4;
	 *	   double sec = 276;	 
	 *	   getPercent(fir, sec, -2) 하면 "13.6%" 라는 값이 리턴
	 * @param	fir		피젯수 
	 *			sec		젯수
	 *			digit	반올림 하고 싶은 자릿수
	 * @return	String	% 값
	 */
	public static String getPercent(double fir, double sec, int digit){	
		double result = fir/sec;
		result *= 100;
		double round = getRound(result, digit);
		
		return round + "%";
	}	
	
	
	/**
	 * 문자열 형태인 숫자에서 콤마(,)를 없애고 double 형식으로 리턴해 주는 메소드 <br>
	 * num 에 숫자로 변환될 수 없는 문자가 포함되어 있다면 NumberFormatException이 발생할 가능성이 있다. 
	 *
	 * @ param num 문자열 형태의 숫자값을 가지고 있는 String 예) "123,456.889"
	 * @ return double 콤마를 뺀 double 형태의 숫자.
	 */	
	
	public static double delComma(String number){		
		double soo = 0.0;
		String num = number.trim();
				
//		if(num.equals("N/A")) return 0.0;			
			
		// , 가 없는 경우.
		if(num.indexOf(",") == -1){
			soo =  Double.parseDouble(num);
		}
		// , 가 있는 경우..콤마를 제거한 후 숫자로 리턴..
		else{
			StringTokenizer st = new StringTokenizer(num,",");
			StringBuffer value = new StringBuffer();
			while(st.hasMoreTokens()){
				String temp = st.nextToken();
				value.append(temp);
			}
			
			// System.out.println("value : " + value);
			
			soo = Double.parseDouble(value.toString());		
		}
		return soo;
	}
	
	
	/**
	 * 숫자(double)에 콤마(,)를 넣어서 문자열 형식으로 리턴해 주는 메소드
	 *
	 * @ param num double value 예) 123456.889
	 * @ param omitPosition 반올림할 자릿수
	 * @ return String 콤마를 포함한 double 형태의 문자열.
	 */	
	public static String addComma(double num, int omitPosition){
	
		NumberFormat myFormat= NumberFormat.getNumberInstance();
		FieldPosition fp=new FieldPosition(NumberFormat.INTEGER_FIELD);		
		
		myFormat.setMaximumFractionDigits(omitPosition);
		myFormat.setMinimumFractionDigits(omitPosition);
	    
		String return_value = myFormat.format(num,new StringBuffer(), fp).toString();
	   
		return return_value;
	}


	/**
	 * 문자열 형태인 숫자값(예:123,456.8899)을 omitPosition 자리만큼 반올림하여 double 형식으로 리턴해 주는 메소드<br>
	 * num 에 숫자로 변환될 수 없는 문자(콤마를 제외)가 포함되어 있다면 NumberFormatException이 발생할 가능성이 있다.
	 *
	 * @ param num double value 예) 123456.889
	 * @ param omitPosition 반올림할 자릿수
	 * @ return String 콤마를 포함한 double 형태의 문자열.
	 */	
	public static double omitDecimal(String double_num, int omitPosition){
			
		double num = delComma(double_num);

		NumberFormat myFormat= NumberFormat.getNumberInstance();
		FieldPosition fp=new FieldPosition(NumberFormat.INTEGER_FIELD);		
		
		myFormat.setMaximumFractionDigits(omitPosition);
		myFormat.setMinimumFractionDigits(omitPosition);
	    
		double return_value = delComma(myFormat.format(num,new StringBuffer(), fp).toString());
	   
		return return_value;
	}
	
	
	/**
	 * double 타입의 숫자값(예:123456.8899)을 omitPosition 자리만큼 반올림하여 문자열 형식으로 리턴해 주는 메소드<br>
	 * 리턴값에 콤마를 포함한다.
	 *
	 * @ param num double value 예) 123456.889
	 * @ param omitPosition 반올림할 자릿수
	 * @ return String 콤마를 포함한 double 형태의 문자열.
	 */		
	public static String omitDecimal(double num, int omitPosition){
			
		NumberFormat myFormat= NumberFormat.getNumberInstance();
		FieldPosition fp=new FieldPosition(NumberFormat.INTEGER_FIELD);		
		
		myFormat.setMaximumFractionDigits(omitPosition);
		myFormat.setMinimumFractionDigits(omitPosition);
	    
		String return_value = myFormat.format(num,new StringBuffer(), fp).toString();
	   
		return return_value;
	}
	
	
	/**
	 * 파라이터로 들어온 double[] 안의 숫자 중 제일 큰 수를 리턴한다. 
	 *
	 * @ param num double 타입의 배열
	 * @ return double 파라이터로 들어온 배열의 double value 중 제일 큰 값을 리턴한다. 
	 */	
	public static double getMaxValue(double[] num){
		double tmpMax =  num[0];
		for (int x=0 ; x < num.length ; x++ ){
			if (tmpMax < num[x]){
					tmpMax = num[x]; 
			}
		}
		return tmpMax;
	}
	
	/**
	 * 파라이터로 들어온 double[] 안의 숫자 중 제일 작은 수를 리턴한다. 
	 *
	 * @ param num double 타입의 배열
	 * @ return double 파라이터로 들어온 배열의 double value 중 제일 작은 값을 리턴한다. 
	 */	
	public static double getMinValue(double[] num){
		
		double tmpMax =  num[0];
		for (int x=0 ; x < num.length ; x++ ){
			if (tmpMax > num[x]){
					tmpMax = num[x]; 
			}
		}
		return tmpMax;
	}
	
	/**
	 * 파라이터로 들어온 double[] 안의 숫자 중 제일 작은 수를 리턴한다. 
	 *
	 * @ param num String 배열
	 * @ return double 파라이터로 들어온 배열의 double value 중 제일 작은 값을 리턴한다. 
	 */	
	public static double getMinValue(String[] num){
		
		double tmpMax =  NumberUtil.omitDecimal(num[0].trim(),2);
		
		for (int x=0 ; x < num.length ; x++ ){
			if (tmpMax > NumberUtil.omitDecimal(num[x].trim(),2)){
					tmpMax = NumberUtil.omitDecimal(num[x].trim(),2);
			}
		}
		return tmpMax;
	}

}
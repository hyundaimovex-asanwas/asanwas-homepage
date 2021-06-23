/**
 * �ۼ��� : 2005-01-25
 * �ۼ��� : csangsu
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
 * Comment  : �ø�, �ݿø�, ����, ��ȿ�� �����ΰ�?,% ��ȯ �ϴ� Ŭ����<BR>
 * </PRE>
 * @version 1.0 
 * @author  : 2003.11.17 ����ȣ
*/

public class NumberUtil {

	/**
	 * �Ѱܹ��� ���ڸ� ���ϴ� �ڸ������� �ø��� �ϴ� �޼���
	 * ex) 123.456 �� ���ڿ��� �Ҽ��� �ι�°�ڸ�( 5 )���� �ø��� �ϰ� ������
	 *     double value = 123.456
	 *     WDLNumberUtil.getCeil(value, -2)
	 *     ��� �ι�° �ڸ����� ( 2 ) ���� �ø��� �ϰ� ������
	 *     WDLNumberUtil.getCeil(value, 2)
	 * @param	value	�ø��� �ϰ��� �ϴ� ��
	 *			digit	���° �ڸ����� �ø��� �ϰ� �������� �����ϴ� �ڸ���
	 *					�Ҽ����� �������� ��� ù°�ڸ� 1, ��°�ڸ� 2
	 *					�Ҽ����� �������� �Ҽ� ù°�ڸ� -1, ��°�ڸ� -2
	 * @return	double	�ø��� ��
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
	 * �Ѱܹ��� ���ڸ� ���ϴ� �ڸ������� �ݿø��� �ϴ� �޼���
	 * ex) 123.456 �� ���ڿ��� �Ҽ��� �ι�°�ڸ�( 5 )���� �ݿø��� �ϰ� ������
	 *     double value = 123.456
	 *     WDLNumberUtil.getRound(value, -2)
	 *     ��� �ι�° �ڸ����� ( 2 ) ���� �ݿø��� �ϰ� ������
	 *     WDLNumberUtil.getRound(value, 2)
	 * @param	value	�ݿø��� �ϰ��� �ϴ� ��
	 *			digit	���° �ڸ����� �ݿø��� �ϰ� �������� �����ϴ� �ڸ���
	 *					�Ҽ����� �������� ��� ù°�ڸ� 1, ��°�ڸ� 2
	 *					�Ҽ����� �������� �Ҽ� ù°�ڸ� -1, ��°�ڸ� -2
	 * @return	double	�ݿø��� ��
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
	 * �Ѱܹ��� ���ڸ� ���ϴ� �ڸ������� ������ �ϴ� �޼���
	 * ex) 123.456 �� ���ڿ��� �Ҽ��� �ι�°�ڸ�( 5 )���� ������ �ϰ� ������
	 *     double value = 123.456
	 *     WDLNumberUtil.getFloor(value, -2)
	 *     ��� �ι�° �ڸ����� ( 2 ) ���� ������ �ϰ� ������
	 *     WDLNumberUtil.getRound(value, 2)
	 * @param	value	������ �ϰ��� �ϴ� ��
	 *			digit	���° �ڸ����� ������ �ϰ� �������� �����ϴ� �ڸ���
	 *					�Ҽ����� �������� ��� ù°�ڸ� 1, ��°�ڸ� 2
	 *					�Ҽ����� �������� �Ҽ� ù°�ڸ� -1, ��°�ڸ� -2
	 * @return	double	������ ��
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
	 * ��ȿ���������� üũ�ϴ� �޼���
	 * ���ڿ� +,- ��ȣ �Ǵ� ","�� �پ� �־ ���ڷ� �ν��Ѵ�. 
	 * @param	num		��ȿ���������� üũ�ϱ� ���� �Ķ����
	 * @return	boolean	true : ��ȿ����, false : ���ھƴ�
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
	
			if(temp == ',') continue;		// ���ڿ� , ���..
			
			if(temp == '.' && !pointFlag)
				return false;		
			
			if(!(temp >= '0' && temp <= '9'))
				return false;							
		}
		return true;
	}
	/**
	 * % �� ����� �� ���ϴ� �ڸ����� �ݿø��ؼ� �Ѱ��ִ� �޼���
	 * ex) 276 ���� 37.4 �� �����ϴ� ������ �Ҽ��� ���ڸ����� �ؼ� % �����ϰ� �� ���
	 *	   double fir = 37.4;
	 *	   double sec = 276;	 
	 *	   getPercent(fir, sec, -2) �ϸ� "13.6%" ��� ���� ����
	 * @param	fir		������ 
	 *			sec		����
	 *			digit	�ݿø� �ϰ� ���� �ڸ���
	 * @return	String	% ��
	 */
	public static String getPercent(double fir, double sec, int digit){	
		double result = fir/sec;
		result *= 100;
		double round = getRound(result, digit);
		
		return round + "%";
	}	
	
	
	/**
	 * ���ڿ� ������ ���ڿ��� �޸�(,)�� ���ְ� double �������� ������ �ִ� �޼ҵ� <br>
	 * num �� ���ڷ� ��ȯ�� �� ���� ���ڰ� ���ԵǾ� �ִٸ� NumberFormatException�� �߻��� ���ɼ��� �ִ�. 
	 *
	 * @ param num ���ڿ� ������ ���ڰ��� ������ �ִ� String ��) "123,456.889"
	 * @ return double �޸��� �� double ������ ����.
	 */	
	
	public static double delComma(String number){		
		double soo = 0.0;
		String num = number.trim();
				
//		if(num.equals("N/A")) return 0.0;			
			
		// , �� ���� ���.
		if(num.indexOf(",") == -1){
			soo =  Double.parseDouble(num);
		}
		// , �� �ִ� ���..�޸��� ������ �� ���ڷ� ����..
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
	 * ����(double)�� �޸�(,)�� �־ ���ڿ� �������� ������ �ִ� �޼ҵ�
	 *
	 * @ param num double value ��) 123456.889
	 * @ param omitPosition �ݿø��� �ڸ���
	 * @ return String �޸��� ������ double ������ ���ڿ�.
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
	 * ���ڿ� ������ ���ڰ�(��:123,456.8899)�� omitPosition �ڸ���ŭ �ݿø��Ͽ� double �������� ������ �ִ� �޼ҵ�<br>
	 * num �� ���ڷ� ��ȯ�� �� ���� ����(�޸��� ����)�� ���ԵǾ� �ִٸ� NumberFormatException�� �߻��� ���ɼ��� �ִ�.
	 *
	 * @ param num double value ��) 123456.889
	 * @ param omitPosition �ݿø��� �ڸ���
	 * @ return String �޸��� ������ double ������ ���ڿ�.
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
	 * double Ÿ���� ���ڰ�(��:123456.8899)�� omitPosition �ڸ���ŭ �ݿø��Ͽ� ���ڿ� �������� ������ �ִ� �޼ҵ�<br>
	 * ���ϰ��� �޸��� �����Ѵ�.
	 *
	 * @ param num double value ��) 123456.889
	 * @ param omitPosition �ݿø��� �ڸ���
	 * @ return String �޸��� ������ double ������ ���ڿ�.
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
	 * �Ķ����ͷ� ���� double[] ���� ���� �� ���� ū ���� �����Ѵ�. 
	 *
	 * @ param num double Ÿ���� �迭
	 * @ return double �Ķ����ͷ� ���� �迭�� double value �� ���� ū ���� �����Ѵ�. 
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
	 * �Ķ����ͷ� ���� double[] ���� ���� �� ���� ���� ���� �����Ѵ�. 
	 *
	 * @ param num double Ÿ���� �迭
	 * @ return double �Ķ����ͷ� ���� �迭�� double value �� ���� ���� ���� �����Ѵ�. 
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
	 * �Ķ����ͷ� ���� double[] ���� ���� �� ���� ���� ���� �����Ѵ�. 
	 *
	 * @ param num String �迭
	 * @ return double �Ķ����ͷ� ���� �迭�� double value �� ���� ���� ���� �����Ѵ�. 
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
/**
	��¥ ���� ��ƿ
*/

package kr.co.imjk.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

public class DateUtil
{
			
	/**
		��¥������ - ��ȣ ���ֱ�(��¥�� ���� ��ȣ)
	*/
	public static String delString(String date,String del)
	{
    	StringTokenizer token = new StringTokenizer(date,del);
    	date ="";
    	
    	while(token.hasMoreTokens())
    	{
    		date = date + token.nextToken();
    	}
    	
    	return date;
	}
	
	/**
		���糯¥ �˾Ƴ���(yyyy-mm-dd��)
	*/
	public static String TodayIs() throws ParseException 
	{
    	
    	//���糯¥ �˾Ƴ���
        java.util.Date today1 = new java.util.Date();
    	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    	String todayString1 = sdf1.format(today1);
    	
    	return todayString1;
    	
    }	
    
	/**
		�Ѿ�� ��¥�� �ֱٱ����� (�ֱٱ��̸� true)-- �ٸ� ���
	*/
	public static boolean isNew(String dbDate,long minDate) throws ParseException 
	{
    	
		String todayString1 = TodayIs();
  		SimpleDateFormat df = new SimpleDateFormat ("yyyy-MM-dd");
  
  		long diffDate =  (df.parse(todayString1).getTime() - df.parse(dbDate).getTime()) / 86400 / 1000;
		
 
    	if (diffDate <= minDate) {
    		return true;
    	}else {
    		return false;
    	}			
	}
	
	       
}

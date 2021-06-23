/**
	날짜 관련 유틸
*/

package kr.co.imjk.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

public class DateUtil
{
			
	/**
		날짜형에서 - 부호 없애기(날짜와 지울 부호)
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
		현재날짜 알아내기(yyyy-mm-dd형)
	*/
	public static String TodayIs() throws ParseException 
	{
    	
    	//현재날짜 알아내기
        java.util.Date today1 = new java.util.Date();
    	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    	String todayString1 = sdf1.format(today1);
    	
    	return todayString1;
    	
    }	
    
	/**
		넘어온 날짜가 최근글인지 (최근글이면 true)-- 다른 방법
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

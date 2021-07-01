/**
 * 작성일 : 2005-01-25
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.util;

import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
import java.util.*;
import java.sql.Timestamp;

public class DateUtil {
	private final static String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	private final static String DEFAULT_DATE_LEN    = "00000000000000";
	private final static int MILLIS_PER_HOUR = 3600000;	//60*60*1000

	private final static int[] SOLAR_MONTH_ARRAY ={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

	private final static String[] TEN_KR_ARRAY = {"갑", "을", "병", "정", "무", "기", "경", "신", "임", "계" };
	private final static String[] TEN_CH_ARRAY = {"甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"};

	private final static String[] ZODIAC_KR_ARRAY = {"자", "축", "인", "묘", "진", "사", "오", "미", "신", "유", "술", "해" };
	private final static String[] ZODIAC_CH_ARRAY = {"子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"};

	private final static String[] ZODIAC_ARRAY = {"쥐", "소", "호랑이", "토끼", "용", "뱀", "말", "양", "원숭이", "닭", "개", "돼지"};

	private static Calendar getCalendar(){
		return Calendar.getInstance();
	}

	/**
	 * 현재년도를 yyyy 형식으로 얻어온다.
	 * 
	 * @param	void
	 * @return	String	yyyy
	 */	
	public static String getYear(){	
		return (DateUtil.getCalendar()).get(Calendar.YEAR) + "";
	}
	/**
	* 현재월을 mm 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	mm
	*/	
	public static String getMonth(){
		int mon = (DateUtil.getCalendar()).get(Calendar.MONTH);
		mon++; // 0~11 까지 나온다. 0 이 1월이다.
		
		if(mon <= 9)
			return "0"+mon;
		else
			return ""+mon;
	}

	/**
	* 현재일을 dd 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	dd
	*/	
	public static String getDay(){
		int day = (DateUtil.getCalendar()).get(Calendar.DATE);
		if(day <= 9)
			return "0"+day;
		else 
			return ""+day;
	}
	/**
	* 현재시간을 hh 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	hh
	*/	
	public static String getHour(){
		int hour = (DateUtil.getCalendar()).get(Calendar.HOUR_OF_DAY);
		if(hour <= 9)
			return "0"+hour;
		else 
			return ""+hour;	
	}
	/**
	* 현재분을 mm 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	mm
	*/	
	public static String getMinute(){
		int min = (DateUtil.getCalendar()).get(Calendar.MINUTE);
		if(min <= 9)
			return "0"+min;
		else 
			return ""+min;
	}
	/**
	* 현재초를 ss 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	ss
	*/	
	public static String getSecond(){
		int sec = (DateUtil.getCalendar()).get(Calendar.SECOND);
		if(sec <= 9)
			return "0"+sec;
		else 
			return ""+sec;
	}
	/**
	* 현재년월을 yyyymm 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	yyyymm
	*/	
	public static String getYearMonth(){
		return getYear()+getMonth();
	}	
	/**
	* 현재년월을 yyyy-mm 형식으로 얻어온다.
	* 
	* @param	delim	구분자
	* @return	String	yyyy-mm (구분자가 "-" 일경우)
	*/	
	public static String getYearMonth(String delim){
		return add(getYearMonth(),delim);
	}	
	/**
	* 현재시간을 yyyymmdd 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	yyyymmdd
	*/	
	public static String getShortDate(){
		//return (DateUtil.getYear()+DateUtil.getMonth()+DateUtil.getDay()).trim();
		return getYear()+getMonth()+getDay();
	}
	/**
	* 현재시간을 yyyy-mm-dd 형식으로 구분자를 넣어서 얻어온다.
	* 
	* @param	delim	구분자
	* @return	String	yyyy-mm-dd (구분자가 "-" 일경우)
	*/	
	public static String getShortDate(String delim){
		return add(getShortDate(),delim);
	}
	/**
	* 현재시간을 yyyymmddhhmmss 형식으로 얻어온다.
	* 
	* @param	void
	* @return	String	yyyymmddhhmmss
	*/	
	public static String getLongDate(){		
		//return (DateUtil.getYear()+DateUtil.getMonth()+DateUtil.getDay()
		//			+DateUtil.getHour()+DateUtil.getMinute()+DateUtil.getSecond()).trim();
		return getYear()+getMonth()+getDay()+getHour()+getMinute()+getSecond();
	}
	/**
	 * 유효날짜인지를 체크하는 메서드
	 * 
	 * @param	date	유효날짜인지를 체크하기 위한 파라미터(yyyy or yyyymm or yyyymmdd)
	 * @return	boolean	true : 유효날짜, false : 유효날짜아님
	 */
	public static boolean isDate(String date){
		if(date == null || date.trim().length() == 0 || date.trim().length() >= 9) 
			return false;
		
		int size = date.trim().length();
		
		if(size != 4 && size != 6 && size != 8)
			return false;
		// 모두 숫자인지를 먼저 체크한다.
		for(int i=0 ; i < size ; i++){
			char temp = date.charAt(i);	
			
			if(temp >= '0' && temp <= '9'){
				continue;
			}else{
				return false;
			}			
		}
		// yyyymm 일경우 
		if(size == 6){			
			String month = date.substring(4);
			int mon = Integer.parseInt(month);
			
			if(mon > 12)
				return false;
		// yyyymmdd 일경우
		}else if(size == 8){
			String year = date.substring(0,4);
			String month = date.substring(4,6);
			String day = date.substring(6);
			
			int yy = Integer.parseInt(year);
			int mon = Integer.parseInt(month);
			int today = Integer.parseInt(day);
			
			if(mon > 12 || mon == 0 )
				return false;
			// 31일인달
			if((mon == 1 || mon == 3 || mon == 5 || mon == 7 || mon == 8 || mon == 10 || mon == 12) && (today > 31))
				return false;
			// 30일인달
			else if((mon == 4 || mon == 6 || mon == 9 || mon == 11) && (today > 30))
				return false;
			else if(mon == 2){
				// 윤달일 경우 29일, 평달인 경우 28일
				if(((yy%4 == 0)&&(yy%100 != 0)) || (yy%400 == 0)){
					if(today > 29)	
						return false;
				}else{
					if(today > 28)
						return false;
				}				
			}
		}
		return true;
	}
	/**
	* 넘겨받은 두 날짜를 유효한 날짜인지를 체크한 다음 두개를 비교해서 
	* 앞의것이 크거나 같으면 true, 작으면 false 반환
	* 
	* @param	fir		날짜
	* @param	sec		날짜
	* @return	boolean	fir >= sec : true, fir < sec : false
	*/		
	public static boolean compareDate(String fir, String sec){
		if(isDate(fir) && isDate(sec))
			return (fir.compareTo(sec) >= 0) ? true : false;
		else
			return false;
	}
	/*************************************************************************************************
	 *################################################################################################
	 * 아래는 최진우 대리가 작성한것임
	 */
	/**
	* 넘겨온 날짜와 구분자를 가지고 날짜의 중간에 구분자를 삽입한다.
	* 
	* @param	str		날짜
	* @param	delim	구분자
	* @return	String	날짜에 구분자를 삽입한 문자열
	*/		
	public static String add(String str,String delim){ 
		if(!isDate(str)){
			return str;
		}
		if(delim==null||delim.equals("")){
			return str;
		}		
						
		StringBuffer sb = new StringBuffer();
		
		if(str.length()==8){
			sb.append(str.substring(0,4));
			sb.append(delim);
			sb.append(str.substring(4,6));
			sb.append(delim);						
			sb.append(str.substring(6,8));						
		}else if(str.length()==6){
			sb.append(str.substring(0,4));
			sb.append(delim);						
			sb.append(str.substring(4,6));						
		}else if(str.length()==4){
			sb.append(str.substring(0,2));
			sb.append(delim);										
			sb.append(str.substring(2,4));				
		}else{
			return str;
		}
		
		return sb.toString();
	}
	/**
	* 날짜를 한국형 (2002년 04월 19일)으로 바꾸고 싶을때 사용	
	* 
	* @param	str		변경하고 싶은 날짜
	* @return	String	한국형 날짜로 변경된 문자열
	*/	
	public static String toKoreanLocale(String str){
			return convertDateFormat(str);
	}
	/**
	* 날짜를 한국형 (2002년 04월 19일)으로 바꾸고 싶을때 사용한다. 
	* toKoreanLocale을 이용
	* 
	* @param	str		변경하고 싶은 날짜
	* @return	String	한국형 날짜로 변경된 문자열
	*/	
	private static String convertDateFormat(String str){
		if(!isDate(str)){
			return str;
		}					
		StringBuffer sb = new StringBuffer();
		
		if( str.length() == 8 ){
			sb.append(str.substring(0,4));
			sb.append("년 ");
			sb.append(removeZero2(str.substring(4,6)));
			sb.append("월 ");
			sb.append(removeZero2(str.substring(6,8)));	
			sb.append("일");	
		}else if( str.length() == 6 ){
			sb.append(str.substring(0,4));
			sb.append("년 ");
			sb.append(removeZero2(str.substring(4,6)));
			sb.append("월");
		}else if( str.length() == 4 ){
			sb.append(str.substring(0,4));
			sb.append("년");
		}else{
			return str;
		}		
		return sb.toString();		
	}
	/**
	* 앞자리의 '0' 을 제거한다.
	* 
	* @param	s		'0'을 제거할 문자열
	* @return	String	'0'을 제거한 문자열
	*/	
	private static String removeZero1(String s){
		if( s.substring(0,1).equals("0") ) 
			return s.substring(1,2);
		else 
			return s;
	}
	/**
	* 앞자리의 '0' 을 제거한다.
	* 
	* @param	s		'0'을 제거할 문자열
	* @return	String	'0'을 제거한 문자열
	*/	
	private static String removeZero2(String s){
		if( s.substring(0,1).equals("0") ) 
			return "&nbsp;&nbsp;"+s.substring(1,2);
		else 
			return s;
	}
	/**
	* 특정날짜 나 시간에서 구분자를 삭제한다.
	* 
	* @param	str		삭제할 날짜나 시간
	* @param	delim	삭제할 구분자
	* @return	String	구분자를 삭제한 문자열
	*/	
	public static String delete(String str,String delim){			
		if(!isDate(str)){
			return str;
		}		
		if(delim==null||delim.equals("")){
			return str;
		}				
		StringBuffer sb = new StringBuffer();
		
		StringTokenizer st = new StringTokenizer(str,delim);
		while (st.hasMoreTokens()){
				sb.append(st.nextToken());
		}
		
		return sb.toString();
	}
	/**
	* 현재시간을 yyyymmdd 형식으로 얻어온다.
	* 
	* getShortDate()이용 : Deprecated
	* @param	void
	* @return	String	yyyymmdd
	*/	
	public static String getSystemDate(){
		/*
		Locale.setDefault(Locale.KOREA);
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String str =sdf.format( date );
		return str.substring(0,8);
		*/
		return getShortDate();
	}
	/**
	* 현재시간을 yyyy-mm-dd 형식으로 얻어올때 구분자를 집어넣는다. 
	* getShortDate(delim)이용 : Deprecated
	* 
	* @param	delim	구분자
	* @return	String	yyyy-mm-dd (구분자가 "-" 일경우)
	*/	
	public static String getSystemDate(String delim){
		return add(getLongDate(),delim);			
	}
	/**
	* 현재년도를 yyyy형식으로 얻어온다. 
	* getYear()이용 : Deprecated
	* 
	* @param	void
	* @return	String	현재년도
	*/
	public static String getSystemYear(){
		/*
		Locale.setDefault(Locale.KOREA);
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String str =sdf.format( date );
		return str.substring(0,4);
		*/
		return getYear();
	}
		
	/**
	* 현재 월을 mm형식으로 얻어온다. 
	* getMonth()이용 : Deprecated
	* 
	* @param	void
	* @return	String	현재월
	*/
	public static String getSystemMonth(){
		/*
		Locale.setDefault(Locale.KOREA);
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String str =sdf.format( date );
		return str.substring(4,6);
		*/
		return getMonth();
	}
		
	/**
	* 현재 일을 dd형식으로 얻어온다. 
	* getDay()이용 : Deprecated
	* 
	* @param	void
	* @return	String	현재일
	*/
	public static String getSystemDay(){
		/*
		Locale.setDefault(Locale.KOREA);
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String str =sdf.format( date );
		return str.substring(6,8);
		*/
		return getDay();
	}
		
	/**
	* 현재년도와 달을 yyyymm 형식으로 얻어온다. 
	* getYearMonth()이용 : Deprecated
	* 
	* @param	void
	* @return	String	현재년도와 월
	*/	
	public static String getSystemYearMonth(){
		/*
		Locale.setDefault(Locale.KOREA);
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String str =sdf.format( date );
		return str.substring(0,6);
		*/
		return getYearMonth();
	}
	
	/**
	* 현재년도와 달을 yyyymm 형식으로 얻어올때 구분자를 집어넣는다. 
	* getYearMonth(delim)이용 : Deprecated
	* 
	* @param	delim	구분자
	* @return	String	현재년도와 월 (yyyy-mm :구분자가 "-" 일때)
	*/	
	public static String getSystemYearMonth(String delim){
		return add(getYearMonth(),delim);
	}
	/**
	* 현재날짜에서 앞뒤로 가감한 날짜를 yyyymmdd 형식으로 구해온다.
	* 
	* @param	month	가감할 개월수( + : 더한 날짜, - : 뺀 날짜)
	* @param	day		가감할 일수  ( + : 더한 날짜, - : 뺀 날짜)
	* @return	String	현재날짜에서 가감한 날짜
	*/	
	public static String getConvertDate(int month,int day){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar now= Calendar.getInstance();	

		now.add(Calendar.MONTH, month);
		now.add(Calendar.DATE, day);

		String str = sdf.format(now.getTime());	
		return str.substring(0,8);
	
	}
	/**
	* 특정날짜에서 앞뒤로 가감한 날짜를 yyyymmdd 형식으로 구해온다.
	* 
	* @param	time	가감할 특정날짜
	* @param	month	가감할 개월수( + : 더한 날짜, - : 뺀 날짜)
	* @param	day		가감할 일수  ( + : 더한 날짜, - : 뺀 날짜)
	* @return	String	현재날짜에서 가감한 날짜
	*/	
	public static String getConvertDate(String time,int month,int day){
		if(!isDate(time)){
			return time;
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar now = convert(time);

		now.add(Calendar.MONTH, month);			
		now.add(Calendar.DATE, day);
															
		String str = sdf.format(now.getTime());	
		return str.substring(0,8);		
	}
	/**
	* 날짜사이의 기간을 알아오는 메서드
	* 순서는 상관이 없으며, 200204 또는 20020419 처럼 월까지만 넣던지
	* 일까지 넣던지 한다.
	* 
	* @param	param1	날짜 (yyyymmdd or yyyymm)
	* @param	param2	날짜 (yyyymmdd or yyyymm)
	* @return	String	특정날짜의 마지막날
	*/	
	public static int getPeriod(String param1,String param2){			
		if (!isDate(param1)||!isDate(param2)){
			return -1;
		}
			
		String start = null;
		String end = null;
		
		if(Integer.parseInt(param1)>Integer.parseInt(param2)){
			start = param2;
			end = param1;
		}else{
			start = param1;
			end = param2;
		}
		
		if(start.length()==8&&end.length()==8){
			Date start_date= convert(start).getTime();
			Date end_date= convert(end).getTime();

			long temp = end_date.getTime() - start_date.getTime();
			int period = (int)(temp/(1000*3600*24))+1;

			return period;
		}else if(start.length()==6&&end.length()==6){
			int start_year = Integer.parseInt(start.substring(0,4));
			int start_month = Integer.parseInt(start.substring(4,6));
			
			int end_year = Integer.parseInt(end.substring(0,4));
			int end_month = Integer.parseInt(end.substring(4,6));
			
			int year = end_year - start_year;
			int month = end_month - start_month;
		
			return year*12+month;				
		}else{
			return -1;
		}			
	}
	/**
	* 날짜를 Calendar class 타입으로 변경한다.
	* 
	* @param	time		날짜
	* @return	Calendar	입력된 날짜 정보를 가지고 있는 Calendar 객체
	*/	
	private static Calendar convert(String time){	
		if(time==null||time.equals("")){
			return null;
		}		
		Calendar now= Calendar.getInstance();
		if(time.length()==8){
			int y = Integer.parseInt(time.substring(0,4));
			int m = Integer.parseInt(time.substring(4,6))-1;
			int d = Integer.parseInt(time.substring(6,8));				
		
			now.set(y,m,d);			
		}else if(time.length()==6){
			int y = Integer.parseInt(time.substring(0,4));
			int m = Integer.parseInt(time.substring(4,6))-1;
		
			now.set(y,m,1);			
		}else{
			return null;
		}		
		return now;
	}
	
	
	private static String kk[] = {
		"1212122322121", // 1881
		"1212121221220",
		"1121121222120",
		"2112132122122",
		"2112112121220",
		"2121211212120",
		"2212321121212",
		"2122121121210",
		"2122121212120",
		"1232122121212",
		"1212121221220", // 1891
		"1121123221222",
		"1121121212220",
		"1212112121220",
		"2121231212121",
		"2221211212120",
		"1221212121210",
		"2123221212121",
		"2121212212120",
		"1211212232212",
		"1211212122210", // 1901
		"2121121212220",
		"1212132112212",
		"2212112112210",
		"2212211212120",
		"1221412121212",
		"1212122121210",
		"2112212122120",
		"1231212122212",
		"1211212122210",
		"2121123122122", // 1911
		"2121121122120",
		"2212112112120",
		"2212231212112",
		"2122121212120",
		"1212122121210",
		"2132122122121",
		"2112121222120",
		"1211212322122",
		"1211211221220",
		"2121121121220", // 1921
		"2122132112122",
		"1221212121120",
		"2121221212110",
		"2122321221212",
		"1121212212210",
		"2112121221220",
		"1231211221222",
		"1211211212220",
		"1221123121221",
		"2221121121210", // 1931
		"2221212112120",
		"1221241212112",
		"1212212212120",
		"1121212212210",
		"2114121212221",
		"2112112122210",
		"2211211412212",
		"2211211212120",
		"2212121121210",
		"2212214112121", // 1941
		"2122122121120",
		"1212122122120",
		"1121412122122",
		"1121121222120",
		"2112112122120",
		"2231211212122",
		"2121211212120",
		"2212121321212",
		"2122121121210",
		"2122121212120", //1951
		"1212142121212",
		"1211221221220",
		"1121121221220",
		"2114112121222",
		"1212112121220",
		"2121211232122",
		"1221211212120",
		"1221212121210",
		"2121223212121",
		"2121212212120", // 1961
		"1211212212210",
		"2121321212221",
		"2121121212220",
		"1212112112210",
		"2223211211221",
		"2212211212120",
		"1221212321212",
		"1212122121210",
		"2112212122120",
		"1211232122212", // 1971
		"1211212122210",
		"2121121122210",
		"2212312112212",
		"2212112112120",
		"2212121232112",
		"2122121212110",
		"2212122121210",
		"2112124122121",
		"2112121221220",
		"1211211221220", // 1981
		"2121321122122",
		"2121121121220",
		"2122112112322",
		"1221212112120",
		"1221221212110",
		"2122123221212",
		"1121212212210",
		"2112121221220",
		"1211231212222",
		"1211211212220", // 1991
		"1221121121220",
		"1223212112121",
		"2221212112120",
		"1221221232112",
		"1212212122120",
		"1121212212210",
		"2112132212221",
		"2112112122210",
		"2211211212210",
		"2221321121212", //2001
		"2212121121210",
		"2212212112120",
		"1232212122112",
		"1212122122120",
		"1121212322122",
		"1121121222120",
		"2112112122120",
		"2211231212122",
		"2121211212120",
		"2122121121210", // 2011
		"2124212112121",
		"2122121212120",
		"1212121223212",
		"1211212221220",
		"1121121221220",
		"2112132121222",
		"1212112121220",
		"2121211212120",
		"2122321121212",
		"1221212121210", // 2021
		"2121221212120",
		"1232121221212",
		"1211212212210",
		"2121123212221",
		"2121121212220",
		"1212112112220",
		"1221231211221",
		"2212211211220",
		"1212212121210",
		"2123212212121", // 2031
		"2112122122120",
		"1211212322212",
		"1211212122210",
		"2121121122120",
		"2212114112122",
		"2212112112120",
		"2212121211210",
		"2212232121211",
		"2122122121210",
		"2112122122120", // 2041
		"1231212122212",
		"1211211221220" 
	};

	private static int dt[] = {
		384, 355, 354, 384, 354, 354, 384, 354, 355, 384,
		355, 384, 354, 354, 383, 355, 354, 384, 355, 384,
		354, 355, 383, 354, 355, 384, 354, 355, 384, 354,
		384, 354, 354, 384, 355, 354, 384, 355, 384, 354,
		354, 384, 354, 354, 385, 354, 355, 384, 354, 383,
		354, 355, 384, 355, 354, 384, 354, 384, 354, 354,
		384, 355, 355, 384, 354, 354, 384, 354, 384, 354,
		355, 384, 355, 354, 384, 354, 384, 354, 354, 384,
		355, 354, 384, 355, 353, 384, 355, 384, 354, 355,
		384, 354, 354, 384, 354, 384, 354, 355, 384, 355,
		354, 384, 354, 384, 354, 354, 385, 354, 355, 384,
		354, 354, 383, 355, 384, 355, 354, 384, 354, 354,
		384, 354, 355, 384, 355, 384, 354, 354, 384, 354,
		354, 384, 355, 384, 355, 354, 384, 354, 354, 384,
		354, 355, 384, 354, 384, 355, 354, 383, 355, 354,
		384, 355, 384, 354, 354, 384, 354, 354, 384, 355,
		355, 384, 354
	};
	
	private static int day_array[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

	public static String SolToLun(String solarDate) {
		int total_day;
		int acc_day;
		int buff_day;
		int LunYear;
		int LunMonth;
		int LunDay;
		int SolYear;    
		int SolMonth;   
		int SolDay;    		 
		int i;          
		int j;          
		int m0;         
		int m1;         
		int m2;         
		int temp;       
		boolean isLeap; 
		String str;     
		                
		int yy;         
		int n2;         
		int mm;         
		int r;          

		if(!isDate(solarDate))	return solarDate;  
		
		SolYear = Integer.parseInt(solarDate.substring(0,4));
		SolMonth   = Integer.parseInt(solarDate.substring(4,6));
		SolDay   = Integer.parseInt(solarDate.substring(6,8));
	  
		if((SolYear < 1881) || (SolYear > 2043)) return solarDate; //1881~2043사이의 년도만 사용가능";
		
		//if((SolMonth < 1) || (SolMonth > 12)) throw new Exception ("년도가 유효하지 않습니다.");
		//if((SolDay < 1) || (SolDay > 31)) throw new Exception ("년도가 유효하지 않습니다.");
		
		//total days
		SolYear--;
		total_day = SolYear*365 + SolYear/4 - SolYear/100 + SolYear/400;
		SolYear++;
    
		if(((SolYear % 4) == 0) && ((SolYear % 100) != 0) || ((SolYear % 400) == 0)) day_array[1] = 29;
		else day_array[1] = 28;
    
		for(i = 0; i < SolMonth-1; i++) total_day = total_day + day_array[i];
		total_day = total_day + SolDay;
    
		//total days until 1880
		acc_day = total_day - 686686 + 1;
    
		//Get Lunar Year
		buff_day = dt[0];
		for(i = 0; i <= 162; i++) {
			if(acc_day <= buff_day) break;
			buff_day = buff_day + dt[i+1];
		}
		LunYear = i + 1881;

		//Get Lunar Month
		buff_day = buff_day - dt[i];
		acc_day  = acc_day - buff_day;
		
		if(!kk[i].substring(12,13).equals("0")) temp = 13;
		else temp = 12;

		m2 = 0;
		for(j = 0; j < temp-1; j++) {
			if(Integer.parseInt(kk[i].substring(j,j+1)) <= 2) {
				m2++;
				m1 = Integer.parseInt(kk[i].substring(j,j+1)) + 28;
			} else {
				m1 = Integer.parseInt(kk[i].substring(j,j+1)) + 26;
			}
			if(acc_day <= m1) break;
			acc_day = acc_day - m1;
		}
		m0 = j;
		LunMonth = m2;

		//Get Lunar Day
		LunDay = acc_day;

		if((kk[LunYear - 1881].substring(12,13) != "0") && (Integer.parseInt(kk[LunYear - 1881].substring(m0,m0+1)) > 2))
			isLeap = true;
		else
			isLeap = false;

		//return date string
		str = Integer.toString(LunYear);
		if(LunMonth < 10) str += "0"+LunMonth;
		else str += LunMonth;

		if(LunDay < 10) str += "0"+LunDay;
		else str += LunDay;
		//if(isLeap == true) str += "(윤달)";
		return str;
	}
	
	public static String LunToSol(String lunarDate) {

		int total_day;  
		int acc_day;    
		int buff_day;   
		int SolYear;
		int SolMonth;
		int SolDay;
		int LunYear;		
		int LunMonth;
		int LunDay;
		int i;          
		int j;          
		int m0;         
		int m1;         
		int m2;         
		int temp;       
		boolean isLeap; 
		String str;     
		                
		int yy;         
		int n2;         
		int mm;         
		int r;          

		if(!isDate(lunarDate))	return lunarDate; //일자가 유효하지 않습니다.
		
		LunYear = Integer.parseInt(lunarDate.substring(0,4));
		LunMonth   = Integer.parseInt(lunarDate.substring(4,6));
		LunDay   = Integer.parseInt(lunarDate.substring(6,8));
		
		if((LunYear < 1881) || (LunYear > 2043)) return lunarDate; //1881~2043사이의 년도만 사용할 수 있습니다.
//		if((LunMonth < 1) || (LunMonth > 12)) throw new Exception ("년도가 유효하지 않습니다.");
//		if((LunDay < 1) || (LunDay > 31)) throw new Exception ("년도가 유효하지 않습니다.");
		
		if(LunYear%4 == 0 && LunYear%100>0 && LunYear%400==0) isLeap = true;
		else isLeap = false;
		
		yy = -1;
		acc_day = 0;
		if(LunYear != 1881) {
			yy = LunYear - 1882;
			for(i = 0; i <= yy; i++) {
				for(j = 0; j <= 12; j++) 
					acc_day = acc_day + Integer.parseInt(kk[i].substring(j,j+1));
				if(kk[i].substring(12,13).equals("0")) acc_day = acc_day + 336;
				else acc_day = acc_day + 362;
			}
		}

		yy++;
		n2 = LunMonth - 1;
		mm = -1;

		r = 2;
		while(r != 1) {
			mm++;
			if(Integer.parseInt(kk[yy].substring(mm,mm+1)) > 2) {
				acc_day = acc_day + 26 + Integer.parseInt(kk[yy].substring(mm,mm+1));
				n2++;
			} else {
				if(mm == n2) break;
				else acc_day = acc_day + 28 + Integer.parseInt(kk[yy].substring(mm,mm+1));
			}
		}

		// Leap Year
		if(isLeap == true) acc_day = acc_day + 28 + Integer.parseInt(kk[yy].substring(mm,mm+1));
		acc_day = acc_day + LunDay + 29;
		yy = 1880;
		r = 2;
		while(r != 1) {
			yy++;
			mm = 365;
			if((yy % 4) == 0 && ((yy % 100) != 0 || (yy % 400) == 0)) mm = 366;
			if(acc_day <= mm) break;
			acc_day = acc_day - mm;
		}
		SolYear = yy;
		day_array[1] = mm - 337;
		yy = 0;

		r = 2;
		while(r != 1) {
			yy++;
			if(acc_day <= day_array[yy-1]) break;
			acc_day = acc_day - day_array[yy-1];
		}

		SolMonth = yy;
		SolDay = acc_day;

		//return date string
		str = Integer.toString(SolYear);

		if(SolMonth < 10) str += "0" + Integer.toString(SolMonth);
		else str += Integer.toString(SolMonth);

		if(SolDay < 10) str += "0" + Integer.toString(SolDay);
		else str += Integer.toString(SolDay);

		return str;
	}	

	/**
	* get default date format : yyyyMMdd, yyyy-MM-dd HH:mm:ss
	* 
	* @return String
	*/
	public static String getDefaultFormat()
	{
		//return BasePropManager.getBaseProperties("Environment").getString("date.formatter", DEFAULT_DATE_FORMAT);
		return "test";
	}

	/**
	* get default time zone ID (System Properties)
	* 
	* @return String
	*/
	public static String getTimeZoneID()
	{
		return ( TimeZone.getDefault() ).getID();
	}

	/**
	* get default raw off set (System Properties)
	* 
	* @return String
	*/
	public static int getRawOffSet()
	{
		return ( TimeZone.getDefault() ).getRawOffset();
	}

	/**
	* get default SimpleTimeZone (System Properties)
	* 
	* @return SimpleTimeZone
	*/
	public static TimeZone getTimeZone()
	{
		return TimeZone.getDefault();
	}

	/**
	* get system time with a default date format
	* 
	* @return String
	*/
	public static String getCurrentTime()
	{
		return getCurrentTime(   getDefaultFormat()   );
	}

	/**
	* get system time with a formatter
	* 
	* @param String formatter : yyyyMMdd....
	* @return String
	*/
	public static String getCurrentTime(String formatter)
	{
		SimpleDateFormat fmt = new SimpleDateFormat(formatter);
		fmt.setTimeZone( getTimeZone() );

		return fmt.format(new java.util.Date( System.currentTimeMillis() ));
	}

	/**
	* get system date
	* 
	* @return java.util.Date
	*/
	public static java.util.Date getCurrentDate()
	{
		return new java.util.Date( System.currentTimeMillis() );
	}

	/**
	* yyyyMMddHHmmss --> java.util.Date
	* 
	* @param String dt
	* @return java.util.Date
	*/
	private static java.util.Date getDate(String dt)
	{
		Calendar cal = Calendar.getInstance();
		cal.set(
			Integer.valueOf( dt.substring(0,4) ).intValue(),
			Integer.valueOf( dt.substring(4,6) ).intValue() - 1,
			Integer.valueOf( dt.substring(6,8) ).intValue(),
			Integer.valueOf( dt.substring(8,10) ).intValue(),
			Integer.valueOf( dt.substring(10,12) ).intValue(),
			Integer.valueOf( dt.substring(12,14) ).intValue()
		);

		return cal.getTime();
	}

	/**
	* add date
	* 
	* @ param String (yyyyMMdd or yyyyMMddHHmmss)
	* @ param int
	* @ return String (yyyyMMddHHmmss)
	*/
	public static String addDay(String dt, long day)
	{
		if (dt == null)
			throw new IllegalArgumentException("dt can not be null");

		if ( dt.length() < 14 )
			dt += DEFAULT_DATE_LEN.substring(0, 14 - dt.length() );

/*			throw new IllegalArgumentException(
				"dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);

		if (len == 8) dt += "090000";
*/
		return addDay( getDate(dt), day );
	}

	/**
	* add date
	* 
	* @ param java.Util.Date
	* @ param int
	* @ return String (yyyyMMddHHmmss)
	*/
	public static String addDay(java.util.Date dt, long day)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		sdf.setTimeZone(   getTimeZone()  );

		return sdf.format( addDate(dt, day) );
	}

	/**
	* add date
	* 
	* @ param String (yyyyMMdd or yyyyMMddHHmmss)
	* @ param int
	* @ return java.Util.Date
	*/
	public static java.util.Date addDate(String dt, long day)
	{
		if (dt == null)
			throw new IllegalArgumentException("dt can not be null");

		if ( dt.length() <= 14 )
			dt += DEFAULT_DATE_LEN.substring(0, 14 - dt.length() );

/*
			throw new IllegalArgumentException(
				"dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);

		if (len == 8) dt += "090000";
*/
		return addDate(getDate(dt), day);
	}

	/**
	* add date
	* 
	* @ param java.Util.Date
	* @ param long
	* @ return java.Util.Date
	*/
	public static java.util.Date addDate(java.util.Date dt, long day)
	{
		return new java.util.Date(
			dt.getTime() + (MILLIS_PER_HOUR * 24L * day)
		);
	}

	/**
	* between date
	* 
	* @param String from (yyyyMMdd or yyyyMMddHHmmss)
	* @param String to (yyyyMMdd or yyyyMMddHHmmss)
	* @return int
	*/
	public static long betweenDate(String from, String to)
	{
		if (from == null)
			throw new IllegalArgumentException("from can not be null");
		if (to == null)
			throw new IllegalArgumentException("to can not be null");

		if ( from.length() < 14 )
			from += DEFAULT_DATE_LEN.substring(0, 14 - from.length() );
/*
			throw new IllegalArgumentException(
				"from length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);

		if (len == 8) from += "090000";
*/
		if ( to.length() < 14  )
			to += DEFAULT_DATE_LEN.substring(0, 14 - to.length() );
/*
			throw new IllegalArgumentException(
				"to length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);

		if (len == 8) to += "090000";
*/
		return betweenDate( getDate(from), getDate(to) );
	}

	/**
	* between date
	* 
	* @param java.util.Date from
	* @param java.util.Date to
	* @return int
	*/
	public static long betweenDate(java.util.Date from, java.util.Date to)
	{
		return new Double(
			Math.ceil(
				(to.getTime() - from.getTime()) / (MILLIS_PER_HOUR*24f)
			)
		).longValue();
	}

	/** 
	* between hour
	* 
	* @param String from (yyyyMMdd or yyyyMMddHHmmss)
	* @param String to (yyyyMMdd or yyyyMMddHHmmss)
	* @return int
	*/
	
	//add ekchoi (2001.10.18)
	public static long betweenHour(String from, String to)
	{
		if (from == null)
			throw new IllegalArgumentException("from can not be null");
		if (to == null)
			throw new IllegalArgumentException("to can not be null");

		if ( from.length() < 14 )
			from += DEFAULT_DATE_LEN.substring(0, 14 - from.length() );

		if ( to.length() < 14  )
			to += DEFAULT_DATE_LEN.substring(0, 14 - to.length() );

		return betweenHour( getDate(from), getDate(to) );
		
	}

	/**
	* between hour
	* 
	* @param java.util.Date from
	* @param java.util.Date to
	* @return int
	*/
	public static long betweenHour(java.util.Date from, java.util.Date to)
	{
		return new Double(
			Math.ceil(
				(to.getTime() - from.getTime()) / (MILLIS_PER_HOUR)
			)
		).longValue();
	}

	/**
	* conver date format
	* 
	* @param String dt (yyyyMMdd or yyyyMMddHHmmss)
	* @param String formatter (yyyyMMdd.....)
	* @return String
	*/
	public static String convertFormat(String dt, String formatter)
	{
		if ( (dt == null) || dt.trim().length() < 1 || dt.substring(0,4).equals("9999") ) 
			return "";
		
		if ( dt.length() < 14 )
			dt += DEFAULT_DATE_LEN.substring(0, 14 - dt.length() );
/*
			throw new IllegalArgumentException(
				"dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);
		
		if (dt.length() == 8) dt += "090000";
*/
  		 		
		SimpleDateFormat sdf = new SimpleDateFormat(formatter);
		return sdf.format( getDate(dt) );
	}

	/**
	* conver date format
	* 
	* @param java.sql.Date dt
	* @param String formatter (yyyyMMdd.....)
	* @return String
	*/
	public static String convertFormat(java.sql.Date dt, String formatter)
	{
		return convertFormat( (java.util.Date) dt, formatter );
	}

	public static String convertFormat(long dt, String formatter)
	{
		return convertFormat( toUtilDate(dt), formatter );
	}

	/**
	* conver date format
	* 
	* @param java.sql.Timestamp dt
	* @param String formatter (yyyyMMdd.....)
	* @return String
	*/
	public static String converFormat(java.sql.Timestamp dt, String formatter)
	{
		return convertFormat((java.util.Date) dt, formatter);
	}
	/**
	* conver date format
	* 
	* @param java.util.Date dt
	* @param String formatter (yyyyMMdd.....)
	* @return String
	*/
	public static String convertFormat(java.util.Date dt, String formatter)
	{
		SimpleDateFormat sdf = new SimpleDateFormat( formatter );
		return sdf.format(dt);
	}

	/**
	* convert String date (yyyyMMdd or yyyyMMddHHmmss) to java.sql.Date
	* 
	* @param String dt (yyyyMMdd or yyyyMMddHHmmss)
	* @return java.sql.Date
	*/
	public static java.sql.Date toSQLDate(String dt)
	{
		return new java.sql.Date( toUtilDate(dt).getTime() );
	}

	/**
	* convert String date (yyyyMMdd or yyyyMMddHHmmss) to java.util.Date
	* 
	* @param String dt (yyyyMMdd or yyyyMMddHHmmss)
	* @return java.util.Date
	*/
	public static java.util.Date toUtilDate(String dt)
	{
		if (dt == null)
			throw new IllegalArgumentException("dt can not be null");

		if ( dt.length() < 14 )
			dt += DEFAULT_DATE_LEN.substring(0, 14 - dt.length() );
/*
			throw new IllegalArgumentException(
				"dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);

		if (dt.length() == 8) dt += "090000";
*/
		return getDate(dt);
	}

	public static java.util.Date toUtilDate(long dt)
	{
		return new java.util.Date(dt);
	}

	/**
	* convert String date (yyyyMMdd or yyyyMMddHHmmss) to java.sql.Timestamp
	* 
	* @param String dt (yyyyMMdd or yyyyMMddHHmmss)
	* @return java.sql.Timestamp
	*/
	public static java.sql.Timestamp toTimestamp(String dt)
	{
		if (dt == null)
			throw new IllegalArgumentException("dt can not be null");

		if ( dt.length() < 14 )
			dt += DEFAULT_DATE_LEN.substring(0, 14 - dt.length() );
/*
			throw new IllegalArgumentException(
				"dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)"
			);

		if (dt.length() == 8) dt += "090000";
*/
		return new java.sql.Timestamp( toUtilDate(dt).getTime() );
	}

	/**
	* 해당 년도의 윤년여부
	* 
	* @param year yyyy
	* @return true 윤년, false 평년
	*/
	public static boolean isLeapYear(int year)
	{
		return (year%400==0 || year%100!=0 && year%4==0);
	}

	/**
	* 해당 일자 월의 마지말 일자를 얻는다.
	* 
	* @param String dt yyyyMM, yyyyMMdd, yyyyMMddHHmmss
	* @return int 28, 29, 30, 31
	*/
	public static int getLastDay(String dt)
	{
		if ( dt.length() < 6 )
			throw new IllegalArgumentException("date type -- yyyyMM, yyyyMMdd, yyyyMMddHHmmss");
		int year = Integer.parseInt( dt.substring(0,4) );
		int month = Integer.parseInt( dt.substring(4,6) );
		if ( isLeapYear(year) )
			return ( month == 2 ) ? 29 : SOLAR_MONTH_ARRAY[ month-1 ];
		else
			return SOLAR_MONTH_ARRAY[ month-1 ];
	}

	/**
	* 해당 일자 월의 마지말 일자를 얻는다.
	* 
	* @param java.util.Date dt
	* @return int 28, 29, 30, 31
	*/
	public static int getLastDay(java.util.Date dt)
	{
		return getLastDay( convertFormat(dt, "yyyyMM") );
	}

	/**
	* 해당 일자 월의 마지말 일자를 얻는다.
	* 
	* @param java.sql.Date dt
	* @return int 28, 29, 30, 31
	*/
	public static int getLastDay(java.sql.Date dt)
	{
		return getLastDay( convertFormat(dt, "yyyyMM") );
	}

	/**
	* 해당 일자 월의 마지말 일자를 얻는다.
	* 
	* @param java.sql.Timestamp dt
	* @return int 28, 29, 30, 31
	*/
	public static int getLastDay(java.sql.Timestamp dt)
	{
		return getLastDay( convertFormat(dt, "yyyyMM") );
	}

	/**
	* 해당년도의 육갑을 얻는다.
	* 
	* @param year 연도
	* @param flag true 한글육갑, false 한문육갑
	*/
	public static String getSexagenaryCycle(int year, boolean flag)
	{
		return (
			flag
			? TEN_KR_ARRAY[(year+6) % 10]
			: TEN_CH_ARRAY[(year+6) % 10]
			) + (
			flag ?
			ZODIAC_KR_ARRAY[(year-4) % 12]
			: ZODIAC_CH_ARRAY[(year-4) % 12]
		);
	}

	/**
	* 해당연도의 띠를 얻는다.
	* 
	* @param year
	* @return 띠
	*/
	public static String getDDI(int year)
	{
		return ZODIAC_ARRAY[(year-4) % 12];
	}	
	/**
	* compute Date ( plus or minus hour )
	* 
	* @ param java.Util.Date	dt		날짜
	* @ param long				hour 	시간
	* @ param int				check	구분(1:plus, 2:minus)
	* @ return java.Util.Date
	*/
// add : 2001.10.04 (ekchoi) 시간을 더하거나 빼서 날짜를 구함

	public static java.util.Date computeTime(String dt, long hour, int check)
	{
		if (check == 2)
			return new java.util.Date( toUtilDate(dt).getTime() - (MILLIS_PER_HOUR * hour) );
		else
			return new java.util.Date( toUtilDate(dt).getTime() + (MILLIS_PER_HOUR * hour) );
	}

	/**
	* get system time with a formatter
	* 
	* @param String formatter : yyyyMMdd....
	* @return String
	*/
// add : 2001.10.22 (ekchoi) milliseconds 2자리까지 구함
	public static String getCurrentMillis()
	{
		String millis = "";
		SimpleDateFormat fmt = new SimpleDateFormat("S");
		fmt.setTimeZone( getTimeZone() );

		millis = fmt.format(new java.util.Date( System.currentTimeMillis() ));
		if ( millis.length() > 2 ) 
			return millis.substring(0,2);
		else 
			return EJBStringUtil.getData(millis, "00", "00");
	}

	/**
	*  Data를 변환하여 리턴(request.getParameter 등에서 활용)
	* <code>
	* BaseStringUtil.getData(paramStr, defaultStr);<br>
	* </code>
	* @param String paramStr 	  변환할 원래 문자열
	* @param String defaultStr    default Value(String)
	* @return String 변환된 문자열
	*/
	public static String getData(String paramStr, String defaultStr) {
		if (paramStr == null || paramStr.trim().length() == 0)
			return defaultStr;
		else
			return paramStr.trim();
	}

	/**
	*  Data를 변환하여 리턴(request.getParameter 등에서 활용)
	* <code>
	* BaseStringUtil.getData(paramStr, defaultStr, formatStr);<br>
	* </code>
	* @param String paramStr 	  변환할 원래 문자열
	* @param String defaultStr    default Value(String)
	* @param String formatStr     변환시 format적용
	* @return String 변환된 문자열
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
	*  Data를 변환하여 리턴(request.getParameter 등에서 활용)
	* <code>
	* BaseStringUtil.getData(sqlWhere, sqlAdd);<br>
	* </code>
	* @param String paramStr 	  변환할 원래 문자열
	* @param String defaultInt    default Value(int)
	* @return int 변환된 숫자
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
	* 문자열의 총 길이에서 실제 문자열 이후, 나머지 길이 만큼 앞또는 뒤쪽에 지정한 값("0", 또는 space)를 채워 리턴
	* (문자열의 길이를 채워서 보내줘야 할 경우 활용)
	* <code>
	* BaseStringUtil.getData(sqlWhere, sqlAdd);<br>
	* </code>
	* @param String str 	 	실 문자열
	* @param int	strLen    	리턴될 문자열 총길이
	* @param char 	setChar    	채우질 문자
	* @param int	gubun    	채월질 문자가 실문자열의 앞 또는 뒤 (1 : 뒤, 2 : 앞)
	* @return int 총길이를 채운 문자열
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

		// 총길이 만큼만 StringBuffer를 생성
		StringBuffer setStr = new StringBuffer(strLen);
		String result = null;

		try {
			//나머지 만큼 setChar를 채운다.
			for (int i = str.length(); i < strLen; i++) {
				setStr.append(setChar);
			}

			//앞에 채울 경우 //
			if (gubun == 2) {
				result = setStr.append(str).toString();
				//뒤에 붙일 경우 //
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
	* 전화번호 포맷 리턴
	* <code>
	* FdsUtil.getPhoneNo(str);<br>
	* </code>
	* @param  String str    전화번호 전체 문자열
	* @return String 		형식에 맞춘 전화번호
	*/
	public static String getPhoneNo(String str) {
		if (str == null || str.trim().length() == 0)
			return "";
		if (str.trim().length() < 7)
			return str;

		str = str.trim();

		StringBuffer telNo = new StringBuffer();
		StringBuffer pureNo = new StringBuffer();

		// 숫자만 전화번호를 먼저 구성.. //
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
		// 핸드폰 번호 //
		if (pureNo.substring(0, 2).equals("01")) {
			telNo.append(pureNo.substring(0, 3)).append("-");
			telNo.append(pureNo.substring(3, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		// 지역번호 포함 - 서울
		else if (pureNo.substring(0, 2).equals("02")) {
			telNo.append(pureNo.substring(0, 2)).append("-");
			telNo.append(pureNo.substring(2, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		// 지역번호 포함
		else if (pureNo.substring(0, 1).equals("0")) {
			telNo.append(pureNo.substring(0, 3)).append("-");
			telNo.append(pureNo.substring(3, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		// 지역번호 없음
		else {
			telNo.append(pureNo.substring(0, pureNo.length() - 4)).append("-");
			telNo.append(pureNo.substring(pureNo.length() - 4));
		}
		return String.valueOf(telNo);
	}

	/**
	* 전화번호 리턴
	* <code>
	* FdsUtil.getTelNo(str);<br>
	* </code>
	* @param  String str    전화번호 전체 문자열
	* @return String 		순수 전화번호만 리턴
	*/
	public static String getPhoneNo1(String str) {
		if (str == null || str.trim().length() == 0)
			return "";
		if (str.trim().length() < 7)
			return str;

		str = str.trim();

		StringBuffer pureNo = new StringBuffer();

		// 숫자만 전화번호를 먼저 구성.. //
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
	* 해당 문자열에서 특정 문자열을 대체한다.
	* @param str  		전체문자열
	* @param insteadStr	찾는 문자열
	* @param changeStr	대체 문자열
	* @return String
	*/
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
	* 해당 문자열에서 특정 문자를 대체한다.
	* @param str  		전체문자열
	* @param insteadChar찾는 문자
	* @param changeChar	대체 문자
	* @return String
	*/
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
	* 대문자로 변경하는 메서드
	* @param  str  		전체문자열
	* @return String	대문자로 변경된 문자열
	*/
	public static String upperString(String str) {
		return str.toUpperCase();
	}
	/**
	 * 소문자로 변경하는 메서드
	 *
	 * @param str  		전체문자열
	 * @return String	소문자로 변경된 문자열
	 */
	public static String lowerString(String str) {
		return str.toLowerCase();
	}
	/**
	* 특정 문자열이 포함되어 있는지 체크하는 메서드
	* @param	target		전체문자열
	* @param	tokenStr	체크할 특정 문자열
	* @return	boolean		true : 포함, false : 포함하지 않음
	*/
	public static boolean isContains(String target, String tokenStr) {
		return (target.indexOf(tokenStr) != -1) ? true : false;
	}
	/**
	* 특정 문자열이 몇개 포함되어 있는지 체크하는 메서드
	* @param	target		전체문자열
	* @param	tokenStr	체크할 특정 문자열
	* @return	int			특정 문자열 포함 횟수
	*/
	public static int getOccurTimes(String target, String tokenStr) {
		int count = 0;
		int tokenStr_size = tokenStr.length();
		int sPos = 0;
		int ePos = 0;

		for (int i = 0; i < target.length(); i++) {
			sPos = target.indexOf(tokenStr, ePos);
			if (sPos > 0) {
				/** sPos 는 처음부터 체크 들어간다. */
				ePos = (sPos + tokenStr_size);
				i = ePos;
				count++;
			}
		}
		return count;
	}
	/**
	* 특정 문자열로 시작하는지 체크하는 메서드
	* @param	target		전체문자열
	* @param	tokenStr	체크할 특정 문자열
	* @return	boolean		true : 특정 문자열로 시작, false : 특정 문자열로 시작하지 않음
	*/
	public static boolean isStartWith(String target, String prefix) {
		return target.startsWith(prefix);
	}
	/**
	* 특정 문자열로 종료되는지 체크하는 메서드
	* @param	target		전체문자열
	* @param	tokenStr	체크할 특정 문자열
	* @return	boolean		true : 특정 문자열로 종료, false : 특정 문자열로 종료하지 않음
	*/
	public static boolean isEndWith(String target, String suffix) {
		return target.endsWith(suffix);
	}
	/**
	* 주민등록 번호로 표현하는 메서드('-' 삽입)
	* @param	no		주민등록 번호타입으로 변결할 문자열
	* @return	String	주민등록 번호로 변경된 문자열
	*/
	public static String getJuminNo(String no) {
		if (no.length() != 13)
			return null;

		return (no.substring(0, 6) + "-" + no.substring(6));
	}

	/**
	* 우편번호로 표현하는 메서드('-' 삽입)
	* @param	no			우편번호타입으로 변결할 문자열
	* @return	String		우편번호로 변경된 문자열
	*/
	public static String getZipCode(String no) {
		if (no.trim().length() != 6)
			return null;

		return (no.substring(0, 3) + "-" + no.substring(3));
	}
	/**
	* 주민번호에서 나이를 알아오는 메서드
	* @param	jumin		주민등록번호
	* @return	int			나이
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
	* 주민번호에서 성별을 알아오는 메서드
	* @param	jumin		주민등록번호
	* @return	String		성별 (남자 : Man, 여자 : Woman)
	*/
	public static String getSex(String jumin) {
		int jumin_length = jumin.length();
		char flag = jumin.charAt(jumin_length - 7);

		return (flag == '1') ? "Man" : "Woman";
	}
	/**
	* 주민번호에서 성별을 알아오는 메서드
	* @param	String		법인번호(10자리 숫자)
	* @return	String		법인번호(-가 포함된 형태)
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
/*
	public static void main(String[] args){
		System.out.println(getPeriod("2002001","20020401"));
		System.out.println(betweenDate("20020101","20020401"));
	}
*/

	// 1841 ~ 2043년까지.. 음력 계산용 배열
	static final int[] LUNAR_CNT = {
							1,2,4,1,1,2,1,2,1,2,2,1,
							2,2,1,2,1,1,2,1,2,1,2,1,
							2,2,2,1,2,1,4,1,2,1,2,1,
							2,2,1,2,1,2,1,2,1,2,1,2,
							1,2,1,2,2,1,2,1,2,1,2,1,
							2,1,2,1,5,2,1,2,2,1,2,1,
							2,1,1,2,1,2,1,2,2,2,1,2,
							1,2,1,1,2,1,2,1,2,2,2,1,
							2,1,2,3,2,1,2,1,2,1,2,2,
							2,1,2,1,1,2,1,1,2,2,1,2,
							2,2,1,2,1,1,2,1,2,1,5,2,
							2,1,2,2,1,1,2,1,2,1,1,2,
							2,1,2,2,1,2,1,2,1,2,1,2,
							1,2,1,2,1,2,5,2,1,2,1,2,
							1,1,2,1,2,2,1,2,2,1,2,1,
							2,1,1,2,1,2,1,2,2,2,1,2,
							1,2,1,1,5,2,1,2,1,2,2,2,
							1,2,1,1,2,1,1,2,2,1,2,2,
							2,1,2,1,1,2,1,1,2,1,2,2,
							2,1,6,1,1,2,1,1,2,1,2,2,
							1,2,2,1,2,1,2,1,2,1,1,2,
							2,1,2,1,2,2,1,2,2,3,1,2,
							1,2,2,1,2,1,2,2,1,2,1,2,
							1,1,2,1,2,1,2,2,1,2,2,1,
							2,1,1,2,4,1,2,2,1,2,2,1,
							2,1,1,2,1,1,2,2,1,2,2,2,
							1,2,1,1,2,1,1,2,1,2,2,2,
							1,2,2,3,2,1,1,2,1,2,2,1,
							2,2,2,1,1,2,1,1,2,1,2,1,
							2,2,2,1,2,1,2,1,1,5,2,1,
							2,2,1,2,2,1,2,1,2,1,1,2,
							1,2,1,2,2,1,2,1,2,2,1,2,
							1,1,2,1,2,4,2,1,2,2,1,2,
							1,1,2,1,2,1,2,1,2,2,2,1,
							2,1,1,2,1,1,2,1,2,2,2,1,
							2,2,1,1,5,1,2,1,2,2,1,2,
							2,2,1,1,2,1,1,2,1,2,1,2,
							2,2,1,2,1,2,1,1,2,1,2,1,
							2,2,4,2,1,2,1,1,2,1,2,1,
							2,1,2,2,1,2,2,1,2,1,1,2,
							1,2,1,2,1,2,5,2,2,1,2,1,
							1,2,1,2,1,2,1,2,2,1,2,2,
							1,1,2,1,1,2,1,2,2,2,1,2,
							2,1,1,2,3,2,1,2,2,1,2,2,
							2,1,1,2,1,1,2,1,2,1,2,2,
							2,1,2,1,2,1,1,2,1,2,1,2,
							2,2,1,5,2,1,1,2,1,2,1,2,
							2,1,2,2,1,2,1,1,2,1,2,1,
							2,1,2,2,1,2,1,2,1,2,1,2,
							1,5,2,1,2,2,1,2,1,2,1,2,
							1,2,1,2,1,2,1,2,2,1,2,2,
							1,1,2,1,1,5,2,2,1,2,2,2,
							1,1,2,1,1,2,1,2,1,2,2,2,
							1,2,1,2,1,1,2,1,2,1,2,2,
							2,1,2,1,5,1,2,1,2,1,2,1,
							2,2,2,1,2,1,1,2,1,2,1,2,
							1,2,2,1,2,1,2,1,2,1,2,1,
							2,1,5,2,2,1,2,1,2,1,2,1,
							2,1,2,1,2,1,2,2,1,2,1,2,
							1,2,1,1,2,1,2,5,2,2,1,2,
							1,2,1,1,2,1,2,1,2,2,2,1,
							2,1,2,1,1,2,1,2,1,2,2,2,
							1,2,1,2,3,2,1,1,2,2,1,2,
							2,2,1,2,1,1,2,1,1,2,2,1,
							2,2,1,2,2,1,1,2,1,2,1,2,
							1,2,2,4,1,2,1,2,1,2,1,2,
							1,2,1,2,1,2,2,1,2,1,2,1,
							2,1,1,2,2,1,2,1,2,2,1,2,
							1,5,1,2,1,2,1,2,2,2,1,2,
							1,2,1,1,2,1,2,1,2,2,2,1,
							2,1,2,1,1,5,1,2,2,1,2,2,
							2,1,2,1,1,2,1,1,2,2,1,2,
							2,2,1,2,1,1,2,1,1,2,1,2,
							2,2,1,2,5,1,2,1,2,1,1,2,
							2,1,2,2,1,2,1,2,1,2,1,2,
							1,2,1,2,1,2,2,1,2,1,2,1,
							2,3,2,1,2,2,1,2,2,1,2,1,
							2,1,1,2,1,2,1,2,2,2,1,2,
							1,2,1,1,2,1,5,2,2,1,2,2,
							1,2,1,1,2,1,1,2,2,1,2,2,
							2,1,2,1,1,2,1,1,2,1,2,2,
							2,1,2,2,3,2,1,1,2,1,2,2,
							1,2,2,1,2,1,2,1,2,1,1,2,
							2,1,2,1,2,2,1,2,1,2,1,1,
							2,1,2,5,2,1,2,2,1,2,1,2,
							1,1,2,1,2,1,2,2,1,2,2,1,
							2,1,1,2,1,2,1,2,2,1,2,2,
							1,5,1,2,1,1,2,2,1,2,2,2,
							1,2,1,1,2,1,1,2,1,2,2,2,
							1,2,2,1,1,5,1,2,1,2,2,1,
							2,2,2,1,1,2,1,1,2,1,2,1,
							2,2,2,1,2,1,2,1,1,2,1,2,
							1,2,2,1,6,1,2,1,2,1,1,2,
							1,2,1,2,2,1,2,2,1,2,1,2,
							1,1,2,1,2,1,2,2,1,2,2,1,
							2,1,4,1,2,1,2,1,2,2,2,1,
							2,1,1,2,1,1,2,1,2,2,2,1,
							2,2,1,1,2,1,4,1,2,2,1,2,
							2,2,1,1,2,1,1,2,1,2,1,2,
							2,2,1,2,1,2,1,1,2,1,2,1,
							2,2,1,2,2,4,1,1,2,1,2,1,
							2,1,2,2,1,2,2,1,2,1,1,2,
							1,2,1,2,1,2,2,1,2,2,1,2,
							1,1,2,4,1,2,1,2,2,1,2,2,
							1,1,2,1,1,2,1,2,2,2,1,2,
							2,1,1,2,1,1,2,1,2,2,1,2,
							2,5,1,2,1,1,2,1,2,1,2,2,
							2,1,2,1,2,1,1,2,1,2,1,2,
							2,2,1,2,1,2,3,2,1,2,1,2,
							2,1,2,2,1,2,1,1,2,1,2,1,
							2,1,2,2,1,2,1,2,1,2,1,2,
							1,2,1,2,4,2,1,2,1,2,1,2,
							1,2,1,1,2,2,1,2,2,1,2,2,
							1,1,2,1,1,2,1,2,2,1,2,2,
							2,1,4,1,1,2,1,2,1,2,2,2,
							1,2,1,2,1,1,2,1,2,1,2,2,
							2,1,2,1,2,1,1,5,2,1,2,2,
							1,2,2,1,2,1,1,2,1,2,1,2,
							1,2,2,1,2,1,2,1,2,1,2,1,
							2,1,2,1,2,5,2,1,2,1,2,1,
							2,1,2,1,2,1,2,2,1,2,1,2,
							1,2,1,1,2,1,2,2,1,2,2,1,
							2,1,2,3,2,1,2,1,2,2,2,1,
							2,1,2,1,1,2,1,2,1,2,2,2,
							1,2,1,2,1,1,2,1,1,2,2,1,
							2,2,5,2,1,1,2,1,1,2,2,1,
							2,2,1,2,2,1,1,2,1,2,1,2,
							1,2,2,1,2,1,5,2,1,2,1,2,
							1,2,1,2,1,2,2,1,2,1,2,1,
							2,1,1,2,2,1,2,1,2,2,1,2,
							1,2,1,1,5,2,1,2,2,2,1,2,
							1,2,1,1,2,1,2,1,2,2,2,1,
							2,1,2,1,1,2,1,1,2,2,2,1,
							2,2,1,5,1,2,1,1,2,2,1,2,
							2,2,1,2,1,1,2,1,1,2,1,2,
							2,2,1,2,1,2,1,5,2,1,1,2,
							2,1,2,2,1,2,1,2,1,2,1,1,
							2,2,1,2,1,2,2,1,2,1,2,1,
							2,1,1,2,1,6,1,2,2,1,2,1,
							2,1,1,2,1,2,1,2,2,1,2,2,
							1,2,1,1,2,1,1,2,2,1,2,2,
							2,1,2,3,2,1,1,2,2,1,2,2,
							2,1,2,1,1,2,1,1,2,1,2,2,
							2,1,2,2,1,1,2,1,1,5,2,2,
							1,2,2,1,2,1,2,1,1,2,1,2,
							1,2,2,1,2,2,1,2,1,2,1,1,
							2,1,2,2,1,5,2,2,1,2,1,2,
							1,1,2,1,2,1,2,2,1,2,2,1,
							2,1,1,2,1,2,1,2,2,1,2,2,
							1,2,1,1,5,1,2,1,2,2,2,2,
							1,2,1,1,2,1,1,2,1,2,2,2,
							1,2,2,1,1,2,1,1,2,1,2,2,
							1,2,5,2,1,2,1,1,2,1,2,1,
							2,2,2,1,2,1,2,1,1,2,1,2,
							1,2,2,1,2,2,1,5,2,1,1,2,
							1,2,1,2,2,1,2,1,2,2,1,2,
							1,1,2,1,2,1,2,2,1,2,2,1,
							2,1,1,2,3,2,2,1,2,2,2,1,
							2,1,1,2,1,1,2,1,2,2,2,1,
							2,2,1,1,2,1,1,2,1,2,2,1,
							2,2,2,3,2,1,1,2,1,2,1,2,
							2,2,1,2,1,2,1,1,2,1,2,1,
							2,2,1,2,2,1,2,1,1,2,1,2,
							1,5,2,2,1,2,1,2,2,1,1,2,
							1,2,1,2,1,2,2,1,2,2,1,2,
							1,1,2,1,2,1,5,2,2,1,2,2,
							1,1,2,1,1,2,1,2,2,2,1,2,
							2,1,1,2,1,1,2,1,2,2,1,2,
							2,2,1,1,5,1,2,1,2,1,2,2,
							2,1,2,1,2,1,1,2,1,2,1,2,
							2,1,2,2,1,2,1,1,2,1,2,1,
							2,1,6,2,1,2,1,1,2,1,2,1,
							2,1,2,2,1,2,1,2,1,2,1,2,
							1,2,1,2,1,2,1,2,5,2,1,2,
							1,2,1,1,2,1,2,2,2,1,2,2,
							1,1,2,1,1,2,1,2,2,1,2,2,
							2,1,1,2,3,2,1,2,1,2,2,2,
							1,2,1,2,1,1,2,1,2,1,2,2,
							2,1,2,1,2,1,1,2,1,2,1,2,
							2,1,2,5,2,1,1,2,1,2,1,2,
							1,2,2,1,2,1,2,1,2,1,2,1,
							2,1,2,1,2,2,1,2,1,2,1,2,
							1,5,2,1,2,1,2,2,1,2,1,2,
							1,2,1,1,2,1,2,2,1,2,2,1,
							2,1,2,1,1,5,2,1,2,2,2,1,
							2,1,2,1,1,2,1,2,1,2,2,2,
							1,2,1,2,1,1,2,1,1,2,2,2,
							1,2,2,1,5,1,2,1,1,2,2,1,
							2,2,1,2,2,1,1,2,1,1,2,2,
							1,2,1,2,2,1,2,1,2,1,2,1,
							2,1,5,2,1,2,2,1,2,1,2,1,
							2,1,1,2,1,2,2,1,2,2,1,2,
							1,2,1,1,2,1,5,2,2,2,1,2,
							1,2,1,1,2,1,2,1,2,2,2,1,
							2,1,2,1,1,2,1,1,2,2,1,2,
							2,2,1,2,1,4,1,1,2,1,2,2,
							2,2,1,2,1,1,2,1,1,2,1,2,
							2,2,1,2,1,2,1,2,1,1,2,1,
							2,2,1,2,5,2,1,2,1,2,1,1,
							2,1,2,2,1,2,2,1,2,1,2,1,
							2,1,1,2,1,2,2,1,2,2,1,2,
							1,5,1,2,1,2,1,2,2,2,1,2,
							1,2,1,1,2,1,1,2,2,1,2,2};

	static final int[] MONTH_DAY_CNT = {31,0,31,30,31,30,31,31,30,31,30,31};

	static final String[] KO_MODE_FORMAT = new String[]{   "yyyy-MM-dd HH:mm:ss",
															"yyyy-MM-dd HH:mm",
															"yyyy-MM-dd",
															"MM-dd"};

	static final String[] EN_MODE_FORMAT = new String[]{   "MMM dd, yyyy HH:mm:ss",
															"MMM dd, yyyy HH:mm",
															"MMM dd, yyyy",
															"MMM dd"};

	/** 양력을 음력으로 변환한다.
	*/
	public static String convertLunarDate(int year, int month, int day)
	{
		// 처리가능 기간  1841 - 2043년
		int TempDate1;					     // 음력일을 계산하기 위해 양력일과의 차이를 저장할 변수
		int TempDate2;					     // 현재까지의 날수
		int TotalDayCnt;				     // 1840년까지의 날수
		int Temp = 0;
		int Temp1 = 0;
		int Temp2 = 0;
		int lYear;				 // 계산된 음력 년, 월, 일을 저장할 변수
		int lMonth;
		int lDay;
		String lsLunarMonth;				 // 현재월이 윤달임을 표시
		String RetValue;
		int i;
		int j;
		boolean Flag = true;
		int[] ArrayTempDate = new int[250];	 // 매년의 음력일수를 저장할 배열 변수(year-1841)

		TotalDayCnt = 672069;    // 672069 = 1840 * 365 + 1840/4 - 1840/100 + 1840/400 + 23

		// 윤달여부를 체크
		if(year % 4 != 0){
			MONTH_DAY_CNT[1] = 28;
		}else if(year % 100 != 0 ){
			MONTH_DAY_CNT[1] = 29;
		}else if(year % 400 != 0){
			MONTH_DAY_CNT[1] = 28;
		}else{
			MONTH_DAY_CNT[1] = 29;
		}

		// 1841년부터 작년까지의 날수
		TempDate2 = (year-1)*365 + (year-1)/4 - (year-1)/100 + (year-1)/400;

		// 전월까지의 날수를 더함
		for(i=0;i<(month-1);i++){
			TempDate2 = TempDate2 + MONTH_DAY_CNT[i];
		}
		// 현재일까지의 날수를 더함
		TempDate2 = TempDate2 + day;

		// 양력현재일과 음력 1840년까지의 날수의 차이
		TempDate1 = TempDate2 - TotalDayCnt + 1;

		// 1841년부터 음력날수를 계산
		for(i=0;i<(year-1840);i++){
			ArrayTempDate[i] = 0;
			for(j=0;j<12;j++){
				switch(LUNAR_CNT[i*12 + j]){
					case 1:
						Temp = 29; break;
					case 2:
						Temp = 30; break;
					case 3:
						Temp = 58; break;
					case 4:
						Temp = 59; break;
					case 5:
						Temp = 59; break;
					case 6:
						Temp = 60; break;
				}
				ArrayTempDate[i] = ArrayTempDate[i] + Temp;
			}
		}

		// 1840년 이후의 년도 계산
		// 현재까지의 일수에서 위에서 계산된 1841년부터의 매년 음력일수를 빼가면수 년도를 계산
		lYear = 0;
		while(TempDate1 > ArrayTempDate[lYear]){
			TempDate1 = TempDate1 - ArrayTempDate[lYear];
			lYear = lYear + 1;
		}
		lMonth = 0;
		lsLunarMonth = "N";		// 현재월이 윤달임을 표시할 변수 - 기본값 평달
		while(Flag){
			if(LUNAR_CNT[lYear*12 + lMonth] <= 2){
				Temp = LUNAR_CNT[lYear*12 + lMonth] + 28;
				if(TempDate1 > Temp){
					TempDate1 = TempDate1 - Temp;
					lMonth = lMonth + 1;
				}else{
					Flag = false;
				}
			}else{
				switch(LUNAR_CNT[lYear*12 + lMonth]){
					case 3:
						Temp1 = 29; Temp2 = 29; break;
					case 4:
						Temp1 = 29; Temp2 = 30; break;
					case 5:
						Temp1 = 30; Temp2 = 29; break;
					case 6:
						Temp1 = 30; Temp2 = 30; break;
				}
				if(TempDate1 > Temp1){
					TempDate1 = TempDate1 - Temp1;
					if(TempDate1 > Temp2){
						TempDate1 = TempDate1 - Temp2;
						lMonth = lMonth + 1;
					}else{
						lsLunarMonth = "Y";
					}
				}else{
					Flag = false;
				}
			}
		}

		lYear = lYear + 1841;
		lMonth = lMonth + 1;
		lDay = TempDate1;

		RetValue = String.valueOf(lYear) + "-" + checkDigit(String.valueOf(lMonth)) + "-" + checkDigit(String.valueOf(lDay)) + "-" + lsLunarMonth;
		return RetValue;
	}

	public static String lunarDateForCalendar(int year, int month, int day){
		// 처리가능 기간  1841 - 2043년
		int TempDate1;					     // 음력일을 계산하기 위해 양력일과의 차이를 저장할 변수
		int TempDate2;					     // 현재까지의 날수
		int TotalDayCnt;				     // 1840년까지의 날수
		int Temp = 0;
		int Temp1 = 0;
		int Temp2 = 0;
		int lYear;				 // 계산된 음력 년, 월, 일을 저장할 변수
		int lMonth;
		int lDay;
		String lsLunarMonth;				 // 현재월이 윤달임을 표시
		String RetValue = "";
		int i;
		int j;
		boolean Flag = true;
		int[] ArrayTempDate = new int[250];	 // 매년의 음력일수를 저장할 배열 변수(year-1841)

		TotalDayCnt = 672069;    // 672069 = 1840 * 365 + 1840/4 - 1840/100 + 1840/400 + 23

		// 윤달여부를 체크
		if(year % 4 != 0){
			MONTH_DAY_CNT[1] = 28;
		}else if(year % 100 != 0 ){
			MONTH_DAY_CNT[1] = 29;
		}else if(year % 400 != 0){
			MONTH_DAY_CNT[1] = 28;
		}else{
			MONTH_DAY_CNT[1] = 29;
		}

		// 1841년부터 작년까지의 날수
		TempDate2 = (year-1)*365 + (year-1)/4 - (year-1)/100 + (year-1)/400;

		// 전월까지의 날수를 더함
		for(i=0;i<(month-1);i++){
			TempDate2 = TempDate2 + MONTH_DAY_CNT[i];
		}
		// 현재일까지의 날수를 더함
		TempDate2 = TempDate2 + day;

		// 양력현재일과 음력 1840년까지의 날수의 차이
		TempDate1 = TempDate2 - TotalDayCnt + 1;

		// 1841년부터 음력날수를 계산
		for(i=0;i<(year-1840);i++){
			ArrayTempDate[i] = 0;
			for(j=0;j<12;j++){
				switch(LUNAR_CNT[i*12 + j]){
					case 1:
						Temp = 29; break;
					case 2:
						Temp = 30; break;
					case 3:
						Temp = 58; break;
					case 4:
						Temp = 59; break;
					case 5:
						Temp = 59; break;
					case 6:
						Temp = 60; break;
				}
				ArrayTempDate[i] = ArrayTempDate[i] + Temp;
			}
		}

		// 1840년 이후의 년도 계산
		// 현재까지의 일수에서 위에서 계산된 1841년부터의 매년 음력일수를 빼가면수 년도를 계산
		lYear = 0;
		while(TempDate1 > ArrayTempDate[lYear]){
			TempDate1 = TempDate1 - ArrayTempDate[lYear];
			lYear = lYear + 1;
		}
		lMonth = 0;
		lsLunarMonth = "N";		// 현재월이 윤달임을 표시할 변수 - 기본값 평달
		while(Flag){
			if(LUNAR_CNT[lYear*12 + lMonth] <= 2){
				Temp = LUNAR_CNT[lYear*12 + lMonth] + 28;
				if(TempDate1 > Temp){
					TempDate1 = TempDate1 - Temp;
					lMonth = lMonth + 1;
				}else{
					Flag = false;
				}
			}else{
				switch(LUNAR_CNT[lYear*12 + lMonth]){
					case 3:
						Temp1 = 29; Temp2 = 29; break;
					case 4:
						Temp1 = 29; Temp2 = 30; break;
					case 5:
						Temp1 = 30; Temp2 = 29; break;
					case 6:
						Temp1 = 30; Temp2 = 30; break;
				}
				if(TempDate1 > Temp1){
					TempDate1 = TempDate1 - Temp1;
					if(TempDate1 > Temp2){
						TempDate1 = TempDate1 - Temp2;
						lMonth = lMonth + 1;
					}else{
						lsLunarMonth = "Y";
					}
				}else{
					Flag = false;
				}
			}
		}

		lYear = lYear + 1841;
		lMonth = lMonth + 1;
		lDay = TempDate1;

		if(1 == lDay || 15 == lDay || 1 == day || 15 == day)
		{
			if(lsLunarMonth=="Y")
			{
				RetValue = " (" + "윤 " + String.valueOf(lMonth) + "." + String.valueOf(lDay) + ")";
			}
			else
			{
				RetValue = " (" + String.valueOf(lMonth) + "." + String.valueOf(lDay) + ")";
			}
		}

		return RetValue;
	}

	public static String convertLunarDate1(int year, int month, int day){
		// 처리가능 기간  1841 - 2043년
		int TempDate1;					     // 음력일을 계산하기 위해 양력일과의 차이를 저장할 변수
		int TempDate2;					     // 현재까지의 날수
		int TotalDayCnt;				     // 1840년까지의 날수
		int Temp = 0;
		int Temp1 = 0;
		int Temp2 = 0;
		int lYear;				 // 계산된 음력 년, 월, 일을 저장할 변수
		int lMonth;
		int lDay;
		String lsLunarMonth;				 // 현재월이 윤달임을 표시
		String RetValue;
		int i;
		int j;
		boolean Flag = true;
		int[] ArrayTempDate = new int[250];	 // 매년의 음력일수를 저장할 배열 변수(year-1841)

		TotalDayCnt = 672069;    // 672069 = 1840 * 365 + 1840/4 - 1840/100 + 1840/400 + 23

		// 윤달여부를 체크
		if(year % 4 != 0){
			MONTH_DAY_CNT[1] = 28;
		}else if(year % 100 != 0 ){
			MONTH_DAY_CNT[1] = 29;
		}else if(year % 400 != 0){
			MONTH_DAY_CNT[1] = 28;
		}else{
			MONTH_DAY_CNT[1] = 29;
		}

		// 1841년부터 작년까지의 날수
		TempDate2 = (year-1)*365 + (year-1)/4 - (year-1)/100 + (year-1)/400;

		// 전월까지의 날수를 더함
		for(i=0;i<(month-1);i++){
			TempDate2 = TempDate2 + MONTH_DAY_CNT[i];
		}
		// 현재일까지의 날수를 더함
		TempDate2 = TempDate2 + day;

		// 양력현재일과 음력 1840년까지의 날수의 차이
		TempDate1 = TempDate2 - TotalDayCnt + 1;

		// 1841년부터 음력날수를 계산
		for(i=0;i<(year-1840);i++){
			ArrayTempDate[i] = 0;
			for(j=0;j<12;j++){
				switch(LUNAR_CNT[i*12 + j]){
					case 1:
						Temp = 29; break;
					case 2:
						Temp = 30; break;
					case 3:
						Temp = 58; break;
					case 4:
						Temp = 59; break;
					case 5:
						Temp = 59; break;
					case 6:
						Temp = 60; break;
				}
				ArrayTempDate[i] = ArrayTempDate[i] + Temp;
			}
		}

		// 1840년 이후의 년도 계산
		// 현재까지의 일수에서 위에서 계산된 1841년부터의 매년 음력일수를 빼가면수 년도를 계산
		lYear = 0;
		while(TempDate1 > ArrayTempDate[lYear]){
			TempDate1 = TempDate1 - ArrayTempDate[lYear];
			lYear = lYear + 1;
		}
		lMonth = 0;
		lsLunarMonth = "N";		// 현재월이 윤달임을 표시할 변수 - 기본값 평달
		while(Flag){
			if(LUNAR_CNT[lYear*12 + lMonth] <= 2){
				Temp = LUNAR_CNT[lYear*12 + lMonth] + 28;
				if(TempDate1 > Temp){
					TempDate1 = TempDate1 - Temp;
					lMonth = lMonth + 1;
				}else{
					Flag = false;
				}
			}else{
				switch(LUNAR_CNT[lYear*12 + lMonth]){
					case 3:
						Temp1 = 29; Temp2 = 29; break;
					case 4:
						Temp1 = 29; Temp2 = 30; break;
					case 5:
						Temp1 = 30; Temp2 = 29; break;
					case 6:
						Temp1 = 30; Temp2 = 30; break;
				}
				if(TempDate1 > Temp1){
					TempDate1 = TempDate1 - Temp1;
					if(TempDate1 > Temp2){
						TempDate1 = TempDate1 - Temp2;
						lMonth = lMonth + 1;
					}else{
						lsLunarMonth = "Y";
					}
				}else{
					Flag = false;
				}
			}
		}

		lYear = lYear + 1841;
		lMonth = lMonth + 1;
		lDay = TempDate1;

		RetValue = String.valueOf(lYear) + "-" + checkDigit(String.valueOf(lMonth)) + "-" + checkDigit(String.valueOf(lDay));
		return RetValue;
	}

	//2001.10.19
	public static String convertSolarDate(int year, int month, int day)
	{
		int sYear;
		int sMonth;
		int sDay;
		int y1;
		int y2 = 0;
		int y3;
		int m1;
		int mm;
		int leap;
		int td;
		int i;
		int j;
		boolean Flag = true;
		String RetValue = "";

		y1 = year - 1841;
		m1 = month - 1;
		leap = 0;

		if(LUNAR_CNT[y1*12 + m1] > 2){ //LUNAR_CNT[1911]
			if(year % 4 != 0){
				leap = 0;
			}else if(year % 100 != 0){
				leap = 1;
			}else if(year % 400 != 0){
				leap = 0;
			}else{
				leap = 1;
			}
		}

		if(leap == 1){
			switch(LUNAR_CNT[y1*12 + m1]){
				case 3 : mm = 29; break;
				case 4 : mm = 30; break;
				case 5 : mm = 29; break;
				case 6 : mm = 30; break;
			}
		}else{
			switch(LUNAR_CNT[y1*12 + m1]){
				case 1 : mm = 29; break;
				case 2 : mm = 30; break;
				case 3 : mm = 29; break;
				case 4 : mm = 29; break;
				case 5 : mm = 30; break;
				case 6 : mm = 30; break;
			}
		}

		td = 0;
		for(i=0;i<y1;i++){
			for(j=0;j<12;j++){
				switch(LUNAR_CNT[i*12 + j]){
					case 1 : td = td + 29; break;
					case 2 : td = td + 30; break;
					case 3 : td = td + 58; break;
					case 4 : td = td + 59; break;
					case 5 : td = td + 59; break;
					case 6 : td = td + 60; break;
				}
			}
		}

		for(j=0;j<m1;j++){
			switch(LUNAR_CNT[y1*12 + j]){
				case 1 : td = td + 29; break;
				case 2 : td = td + 30; break;
				case 3 : td = td + 58; break;
				case 4 : td = td + 59; break;
				case 5 : td = td + 59; break;
				case 6 : td = td + 60; break;
			}
		}

		if(leap == 1){
			switch(LUNAR_CNT[y1*12 + m1]){
				case 3 : mm = 29; break;
				case 4 : mm = 29; break;
				case 5 : mm = 30; break;
				case 6 : mm = 30; break;
			}
		}

		td = td + day + 22;

		y1 = 1840;
		while(Flag){
			y1 = y1 + 1;
			if(y1 % 4 != 0){
				y2 = 365;
			}else if(y1 % 100 != 0){
				y2 = 366;
			}else if(y1 % 400 != 0){
				y2 = 365;
			}else{
				y2 = 366;
			}

			if(td <= y2){
				Flag = false;
			}else{
				td = td - y2;
			}
		}

		sYear = y1;
		MONTH_DAY_CNT[1] = y2 - 337;
		m1 = 0;
		Flag = true;
		while(Flag){
			m1 = m1 + 1;
			if(td <= MONTH_DAY_CNT[m1-1]){
				Flag = false;
			}else{
				td = td - MONTH_DAY_CNT[m1-1];
			}
		}

		sMonth = m1;
		sDay = td;
		y3 = sYear;
		td = (y3*365) + (y3/4) - (y3/100) + (y3/400);
		for(i=0;i<sMonth;i++){
			td = td + MONTH_DAY_CNT[i];
		}

		td = td + sDay;

		RetValue = String.valueOf(y3) + "-" + checkDigit(String.valueOf(sMonth)) + "-" + checkDigit(String.valueOf(sDay));
		return RetValue;
	}

	public static String checkDigit(String str)
	{
		if(str.length() == 1){
			str = "0" + str;
		}
		return str;
	}

	public static String checkDigit(int value)
	{
		if(value < 10)
		{
			return "0" + value;
		}
		else
		{
			return String.valueOf(value);
		}
	}

	// 입력된 날짜에 해당하는 일주일의 날짜(배열)과 주차를 구한다.
	// String[] : yyyy-mm-dd-cnt
	public static String[] getWeekCnt(int year, int month, int day)
	{
		Calendar CurDate = Calendar.getInstance();
		CurDate.setFirstDayOfWeek(1);
		String[] strCnt = new String[7];

		CurDate.set(year,month-1,day);
		int retValue = CurDate.get(Calendar.WEEK_OF_YEAR);

		int iYear;
		int iMonth;
		int iDay;
		for(int i=1; i<8; i++)
		{
			CurDate.set(Calendar.DAY_OF_WEEK, i);
			iYear = CurDate.get(Calendar.YEAR);
			iMonth = CurDate.get(Calendar.MONTH)+1;
			iDay = CurDate.get(Calendar.DATE);

			strCnt[i-1] = "" + iYear + "-" + checkDigit(iMonth) + "-" + checkDigit(iDay) + "-" + checkDigit(retValue);
		}
		return strCnt;
	}

	public static String getTime(long gmtTime, String formatStr)
	{
		if(gmtTime == 0)
		{
			return "";
		}

		if(formatStr == null || formatStr.length() == 0)
		{
			formatStr = "yyyy-MM-dd HH:mm";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(formatStr);

		return formatter.format(new java.util.Date(gmtTime));
	}

	public static long getLongLocalTime(long gmtTime, String timeZone, String formatStr)
	{
		if(gmtTime == 0)
		{
			return 0;
		}

		if(formatStr == null || formatStr.length() == 0)
		{
			formatStr = "yyyy-MM-dd HH:mm";
		}

		if(timeZone == null || timeZone.length() == 0)
		{
			timeZone = "GMT+9";
		}

		String localTime = getLocalTime(gmtTime, timeZone, formatStr);

		SimpleDateFormat formatter = new SimpleDateFormat(formatStr);

		try
		{
			return formatter.parse(localTime).getTime();
		}
		catch(Exception e)
		{
			return 0;
		}
	}

	public static String getLocalTime(long gmtTime, String timeZone, String formatStr)
	{
		if(gmtTime == 0)
		{
			return "";
		}

		if(formatStr == null || formatStr.length() == 0)
		{
			formatStr = "yyyy-MM-dd HH:mm";
		}

		if(timeZone == null || timeZone.length() == 0)
		{
			timeZone = "GMT+9";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(formatStr);

		formatter.setTimeZone(TimeZone.getTimeZone(timeZone));

		return formatter.format(new java.util.Date(gmtTime));
	}

	public static String getLocalTime(Timestamp gmtTime, String timeZone, String formatStr)
	{
		if(gmtTime == null)
		{
			return "";
		}

		if(formatStr == null || formatStr.length() == 0)
		{
			formatStr = "yyyy-MM-dd HH:mm";
		}

		if(timeZone == null || timeZone.length() == 0)
		{
			timeZone = "GMT+9";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(formatStr);

		formatter.setTimeZone(TimeZone.getTimeZone(timeZone));

		return formatter.format(gmtTime);
	}

	public static String getLocalTimeString(String gmtTime,   String timeZone,
											String inFormatStr, String outFormatStr) throws Exception
	{
		if ((gmtTime == null) || (gmtTime.length() == 0))
		{
			throw new Exception("변환할 시간을 입력하세요.");
		}

		if(inFormatStr == null || inFormatStr.length() == 0)
		{
			inFormatStr = "yyyy-MM-dd HH:mm";
		}

		if(outFormatStr == null || outFormatStr.length() == 0)
		{
			outFormatStr = "yyyy-MM-dd HH:mm";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(inFormatStr);
		java.util.Date gmtTimeDate = formatter.parse(gmtTime);

		formatter = new SimpleDateFormat(outFormatStr);
		formatter.setTimeZone(TimeZone.getTimeZone(timeZone));
		return formatter.format(gmtTimeDate);
	}

	public static long getGMTTime(String localTime, String timeZone, String formatStr) throws Exception
	{
		if(localTime == null || localTime.length() == 0)
		{
			throw new Exception("변환할 시간을 입력하세요.");
		}

		if(formatStr == null || formatStr.length() == 0)
		{
			formatStr = "yyyyMMddHHmmss";
		}

		if(timeZone == null || timeZone.length() == 0)
		{
			timeZone = "GMT+9";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(formatStr);

		try
		{
			formatter.setTimeZone(TimeZone.getTimeZone(timeZone));
			java.util.Date date = formatter.parse(localTime);

			return date.getTime();
		}
		catch(ParseException e)
		{
			throw e;
		}
	}

	public static String getGMTTime(long gmtTime, String timeZone, String formatStr) throws Exception
	{
		if(gmtTime <= 0)
		{
			throw new Exception("변환할 시간을 입력하세요.");
		}

		if(formatStr == null || formatStr.length() == 0)
		{
			formatStr = "yyyyMMddHHmmss";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(formatStr);
		return formatter.format(new java.util.Date(gmtTime));

	}

	public static String getGMTTime(String localTime, String timeZone,
									String inFormatStr, String outFormatStr) throws Exception
	{
		if(localTime == null || localTime.length() == 0)
		{
			throw new Exception("변환할 시간을 입력하세요.");
		}

		long GMTTime = getGMTTime(localTime, timeZone, inFormatStr);

		if(outFormatStr == null || outFormatStr.length() == 0)
		{
			outFormatStr = "yyyy-MM-dd HH:mm";
		}

		SimpleDateFormat formatter = new SimpleDateFormat(outFormatStr);
		return formatter.format(new java.util.Date(GMTTime));
	}

	/** long 타입의 두개의 시간중 첫번쨰 시간의 일자 + 두번째 시간의 시간,분을 합쳐 다른 시간을 만든다.
	 * @param long date 일자 정보를 가지고 있는 변수
	 * @param long time 시간정보를 가지고 있는 변수
	 * @return long 첫번쨰 시간의 일자 + 두번째 시간의 시간,분
	 */
	public static long concateDate(long date, long time) throws Exception
	{
		try
		{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			String dateStr = formatter.format(new java.util.Date(date));

			formatter = new SimpleDateFormat("HHmm");
			String timeStr = formatter.format(new java.util.Date(time));

			formatter = new SimpleDateFormat("yyyyMMddHHmm");
			java.util.Date resultDate = formatter.parse(dateStr + timeStr);

			return resultDate.getTime();
		}
		catch(Exception e)
		{
			throw e;
		}
	}

	/**
		작성자 : 김형준
		Locale이 KO인 경우와 아닌 경우에 따른 다른 포맷으로 날짜 변환
	mode 1 : 2002-12-30 17:43:25   Dec 30, 2002 17:43:25
	mode 2 : 2002-12-30 17:35      Dec 30, 2002 17:43
	mode 3 : 2002-12-30            Dec 30, 2002
	mode 4 : 12-30                 Dec 30
	*/
	public static String getLocalTime(long gmtTime, String timeZone, String locale, int mode)
	{
		if(gmtTime == 0)
		{
			return "";
		}

		if(timeZone == null || timeZone.length() == 0)
		{
			timeZone = "GMT+9";
		}

		if(mode < 1 || mode > 4)
		{
			mode = 3;
		}

		DateFormatSymbols dateSymbols = new DateFormatSymbols(Locale.US);
		SimpleDateFormat formatter = null;
		if(locale == null || "ko".equals(locale.substring(0,2)))
		{
			formatter = new SimpleDateFormat(KO_MODE_FORMAT[mode-1], dateSymbols);
		}
		else
		{
			formatter = new SimpleDateFormat(EN_MODE_FORMAT[mode-1], dateSymbols);
		}

		formatter.setTimeZone(TimeZone.getTimeZone(timeZone));

		return formatter.format(new java.util.Date(gmtTime));
	}

	public static String getLocalTime(Timestamp gmtTime, String timeZone, String locale, int mode)
	{
		if(gmtTime == null)
		{
			return "";
		}

		if(timeZone == null || timeZone.length() == 0)
		{
			timeZone = "GMT+9";
		}

		if(mode < 1 || mode > 4)
		{
			mode = 3;
		}

		DateFormatSymbols dateSymbols = new DateFormatSymbols(Locale.US);
		SimpleDateFormat formatter = null;
		if(locale == null || "ko".equals(locale.substring(0,2)))
		{
			formatter = new SimpleDateFormat(KO_MODE_FORMAT[mode-1], dateSymbols);
		}
		else
		{
			formatter = new SimpleDateFormat(EN_MODE_FORMAT[mode-1], dateSymbols);
		}

		formatter.setTimeZone(TimeZone.getTimeZone(timeZone));

		return formatter.format(gmtTime);
	}

	public static String getLocalTime(String gmtTime, String timeZone, String locale, String inFormatStr, int mode)
					throws Exception
	{
		try
		{
			if(gmtTime == null || inFormatStr == null)
			{
				return "";
			}

			if(timeZone == null || timeZone.length() == 0)
			{
				timeZone = "GMT+9";
			}

			if(mode < 1 || mode > 4)
			{
				mode = 3;
			}

			SimpleDateFormat formatter = new SimpleDateFormat(inFormatStr);
			java.util.Date gmtTimeDate = formatter.parse(gmtTime);

			DateFormatSymbols dateSymbols = new DateFormatSymbols(Locale.US);
			if(locale == null || "ko".equals(locale.substring(0,2)))
			{
				formatter = new SimpleDateFormat(KO_MODE_FORMAT[mode-1], dateSymbols);
			}
			else
			{
				formatter = new SimpleDateFormat(EN_MODE_FORMAT[mode-1], dateSymbols);
			}

			formatter.setTimeZone(TimeZone.getTimeZone(timeZone));

			return formatter.format(gmtTimeDate);
		}
		catch(Exception e)
		{
			throw e;
		}
	}

	// ======================================= 1. 날자 관련 메서드 ==================================================

	/**
	* 날짜 포맷을 변경한다.<br>
	* yyyymmdd  에서 yyyy년mm월dd일
	*
	*@param      p_strDate   yyyymmdd
	*@return	 yyyy년mm월dd일
	*/
	public static String dateFormat(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 8) {
			strDate = p_strDate.substring(0, 8);
			StringBuffer stbResult = new StringBuffer();

			stbResult.append(strDate);
			stbResult.insert(4, "년 ");
			stbResult.insert(8, "월 ");
			stbResult.insert(12, "일");

			return stbResult.toString();
		}

		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다.<br>
	* yyyy-mm-dd 에서 yyyymmdd
	*
	*@param      p_strDate  yyyy-mm-dd
	*@return     yyyymmdd
	*/
	public static String dateFormat10to8(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 10) {
			strDate =
				strDate.substring(0, 4)
					+ strDate.substring(5, 7)
					+ strDate.substring(8);
		} else {
			;
		}

		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다.<br>
	* yyyymmdd 에서 yyyy-mm-dd
	*
	* @param     p_strDate	  yyyymmdd
	* @return    yyyy-mm-dd
	*/
	public static String dateFormat8to10(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 8) {
			strDate =
				strDate.substring(0, 4)
					+ "-"
					+ strDate.substring(4, 6)
					+ "-"
					+ strDate.substring(6);
		} else {
			;
		}

		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다.<br>
	* yyyymm 에서 yyyy-mm
	*
	* @param	p_strDate	yyyymm
	* @return	yyyy-mm
	*/
	public static String dateFormat6to7(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 6) {
			strDate = strDate.substring(0, 4) + "-" + strDate.substring(4);
		} else {
			;
		}

		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다.<br>
	* yyyy-mm 에서 yyyymm
	*
	* @param     p_strDate	 yyyy-mm
	* @return	 yyyymm
	*/
	public static String dateFormat7to6(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 7) {
			strDate = strDate.substring(0, 4) + strDate.substring(5);
		} else {
			;
		}

		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다 <br>
	* yyyy 에서 yyyy-00-00
	*
	* @param     p_strDate	 yyyy
	* @return	 yyyy-00-00
	*/
	public static String dateFormat4to10(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 4) {
			strDate = strDate + "-00-00";
		}
		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다
	* yyyy-mm 에서 yyyy-mm-00
	*
	* @param     p_strDate	 yyyy-mm
	* @return	 yyyy-mm-00
	*/
	public static String dateFormat7to10(String p_strDate) {
		String strDate = EJBStringUtil.nvl(p_strDate, "");

		if (strDate.length() == 4) {
			strDate = strDate + "-00";
		}
		return strDate;
	}

	/**
	* 날짜 포맷을 변경한다.<br>
	* 원하는 구분자를 이용하여 년,월,일을 구분한다
	*
	* @param     day 	yyyymmdd
	* @param	 gubun  구분자 (ex."." 또는 "-");
	* @return    yyyy.mm.dd 또는 yyyy-mm-dd
	*/
	public static String dayFormat(String day, String gubun) {
		String value = "";

		if ((day == null) || (day.equals(""))) {
			System.out.println("입력하신 날짜가 null 또는 공백입니다 : dayFormat()에서 에러");

		} else {
			if (day.length() == 8) {
				try {
					value =
						day.substring(0, 4)
							+ gubun
							+ day.substring(4, 6)
							+ gubun
							+ day.substring(6, 8);
				} catch (StringIndexOutOfBoundsException s) {
				}
			} else {
				value = day;
				System.out.println(
					"DB에 저장할 날짜 타입에 일치하지 않습니다(" + day + ") : dayFormat()에서 에러");
			}
		}
		return value;
	}

	/**
	* 날짜 포맷의 문자열에서 연도만 가져온다.<br>
	* yyyy-mm-dd 에서 yyyy만 리턴.
	*
	* @param     date_from_db	 yyyy-mm-dd
	* @return	 yyyy
	*/
	public static String getYear(String date_from_db) {
		String year = "";

		if (date_from_db == null) {
			System.out.println("입력하신 날짜가 null 입니다 : ComUtils.getYear()에서 에러");
			return year;
		}

		if (date_from_db.length() != 10) {
			System.out.println(
				"yyyy-mm-dd 포멧을 따르지 않는 날짜형식입니다 : ComUtils.getYear()에서 에러");
			return year;
		}

		year = date_from_db.substring(0, 4);

		return year;
	}

	/**
	* 날짜 포맷의 문자열에서 월만 가져온다.<br>
	* yyyy-mm-dd 에서 mm만 리턴.
	*
	* @param     date_from_db	 yyyy-mm-dd
	* @return	 mm
	*/
	public static String getMonth(String date_from_db) {
		String month = "";

		if (date_from_db == null) {
			System.out.println("입력하신 날짜가 null 입니다 : ComUtils.getMonth()에서 에러");
			return month;
		}

		if (date_from_db.length() != 10) {
			System.out.println(
				"yyyy-mm-dd 포멧을 따르지 않는 날짜형식입니다 : ComUtils.getMonth()에서 에러");
			return month;
		}

		month = date_from_db.substring(5, 7);

		return month;
	}

	/**
	* 날짜 포맷의 문자열에서 일만 가져온다.<br>
	* yyyy-mm-dd 에서 mm만 리턴.
	*
	* @param     date_from_db	 yyyy-mm-dd
	* @return	 dd
	*/
	public static String getDay(String date_from_db) {
		String day = "";

		if (date_from_db == null) {
			System.out.println("입력하신 날짜가 null 입니다 : ComUtils.getDay()에서 에러");
			return day;
		}

		if (date_from_db.length() != 10) {
			System.out.println(
				"yyyy-mm-dd 포멧을 따르지 않는 날짜형식입니다 : ComUtils.getDay()에서 에러");
			return day;
		}

		day = date_from_db.substring(8, 10);

		return day;
	}

	/*
	public static void main(String[] args){
		System.out.println(getYear("2002-11-30"));
		System.out.println(getMonth("2002-11-30"));
		System.out.println(getDay("2002-11-30"));
		System.out.println(dayFormat("20021130","-"));
	}
	*/

}

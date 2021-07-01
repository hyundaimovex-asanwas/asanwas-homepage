/*
 * @ Util.java
 *
 * TYPE : 공통 클래스
 *
 *
 * 사용법
 *    - static method는 Util.mehtod()로 호출한다.
 *    - 기타 메소드는 객체생성후 접근한다.
 */
 
package kr.co.imjk.util;
 
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.SimpleTimeZone;
import java.util.StringTokenizer;
import java.util.TimeZone;

import sun.misc.BASE64Encoder;
import sun.misc.BASE64Decoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import sun.misc.BASE64Encoder;

public class Util{
  
    public Util() {
     
    }       
    public static String getStringLimit(String param, int length){
        String returnVal = "";
        if(param.length()>length){
            returnVal = param.substring(0,length) + "...";
        }else{
            returnVal=param;
        }
        return returnVal;
        
    }
    
    public static String encoder(String string, String enc) { 
        String encodedString = ""; 
        try { 
        byte[] conb1; 

        conb1 = string.getBytes(enc); 

        for (int i = 0; i < conb1.length; i++) { 
        int k = (int) conb1[i]; 
        if (k < 0) { 
        k = 256 + k; 
        } 
        encodedString = encodedString + (char) (k / 16 + 65); 
        encodedString = encodedString + (char) (k % 16 + 97); 
        } 
        } catch (UnsupportedEncodingException e) { 
        e.printStackTrace(); 
        } 
        return encodedString; 
        } 

        public static String decoder(String string, String enc) { 
        byte[] decodingByte = new byte[string.length() / 2]; 

        for (int i = 0; i < decodingByte.length; i++) { 
        int k = ((int) (string.charAt(i * 2)) - 65) * 16 + (int) (string.charAt(i * 2 + 1)) - 97; 
        if (k > 127) { 
        k = k - 256; 
        } 
        decodingByte[i] = (byte) k; 
        } 

        String decodingStr = null; 
        try { 
        decodingStr = new String(decodingByte, enc); 
        } catch (UnsupportedEncodingException e) { 
        e.printStackTrace(); 
        } 
        return decodingStr; 
        } 

    
    public static String toUTF8(String isoString) {  
        String utf8String = null;   
        if (null != isoString && !isoString.equals("")) {  
            try {  
                 byte[] stringBytesISO = isoString.getBytes("ISO-8859-1");   
                 utf8String = new String(stringBytesISO, "UTF-8");  
             } catch(UnsupportedEncodingException e) {    } 
        } 
        return utf8String;
     } 
    /**
     * 반올림 또는 내림 하는 메소드
     *
     * Parameter : 입력값, 소수점 이하 자리수, 올림내림 구분
     * 
     * round_type :
     * 
     * java.math.BigDecimal.ROUND_CEILING 
     * java.math.BigDecimal.ROUND_DOWN
     * java.math.BigDecimal.ROUND_FLOOR
     * java.math.BigDecimal.ROUND_HALF_DOWN
     * java.math.BigDecimal.ROUND_HALF_EVEN
     * java.math.BigDecimal.ROUND_HALF_UP
     * java.math.BigDecimal.ROUND_UP
     * 
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static float round(float f, int len, int round_type){
        float retval = 0F;
        try{
            retval = (new java.math.BigDecimal(f).setScale(len, round_type)).floatValue();  
        }catch(NumberFormatException nfe){}
        return retval;
    }    
	
    /**
     * 분모가 0이면 ArithmeticException이 발생하는 것을 방지하기 위한 메소드<br>
     * 
     * Parameter : 분자, 분모
     * 
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static float division(float son, float mother){
        float retval = 0F;
        if(mother == 0){
            retval = son;
        }else{
            retval = (son / mother);
			retval = round(retval, 2,java.math.BigDecimal.ROUND_HALF_UP);
        }
        return retval;
    }
    
    /**
     * 8859_1 -> KSC5601 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static String toEN(String ko) 
    {
    	String new_str = null;		
    	try {		
    		if(ko != null ){
    			new_str=new String(ko.getBytes("KSC5601"),"8859_1");
    		}		
    	} catch(UnsupportedEncodingException e) { }			
    	return new_str;
    }

    /**
     * KSC5601 -> 8859_1 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static String toKSC(String en) 
    {
    	String new_str = null;		
    	try {
    		if(en != null){
    			new_str = new String (en.getBytes("8859_1"), "KSC5601");
    		}
    	} catch (UnsupportedEncodingException e) {}
    	return new_str;
    }

    /**
     * KSC5601 -> 8859_1 <br>
     *
     * @author : 정철우
     * @e-mail : cwjung@mirenet.com
	 * return  : null일 경우, ""을 return
     */

    public static String toKSC2(String en) 
    {
    	String new_str = null;		
    	try {
    		if(en != null){
    			new_str = new String (en.getBytes("8859_1"), "KSC5601");
    		} else {
				new_str = "";
			}
    	} catch (UnsupportedEncodingException e) {}
    	return new_str;
	}
	
    /**
     * space -> &nbsp;  <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static String spaceToNBSP(String source) 
    {
    	StringBuffer sb = new StringBuffer(source);
    	StringBuffer result = new StringBuffer();
    	String ch = null;
    	for(int i=0; i<source.length(); i++) {
    	
    		if (Character.isSpaceChar(sb.charAt(i))) 
    			ch = "&nbsp;";
    		else 
    			ch = String.valueOf(sb.charAt(i));
    		
    		result.append(ch);
    	}
    	return result.toString();
    }

	/* *************************
	 *특정 요일을 알아온다.
	 * inserted by jeonghwa, Kim
	 **************************/
	public static int getDay(int year, int month, int day) 
	{
		Date d = new Date(year-1900, month-1, day);
		return d.getDay();
	}	

	/* *************************
	 *특정 날짜 형태로 알아온다.
	 * inserted by jeonghwa, Kim
	 **************************/
	public static String changeDateType(String date_s) 
	{
		int year = Integer.parseInt(date_s.substring(0,4));
		int month = Integer.parseInt(date_s.substring(5,7));
		int day = Integer.parseInt(date_s.substring(8,10));

		Date d = new Date(year-1900, month-1, day);
		String day_name=""+month+"월"+day+"일";
		
		switch(d.getDay())
		{
			case 0 : day_name=day_name+"(일)"; break;
			case 1 : day_name=day_name+"(월)"; break;
			case 2 : day_name=day_name+"(화)"; break;
			case 3 : day_name=day_name+"(수)"; break;
			case 4 : day_name=day_name+"(목)"; break;
			case 5 : day_name=day_name+"(금)"; break;
			case 6 : day_name=day_name+"(토)"; break;
		}
		return day_name;
	}
	
	/* *************************
	 *특정 날짜 형태로 알아온다.
	 * inserted by jungeun, Kim
	 **************************/
	
	public static String changeDateDay(String date_s) 
	{
		int year = Integer.parseInt(date_s.substring(0,4));
		int month = Integer.parseInt(date_s.substring(4,6));
		int day = Integer.parseInt(date_s.substring(6,8));

		Date d = new Date(year-1900, month-1, day);
		String day_name=year+"년 "+month+"월 "+day+"일 ";
		
		switch(d.getDay())
		{
			case 0 : day_name=day_name+" (일)"; break;
			case 1 : day_name=day_name+" (월)"; break;
			case 2 : day_name=day_name+" (화)"; break;
			case 3 : day_name=day_name+" (수)"; break;
			case 4 : day_name=day_name+" (목)"; break;
			case 5 : day_name=day_name+" (금)"; break;
			case 6 : day_name=day_name+" (토)"; break;
		}
		return day_name;
	}
	
	/* *************************
	 * 'yyyy-MM-dd 형태를 yyyymmdd형의 int로 반환
	 * inserted by jungeun, Kim
	 **************************/
	
	public static int dateFormat2(String date_s) 
	{
		date_s = date_s.substring(0,4)+date_s.substring(5,7)+date_s.substring(8,10);
        int intDate = Integer.parseInt(date_s);
		return intDate;
	}

    /**
     * 현재날짜를 지정된 포맷으로 만들어 리턴 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static String dateFormat(String format)
    {
    	String date=null;
    	try
    	{
    		TimeZone tz = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
    		TimeZone.setDefault(tz);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat(format);
    		date = sdf.format(d);
    	} catch(Exception kkkk) { }
    	return date;
    }
	
    /**
     * 현재날짜를 YYYY-MM-DD 형식으로 만들어 리턴 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static String getDate()
    {
    	String ch = null;
    	try
    	{
    		TimeZone tz = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
    		TimeZone.setDefault(tz);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy'-'MM'-'dd");
    		ch = sdf.format(d);
    	} catch(Exception dfdf) { }
    	return ch;
    }

    /**
     * 입력받은 Date 오브젝트를 YYYY-MM-DD 형식의 String 으로 만들어 리턴 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static String dateToString(Date d)
    {
    	String ch = null;
    	try
    	{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy'-'MM'-'dd");
            ch = sdf.format(d);
    	} catch(Exception dfdf) { }
    	return ch;
    }
    
    /**
     * 입력받은 Date 오브젝트를 특정한 포멧 형식의 String 으로 만들어 리턴 <br>
     *
     * 예) dateToString(new Date(), "MMM d,  yyyy")<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static String dateToString(Date d, String format)
    {
    	String ch = null;
    	try
    	{
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            ch = sdf.format(d);
    	} catch(Exception dfdf) { }
    	return ch;
    }    

    /**
     * 입력받은 String오브젝트를 특정한 포멧 형식의 Date 형으로 만들어 리턴 <br>
     *
     * 예) stringToDate("2001-06-01", "yyyy-'-'MM'-'dd")<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static java.util.Date stringToDate(String d, String format)
    {
    	java.util.Date ch = null;
    	try
    	{
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            ch = sdf.parse(d);
    	} catch(Exception dfdf) { }
    	return ch;
    }
    
    public static java.util.Date dateFormat(Date d, String format){
        String str = dateToString(d, format);
        return stringToDate(str, format);  
    }
    
    public static String stringToDateString(String d, String format){
        if(d == null || d.length() < 6) return "";
        if(d.length() < 7){
            d = d.substring(0,4) +"-"+ d.substring(4,6) +"-"+ d.substring(6);  
        }
        return dateToString(stringToDate(d, "yyyy'-'MM'-'dd"), format);
    }
     
    /**
     * 현재날짜를 YYYY-MM-DD HH:MM:SS 형식으로 만들어 리턴 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static String getTime(){
    	String ch = null;
    	try{
    		TimeZone tz = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
    		TimeZone.setDefault(tz);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy'-'MM'-'dd'-'HH'-'mm'-'ss");
    		ch = sdf.format(d);
    	}catch(Exception dfdf){}
    	return ch;
    } 
    
    
    /**
     * 유닉크한 문자를 리턴  <br>
     *
     * @author : 임형수 
     * @e-mail : hslim@imjk.co.kr
     */    
    public synchronized static String getSeqText() {
 
    	java.util.Random rands = new java.util.Random();
		java.lang.StringBuffer str = new java.lang.StringBuffer();
		String resultSeq = null;
		String ch = null;
    	try{
    		TimeZone tz = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
    		TimeZone.setDefault(tz);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    		ch = sdf.format(d);
    		
    		char[] chs = {
    			 '1','b','5','k','l','m','6','a','c','f','4','h','3','i','0','j','n','o','2',
    			'p','q','r','z','s','t','u','v','7','8','w','x','d','e','y','9'};
    		int rnd;
    		for( int i=0; i<8; i++)
    		{
    			rnd = rands.nextInt(35);
    			str.append(chs[rnd]);
    		}
    		
    		resultSeq = ch+str;
    	}catch(Exception e){
    		
    		e.printStackTrace();
    	}
    	
    	return resultSeq;
    } 
	
    /**
     * 현재 날짜를 타입에 따라 년, 월,일 만을 리턴 <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */  
    public static String getDate(int type)
    {
    	String ch = getDate();
    	String format = null;		
    	switch(type){
    		case 1:
    			format = ch.substring(0,4);
    			break;
    		case 2:
    			format = ch.substring(5,7);
    			break;
    		case 4:
    			format = ch.substring(0,4)+ch.substring(5,7)+ch.substring(8,10);
    			break;
    			
    		default:
    			format = ch.substring(8,10);
    			break;
    	}
    	return format;
    }
	
    /**
     * Encode URL -> Decode URL : jdk 1.x 버전에서는 java.net.URLDecoder 클래스를 지원하지 않기 때문에<br>
     *  jdk1.x 에서 URL 디코딩시 사용. <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static String decodeURL(String s){
    	 
    	ByteArrayOutputStream out = new ByteArrayOutputStream(s.length());
    	for (int i = 0; i < s.length(); i++){  
    		int c = (int) s.charAt(i);
    		if ( c == '+') 
    			out.write(' ');
    		else if (c == '%'){  
    				int c1 = Character.digit(s.charAt(++i), 16);
    				int c2 = Character.digit(s.charAt(++i), 16);
    				out.write((char) (c1 * 16 + c2));
    		}else 
    			out.write(c);
    	}
    	return out.toString();
    }
	
    /**
     * 스트링을 int로 변환. NumberFormatException, NullPointerException 을 검사하기 위해, Exception 발생시 0 리턴
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static int parseInt(String str){
    	int parseInt = 0;
    	try{
    		parseInt = Integer.parseInt(str);
    	}catch(Exception nf){}
    	return parseInt;
    }
	
    /**
     * 스트링을 int로 변환. NumberFormatException, NullPointerException 을 검사하기 위해, Exception 발생시 0 리턴
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static float parseFloat(String str){
    	float parseFloat = 0.0f;
    	try{
    		parseFloat = Float.parseFloat(str);
    	}catch(Exception nf){}
    	return parseFloat;
    }
    
    /**
     * 스트링을 int로 변환. NumberFormatException, NullPointerException 을 검사하기 위해, Exception 발생시 0 리턴
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static long parseLong(String str){
    	long parseLong = 0L;
    	try{
    		parseLong = Long.parseLong(str);
    	}catch(Exception nf){}
    	return parseLong;
    }	
    
    /**
     * 스트링을 int로 변환. NumberFormatException, NullPointerException을 검사하기 위해, Exception 발생시 default value 리턴<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static int parseInt(String str, int def){
    	int parseInt = 0;
    	try{
    		parseInt = Integer.parseInt(str);
    	}catch(Exception nf){parseInt = def;}
    	return parseInt;
    }

    /**
     * 파라미터의 값이 "" 일때 null 을 리턴하게끔 하는 메소드<br>
     * URL에서 파라미터를 받을때 name 값이 존재하면 "" 이 넘어올 수 있기 때문에 null 값을 검사할때 사용.<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     *     
     */
    public static String checkNull(String key){
    	String value = key;
    	if(key == null || key.equals(""))
    		value = null;
    	return value;			
    }
	
    /**
     * 날짜형을 년, 월, 일로 나누어 리턴하는 메소드<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */
    public static String parseDate(String date, int type){
    	String parse = "";
    	if(date != null && date.length() == 8){
    		switch(type){
    			case 1: //년
    				parse = date.substring(0, 4);
    				break; 
    			case 2: //월
    				parse = date.substring(4, 6);
    				break;
    			default: //일
    				parse = date.substring(6, 8);
    				break;
    		}
    	}
    	return parse;
    }
    
    public static String parseMMDD(String date, String delim){
        String parse = null;
        if(date != null && date.length() == 8){
           parse = date.substring(4, 6) + delim +  date.substring(6, 8);
        }
        return parse;
    }    
    
    public static String parseDate(String date, String delim){
        String parse = null;
        if(date != null && date.length() == 8){
           parse = date.substring(0,4) + delim + date.substring(4, 6) + delim +  date.substring(6, 8);
        }
        return parse;
    }       
    
    //YYYY-MM-DD 또는 YYYY/MM/DD인 경우 YYYY년MM월DD일로 반환
    public static String parseKorDate(String tdate,int type){
        String parse = null;
        if(tdate != null && tdate.length() == 10){
            switch(type){
    			case 1: //년 월 일
    				parse = Util.parseInt(tdate.substring(0, 4))+"년 "+Util.parseInt(tdate.substring(5,7))+"월 "+Util.parseInt(tdate.substring(7,9)) + "일" ;
    				break; 
    			case 2: //월 일
    				parse = Util.parseInt(tdate.substring(5,7))+"월 "+Util.parseInt(tdate.substring(8,10)) + "일" ;
    				break;
    			default: //일
    				parse = Util.parseInt(tdate.substring(8,10)) + "일" ;
    				break;
    		}
        }
        return parse;
    }
    
    //  YYYY-MM-DD 또는 YYYY/MM/DD인 경우 YYYY.MM.DD로 반환
    public static String parseMDate(String tdate,int type){
        String parse = null;
        String tdate1 = "";
        String tdate2 = "";
        String tdate3 = "";
        if(tdate != null && tdate.length() > 8){
        	StringTokenizer st =  new StringTokenizer(tdate,"-"); 
        	tdate1 = st.nextToken(); 
    		tdate2 = st.nextToken(); 
    		tdate3 = st.nextToken(); 
    		
            switch(type){
    			case 1: //년 월 일
    				parse = tdate1+"."+tdate2+"."+tdate3.substring(0,2)+ "" ;
    				break; 
    			case 2: //월 일
    				parse = tdate2+"."+tdate3.substring(1,2)+ "" ;
    				break;
    			default: //일
    				parse = tdate3.substring(1,2) + "" ;
    				break;
    		}
        }
        return parse;
    }
    /**
     * &nbsp -> ""
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */     
    public static String nbspToSpace(String nbsp){
    	String value = "";
    	if(nbsp != null && !nbsp.trim().equals("&nbsp;")){
    		value = nbsp;
    	}
    	return value;
    }
     
    
    /**
     * null -> "" 로 변환하는 메소드<br>
     * : 데이터 수정시 데이터 베이스로 부터 읽은 값이 null이면 수정 폼에 null이 들어가므로 이값을 변환하는 메소드 <br>
     * : 데이터 수정시 null 값을 수정 폼에 setting 할때 사용하면 유용한 메소드. <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */     
    public static String nullToString(String str){
    	String value = str;
    	if(str == null){
    		value = "";
    	}
    	return value;
    }
    
    /**
     * null or "" --> "&nbsp;" <br>
     * : HTML에서 테이블의 셀에 "" 이 들어가면 테이블이 깨지므로(netscape) 공백문자(&nbsp;)로 대치하는 메소드<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */   
    public static String nullToNbsp(String str){
    	String value = str;
    	if(str == null || str.equals("")){
    		value = "&nbsp;";
    	}
    	return value;
    }
    
    /**
     * Object 형을 String 으로 변환<br>
     * : Object 가 null 일때 NullpointerException 을 검사하기 위해서 사용.<br>
     * : ResultSet 으로부터 getObject()로 값을 가져왔을경우 String으로 변환할때 사용하면 유용한 메소드.<br>
     *
     * @author : 심재진
     * @E-mail : sim11@miraenet.com
     */
    public static String toString(Object obj){
        String str = "";
    	if(obj != null)
    	    str = obj.toString();
    	return str;
    }
    
    /**
     * 전체 데이터수로 마지막페이지를 계산해오기 위한 Method.<br>
     * : 게시판 목록 같은 경우 몇 페이지 까지 있는지 계산할때 사용하면 유용한 메소드<br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */    
    public static int getPageCount(int token, int allPage){
    	int lastPage =(int)(((allPage-1)/token)+1);	
    	return lastPage;
    }
	
    /**
     * 데이터의 번호를 주기위해 번호를 계산해오는 Method <br>
     * : 게시판 목록 같은 경우 페이지별 데이터의 번호를 계산해 주는 메소드. <br>
     *
     * @author : 심재진
     * @e-mail : sim11@mirenet.com
     */    
    public static int getDataNum(int token, int page, int allPage){
    	if(allPage<=token){
    		return allPage;
    	}
    	int num = allPage - (token*page) + token;	
    	return num;
    }
        
    /**
     * 문자열의 값이 null 이거나 ""이면 default 값을 리턴하는 메소드<br>
     *
     * @author : 심재진 
     * @e-mail : sim11@mirenet.com
     */
    public static String getString(String line, String def){
        if(line == null || line.equals(""))
            return def;
        return line;  
    } 
         
    /**
     * 현재일이  특정 기간에 속해있는지 검사하는 메소드<br>
     * : argument : 시작일(yyyy-mm-dd), 종료일(yyyy-mm-dd)
     *     
     * @author : 심재진 
     * @e-mail : sim11@mirenet.com 
     */
    public static boolean betweenDate(String first, String second){
        boolean flag = false;
        java.util.Date start = null;
        java.util.Date end = null;
        java.util.Date current = null;
        
        DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.KOREA);
        
        try{			
            start = df.parse(first);
            end = df.parse(second);
            current = df.parse(getDate());
        }catch(Exception pe){
            return false;				
        }
        
        if((start.before(current) && end.after(current)) || start.equals(current) || end.equals(current)) 
            flag= true;
        
        return flag;
    }

    public static String reqTime(){ 
    	String ch = null;
    	try{
    		TimeZone tz = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
    		TimeZone.setDefault(tz);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy'-'MM'-'dd' 'HH");
    		ch = sdf.format(d);
    	}catch(Exception dfdf){}
    	return ch;
    } 
    
    public static String getToMonth(){ 
    	String ch = null;
    	try{
    		TimeZone tz = new SimpleTimeZone( 9 * 60 * 60 * 1000, "KST" );
    		TimeZone.setDefault(tz);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
    		ch = sdf.format(d);
    	}catch(Exception dfdf){}
    	return ch;
    }
    

	/******************************************************
	 ** 현재일이   종료일 이후에 있는지 검사**
	 ******************************************************/
	public static boolean afterDate(String second)
	{
		boolean flag = false;
		java.util.Date end = null;
		java.util.Date current = null;

		DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.KOREA);
		
		try{			
			end = df.parse(second);
			current = df.parse(Util.reqTime());
		}catch(Exception pe)
		{
			//System.err.println("afterDate 에러입니다."+pe.getMessage());	
            return false;
		}
		
		
		if(end.before(current) || end.equals(current)) 
			flag= true;

		return flag;
	}
	
	
	/******************************************************
	 ** 현재일이   시작일 이전에 있는지 검사**
	 ******************************************************/
	public static boolean beforeDate(String first)
	{
		boolean flag = false;
		java.util.Date start = null;
		java.util.Date current = null;

		DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.KOREA);
		
		try{			
			start = df.parse(first);
			current = df.parse(Util.reqTime());
		}catch(Exception pe)
		{
			//System.err.println("beforeDate 에러입니다."+pe.getMessage());	
		}
		
		
		if(start.after(current)  || start.equals(current)) 
			flag= true;

		return flag;
	}
		        
    /**
    * 가격등의 값을 3자리 마다 comma(,)로 분리하여 리턴<br>
    *     
    * @author : 심재진 
    * @e-mail : sim11@mirenet.com 
    */        
    public static String parseDecimal(double unFormat){
        DecimalFormat df = new DecimalFormat("###,###.##");
        String format = df.format(unFormat);
        return format;
    }
    
    /**
    * 가격등의 값을 3자리 마다 comma(,)로 분리하여 리턴<br>
    *     
    * @author : 심재진 
    * @e-mail : sim11@mirenet.com 
    */        
    public static String parseDecimal(double unFormat, String foramt){
        DecimalFormat df = new DecimalFormat(foramt);
        String format = df.format(unFormat);
        return format;
    }    

    /**
    * Object 의 복제하여 주는 메소드<br>
    * 일반적으로 java.lang.Object.clone() 메소드를 사용하여 Object를 복제하면 Object내에 있는 Primitive type을 제외한 Object <br>
    * field들은 복제가 되는 것이 아니라 같은 Object의 reference를 갖게 된다.<br>
    * 그러나 이 Method를 사용하면 각 field의 동일한 Object를 새로 복제(clone)하여 준다.<br>
    * java.lang.reflect API 를 사용하였음. <br>
    *     
    * @author : 심재진 
    * @e-mail : sim11@mirenet.com 
    */        
    public static Object clone(Object object){
        Class c = object.getClass();
        Object newObject = null;
        try {
            newObject = c.newInstance();
        }catch(Exception e ){
            return null;
        }
        
        java.lang.reflect.Field[] field = c.getFields();
        for (int i=0 ; i<field.length; i++) {
            try {
                Object f = field[i].get(object);
                field[i].set(newObject, f);
            }catch(Exception e){}
        }
        return newObject;
    }
        
    /**
    * 디버깅시 Servlet 에서는 PrintWriter 를 넣어서 쉽게 디버깅을 할 수 있었지만 <br>
    * JSP 에서 처럼 PrintWriter가 없을때 디버깅을 쉽게 하기 위하여 메세지를 문자열로 만들어 리턴하게 하였음.<br>
    *
    * @author : 심재진 
    * @e-mail : sim11@mirenet.com 
    */                
    public static String getStackTrace(Throwable e) {
        java.io.ByteArrayOutputStream bos = new java.io.ByteArrayOutputStream();
        java.io.PrintWriter writer = new java.io.PrintWriter(bos);
        e.printStackTrace(writer);
        writer.flush();        
        return bos.toString();
    }        

    /**
     * 특정 문자열을 다른 문자열로 대체하는 메소드<br>
     * : 문자열 검색시 검색어에 색깔을 넣거나 ... 테그를 HTML 문자로 바꾸는데 사용하면 유용할거 같음.<br>
     *
     * @author : 심재진 
     * @e-mail : sim11@mirenet.com 
     * @ 참고 문헌 : JAVA Servlet Programming(Oreilly) 
     */
    public static String replaceAll(String line, String oldString, String newString){
        if(line == null) return line;
        int index=0;
        while((index = line.indexOf(oldString, index)) >= 0){
        	line = line.substring(0, index) + newString + line.substring(index + oldString.length());
        	index += newString.length();
        }
        return line;
    }	
    

    
    /**
     * 문자열을 substring할때 문자열 길이를 넘어설 경우 "" 를리턴하는 메소드
     *
     * @author : 심재진 
     * @e-mail : sim11@mirenet.com 
     * @date : 2001-04-21
     *
     */
    public static String substring(String str, int start, int end){
        String val = null;
        try{
            val = str.substring(start, end);
        }catch(Exception e){
            return "";  
        }
        return val;
    }
        
    /**
    * ','로 분리되어 있는 문자열을 분리하여 Return
    * List에서 일괄 삭제시 ID값을 일괄로 받아와서 Parsing...
    * written by Blue.
    */
    
    public static String[] getItemArray(String src) {
    
        String[] retVal = null;
        if (src.length() == 0) return null;
        
        int nitem = 1;
        
        for (int i = 0; i < src.length(); i++)
        		if (src.charAt(i) == ',') nitem++;
        
        retVal = new String[nitem];
        
        int ep = 0;
        int sp = 0;
        
        for (int i = 0; i < nitem; i++) {
        	ep = src.indexOf(",", sp);
        	if (ep == -1) ep = src.length();
        	retVal[i] = new String(src.substring(sp, ep));
        	sp = ep + 1;
        }
        
        return retVal; 
    }
    
    public static String[] getItemArray(String src, char parser) {
    
        String[] retVal = null;
        if (src.length() == 0) return null;
        
        int nitem = 1;
        
        for (int i = 0; i < src.length(); i++)
                if (src.charAt(i) == parser) nitem++;
        
        retVal = new String[nitem];
        
        int ep = 0;
        int sp = 0;
        
        for (int i = 0; i < nitem; i++) {
            ep = src.indexOf(parser, sp);
            if (ep == -1) ep = src.length();
            retVal[i] = new String(src.substring(sp, ep));
            sp = ep + 1;
        }
        
        return retVal; 
    }    

    /**
     * 특정 날짜를 'YYYY/MM/DD' 형식으로 return<br>
     *
     *
     * @author : 정철우 
     * @e-mail : cwjung@mirenet.com 
     * 
     */
    public static String returnDate(String date) {
        
        if(date == null){
            return "";
        }else if(date.length() < 8){
            return date;
        }
        
        String year = date.substring(0,4);
        String month = date.substring(4,6);
        String day = date.substring(6,8);
        
        return year + "/" + month + "/" + day;
    }
    
    /**
     * 윤년 check Method...
     * : 올해가 윤년인지를 check하여 booelan으로 return;
     *
     * @author : 정철우 
     * @e-mail : cwjung@mirenet.com 
	 *
     */

	 public static boolean checkEmbolism(int year) {

		 int remain = 0;
		 int remain_1 = 0;
		 int remain_2 = 0;

		 remain = year % 4;
		 remain_1 = year % 100;
		 remain_2 = year % 400;

		 // the ramain is 0 when year is divided by 4;
		 if (remain == 0) {

			 // the ramain is 0 when year is divided by 100;
			 if (remain_1 == 0) {

			 	// the remain is 0 when year is divided by 400;
				if (remain_2 == 0) return true;
				else return false;

			 } else  return true;
		 }

		 return false;
	 }

    /**
     * 각 월의 마지막 일을 return
     * 해당 월의 마지막일을 return. 윤년 check후 해당 일을 return
     *
     * @author : 정철우 
     * @e-mail : cwjung@mirenet.com 
	 *
     */

	public static int getMonthDate(int year, int month) {

		int[] dateMonth = new int[12];

		dateMonth[0] = 31;
		dateMonth[1] = 28;
		dateMonth[2] = 31;
		dateMonth[3] = 30;
		dateMonth[4] = 31;
		dateMonth[5] = 30;
		dateMonth[6] = 31;
		dateMonth[7] = 31;
		dateMonth[8] = 30;
		dateMonth[9] = 31;
		dateMonth[10] = 30;
		dateMonth[11] = 31;

		if (Util.checkEmbolism(year)) dateMonth[1] = 29;

		return dateMonth[month - 1];
	}

	/**
	 * 한 자리 숫자에 앞에 '0'을 붙여 String으로 return하는 메소드<br>
	 * : argument : str, int
	 *     
	 * @author : 정철우 
         * @e-mail : cwjung@mirenet.com 
	 */

	public static String addZero(String str) {

		return (Integer.toString(Integer.parseInt(str) + 100)).substring(1,3);
	}

	public static String addZero2(int num) {

		return (Integer.toString(num + 100)).substring(1,3);
	}
	
	/**
	 * 특정 디렉토리의 파일 삭제
	 * : argument : 파일위치 + 파일명
	 *     
	 * @author : 김영진 
         * @e-mail : yalli@miraenet.com
	 */
	
	public static void DeleteFile(String path)
	{
		
		File f = new File(path);
		f.delete();	

	}


	/**
	 * 현재 년/월/일
	 *     
	 * @author :  
     * @e-mail : 
	 */
	public static String[] GetTodayString()
    {

		java.util.SimpleTimeZone kst = new java.util.SimpleTimeZone(9*60*60*1000,"KST");
		java.util.Calendar cal = java.util.Calendar.getInstance(kst);

		String[] today = new String[3];
	
	    int year = cal.get(Calendar.YEAR);
		today[0] = Integer.toString(year);

		if((cal.get(Calendar.MONTH)+1) <10)
			today[1] = "0"+(cal.get(Calendar.MONTH)+1);
		else    today[1] +=  (cal.get(Calendar.MONTH)+1);
	
		if(cal.get(Calendar.DAY_OF_MONTH)<10) 
			today[2] = "0"+cal.get(Calendar.DAY_OF_MONTH);
	 	else    today[2] += cal.get(Calendar.DAY_OF_MONTH);
	
        return today;
     }

	public static int[] GetTodayInt()
    {

		java.util.SimpleTimeZone kst = new java.util.SimpleTimeZone(9*60*60*1000,"KST");
		java.util.Calendar cal = java.util.Calendar.getInstance(kst);

		int[] today = new int[3];
  
	    today[0] = cal.get(Calendar.YEAR);
	    today[1] = cal.get(Calendar.MONTH)+1;
	    today[2] = cal.get(Calendar.DAY_OF_MONTH);

        
        return today;
     }	
	
    /*
    * Date : yyyymmdd -> yyyy-mm-dd
    */
    public static String makeDateString(String date) {
 
        if (date.length() > 9) return date;
        return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6);
    }   
    
	/*
    * Date : yyyymmdd -> yyyy-mm-dd
    */
    public static String makeDateString2(String date) {
        return date.substring(0, 4) + "." + date.substring(5, 7) + "." + date.substring(8,10);
    }   

   /*
    * Date : yyyy-mm-dd -> yyyymmdd 
    */
    public static int makeDateInt(String date) {
        return Integer.parseInt(date.substring(0, 4)+date.substring(5, 7)+date.substring(8));
    }     

    /**
     * <pre>
     * text를 format에 맞추어 출력한다.
     * getFormatedText("0193372412","???-???-????") --->> 019-337-2412로 출력
     * </pre>
     *
     * @param String text
     * @param String format
     *
     * @return String
     */
    public static String getFormatedText(String text,String format)
    {
        String rtn;
        int start,i,j,len;
        int tCount,fCount;

        tCount = text.length();
        fCount = format.length();

        rtn = "";

        if (text.equals("")) return rtn;
        if (text.equals("&nbsp;")) return "&nbsp;";
        // text가 01252412 이고 format 이 ????-???? 이면 0125-2412로 출력
        //text에서 -를 제거한다.
        for (i=0; i<tCount; ++i) {
            if (!text.substring(i,i+1).equals("-"))
                rtn = rtn + text.substring(i,i+1);
        }

        text = rtn;
        tCount = text.length();

        //포멧에서 ?의  count
        len = 0;
        for (j=0; j<fCount; ++j) {
            if (format.substring(j,j+1).equals("?")) ++len;
        }
        //text의 길이가 len보다 작으면 앞에 0를 붙인다.
        if (tCount<len) {
            for (i=0; i<(len-tCount); ++i) {
                text = '0' + text;
            }
            tCount = len;
        }

        rtn = "";
        start = 0;
        for (i=0; i<tCount; ++i) {
            for (j=start; j<fCount; ++j) {
                if (format.substring(j,j+1).equals("?")) {
                    rtn = rtn + text.substring(i,i+1);
                    start = start + 1;
                    break;
                }
                else {
                    rtn = rtn + format.substring(j,j+1);
                    start = start + 1;
                }
            }
        }
        return rtn+format.substring(start);
    }    
    
    public static String lectureDate(String sdate, String edate)
    {
        String retval = null;
        boolean s = sdate.equals("00000000");
        boolean e = edate.equals("00000000");
        if(s){
            if(e){
                retval = "제한없음";   
            }else{
                retval = edate.substring(4,6) +"/"+ edate.substring(6) + " 까지";
            }
        }else{
            if(e){
                retval = sdate.substring(4,6) +"/"+ sdate.substring(6) + " 부터";
            }else{
                retval = sdate.substring(4,6) +"/"+ sdate.substring(6) + " ~ " + edate.substring(4,6) +"/"+ edate.substring(6);
            }            
        }   
        return retval;
    }


	public static void MoveFiles(String [] filename, String src, String des)
	{

		//파일을 이동한다
		if(filename!=null && filename.length>0){
			for(int i=0; i<filename.length; i++){
				File sf = new File(src + Util.toKSC(filename[i]));
				File desDir = new File(des);
				if(!desDir.exists()){
					desDir.mkdirs();	
				}
				File df = new File(des + Util.toKSC(filename[i]));
				sf.renameTo(df);
			}
		}
	}
    
    public static String sNull(String str)          
    {
            if(str==null)
            {
                return "";
            }
            else
            {
                return str; 
            }   
    }

	/*
	*
	*	str,str,str 이러한 형식으로 묶인것을 풀어서 쿼리에서 사용할 수 있도록 한다.
	*
	*	@author : Jin young sug
	*	@modify : 2003-08-06
	*
	*/
	public static String InnerQuery (String maskStr, String cond1, String cond2, String sourceStr, String delim)
	{
		StringBuffer innerQuery = new StringBuffer();
		StringTokenizer st = new StringTokenizer(sourceStr, delim);
		while (st.hasMoreTokens()) {
			innerQuery.append(maskStr);
			if (cond1.equals ("like")) {
				innerQuery.append(" like '");
				innerQuery.append(st.nextToken());
				innerQuery.append("%' ");
			}else{
				innerQuery.append(" = '");
				innerQuery.append(st.nextToken());
				innerQuery.append("' ");
			}

			innerQuery.append(cond2);
			innerQuery.append(" ");
		}

		innerQuery.delete (innerQuery.length() - cond2.length() - 1, innerQuery.length());
        
        return innerQuery.toString();
	}
	
	 // 두개의 날짜 받아서 날짜 차이 계산.."20031212,20031214"
   public static int getDiff_day(String firstday, String lastday)
   {
   
	   int mon[] = {0,31,28,31,30,31,30,31,31,30,31,30,31};
	   
	   int year = 0;
	   int month = 0;
	   int day = 0;
	   int Year = 0;
	   int Month = 0;
	   int Day = 0;
	
	   int yetDay =0;
	   if(firstday.length() > 8 || firstday.length() < 8 || lastday.length() < 8 || lastday.length() > 8)
	   		return 99999;
	   		
	   
	   year = Integer.parseInt(firstday.substring(0,4));
	   month = Integer.parseInt(firstday.substring(4,6));
	   day = Integer.parseInt(firstday.substring(6,8));
	   
	   Year = Integer.parseInt(lastday.substring(0,4));
	   Month = Integer.parseInt(lastday.substring(4,6));
	   Day = Integer.parseInt(lastday.substring(6,8));
	   
	   // 년도가 같을때 날짜 계산
	   if (year == Year)
	        {
	          for (int i = month ; i < Month ; i++)
	     	  {
	     	     // 윤달구하는 소스	
	     	     if (((year%400 == 0) || ((year%100 != 0) && (year%4 ==0))) && i==2)
	     	     yetDay++;	
	     	     yetDay += mon[i];
	           }
	         }
	   
	   // 년도가 차이날 경우 날짜 계산
	   else {
	         for (int i = year ; i <= Year ; i++)
	           {
	     	  if (i == year)
	     	     { 
	     	     for (int j = month + 1 ; j<=12 ; j++)
	     	        {
	     	         if (((year%400 == 0) || ((year%100 != 0) && (year%4 ==0))) && j==2)
	     	         yetDay++;	
	     	         yetDay += mon[j];
	     	        }
	     	      }
	     	 
	     	  else if (i == Year)
	     	  { 
	     	     for (int j = 1 ; j<= Month ; j++)
	     	       {
	     	         if (((year%400 == 0) || ((year%100 != 0) && (year%4 ==0))) && j==2)
	     	         yetDay++;	
	     	         yetDay += mon[j];
	     	        }   
	     	  }
	        
	        else 
	     	    {
	     	   	for (int j = 1 ; j <= 12 ; j++)
	     	        {
	     	         if (((year%400 == 0) || ((year%100 != 0) && (year%4 ==0))) && j==2)
	     	         yetDay++;	
	     	         yetDay += mon[j];
	     	         }
	     	      }    
	           }
	        }
	      yetDay += ( Day - day);
	    //  return Month;
	      // 남은 날짜를 반환
	      return yetDay;
   }
	
   /* *************************
    *특정 요일명을 알아온다.
    * inserted by jeonghwa, Kim
    **************************/
   public static String getDayName(int year, int month, int day) 
   {
       Date d = new Date(year-1900, month-1, day);
       String day_name="";
       switch(d.getDay())
       {
           case 0 : day_name="일요일"; break;
           case 1 : day_name="월요일"; break;
           case 2 : day_name="화요일"; break;
           case 3 : day_name="수요일"; break;
           case 4 : day_name="목요일"; break;
           case 5 : day_name="금요일"; break;
           case 6 : day_name="토요일"; break;
       }
       return day_name;
   }  
   
   /**
    * getCookie <br>
    * request로부터 들어온 Cookie에서 name에 해당하는 값을 받아온다.<br>
    * <br>

    * @param request HttpServletRequest
    * @param name String
    * @return String
    * @exception Exception
    * @since v0.9
    */
   public static String getCookie(HttpServletRequest request, String name)
   {
       if(name == null || name.length() == 0){
           return "";
       }
       else{
           try{
               Cookie[] cookies = request.getCookies();

               if(cookies != null){
                   for(int i=0 ; i < cookies.length ; i++){
                       if(cookies[i].getName().equals(name)){
                           return(URLDecoder.decode(cookies[i].getValue()));
                       }
                   }
               }
           }
           catch(Exception e){
               return "";
           }
       }
       return "";
   }
   
   /*
   public static String replace(String original, String oldstr, String newstr)
	{
		String convert = new String();
		int pos = 0;
		int begin = 0;
		
		original = original==null?"":original;
		pos = original.indexOf(oldstr);
	
		if(pos == -1)
			return original;
	
		while(pos != -1)
		{
			convert = convert + original.substring(begin, pos) + newstr;
			begin = pos + oldstr.length();
			pos = original.indexOf(oldstr, begin);
		}
		convert = convert + original.substring(begin);
	
		return convert;
	}
	*/
   
   public static String replace(String line, String oldString, String newString){
       // 원본 문자열이 null인지 검사
       if(line == null ) return line;
       // 원본문자열이 공백인지 검사
       if(line.equals("")) return line;
       // 대체 문자열이 동일한지 검사
       if(oldString.equals(newString)) return line;
       // 찾는문자열이 공백인지 검사
       if(oldString.equals("")) return line;
       // 대체 문자열이 원본 문자열을 포함하고 있는지 검사
       if(newString.indexOf(oldString) != -1 && newString.length() > oldString.length()){
           line = replace(line, oldString, "º");
           line = replace(line, "º", newString);
           return line;
       }
       
       int index=0;
       while((index = line.indexOf(oldString, index)) >= 0){
          line = new StringBuffer()
            .append(line.substring(0, index))
            .append(newString)
            .append(line.substring(index + oldString.length())).toString();
       }
       return line;
   }
   
   public static String BASE64Encoding (String value)
	{
       if(value != null){
           BASE64Encoder encoder = new BASE64Encoder();
           byte[] b_value = value.getBytes();
           String e_value = encoder.encode(b_value);
           return e_value;
       }
      
	
		return null;
	}
   
   public static String BASE64Decoding (String value)
	{
      if(value != null){
          try{
              sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
              byte[] b_value = decoder.decodeBuffer(value);
              String e_value = new String(b_value);
              return e_value;
              
          }catch(IOException e){
              e.printStackTrace();
          }
         
      }
     
	
		return null;
	}

   /**
    * getSchoolYear <br>
    * 02월15일 을 기준으로 이전이면 1년전의 년을, 이후면 현재년을 리턴.<br>
    * <br>
    * @return int
    * @since v0.9
    */ 
  public static int getSchoolYear(){
  
       int now =  Integer.parseInt(kr.co.imjk.util.DateUtils.getYYYYMMDD(new java.util.Date()));       
       int sub_now =  Integer.parseInt(String.valueOf(now).substring(4));
       if(sub_now> 214){
		   return Integer.parseInt(String.valueOf(now).substring(0,4));
          
       }else{
           now = now - 10000;
           return Integer.parseInt(String.valueOf(now).substring(0,4));
       }
  }
  
   
  /**
   * getSchoolYear <br>
   * 입력받은 날짜가 02월15일 이전이면 1년전의 년을, 이후면 현재년을 리턴.<br>
   * <br>
   * @param date java.util.Date
   * @return int
   * @since v0.9
   */ 
 public static String getSchoolYear(java.util.Date date){
 
      int now =  Integer.parseInt(kr.co.imjk.util.DateUtils.getYYYYMMDD(date));       
      int sub_now =  Integer.parseInt(String.valueOf(now).substring(4));
      if(sub_now> 214){
		   return String.valueOf(now).substring(0,4);
         
      }else{
          now = now - 10000;
          return String.valueOf(now).substring(0,4);
      }
 }
  
  /**
   * cutString <br>
   * 문자자르기.<br>
   * <br>
   * @return String
   * @since v0.9
   */ 
  public static String cutString(Object str, int limit) { 
	String text = (String) str; 

	int len = text.length(); 
	int cnt = 0, index = 0; 

	while (index < len && cnt < limit) { 
	if (text.charAt(index++) < 256) { // 1바이트 문자라면... 
	cnt++; // 길이 1 증가 
	} else { // 2바이트 문자라면... 
	cnt += 2; // 길이 2 증가 
	} 
	} 
	if (index < len) { 
	text = text.substring(0, index) + "..."; 
	} 
	return text; 
 }
  
  /* *************************
   * 오늘 요일을 알아온다.(숫자표시)
   * inserted by nayoung, jin
   **************************/
  public static int getToDayNum() 
  {
	String today_name = "";
	int today_num = 0;
	Calendar cal = Calendar.getInstance();
	
	int year  = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	int day   = cal.get(Calendar.DAY_OF_MONTH);
	
	Date d = new Date(year-1900, month-1, day);    
	today_num = d.getDay();	
	   
	return today_num;
  }  
  
	//euc-kr을 8859_1로 변환
	public static String toKorean(String str) {
		String convStr = null;
		try {
			if(str == null)
				return "";

			convStr = new String(str.getBytes("euc-kr"), "8859_1");
		} catch (UnsupportedEncodingException e) {
		}

		return convStr;
	}
      
    public static String encodeHTMLSpecialChar(String str,int n) {
        switch (n){
			case 1 : //subject text mode db입력
				str = rplc(str,"'","''");
			break;
			case 2 : //content text mode db입력
				str = rplc(str,"&","&amp;");
				str = rplc(str,"'","''");
			break;

			case 11 : 
				str = rplc(str,"\n","<br>");
			break;
			
            /*
			case 1 : // text mode db 입력
                     str = rplc(str,"<","&lt;");
                     str = rplc(str,"\"","&quot;");
            break;
            case 2 : // html mode db 입력
                     str = rplc(str,"<sc","<x-sc");
                     str = rplc(str,"<title","<x-title");
                     str = rplc(str,"<xmp","<x-xmp");
            break;
            case 11: // text 일때 CONENT 처리
                     //str = rplc(str," ","&nbsp;");
                     str = rplc(str,"\n","<br>");
            break;
            case 13: // comment 저장 일때
                     str = rplc(str,"<sc","<x-sc");
                     str = rplc(str,"<title","<x-title");
                     str = rplc(str,"<xmp","<x-xmp");
                     str = rplc(str,"\n","<br>");
            break;
            case 14 : // text mode db 입력
                     str = rplc(str,"&quot;","\"");
            break;
			*/
        } 
        return str;
    }


	public static String rplc(String mainString, String oldString, String newString) { 
        if (mainString == null) {
            return null;
        }
        if (oldString == null || oldString.length() == 0) {
            return mainString;
        }
        if (newString == null) {
            newString = "";
        }
        
        int i = mainString.lastIndexOf(oldString);
        if (i < 0)return mainString;
        StringBuffer mainSb = new StringBuffer(mainString);
        while (i >= 0) {
            mainSb.replace(i, (i + oldString.length()), newString);
            i = mainString.lastIndexOf(oldString, i - 1);
        }
        return mainSb.toString();
    } 
	/**
	 * 파일의 확장자를 리턴한다. ex) ".gif" 또는 ".wma" ...
	 * @param fileName
	 * @return
	 */
	public static String getFileExtName(String fileName){
	    String fileExtName = "";
	    int sepIndex = -1;
	    if(fileName != null){
		    //확장자 뽑아내기
		    sepIndex = fileName.indexOf(".");
		    if(sepIndex>0){
		        fileExtName =  fileName.substring(sepIndex);
		    }
	    }else{
	        fileExtName = "";
	    }
	    return fileExtName;
	}
	
	/**
	 * 파일의 확장자 이미지 링크를  리턴한다. ex) ".gif" 또는 ".wma" ...
	 * @param fileName
	 * @return
	 */ 
	public static String getFileExtImg(String fileName, String imageServer){
	    String fileExtName = "";
		int dot = fileName.lastIndexOf(".");
		String body ="";
		String ext ="";
		String ext_icon ="";
		if (dot != -1) {
	      body = fileName.substring(0, dot);
	      ext = fileName.substring(dot+1,fileName.length());  // includes "."
	    }else{
	      body = fileName;
	      ext = "";
	    }
	     
	    if(!ext.equals("")){
	    	ext = ext.toLowerCase();
	    	int pos = ext.indexOf("htm");
	    	if(pos >= 0 ){
	    		ext_icon = "<img src='"+imageServer+"img/icons/htm.gif' border=0>";	
	    	}else{
	    		ext_icon = "<img src='"+imageServer+"img/icons/"+ext+".gif' border=0>";
	    	}
	    }else{
	    	ext_icon = "";	
	    }
	    return ext_icon;
	}
 }
/*

 *
 * Jsp page를 위한 utility class
 */
package kr.co.imjk.util;


import java.text.SimpleDateFormat;





/**
 * JspBase 2003/11/18<br>
 * 모든 jsp는 이 class를 상속 받는다.<br>
 * jsp 내에서 사용할 간단한 utility method와 //System configuration
 * (com.imjk.blog.properties)에 대한 접근 기능을 제공한다.<br>
 * <br>
 * history<br>
 *

 */
public  class JspBase // extends org.apache.jasper.runtime.HttpJspBase// javax.servlet.jsp 
{
	
	


     
     public int [] JudisIndex = {23};

    /**
     * Do Nothing..
     */
    public static String decode(String str) {
        if (str==null) return null;
        try {return new String(str.getBytes("8859_1"),"ksc5601");}
        catch (Exception e) {return null;}
    }

    /**
     * 문자열이 지정된 길이 보다 긴 경우 지정된 길이에서 잘라내고 suffix를 붙인다.
     * @param src cut off할 문자열
     * @param len cut off기준 길이
     * @param suffix cut off 후 붙여주는 문자
     * @return cut off된 문자열
     */
    public static String cutOff(String src, int len, String suffix) {
		
		if (src.getBytes().length <= len) return src; 
		
		int j=0;
		String dest="";

		byte srcByte[] = src.getBytes();
		len = len-suffix.getBytes().length;
		
		for (int i=0 ; i<len ; i++) {
			if(srcByte[i]<0) j++;
		}
		
		if((j%2)==1) len = len - 1;
		
		try {
			dest = new String(src.getBytes("EUC-KR"), "8859_1");
			dest = dest.substring(0,len);
			dest = new String(dest.getBytes("8859_1"),"EUC-KR");
		} catch (Exception e) {return src;}
		
		return dest+suffix;
	}
    
    /**
     * 문자열이 지정된 길이 보다 긴 경우 지정된 길이에서 잘라내고 '...'을 붙인다.
     * @param src cut off할 문자열
     * @param leng cut off기준 길이
     * @return cut off된 문자열
     */
    public static String cutOff(String src,int leng) {
        if (src!=null && leng>0) {
            String dest=src;
            if (src.length()>leng) {dest=src.substring(0,leng)+"...";}
            return dest;
        }
        return null;
    }

   
    /**
    * 지정된 길이 만큼 문자열을 자른다.
    *
    * @param srcString 대상 문자열
    * @param length 길이
    * @return 
    */
    public static String cutOffString(String src, int leng){
        if (src!=null && leng>0) {
            String dest=src;
            if (src.length()>leng) {dest=src.substring(0,leng);}
            return dest;
        }
        return null;   
    }

    /**
    * MasterOrderId cut off
    */
    public static String makeSubOrderId(String masterOrderId, String orderType){
        if(masterOrderId.length() == 11 ){
            return cutOffString(masterOrderId, 10)+orderType;
        }else{
            return masterOrderId+orderType;
        }
    }



    /**
     * 문자열이 null이거나 공백인지 검사.
     * @param str null이거나 공백인지 검사할 문자열
     * @return 검사 결과
     */
    public static boolean isNull(String str) {
        return (str==null || str.trim().length()==0);
    }

    /**
     * 문자열이 null이면 이를 빈 문자열로 변환.
     * @param str 변환할 문자열
     * @return 빈 문자열
     */
    public static String replaceNull(String str) {
        return (str==null)?"":str;
    }

    /**
     * yyyymm의 날짜를 yyyy.mm으로 return;
     */

    public static String formatDateYYYYMM( String yyyymm ) {
  	if( yyyymm == null ) return "";
  	if( yyyymm.length() < 6 ) return yyyymm;

  	return yyyymm.substring(0,4)+"."+yyyymm.substring(4,6);
    }

    /**
     * yyyymmdd의 날짜를 yyyy.mm.dd으로 return;
     */

    public static String formatDateYYYYMMDD( String yyyymmdd ) {
  	if( yyyymmdd == null ) return "";
  	if( yyyymmdd.length() < 8 ) return yyyymmdd;

  	return yyyymmdd.substring(0,4)+"."+yyyymmdd.substring(4,6)+"."+yyyymmdd.substring(6,8);
    }

    /**
     * yyyymmdd의 날짜를 yyyy-mm-dd으로 return;
     */

    public static String formatDateDashYYYYMMDD( String yyyymmdd ) {
	  	if( yyyymmdd == null ) return "";
	  	if( yyyymmdd.length() < 8 ) return yyyymmdd;
	
	  	return yyyymmdd.substring(0,4)+"-"+yyyymmdd.substring(5,7)+"-"+yyyymmdd.substring(8,10);
    }


	public static String formatDateBarYYYYMMDD( String yyyymmdd ) {
	  	if( yyyymmdd == null ) return "";
	  	if( yyyymmdd.length() < 8 ) return yyyymmdd;
	
	  	return yyyymmdd.substring(0,4)+"-"+yyyymmdd.substring(4,6)+"-"+yyyymmdd.substring(6,8);
	}
    
    /**
     * Date를 지정된 로케일에 따라 포멧팅.
     * @param d 포멧할 날자정보
     * @param style 포멧 스타일 java.text.DateFormat.[SHORT|MEDIUM|LONG|FULL]
     * @return 포멧팅 된 문자열
     */
    public String formatDate(java.util.Date d,int style) {
        if (d==null) return "";
        java.text.DateFormat df=java.text.DateFormat.getDateInstance(style);
        return df.format(d).replace('-','.');
    }

    /**
     * Date를 지정된 로케일에 따라 SHORT형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateShort(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.SHORT);
    }

    /**
     * Date를 지정된 로케일에 따라 MEDIUM형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateMedium(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.MEDIUM);
    }

    /**
     * Date를 지정된 로케일에 따라 LONG형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateLong(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.LONG);
    }

    /**
     * Date를 지정된 로케일에 따라 FULL형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateFull(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.FULL);
    }

    /**
     * Date를 지정된 로케일에 따라 포멧팅. 년월시분초.
     * @param d 포멧할 날자정보
     * @param style 포멧 스타일 java.text.DateFormat.[SHORT|MEDIUM|LONG|FULL]
     * @return 포멧팅 된 문자열
     */
    public String formatDateTime(java.util.Date d,int style) {
        if (d==null) return "-";
        java.text.DateFormat df=java.text.DateFormat.getDateTimeInstance(style,style);
        return df.format(d).replace('-','.');
    }

    /**
     * Date를 지정된 로케일에 따라 SHORT형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateTimeShort(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.SHORT);
    }

    /**
     * Date를 지정된 로케일에 따라 MEDIUM형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateTimeMedium(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.MEDIUM);
    }

    /**
     * Date를 지정된 로케일에 따라 LONG형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateTimeLong(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.LONG);
    }

    /**
     * Date를 지정된 로케일에 따라 FULL형식으로 포멧팅.
     * @param d 포멧할 날자정보
     * @return 포멧팅 된 문자열
     */
    public String formatDateTimeFull(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.FULL);
    }

    /**
    * Timestamp의 값을 YYYY.MM.DD HH:MI 형식으로 포멧팅
     * @param d 포멧할 timestamp
     * @return 포멧팅 된 문자열
     */
     public String timestampFormat(java.sql.Timestamp d){
        if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("yyyy.MM.dd  a  hh:mm");
        return  formatter.format(d);

    }

    /**
    * Timestamp의 값을 YYYY 형식으로 포멧팅
     * @param d 포멧할 timestamp
     * @return 포멧팅 된 문자열
     */
     public String timestampFormatYear(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("yyyy");
        return  formatter.format(d);

    }

    /**
    * Timestamp의 값을 MM 형식으로 포멧팅
     * @param d 포멧할 timestamp
     * @return 포멧팅 된 문자열
     */
     public String timestampFormatMonth(java.sql.Timestamp d){
        if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("MM");
        return  formatter.format(d);

    }

    /**
    * Timestamp의 값을 dd 형식으로 포멧팅
     * @param d 포멧할 timestamp
     * @return 포멧팅 된 문자열
     */
     public String timestampFormatDay(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("dd");
        return  formatter.format(d);

    }

    /**
    * Timestamp의 값을 0~24 형식으로 포멧팅
     * @param d 포멧할 timestamp
     * @return 포멧팅 된 문자열
     */
     public String timestampFormatHour(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("k");
        return  formatter.format(d);

}

    /**
    * timestamp의 값을 YYYYMMDD로 포멧팅
    * @param d 포멧할 timestamp
    * @return 포멧팅 된 문자열
    */
    public String timestampFormatYYYYMMDD(java.sql.Timestamp d){
            if(d == null) return "";
            SimpleDateFormat formatter
                 =new SimpleDateFormat("yyyyMMdd");
             return formatter.format(d);

    }

    /**
    * Timestamp의 값을 0~24 형식으로 포멧팅
     * @param d 포멧할 timestamp
     * @return 포멧팅 된 문자열
     */
     public String timestampFormatMinute(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("mm");
        return  formatter.format(d);

    }

    /**
    * 1자리 integer --> 2자리 String로 포멧팅
    * @param 포캣할 integer
    * @return 포멧팅 된 문자열
    */
    public String IntegerTo2LengthString(int d){
        return d <10? "0"+d:""+d;
    }



    /**
     * 로케일 지정. <b>Not implemented yet!!</b>
     */
    public void initLocale(java.util.Locale locale) {
    }


 

  

    /**
    * 숫자 형식을 가격정보로 설정 <br>
    *
    * @param price 가격
    * @parma return "," "원" 이 포함된 가격정보
    */
    public static String formatPrice(long price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        return nf.format(price)+" 원";
    }

    /**
    * 숫자 형식 설정 <br>
    *
    * @param price 가격
    * @parma return "," 이 포함된 가격정보
    */
    public static String formatNumber(long price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        return nf.format(price);
    }

        /**
    * 숫자 형식 설정 <br>
    *
    * @param price 가격
    * @parma return "," 이 포함된 가격정보
    */
    public static String formatNumber(double price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        return nf.format(price);
    }

    /**
    * 숫자 형식 설정 <br>
    *
    * @param price 가격
    * @parma return ","와 소수점 생략 포함되지 않은 형식
    */
    public static String formatNumberWithoutComma(double price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        nf.setGroupingUsed(false);
        return nf.format(price);
    }
    
    /** 
    * 숫자 형식 설정<br>
    *
    * @param number 대상 수
    * @param places 소숫점 자릿수
    * @param return 소숫점 자리 cutting
    */
    public static String formatNumberNPlaces(double price , int places){
        if (price==0) {return "0";  }
        else if (java.lang.Double.isNaN(price)) { return "-";  }
        else {
            java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
            nf.setMinimumFractionDigits(places);
            nf.setMaximumFractionDigits(places);
            //nf.setGroupingUsed(false);
            return nf.format(price);
        }
    }
    

    public static String formatNumberWithoutCommaNPlaces(double price , int places){
        if (price==0) {return "0";  }
        else if (java.lang.Double.isNaN(price)) { return "0";  }
        else {
            java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
            nf.setGroupingUsed(false);
            nf.setMinimumFractionDigits(places);
            nf.setMaximumFractionDigits(places);
            //nf.setGroupingUsed(false);
            return nf.format(price);
        }
    }
    

    /**
    * String을  double 로 변환 <br>
    * @param comma가 없는 String
    * @return  double
    */
   public static double formatDouble(String price){
        if(isNull(price)) return 0;
        return Double.parseDouble(StringUtil.strReplace(price,",",""));
    }



    /**
    * 내용을 HTML형식으로 출력한다.
    * \n은 <br>을 넣고
    */
    public static String convertHtmlBr(String comment)  {
       if(comment == null || comment.equals("")) return comment;

       int length = comment.length();
       StringBuffer buffer = new StringBuffer();

       for ( int i = 0; i < length; ++i)
       {
               String comp = comment.substring(i, i+1);
               if ("\r".compareTo(comp) == 0)
               {
                       comp = comment.substring(++i, i+1);
                       if ("\n".compareTo(comp) == 0)
                               buffer.append("<BR>\r");
                       else
                               buffer.append("\r");
               }

               buffer.append(comp);
       }
       return buffer.toString();
    }

    /**
    * 특수문자 출력이 되도록 한다.
    * " -> &quot;
    */
    public static String convertSpecialCharacter(String comment)  {
       if(comment == null || comment.equals("")) return comment;

       int length = comment.length();
       StringBuffer buffer = new StringBuffer();

       for ( int i = 0; i < length; ++i)
       {
               String comp = comment.substring(i, i+1);
               if ("\"".compareTo(comp) == 0) buffer.append("&quot;");
               else buffer.append(comp);
       }
       return buffer.toString();
    }
    
 
    
	public String replace(String original, String oldstr, String newstr)
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

    /**
     * 문자열을 바꾼다.
     * @param strVal
     * @return String
     */
	public String convertToHtml(String strVal) {
		String rtnVal = new String();
		
		strVal = replace(strVal, "&", "&amp;");
		strVal = replace(strVal, "<", "&lt");
		strVal = replace(strVal, ">", "&gt");
		
		rtnVal = strVal;
		
		return rtnVal;
	}
}



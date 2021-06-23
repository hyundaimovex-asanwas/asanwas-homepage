




package kr.co.imjk.util;

import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.text.StringCharacterIterator;


/**
 * <p>DateUtils
 * <p>날자 관련 Utility
 * <br>
 * <p> History
 * <p> 1.1 (2002-05-08)
 * <p> getYYYYMMDDHHMISS 추가
 * <p>
 * @version 1.1
 */
public class DateUtils {
/**
 * 윤년여부를 판단한다.
 */
  private static boolean isLeapYear (int year) {
    return (((year % 4)==0) && ((year % 100)!=0) || ((year % 400)==0));
  }

/**
 * year, month 내의 일수를 계산한다.
 */
  public static int getDaysInMonth(int year,int month)  {
    int days=0;
    if (month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)  days=31;
    else if (month==4 || month==6 || month==9 || month==11) days=30;
    else if (month==2)  {
      if (isLeapYear(year)) { days=29; }
      else { days=28; }
    }
    return days;
  }

/**
 * Calendar내의 년월일을 YYYYMMDD형식의 문자열로 변환한다.
 */
  public static String getYYYYMMDD(Calendar cal) {
    if( cal == null ) return "";
    String YYMMDD=null;
    int yyyy=cal.get(Calendar.YEAR);
    int mm=cal.get(Calendar.MONTH)+1;
    int dd=cal.get(Calendar.DATE);
    YYMMDD=Integer.toString(yyyy);
    if (mm<10) {YYMMDD=YYMMDD+"0"+Integer.toString(mm);}
    else {YYMMDD=YYMMDD+Integer.toString(mm);}
    if (dd<10) {YYMMDD=YYMMDD+"0"+Integer.toString(dd);}
    else {YYMMDD=YYMMDD+Integer.toString(dd);}
    return YYMMDD;
  }

/**
 * Calendar내의 년월일을 YYYYMMDDHHMISS형식의 문자열로 변환한다.
 */
  public static String getYYYYMMDDHHMISS(Calendar cal) {
    if( cal == null ) return "";
    String YYMMDDHHMISS=null;
    int yyyy=cal.get(Calendar.YEAR);
    int mm=cal.get(Calendar.MONTH)+1;
    int dd=cal.get(Calendar.DATE);
    int hh=cal.get(Calendar.HOUR_OF_DAY);
    int mi=cal.get(Calendar.MINUTE);
    int ss=cal.get(Calendar.SECOND);

    YYMMDDHHMISS=Integer.toString(yyyy);
    if (mm<10) {YYMMDDHHMISS=YYMMDDHHMISS+"0"+Integer.toString(mm);}
    else {YYMMDDHHMISS=YYMMDDHHMISS+Integer.toString(mm);}
    if (dd<10) {YYMMDDHHMISS=YYMMDDHHMISS+"0"+Integer.toString(dd);}
    else {YYMMDDHHMISS=YYMMDDHHMISS+Integer.toString(dd);}
    if (hh<10) {YYMMDDHHMISS=YYMMDDHHMISS+"0"+Integer.toString(hh);}
    else {YYMMDDHHMISS=YYMMDDHHMISS+Integer.toString(hh);}
    if (mi<10) {YYMMDDHHMISS=YYMMDDHHMISS+"0"+Integer.toString(mi);}
    else {YYMMDDHHMISS=YYMMDDHHMISS+Integer.toString(mi);}
    if (ss<10) {YYMMDDHHMISS=YYMMDDHHMISS+"0"+Integer.toString(ss);}
    else {YYMMDDHHMISS=YYMMDDHHMISS+Integer.toString(ss);}
    return YYMMDDHHMISS;
  }

/**
 * Calendar내의 년월일을 MMDDYYYY형식의 문자열로 변환한다.
 */
  public static String getMMDDYYYY(Calendar cal) {
    if( cal == null ) return "";
    
    String MMDDYY=null;
    int yyyy=cal.get(Calendar.YEAR);
    int mm=cal.get(Calendar.MONTH)+1;
    int dd=cal.get(Calendar.DATE);

    if (mm<10) {MMDDYY = "0"+Integer.toString(mm);}
    else {MMDDYY = Integer.toString(mm);}
    if (dd<10) {MMDDYY=MMDDYY+"0"+Integer.toString(dd);}
    else {MMDDYY=MMDDYY+Integer.toString(dd);}
    MMDDYY =MMDDYY+Integer.toString(yyyy);
    return MMDDYY;
  }

/**
 * Calendar내의 년월일을 MMDDYYYYHHMISS형식의 문자열로 변환한다.
 */
  public static String getMMDDYYYYHHMISS(Calendar cal) {
    if( cal == null ) return "";
    String MMDDYYHHMISS=null;
    int yyyy=cal.get(Calendar.YEAR);
    int mm=cal.get(Calendar.MONTH)+1;
    int dd=cal.get(Calendar.DATE);
    int hh=cal.get(Calendar.HOUR_OF_DAY);
    int mi=cal.get(Calendar.MINUTE);
    int ss=cal.get(Calendar.SECOND);

    if (mm<10) {MMDDYYHHMISS = "0"+Integer.toString(mm);}
    else {MMDDYYHHMISS = Integer.toString(mm);}
    if (dd<10) {MMDDYYHHMISS=MMDDYYHHMISS+"0"+Integer.toString(dd);}
    else {MMDDYYHHMISS=MMDDYYHHMISS+Integer.toString(dd);}
    MMDDYYHHMISS =MMDDYYHHMISS+Integer.toString(yyyy);
    if (hh<10) {MMDDYYHHMISS=MMDDYYHHMISS+"0"+Integer.toString(hh);}
    else {MMDDYYHHMISS=MMDDYYHHMISS+Integer.toString(hh);}
    if (mi<10) {MMDDYYHHMISS=MMDDYYHHMISS+"0"+Integer.toString(mi);}
    else {MMDDYYHHMISS=MMDDYYHHMISS+Integer.toString(mi);}
    if (ss<10) {MMDDYYHHMISS=MMDDYYHHMISS+"0"+Integer.toString(ss);}
    else {MMDDYYHHMISS=MMDDYYHHMISS+Integer.toString(ss);}
    return MMDDYYHHMISS;
  }

/**
 * Calendar내의 년월일을 DDMMYYYY형식의 문자열로 변환한다.
 */
  public static String getDDMMYYYY(Calendar cal) {
    if( cal == null ) return "";
    
    String MMDDYY=null;
    int yyyy=cal.get(Calendar.YEAR);
    int mm=cal.get(Calendar.MONTH)+1;
    int dd=cal.get(Calendar.DATE);

    if (dd<10) {MMDDYY="0"+Integer.toString(dd);}
    else {MMDDYY=Integer.toString(dd);}
    if (mm<10) {MMDDYY = MMDDYY+"0"+Integer.toString(mm);}
    else {MMDDYY = MMDDYY+Integer.toString(mm);}

    MMDDYY =MMDDYY+Integer.toString(yyyy);
    return MMDDYY;
  }

/**
 * Calendar내의 년월일을 DDMMYYYYHHMISS형식의 문자열로 변환한다.
 */
  public static String getDDMMYYYYHHMISS(Calendar cal) {
    if( cal == null ) return "";
    
    String DDMMYYHHMISS=null;
    int yyyy=cal.get(Calendar.YEAR);
    int mm=cal.get(Calendar.MONTH)+1;
    int dd=cal.get(Calendar.DATE);
    int hh=cal.get(Calendar.HOUR_OF_DAY);
    int mi=cal.get(Calendar.MINUTE);
    int ss=cal.get(Calendar.SECOND);

    if (dd<10) {DDMMYYHHMISS="0"+Integer.toString(dd);}
    else {DDMMYYHHMISS=Integer.toString(dd);}
    if (mm<10) {DDMMYYHHMISS = DDMMYYHHMISS+"0"+Integer.toString(mm);}
    else {DDMMYYHHMISS = DDMMYYHHMISS+Integer.toString(mm);}
    DDMMYYHHMISS =DDMMYYHHMISS+Integer.toString(yyyy);
    if (hh<10) {DDMMYYHHMISS=DDMMYYHHMISS+"0"+Integer.toString(hh);}
    else {DDMMYYHHMISS=DDMMYYHHMISS+Integer.toString(hh);}
    if (mi<10) {DDMMYYHHMISS=DDMMYYHHMISS+"0"+Integer.toString(mi);}
    else {DDMMYYHHMISS=DDMMYYHHMISS+Integer.toString(mi);}
    if (ss<10) {DDMMYYHHMISS=DDMMYYHHMISS+"0"+Integer.toString(ss);}
    else {DDMMYYHHMISS=DDMMYYHHMISS+Integer.toString(ss);}

    return DDMMYYHHMISS;
  }

/**
 * Date Type의 년월일을 YYYYMMDD형식의 문자열로 변환한다.
 */
  public static String getYYYYMMDD(Date d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getYYYYMMDD(cal);
  }

/**
 * Date Type의 년월일을 YYYYMMDDHHMISS형식의 문자열로 변환한다.
 */
  public static String getYYYYMMDDHHMISS(Date d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getYYYYMMDDHHMISS(cal);
  }

/**
 * Date Type의 년월일을 MMDDYYYY형식의 문자열로 변환한다.
 */
  public static String getMMDDYYYY(Date d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getMMDDYYYY(cal);
  }

/**
 * Date Type의 년월일을 MMDDYYYYHHMISS형식의 문자열로 변환한다.
 */
  public static String getMMDDYYYYHHMISS(Date d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getMMDDYYYYHHMISS(cal);
  }

/**
 * Date Type의 년월일을 DDMMYYYY형식의 문자열로 변환한다.
 */
  public static String getDDMMYYYY(Date d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getDDMMYYYY(cal);
  }

/**
 * Date Type의 년월일을 DDMMYYYYHHMISS형식의 문자열로 변환한다.
 */
  public static String getDDMMYYYYHHMISS(Date d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getDDMMYYYYHHMISS(cal);
  }

/**
 * Timestamp Type의 년월일을 YYYYMMDD형식의 문자열로 변환한다.
 */
  public static String getYYYYMMDD(Timestamp d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getYYYYMMDD(cal);
  }

/**
 * Timestamp Type의 년월일을 YYYYMMDDHHMISS형식의 문자열로 변환한다.
 */
  public static String getYYYYMMDDHHMISS(Timestamp d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getYYYYMMDDHHMISS(cal);
  }

/**
 * Timestamp Type의 년월일을 MMDDYYYY형식의 문자열로 변환한다.
 */
  public static String getMMDDYYYY(Timestamp d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getMMDDYYYY(cal);
  }

/**
 * Timestamp Type의 년월일을 MMDDYYYYHHMISS형식의 문자열로 변환한다.
 */
  public static String getMMDDYYYYHHMISS(Timestamp d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getMMDDYYYYHHMISS(cal);
  }

/**
 * Timestamp Type의 년월일을 MMDDYYYY형식의 문자열로 변환한다.
 */
  public static String getDDMMYYYY(Timestamp d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getDDMMYYYY(cal);
  }

/**
 * Timestamp Type의 년월일을 MMDDYYYYHHMISS형식의 문자열로 변환한다.
 */
  public static String getDDMMYYYYHHMISS(Timestamp d) {
    if( d == null ) return "";
    Calendar cal=Calendar.getInstance();
    cal.setTime(d);
    return getDDMMYYYYHHMISS(cal);
  }

/**
 * YYYYMMDD형식의 문자열을 Calendar형식으로 변환
 */
  public static Calendar getCalenderYYYYMMDD(String YYYYMMDD) throws NumberFormatException {
    if( YYYYMMDD == null || "".equals(YYYYMMDD) ) return null;
    Calendar cal=Calendar.getInstance();
    String yyyyStr=YYYYMMDD.substring(0,4);
    String mmStr=YYYYMMDD.substring(4,6);
    String ddStr=YYYYMMDD.substring(6,8);
    int yyyy=Integer.parseInt(yyyyStr);
    int mm=Integer.parseInt(mmStr);
    int dd=Integer.parseInt(ddStr);
    int hh=0;
    int mi=0;
    int ss=0;
    if (YYYYMMDD.length()>=10) hh=Integer.parseInt(YYYYMMDD.substring(8,10));
    if (YYYYMMDD.length()>=12) mi=Integer.parseInt(YYYYMMDD.substring(10,12));
    if (YYYYMMDD.length()>=14) ss=Integer.parseInt(YYYYMMDD.substring(12,14));
    cal.set(yyyy,mm-1,dd,hh,mi,ss);
    return cal;
  }



/**
 * MMDDYYYY형식의 문자열을 Calendar형식으로 변환
 */
  public static Calendar getCalenderMMDDYYYY(String MMDDYYYY) throws NumberFormatException {
    if( MMDDYYYY == null ||  "".equals(MMDDYYYY)) return null;
    Calendar cal=Calendar.getInstance();
    String mmStr=MMDDYYYY.substring(0,2);
    String ddStr=MMDDYYYY.substring(2,4);
    String yyyyStr=MMDDYYYY.substring(4,8);
    int mm=Integer.parseInt(mmStr);
    int dd=Integer.parseInt(ddStr);
    int yyyy=Integer.parseInt(yyyyStr);
    int hh=0;
    int mi=0;
    int ss=0;
    if (MMDDYYYY.length()>=10) hh=Integer.parseInt(MMDDYYYY.substring(8,10));
    if (MMDDYYYY.length()>=12) mi=Integer.parseInt(MMDDYYYY.substring(10,12));
    if (MMDDYYYY.length()>=14) ss=Integer.parseInt(MMDDYYYY.substring(12,14));
    cal.set(yyyy,mm-1,dd,hh,mi,ss);
    return cal;
  }

/**
 * DDMMYYYY형식의 문자열을 Calendar형식으로 변환
 */
  public static Calendar getCalenderDDMMYYYY(String DDMMYYYY) throws NumberFormatException {
    if( DDMMYYYY == null ||  "".equals(DDMMYYYY)) return null;
    Calendar cal=Calendar.getInstance();
    String ddStr=DDMMYYYY.substring(0,2);
    String mmStr=DDMMYYYY.substring(2,4);
    String yyyyStr=DDMMYYYY.substring(4,8);
    int dd=Integer.parseInt(ddStr);
    int mm=Integer.parseInt(mmStr);
    int yyyy=Integer.parseInt(yyyyStr);
    int hh=0;
    int mi=0;
    int ss=0;
    if (DDMMYYYY.length()>=10) hh=Integer.parseInt(DDMMYYYY.substring(8,10));
    if (DDMMYYYY.length()>=12) mi=Integer.parseInt(DDMMYYYY.substring(10,12));
    if (DDMMYYYY.length()>=14) ss=Integer.parseInt(DDMMYYYY.substring(12,14));
    cal.set(yyyy,mm-1,dd,hh,mi,ss);
    return cal;
  }

/**
 * YYYYMMDD형식의 문자열을 Date형식으로 변환
 */
  public static Date getDateYYYYMMDD(String YYYYMMDD) throws NumberFormatException {
    if( YYYYMMDD == null ||  "".equals(YYYYMMDD)) return null;
    return getCalenderYYYYMMDD(YYYYMMDD).getTime();
  }

/**
 * MMDDYYYY형식의 문자열을 Date형식으로 변환
 */
  public static Date getDateMMDDYYYY(String MMDDYYYY) throws NumberFormatException {
    if( MMDDYYYY == null ||  "".equals(MMDDYYYY) ) return null;
    return getCalenderMMDDYYYY(MMDDYYYY).getTime();
  }

/**
 * DDMMYYYY형식의 문자열을 Date형식으로 변환
 */
  public static Date getDateDDMMYYYY(String DDMMYYYY) throws NumberFormatException {
    if( DDMMYYYY == null ||  "".equals(DDMMYYYY)) return null;
    return getCalenderDDMMYYYY(DDMMYYYY).getTime();
  }

/**
 * YYYYMMDD형식의 문자열을 Timestamp형식으로 변환
 */
  public static Timestamp getTimestampYYYYMMDD(String YYYYMMDD) throws NumberFormatException {
    if( YYYYMMDD == null ||  "".equals(YYYYMMDD) ) return null;
    return new Timestamp(getDateYYYYMMDD(YYYYMMDD).getTime());
  }

/**
 * MMDDYYYY형식의 문자열을 Timestamp형식으로 변환
 */
  public static Timestamp getTimestampMMDDYYYY(String MMDDYYYY) throws NumberFormatException {
    if( MMDDYYYY == null ||  "".equals(MMDDYYYY)) return null;
    return new Timestamp(getDateMMDDYYYY(MMDDYYYY).getTime());
  }

/**
 * DDMMYYYY형식의 문자열을 Timestamp형식으로 변환
 */
  public static Timestamp getTimestampDDMMYYYY(String DDMMYYYY) throws NumberFormatException {
    if( DDMMYYYY == null ||  "".equals(DDMMYYYY)) return null;
    return new Timestamp(getDateDDMMYYYY(DDMMYYYY).getTime());
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
     * yyyy-mm-dd의 날짜를 yyyy.mm.dd으로 return;
     */
    
    public static String formatDateYYYYMMDD2( String yyyy_mm_dd ) {
        ////System.out.println("==================>"+yyyy_mm_dd);
      	if( yyyy_mm_dd == null ) return "";
      	if( yyyy_mm_dd.length() < 10 ) return yyyy_mm_dd;
      	String yyyymmdd = Util.replaceAll(yyyy_mm_dd, "-", ".");
      	////System.out.println("=========ca=========>"+yyyymmdd);
      	////System.out.println("-------------DATE-------------->"+yyyymmdd);
      	return yyyymmdd;
    }
    
    /**
     * yyyymmdd의 날짜를 yyyy.mm.dd으로 return;
     */

    public static String formatDateYYYYMMDD( java.util.Date d ) {
  	if( d == null ) return "";
  	
  	String outD = d.toString();

  	return outD.substring(0,4)+"."+outD.substring(5,7)+"."+outD.substring(8,10);
    }

    /**
     * yyyy.mm.dd의 날짜를 yyyymmdd으로 return;
     */

    public static String formatDateYYYYMMDDdot( String yyyymmdd ) {
        if( yyyymmdd == null ) return "";
        if( yyyymmdd.length() < 10 ) return yyyymmdd;

        return yyyymmdd.substring(0,4)+yyyymmdd.substring(5,7)+yyyymmdd.substring(8,10);
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
     * Date를 지정된 로케일에 따라 포멧팅.
     * @param d 포멧할 날자정보
     * @param style 포멧 스타일 ex) yyyyMMdd
     * @return 포멧팅 된 문자열
     */
    public static String formatSimpleDate(java.util.Date d, String type) {
        if (d==null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat(type);
        
        return sdf.format(d);
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
     * <pre>
     * 시스템 날짜를 리턴
     * @param int
     * 0 : 20020621182030형태로 리턴
     * 1 : 20020621(YYYYMMDD)형태로 리턴 
     * 2 : 200206(YYYYMM)형태로 리턴
     * </pre>
     *
     * @return String
     */
    public static String getSysDate(int i)
    {
        String second, minute, hour;
        Calendar cal = Calendar.getInstance();

        String year  = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH)+1);
        String day   = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        if((cal.get(Calendar.MONTH)+1) < 10) month = "0" + String.valueOf((cal.get(Calendar.MONTH)+1));
        else month = String.valueOf((cal.get(Calendar.MONTH)+1));

        if(cal.get(Calendar.DAY_OF_MONTH) < 10) day = "0" + String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
        else day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        if(cal.get(Calendar.HOUR_OF_DAY) < 10) hour = "0" + String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
        else hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));

        if(cal.get(Calendar.MINUTE) < 10) minute = "0" + String.valueOf(cal.get(Calendar.MINUTE));
        else minute = String.valueOf(cal.get(Calendar.MINUTE));

        if(cal.get(Calendar.SECOND) < 10) second = "0" + String.valueOf(cal.get(Calendar.SECOND));
        else second = String.valueOf(cal.get(Calendar.SECOND));
        
        switch(i) {
            case 0 : 
                return year + month + day + hour+ minute + second;
            case 1 :
                return year + month + day ;
            case 2 :
                return year + month;
        }
        return year + month + day + hour+ minute + second;
    } 
 
}

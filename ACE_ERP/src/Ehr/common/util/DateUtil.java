package Ehr.common.util;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtil{

    /**
     * 스트링을 Date형으로 변환
     * @param dateStr
     * @return
     */
    public static Date parseDate(String dateStr) {
        SimpleDateFormat formatter      = null;
        Date            date            = null;

        String[]        formats         = {"yyyy-MM-dd", "yyyy.MM.dd", "yyyy,MM,dd", "yyyyMMdd", "yyyy/MM/dd"};

        for(int i=0; i<formats.length; i++) {
            formatter                   = new SimpleDateFormat(formats[i]);
            try{
                date                    = formatter.parse(dateStr);
            }catch (Exception ex) {
            }

            if(date != null) break;
        }
        if(date == null) return getCurrentDate();
        return date;
    }

    /**
     * 시작 날짜와 끝 날짜간의 차이를 반환
     * @param beginDateStr
     * @param endDateStr
     * @return Date
     */
    public static Calendar getCompareDate(String beginDateStr, String endDateStr) {

        Date            beginDate       = parseDate(beginDateStr);
        Date            endDate         = parseDate(endDateStr);

        return getCompareDate(beginDate, endDate);
    }

    /**
     * 시작 날짜와 끝 날짜간의 차이를 반환
     * (년도 값을 사용하기 전 -1970 를 빼고 사용)
     * @param beginDate
     * @param endDate
     * @return Date
     */
    public static Calendar getCompareDate(Date beginDate, Date endDate) {
        Calendar        calendar        = new GregorianCalendar();

        Date            compareDate     = new Date(endDate.getTime() - beginDate.getTime());

        calendar.setTime(compareDate);
        return calendar;
    }


    /**
     * 현재 날짜 가져와서 반환
     * (yyyyMMdd)
     *
     * @return String
     */
    public static String getCurrentDateStr() {
        return getCurrentDateStr("yyyyMMdd");
    }

    /**
     * 현재 날짜를 원하는 포맷으로 가져옴
     * @param format
     * @return String
     */
    public static String getCurrentDateStr(String format) {
        return getConvertDateFormat(getCurrentDate(), format);
    }

    /**
     * 원하는 형식으로 날짜 형식 변경
     * @param date
     * @param format
     * @return
     */
    public static String getConvertDateFormat(String dateStr, String format) {
        return getConvertDateFormat(parseDate(dateStr), format);
    }

    /**
     * 원하는 형식으로 날짜 형식 변경
     * @param date
     * @param format
     * @return
     */
    public static String getConvertDateFormat(Date date, String format) {
        SimpleDateFormat
                        simpleDateFormate
                                        = null;
        simpleDateFormate               = new SimpleDateFormat(format);

        return simpleDateFormate.format(date);
    }

    /**
     * 현재 날짜를 가져옴
     * @return Date
     */
    public static Date getCurrentDate() {
        Calendar        calendar        = null;

        //현재 날짜 가져오기
        calendar                        = Calendar.getInstance();

        return  calendar.getTime();
    }

    /**
     * 현재 년도를 가져옴
     * @return (yyyy)
     */
    public static String getCurrentYear() {
        String year = null;
        String date = getCurrentDateStr();

        try{
            year = date.substring(0, 4);
        }catch(IndexOutOfBoundsException e) {
            year = "0000";
        }

        return year;
    }

    /**
     * 현재 시간을 가져옴
     * @return
     */
    public static String getCurrentTime() {
        Calendar        calendar        = null;
        SimpleDateFormat
                        simpleDateFormate
                                        = null;
        String          currentTime     = null;

        //현재 날짜 가져오기
        calendar                        = Calendar.getInstance();
        simpleDateFormate               = new SimpleDateFormat("HH:mm:ss");
        currentTime                     = simpleDateFormate.format(calendar.getTime());

        return currentTime;
    }

    /**
     * 현재 시를 가져옴
     * @return
     */
    public static String getCurrentHour() {
        String hour = null;
        String time = getCurrentTime();

        try{
            hour = time.substring(0, 2);
        }catch(IndexOutOfBoundsException e) {
            hour = "00";
        }

        return hour;
    }

    /*
    private String getDateRegex(String date) {
        String      regex       = null;
        String[]    splitStr    = null;

        regex                   ="/";
        splitStr                = date.split(regex);
        if(splitStr.length != 3) {
            regex               = "-";
            splitStr            = date.split(regex);
        }
        if(splitStr.length != 3) {
            regex               = "\\.";
            splitStr            = date.split("\\.");
        }
        if(splitStr.length != 3) {
            regex               = "";
        }

        return regex;
    }

    private String[] splitDate(String date) {
        String[]    splitStr    = null;
        String      regex       = null;

        regex                   = this.getDateRegex(date);
        splitStr = date.split(regex);

        return splitStr;
    }

    private String convertfullDateShort(String date, String regex) {
        String      convert     = null;
        String[]    splitStr    = null;

        try{
            splitStr            = splitDate(date);
            if(splitStr != null && splitStr.length == 3) {
                convert         = splitStr[0].substring(2);
                convert         += regex;
                convert         += splitStr[1];
                convert         += regex;
                convert         += splitStr[2];
            }
        }catch(Exception e) {

        }

        return convert;
    }*/

    /**
     * 년도를 짧게 만들어서 반환
     * @param date
     * @return
     */
    /*
    public String convertDateShort(String date, String regex) {
        String      convert     = null;
        String[]    splitStr    = null;

        try{
            if(date.length() == 10) {
                convert         = convertfullDateShort(date, regex);
            }else if(date.length() == 8){
                splitStr        = this.splitDate(date);
                if(splitStr.length != 3)
                    convert     = date.substring(2,4)+regex+date.substring(4,6)+regex+date.substring(6,8);
                else
                    convert     = date.replace(this.getDateRegex(date), regex);
            }else {
                convert = date;
                if(this.isNull(convert))
                    throw new Exception();
            }
        }catch(Exception e) {
            convert                 = "00"+regex+"00"+regex+"00";
        }


        return convert;
    }*/

    /**
     *  문자열 날짜를 날짜형식으로 변형
     *    20051020 => 2005/10/20
     *    2005/10/20 => 20051020
     *    2005-10-20 => 20051020
     *
     * @param date - 문자열, 예) 20051030
     * @return 날짜문자열
     */
    public static String convertDate(String date)
    {
        try
        {
            if (date.length() == 8)
            {
                if(Integer.parseInt(date) > 0)
                {
                    return date.substring(0,4)+"/"+date.substring(4,6)+"/"+date.substring(6,8);
                }
            }
            if (date.length() == 10)
            {
                return date.replaceAll("/", "").replaceAll("-", "");
            }
        }
        catch(Throwable e)
        {
        }

        return "";
    }

    /**
     * 현재 날짜에서 주어진 수만큼 빼서 yyyy/mm/dd 형태로 만들어 리턴
     * @param y - 현재 년에서 뺄 년수
     * @param m - 현재 년에서 뺄 월수
     * @param d - 현재 년에서 뺄 날수
     */
    public static String getAfterDate(int y, int m, int d){
        GregorianCalendar oTmpCrtGc = new GregorianCalendar();
        GregorianCalendar oTmpGc = new GregorianCalendar(oTmpCrtGc.get(Calendar.YEAR)+y,oTmpCrtGc.get(Calendar.MONTH)+m,oTmpCrtGc.get(Calendar.DATE)+d);

        String sTmp_YY = Integer.toString(oTmpGc.get(Calendar.YEAR));// 년, 2004
        String sTmp_MM = Integer.toString(oTmpGc.get(Calendar.MONTH)+1);// 월, 10
        String sTmp_DD = Integer.toString(oTmpGc.get(Calendar.DATE));// 일, 01

        sTmp_MM = (sTmp_MM.length()==1)? "0"+sTmp_MM: sTmp_MM;
        sTmp_DD = (sTmp_DD.length()==1)? "0"+sTmp_DD: sTmp_DD;

        return (sTmp_YY+sTmp_MM+sTmp_DD);
    }

    /**
     * 기준일로부터 원하는 날짜 만큼을 더해서 반환
     * @param bas_ymd   - 기준일
     * @param addYear
     * @param addMonth
     * @param addDay
     * @return
     */
    public static String getAfterDate(String bas_ymd, int addYear, int addMonth, int addDay) {
        //문자열을 기간으로 설정함
        int basYear     = Integer.parseInt(getConvertDateFormat(bas_ymd, "yyyy"));
        int basMonth    = Integer.parseInt(getConvertDateFormat(bas_ymd, "MM"));
        int basDay      = Integer.parseInt(getConvertDateFormat(bas_ymd, "dd"));

        //기준일 설정시킴
        Calendar basCal = Calendar.getInstance();
        basCal.set(basYear, basMonth-1, basDay);


        //기간을 변경시킴
        basCal.add(Calendar.YEAR,           addYear);
        basCal.add(Calendar.MONTH,          addMonth);
        basCal.add(Calendar.DAY_OF_MONTH,   addDay);


        return getConvertDateFormat(basCal.getTime(), "yyyyMMdd");
    }

    /**
     * 주어준 년월의 마지막 날짜구함
     *   예) 2004년 11월이면 30
     * @param y - 현재 년
     * @param m - 현재 년
     */
    public static int getEndDayOfMonth(String y, String m)
    {
        int iTmpYear = Integer.parseInt(y);
        int iTmpMonth = Integer.parseInt(m);

        GregorianCalendar oTmpGc = new GregorianCalendar(iTmpYear, iTmpMonth, 0);

        return oTmpGc.get(Calendar.DATE);

    }

    /**
     * 일자가 속한 주의 인덱스를구한다
     *
     * @param date
     *            DATE형 일자
     * @return int
     * @author PSMKORE CO,.LTD
     * @since 2003.11.13
     */

    public static int getDayOfWeek(java.util.Date date)
    {
        String weekdays[] = (new DateFormatSymbols()).getShortWeekdays();
        String weekday = (new SimpleDateFormat("E")).format(date);

        for (int i = 1; i <= weekdays.length; ++i)
        {
            if (weekday.equals(weekdays[i]))
                return i;
        }
        return -1;
    }

    /**
     * 두 날짜를 비교해서 첫번째 날짜가 크면 true
     * @param startDate
     * @param endDate
     * @return
     */
    public static boolean biggerThanDate(String startDate, String endDate) {
        boolean result = false;

        if(parseDate(startDate).getTime() > parseDate(endDate).getTime())
            result = true;

        return result;
    }

}

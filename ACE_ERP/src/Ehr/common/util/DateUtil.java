package Ehr.common.util;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtil{

    /**
     * ��Ʈ���� Date������ ��ȯ
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
     * ���� ��¥�� �� ��¥���� ���̸� ��ȯ
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
     * ���� ��¥�� �� ��¥���� ���̸� ��ȯ
     * (�⵵ ���� ����ϱ� �� -1970 �� ���� ���)
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
     * ���� ��¥ �����ͼ� ��ȯ
     * (yyyyMMdd)
     *
     * @return String
     */
    public static String getCurrentDateStr() {
        return getCurrentDateStr("yyyyMMdd");
    }

    /**
     * ���� ��¥�� ���ϴ� �������� ������
     * @param format
     * @return String
     */
    public static String getCurrentDateStr(String format) {
        return getConvertDateFormat(getCurrentDate(), format);
    }

    /**
     * ���ϴ� �������� ��¥ ���� ����
     * @param date
     * @param format
     * @return
     */
    public static String getConvertDateFormat(String dateStr, String format) {
        return getConvertDateFormat(parseDate(dateStr), format);
    }

    /**
     * ���ϴ� �������� ��¥ ���� ����
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
     * ���� ��¥�� ������
     * @return Date
     */
    public static Date getCurrentDate() {
        Calendar        calendar        = null;

        //���� ��¥ ��������
        calendar                        = Calendar.getInstance();

        return  calendar.getTime();
    }

    /**
     * ���� �⵵�� ������
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
     * ���� �ð��� ������
     * @return
     */
    public static String getCurrentTime() {
        Calendar        calendar        = null;
        SimpleDateFormat
                        simpleDateFormate
                                        = null;
        String          currentTime     = null;

        //���� ��¥ ��������
        calendar                        = Calendar.getInstance();
        simpleDateFormate               = new SimpleDateFormat("HH:mm:ss");
        currentTime                     = simpleDateFormate.format(calendar.getTime());

        return currentTime;
    }

    /**
     * ���� �ø� ������
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
     * �⵵�� ª�� ���� ��ȯ
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
     *  ���ڿ� ��¥�� ��¥�������� ����
     *    20051020 => 2005/10/20
     *    2005/10/20 => 20051020
     *    2005-10-20 => 20051020
     *
     * @param date - ���ڿ�, ��) 20051030
     * @return ��¥���ڿ�
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
     * ���� ��¥���� �־��� ����ŭ ���� yyyy/mm/dd ���·� ����� ����
     * @param y - ���� �⿡�� �� ���
     * @param m - ���� �⿡�� �� ����
     * @param d - ���� �⿡�� �� ����
     */
    public static String getAfterDate(int y, int m, int d){
        GregorianCalendar oTmpCrtGc = new GregorianCalendar();
        GregorianCalendar oTmpGc = new GregorianCalendar(oTmpCrtGc.get(Calendar.YEAR)+y,oTmpCrtGc.get(Calendar.MONTH)+m,oTmpCrtGc.get(Calendar.DATE)+d);

        String sTmp_YY = Integer.toString(oTmpGc.get(Calendar.YEAR));// ��, 2004
        String sTmp_MM = Integer.toString(oTmpGc.get(Calendar.MONTH)+1);// ��, 10
        String sTmp_DD = Integer.toString(oTmpGc.get(Calendar.DATE));// ��, 01

        sTmp_MM = (sTmp_MM.length()==1)? "0"+sTmp_MM: sTmp_MM;
        sTmp_DD = (sTmp_DD.length()==1)? "0"+sTmp_DD: sTmp_DD;

        return (sTmp_YY+sTmp_MM+sTmp_DD);
    }

    /**
     * �����Ϸκ��� ���ϴ� ��¥ ��ŭ�� ���ؼ� ��ȯ
     * @param bas_ymd   - ������
     * @param addYear
     * @param addMonth
     * @param addDay
     * @return
     */
    public static String getAfterDate(String bas_ymd, int addYear, int addMonth, int addDay) {
        //���ڿ��� �Ⱓ���� ������
        int basYear     = Integer.parseInt(getConvertDateFormat(bas_ymd, "yyyy"));
        int basMonth    = Integer.parseInt(getConvertDateFormat(bas_ymd, "MM"));
        int basDay      = Integer.parseInt(getConvertDateFormat(bas_ymd, "dd"));

        //������ ������Ŵ
        Calendar basCal = Calendar.getInstance();
        basCal.set(basYear, basMonth-1, basDay);


        //�Ⱓ�� �����Ŵ
        basCal.add(Calendar.YEAR,           addYear);
        basCal.add(Calendar.MONTH,          addMonth);
        basCal.add(Calendar.DAY_OF_MONTH,   addDay);


        return getConvertDateFormat(basCal.getTime(), "yyyyMMdd");
    }

    /**
     * �־��� ����� ������ ��¥����
     *   ��) 2004�� 11���̸� 30
     * @param y - ���� ��
     * @param m - ���� ��
     */
    public static int getEndDayOfMonth(String y, String m)
    {
        int iTmpYear = Integer.parseInt(y);
        int iTmpMonth = Integer.parseInt(m);

        GregorianCalendar oTmpGc = new GregorianCalendar(iTmpYear, iTmpMonth, 0);

        return oTmpGc.get(Calendar.DATE);

    }

    /**
     * ���ڰ� ���� ���� �ε��������Ѵ�
     *
     * @param date
     *            DATE�� ����
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
     * �� ��¥�� ���ؼ� ù��° ��¥�� ũ�� true
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

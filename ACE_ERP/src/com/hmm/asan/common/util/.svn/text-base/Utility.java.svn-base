// Decompiled by DJ v3.2.2.67 Copyright 2002 Atanas Neshkov  Date: 2006-05-24 ¿ÀÈÄ 9:11:51
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   Utility.java

package com.hmm.asan.common.util;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

public class Utility
{
 
    public Utility()
    {
    }

    public static String ko(String str)
    {
        if(str == null)
            return "";
        try
        {
            return new String(str.getBytes("8859_1"), "KSC5601");
        }
        catch(Exception e)
        {
            return "";
        }
    }

    public static String en(String str)
    {
        if(str == null)
            return "";
        try
        {
            return new String(str.getBytes("KSC5601"), "8859_1");
        }
        catch(Exception e)
        {
            return "";
        }
    }

    public static String date2String(java.util.Date d)
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        return sdf.format(d);
    }

    public static java.util.Date string2Date(String s)
    {
        java.util.Date d = null;
        try
        {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            d = sdf.parse(s, new ParsePosition(0));
        }
        catch(Exception e)
        {
            throw new RuntimeException("Date format not valid.");
        }
        return d;
    }

    public static String getLogTime()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat logTime = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
        return logTime.format(d);
    }

    public static String string2Format(String date)
    {
        StringBuffer newType = new StringBuffer();
        if(date == null || date.length() < 8)
        {
            return date;
        } else
        {
            date = date.substring(0, 8);
            newType.append(date.substring(0, 4));
            newType.append("-");
            newType.append(date.substring(4, 6));
            newType.append("-");
            newType.append(date.substring(6));
            return newType.toString();
        }
    }

    public static String string2Format(String date, String token)
    {
        StringBuffer newType = new StringBuffer();
        if(date == null || date.length() < 8)
        {
            return date;
        } else
        {
            date = date.substring(0, 8);
            newType.append(date.substring(0, 4));
            newType.append(token);
            newType.append(date.substring(4, 6));
            newType.append(token);
            newType.append(date.substring(6));
            return newType.toString();
        }
    }

    public static String formatDate(java.util.Date d, String format)
    {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(d);
    }

    public static Number parseNumber(String number, String format)
    {
        DecimalFormat formatter = new DecimalFormat(format);
        return formatter.parse(number, new ParsePosition(0));
    }

    public static int parseInt(String number, String format)
    {
        return parseNumber(number, format).intValue();
    }

    public static String toString(int i)
    {
        return (new Integer(i)).toString();
    }

    public static long parseLong(String number, String format)
    {
        return parseNumber(number, format).longValue();
    }

    public static float parseFloat(String number, String format)
    {
        return parseNumber(number, format).floatValue();
    }

    public static double parseDouble(String number, String format)
    {
        return parseNumber(number, format).doubleValue();
    }

    public static String formatNumber(int number, String format)
    {
        DecimalFormat formatter = new DecimalFormat(format);
        return formatter.format(number);
    }

    public static String formatNumber(long number, String format)
    {
        DecimalFormat formatter = new DecimalFormat(format);
        return formatter.format(number);
    }

    public static String formatNumber(float number, String format)
    {
        DecimalFormat formatter = new DecimalFormat(format);
        return formatter.format(number);
    }

    public static String formatNumber(double number, String format)
    {
        DecimalFormat formatter = new DecimalFormat(format);
        return formatter.format(number);
    }

    public static String getTime()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy\uB144 MM\uC6D4 dd\uC77C HH\uC2DC mm\uBD84");
        return sdf.format(d);
    }

    public static String getTimeEng()
    {
        java.util.Date d = new java.util.Date();
        String time = "";
        time = getCurrentTime2() + " " + getDay() + "," + getMonthNameEng(getMonth()) + ", " + getYear();
        return time;
    }

    public static String getTimeKor()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy\uB144 MM\uC6D4 dd\uC77C a hh\uC2DC mm\uBD84");
        return sdf.format(d);
    }

    public static String getCurrentDate()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(d);
    }

    public static int getYear()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        return Integer.parseInt(sdf.format(d));
    }

    public static int getMonth()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("MM");
        return Integer.parseInt(sdf.format(d));
    }

    public static int getDay()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("dd");
        return Integer.parseInt(sdf.format(d));
    }

    public static String getThisMonth()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
        return sdf.format(d);
    }

    public static String getThisYear()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        return sdf.format(d);
    }

    public static String getCurrentTime()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        return sdf.format(d);
    }

    public static String getCurrentTime2()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a ");
        return sdf.format(d);
    }

    public static String getCurrentTime3()
    {
        java.util.Date d = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.format(d);
    }

    public static String getYesterday()
    {
        Calendar cal = getCalendar();
        cal.add(5, -1);
        java.util.Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        return sdf.format(d);
    }

    public static String getYesterday(String day)
    {
        Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT+09:00"), Locale.KOREA);
        cal.setTime(new java.util.Date(Integer.parseInt(day.substring(0, 4)) - 1900, Integer.parseInt(day.substring(5, 7)) - 1, Integer.parseInt(day.substring(8, 10))));
        cal.add(5, -1);
        java.util.Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(d);
    }

    public static String getTomorrow()
    {
        Calendar cal = getCalendar();
        cal.add(5, 1);
        java.util.Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        return sdf.format(d);
    }

    public static String getTomorrow(String day)
    {
        Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT+09:00"), Locale.KOREA);
        cal.setTime(new java.util.Date(Integer.parseInt(day.substring(0, 4)) - 1900, Integer.parseInt(day.substring(5, 7)) - 1, Integer.parseInt(day.substring(8, 10))));
        cal.add(5, 1);
        java.util.Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(d);
    }

    public static String getLastMonth()
    {
        Calendar cal = getCalendar();
        cal.roll(2, -1);
        java.util.Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
        return sdf.format(d);
    }

    public static String[] getDates(String startDay, String endDay)
    {
        Vector v = new Vector();
        v.addElement(startDay);
        Calendar cal = getCalendar();
        cal.setTime(string2Date(startDay));
        for(String nextDay = date2String(cal.getTime()); !nextDay.equals(endDay); v.addElement(nextDay))
        {
            cal.add(5, 1);
            nextDay = date2String(cal.getTime());
        }

        String go[] = new String[v.size()];
        v.copyInto(go);
        return go;
    }

    public static Calendar getCalendar()
    {
        Calendar calendar = new GregorianCalendar(TimeZone.getTimeZone("GMT+09:00"), Locale.KOREA);
        calendar.setTime(new java.util.Date());
        return calendar;
    }

    public static String toHTML(String fromText)
    {
        return toHTML(fromText, false);
    }

    public static String toReplyHTML(String fromText)
    {
        return toHTML(fromText, true);
    }

    private static String toHTML(String fromText, boolean replyMode)
    {
        BufferedReader buf = new BufferedReader(new StringReader(fromText), 80);
        StringBuffer sbuf = new StringBuffer(100);
        try
        {
            for(String s = null; (s = buf.readLine()) != null;)
                if(s != null)
                {
                    char c = ' ';
                    if(replyMode)
                        sbuf.append("> ");
                    for(int i = 0; i < s.length(); i++)
                    {
                        c = s.charAt(i);
                        switch(c)
                        {
                        case 9: // '\t'
                            sbuf.append("&nbsp;&nbsp;&nbsp;&nbsp;");
                            break;

                        case 60: // '<'
                            sbuf.append("&lt;");
                            break;

                        case 62: // '>'
                            sbuf.append("&gt;");
                            // fall through

                        case 34: // '"'
                            sbuf.append("&quot;");
                            break;

                        default:
                            sbuf.append(c);
                            break;
                        }
                    }

                }

        }
        catch(IOException e)
        {
            return fromText;
        }
        return sbuf.toString();
    }

    public static String getReplyText(String fromText)
    {
        BufferedReader buf = new BufferedReader(new StringReader(fromText), 80);
        StringBuffer sbuf = new StringBuffer(100);
        try
        {
            for(String s = null; (s = buf.readLine()) != null;)
                sbuf.append("> " + s + "\n");

        }
        catch(IOException e)
        {
            return fromText;
        }
        return sbuf.toString();
    }

    public static String getSocialId(String socialId)
    {
        if(socialId == null)
            throw new NullPointerException("socialId is null.");
        if(socialId.charAt(6) == '-')
        {
            return socialId;
        } else
        {
            StringBuffer sb = new StringBuffer(socialId);
            sb.insert(6, '-');
            return sb.toString();
        }
    }

    public static String getSocialId(String socialId, boolean isFirst)
    {
        if(isFirst)
            return socialId.substring(0, 6);
        else
            return socialId.substring(6);
    }

    public static String[] parseTel(String tel)
    {
        if(tel == null)
            throw new NullPointerException("tel is null.");
        String result[] = new String[3];
        int idx = 0;
        for(int i = 0; i < tel.length(); i++)
        {
            char c = tel.charAt(i);
            if(c < '0' || c > '9')
                if(idx == 0)
                {
                    idx = i;
                    result[0] = tel.substring(0, idx);
                } else
                {
                    result[1] = tel.substring(idx + 1, i);
                    result[2] = tel.substring(i + 1);
                }
        }

        return result;
    }

    public static String getTel(String tel, int which)
    {
        if(tel == null)
            throw new NullPointerException("tel is null.");
        switch(which)
        {
        case 1: // '\001'
            return tel.substring(0, tel.indexOf('-'));

        case 2: // '\002'
            return tel.substring(tel.indexOf('-') + 1, tel.lastIndexOf('-'));

        case 3: // '\003'
            return tel.substring(tel.lastIndexOf('-') + 1);
        }
        return tel;
    }

    public static String isSelected(String key, String word)
    {
        if(word.startsWith(key) || word.equals(key))
            return "selected";
        else
            return "";
    }

    public static String isChecked(String value, int key)
    {
        if(Integer.parseInt(value) == key)
            return "checked";
        else
            return "";
    }

    public static String imageHTML(String image)
    {
        if(image == null || image.equals("") || image.equals("null"))
        {
            return "";
        } else
        {
            String baseDir = "";
            StringBuffer sb = new StringBuffer();
            sb.append("<img src='");
            sb.append(baseDir);
            sb.append("/");
            sb.append(image);
            sb.append("' border='0.5' width='120' height='140' >");
            return sb.toString();
        }
    }

    public static String replyHTML(String imgURI, String depth)
    {
        if(Integer.parseInt(depth) <= 0)
            return "";
        StringBuffer sb = new StringBuffer();
        for(int i = 0; i < Integer.parseInt(depth) * 2; i++)
            sb.append("&nbsp;");

        sb.append("<img src='");
        sb.append(imgURI);
        sb.append("' border='0'>");
        return sb.toString();
    }

    public static String getStringcut(int leng, String str)
    {
        try
        {
            int hanlen = 0;
            int englen = 0;
            int cutleng = 0;
            char nc_str[] = str.trim().toCharArray();
            if(nc_str.length >= leng)
            {
                String cut_str = str.substring(0, leng);
                char strlen[] = cut_str.trim().toCharArray();
                for(int i = 0; i < strlen.length; i++)
                {
                    String strlen2 = (new Character(strlen[i])).toString();
                    int hash = strlen2.hashCode();
                    if(hash > 127)
                        hanlen++;
                    else
                        englen++;
                }

                if(hanlen % 2 != 0)
                    hanlen--;
                cutleng = hanlen + englen;
                cut_str = cut_str.substring(0, cutleng);
                cut_str = cut_str + "...";
                return cut_str;
            } else
            {
                return str;
            }
        }
        catch(Exception e)
        {
            return str;
        }
    }

    public static String getStringcut1(int leng, String str)
    {
        try
        {
            int hanlen = 0;
            int englen = 0;
            int cutleng = 0;
            char nc_str[] = str.trim().toCharArray();
            if(nc_str.length >= leng)
            {
                String cut_str = str.substring(0, leng);
                char strlen[] = cut_str.trim().toCharArray();
                for(int i = 0; i < strlen.length; i++)
                {
                    String strlen2 = (new Character(strlen[i])).toString();
                    int hash = strlen2.hashCode();
                    if(hash > 127)
                        hanlen++;
                    else
                        englen++;
                }

                if(hanlen % 2 != 0)
                    hanlen--;
                cutleng = hanlen + englen;
                cut_str = cut_str.substring(0, cutleng);
                cut_str = cut_str + "...";
                cut_str = cut_str + "<br>more";
                return cut_str;
            } else
            {
                return str;
            }
        }
        catch(Exception e)
        {
            return str;
        }
    }

    public static String getRemoveBr(String str)
    {
        try
        {
            for(; str.indexOf("<br>") >= 0; str = str.replaceAll("<br>", ""));
            for(; str.indexOf("<Br>") >= 0; str = str.replaceAll("<Br>", ""));
            for(; str.indexOf("<BR>") >= 0; str = str.replaceAll("<BR>", ""));
            return str;
        }
        catch(Exception e)
        {
            return str;
        }
    }

    public static String getRemoveP(String str)
    {
        try
        {
            for(; str.indexOf("<P>") >= 0; str = str.replaceAll("<P>", ""));
            for(; str.indexOf("<p>") >= 0; str = str.replaceAll("<p>", ""));
            return str;
        }
        catch(Exception e)
        {
            return str;
        }
    }

    public static String getRemoveCr(String str)
    {
        try
        {
            for(; str.indexOf("\n") >= 0; str = str.replaceAll("\n", ""));
            for(; str.indexOf("\r") >= 0; str = str.replaceAll("\r", ""));
            for(; str.indexOf("\n\r") >= 0; str = str.replaceAll("\n\r", ""));
            return str;
        }
        catch(Exception e)
        {
            return str;
        }
    }

    public static String getRemoveLine(String str)
    {
        try
        {
            str = getRemoveBr(str);
            str = getRemoveP(str);
            str = getRemoveCr(str);
            return str;
        }
        catch(Exception e)
        {
            return str;
        }
    }

    public static String tokenize(String time, String returnData)
    {
        HashMap data = new HashMap();
        String tempString;
        for(StringTokenizer tokenString = new StringTokenizer(time, "/"); tokenString.hasMoreTokens(); data.put(tempString.substring(0, 1), tempString.substring(1)))
            tempString = tokenString.nextToken();

        return (String)data.get(returnData);
    }

    public static String viewMDY(String m, String d, String y, int pattern)
    {
        StringBuffer viewMDY = new StringBuffer();
        int intM = Integer.parseInt(m);
        if(pattern == 1 || pattern == 2)
            switch(intM)
            {
            case 1: // '\001'
                viewMDY.append("Jan");
                break;

            case 2: // '\002'
                viewMDY.append("Feb");
                break;

            case 3: // '\003'
                viewMDY.append("Mar");
                break;

            case 4: // '\004'
                viewMDY.append("Apr");
                break;

            case 5: // '\005'
                viewMDY.append("May");
                break;

            case 6: // '\006'
                viewMDY.append("Jun");
                break;

            case 7: // '\007'
                viewMDY.append("Jul");
                break;

            case 8: // '\b'
                viewMDY.append("Aug");
                break;

            case 9: // '\t'
                viewMDY.append("Sepz");
                break;

            case 10: // '\n'
                viewMDY.append("Oct");
                break;

            case 11: // '\013'
                viewMDY.append("Nov");
                break;

            case 12: // '\f'
                viewMDY.append("Dec");
                break;
            }
        else
        if(1 <= intM && intM <= 3)
            viewMDY.append("1Q");
        else
        if(4 <= intM && intM <= 6)
            viewMDY.append("2Q");
        else
        if(7 <= intM && intM <= 9)
            viewMDY.append("3Q");
        else
            viewMDY.append("4Q");
        switch(pattern)
        {
        case 1: // '\001'
            viewMDY.append(" " + y);
            break;

        case 2: // '\002'
            viewMDY.append("," + d + "," + y);
            break;

        case 3: // '\003'
            viewMDY.append(" " + y);
            break;
        }
        return viewMDY.toString();
    }

    public static String viewMDY(String monyearday, int pattern)
    {
        return viewMDY(monyearday.substring(4, 5), monyearday.substring(0, 3), monyearday.substring(6), pattern);
    }

    public static String fileType(String filename)
    {
        String pattern = "";
        String soundfile = "/ir/com_images/ir_ico_soundfile.gif";
        String docFile = "/ir/com_images/ir_ico_docfile.gif";
        String acrobetFile = "/ir/com_images/ir_ico_pdffile.gif";
        String wavefile = "/ir/com_images/ir_ico_windowmeidafile.gif";
        int pos = 0;
        String fileExtention = null;
        pos = filename.lastIndexOf(".");
        fileExtention = filename.substring(pos);
        if(fileExtention.equalsIgnoreCase(".wav"))
            pattern = soundfile;
        else
        if(fileExtention.equalsIgnoreCase(".doc"))
            pattern = docFile;
        else
        if(fileExtention.equalsIgnoreCase(".pdf"))
            pattern = acrobetFile;
        else
        if(fileExtention.equalsIgnoreCase(".wma"))
            pattern = wavefile;
        else
            pattern = soundfile;
        return pattern;
    }

    public static String makeImgLink(String requestURL, String img)
    {
        StringBuffer returnURL = new StringBuffer();
        int startp = 0;
        int endp = 0;
        String temprequestURL = null;
        for(int i = 0; i < 3; i++)
        {
            startp = requestURL.indexOf("/");
            temprequestURL = requestURL.substring(0, startp);
            requestURL = requestURL.substring(startp);
        }

        returnURL.append(temprequestURL);
        endp = img.lastIndexOf("DefaultWebApp");
        returnURL.append(img.substring(endp + 13));
        return returnURL.toString();
    }

    public static String nl2br(String str)
    {
        try
        {
            char ch[] = str.trim().toCharArray();
            if(ch.length > 0)
            {
                StringBuffer sb = new StringBuffer(str.trim());
                int index = 0;
                for(int i = 0; i < ch.length;)
                    switch(ch[i])
                    {
                    case 10: // '\n'
                        sb.insert(i + index, "<br>");
                        index += 4;
                        // fall through

                    default:
                        i++;
                        break;
                    }

                return sb.toString();
            }
        }
        catch(Exception exception) { }
        return "";
    }

    public static String makeReDirURL(String servlet, String query)
    {
        String reDirURL = servlet;
        for(int i = 0; i < 3; i++)
            reDirURL = reDirURL.substring(reDirURL.indexOf("/") + 1);

        if(query != null)
            reDirURL = reDirURL + "?" + query;
        reDirURL = "/" + reDirURL;
        return reDirURL;
    }

    public static boolean isEmpty(String string)
    {
        if(string == null)
            return true;
        return string.trim().length() == 0;
    }

    public static String getParameter(HttpServletRequest request, String param_name)
    {
        Enumeration params = request.getParameterNames();
        String param = null;
        while(params.hasMoreElements()) 
            if(params.nextElement().toString().equals(param_name))
            {
                param = request.getParameter(param_name);
                if(param.trim().length() == 0)
                    param = null;
            }
        return param;
    }

    public static String removeTag(String s)
    {
        int NORMAL_STATE = 0;
        int TAG_STATE = 1;
        int START_TAG_STATE = 2;
        int END_TAG_STATE = 3;
        int SINGLE_QUOT_STATE = 4;
        int DOUBLE_QUOT_STATE = 5;
        int state = 0;
        int oldState = 0;
        char chars[] = s.toCharArray();
        StringBuffer sb = new StringBuffer();
        try
        {
            for(int i = 0; i < chars.length; i++)
            {
                char a = chars[i];
                switch(state)
                {
                default:
                    break;

                case 0: // '\0'
                    if(a == '<')
                        state = 1;
                    else
                        sb.append(a);
                    break;

                case 1: // '\001'
                    if(a == '>')
                    {
                        state = 0;
                        break;
                    }
                    if(a == '"')
                    {
                        oldState = state;
                        state = 5;
                        break;
                    }
                    if(a == '\'')
                    {
                        oldState = state;
                        state = 4;
                        break;
                    }
                    if(a == '/')
                    {
                        state = 3;
                        break;
                    }
                    if(a != ' ' && a != '\t' && a != '\n' && a != '\r' && a != '\f')
                        state = 2;
                    break;

                case 2: // '\002'
                case 3: // '\003'
                    if(a == '>')
                    {
                        state = 0;
                        break;
                    }
                    if(a == '"')
                    {
                        oldState = state;
                        state = 5;
                        break;
                    }
                    if(a == '\'')
                    {
                        oldState = state;
                        state = 4;
                        break;
                    }
                    if(a == '"')
                    {
                        state = 5;
                        break;
                    }
                    if(a == '\'')
                        state = 4;
                    break;

                case 5: // '\005'
                    if(a == '"')
                        state = oldState;
                    break;

                case 4: // '\004'
                    if(a == '\'')
                        state = oldState;
                    break;
                }
            }

        }
        catch(Exception exception) { }
        return sb.toString();
    }

    public static String removeQuotationmark(String str)
    {
        str = str.replaceAll("\"", "&#34;");
        str = str.replaceAll("'", "&#39;");
        return str;
    }

    public static String parseString(String str, String regex, int idx)
    {
        if(str == null || str.length() == 0)
            return null;
        String token[] = str.split(regex);
        if(token == null || token.length == 0 || idx < 0 || idx >= token.length)
            return null;
        else
            return token[idx];
    }

    public static int getBarSize(String data, String total)
    {
        int ipersent = 0;
        int itotal = 0;
        int idata = 0;
        try
        {
            itotal = Integer.parseInt(total);
            idata = Integer.parseInt(data);
            if(itotal > 0)
                ipersent = (int)(((double)idata / 100D) * (double)itotal);
        }
        catch(Exception exception) { }
        return ipersent;
    }

    public static String toString(Object data)
    {
        try
        {
            if(data == null)
                return "";
        }
        catch(Exception exception) { }
        return ko((String)data);
    }

    public static void cleanUp(Statement stmt)
    {
        cleanUp(null, stmt);
    }

    public static void cleanUp(ResultSet rset)
    {
        cleanUp(rset, null);
    }

    public static void cleanUp(ResultSet rset, Statement stmt)
    {
        try
        {
            if(rset != null)
                rset.close();
            if(stmt != null)
                stmt.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }

    public static String getMonthNameEng(int month)
    {
        String monthnm = "";
        try
        {
            switch(month)
            {
            case 1: // '\001'
                monthnm = "January";
                break;

            case 2: // '\002'
                monthnm = "February";
                break;

            case 3: // '\003'
                monthnm = "March";
                break;

            case 4: // '\004'
                monthnm = "April";
                break;

            case 5: // '\005'
                monthnm = "May";
                break;

            case 6: // '\006'
                monthnm = "June";
                break;

            case 7: // '\007'
                monthnm = "July";
                break;

            case 8: // '\b'
                monthnm = "August";
                break;

            case 9: // '\t'
                monthnm = "September";
                break;

            case 10: // '\n'
                monthnm = "October";
                break;

            case 11: // '\013'
                monthnm = "November";
                break;

            case 12: // '\f'
                monthnm = "December";
                break;
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return monthnm;
    }

    public static String DateToEng(String date)
    {
        if(date == null || date.length() < 8)
            return date;
        try
        {
            String year = date.substring(0, 4);
            String month = date.substring(4, 6);
            String day = date.substring(6, 8);
            month = getMonthNameEng(Integer.parseInt(month)) + " ";
            return month + day + ", " + year;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return date;
    }

    public static String DateToEng2(String date)
    {
        if(date == null || date.length() < 10)
            return date;
        if(date.length() > 10)
            date = date.substring(0, 10);
        date = date.replaceAll("-", "");
        try
        {
            String year = date.substring(0, 4);
            String month = date.substring(4, 6);
            String day = date.substring(6, 8);
            month = getMonthNameEng(Integer.parseInt(month)) + " ";
            return month + day + ", " + year;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return date;
    }

    public static String DateToEng3(String date)
    {
        if(date == null || date.length() < 10)
            return date;
        if(date.length() > 10)
            date = date.substring(0, 10);
        date = date.replaceAll("-", "");
        try
        {
            String year = date.substring(0, 4);
            String month = date.substring(4, 6);
            month = (new StringBuffer(String.valueOf(getMonthNameEng(Integer.parseInt(month))))).toString();
            return month + ", " + year;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return date;
    }

    public static boolean NewDay(String date)
    {
        java.util.Date yymmdd = new java.util.Date();
        SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");
        try
        {
            date = date.substring(0, 10).replaceAll("-", "");
            String curdate = myformat.format(yymmdd);
            if(Integer.parseInt(date) >= Integer.parseInt(curdate) - 1)
                return true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return false;
    }

    public static String toString(String str, int len)
    {
        try
        {
            int x = len - str.length();
            if(x != 0)
            {
                for(int i = 1; i <= x; i++)
                    str = "0" + str;

            }
        }
        catch(Exception exception) { }
        return str;
    }

    public static String getEmail(String email, int which)
    {
        try
        {
            switch(which)
            {
            case 1: // '\001'
                return email.substring(0, email.indexOf('@'));

            case 2: // '\002'
                return email.substring(email.lastIndexOf('@') + 1);
            }
        }
        catch(Exception exception) { }
        return email;
    }

    public static String getDb2Time(String date, int val)
    {
        java.util.Date d = new java.util.Date(Integer.parseInt(date.substring(0, 4)) - 1900, Integer.parseInt(date.substring(5, 7)) - 1, Integer.parseInt(date.substring(8, 10)), Integer.parseInt(date.substring(11, 13)), Integer.parseInt(date.substring(14, 16)), Integer.parseInt(date.substring(17, 19)) + val);
        SimpleDateFormat logTime = new SimpleDateFormat("yyyy-MM-dd-HH.mm.ss.S");
        return logTime.format(d);
    }

    public static String string3Format(String date)
    {
        StringBuffer newType = new StringBuffer();
        if(date == null || date.length() < 8)
        {
            return date;
        } else
        {
            date = date.substring(0, 8);
            newType.append(date.substring(0, 4));
            newType.append("\uB144 ");
            newType.append(date.substring(4, 6));
            newType.append("\uC6D4 ");
            newType.append(date.substring(6));
            newType.append("\uC77C ");
            return newType.toString();
        }
    }

    public static boolean dateCompareA(String date1, String date2)
    {
        java.util.Date yymmdd = new java.util.Date();
        SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");
        try
        {
            if(date1.length() >= 10)
                date1 = date1.substring(0, 10).replaceAll("-", "");
            if(date2.length() > 10)
                date2 = date2.substring(0, 10).replaceAll("-", "");
            if(Integer.parseInt(date1) >= Integer.parseInt(date2))
                return true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return false;
    }

    public static boolean dateCompareB(String date1, String date2)
    {
        java.util.Date yymmdd = new java.util.Date();
        SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");
        try
        {
            if(date1.length() >= 10)
                date1 = date1.substring(0, 10).replaceAll("-", "");
            if(date2.length() > 10)
                date2 = date2.substring(0, 10).replaceAll("-", "");
            if(Integer.parseInt(date1) <= Integer.parseInt(date2))
                return true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return false;
    }

    public static boolean checkNewdata(ArrayList newmenulist, String category)
    {
        try
        {
            if(newmenulist.size() == 0)
                return false;
            for(int i = 0; i < newmenulist.size(); i++)
            {
                HashMap hm = (HashMap)newmenulist.get(i);
                if(hm.get("CATEGORY").toString().equals(category) && Integer.parseInt(hm.get("CNT").toString()) > 0)
                    return true;
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return false;
    }
}
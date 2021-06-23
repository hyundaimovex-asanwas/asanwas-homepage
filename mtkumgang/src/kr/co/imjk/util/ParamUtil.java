/*
 * Author(s) Park Sang Bae 
 * Date: 2003.12.22
 */
package kr.co.imjk.util;

import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;
import java.util.TimeZone;

public class ParamUtil {
    public static String getReqParameter(String Req,String ifNulltoReplace ) {
        if ( Req == null || Req.equals("")) return ifNulltoReplace;
        else return Req.trim();
    }
    public static String getReqParameter(String Req ) {
        if (Req == null || Req.equals("")) return "";
        else return Req.trim();
    }

    public static int getIntParameter(String Req,int ifNulltoReplace ) {
        try {
            if ( Req == null || Req.equals("")) return ifNulltoReplace;
            else return Integer.parseInt(Req.toString());
        }catch(NumberFormatException e){
            return ifNulltoReplace;
        }
    }
    public static int getIntParameter(String Req ) {
        try {
            if (Req == null || Req.equals("")) return 0;
            else return Integer.parseInt(Req.toString());
        }catch(NumberFormatException e){
            return 0;
        }
    }

	 public static String dateToString(Date d, String format){
    	String ch = null;
    	try
    	{
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            ch = sdf.format(d);
    	} catch(Exception dfdf) { }
    	return ch;
    }      
}

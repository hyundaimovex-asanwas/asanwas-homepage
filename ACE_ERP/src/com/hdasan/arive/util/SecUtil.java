/*

 *  
 */
package com.hdasan.arive.util;

import java.security.*;

/*
 *
 * String 변환 관련 UTIL
 *
 */

public class SecUtil {

	//SQL Injection 필터링 함수 
	//공격 위험성이 존재하는 문자들을 필터링 
	//입력값: SQL 입력값 
	public static String sqlFilter(String str) { 
		str = strReplace(str,"'","''"); 
		str = strReplace(str,"\"","\"\""); 
		str = strReplace(str,"\\","\\\\"); 
		str = strReplace(str,";",""); 
		str = strReplace(str,"#",""); 
		str = strReplace(str,"--",""); 
		str = strReplace(str," ",""); 
		return (str); 
	}


		


    /** text를 html로 바꾼다.
     * @param String str 변환될 스트링
     * @return String temp 변환된 스트링
     */
    public static String htmlToText(String str)
    {
        if (str==null) return null;
		String temp = str;
		temp=strReplace(temp, "<br>", "\n");
		temp=strReplace(temp, "<Br>", "\n");
		temp=strReplace(temp, "<BR>", "\n");
		temp=strReplace(temp, "&nbsp;", " ");
		temp=strReplace(temp, "&quot;", "\"");
		temp=strReplace(temp, "&#39;", "'");
		temp=strReplace(temp, "&gt;", ">");
		temp=strReplace(temp, "&lt;", "<");
		temp=strReplace(temp, "&amp;", "&");
		return temp;
	}

     /** html을 text로 바꾼다.
     * @param String str 변환될 스트링
     * @return String temp 변환돈 스트링
     */
    public static String textToHtml(String str)
    {
        if (str==null) return null;
		String temp = str;
		temp=strReplace(temp, " ", "&nbsp;");
		temp=strReplace(temp, "\"", "&quot;");
		temp=strReplace(temp, "'", "&#39;");
		temp=strReplace(temp, ">", "&gt;");
		temp=strReplace(temp, "<", "&lt;");
		temp=strReplace(temp, "\n", "<br>");
		//temp=strReplace(temp, "&", "&amp;");
		return temp;
    }


    /**
     *  스트링에서 특정 문자열을 원하는 문자열로 바꾼다.
     *  <pre>
     *  특정 스트링에서 어떤 문자열을 원하는 문자열로 바꿀때 사용된다.
     *  "that is red pig" 라는 문자열에서 "is"를 "was"로 바꾸려 할때는
     *
     *  TAUtil.strReplace("this is red pig", "is", "was")
     *  와 같이 호출하면 "this was red pig"를 리턴한다.
     *
     * </pre>
     * @param   dest    바꾸는 대상이 되는 스트링
     * @param   src     찾기를 원하는 스트링
     * @param   rep     바뀔 문자열
     * @retrun  특정문자열이 원하는 문자열로 바뀌어진 스트링을 리턴한다.
     */
   	public static   String strReplace(String dest,String src,String rep)
   	{
    	String retstr="";
    	String left="";
		int pos=0;
		if(dest == null) return retstr;
		while(true) {
			if((pos=dest.indexOf(src))!=-1) {
				left = dest.substring(0, pos);
				dest = dest.substring(pos+src.length(), dest.length());
				retstr=retstr+left+rep;
				pos=pos+src.length();
			}
			else {
				retstr=retstr+dest;
				break;
			}
		}
		return retstr;
   	}

}

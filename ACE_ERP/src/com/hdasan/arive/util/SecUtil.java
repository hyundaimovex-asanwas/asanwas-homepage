/*

 *  
 */
package com.hdasan.arive.util;

import java.security.*;

/*
 *
 * String ��ȯ ���� UTIL
 *
 */

public class SecUtil {

	//SQL Injection ���͸� �Լ� 
	//���� ���輺�� �����ϴ� ���ڵ��� ���͸� 
	//�Է°�: SQL �Է°� 
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


		


    /** text�� html�� �ٲ۴�.
     * @param String str ��ȯ�� ��Ʈ��
     * @return String temp ��ȯ�� ��Ʈ��
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

     /** html�� text�� �ٲ۴�.
     * @param String str ��ȯ�� ��Ʈ��
     * @return String temp ��ȯ�� ��Ʈ��
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
     *  ��Ʈ������ Ư�� ���ڿ��� ���ϴ� ���ڿ��� �ٲ۴�.
     *  <pre>
     *  Ư�� ��Ʈ������ � ���ڿ��� ���ϴ� ���ڿ��� �ٲܶ� ���ȴ�.
     *  "that is red pig" ��� ���ڿ����� "is"�� "was"�� �ٲٷ� �Ҷ���
     *
     *  TAUtil.strReplace("this is red pig", "is", "was")
     *  �� ���� ȣ���ϸ� "this was red pig"�� �����Ѵ�.
     *
     * </pre>
     * @param   dest    �ٲٴ� ����� �Ǵ� ��Ʈ��
     * @param   src     ã�⸦ ���ϴ� ��Ʈ��
     * @param   rep     �ٲ� ���ڿ�
     * @retrun  Ư�����ڿ��� ���ϴ� ���ڿ��� �ٲ���� ��Ʈ���� �����Ѵ�.
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

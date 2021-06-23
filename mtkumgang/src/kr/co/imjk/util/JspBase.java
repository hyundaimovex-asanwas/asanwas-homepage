/*

 *
 * Jsp page�� ���� utility class
 */
package kr.co.imjk.util;


import java.text.SimpleDateFormat;





/**
 * JspBase 2003/11/18<br>
 * ��� jsp�� �� class�� ��� �޴´�.<br>
 * jsp ������ ����� ������ utility method�� //System configuration
 * (com.imjk.blog.properties)�� ���� ���� ����� �����Ѵ�.<br>
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
     * ���ڿ��� ������ ���� ���� �� ��� ������ ���̿��� �߶󳻰� suffix�� ���δ�.
     * @param src cut off�� ���ڿ�
     * @param len cut off���� ����
     * @param suffix cut off �� �ٿ��ִ� ����
     * @return cut off�� ���ڿ�
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
     * ���ڿ��� ������ ���� ���� �� ��� ������ ���̿��� �߶󳻰� '...'�� ���δ�.
     * @param src cut off�� ���ڿ�
     * @param leng cut off���� ����
     * @return cut off�� ���ڿ�
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
    * ������ ���� ��ŭ ���ڿ��� �ڸ���.
    *
    * @param srcString ��� ���ڿ�
    * @param length ����
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
     * ���ڿ��� null�̰ų� �������� �˻�.
     * @param str null�̰ų� �������� �˻��� ���ڿ�
     * @return �˻� ���
     */
    public static boolean isNull(String str) {
        return (str==null || str.trim().length()==0);
    }

    /**
     * ���ڿ��� null�̸� �̸� �� ���ڿ��� ��ȯ.
     * @param str ��ȯ�� ���ڿ�
     * @return �� ���ڿ�
     */
    public static String replaceNull(String str) {
        return (str==null)?"":str;
    }

    /**
     * yyyymm�� ��¥�� yyyy.mm���� return;
     */

    public static String formatDateYYYYMM( String yyyymm ) {
  	if( yyyymm == null ) return "";
  	if( yyyymm.length() < 6 ) return yyyymm;

  	return yyyymm.substring(0,4)+"."+yyyymm.substring(4,6);
    }

    /**
     * yyyymmdd�� ��¥�� yyyy.mm.dd���� return;
     */

    public static String formatDateYYYYMMDD( String yyyymmdd ) {
  	if( yyyymmdd == null ) return "";
  	if( yyyymmdd.length() < 8 ) return yyyymmdd;

  	return yyyymmdd.substring(0,4)+"."+yyyymmdd.substring(4,6)+"."+yyyymmdd.substring(6,8);
    }

    /**
     * yyyymmdd�� ��¥�� yyyy-mm-dd���� return;
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
     * Date�� ������ �����Ͽ� ���� ������.
     * @param d ������ ��������
     * @param style ���� ��Ÿ�� java.text.DateFormat.[SHORT|MEDIUM|LONG|FULL]
     * @return ������ �� ���ڿ�
     */
    public String formatDate(java.util.Date d,int style) {
        if (d==null) return "";
        java.text.DateFormat df=java.text.DateFormat.getDateInstance(style);
        return df.format(d).replace('-','.');
    }

    /**
     * Date�� ������ �����Ͽ� ���� SHORT�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateShort(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.SHORT);
    }

    /**
     * Date�� ������ �����Ͽ� ���� MEDIUM�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateMedium(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.MEDIUM);
    }

    /**
     * Date�� ������ �����Ͽ� ���� LONG�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateLong(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.LONG);
    }

    /**
     * Date�� ������ �����Ͽ� ���� FULL�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateFull(java.util.Date d) {
        return formatDate(d,java.text.DateFormat.FULL);
    }

    /**
     * Date�� ������ �����Ͽ� ���� ������. ����ú���.
     * @param d ������ ��������
     * @param style ���� ��Ÿ�� java.text.DateFormat.[SHORT|MEDIUM|LONG|FULL]
     * @return ������ �� ���ڿ�
     */
    public String formatDateTime(java.util.Date d,int style) {
        if (d==null) return "-";
        java.text.DateFormat df=java.text.DateFormat.getDateTimeInstance(style,style);
        return df.format(d).replace('-','.');
    }

    /**
     * Date�� ������ �����Ͽ� ���� SHORT�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateTimeShort(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.SHORT);
    }

    /**
     * Date�� ������ �����Ͽ� ���� MEDIUM�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateTimeMedium(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.MEDIUM);
    }

    /**
     * Date�� ������ �����Ͽ� ���� LONG�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateTimeLong(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.LONG);
    }

    /**
     * Date�� ������ �����Ͽ� ���� FULL�������� ������.
     * @param d ������ ��������
     * @return ������ �� ���ڿ�
     */
    public String formatDateTimeFull(java.util.Date d) {
        return formatDateTime(d,java.text.DateFormat.FULL);
    }

    /**
    * Timestamp�� ���� YYYY.MM.DD HH:MI �������� ������
     * @param d ������ timestamp
     * @return ������ �� ���ڿ�
     */
     public String timestampFormat(java.sql.Timestamp d){
        if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("yyyy.MM.dd  a  hh:mm");
        return  formatter.format(d);

    }

    /**
    * Timestamp�� ���� YYYY �������� ������
     * @param d ������ timestamp
     * @return ������ �� ���ڿ�
     */
     public String timestampFormatYear(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("yyyy");
        return  formatter.format(d);

    }

    /**
    * Timestamp�� ���� MM �������� ������
     * @param d ������ timestamp
     * @return ������ �� ���ڿ�
     */
     public String timestampFormatMonth(java.sql.Timestamp d){
        if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("MM");
        return  formatter.format(d);

    }

    /**
    * Timestamp�� ���� dd �������� ������
     * @param d ������ timestamp
     * @return ������ �� ���ڿ�
     */
     public String timestampFormatDay(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("dd");
        return  formatter.format(d);

    }

    /**
    * Timestamp�� ���� 0~24 �������� ������
     * @param d ������ timestamp
     * @return ������ �� ���ڿ�
     */
     public String timestampFormatHour(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("k");
        return  formatter.format(d);

}

    /**
    * timestamp�� ���� YYYYMMDD�� ������
    * @param d ������ timestamp
    * @return ������ �� ���ڿ�
    */
    public String timestampFormatYYYYMMDD(java.sql.Timestamp d){
            if(d == null) return "";
            SimpleDateFormat formatter
                 =new SimpleDateFormat("yyyyMMdd");
             return formatter.format(d);

    }

    /**
    * Timestamp�� ���� 0~24 �������� ������
     * @param d ������ timestamp
     * @return ������ �� ���ڿ�
     */
     public String timestampFormatMinute(java.sql.Timestamp d){
         if (d==null) return "";
        SimpleDateFormat formatter
             = new SimpleDateFormat ("mm");
        return  formatter.format(d);

    }

    /**
    * 1�ڸ� integer --> 2�ڸ� String�� ������
    * @param ��Ĺ�� integer
    * @return ������ �� ���ڿ�
    */
    public String IntegerTo2LengthString(int d){
        return d <10? "0"+d:""+d;
    }



    /**
     * ������ ����. <b>Not implemented yet!!</b>
     */
    public void initLocale(java.util.Locale locale) {
    }


 

  

    /**
    * ���� ������ ���������� ���� <br>
    *
    * @param price ����
    * @parma return "," "��" �� ���Ե� ��������
    */
    public static String formatPrice(long price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        return nf.format(price)+" ��";
    }

    /**
    * ���� ���� ���� <br>
    *
    * @param price ����
    * @parma return "," �� ���Ե� ��������
    */
    public static String formatNumber(long price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        return nf.format(price);
    }

        /**
    * ���� ���� ���� <br>
    *
    * @param price ����
    * @parma return "," �� ���Ե� ��������
    */
    public static String formatNumber(double price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        return nf.format(price);
    }

    /**
    * ���� ���� ���� <br>
    *
    * @param price ����
    * @parma return ","�� �Ҽ��� ���� ���Ե��� ���� ����
    */
    public static String formatNumberWithoutComma(double price) {
        if (price==0) return "0";
        java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
        nf.setGroupingUsed(false);
        return nf.format(price);
    }
    
    /** 
    * ���� ���� ����<br>
    *
    * @param number ��� ��
    * @param places �Ҽ��� �ڸ���
    * @param return �Ҽ��� �ڸ� cutting
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
    * String��  double �� ��ȯ <br>
    * @param comma�� ���� String
    * @return  double
    */
   public static double formatDouble(String price){
        if(isNull(price)) return 0;
        return Double.parseDouble(StringUtil.strReplace(price,",",""));
    }



    /**
    * ������ HTML�������� ����Ѵ�.
    * \n�� <br>�� �ְ�
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
    * Ư������ ����� �ǵ��� �Ѵ�.
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
     * ���ڿ��� �ٲ۴�.
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



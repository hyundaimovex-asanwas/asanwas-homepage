package sales.org.util.common;


import java.util.ArrayList;
import java.util.HashMap;

import sales.org.util.CalendarUtil;


public class CommonUtil 
{
	private static HashMap storage = null; 
	
	
	public static String getCodeName(String kind, String code)
	{
		String result = "";
	
		if(kind != null && !kind.equals("") && code != null && !code.equals(""))
		{	
			init();
			
			int codeValue = Integer.parseInt(code);
			
			String value[] = (String[])storage.get(kind);
			
			result = value[(codeValue-1)];
		}
		
		return result;
	}
	
	public static String[] getCodeNames(String kind) {
		return (String[])storage.get(kind);
	}
	
	/**
	 * YN 형태의 코드명 리턴
	 * 
	 * @param kind		<code>종류</code>
	 * @param code		<code>코드값</code>
	 * 
	 * @return 		<code>코드명</code>
	 */
	private static void init()
	{
		storage = new HashMap(); 
		
		storage.put("YN",		new String[] {"Yes", "No"});
		storage.put("SEX",		new String[] {"남자", "여자"});
		storage.put("EXIST",	new String[] {"있음", "없음"});
		storage.put("STOCK",	new String[] {"상장", "비상장"});
		storage.put("EMAIL",	new String[] {"수신함", "수신안함"});
		storage.put("OX",		new String[] {"○", ""});
		storage.put("MEMBER_ROLE",	new String[] {"관리자", "참여회원사", "구매대행사", "전문가", "회원"});
		storage.put("COMP_CODE",	new String[] {"제조업체", "부품제조업체", "유통업체"});
		storage.put("EMAIL_YN",	new String[] {"수신함", "수신안함"});
	}
	
    /**
     *  인수로 받은 문자열 배열을 인수로 받은 델리미터로 구분한 문자열로 변환해서  리턴한다.<p>
     *  
     *  @param  values    <code>대상 문자열 배열</code> 
     *  @param  delemeter <code>델리미터 문자열</code>
     *   
     *  @return 			<code>변환된 문자열</code>
     */
    public static String arrayToString(String values[], String delemeter)
    {
        String returnValue = arrayToString(values, delemeter, "");
        
        return returnValue;
    }   

    /**
     *  인수로 받은 문자열 배열을 인수로 받은 델리미터로 구분한 문자열로 변환해서  리턴한다.(따옴표를 붙여서)<p>
     *  
     *  @param  values		<code>대상 문자열 배열</code> 
     *  @param  delemeter	<code>델리미터 문자열</code> 
     *  @param  quotation	<code>따옴표</code>
     *   
     *  @return 			<code>변환된 문자열</code>
     */
    public static String arrayToString(String values[], String delemeter, String quotation)
    {
        String returnValue = "";
        
        for(int i=0; values != null && i<values.length; i++)
        {
            if(i == 0)
                returnValue += quotation + values[i] + quotation;
            else
                returnValue += delemeter + quotation + values[i] + quotation;
        }
        
        return returnValue;
    }   

    /**
     *  인수로 받은 델리미터로 구분된 문자열을 배열로 변환해서 리턴한다.<p>
     *  
     *  @param  source    <code>대상 문자열</code> 
     *  @param  delemeter <code>델리미터 문자열</code> 
     *  
     *  @return <code>변환된 문자열 배열</code>
     */
    public static String[] stringToArray(String source, String delemeter)
    {
        String endString = "";
        
        return stringToArray(source, delemeter, endString);
    }
    
    /**
     *  인수로 받은 델리미터로 구분된 문자열을 인수로 받은 EOF 문자열까지 배열로 변환해서 리턴한다.<p>
     *  
     *  @param  source    <code>대상 문자열</code> 
     *  @param  delimeter <code>델리미터 문자열</code> 
     *  @param  endString <code>소스문자열 내 EOF 문자열</code>
     *  
     *  @return <code>변환된 문자열 배열</code>
     */
    public static String[] stringToArray(String source, String delimeter, String endString)
    {
        String returnValue[] = null;
        
        // 인수값 검사...

        if(source != null && !source.equals(""))
        {
            if(delimeter != null && !delimeter.equals(""))
            {
                if(endString != null && !endString.equals(""))
                    source = source.substring(0, source.indexOf(endString));        // 종료 문자 검사 후 파싱 문자열 구함...
                
                returnValue = source.split(delimeter);
            }
        }
        
        return returnValue;
    }
    
    /**
     *  인수로 받은 문자열내에 인수로 받은 해당 문자열을, 인수로 받은 문자열 치환해서 리턴한다.<p>
     *  
     *  @param  source     <code>대상 문자열</code> 
     *  @param  targetChar <code>변경전 문자(열)</code> 
     *  @param  changeChar <code>변경후 문자(열)</code>
     *  
     *  @return 치환된 문자열
     */
    public static String replaceString(String source, String targetStr, String changeStr)
    {
        return replaceString(source, new String[] {targetStr}, new String[] {changeStr});
    }

    /**
     *  인수로 받은 문자열내에 인수로 받은 해당 배열에 저장된 문자열을 인수로 받은 배열에 저장된 문자열로 순차적으로 치환해서 리턴한다.<p>
     *  
     *  @param  source     <code>대상 문자열</code> 
     *  @param  targetChar <code>변경전 문자(열)가 저장된 배열</code> 
     *  @param  changeChar <code>변경후 문자(열)가 저장된 배열</code>
     *  
     *  @return 치환된 문자열
     */
    public static String replaceString(String source, String targetStr[], String changeStr[])
    {
        StringBuffer src    = new StringBuffer(source);

        if(source != null && !source.equals(""))
        {
            if(targetStr != null && changeStr != null && targetStr.length == changeStr.length)
            {    
                for(int i=0; i<targetStr.length; i++)
                {
                    int startPos   = 0;
                    
                    while(startPos != -1)
                    {
                        startPos    = src.indexOf(targetStr[i], startPos);
                        
                        if(startPos != -1)
                        {    
                            src.delete(startPos, startPos + targetStr[i].length());
                            src.insert(startPos, changeStr[i]);

                            startPos = startPos + changeStr[i].length() + 1;
                        }
                    }
                }
            }    
        }
        
        return src.toString();
    }
	
    public static String[] getPhoneType(String source, String delemeter)
    {
    	String result[] = stringToArray(source, delemeter);
    	
    	if(result == null || result.equals("--"))
    		result = new String[] {"", "", ""};
    	
    	return result;
    }

    public static String getPhoneDash(String source[], String delemeter)
    {
		String result = "";
		
		if(source != null && source.length == 3)
    	{	
    		if(source[0] != null && !source[0].equals("") && source[1] != null && !source[1].equals("") && source[2] != null && !source[2].equals(""))
    			result = arrayToString(source, delemeter);
    	
    	}
    	return result;
    }

    public static String getSelectOption(ArrayList itemList)
    {
    	return getSelectOption(itemList, "");
    }
    
    public static String getSelectOption(ArrayList itemList, String key)
    {
    	String result = "";
    	
    	for(int i=0; itemList != null && i < itemList.size(); i++)
    	{
    		HashMap item = (HashMap)itemList.get(i);
    		
    		String value	= (String)item.get("value");
    		String name		= (String)item.get("name");
    		
    		String selected = "";

    		if(key != null && key.compareTo(value) == 0)
    			selected = "selected";
    		
    		result += "<option value='" + value+ "' " + selected + ">" + name + "</option>";
    		
    	}
    	
    	return result;
    }
    
    public static String[] arrayCheck(String source[], int size)
    {
    	String result[] = null;
    	
    	if(source == null || source.length < size)
    	{
    		result = new String[size];

    		int sourceLength = 0;
    		
    		if(source != null)
    			sourceLength = source.length;
    		
    		for(int i=0; i<size; i++)
    		{
    			if(i < sourceLength)
    				result[i] = source[i];
    			else
    				result[i] = "";
    		}
    	}
    	else
    		result = source;
    	
    	
    	return result;
    }

    // 셀랙트 박스 년도 옵션 구하기
    
    public static String getYearOption(int prevPosition)
    {
    	String result = "";
    	
    	CalendarUtil calendar = new CalendarUtil();
    	
    	int endYear	= Integer.parseInt(calendar.getYear());
    	
    	int startYear = endYear - prevPosition;
    	
    	
    	for(int i=startYear; i<endYear+1; i++)
    		result += "<option value='" + i + "'>" + i + "</option>" ;
    	
    	return result;
    }

    // 셀랙트 박스 년도 옵션 구하기
    
    public static String getYearOption(String startYear)
    {
    	String result = "";
    	
    	CalendarUtil calendar = new CalendarUtil();
    	
    	int endYear	= Integer.parseInt(calendar.getYear());
    	
    	if(startYear != null && startYear.compareTo(endYear + "") < 0)
    	{	
	    	for(int i=Integer.parseInt(startYear); i<endYear+1; i++)
	    		result += "<option value='" + i + "'>" + i + "</option>" ;
    	}
    	
    	return result;
    }    
}
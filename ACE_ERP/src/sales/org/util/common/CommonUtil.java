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
	 * YN ������ �ڵ�� ����
	 * 
	 * @param kind		<code>����</code>
	 * @param code		<code>�ڵ尪</code>
	 * 
	 * @return 		<code>�ڵ��</code>
	 */
	private static void init()
	{
		storage = new HashMap(); 
		
		storage.put("YN",		new String[] {"Yes", "No"});
		storage.put("SEX",		new String[] {"����", "����"});
		storage.put("EXIST",	new String[] {"����", "����"});
		storage.put("STOCK",	new String[] {"����", "�����"});
		storage.put("EMAIL",	new String[] {"������", "���ž���"});
		storage.put("OX",		new String[] {"��", ""});
		storage.put("MEMBER_ROLE",	new String[] {"������", "����ȸ����", "���Ŵ����", "������", "ȸ��"});
		storage.put("COMP_CODE",	new String[] {"������ü", "��ǰ������ü", "�����ü"});
		storage.put("EMAIL_YN",	new String[] {"������", "���ž���"});
	}
	
    /**
     *  �μ��� ���� ���ڿ� �迭�� �μ��� ���� �������ͷ� ������ ���ڿ��� ��ȯ�ؼ�  �����Ѵ�.<p>
     *  
     *  @param  values    <code>��� ���ڿ� �迭</code> 
     *  @param  delemeter <code>�������� ���ڿ�</code>
     *   
     *  @return 			<code>��ȯ�� ���ڿ�</code>
     */
    public static String arrayToString(String values[], String delemeter)
    {
        String returnValue = arrayToString(values, delemeter, "");
        
        return returnValue;
    }   

    /**
     *  �μ��� ���� ���ڿ� �迭�� �μ��� ���� �������ͷ� ������ ���ڿ��� ��ȯ�ؼ�  �����Ѵ�.(����ǥ�� �ٿ���)<p>
     *  
     *  @param  values		<code>��� ���ڿ� �迭</code> 
     *  @param  delemeter	<code>�������� ���ڿ�</code> 
     *  @param  quotation	<code>����ǥ</code>
     *   
     *  @return 			<code>��ȯ�� ���ڿ�</code>
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
     *  �μ��� ���� �������ͷ� ���е� ���ڿ��� �迭�� ��ȯ�ؼ� �����Ѵ�.<p>
     *  
     *  @param  source    <code>��� ���ڿ�</code> 
     *  @param  delemeter <code>�������� ���ڿ�</code> 
     *  
     *  @return <code>��ȯ�� ���ڿ� �迭</code>
     */
    public static String[] stringToArray(String source, String delemeter)
    {
        String endString = "";
        
        return stringToArray(source, delemeter, endString);
    }
    
    /**
     *  �μ��� ���� �������ͷ� ���е� ���ڿ��� �μ��� ���� EOF ���ڿ����� �迭�� ��ȯ�ؼ� �����Ѵ�.<p>
     *  
     *  @param  source    <code>��� ���ڿ�</code> 
     *  @param  delimeter <code>�������� ���ڿ�</code> 
     *  @param  endString <code>�ҽ����ڿ� �� EOF ���ڿ�</code>
     *  
     *  @return <code>��ȯ�� ���ڿ� �迭</code>
     */
    public static String[] stringToArray(String source, String delimeter, String endString)
    {
        String returnValue[] = null;
        
        // �μ��� �˻�...

        if(source != null && !source.equals(""))
        {
            if(delimeter != null && !delimeter.equals(""))
            {
                if(endString != null && !endString.equals(""))
                    source = source.substring(0, source.indexOf(endString));        // ���� ���� �˻� �� �Ľ� ���ڿ� ����...
                
                returnValue = source.split(delimeter);
            }
        }
        
        return returnValue;
    }
    
    /**
     *  �μ��� ���� ���ڿ����� �μ��� ���� �ش� ���ڿ���, �μ��� ���� ���ڿ� ġȯ�ؼ� �����Ѵ�.<p>
     *  
     *  @param  source     <code>��� ���ڿ�</code> 
     *  @param  targetChar <code>������ ����(��)</code> 
     *  @param  changeChar <code>������ ����(��)</code>
     *  
     *  @return ġȯ�� ���ڿ�
     */
    public static String replaceString(String source, String targetStr, String changeStr)
    {
        return replaceString(source, new String[] {targetStr}, new String[] {changeStr});
    }

    /**
     *  �μ��� ���� ���ڿ����� �μ��� ���� �ش� �迭�� ����� ���ڿ��� �μ��� ���� �迭�� ����� ���ڿ��� ���������� ġȯ�ؼ� �����Ѵ�.<p>
     *  
     *  @param  source     <code>��� ���ڿ�</code> 
     *  @param  targetChar <code>������ ����(��)�� ����� �迭</code> 
     *  @param  changeChar <code>������ ����(��)�� ����� �迭</code>
     *  
     *  @return ġȯ�� ���ڿ�
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

    // ����Ʈ �ڽ� �⵵ �ɼ� ���ϱ�
    
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

    // ����Ʈ �ڽ� �⵵ �ɼ� ���ϱ�
    
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
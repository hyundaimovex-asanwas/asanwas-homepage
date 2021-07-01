package sales.org.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;

public class EncodingUtil
{
	private String key = ""; 
	
	private String source = "";
	
	public EncodingUtil()
	{
		this.key = this.getDate();
	}
	
	public EncodingUtil(String src)
	{
		this.source = src;
		this.key = this.getDate();
	}

	public String encoding()
	{
		return encoding(this.source);
	}
	
	// 암호화 
	
	public String encoding(String src)
	{
		String result = "";

		if(src != null && src.length() > 0 && key != null && !key.equals(""))
		{
			// 전달 받은 문자열을 byte 배열로 변환한다.
			
			byte token[] = src.getBytes();

			// byte 배열 요소를 integer로 변경한 값에 오늘 날짜 값중 일에 해당하는 값으로 곱한 후
			// byte 배열 각 요소 값에 delimeter 문자열(#+배열순번)을 포함해서 하나의 문자열로 만든다. 
			
			for(int i=0; token != null && i < token.length; i++)
			{
				Byte eByte = new Byte(token[i]);
				
				result +=  "#" + i + encrypt(eByte.toString());
			}	
		}
		
		return result;
	}
	
	// 복호화 
	
	public String decoding(String src)
	{
		String result = ""; 
		
		if(src != null && src.length() > 0)
		{
			// 전달받은 문자열을 delimeter 문자(#+배열순번)를 기준으로 delimeter문자열을 제외한 문자배열로 변환한다.
			
			String buff[] = this.stringToArray(src, "#");

			// 복호화된 값을 저장할 byte 배열을 생성한다.
			
			byte[] token = new byte[buff.length];
			
			for(int i=0; i<token.length; i++)
			{
				if(buff[i] != null && !buff[i].equals(""))
				{	
					// 문자배열요소를 integer 값으로 변환 후 오늘 날짜의 일에 해당되는 값으로 나눈 값을 byte 값으로 변환한다.  
					
					Byte iByte = new Byte(decrypt(buff[i]));
					
					// byte 배열에 복호화 된 값을 저장한다. 
					
					token[i] = iByte.byteValue();
				}	
			}
			
			// byte 배열을 문자열로 변환한다. 
			
			result = new String(token);
		}
		return result;
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////

	private String encrypt(String src)
	{
		String result = "" + (Integer.parseInt(src) * Integer.parseInt(key));
		
		return result;
	}
	
	private String decrypt(String src)
	{
		String result = "" + (Integer.parseInt(src) / Integer.parseInt(key));
		
		return result;
	}
	
    /**
     *  인수로 받은 델리미터로 구분된 문자열을 배열로 변환해서 리턴한다.<p>
     *  
     *  @param  source    <code>대상 문자열</code> 
     *  @param  delimeter <code>델리미터 문자열</code> 
     *  @return <code>변환된 문자열 배열</code>
     *  @author pronema
     */
    private String[] stringToArray(String source, String delimeter)
    {
        String returnValue[] = null;
        
        // 인수값 검사...

        if(source != null && !source.equals(""))
        {
            ArrayList temp = new ArrayList();
            
            if(delimeter != null && !delimeter.equals(""))
            {
                for(int i=0; source.length() > 0; i++)
                {
                	String tag = delimeter + i;

                	int pos = source.indexOf(tag); 
                	
                	if(pos == -1)
                	{	
                		temp.add(source);	
                		source = "";
                	}
                	else if(pos == 0)
                		source = source.substring(tag.length());
                	else
                	{	
                		temp.add(source.substring(0, pos));
                		source = source.substring(pos + tag.length());
                	}	
                }
                
                returnValue = new String[temp.size()];
                
                for(int j=0; j<temp.size(); j++)
                {	
                	returnValue[j] = (String)temp.get(j);
                }
            }
        }    
        
        return returnValue;
    }

    
	/**
	 * 현재 년월일을 돌려준다 - YYYYMMDD   
	 */
	private String getDate()
	{
 		Calendar cal = Calendar.getInstance(Locale.getDefault());

 		return "" + (cal.get(Calendar.DATE)+1);
	}
    
////////////////////////////////////////////////////////////////////////////////////////////////////////	

	public String getKey()
	{
		return key;
	}

	public void setKey(String key)
	{
		this.key = key;
	}

	public String getSource()
	{
		return source;
	}

	public void setSource(String source)
	{
		this.source = source;
	}
}

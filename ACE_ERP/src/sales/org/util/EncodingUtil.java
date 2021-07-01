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
	
	// ��ȣȭ 
	
	public String encoding(String src)
	{
		String result = "";

		if(src != null && src.length() > 0 && key != null && !key.equals(""))
		{
			// ���� ���� ���ڿ��� byte �迭�� ��ȯ�Ѵ�.
			
			byte token[] = src.getBytes();

			// byte �迭 ��Ҹ� integer�� ������ ���� ���� ��¥ ���� �Ͽ� �ش��ϴ� ������ ���� ��
			// byte �迭 �� ��� ���� delimeter ���ڿ�(#+�迭����)�� �����ؼ� �ϳ��� ���ڿ��� �����. 
			
			for(int i=0; token != null && i < token.length; i++)
			{
				Byte eByte = new Byte(token[i]);
				
				result +=  "#" + i + encrypt(eByte.toString());
			}	
		}
		
		return result;
	}
	
	// ��ȣȭ 
	
	public String decoding(String src)
	{
		String result = ""; 
		
		if(src != null && src.length() > 0)
		{
			// ���޹��� ���ڿ��� delimeter ����(#+�迭����)�� �������� delimeter���ڿ��� ������ ���ڹ迭�� ��ȯ�Ѵ�.
			
			String buff[] = this.stringToArray(src, "#");

			// ��ȣȭ�� ���� ������ byte �迭�� �����Ѵ�.
			
			byte[] token = new byte[buff.length];
			
			for(int i=0; i<token.length; i++)
			{
				if(buff[i] != null && !buff[i].equals(""))
				{	
					// ���ڹ迭��Ҹ� integer ������ ��ȯ �� ���� ��¥�� �Ͽ� �ش�Ǵ� ������ ���� ���� byte ������ ��ȯ�Ѵ�.  
					
					Byte iByte = new Byte(decrypt(buff[i]));
					
					// byte �迭�� ��ȣȭ �� ���� �����Ѵ�. 
					
					token[i] = iByte.byteValue();
				}	
			}
			
			// byte �迭�� ���ڿ��� ��ȯ�Ѵ�. 
			
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
     *  �μ��� ���� �������ͷ� ���е� ���ڿ��� �迭�� ��ȯ�ؼ� �����Ѵ�.<p>
     *  
     *  @param  source    <code>��� ���ڿ�</code> 
     *  @param  delimeter <code>�������� ���ڿ�</code> 
     *  @return <code>��ȯ�� ���ڿ� �迭</code>
     *  @author pronema
     */
    private String[] stringToArray(String source, String delimeter)
    {
        String returnValue[] = null;
        
        // �μ��� �˻�...

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
	 * ���� ������� �����ش� - YYYYMMDD   
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

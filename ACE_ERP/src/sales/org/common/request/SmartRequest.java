/**********************************************************
�ҽ��� : SmartRequest.java (Ver 5.5)
�ۼ��� : ��â��
�ۼ��� : 2002.11.23
***********************************************************/

package sales.org.common.request;


import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import sales.org.common.log.LogUtil;
import sales.org.util.EncodingUtil;

;

/**
 *  Request ��ü�κ��� �Ķ���Ͱ��� FileStorage ������ ���Ѵ�. <br>
 *  Request ��ü�� ContextType("application/x-www-form-urlencoded" Ȥ�� "multipart/form-data")�� ���� �ڵ����� �Ľ̵ǰ�,<br> 
 *  �Ľ� �� �Ķ���� ����, �Ķ���� �� ���� ������ ���� ���丮�� ������ ���� ���� �� �ִ�.<p>
 *  
 *  @see FileStorage
 *   
 *  @author pronema
 */
public class SmartRequest
{
	private DataInputStream in = null;      // Request ��ü�� ��ȯ�� ��Ʈ���� ����
	
	private ArrayList paramID   = null;     // �Ķ���Ϳ� �ش��ϴ� ���̵� �����
	private HashMap paramStorage = null;     // �Ķ���Ϳ� �ش��ϴ� �� �����
	
	// character set ���� ����, boundary ����  
	
	private String charSet		 = "KSC5601";
	private String boundary	 = "";
	
	// ���� ���� ��ü

	private FileForm fileForm	= null;

	// ����� ���� �ӽ� ����� 
	
	private HashMap objectStorage			= null;
	
	/**
	 *  Request ��ü�� ���� �Ķ���Ϳ� ÷������ ������ ���Ѵ�.<p>
	 *  
	 *  @param  reqs	<code>Request ��ü</code>
	 */     
	public SmartRequest(HttpServletRequest reqs)
	{
		try
		{ 
			if(!reqs.getCharacterEncoding().equals("EUC-KR"))
				reqs.setCharacterEncoding("EUC-KR"); 
		}
		catch(Exception e)
		{
			LogUtil.error(e);
		}
		
		this.inits(reqs);
		
		this.objectStorage = new HashMap();
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    /**
     *  �Ķ���� �� �ش��ϴ� �Ķ���� ������ ������ String ��ü �迭�� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ���� ����� String ��ü �迭</code>
     */     
    public String[] getParameterArray(String paramName)
    {
        String result[] = null;
        
        if(this.paramStorage != null && !this.paramStorage.isEmpty())
        {
            result = toArray((ArrayList)this.paramStorage.get(paramName));
            
            if(result == null)
                result = new String[0];
        }
        else
            result = new String[0];
        
        return result;  
    }

    /**
     *  �Ķ���� �� �ش��ϴ� �Ķ���� ������ ������ ArrayList�� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ���� ����� ArrayList ��ü </code>
     */     
    public ArrayList getParameterList(String paramName)
    {
    	ArrayList result = new ArrayList();
    	
        if(this.paramStorage != null && !this.paramStorage.isEmpty())
            result = (ArrayList)this.paramStorage.get(paramName);
        
        return result;  
    }
    
    /**
     *  �Ķ���� �� �ش��ϴ� �Ķ���Ͱ��� ���� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ��</code>
     */     
    public String getParameter(String paramName)
    {
        ArrayList value = (ArrayList)this.paramStorage.get(paramName);

        String result = "";
        
        if(value != null && !value.isEmpty())
        	result = (String)value.get(0);
        
        return result;
    }

    /**
     * ���޹��� �Ķ���Ϳ� �ش��ϴ� ���� �߰� �Ǵ� ��ü �Ѵ�.  
     * 
     * @param paramName	<code>�Ķ���� ��</code>
     * @param paramValue	<code>�Ķ���� ��</code>
     */
    public void setParameter(String paramName, String paramValue)
    {
    	if(paramName != null && !paramName.equals(""))
    	{
    		if(!this.paramStorage.containsKey(paramName))
    		{
    			ArrayList value = new ArrayList();
    			
    			value.add(paramValue);
    			
    			this.paramStorage.put(paramName, value);
    		}
    		else
    		{
    			ArrayList value = (ArrayList)this.paramStorage.get(paramName);
    			
    			value.set(0, paramValue);
    			
    			this.paramStorage.put(paramName, value);
    		}
    		
    		this.paramID.add(paramName);
    	}
    }

    /**
     * ���޹��� �Ķ���͸� �ش��ϴ� ArrayList�� �߰� �Ǵ� ��ü �Ѵ�.  
     * 
     * @param paramName	<code>�Ķ���� ��</code>
     * @param paramValue	<code>�Ķ���� ���� ����ִ� ArrayList ��ü</code>
     */
    public void setParameter(String paramName, ArrayList paramValue)
    {
    	if(paramName != null && !paramName.equals(""))
    	{
    		if(paramValue != null)	
    			this.paramStorage.put(paramName, paramValue);

    		this.paramID.add(paramName);
    	}
    }

    /**
     * ���޹��� �Ķ���͸� �ش��ϴ� �迭 ���� �߰� �Ǵ� ��ü �Ѵ�.  
     * 
     * @param paramName	<code>�Ķ���� ��</code>
     * @param paramValue	<code>�Ķ���� ���� ����ִ� String �迭</code>
     */
    public void setParameter(String paramName, String[] paramValue)
    {
    	if(paramName != null && !paramName.equals(""))
    	{
    		if(paramValue != null)	
    			this.paramStorage.put(paramName, toArrayList(paramValue));

    		this.paramID.add(paramName);
    	}
    }
    
    /**
     *  �Ķ���� �� �ش��ϴ� ���� �Ķ���� ���� ���� String ���·� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ��</code>
     */     
    public String getString(String paramName) throws Exception
    {
    	return getParameter(paramName);
    }
    
    /**
     *  �Ķ���� �� �ش��ϴ� ���� �Ķ���� ���� ���� int ���·� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ��</code>
     */     
    public int getInt(String paramName) throws Exception
    {
    	int result = 0;
    	
    	String tempValue = getParameter(paramName);
    	
    	if(tempValue != null && !tempValue.equals(null) && !tempValue.equals("null") && !tempValue.equals(""))
    		result = Integer.parseInt(tempValue);
    	
    	return result;
    }
    
    /**
     *  �Ķ���� �� �ش��ϴ� ���� �Ķ���� ���� ���� long ���·� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ��</code>
     */     
    public long getLong(String paramName) throws Exception
    {
    	long result = 0;
    	
    	String tempValue = getParameter(paramName);
    	
    	if(tempValue != null && !tempValue.equals(null) && !tempValue.equals("null") && !tempValue.equals(""))
    		result = Long.parseLong(tempValue);
    	
    	return result;
    }
    
    /**
     *  �Ķ���� �� �ش��ϴ� ���� �Ķ���� ���� ���� double ���·� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ��</code>
     */     
    public double getDouble(String paramName) throws Exception
    {
    	double result = 0;
    	
    	String tempValue = getParameter(paramName);
    	
    	if(tempValue != null && !tempValue.equals(null) && !tempValue.equals("null") && !tempValue.equals(""))
    		result = Double.parseDouble(tempValue);
    	
    	return result;
    }
    
    /**
     *  �Ķ���� �� �ش��ϴ� ���� �Ķ���� ���� ���� float ���·� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>�Ķ���� ��</code>
     */     
    public float getFloat(String paramName) throws Exception
    {
    	float result = 0;
    	
    	String tempValue = getParameter(paramName);
    	
    	if(tempValue != null && !tempValue.equals(null) && !tempValue.equals("null") && !tempValue.equals(""))
    		result = Float.parseFloat(tempValue);
    	
    	return result;
    }
    
    /**
     *  Request�� ���Ե� ��� �Ķ���� ���� �����Ѵ�.<p>
     *  
     *  @return <code>�Ķ���� ���� ����� ArrayList ��ü</code>
     */     
    public ArrayList getParameterNameList()
    {
        return paramID;
    }
    
    /**
     *  Request�� ���Ե� ��� �Ķ���� ���� �����Ѵ�.<p>
     *  
     *  @return <code>�Ķ���� ���� ����� String ��ü �迭</code>
     */     
    public String[] getParameterNameArray()
    {
        return this.toArray(paramID);
    }

    /**
     *  �Ķ���� �� �ش��ϴ� ���Ͻ��丮�� ������ ����� ArrayList ��ü�� �����Ѵ�.<p>
     *  
     *  @return <code>���Ͻ��丮�� ������ ����� ArrayList ��ü</code>
     *
     *  @see FileStorage
     */     
    public ArrayList getFileStorageList(String paramId)
    {
    	ArrayList result = null;
    	
    	if(this.fileForm != null)
    		result = this.fileForm.getFileStorageList(paramId);
    	
        return result;
    }

    /**
     *  �Ķ���� �� �ش��ϴ� ���Ͻ��丮�� ���� ��ü�� �����Ѵ�.<p>
     *  
     *  @return <code>���Ͻ��丮�� ���� ��ü</code>
     *
     *  @see FileStorage
     */     
    public FileStorage getFileStorage(String paramId)
    {
    	FileStorage result = null;
    	
    	if(this.fileForm != null)
    		result = this.fileForm.getFileStorage(paramId);
    	
        return result;
    }

    /**
     *  ����� ���� ������ �߰��Ѵ�.<p>
     *  
     *  @param objId 	<code>������ �ش��ϴ� ���̵�</code>
     *  @param obj 	<code>����� ���� ����</code>
     *
     *  @see FileStorage
     */     
    public void setObject(String objId, Object obj)
    {
    	if(objId != null && !objId.trim().equals("") && obj != null)
    		this.objectStorage.put(objId, obj); 
    }

    /**
     *  ���̵� �ش��ϴ� ����� ���� ������ �����Ѵ�.<p>
     *  
     *  @return <code>���̵� �ش��ϴ� ����� ���� ����</code>
     *
     *  @see FileStorage
     */     
    public Object getObject(String objId)
    {
    	return this.objectStorage.get(objId); 
    }

    
    /**
     *  Request�� ���� �Ķ���� ������ ���ڵ��� Query String���� ��ȯ�ؼ� �����Ѵ�.<p>
     *  
     *  @return <code>���̵� �ش��ϴ� ����� ���� ����</code>
     *
     *  @see FileStorage
     */     
    public String toString()
    {
    	String result = "";
    	
        for(int i=0; paramID != null && i<paramID.size(); i++)
        {
            ArrayList paramValue = (ArrayList)this.paramStorage.get((String)paramID.get(i));
            
            for(int j=0; paramValue != null && j<paramValue.size(); j++)
            {
            	if(i > 0)
            		result += "&";
            	
                result += (String)paramID.get(i) + "=" + (String)paramValue.get(j);
            }
        }   
    	
        EncodingUtil encoder = new EncodingUtil(result); 
        
        result = encoder.encoding();
        
    	return result;
    }

    /**
     *  ���ڵ��� �Ķ���� ������ ���ڵ��� ���ڿ��� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>���ڵ��� �Ķ���� query ��</code>
     */     
    public String convertToQueryString(String paramName)
    {
    	String result = "";
    	
        ArrayList value = (ArrayList)this.paramStorage.get(paramName);

        if(value != null && !value.isEmpty())
        {	
        	result = (String)value.get(0);
    	
    	
        	if(result != null && !result.equals(null) && !result.equals("null") && !result.equals("") && result.substring(0, 1).equals("#"))
        	{	
        		EncodingUtil encoder = new EncodingUtil(); 
            
        		result = encoder.decoding(result);
        	}
    	}	
    		
    	return result;
    }

    /**
     *  ���ڵ��� �Ķ���� ������ ���ڵ��� �� html hidden input �ʵ� ��Ʈ������ �����ؼ� �����Ѵ�.<p>
     *  
     *  @param  paramName   <code>�Ķ���� ��</code>
     *
     *  @return <code>���ڵ��� html hidden input �ʵ� ��Ʈ��</code>
     */     
    public String convertToFormString(String paramName)
    {
    	String result = "";
    	
    	ArrayList paramList = toArrayList(convertToQueryString(paramName).split("&"));    	
    	
    	for(int i=0; paramList != null && i < paramList.size(); i++){
    		String paramStr = (String)paramList.get(i); 

    		if(paramStr != null && !paramStr.equals(null) && !paramStr.equals("null") && !paramStr.equals(""))
    		{
    			String paramStatement[] = paramStr.split("=");
    			
    			if(paramStatement != null && paramStatement.length == 2 && paramStatement[1] != null && !paramStatement[1].equals(""))
    				result += "<input type='hidden' name='" + paramStatement[0] + "' value='" + paramStatement[1] + "'>\n";
    		}	
    	}
    	
    	return result;
    }
    
    
    /**
     *  ������ �Ķ���Ϳ� ���Ͽ� ���õ� ������ �ֿܼ� ����Ѵ�. (���� �׽�Ʈ ��)<p>
     *  
     */     
    public void printParameter()
    {
        for(int i=0; paramID != null && i<paramID.size(); i++)
        {
            ArrayList paramValue = (ArrayList)this.paramStorage.get((String)paramID.get(i));
            
            for(int j=0; paramValue != null && j<paramValue.size(); j++)
            {
                byte temp[] = ((String)paramValue.get(j)).getBytes();
                
                System.out.println((String)paramID.get(i) + " [" + temp.length + " Bytes] : " + (String)paramValue.get(j));
            }
        }   
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////

    private void inits(HttpServletRequest reqs)
    {
        if(reqs.getContentType() != null)
        {
            if(reqs.getContentType().indexOf("application/x-www-form-urlencoded") != -1)
                normalRequest(reqs);
            else if(reqs.getContentType().indexOf("multipart/form-data") != -1)
                multiPartRequest(reqs);
        }
        else
            normalRequest(reqs);
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////
    
    // ContextType�� "application/x-www-form-urlencoded" �� ��� �Ķ���Ͱ� ���ϱ�

    private void normalRequest(HttpServletRequest req)
    {
    	this.paramID = new ArrayList();
        this.paramStorage  = new HashMap();     

        Enumeration em = req.getParameterNames();

        while(em.hasMoreElements())
        {
        	// �Ķ���� ��
        	
        	String paramName = (String)em.nextElement();

        	this.paramID.add(paramName);
        	
        	// �Ķ���� ��
        	
        	String paramValue[] = convertCharSet(req.getParameterValues(paramName), this.charSet);

            this.paramStorage.put(paramName, toArrayList(paramValue));
        }
    }

////////////////////////////////////////////////////////////////////////////////////////////////

    // ContextType�� "multipart/form-data" �� ��� �Ķ���Ͱ� ���ϱ�
    
    private void multiPartRequest(HttpServletRequest req)
    {
        try
        {
            this.fileForm = new FileForm();
            
            this.in = new DataInputStream(req.getInputStream());
            
            this.boundary = this.readLine();

            this.parseRequest();            // Request ��ü �Ľ��ϱ�
        }
        catch(Exception e)
        {
            this.in = null;

      		LogUtil.error(e);
        }       
    }

    // �Ľ� �� �� ȭ������ / �Ķ���� ������ �ؽ����̺� �� �ӽ� ȭ�Ϸ� �����Ѵ�. 

    private void parseRequest() throws Exception
    {
        String tempLine = "";

        int spos = 0;                   // �Ľ� ���� ��ġ
        int epos = 0;                   // �Ľ� �� ��ġ
        
        this.paramID     		= new ArrayList();
        this.paramStorage      = new HashMap();

        while((tempLine = this.readLine()) != null)
        {   
            String paramName	= "";				// �Ķ���� �̸�

            String paramValue	= "";				// �Ķ���� ��
            String realFileName	= "";				// ���� ���ϸ�  
            
            ArrayList paramValues	= null;			// �Ķ���� ��

            spos = tempLine.indexOf("name=") + 6;
            
            if(spos != 5)
            {
                epos = tempLine.indexOf("\";",spos);
                
                // 1. ȭ�� ���� ó��

                if(epos != -1)
                {
                	// ȭ�� �Ķ���� �� ���� �� �Ķ���͸� ���� ����

                    paramName = tempLine.substring(spos, epos);
                    
                    // ȭ�� �̸� ����.

                    spos = tempLine.indexOf("filename=") + 10;
                    
                    if(spos != 9)
                    {
                        epos = tempLine.indexOf("\"", spos);
                        
                        if(epos != -1)
                        {
                            if(spos - epos != -1)
                                realFileName = tempLine.substring(spos, epos); 
                            else
                                realFileName = "";    

                            if(realFileName != null && !realFileName.equals(""))
                            {
                                if(realFileName.lastIndexOf("\\") != -1)
                                {    
                                    realFileName = realFileName.substring(realFileName.lastIndexOf("\\")+1);
//                                    realFileName = new String(realFileName.getBytes("8859_1"), "KSC5601");
                                }   
                                // ȭ�� �̸� ����

                                String name = realFileName.substring(0, realFileName.lastIndexOf("."));
                                String ext  = realFileName.substring(realFileName.lastIndexOf(".") + 1);

                                paramValue = System.currentTimeMillis() + "_" + name + "." + ext;
                                
                                // ȭ�� ������ �����ϱ�

                                boolean check = saveFileForm(realFileName, paramValue, paramName);
                                
                                if(check == false)
                                    paramValue = "";
                            }
                        }               
                    }
                }
                
                // 2. �Ķ���� ����
                
                else
                {
                	epos = tempLine.indexOf("\"", spos);
                    
                    if(epos != -1)
                    {
                        // �Ķ���� �� ����

                        paramName = tempLine.substring(spos, epos); 

                        tempLine = this.readLine();
                        tempLine = this.readLine();

	                    
                        if(tempLine != null && !tempLine.equals(""))
                        {	
                        	// �Ķ���� �� ����
                        	
	                        for(int s=0; tempLine.indexOf(this.boundary) < 0; s++)
	                        {   
	                        	if(tempLine != null && !tempLine.equals("")) 
	                                paramValue += tempLine.trim() + "\r\n";
	
	                            tempLine = this.readLine();

	                            if(tempLine == null)
	                            	tempLine = "";
	                        }
	                        
	                        if(paramValue != null && !paramValue.equals(""))
	                            paramValue = paramValue.substring(0, paramValue.lastIndexOf("\r\n"));
                    	}    
                    }
                }

                //3. �Ķ���� ����
                
                if(this.paramStorage.containsKey(paramName))
                {    
                    paramValues   = (ArrayList)this.paramStorage.get(paramName);
                }    
                else
                {
                    this.paramID.add(paramName);
                    
                    paramValues   = new ArrayList();
                }

                if(paramValue != null && !paramValue.equals(""))
                	paramValues.add(paramValue);

                this.paramStorage.put(paramName, paramValues);
            }
        }
    }

    // ȭ���� ���� �ϱ�

    private boolean saveFileForm(String originalFileName, String realFileName, String paramName) throws Exception
    {
        String str = "";

        boolean returnValue = false;

        
        if((str = this.readLine()) != null)
        {
            if(str.indexOf("Content-Type") != -1)
            {
                str = this.readLine();
                
                ByteArrayOutputStream files = saveFileStreams();

                str = this.readLine();

                FileStorage fileInfo = new FileStorage();
                
                fileInfo.setOriginalFileName(originalFileName);
                fileInfo.setRealFileName(realFileName);
                fileInfo.setFileBuffer(files);
                fileInfo.setFileSize(files.size());
                fileInfo.setFileKind(originalFileName.substring(originalFileName.lastIndexOf(".") + 1));
                
                fileForm.setFileStorage(paramName, fileInfo);
            }

            returnValue = true;
        }
    
        return returnValue;
    }
    
    // ��Ʈ�� ������ ByteBuffer�� ����.

    private ByteArrayOutputStream saveFileStreams() throws Exception
    {
        ByteArrayOutputStream returnValue = new ByteArrayOutputStream();
        
        byte[] buffer = new byte[1024];
        
        byte tm;        // ���� ���� ����Ʈ
        byte tm2;       // ���� ���� ����Ʈ
        
        int x = 0;
        
        boolean check = false;      // cf,lr üũ
        
        tm = buffer[0];         // �ʱ�ȭ
        
        for(;;) 
        {
            tm2 = tm; // ���� ���� ����Ʈ ���
            
            buffer[x++] = tm = in.readByte(); // ���� ���� ����Ʈ ���
        
            if(x == boundary.length()+1) 
            {
                int y = 0;
                
                String temp = new String(buffer, 0, x);
        
                if((y = temp.indexOf(boundary)) != -1) 
                {
                    x = y;
                    
                    if(x != 0)
                        returnValue.write(buffer, 0, x-1);
                        
                    break;
                }
            }
            else
            {
                if((x==1023) || (tm =='\n')) 
                {
                    if(check)           // cr,lfüũ��  üũ�Ǿ������� ������ �ڷᰡ �ƴϹǷ� ���ʿ��� ���� cr,lf�� �߰� �Ѵ�.
                    { 
                        returnValue.write('\r');
                        returnValue.write('\n');
                        
                        check = false;
                    }
        
                    if((tm2 =='\r') && (tm =='\n'))  // ���� ����Ʈ�� ���� ����Ʈ�� cr,lf �̸� üũ�ϰ� cr,lf�� �� ������ ����Ʈ�� ���
                    { 
                        check = true;
                        
                        returnValue.write(buffer, 0, x-2);
                    }
                    else
                        returnValue.write(buffer, 0, x);
                    
                    x = 0;
                }
            }
        }

        return returnValue;     
    }

    // DataInputStream ���� 1���� �о ����
    
    private String readLine() throws Exception
    {
    	String result = null;
    	
    	ByteArrayOutputStream bo = new ByteArrayOutputStream();     	
    	
        byte[] buffer	= new byte[1024];

        byte cell[] = new byte[1];
        
        boolean trigger = false;
        
        try
        {
	        for(int i=0; this.in.read(cell) != -1; i++)
	        {
	        	buffer[i] = cell[0];

	        	if(i == 1023)
	        	{
	        		bo.write(buffer);
	        		
	        		buffer = new byte[1024];
	        		i = 0;
	        	}	

	        	if(cell[0] == '\n')
	        	{	
	        		if(i > 0)
	        			bo.write(buffer, 0, i-1);
	        		
	        		trigger = true;
	        		
	        		break;
	        	}
	        }
	        
	        if(bo != null && bo.size() > 0)
	        {	
	        	result = new String(bo.toByteArray(), this.charSet);
//System.out.println(">> '" + result);	        
	        }
	        else
	        {	
		        if(trigger)
		        	result = "";
		        else
		        	result = null;
	        }
	        
	        bo.close();
        }    
        catch(Exception e)
        {
    		LogUtil.error(e);
        	
        	throw e;
        }
        
        return result;
    }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    // ArrayList�� �迭�� ��ȯ
    
    private String[] toArray(ArrayList source)
	{
    	String result[] = null;
    	
    	if(source != null && source.size() > 0)
    	{
    		result = new String[source.size()];
    		
    		for(int i=0; i<source.size(); i++)
    			result[i] = (String)source.get(i);
    	}	
    	
    	return result;
	}

    // �迭�� ArrayList �� ��ȯ 
    
    private ArrayList toArrayList(String source[])
	{
    	ArrayList result = null;
    	
    	if(source != null && source.length > 0)
    	{
    		result = new ArrayList();
    		
    		for(int i=0; i<source.length; i++)
    			result.add(source[i]);
    	}	
    	
    	return result;
	}
    
    //  ���ڿ� 1���� �迭�� charSet�� �����Ѵ�. (true : KSC5601�� ��ȯ, false : 8859_1�� ��ȯ)

    private String[] convertCharSet(String source[], String characterSet)
    {
		try
		{
			for(int i=0; source != null && i<source.length; i++)
			{
				if(source[i] != null || source[i].equals(""))
				{
					source[i] = new String(source[i].getBytes(), characterSet);
				}
			}
		}
		catch(Exception e)
		{ 
		    
				LogUtil.error(e);
		}
        
		return source;
    } 
}
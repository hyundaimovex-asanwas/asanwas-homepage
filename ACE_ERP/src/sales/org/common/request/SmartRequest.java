/**********************************************************
소스명 : SmartRequest.java (Ver 5.5)
작성자 : 박창모
작성일 : 2002.11.23
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
 *  Request 객체로부터 파라메터값과 FileStorage 정보를 구한다. <br>
 *  Request 객체의 ContextType("application/x-www-form-urlencoded" 혹은 "multipart/form-data")에 따라 자동으로 파싱되고,<br> 
 *  파싱 후 파라메터 정보, 파라메터 명에 대한 정보와 파일 스토리지 정보를 리턴 받을 수 있다.<p>
 *  
 *  @see FileStorage
 *   
 *  @author pronema
 */
public class SmartRequest
{
	private DataInputStream in = null;      // Request 객체를 변환한 스트림값 저장
	
	private ArrayList paramID   = null;     // 파라메터에 해당하는 아이디 저장소
	private HashMap paramStorage = null;     // 파라메터에 해당하는 값 저장소
	
	// character set 설정 유무, boundary 변수  
	
	private String charSet		 = "KSC5601";
	private String boundary	 = "";
	
	// 파일 저장 객체

	private FileForm fileForm	= null;

	// 사용자 정보 임시 저장소 
	
	private HashMap objectStorage			= null;
	
	/**
	 *  Request 객체로 부터 파라메터와 첨부파일 정보를 구한다.<p>
	 *  
	 *  @param  reqs	<code>Request 객체</code>
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
     *  파라메터 명에 해당하는 파라메터 값들을 저장한 String 객체 배열을 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값이 저장된 String 객체 배열</code>
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
     *  파라메터 명에 해당하는 파라메터 값들을 저장한 ArrayList을 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값이 저장된 ArrayList 객체 </code>
     */     
    public ArrayList getParameterList(String paramName)
    {
    	ArrayList result = new ArrayList();
    	
        if(this.paramStorage != null && !this.paramStorage.isEmpty())
            result = (ArrayList)this.paramStorage.get(paramName);
        
        return result;  
    }
    
    /**
     *  파라메터 명에 해당하는 파라메터값을 구해 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값</code>
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
     * 전달받은 파라메터에 해당하는 값을 추가 또는 대체 한다.  
     * 
     * @param paramName	<code>파라메터 명</code>
     * @param paramValue	<code>파라메터 값</code>
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
     * 전달받은 파라메터명에 해당하는 ArrayList를 추가 또는 대체 한다.  
     * 
     * @param paramName	<code>파라메터 명</code>
     * @param paramValue	<code>파라메터 값이 들어있는 ArrayList 객체</code>
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
     * 전달받은 파라메터명에 해당하는 배열 값을 추가 또는 대체 한다.  
     * 
     * @param paramName	<code>파라메터 명</code>
     * @param paramValue	<code>파라메터 값이 들어있는 String 배열</code>
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
     *  파라메터 명에 해당하는 단일 파라메터 값을 구해 String 형태로 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값</code>
     */     
    public String getString(String paramName) throws Exception
    {
    	return getParameter(paramName);
    }
    
    /**
     *  파라메터 명에 해당하는 단일 파라메터 값을 구해 int 형태로 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값</code>
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
     *  파라메터 명에 해당하는 단일 파라메터 값을 구해 long 형태로 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값</code>
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
     *  파라메터 명에 해당하는 단일 파라메터 값을 구해 double 형태로 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값</code>
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
     *  파라메터 명에 해당하는 단일 파라메터 값을 구해 float 형태로 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>파라메터 값</code>
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
     *  Request에 포함된 모든 파라메터 명을 리턴한다.<p>
     *  
     *  @return <code>파라메터 명이 저장된 ArrayList 객체</code>
     */     
    public ArrayList getParameterNameList()
    {
        return paramID;
    }
    
    /**
     *  Request에 포함된 모든 파라메터 명을 리턴한다.<p>
     *  
     *  @return <code>파라메터 명이 저장된 String 객체 배열</code>
     */     
    public String[] getParameterNameArray()
    {
        return this.toArray(paramID);
    }

    /**
     *  파라메터 명에 해당하는 파일스토리지 정보가 저장된 ArrayList 객체를 리턴한다.<p>
     *  
     *  @return <code>파일스토리지 정보가 저장된 ArrayList 객체</code>
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
     *  파라메터 명에 해당하는 파일스토리지 정보 객체를 리턴한다.<p>
     *  
     *  @return <code>파일스토리지 정보 객체</code>
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
     *  사용자 정의 정보를 추가한다.<p>
     *  
     *  @param objId 	<code>정보에 해당하는 아이디</code>
     *  @param obj 	<code>사용자 정의 정보</code>
     *
     *  @see FileStorage
     */     
    public void setObject(String objId, Object obj)
    {
    	if(objId != null && !objId.trim().equals("") && obj != null)
    		this.objectStorage.put(objId, obj); 
    }

    /**
     *  아이디에 해당하는 사용자 정의 정보를 리턴한다.<p>
     *  
     *  @return <code>아이디에 해당하는 사용자 정의 정보</code>
     *
     *  @see FileStorage
     */     
    public Object getObject(String objId)
    {
    	return this.objectStorage.get(objId); 
    }

    
    /**
     *  Request에 속한 파라메터 정보를 인코딩된 Query String으로 변환해서 리턴한다.<p>
     *  
     *  @return <code>아이디에 해당하는 사용자 정의 정보</code>
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
     *  인코딩된 파라메터 쿼리를 디코딩한 문자열로 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>디코딩된 파라메터 query 값</code>
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
     *  인코딩된 파라메터 쿼리를 디코딩한 후 html hidden input 필드 스트링으로 변경해서 리턴한다.<p>
     *  
     *  @param  paramName   <code>파라메터 명</code>
     *
     *  @return <code>디코딩된 html hidden input 필드 스트링</code>
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
     *  구해진 파라메터와 파일에 관련된 정보를 콘솔에 출력한다. (개발 테스트 용)<p>
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
    
    // ContextType이 "application/x-www-form-urlencoded" 일 경우 파라메터값 구하기

    private void normalRequest(HttpServletRequest req)
    {
    	this.paramID = new ArrayList();
        this.paramStorage  = new HashMap();     

        Enumeration em = req.getParameterNames();

        while(em.hasMoreElements())
        {
        	// 파라메터 명
        	
        	String paramName = (String)em.nextElement();

        	this.paramID.add(paramName);
        	
        	// 파라메터 값
        	
        	String paramValue[] = convertCharSet(req.getParameterValues(paramName), this.charSet);

            this.paramStorage.put(paramName, toArrayList(paramValue));
        }
    }

////////////////////////////////////////////////////////////////////////////////////////////////

    // ContextType이 "multipart/form-data" 일 경우 파라메터값 구하기
    
    private void multiPartRequest(HttpServletRequest req)
    {
        try
        {
            this.fileForm = new FileForm();
            
            this.in = new DataInputStream(req.getInputStream());
            
            this.boundary = this.readLine();

            this.parseRequest();            // Request 객체 파싱하기
        }
        catch(Exception e)
        {
            this.in = null;

      		LogUtil.error(e);
        }       
    }

    // 파싱 후 각 화일정보 / 파라메터 정보를 해시테이블 및 임시 화일로 저장한다. 

    private void parseRequest() throws Exception
    {
        String tempLine = "";

        int spos = 0;                   // 파싱 시작 위치
        int epos = 0;                   // 파싱 끝 위치
        
        this.paramID     		= new ArrayList();
        this.paramStorage      = new HashMap();

        while((tempLine = this.readLine()) != null)
        {   
            String paramName	= "";				// 파라메터 이름

            String paramValue	= "";				// 파라메터 값
            String realFileName	= "";				// 원본 파일명  
            
            ArrayList paramValues	= null;			// 파라메터 값

            spos = tempLine.indexOf("name=") + 6;
            
            if(spos != 5)
            {
                epos = tempLine.indexOf("\";",spos);
                
                // 1. 화일 관련 처리

                if(epos != -1)
                {
                	// 화일 파라메터 명 구한 후 파라메터명 별도 저장

                    paramName = tempLine.substring(spos, epos);
                    
                    // 화일 이름 구함.

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
                                // 화일 이름 생성

                                String name = realFileName.substring(0, realFileName.lastIndexOf("."));
                                String ext  = realFileName.substring(realFileName.lastIndexOf(".") + 1);

                                paramValue = System.currentTimeMillis() + "_" + name + "." + ext;
                                
                                // 화일 내용을 저장하기

                                boolean check = saveFileForm(realFileName, paramValue, paramName);
                                
                                if(check == false)
                                    paramValue = "";
                            }
                        }               
                    }
                }
                
                // 2. 파라메터 관련
                
                else
                {
                	epos = tempLine.indexOf("\"", spos);
                    
                    if(epos != -1)
                    {
                        // 파라메터 명 구함

                        paramName = tempLine.substring(spos, epos); 

                        tempLine = this.readLine();
                        tempLine = this.readLine();

	                    
                        if(tempLine != null && !tempLine.equals(""))
                        {	
                        	// 파라메터 값 구함
                        	
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

                //3. 파라메터 구성
                
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

    // 화일폼 저장 하기

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
    
    // 스트림 내용을 ByteBuffer로 저장.

    private ByteArrayOutputStream saveFileStreams() throws Exception
    {
        ByteArrayOutputStream returnValue = new ByteArrayOutputStream();
        
        byte[] buffer = new byte[1024];
        
        byte tm;        // 현재 읽은 바이트
        byte tm2;       // 이전 읽은 바이트
        
        int x = 0;
        
        boolean check = false;      // cf,lr 체크
        
        tm = buffer[0];         // 초기화
        
        for(;;) 
        {
            tm2 = tm; // 이전 읽은 바이트 기억
            
            buffer[x++] = tm = in.readByte(); // 현재 읽은 바이트 기억
        
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
                    if(check)           // cr,lf체크가  체크되어있으면 마지막 자료가 아니므로 앞쪽에서 뺐던 cr,lf를 추가 한다.
                    { 
                        returnValue.write('\r');
                        returnValue.write('\n');
                        
                        check = false;
                    }
        
                    if((tm2 =='\r') && (tm =='\n'))  // 이전 바이트와 현재 바이트가 cr,lf 이면 체크하고 cr,lf를 뺀 앞쪽의 바이트를 기록
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

    // DataInputStream 에서 1라인 읽어서 리턴
    
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
    
    // ArrayList를 배열로 변환
    
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

    // 배열을 ArrayList 로 변환 
    
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
    
    //  문자열 1차원 배열의 charSet을 변경한다. (true : KSC5601로 변환, false : 8859_1로 변환)

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
/**********************************************************
소스명 : FileStorage.java (Ver 1.0)
작성자 : 박창모
작성일 : 2002.11.23
***********************************************************/
package sales.org.common.request;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;

/**
 *  SmartRequest 객체에서 구해진 첨부파일에 관련된 정보로 첨부된 파일에 해당하는 <br>
 *  실제 파일 내용(ByteStream), 저장될 파일명, 실제 파일명, 파일사이즈, 파일 종류정보가 저장되어 있으며<br> 
 *  이들 정보를 리턴하는 메소드와 파일을 서버내 특정 디렉토리에 저장하기 위한 메소드가 지원된다.<p> 
 *  
 *  @see SmartRequest
 *   
 *  @author pronema
 */
public class FileStorage
{
    private ByteArrayOutputStream fileBuffer   = null;

    private String realFileName     = "";
    private String originalFileName = "";
    private String fileKind         = "";
    
    private long fileSize = 0;
    
    /**
     *  특정 디렉토리에 파일을 저장한다.<p>
     *  
     *  @param		rootDir		<code>파일을 저장할 디렉토리</code>
     *  
     *  @return <code>성공여부</code>
     */     
    public boolean saveFile(String rootDir)
    {
        boolean result = false; 
        
        FileOutputStream outFile = null;
        
        try
        {
            if(this.fileBuffer != null && this.fileBuffer.size() > 0)
            {
                outFile = new FileOutputStream(new File(getDirectory(rootDir) + this.realFileName));
                
                outFile.write(this.fileBuffer.toByteArray());

                outFile.close();	outFile = null;
                this.fileBuffer.close();	this.fileBuffer = null;
            }
        }
        catch(Exception e)
        {
        	try
        	{
    	    	if(outFile != null) outFile.close(); outFile = null;
    	    	if(this.fileBuffer != null)	this.fileBuffer.close(); this.fileBuffer = null;
        	}
        	catch(Exception ec)
        	{}

        	e.printStackTrace();
        }
        
        return result;
    }

    /**
     *  파일내용을 저장한 정보를 Clear 시킨다.<p>
     *  
     */     
    public void close()
    {
    	try
    	{
	    	if(fileBuffer != null)	this.fileBuffer.close(); this.fileBuffer = null;
	    	
	    	this.realFileName     = "";
	        this.originalFileName = "";
	        this.fileKind         = "";
	        
	        this.fileSize = 0;
    	}
    	catch(Exception e)
    	{}
    }
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    /**
     *  첨부파일 종류를 리턴한다.<p>
     *  
     *  @return <code>첨부파일 확장자</code>
     */     
    public String getFileKind()
    {
        return fileKind.toLowerCase();
    }

    /**
     *  첨부파일 크기를 리턴한다.<p>
     *  
     *  @return <code>첨부파일 크기(Byte단위)</code>
     */     
    public long getFileSize()
    {
        return fileSize;
    }

    /**
     *  첨부파일 원래 명칭을 리턴한다.<p>
     *  
     *  @return <code>첨부파일 원래 명칭</code>
     */     
    public String getOriginalFileName()
    {
        return originalFileName;
    }

    /**
     *  첨부파일 저장명을 리턴한다.<p>
     *  
     *  @return <code>첨부파일 저장이름</code>
     */     
    public String getRealFileName()
    {
        return realFileName;
    }

    final void setFileKind(String fileKind)
    {
        this.fileKind = fileKind;
    }

    final void setFileSize(long fileSize)
    {
        this.fileSize = fileSize;
    }

    final void setOriginalFileName(String originalFileName)
    {
        this.originalFileName = originalFileName;
    }

    final void setRealFileName(String realFileName)
    {
        this.realFileName = realFileName;
    }

    final void setFileBuffer(ByteArrayOutputStream fileBuffer)
	{
		this.fileBuffer = fileBuffer;
	}
    
    
////////////////////////////////////////////////////////////////////////////////////////////////    

	/**
     *  현재 날자에 해당하는 서브디렉토리를 생성한 후  
     *  생성된 디렉토리 전체 경로를 리턴한다.
     *  
     *  @param baseDir <code>시작 디렉토리 경로</code>
     *  @return <code>파일이 저장될 디렉토리 경로</code>
     */
    private String getDirectory(String fileDir)
    {
        String result = "";
        
        // 지정된 디렉토리내에 서브디렉토리가 없는지 검사
        
        try
        {
            File newDir = new File(fileDir);

            if(!newDir.isDirectory())    
                newDir.mkdir();

            result = newDir.getAbsolutePath() + "/";
        }
        catch(Exception e)
        {
            result = "";
        }

        return result;
    }
}

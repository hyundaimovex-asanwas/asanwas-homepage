/**********************************************************
�ҽ��� : FileStorage.java (Ver 1.0)
�ۼ��� : ��â��
�ۼ��� : 2002.11.23
***********************************************************/
package sales.org.common.request;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;

/**
 *  SmartRequest ��ü���� ������ ÷�����Ͽ� ���õ� ������ ÷�ε� ���Ͽ� �ش��ϴ� <br>
 *  ���� ���� ����(ByteStream), ����� ���ϸ�, ���� ���ϸ�, ���ϻ�����, ���� ���������� ����Ǿ� ������<br> 
 *  �̵� ������ �����ϴ� �޼ҵ�� ������ ������ Ư�� ���丮�� �����ϱ� ���� �޼ҵ尡 �����ȴ�.<p> 
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
     *  Ư�� ���丮�� ������ �����Ѵ�.<p>
     *  
     *  @param		rootDir		<code>������ ������ ���丮</code>
     *  
     *  @return <code>��������</code>
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
     *  ���ϳ����� ������ ������ Clear ��Ų��.<p>
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
     *  ÷������ ������ �����Ѵ�.<p>
     *  
     *  @return <code>÷������ Ȯ����</code>
     */     
    public String getFileKind()
    {
        return fileKind.toLowerCase();
    }

    /**
     *  ÷������ ũ�⸦ �����Ѵ�.<p>
     *  
     *  @return <code>÷������ ũ��(Byte����)</code>
     */     
    public long getFileSize()
    {
        return fileSize;
    }

    /**
     *  ÷������ ���� ��Ī�� �����Ѵ�.<p>
     *  
     *  @return <code>÷������ ���� ��Ī</code>
     */     
    public String getOriginalFileName()
    {
        return originalFileName;
    }

    /**
     *  ÷������ ������� �����Ѵ�.<p>
     *  
     *  @return <code>÷������ �����̸�</code>
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
     *  ���� ���ڿ� �ش��ϴ� ������丮�� ������ ��  
     *  ������ ���丮 ��ü ��θ� �����Ѵ�.
     *  
     *  @param baseDir <code>���� ���丮 ���</code>
     *  @return <code>������ ����� ���丮 ���</code>
     */
    private String getDirectory(String fileDir)
    {
        String result = "";
        
        // ������ ���丮���� ������丮�� ������ �˻�
        
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

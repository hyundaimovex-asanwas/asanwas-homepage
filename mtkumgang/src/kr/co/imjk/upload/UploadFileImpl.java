package kr.co.imjk.upload;

import java.io.File;
import java.util.*;
import java.text.DecimalFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.imjk.util.Util;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//import kr.co.ecmd.util.ParamUtil;

public class UploadFileImpl implements UploadFile{
	private String Filename;
	private String Filesize;
	private String VFilename; 

	public UploadFileImpl(HttpServletRequest request, HttpServletResponse response, MultipartRequest multi, String saveDir) throws Exception{

		
		String fileName = new String();
		String fileSystemName = new String();
		Enumeration enum = multi.getFileNames();
		File systemFile = null;
		File tempFile = null;
		int sepIndex = 0;
		String fileExtName = "";
		String virtualName = "";
		
		while(enum.hasMoreElements()){  
			
			fileName = (String)enum.nextElement();
		
			fileSystemName = Util.getString(multi.getFilesystemName(fileName),"");
			
			//확장자 뽑아내기
			
			if(!fileSystemName.equals("")){
				sepIndex = fileSystemName.indexOf(".");
			
				
				if(sepIndex>0){
					fileExtName =  fileSystemName.substring(sepIndex);
				}
				
				//업데이트 된 파일 찾기
				systemFile = new File(saveDir+fileSystemName);
				
				//업데이트 된 파일이 있으면..
				//파일이름 
				
				String fileSeq = Util.getSeqText();
				
				if(systemFile.exists()){
					//파일 이름을 시퀀스번호로 변경한다.
					virtualName = fileSeq+fileExtName;
					tempFile = new File(saveDir+virtualName);
					//서버에 저장한다.
					systemFile.renameTo(tempFile);
				}
			}
		}
		
		VFilename = virtualName;
		Filename = fileSystemName;
		
		if(tempFile != null){
			
			Filesize = getFileSize(tempFile.length());
			
		}else{
			
			Filesize = "0";
			
		}
		
		
		/*
		Enumeration files = multi.getFileNames();
		
		String fname		= "";
        String filename		= "";
		String ext			= "";
		File fSourceFile	= null;
		File fTargetFile	= null;
		File fVirtualFile	= null;

		//String saveCopy = ContextPath+saveDirCopy+"temp/";
        FileRenameCommand policy = (FileRenameCommand)new FileRenameCommandImpl();

		while (files.hasMoreElements()) {
            fname       = (String)files.nextElement();
            filename    = multi.getFilesystemName(fname);
			fSourceFile = new File(saveDir+filename);
			

			
            if (fSourceFile.length() < 2 || filename.length() < 4){
                if (fSourceFile.exists()) fSourceFile.delete();
            }else{

				
                ext = filename.substring(filename.length()-4);

				if (ext.toUpperCase().equals(".JSP")) filename += ".zip";
              
                fTargetFile = new File(saveDirCopy + filename);
                fTargetFile = policy.rename(fSourceFile,fTargetFile);
                
                fVirtualFile = new File(saveDirCopy + filename);
                fVirtualFile = policy.VirtualFile(fTargetFile,fVirtualFile);
               
                
                Filename = fTargetFile.getName();
                System.out.println("Filename : " + Filename);
                Filesize = getFileSize(fSourceFile.length());
                
                System.out.println("VFile : " + fVirtualFile.getName());

			}
		}
		*/

	}

	public String getFileSize(long filesize) {
		DecimalFormat df = new DecimalFormat(".##"); 
        String fSize="";
        if ((filesize > 1024) && (filesize < 1024 * 1024)) {
            fSize = df.format((float)filesize/1024).toString() + " KB" ;
        } else if (filesize >= 1024 * 1024) {
            fSize = df.format((float)filesize/(1024*1024)).toString() + " MB" ;
        } else {
            fSize = Long.toString(filesize) + " Bytes" ;
        }
        return fSize;
    }

	public String getFilename(){
		return Filename;
	}
    public String getFilesize(){
		return Filesize;
	}
    public String getVFilename(){ 
		return VFilename;
	}
   

}


package sales.org.common.request;

import java.util.ArrayList;
import java.util.HashMap;

final class FileForm
{
    private HashMap fileStorage = null;

    // 생성자 
    
    public FileForm()
    {
        this.fileStorage = new HashMap();
    }
    
    // 파라메터 아이디에 해당하는 FileStorage 리스트를 리턴
    
    public ArrayList getFileStorageList(String paramId)
    {
        return (ArrayList)fileStorage.get(paramId);
    }

    // 파라메터 아이디에 해당하는 FileStorage 객체 리턴
    
    public FileStorage getFileStorage(String paramId)
    {
        FileStorage result = null;
        
        ArrayList fileInfo = this.getFileStorageList(paramId);
        
        if(fileInfo != null && fileInfo.size() > 0)
            result = (FileStorage)fileInfo.get(0);
        
        return result;
    }

    // paramId 로 파일 스토리지를 세팅
    
    public void setFileStorage(String paramId, FileStorage fileInfo)
    {
        if(this.fileStorage.containsKey(paramId))
        {
            ArrayList tempStorage = (ArrayList)this.fileStorage.get(paramId);

            tempStorage.add(fileInfo);
            
            this.fileStorage.put(paramId, tempStorage);
        }
        else
        {
            ArrayList tempStorage = new ArrayList();

            tempStorage.add(fileInfo);
            
            this.fileStorage.put(paramId, tempStorage);
        }
    }
}

package sales.org.common.request;

import java.util.ArrayList;
import java.util.HashMap;

final class FileForm
{
    private HashMap fileStorage = null;

    // ������ 
    
    public FileForm()
    {
        this.fileStorage = new HashMap();
    }
    
    // �Ķ���� ���̵� �ش��ϴ� FileStorage ����Ʈ�� ����
    
    public ArrayList getFileStorageList(String paramId)
    {
        return (ArrayList)fileStorage.get(paramId);
    }

    // �Ķ���� ���̵� �ش��ϴ� FileStorage ��ü ����
    
    public FileStorage getFileStorage(String paramId)
    {
        FileStorage result = null;
        
        ArrayList fileInfo = this.getFileStorageList(paramId);
        
        if(fileInfo != null && fileInfo.size() > 0)
            result = (FileStorage)fileInfo.get(0);
        
        return result;
    }

    // paramId �� ���� ���丮���� ����
    
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

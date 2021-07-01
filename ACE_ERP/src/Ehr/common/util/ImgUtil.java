package Ehr.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;

public class ImgUtil {
    
    
    private String FILEURL; 
    
    private String eno_no;
    
    public ImgUtil(String eno_no) {
        this.eno_no = eno_no;
        Configuration conf;
        try {
            conf = Configuration.getInstance();
            this.FILEURL = conf.get("framework.file.upload.pds");
        } catch (CException e) {
            e.printStackTrace();
        }
    }

    public String get() {
        InputStream is = null;
        
        byte[] buf = null;
        String rtnStr = null;
        
        try {
            File f = new File(FILEURL+"/"+eno_no+".BMP");
            is = new FileInputStream(f);
            
            buf = new byte[Integer.parseInt(String.valueOf(f.length()))];
            
            rtnStr = new String(buf, "8859_1");
            
            is.close();
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        } catch(Exception e) {
            e.printStackTrace();
        } 
        
        return rtnStr;
    }
}

/*
 * Created on 2004. 11. 17.
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package kr.co.imjk.util;

import java.io.File;

import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * @author sim11
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class UploadFileRenamePolicy implements FileRenamePolicy{

    public File rename(File f) {
        
      f = new File(f.getParent(),  f.getName());
    
      // 서버쪽에 업로드 되어서는 안되는 확장자를 txt 확장자로 바꾸어줌
      // 예 = asp, jsp, php, cgi, js
      String filename = f.getName();
      int last = filename.lastIndexOf(".");
      String extend = filename.substring(last+1, filename.length()).toLowerCase();
      if(extend.equals("jsp") || extend.equals("asp") || extend.equals("php") || extend.equals("cgi") || extend.equals("js")){
          filename = filename + ".txt";
      }
      f = new File(f.getParent(),  filename);
    
      if (!f.exists()) {
        return f;
      }
      String name = f.getName();
      String body = null;
      String ext = null;
 
      int dot = name.lastIndexOf(".");
      if (dot != -1) {
        body = name.substring(0, dot);
        ext = name.substring(dot);  // includes "."
      }
      else {
        body = name;
        ext = "";
      }

      int count = 0;
      while (f.exists()) {
        count++;
        String newName = body + "["+ count +"]" + ext;
        f = new File(f.getParent(), newName);
      }
      return f;
    } 
}

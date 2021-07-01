/**
* Filename     : DirectoryList.java
* Function      : TODO
* Description : TODO
* History        :  2005. 3. 3. imjkorea 최태식
* History New : 
* Author         :  최태식
*/

package kr.co.imjk.util;

import java.io.IOException;
import java.io.File;
import java.util.Vector;


public class DirectoryList {

    	DirectoryList(){}
    
    	File directory;
        int indent = 2; //파일은 계층 구조에서 한 단계씩 내려갈 때 마다 2칸을 들여쓴다.ㅣ
        static Vector seen = new Vector();
        
        public static String  Search(String root_dir) {
            
            String rtnValue = "";
             
            try {
                DirectoryList ld = new DirectoryList(root_dir);
                rtnValue = ld.list();
            } catch (Exception ex) {}
            
            return rtnValue;
        }

        public DirectoryList(String s) throws IOException {
            this(new File(s), 2);
        }

        public DirectoryList(File f) throws IOException {
            this(f, 2);
        }

        public DirectoryList(File directory, int indent) throws IOException {
            if (directory.isDirectory()) {
                this.directory = new File(directory.getCanonicalPath());
            } else {
                throw new IOException(directory.toString() + "is not a directory");
            }
            this.indent = indent;
            String spaces = ""; // 디렉 토리 공간

            for (int i = 0; i < indent - 1; i++) {
                spaces += "";
            }
            
            ////System.out.println(spaces + directory + File.separatorChar);  // 공간 + 디렉토리 명 + 파일구분 char
        }

        public String list() throws IOException {
           
            String rtnValue = "";
            String fStart = "<iframe width=500 height=200 src=";
            String fEnd = "></iframe><br>";
                
            
            if (!seen.contains(this.directory)) {  //디렉토리명이 vector의 요소 인지를 파악
                
                seen.addElement(this.directory);
                
                String[] files = directory.list(); // 디레토릭 안에 파일를 files에 담는다.
                String spaces = "";
                
                for (int i = 0; i < indent; i++) {
                    spaces += "";
                }
                
                for (int i = 0; i < files.length; i++) {
                    
                    File f = new File(directory, files[i]);
                    
                    if (f.isFile()) {
                        
                        if(f.getName().substring(f.getName().lastIndexOf("."),f.getName().length()).equals(".jsp")){
                            rtnValue = rtnValue + fStart + spaces + directory + File.separatorChar + f.getName() + fEnd + "\n";
                        }
                    
                    } else {
                      
                        DirectoryList ld = new DirectoryList(f,indent + 2);
                        
                        rtnValue = rtnValue + ld.list();
 
                    }
                }

            }
            
            return rtnValue;
        }


    }

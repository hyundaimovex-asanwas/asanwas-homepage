/*
 * Created on 2005. 1. 20.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.util;
import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.oreilly.servlet.multipart.MultipartParser;
import com.oreilly.servlet.multipart.ParamPart;
import com.oreilly.servlet.multipart.Part;

/**
 * @author and32 (and32@nate.com)
 * @version 1.0, 2003. 3. 17.
 */
public class MPartRequest {

    /**
     * 
     * @uml.property name="parser"
     * @uml.associationEnd 
     * @uml.property name="parser" multiplicity="(1 1)"
     */
    private MultipartParser parser = null;

    /**
     * 
     * @uml.property name="map"
     * @uml.associationEnd 
     * @uml.property name="map" multiplicity="(0 1)" qualifier="name:java.lang.String
     * part:com.oreilly.servlet.multipart.Part"
     */
    private HashMap map = null;

    private boolean isEnd = false;

    /**
     * 
     * @uml.property name="vPart"
     * @uml.associationEnd 
     * @uml.property name="vPart" multiplicity="(0 -1)" elementType="com.oreilly.servlet.multipart.Part"
     */
    private Vector vPart = new Vector();

    private Hashtable hashtable = null;
 
    public MPartRequest(HttpServletRequest req, int maxSize) throws IOException {
        map = new HashMap();
        
        parser = new MultipartParser(req, maxSize, true, true, "euc-kr");
        Part part = null;
        while ((part = parser.readNextPart()) != null) {
            String temp = part.getName();
            vPart.add(part);
        }
    }
 
    public String getParameter(String name) throws Exception, IOException {
        Part part = (Part) map.get(name);
        if (part == null && isEnd == false) {
         part = readNextParts(name);
        }
        if (part == null) {
            return null; 
        } else if (part.isParam()) {
            return ((ParamPart) part).getStringValue();
        } else {
            throw new Exception("잘못 사용된 파라미터입니다.");
        }
    }
 
    public File getFile(String name, String saveDirPath) throws Exception, IOException {
        Part part = (Part) map.get(name);
        if (part == null && isEnd == false) {
            part = readNextParts(name);
        }
        if (part == null) {
            return null; 
        } else if (part.isFile()) {
            FilePart filePart = (FilePart) part;
            String fileName = filePart.getFileName();
            if (fileName != null) {
                File saveDir = new File(saveDirPath);
                FileRenamePolicy policy = new DefaultFileRenamePolicy();
    
                filePart.setRenamePolicy(policy);
                filePart.writeTo(saveDir);
                return new File(saveDirPath + "/" + filePart.getFileName()); 
            }
        } else {
            throw new Exception("잘못 사용된 파라미터입니다.");
        }
     return null;
    }
 
    private Part readNextParts(String name) throws IOException {
        Part part = null;
 
        while ((part = parser.readNextPart()) != null) {
            String temp = part.getName();
            map.put(temp, part);
            if (temp.equals(name)) {
                return part;
            }
        }
        isEnd = true;
        return null;
    }
    
    public Part readNextPart() throws IOException {
        
        return parser.readNextPart();
    }
    
    public HashMap getPartHashMap()throws IOException{
            Part part = null;
        if (isEnd == false) {
            while ((part = parser.readNextPart()) != null) {
                String temp = part.getName();
                map.put(temp, part);
            }
        }
        
        return map;
    }
    
    public Vector getParts(){
      return vPart;
    }
 

    public static boolean isMultipartRequest(HttpServletRequest request) {
        String contentType = null;
        return (contentType = request.getContentType()) != null && contentType.trim().toLowerCase().startsWith("multipart");
    }
}


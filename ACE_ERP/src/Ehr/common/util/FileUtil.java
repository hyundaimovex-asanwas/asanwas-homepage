/***********************************************************************
* PROGRAM NAME     :  FileUtil.java
* DESCRIPTION      :  File에 관련된 유틸들의 모음
* DESIGNER NAME    :
* DEVELOPER NAME   :  조정호
* CREATE DATE      :  2006. 08. 04
*
* Date	            Ver         Name           Description
* ------------      ------      ------------   ------------------------
* 2006. 08. 04        V1.0        조정호      	   Initial Version
***********************************************************************/

package Ehr.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.io.GauceInputStream;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.vo.DynamicValueObject;

public class FileUtil {

    /**
     * 가우스 Stream을 읽어 들여 File Stream을 찾아 온다.
     * (기존 프레임웍으로 InputStream 만 별도로 가져오기 어려움 별도 구현)
     * @param p_tr
     * @param dsName
     * @param dsFileUrl
     * @return
     */
    public static InputStream[] getFileStream(TrBox p_tr, String dsName, String dsFileUrl) {
        GauceInputStream gis = p_tr.getGauceInputStream();
        List streamList = new ArrayList();
        InputStream is = null;

        //File 이 저장된 ds 를 가져옴
        GauceDataSet ds = gis.read(dsName);

        try {
            GauceDataRow rows[] = ds.getDataRows();
            int data_url = ds.indexOfColumn(dsFileUrl);
            System.out.println("권혁수 rows [" + rows.length + "]");
            for(int j = 0; j < rows.length; j++) {
            	System.out.println("타입 [" + rows[j].getJobType() + "]");
                //type 이 Insert 인것들만 불러들임
                if(rows[j].getJobType() == 2) {
                    //txt Stream을 읽어들임
                    is = rows[j].getInputStream(data_url);
                    System.out.println("is.available() [" + is.available() + "]");
                    if(is.available() != 0) {
                        streamList.add(is);
                    } else {
                        is.close();
                    }
                }
            }
        } catch(Exception e) {
            Log.err.println(e.getMessage());
        }

        return (InputStream[])streamList.toArray(new InputStream[0]);
    }

    /**
     * 출력할 OutputStream 을 넘겨받아 Value Object 리스트의 값들을 한줄씩 기록하고 반환 시킨다.
     *
     * @param out
     * @param voList
     */
    public static void writeOutputStream(OutputStream out
            ,String keyFieldName
            ,String valueFieldName
            ,DynamicValueObject voList
            ,String nonSelectedKeys) {

        //**Debug**
        Log.debug.println("nonSelectedKeys:"+nonSelectedKeys);
        Log.debug.println("keyFieldName:"+keyFieldName);
        Log.debug.println("valueFieldName:"+valueFieldName);
        Log.debug.println("voList size"+voList.size());

        Writer writer = null;

        writer =
            new BufferedWriter(
                    new OutputStreamWriter(out)); //stream 에 기록할 writer Buffer가 다차면 flush 되어버림

        DynamicValueObject vo = null;           //value Object

        String key = null;
        String value = null;

        //문자열을 ',' 으로 분리
        String[] strArr = null;
        if(nonSelectedKeys != null) {
            strArr = nonSelectedKeys.split(",");
        } else {
            strArr = new String[]{""};
        }

        List keyList =  Arrays.asList(strArr);

        //VO List 만큼 반복
        for(int i=0; i< voList.size(); i++) {
            vo  = (DynamicValueObject) voList.get(i);

            key = vo.getString(keyFieldName);
            value = vo.getString(valueFieldName);

            //만약 선택되어 있지 않으면 무시
            if(keyList.contains(key)) {
                continue;
            }

            try {
                //Stream에 기록
                writer.write(value+"\r\n");
            } catch (IOException e) {
                Log.err.println(e.getMessage());
            }
        }

        try {
            //jsp flush가 중간시점에 되어 버려 작업이 완료되면 flush 시킴
            writer.flush();
        } catch (IOException e) {
            Log.err.println(e.getMessage());
        }
    }

    /**
     * 파일로 부터 문자열을 읽어서 스트링으로 반환
     * @param dirPath
     * @param fileName
     * @return
     */
    public static String read(String dirPath, String fileName) throws FileNotFoundException, IOException{
        StringBuffer sb                 = new StringBuffer();

        BufferedReader in = null;
        String      s                   = null;
        try {
            in                          = new BufferedReader(new FileReader(dirPath+fileName));

            while((s = in.readLine()) != null) {
                sb.append(s);
                sb.append("\n");
            }
        } catch (FileNotFoundException e) {
            Log.err.println(e.getMessage());
        } catch (IOException e) {
            Log.err.println(e.getMessage());
        } finally{
            try {in.close();} catch (IOException e) {Log.err.println(e.getMessage());}
        }

        return sb.toString();
    }

    /**
    * 해당 리렉토리의 dirList Url을 가져옴
    * @param dirPath
    * @return HashMap
    */
   public static Map getDirList(String dirPath) {
       Map          fileList            = new HashMap();
       Map          childList           = null;
       File         dir                 = null;
       File         file                = null;
       String[]     child               = null;
       String       fileName            = null;

       Iterator     it                  = null;
       String       key                 = null;
       String       value               = null;

       URL          realPath            = new FileUtil().getClass().getResource(dirPath);
       if(dirPath != null) {
           dir                          = new File(realPath.getPath());

           if(dir.isDirectory()) {
               child                    = dir.list();

               for(int i=0; i<child.length; i++) {
                   fileName             = child[i];
                   file                 = new File(dir, fileName);

                   //자식 Query 파일 리스트를 현재 Query 파일 리스트로 옮김
                   if(file.isDirectory()) {
                       childList        = getDirList(dirPath+File.separator+fileName);

                       it = childList.keySet().iterator();
                       while(it.hasNext()) {
                           key          = (String)it.next();
                           value        = (String)childList.get(key);

                           fileList.put(key, value);
                       }
                   }
                   //파일일 경우 파일 패스 경로를 담음
                   else if(file.isFile()){
                       int      index   = fileName.lastIndexOf(".");
                       String   ext     = null;
                       if (index != -1) {
                           ext          = fileName.substring(index + 1);
                           if(ext != null
                                   &&
                                   (  ext.equals("sql")
                                   || ext.equals("txt")
                                   || ext.equals("properties"))) {
                               fileList.put(dirPath+File.separator+fileName, realPath+File.separator+fileName);
                           }
                       }
                   }
               }
           }
       }

       return fileList;
   }

   /**
    * InputStreamReader 를 읽어서 문서 파일을 생성
    * @param dirPath
    * @param fileName
    * @param is
    * @return
    */
   public static boolean createTextFile(String dirPath
           , String fileName
           , Reader is) throws FileNotFoundException, IOException{
       return createTextFile(dirPath, fileName, is, "");
   }

   /**
    * InputStreamReader 를 읽어서 문서 파일을 생성
    * @param dirPath
    * @param fileName
    * @param is
    * @param carriageReturnStr 개행문자를 변환시킬 문자
    * @return
    */
   public static boolean createTextFile(String dirPath
           , String fileName
           , Reader is
           , String carriageReturnStr) throws FileNotFoundException, IOException{
       return createTextFile(dirPath, fileName, is, carriageReturnStr, false);
   }

   /**
    * InputStreamReader 를 읽어서 기존 문서 파일에 덧붙임
    * @param dirPath
    * @param fileName
    * @param is
    * @return
    */
   public static boolean appendTextFile(String dirPath
           , String fileName
           , Reader is) throws FileNotFoundException, IOException{
       return appendTextFile(dirPath, fileName, is, "");
   }

   /**
    * InputStreamReader 를 읽어서 기존 문서 파일에 덧붙임
    * @param dirPath
    * @param fileName
    * @param is
    * @param carriageReturnStr 개행문자를 변환시킬 문자
    * @return
    */
   public static boolean appendTextFile(String dirPath
           , String fileName
           , Reader is
           , String carriageReturnStr) throws FileNotFoundException, IOException{
       return createTextFile(dirPath, fileName, is, carriageReturnStr, true);
   }

   /**
    * InputStreamReader 를 읽어서 문서 파일을 생성
    * @param dirPath
    * @param fileName
    * @param is
    * @param carriageReturnStr 개행문자를 변환시킬 문자
    * @param isAppend 덧붙일 것인지 여부를 결정
    * @return
    */
   public static boolean createTextFile(String dirPath
           , String fileName
           , Reader is
           , String carriageReturnStr
           , boolean isAppend) throws FileNotFoundException, IOException{
       boolean result           = false;
       String line              = null;

       BufferedReader reader    = new BufferedReader(is);
       BufferedWriter writer    = null;
       try {
           //폴더 생성
           createDir(dirPath);

           writer = new BufferedWriter(new FileWriter(dirPath+fileName, isAppend));
           while((line = reader.readLine()) != null)
               writer.write(line+carriageReturnStr);

           reader.close();
           writer.close();
       } catch (FileNotFoundException e) {
           Log.err.println(e.getMessage());
       } catch (IOException e) {
           e.printStackTrace();
           Log.err.println(e.getMessage());
       }

       Log.debug.println("createTextFile result:"+result);
       return result;
   }

   /**
    * Stream을 읽어서 파일을 생성함
    * @param dirPath 경로의 끝부분은 꼭 '/' 을(를) 붙여야 함
    * @param fileName
    * @param inputStream
    * @return
    */
   public static boolean createFile(String dirPath
           , String fileName
           , InputStream is) throws FileNotFoundException, IOException{
       boolean result           = false;
       byte readByte[]          = new byte[4096];
       int i                    = 0;

       BufferedInputStream bis  = new BufferedInputStream(is);
       BufferedOutputStream bos = null;

       bos = new BufferedOutputStream(
               new DataOutputStream(
                       new FileOutputStream(dirPath+File.separator+fileName)));

       while ((i = bis.read(readByte, 0, 4096)) != -1) {
           bos.write(readByte, 0, i);
       }

       bis.close();
       bos.close();

       return result;
   }

   /**
    * 파일 있는지 여부 검증
    * @param dirPath
    * @param fileName
    * @return
    */
   public static boolean isCreatedFile(String dirPath, String fileName) {
       boolean result = false;
       File file = new File(dirPath, fileName);

       if(file.isFile() && file.length() > 0) {
           result = true;
       }

       Log.debug.println("isCreatedFile result:"+result);
       return result;
   }

   /**
    * dir을 만든다.
    * @param dirPath
    * @return
    */
   public static boolean createDir(String dirPath) {
       boolean result = true;

       File file = new File(dirPath);
       if(!(file.canRead() || file.mkdir())) {
           result = false;
       }

       return result;
   }

   /**
    * 기존 파일을 읽어 스트림으로 반환
    * @param outputstream
    * @param realFile
    */
   public static void writeOutputStream(OutputStream outputstream, File realFile) {
       byte readByte[] = new byte[4096];
       try {
           BufferedInputStream bufferedinputstream =
               new BufferedInputStream(new FileInputStream(realFile));
           int i;
           while ((i = bufferedinputstream.read(readByte, 0, 4096)) != -1)
               outputstream.write(readByte, 0, i);
           bufferedinputstream.close();
       } catch (Exception _ex) {
       }
   }
}

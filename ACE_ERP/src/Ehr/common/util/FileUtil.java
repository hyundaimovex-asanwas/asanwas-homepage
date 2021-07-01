/***********************************************************************
* PROGRAM NAME     :  FileUtil.java
* DESCRIPTION      :  File�� ���õ� ��ƿ���� ����
* DESIGNER NAME    :
* DEVELOPER NAME   :  ����ȣ
* CREATE DATE      :  2006. 08. 04
*
* Date	            Ver         Name           Description
* ------------      ------      ------------   ------------------------
* 2006. 08. 04        V1.0        ����ȣ      	   Initial Version
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
     * ���콺 Stream�� �о� �鿩 File Stream�� ã�� �´�.
     * (���� �����ӿ����� InputStream �� ������ �������� ����� ���� ����)
     * @param p_tr
     * @param dsName
     * @param dsFileUrl
     * @return
     */
    public static InputStream[] getFileStream(TrBox p_tr, String dsName, String dsFileUrl) {
        GauceInputStream gis = p_tr.getGauceInputStream();
        List streamList = new ArrayList();
        InputStream is = null;

        //File �� ����� ds �� ������
        GauceDataSet ds = gis.read(dsName);

        try {
            GauceDataRow rows[] = ds.getDataRows();
            int data_url = ds.indexOfColumn(dsFileUrl);
            System.out.println("������ rows [" + rows.length + "]");
            for(int j = 0; j < rows.length; j++) {
            	System.out.println("Ÿ�� [" + rows[j].getJobType() + "]");
                //type �� Insert �ΰ͵鸸 �ҷ�����
                if(rows[j].getJobType() == 2) {
                    //txt Stream�� �о����
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
     * ����� OutputStream �� �Ѱܹ޾� Value Object ����Ʈ�� ������ ���پ� ����ϰ� ��ȯ ��Ų��.
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
                    new OutputStreamWriter(out)); //stream �� ����� writer Buffer�� ������ flush �Ǿ����

        DynamicValueObject vo = null;           //value Object

        String key = null;
        String value = null;

        //���ڿ��� ',' ���� �и�
        String[] strArr = null;
        if(nonSelectedKeys != null) {
            strArr = nonSelectedKeys.split(",");
        } else {
            strArr = new String[]{""};
        }

        List keyList =  Arrays.asList(strArr);

        //VO List ��ŭ �ݺ�
        for(int i=0; i< voList.size(); i++) {
            vo  = (DynamicValueObject) voList.get(i);

            key = vo.getString(keyFieldName);
            value = vo.getString(valueFieldName);

            //���� ���õǾ� ���� ������ ����
            if(keyList.contains(key)) {
                continue;
            }

            try {
                //Stream�� ���
                writer.write(value+"\r\n");
            } catch (IOException e) {
                Log.err.println(e.getMessage());
            }
        }

        try {
            //jsp flush�� �߰������� �Ǿ� ���� �۾��� �Ϸ�Ǹ� flush ��Ŵ
            writer.flush();
        } catch (IOException e) {
            Log.err.println(e.getMessage());
        }
    }

    /**
     * ���Ϸ� ���� ���ڿ��� �о ��Ʈ������ ��ȯ
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
    * �ش� �����丮�� dirList Url�� ������
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

                   //�ڽ� Query ���� ����Ʈ�� ���� Query ���� ����Ʈ�� �ű�
                   if(file.isDirectory()) {
                       childList        = getDirList(dirPath+File.separator+fileName);

                       it = childList.keySet().iterator();
                       while(it.hasNext()) {
                           key          = (String)it.next();
                           value        = (String)childList.get(key);

                           fileList.put(key, value);
                       }
                   }
                   //������ ��� ���� �н� ��θ� ����
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
    * InputStreamReader �� �о ���� ������ ����
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
    * InputStreamReader �� �о ���� ������ ����
    * @param dirPath
    * @param fileName
    * @param is
    * @param carriageReturnStr ���๮�ڸ� ��ȯ��ų ����
    * @return
    */
   public static boolean createTextFile(String dirPath
           , String fileName
           , Reader is
           , String carriageReturnStr) throws FileNotFoundException, IOException{
       return createTextFile(dirPath, fileName, is, carriageReturnStr, false);
   }

   /**
    * InputStreamReader �� �о ���� ���� ���Ͽ� ������
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
    * InputStreamReader �� �о ���� ���� ���Ͽ� ������
    * @param dirPath
    * @param fileName
    * @param is
    * @param carriageReturnStr ���๮�ڸ� ��ȯ��ų ����
    * @return
    */
   public static boolean appendTextFile(String dirPath
           , String fileName
           , Reader is
           , String carriageReturnStr) throws FileNotFoundException, IOException{
       return createTextFile(dirPath, fileName, is, carriageReturnStr, true);
   }

   /**
    * InputStreamReader �� �о ���� ������ ����
    * @param dirPath
    * @param fileName
    * @param is
    * @param carriageReturnStr ���๮�ڸ� ��ȯ��ų ����
    * @param isAppend ������ ������ ���θ� ����
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
           //���� ����
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
    * Stream�� �о ������ ������
    * @param dirPath ����� ���κ��� �� '/' ��(��) �ٿ��� ��
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
    * ���� �ִ��� ���� ����
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
    * dir�� �����.
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
    * ���� ������ �о� ��Ʈ������ ��ȯ
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

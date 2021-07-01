package Ehr.common.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.*;

//import Ehr.base64Coder.Base64Coder;

public class EncryptUtil {
    
    /** SHA1 / MD5 **/
    public static String SHA1Encrypt(String EncMthd, String strData)
    {
        MessageDigest md;
        String ENCData = "";
        try
       {
          md = MessageDigest.getInstance(EncMthd); // "MD5" or "SHA1"
          byte[] bytData = strData.getBytes();
          md.update(bytData);
          byte[] digest = md.digest();
          for(int i =0;i<digest.length;i++)
          {
              ENCData = ENCData + Integer.toHexString(digest[i] & 0xFF).toUpperCase();
          }
        }catch(NoSuchAlgorithmException e){
          ENCData = null;
          e.printStackTrace();
          System.out.print("암호화 알고리즘이 없습니다.");
       }
       return ENCData;
    }
    
    /** SHA512 **/
    public static String SHA512Encrypt(String strData) {
        MessageDigest md;
        String ENCData = "";
        String tempPassword = "";
        
        try {
            md = MessageDigest.getInstance("SHA-512");
            
            md.update(strData.getBytes());
            byte[] mb = md.digest();
            for(int i = 0; i< mb.length; i++) {
                byte temp= mb[i];
                String s = Integer.toHexString(new Byte(temp));
                while(s.length() < 2) {
                    s = "0"+s;
                }
                s = s.substring(s.length() - 2);
                tempPassword += s;
            }
            ENCData = tempPassword;
        }catch (NoSuchAlgorithmException e) {
            ENCData = null;
            e.printStackTrace();
            System.out.print("암호화 알고리즘이 없습니다.");
        }
        return ENCData;
    }
    
    /** SHA256 **/
    public static String SHA256Encrypt (String strData) {
        MessageDigest md;
        String ENCData = "";
        
        try {
            md = MessageDigest.getInstance("SHA-256");
            md.update(strData.getBytes(), 0, strData.length());
            ENCData = new BigInteger(1, md.digest()).toString(16);
        }catch(NoSuchAlgorithmException e) {
            ENCData = null;
            e.printStackTrace();
            System.out.print("암호화 알고리즘이 없습니다.");
        }
        return ENCData;
    }
    
    
    /** sha256_2 **/
    public static String SHA256Encrypt_2(String strData) {
        MessageDigest md;
        String ENCData = "";
        try {
            md = MessageDigest.getInstance("SHA-256");
            md.update(strData.getBytes());
            byte byteData[] = md.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0; i<byteData.length; i++ ) {
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            ENCData = sb.toString();
        }catch(NoSuchAlgorithmException e) {
            ENCData = null;
            e.printStackTrace();
            System.out.print("암호화 알고리즘이 없습니다.");
        }
        return ENCData;
    }
    
    /** sha256_2 + salt 추가 **/
    public static String SHA256Encrypt_3(String strData, byte[] salt) {
        MessageDigest md;
        String ENCData = "";
        try {
            byte[] a = strData.getBytes();
            byte[] bytes = new byte[a.length + salt.length];
            
            System.arraycopy(a, 0, bytes, 0, a.length);
            System.arraycopy(salt, 0, bytes, a.length, salt.length);
            
            md = MessageDigest.getInstance("SHA-256");
            md.update(bytes);
            byte byteData[] = md.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0; i<byteData.length; i++ ) {
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            ENCData = sb.toString();
        }catch(NoSuchAlgorithmException e) {
            ENCData = null;
            e.printStackTrace();
            System.out.print("암호화 알고리즘이 없습니다.");
        }
        return ENCData;
    }
    
    
    /** salt **/
    public static byte[] Salt() {
        java.util.Random random = new java.util.Random();
        byte[] saltBytes = new byte[8];
        random.nextBytes(saltBytes);
        StringBuffer salt = new StringBuffer();
        for(int i=0; i< saltBytes.length; i++) {
            salt.append(String.format("%02x",saltBytes[i]));
        }
        return saltBytes;
    }
    
    /** byteToBase64**/
    /*
    public static String byteToBase64(byte[] data) throws UnsupportedEncodingException {
       // String encodelines = Base64Coder.encodeLines(data);
        //return encodelines;
    	return "0";
    }
    */
    /** base64ToByte **/
    /*
    public static byte[] base64ToByte(String data) throws IOException  {
        //byte[] decodelines = Base64Coder.decodeLines(data);
        //return decodelines;
    	return "0";
    }
    */
}
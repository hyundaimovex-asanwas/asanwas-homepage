package com.hmm.ejb.util;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Security {

    /**
    * Turns array of bytes into string
    *
    * @param buf	Array of bytes to convert to hex string
    * @return	Generated hex string
    */
    public static String asHex (byte buf[]) {
       StringBuffer strbuf = new StringBuffer(buf.length * 2);
       int i;

       for (i = 0; i < buf.length; i++) {
        if (((int) buf[i] & 0xff) < 0x10)
         strbuf.append("0");

        strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
       }

       return strbuf.toString();
    }

    public static void main(String[] args) throws Exception
    {

        String message="hahaha";

        String skey = "0123456789012345";

        byte[] encrypted = encrypt(message,skey);
        System.out.println(decrypt(encrypted,skey));

    }


    /**
     * Encrypt Message
     *
     * @param msg               message for encryption
     * @param skey              key for encryption
     * @return byte[]
     * @throws Exception
     */

    // AES 알고리즘을 사용하여 Encrypt 함
    // todo 현재는 그냥 키만 가지고 encrpt/decript하도록 되어 있으나  키 값에 시간 정보를 붙여야 됨
    public static byte[] encrypt( String msg , String skey ) throws Exception
    {
        byte[] raw = skey.getBytes();

        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

        byte[] encrypted = cipher.doFinal(msg.getBytes());
//        System.out.println("encrypted string: " + asHex(encrypted));

        return encrypted;
    }

    /**
     * Decrypt message
     *
     * @param encrypted      encrytped message for decription
     * @param skey           key for decryption and same key as key when encrypted
     * @return
     * @throws Exception
     */

    // AES 알고리즘을 사용하여 Decrypt 함
    // todo 현재는 그냥 키만 가지고 encrpt/decript하도록 되어 있으나  키 값에 시간 정보를 붙여야 됨
    public static String decrypt( byte[] encrypted, String skey ) throws Exception
    {
        byte[] raw = skey.getBytes();

        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] original = cipher.doFinal( encrypted );
        String originalString = new String(original);
//        System.out.println("Original string: " + originalString + " " + asHex(original));

        return originalString;
    }
}
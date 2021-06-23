package kr.co.imjk.util;

import java.io.*;
import java.net.*;

public class HTTPUtil {

  public HTTPUtil(String urlStr) {
    try {
      URL url = new URL ( urlStr );
      byte[] b = toByteArray(url.openStream());

      //System.out.println( new String(b) );
    } catch ( Exception ex ) {

    }
  }
  public static String getHtml(String urlStr) throws Exception {
      URL url = new URL ( urlStr );
      byte[] b = toByteArray(url.openStream());

      return new String(b);
  }

  public static byte[] toByteArray ( InputStream in ) throws IOException {
    try {
      byte[] byteArray;

      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      BufferedInputStream bis = new BufferedInputStream( in );
      int ch;
      while ( ( ch = bis.read() ) != -1 ) {
        baos.write( ch );
      }
      byteArray = baos.toByteArray();
      bis.close();
      baos.close();

            return byteArray;
    }
    catch ( IOException e ) {
      throw new IOException ( e.toString() );
    }
  }

  public static void main(String[] args) {
    if ( args.length < 1 ) {
      //System.out.println( "HTTPUtil <url>" );
      //System.exit(0);
    }

    try {
      //System.out.println( HTTPUtil.getHtml(args[0]) );
    } catch ( Exception ex ) {

    }
  }
}
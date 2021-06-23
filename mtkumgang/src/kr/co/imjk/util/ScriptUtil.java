/*
 * Author(s) Park Sang Bae 
 * Date: 2003.12.22
 */
package kr.co.imjk.util;

public class ScriptUtil {

    public static String returnURL(String rurl, String alertMessage) {
        String rHtml = new String(" ");
        if ( alertMessage == null || alertMessage.equals("") ) return "";
        rHtml  = "<script language=javascript>\n " +
                 "<!-- \n" +
                 "alert('" + alertMessage.trim() + "'); \n" +
                 "document.location.href='" + rurl + "';  \n" +
                 "// --> \n" +
                 "</script> \n";
        return rHtml;
    }

	public static String goURL(String rurl) {
        String rHtml = new String(" ");        
        rHtml  = "<script language=javascript>\n " +
                 "<!-- \n" +
                // "document.f1.submit();  \n" +
				"document.location.href='" + rurl + "';  \n" +
                 "// --> \n" +
                 "</script> \n";
        return rHtml;
    }


	public static String goFrameURL(String rurl,String alertMessage) {
        String rHtml = new String(" ");        
        rHtml  = "<script language=javascript>\n " +
                 "<!-- \n" +
				 " document.location.href='" + rurl + "';  \n" +
				 " alert('"+alertMessage.trim()+"'); \n" +
				 " parent.location.reload(); \n" +
                 "// --> \n" +
                 "</script> \n";
        return rHtml;
    }

	public static String goFrameURL1(String rurl) {
        String rHtml = new String(" ");        
        rHtml  = "<script language=javascript>\n " +
                 "<!-- \n" +
				 " document.location.href='" + rurl + "';  \n" +
				 " parent.location.reload(); \n" +
                 "// --> \n" +
                 "</script> \n";
        return rHtml;
    }
    
    public static String returnHistory(String alertMessage) {
        String rHtml = "";
        rHtml = "<script language=javascript> \n " +
                "<!-- \n" +
                " alert('"+alertMessage.trim()+"'); \n" +
                " history.back(); \n" +
                "// --> \n" +
                "</script> \n ";
        return rHtml;
    }
    
    public static String returnClose(String alertMessage) {
        String rHtml = "";
        rHtml = "<script language=javascript> \n " +
                "<!-- \n" +
                " alert('"+alertMessage.trim()+"'); \n" +
                " opener.location.reload(); \n" +
                " window.close(); \n" +
                "// --> \n" +
                "</script> \n ";
        return rHtml;
    }
    
    public static String returnClose2(String alertMessage) {
        String rHtml = "";
        rHtml = "<script language=javascript> \n " +
                "<!-- \n" +
                " alert('"+alertMessage.trim()+"'); \n" +
                " window.close(); \n" +
                "// --> \n" +
                "</script> \n ";
        return rHtml;
    }

	public static String returnClose3() {
        String rHtml = "";
        rHtml = "<script language=javascript> \n " +
                "<!-- \n" +
                " window.close(); \n" +
                "// --> \n" +
                "</script> \n ";
        return rHtml;
    }

	public static String returnClose3(String rurl,String alertMessage) {
        String rHtml = "";
        rHtml = "<script language=javascript> \n " +
                "<!-- \n" +
                " alert('"+alertMessage.trim()+"'); \n" +
				"document.location.href='" + rurl + "';  \n" +
                " opener.location.reload(); \n" +                
                "// --> \n" +
                "</script> \n ";
        return rHtml;
    }

	public static String returnClose4(String rurl) {
        String rHtml = "";
        rHtml = "<script language=javascript> \n " +
                "<!-- \n" +
				"document.location.href='" + rurl + "';  \n" +
                " parent.location.reload(); \n" +                
                "// --> \n" +
                "</script> \n ";
        return rHtml;
    }
}
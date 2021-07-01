/*
 * Created on 2006. 4. 19.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.util;

import kr.co.imjk.util.Config;
import kr.co.imjk.util.Util;

/**
 * @author ÀÓÇü¼ö
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Lang {

 
private static Lang instance=null;

/**
 * 
 * @uml.property name="instance"
 */
public static synchronized Lang getInstance() {
    if (instance == null) {
        instance = new Lang();
    }
    return instance;
}

public static String get(String lang, String param){
   
    String returnVal= "";
    if(lang.equals("ko")) {
        returnVal= Util.toUTF8(Config.getInstance().getProperty("lang","ko"+param));
    }else {
        returnVal=Util.toUTF8(Config.getInstance().getProperty("lang","jp"+param));
    }
    return returnVal ;
}


}
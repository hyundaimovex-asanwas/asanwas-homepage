/*
 *
 * 시스템의 설정사항을 관리한다.
 */

package kr.co.imjk.util;

import java.util.HashMap;
import java.util.Set;
import java.util.Iterator;
import java.util.Properties;
import java.io.IOException;
import java.io.InputStream;

public class Config {
    final private static String DEFAULT_SYSTEM ="imjkmd";
    private static Config instance=null;

    /**
     * 
     * @uml.property name="ht"
     * @uml.associationEnd 
     * @uml.property name="ht" multiplicity="(0 1)" qualifier="systemName:java.lang.String
     * prop:java.util.Properties"
     */
    HashMap ht = null;


    /*
      propertie파일 명 맴핑..reload시 한꺼번에 reload하기 위해 사용...
	*/
    private Config() {
        ht=new HashMap();
    }


/*******************************************************************

    프로퍼티 파일 Loding
    Default 는 /WEB-INF/classes/properties/imjkmd.properties
********************************************************************/
    Properties getResource(String name) throws IOException {
        InputStream is=getClass().getResourceAsStream("/properties/"+name+".properties");
        if (is!=null) {
            Properties prop=new Properties();
            prop.load(is);
            return prop;
        }
        return null;
    }




/*************************************************************************

    프로퍼티 정보  

****************************************************************************/



    public String getProperty(String systemName,String key) {
        //System.out.println("systemName=="+systemName);        
        Properties prop=(Properties)ht.get(systemName);
       
        try{
            
            
            if (prop==null) {
                
                if ((prop=getResource(systemName))==null) {
                    //System.out.println("[first time warring] can't find "+systemName+".properties com.imjk.blog.properties will be used.");
                    prop=getResource(DEFAULT_SYSTEM);
                }
                
                ht.put(systemName,prop);
            }
            
            if(prop.getProperty(systemName+"."+key) != null){
            	return prop.getProperty(systemName+"."+key);
            }            
        }catch(IOException e){
            
        }

        return prop.getProperty(key);
    }
    
   


     /*

      properties를 한꺼번에 로딩
	 */
    public synchronized void reloadCnfig() throws IOException {
        Iterator keys=ht.keySet().iterator();
        while (keys.hasNext()) {
            String key=(String)keys.next();
            Properties prop=getResource(key);
            if (prop==null) prop=getResource(DEFAULT_SYSTEM);
            ht.put(key,prop);
        }
    }

    /**
     * 
     * @uml.property name="instance"
     */
    public static synchronized Config getInstance() {
        if (instance == null) {
            instance = new Config();
        }
        return instance;
    }

    public String getWebProperty(String systemName,String key) throws IOException 
    {
        Properties prop=(Properties)ht.get(systemName);
        
        if (prop==null) {
            
            if ((prop=getResource(systemName))==null) {
                //System.out.println("[first time warring] can't find"+systemName+".properties com.imjk.blog.properties will be used.");
                prop=getResource(DEFAULT_SYSTEM);
            }
            ht.put(systemName,prop);
        }
        return prop.getProperty(key);
    }

}

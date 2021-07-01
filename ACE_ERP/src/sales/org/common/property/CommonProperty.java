/*******************************************************************************
 * 1.클래스   명 : CommonProperty.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2006-02-02
 ******************************************************************************/

package sales.org.common.property;


import java.io.File;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;

import sales.org.common.log.LogUtil;
import sales.org.util.PropertiesUtil;



public class CommonProperty{
	private static String webAppHome;
	private static String propertyFileName;
	private static Properties commonProps;
	private static String dsNname;
	private static String saveHome;
	private static Hashtable realPath;
	private static Hashtable virtualPath;

	public static void init(){
		propertyFileName = "common.properties";
		try{
			commonProps = PropertiesUtil.getProperties(webAppHome+File.separator+"WEB-INF"+File.separator+propertyFileName);
			Initialize();
			LogUtil.info("Properties init");
		}catch(Exception e){
			LogUtil.error(e);
		}
	}

	public static void Initialize(){
		try{
			dsNname = commonProps.getProperty("dataSourceName");
			if("virtual".equalsIgnoreCase(commonProps.getProperty("isSavePath"))){
				saveHome = webAppHome+File.separator+commonProps.getProperty("fileSavePath");
			}else{
				saveHome = commonProps.getProperty("fileSavePath");
			}
			Enumeration en = commonProps.propertyNames();
			realPath = new Hashtable();
			virtualPath = new Hashtable();
			while(en.hasMoreElements()){
				String tmpStr = (String)en.nextElement();  
				if(tmpStr.startsWith("fileSavePath.")){
					realPath.put(tmpStr.substring(13),saveHome+File.separator+commonProps.getProperty(tmpStr));
					virtualPath.put(tmpStr.substring(13),"/"+commonProps.getProperty("fileSavePath")+"/"+commonProps.getProperty(tmpStr));
				}
			}
		}catch(Exception e){
			LogUtil.error(e);
		}
		
	}
	
	public static String getWebAppHome() {
		return webAppHome;
	}

	public static void setWebAppHome(String in) {
		webAppHome = in;
	}

	public static String getProperty(String key){
		return commonProps.getProperty(key);
	}

	public static String getRealPath(String key){
		return (String)realPath.get(key); 
	}

	public static String getVirtualPath(String key){
		return (String)virtualPath.get(key); 
	}
	public static String getSaveHome(){
		return saveHome; 
	}

	public static String getDsNname(){
		return dsNname; 
	}
}
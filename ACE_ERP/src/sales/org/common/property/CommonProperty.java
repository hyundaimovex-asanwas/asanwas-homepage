/*******************************************************************************
 * 1.Ŭ����   �� : CommonProperty.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
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
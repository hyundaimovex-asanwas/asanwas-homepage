/*
 * 작성자 : 이동연
 * 파일명 : ExtractRule.java
 * 작성일 : 2004-05-29
 */
package sales.org.util.entity;

import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;

public class RequestSettingRule  implements IEntitySettingRule {
	public void set(EntitySetter setter, Object src) {
		HttpServletRequest request = (HttpServletRequest)src;
		  
		for (Enumeration e = request.getParameterNames();e.hasMoreElements();) {
			String s = (String)e.nextElement(); 
			setter.setValue(s, request.getParameter(s));
		}
		
		for (Enumeration e = request.getAttributeNames();e.hasMoreElements();) {
			String s = (String)e.nextElement(); 
			setter.setValue(s, request.getAttribute(s));
		}
	}
}

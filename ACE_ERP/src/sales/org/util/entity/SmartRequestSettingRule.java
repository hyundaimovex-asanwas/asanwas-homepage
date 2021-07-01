/*
 * 작성자 : 이동연
 * 파일명 : ExtractRule.java
 * 작성일 : 2004-05-29
 */
package sales.org.util.entity;

import sales.org.common.request.SmartRequest;

public class SmartRequestSettingRule  implements IEntitySettingRule {
	public void set(EntitySetter setter, Object src) {
		SmartRequest req = (SmartRequest)src;
		  
		String[] strName = req.getParameterNameArray();
		
		if(strName != null) {
			for(int i = 0; i < strName.length; i++) {
				String s = (String)strName[i]; 
				setter.setValue(s, req.getParameterArray(strName[i])[0]);
			}
		}
	}
}

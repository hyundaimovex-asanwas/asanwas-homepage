/*
 * 작성자 : 이동연
 * 파일명 : ExtractRule.java
 * 작성일 : 2004-05-29
 */
package sales.org.util.entity;

import java.util.HashMap;
import java.util.Set;

public class HashMapSettingRule  implements IEntitySettingRule {
	public void set(EntitySetter setter, Object src) {
		HashMap map = (HashMap)src;
		  
		Set set = map.keySet();
		
		java.util.Iterator iter = set.iterator();

		while(iter.hasNext()) {
			String key = (String)iter.next();

			setter.setValue(key, map.get(key));
		}
	}
}

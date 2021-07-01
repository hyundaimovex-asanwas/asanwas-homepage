/*
 * 작성자 : 이동연
 * 파일명 : EntitySetter.java
 * 작성일 : 2004. 6. 10.
 * 
 */
package sales.org.util.entity;

import java.lang.reflect.*;
import java.util.HashMap;

/**
 * Entity에 값을 자동적으로 설정하기 위한 Class
 * 
 * @author 이동연
 */
public class EntitySetter {
	private Object entity;
	
	// 메소드명을 키로 파라메터 타입명을 저장
	private HashMap mapSetter;

	// 필드(멤버 변수)명을 키로 타입명을 저장
	private HashMap mapField;

	private IEntitySettingRule rule;

	EntitySetter() {
		mapField = new HashMap();
		mapSetter = new HashMap();
	}

	void setExtractRule(IEntitySettingRule er) {
		rule = er;
	}

	void extract(Object entity) {
		this.entity = entity;

		try {
			Class c = entity.getClass();
		
			Field[] field = c.getDeclaredFields();

			// 모든 메소드(Setter Method를 찾기 위해)
			Method[] methods = c.getMethods(); 

			for(int i = 0; i < field.length; i++) {
				Class fType = field[i].getType();			
	
				String fieldName = field[i].getName();
				boolean bAccess = Modifier.isPublic(field[i].getModifiers());

				if(bAccess) {
					// 변수에 접근 가능
					mapField.put(fieldName, field[i]);
				}
				else {
					// 변수에 접근 불가이면 Setter Method를 구함
					Method setter = EntityUtil.getSetter(fieldName, methods);
					if(setter != null) {
						mapSetter.put(fieldName, setter);
					}
				}

			} //end for
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void set(Object src, Object dest) {
		extract(dest);
		
		rule.set(this, src);
	}

	void setValue(String fieldName, Object objColumn) {
		Field field = (Field)mapField.get(fieldName);

		if(field != null) {
			TypeConvertManager.convert(objColumn, entity, field);
		}
		else {
			Method setter = (Method)mapSetter.get(fieldName);

			if(setter != null) {
				try {
					TypeConvertManager.convert(objColumn, entity, setter);
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}

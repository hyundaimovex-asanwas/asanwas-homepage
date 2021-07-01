/*
 * �ۼ��� : �̵���
 * ���ϸ� : EntitySetter.java
 * �ۼ��� : 2004. 6. 10.
 * 
 */
package sales.org.util.entity;

import java.lang.reflect.*;
import java.util.HashMap;

/**
 * Entity�� ���� �ڵ������� �����ϱ� ���� Class
 * 
 * @author �̵���
 */
public class EntitySetter {
	private Object entity;
	
	// �޼ҵ���� Ű�� �Ķ���� Ÿ�Ը��� ����
	private HashMap mapSetter;

	// �ʵ�(��� ����)���� Ű�� Ÿ�Ը��� ����
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

			// ��� �޼ҵ�(Setter Method�� ã�� ����)
			Method[] methods = c.getMethods(); 

			for(int i = 0; i < field.length; i++) {
				Class fType = field[i].getType();			
	
				String fieldName = field[i].getName();
				boolean bAccess = Modifier.isPublic(field[i].getModifiers());

				if(bAccess) {
					// ������ ���� ����
					mapField.put(fieldName, field[i]);
				}
				else {
					// ������ ���� �Ұ��̸� Setter Method�� ����
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

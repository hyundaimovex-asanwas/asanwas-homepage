/*
 * �ۼ��� : �̵���
 * ���ϸ� : EntityUtil.java
 * �ۼ��� : 2004-05-29
 */
package sales.org.util.entity;


import java.lang.reflect.*;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

import sales.org.common.request.SmartRequest;


/**
 * Entity�� ���� �ٷ�� �ִ� ��� ����
 * 
 * 
 * @author �̵�
 */
public class EntityUtil {
	
	static boolean isMethodFromColumn(String field, String method) {
		StringBuffer buf = new StringBuffer();
		
		buf.append("set");
		field = field.toLowerCase();
//		String[] words = field.split("_");
//		for(int i = 0; i < words.length; i++) {
			buf.append(Character.toUpperCase(field.charAt(0)));
			buf.append(field.substring(1));
//		}
		
		return false;
	}
	
	static String getFieldNameFromColumn(String col) {
		StringBuffer buf = new StringBuffer();
		
		return col.toLowerCase();
		
//		String[] words = col.split("_");
//		for(int i = 0; i < words.length; i++) {
//			if(i == 0) {
//				buf.append(words[i]);
//			}
//			else {
//				buf.append(Character.toUpperCase(words[i].charAt(0)));
//				buf.append(words[i].substring(1));
//			}
//		}

//		return buf.toString();
	}
	
	static String getGetterNameFromColumn(String col) {
		StringBuffer buf = new StringBuffer();
		
		buf.append("get");
		col = col.toLowerCase();
//		String[] words = col.split("_");
//		for(int i = 0; i < words.length; i++) {
			buf.append(Character.toUpperCase(col.charAt(0)));
			buf.append(col.substring(1));
//		}

		return buf.toString();
	}
	
	static String getGetterName(String field) {
		StringBuffer buf = new StringBuffer();
		
		if (field == null) {
			return null;
		}
		else {
			if (field.length() > 0) {
				buf.append("get");
				buf.append(Character.toUpperCase(field.charAt(0)));
			}
			if (field.length() > 1) {
				buf.append(field.substring(1));
			}
		}

		return buf.toString();
	}

	static String getSetterName(String field) {
		StringBuffer buf = new StringBuffer();
		
		if (field == null) {
			return null;
		}
		else {
			if (field.length() > 0) {
				buf.append("set");
				buf.append(Character.toUpperCase(field.charAt(0)));
			}
			if (field.length() > 1) {
				buf.append(field.substring(1));
			}
		}

		return buf.toString();
	}

	static Method getGetter(String field, Method[] methods) {
		Method mt = null;
		
		for(int i = 0; i < methods.length; i++) {
			String methodName = methods[i].getName();
			Class[] pType = methods[i].getParameterTypes();

			if(methodName.equals(getGetterName(field)) && pType.length == 0) {
				mt = methods[i];
				break;
			}
		}
		
		return mt;
	}

	static Method getSetter(String field, Method[] methods) {
		Method mt = null;
		
		for(int i = 0; i < methods.length; i++) {
			String methodName = methods[i].getName();

			Class[] pType = methods[i].getParameterTypes();

			if(methodName.equals(getSetterName(field)) && pType.length == 1) {
				mt = methods[i];
				break;
			}
		}
		
		return mt;
	}

	static String getColumn(String method) {
		StringBuffer buf = new StringBuffer();
		
		String column = method.replaceFirst("^set", "");

		char[] chars = column.toCharArray();

		buf.append(Character.toLowerCase(chars[0]));

		for(int i = 1; i < chars.length; i++) {
			if(Character.isUpperCase(chars[i])) {
				buf.append("_");
				buf.append(Character.toLowerCase(chars[i]));
			}
			else {
				buf.append(chars[i]);
			}
		}
		
		return buf.toString();
	}

	/**
	 * Resultset�� ���� ��ü�� �����Ѵ�.
	 * @param rs
	 * @param dest
	 */
	public static void setObject(ResultSet rs, Object dest) {
		EntitySetter es = new EntitySetter();
		es.setExtractRule(new ResultSetSettingRule());
		es.set(rs, dest);
	}
	
	/**
	 * Request�� ���� ��ü�� �����Ѵ�.
	 * @param request	�Է� Request ����Ÿ
	 * @param dest		���� ��ü
	 */
	public static void setObject(HttpServletRequest request, Object dest) {
		EntitySetter es = new EntitySetter();
		es.setExtractRule(new RequestSettingRule());
		es.set(request, dest);
	}
	
	/**
	 * SmartRequest�� ���� ��ü�� �����Ѵ�.
	 * @param request	�Է� SmartRequest ����Ÿ
	 * @param dest		���� ��ü
	 */
	public static void setObject(SmartRequest request, Object dest) {
		EntitySetter es = new EntitySetter();
		es.setExtractRule(new SmartRequestSettingRule());
		es.set(request, dest);
	}

	/**
	 * HashMap�� ���� ��ü�� �����Ѵ�.
	 * @param map	�Է� HashMap ����Ÿ
	 * @param dest	���� ��ü
	 */
	public static void setObject(HashMap map, Object dest) {
		EntitySetter es = new EntitySetter();
		es.setExtractRule(new HashMapSettingRule());
		es.set(map, dest);
	}

	/**
	 * Object�� ��� ��� ������ Getter �޼ҵ��� ���� ���ڿ��� ��Ÿ����.
	 * @param obj
	 * @return
	 */
	public static String toString(Object obj) {
		StringBuffer buf = new StringBuffer();

		if (obj == null) {
			return "null";
		}
		
		try
		{				
			Class c = obj.getClass();
		
			// �⺻ Ÿ���̰ų� java. ������ package�� ��� 
			if(c.isPrimitive() || c.getName().indexOf("java.") == 0) {
				return obj.toString();
			}

			if(c.isArray()) {
				int len = Array.getLength(obj);
				String className = c.getName();
				buf.append("{" + className + ": ");

				for(int i = 0; i < len; i++) {
					if(i != 0) buf.append(", ");
					buf.append("\n\t");
					buf.append(className + "[" + i + "]=");
					Object element = Array.get(obj, i);
					buf.append(toString(element));
				}

				buf.append("}");
				
				return buf.toString();
			} 
			else {
				buf.append("{" + c.getName() + ": ");
	
				// ��� �ʵ�
				Field[] field = c.getDeclaredFields();

				// ��� �޼ҵ�(Getter Method�� ã�� ����)
				Method[] methods = c.getMethods(); 
	
				for(int i = 0; i < field.length; i++) {
					if(i != 0) buf.append(", ");

					Object fObj = null;
					Class fType = field[i].getType();			
	
					String fieldName = field[i].getName();
					boolean bAccess = Modifier.isPublic(field[i].getModifiers());

					if(bAccess) {
						// ������ ���� ����
						fObj = field[i].get(obj);
					}
					else {
						// ������ ���� �Ұ��̸� Getter Method�� ����
						Method getter = getGetter(field[i].getName(), methods);
						
						if(getter != null) {
							bAccess = true;
							fObj = getter.invoke(obj, new Object[] {});
						}
					}

					if(bAccess) {
						if(fObj == null) {
							buf.append(fieldName + "=null");
						}
						else {
							Class fObjType = fObj.getClass();
							
							if(fObjType.isArray()) {
								int len = Array.getLength(fObj);
		
								if(len == 0) {
									buf.append(fieldName + "=[]");
								}
								else {
									for(int j = 0; j < len; j++) {
										if(j != 0) buf.append(", ");
										buf.append(fieldName + "[" + j + "]=");
										Object element = Array.get(fObj, j);
										buf.append(toString(element));
									}
								}
							}
							else {
								buf.append(fieldName + "=" + toString(fObj));
							}						
						}
					}
				} //end for

				buf.append("}");
			} //end if

		}
		catch(Exception e){
			System.err.println(buf.toString());
		}
	
		return buf.toString();
	}
}
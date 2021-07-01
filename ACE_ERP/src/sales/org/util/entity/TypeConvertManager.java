/*
 * 작성자 : 이동연
 * 파일명 : TypeConvertManager.java
 * 작성일 : 2004. 6. 10.
 * 
 */
package sales.org.util.entity;

import java.lang.reflect.*;
import java.util.HashMap;

/**
 * TypeConvert를 관리
 * 
 * @author 이동연
 */
public class TypeConvertManager {
	private static HashMap mapConverter = null;
	
	private TypeConvertManager() {
	}

	private static void init() {
		mapConverter = new HashMap();

		setConverter("int", new IntegerConverter());
		setConverter("java.lang.Integer", new IntegerConverter());
		setConverter("long", new IntegerConverter());
		setConverter("java.lang.Long", new LongConverter());

		setConverter("java.lang.String", new StringConverter());

		setConverter("java.util.Date", new DateConverter());
		setConverter("java.sql.Timestamp", new TimestampConverter());
		
	}

	private static ITypeConverter getConverter(String className) {
		if(mapConverter == null) {
			init();
		}

		return (ITypeConverter)mapConverter.get(className);
	}
	
	public static void convert(Object srcValue, Object dest, Field destField) {
		Object objRet = null;
		
		ITypeConverter conv = getConverter(destField.getType().getName());
		
		if(conv == null) {
			System.err.println(destField.getType().getName() + " Converter not present");
		}
		else {			
			objRet = conv.convert(srcValue);
		}
		
		if(objRet != null) {
			try {
				destField.set(dest, objRet);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static void convert(Object srcValue, Object dest, Method setter) {
		Object objRet = null;
		
		Class[] pType = setter.getParameterTypes();

		ITypeConverter conv = getConverter(pType[0].getName());

		if(conv == null) {
			System.err.println(pType[0].getName() + " Converter not present");
		}
		else {	 
			objRet = conv.convert(srcValue);
		}

		if(objRet != null) {
			try {
				setter.invoke(dest, new Object[] {objRet});
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 객체의 Type을 변환
	 * @param srcValue 변환할 객체
	 * @param type 타입 문자열("int", "String", "Integer"...)
	 * @return TypeObject 객체를 리턴하며 이 객체의 필드에 값이 설정돼 리턴된다.
	 */
	public static TypeObject convert(Object srcValue, String type) {
		TypeObject to = new TypeObject();

		Class c = to.getClass();
	
		Field[] field = c.getFields();

		for(int i = 0; i < field.length; i++) {
			String fieldName = field[i].getName();

			if (fieldName.equals("_" + type)) {
				convert(srcValue, to, field[i]);
				break;
			}
		} //end for
		
		return to;
	}
	
	private static void setConverter(String typeName, ITypeConverter conv) {
		mapConverter.put(typeName, conv);
	}
}
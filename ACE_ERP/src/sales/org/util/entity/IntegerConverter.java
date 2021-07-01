/*
 * 작성자 : 이동연
 * 파일명 : IntegerConverter.java
 * 작성일 : 2004. 6. 10.
 * 
 */
package sales.org.util.entity;

/**
 * Integer 객체로 변환
 * 
 * @author 이동연
 */
public class IntegerConverter implements ITypeConverter {
	public Object convert(Object objValue) {
		Integer ret = new Integer(0);
		
		if(objValue == null) return ret;
		
		String typeName = objValue.getClass().getName(); 
		
		if(typeName.equals("java.lang.String")) {
			return Integer.valueOf((String)objValue);
		}
		else if(typeName.equals("java.lang.Integer")) {
			return objValue;
		}
		else if(typeName.equals("java.lang.Long")) {
			return new Integer(((Long)objValue).intValue());
		}
		else if(typeName.equals("java.math.BigDecimal")) {
			return new Integer(((java.math.BigDecimal)objValue).intValue());
		}
		else {
			System.err.println("IntegerConverter.convert : " + typeName);
		}

		return ret;
	}
}

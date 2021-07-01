/*
 * 작성자 : 이동
 * 파일명 : LongConverter.java
 * 작성일 : 2004. 6. 10.
 * [파일 설명]
 * 
 */
package sales.org.util.entity;

/**
 * Long 객체로 변환
 * 
 * @author 이동연
 */
public class LongConverter implements ITypeConverter {
	public Object convert(Object objValue) {
		Long ret = new Long(0);
		
		if(objValue == null) return ret;
		
		String typeName = objValue.getClass().getName(); 
		
		if(typeName.equals("java.lang.String")) {
			return Long.valueOf((String)objValue);
		}
		else if(typeName.equals("java.lang.Integer")) {
			return new Long(((Integer)objValue).longValue());
		}
		else if(typeName.equals("java.lang.Long")) {
			return objValue;
		}
		else if(typeName.equals("java.math.BigDecimal")) {
			return new Long(((java.math.BigDecimal)objValue).longValue());
		}

		return ret;
	}
}

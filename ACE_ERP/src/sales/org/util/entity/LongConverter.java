/*
 * �ۼ��� : �̵�
 * ���ϸ� : LongConverter.java
 * �ۼ��� : 2004. 6. 10.
 * [���� ����]
 * 
 */
package sales.org.util.entity;

/**
 * Long ��ü�� ��ȯ
 * 
 * @author �̵���
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

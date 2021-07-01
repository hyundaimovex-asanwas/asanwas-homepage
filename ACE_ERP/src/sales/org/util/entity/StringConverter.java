/*
 * 작성자 : 이동연
 * 파일명 : StringConverter.java
 * 작성일 : 2004. 6. 10.
 * [파일 설명]
 *
 */
package sales.org.util.entity;

/**
 * String 객체로 변환
 *
 * @author 이동연
 */
public class StringConverter implements ITypeConverter {
    public Object convert(Object objValue) {
        if(objValue == null) return "";

        String typeName = objValue.getClass().getName();

        if(typeName.equals("java.lang.String")) {
            return objValue;
        }
        else if(typeName.equals("java.lang.Integer")) {
            return _convert((java.lang.Integer)objValue);
        }
        else if(typeName.equals("java.lang.Long")) {
            return _convert((java.lang.Long)objValue);
        }
        else if(typeName.equals("java.lang.Character")) {
            return _convert((java.lang.Character)objValue);
        }
        else if(typeName.equals("java.util.Date")) {
            return _convert((java.util.Date)objValue);
        }


        return "";
    }

    private String _convert(Integer n) {
        return n.toString();
    }

    private String _convert(Long l) {
        return l.toString();
    }

    private String _convert(Character c) {
        return c.toString();
    }

    private String _convert(java.util.Date d) {
        return d.toString();
    }

}

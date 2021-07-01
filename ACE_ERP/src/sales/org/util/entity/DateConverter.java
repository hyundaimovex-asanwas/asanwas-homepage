/*
 * 작성자 : 이동연
 * 파일명 : DateConverter.java
 * 작성일 : 2004. 6. 10.
 *
 */
package sales.org.util.entity;

import java.util.Date;

/**
 * Date 객체로 변환
 *
 * @author 이동연
 */
public class DateConverter implements ITypeConverter {
    public Object convert(Object objValue) {
        if(objValue == null) return null;

        String typeName = objValue.getClass().getName();

        if(typeName.equals("java.lang.String")) {
            return _convert((String)objValue);
        }
        else if(typeName.equals("java.lang.Integer")) {
            return new Date(((Integer)objValue).longValue());
        }
        else if(typeName.equals("java.lang.Long")) {
            return new Date(((Long)objValue).longValue());
        }
        else if(typeName.equals("java.sql.Timestamp")) {
            return objValue;
        }

        return null;
    }

    private Date _convert(String str) {
        Date date = null;

        String[] dateFormats = {
            "yyyy-MM-dd HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd HH:mm",
            "yyyy-MM-dd HH",
            "yyyy-MM-dd",
            "yyyy-MM",
            "yyyy/MM/dd HH:mm:ss.SSS",
            "yyyy/MM/dd HH:mm:ss",
            "yyyy/MM/dd HH:mm",
            "yyyy/MM/dd HH",
            "yyyy/MM/dd",
            "yyyy/MM",
            "yyyyMMddHHmmssSSS",
            "yyyyMMddHHmmss",
            "yyyyMMddHHmm",
            "yyyyMMddHH",
            "yyyyMMdd",
            "yyyyMM"
        };

        for(int i = 0; i < dateFormats.length; i++) {
            String format = dateFormats[i];

            date = getDate(str, format);

            if(date != null) break;
        }

        return date;
    }

    private Date getDate(String str, String frm) {
        Date date = null;

        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(frm);

        try {
            date = sdf.parse(str);
        }
        catch (Exception e) {}

        return date;
    }
}

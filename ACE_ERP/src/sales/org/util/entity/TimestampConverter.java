/*
 * �ۼ��� : �̵���
 * ���ϸ� : DateConverter.java
 * �ۼ��� : 2004. 6. 10.
 *
 */
package sales.org.util.entity;

import java.util.Date;
import java.sql.Timestamp;

/**
 * Date ��ü�� ��ȯ
 *
 * @author �̵���
 */
public class TimestampConverter implements ITypeConverter {
    public Object convert(Object objValue) {
        if(objValue == null) return null;

        String typeName = objValue.getClass().getName();

        if(typeName.equals("java.lang.String")) {
            return _convert((String)objValue);
        }
        else if(typeName.equals("java.lang.Integer")) {
            return new Timestamp(((Integer)objValue).longValue());
        }
        else if(typeName.equals("java.lang.Long")) {
            return new Timestamp(((Long)objValue).longValue());
        }
        else if(typeName.equals("java.sql.Timestamp")) {
            return objValue;
        }

        return null;
    }

    private Timestamp _convert(String str) {
        Timestamp ts = null;

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

            Date date = getDate(str, format);

            if(date != null) {
                ts = new Timestamp(date.getTime());
                break;
            }
        }

        return ts;
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

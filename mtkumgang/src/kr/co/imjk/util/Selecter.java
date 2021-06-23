/*
 * Selecter.java
 *
 * ������ ���̽����� �˻��� ������� Ư���� Bean�� �����Ͽ� �迭�� �����ϴ� Ŭ����
 * ���÷��� API�� ����Ͽ� �ڹٺ��� ������ �����ϰ�, ResultSetMetaData�� �����ͺ��̽��� 
 * ������ Ÿ���� �ľ��Ѵ�.
 * 
 * ���� ����
 * - JDBC 2.0 API�� �ݵ�� ������ ��
 * - ���ϵǴ� �÷��� �� ������ Ÿ�԰� ������ FIELD��  Bean �� ����Ǿ� �ְ� setXxx() �޼ҵ尡 �����Ͽ��� ��
 *
 * �����
 *  > Selecter s = new Selecter(DB_SID[0], "com.miraenet.beans.AdmLecBean", true);
 *  > s.pageConfig(1, 10); // �������� ����� Ư���� �������� ������� �����Ҷ� ��� 
 *  > Collection col = s.execute(sql, Selecter.NULL);
 *
 * @ author : ������
 * @ date : 2001-07-18
 * @ mail : sim11@miraenet.com
 *
 */
package kr.co.imjk.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Clob;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Collection;
import kr.co.imjk.util.Util;

public class Selecter{
        
    /**
     * ResultSet�� �Է¹޾� Bean ������Ʈ�� ��� ����
     */
    public static Collection execute(ResultSet rs, Object anyBean) throws Exception{
        Collection c = new ArrayList();
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnCount = rsmd.getColumnCount();
        Class clsObj = anyBean.getClass();
        while (rs.next()){
            Object bo = clsObj.newInstance();                
            for(int i=0; i<columnCount; i++){ 
                Object obj = null;
                if(rsmd.getColumnType(i+1) == -1){ // LONG TYPE
                    obj = SqlUtil.getLongRaw(rs, i+1);
                    //obj = rs.getObject(i+1);
                    //System.out.println("LONG : " + rsmd.getColumnName(i+1));
                }else{
                    obj = rs.getObject(i+1);
                }                    
                invoke(clsObj, bo, rsmd.getColumnName(i+1), obj);                    
            }
            c.add(bo);
        }
        return c;       
    }

    /**
     * ������ ���̽��� ���� ���� �÷���� Beans�� Field�� ���Ͽ� set �޼ҵ尡 �ִ��� �˻��� �� <br>
     * Filed�� Object ���¸� �ľ��Ͽ� set�޼ҵ��� argument �� �־� �޼ҵ带 call �Ѵ�.<br>
     * java.lang.reflect API �� �̿��Ͽ� Beans�� �ľ��Ѵ�.
     */
    private static void invoke(Class clsObj, Object beanObj, String columnName, Object initValue) 
        throws NoSuchMethodException, NoSuchFieldException, InvocationTargetException
    {
        if(initValue == null)  
            return;
        String fieldName = columnName.toLowerCase();
        if(fieldName.equals("rownum_idx"))
            return;
        try{
            Field field = clsObj.getDeclaredField(fieldName);
            Class fieldType = field.getType();
            
            StringBuffer sb =  new StringBuffer("set");
            sb.append(fieldName.substring(0,1).toUpperCase());
            sb.append(fieldName.substring(1));

            Method method = clsObj.getDeclaredMethod(sb.toString(), new Class[]{fieldType});
            Object [] args = new Object[1];
            //System.out.println("fieldName=="+fieldName+"//fieldType==="+ fieldType);
            
            // String
            if(fieldType == new String().getClass()){
                /* ��ü�� DB�� Ÿ���� ���ߴ� ����
                 * content�� fieldName==content, fieldType===class java.lang.String �̷��� �޾ƿ´�
                 * ���� ���⼭ �б⸦ ����� �� �� �Կ�..
                 * ���̺� TBRD_BOARD_MA�� CLOB �÷��� 
                 *   CONTENT, REPLY_CONTENT 2�� 
                 *   ���п� TBRD_BOARD_DE�� content �÷��� �̸��� �ٲ��ְ� ������ _�Ф� */
                if(fieldName.equals("content")||fieldName.equals("reply_content")){
	                //System.out.println("iniVal=="+ Util.weblogicClobToString((Clob) initValue));//�̰ɷ� �ϴ� �о�Կ�!!!!
	            	args [0] = Util.weblogicClobToString((Clob) initValue);
                } else {
                	args [0] = initValue.toString();	
                }
            // Number, Float
            }else if(fieldType == Integer.TYPE){
                try{
                    args [0] = new Integer(initValue.toString());
                }catch(NumberFormatException ne){
                    args [0] = new Float(initValue.toString());
                }
            }else if(fieldType == Float.TYPE){
                args [0] = new Float(initValue.toString());                
            // Date
            }else if(fieldType == (new java.util.Date()).getClass()){
                args [0] = (java.util.Date)initValue;
            // Clob 20141106 sdh
            }else if(fieldType == Clob.class){
            	System.out.println("iniVal=="+ Util.weblogicClobToString((Clob) initValue));//�̰ɷ� �ϴ� �о�Կ�!!!!
            	args [0] = Util.weblogicClobToString((Clob) initValue);
            	//args [0] = initValue.toString();
            // Unknown
            }else{
                args [0] = initValue.toString();                
            }
            method.invoke(beanObj, args);            
        }catch(NoSuchMethodException nsme){
             throw new NoSuchMethodException("������ �ش��ϴ� setter �޼ҵ尡 �����ϴ�. -> " + fieldName);
        }catch(NoSuchFieldException nsfe){
            throw new NoSuchFieldException("�� ��ü�� �÷��� �ش��ϴ� ������ �����ϴ�. -> " + fieldName);
        }catch(IllegalAccessException iae){ 
        }catch(InvocationTargetException invte){
            throw new InvocationTargetException(invte);
        }catch(IllegalArgumentException iae2){
            throw new IllegalArgumentException("DB�� ��ü�� ���� Ÿ���� ��ġ ���� �ʽ��ϴ�. -> " + fieldName);
        }
    }
}
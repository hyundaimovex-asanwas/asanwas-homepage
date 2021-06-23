/*
 * Setter.java
 *
 * 1. JSP ������ <jsp:setProperty name="beanId" property="fieldName"/>
 *   <jsp:getProperty name="beanId" property="fieldName"/> �±��� ����� �ϴ� Ŭ����
 * 2. ��뿹 (�������� Bean�� ��� �Ķ������ ���� ������ ����ϸ� ������ ����)
 *     // bean  instance ����
 *     JavaBeans bean = new JavaBeans();
 *     Setter set = new Setter(bean, req);
 *     // 1) HttpServletRequest�� ���� ��� �Ķ���ͷ� ������
 *     set.setProperty("*");
 *     // 2) Ư���� �Ķ���͸� ������
 *     set.setProperty("id");
 *     // 3) Ư���� �Ķ���Ϳ� ������ ���� ������
 *     set.setProperty("id", "sim11");
 *
 * 3. ����Ҽ� �ִ� ������ Ÿ�� : String, int, float, double, long
 *
 *
 * @ author : ������
 * @ date : 2001-07-18
 * @ mail : sim11@miraenet.com
 *
 */ 
  
package kr.co.imjk.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class Setter{
    private Class cls;
    private Object obj;

    /**
     * 
     * @uml.property name="req"
     * @uml.associationEnd 
     * @uml.property name="req" multiplicity="(0 1)"
     */
    private HttpServletRequest req;

    /**
     * 
     * @uml.property name="multi"
     * @uml.associationEnd 
     * @uml.property name="multi" multiplicity="(0 1)"
     */
    private MultipartRequest multi;

    private boolean isMultipart;
    
    private Field fields [];
    
    public Setter(Object obj, HttpServletRequest req) throws ClassNotFoundException {
        cls = obj.getClass();
        this.obj = obj;
        this.req = req; 
        init();
    }
    
    public Setter(Object obj, MultipartRequest multi) throws ClassNotFoundException {
        cls = obj.getClass();
        this.obj = obj;
        this.multi = multi;
        this.isMultipart = true;
        
        init();
    }    
    
    /**
     * Beans Ŭ������ ���ǵǾ� �ִ� ��� FIELD�� ������ �ε��Ѵ�.<br>
     * �ܺο��� Setter ��ü�� �����Ǿ� ���� �ѹ� ȣ��ȴ�.
     */
    private void init(){
        fields = cls.getDeclaredFields();
    }
    
    public void setProperty(String property) throws NoSuchFieldException, NoSuchMethodException{
        setProperty(property, null);
    }
    
    /**
     * Beans Ŭ������ ������ ���� �����ϴ� �޼ҵ�.<br>
     * NoSuchFieldException : �ش��ϴ� property�� BeansŬ������ FIELD�� �������� ������ ������<br>
     * NoSuchMethodException : �ش��ϴ� FIELD�� ���� SETTER Method�� �������� ������ ������<br>
     */
    public void setProperty(String property, String value) throws NoSuchFieldException, NoSuchMethodException{        
        
        boolean all = property.equals("*") ? true:false;
        
        if(!all){
            Field field = getDeclaredField(property);
            Method method = getDeclaredMethod(field);
            Object [] args = null;
            if(value == null){                
                args = getArgs(field.getType(), getParameter(property));
            }else{
                args = getArgs(field.getType(), value);
            }
            try{
                method.invoke(obj, args);
            }catch(Exception _ignored){}  
        }else{        
            for(int i=0; i<fields.length; i++){
                String fieldName = fields[i].getName();
                Method method = null;
                try{
                    method = cls.getDeclaredMethod("set"+fieldName.substring(0,1).toUpperCase() + fieldName.substring(1, fieldName.length()), 
                                                          new Class[]{fields[i].getType()});
                }catch(Exception _ignored){ // NoSuchMethodException, SecurityException
                    continue;    
                }
                
                // setter call ( valiable saved )
                Object [] args = getArgs(fields[i].getType(), getParameter(fieldName));
                if(args != null){
                    try{
                        method.invoke(obj, args);
                    }catch(Exception e){} // IllegalAccessException, IllegalArgumentException, InvocationTargetException
                }
            }
        }
    }
    
    /**
     * �ܺο��� ��û�� property�� �ش��ϴ� FIELD�� BeansŬ�������� ã�� �޼ҵ�
     */
    private Field getDeclaredField(String fieldName) throws NoSuchFieldException{
        Field field = null;
        for(int i=0; i<fields.length; i++ ){
            if((fields[i].getName()).equals(fieldName)){ 
                field = fields[i];    
                break;
            }
        }
        if(field == null)
            throw new NoSuchFieldException("Field Name : "+ fieldName);
        return field;
    }

    /**
     * Ư�� FIELD�� �ش��ϴ� Setter Method�� BeansŬ�������� ã�� �޼ҵ�
     */
    private Method getDeclaredMethod(Field field) throws NoSuchMethodException{
        Method method = null;
        String fieldName = field.getName();
        try{
            method = cls.getDeclaredMethod("set"+fieldName.substring(0,1).toUpperCase() + fieldName.substring(1, fieldName.length()), 
                                                          new Class[]{field.getType()});            
        }catch(Exception e){
            throw new NoSuchMethodException("Method Name : "+ "set"+fieldName.substring(0,1).toUpperCase() 
                                                        + fieldName.substring(1, fieldName.length()));
        }
        return method;
    }
    
    /**
     * Ư�� FILED�� ������ Ÿ���� �м��Ͽ� ������ setter method�� call�� ��� <br>
     * Argument�� ������ Ÿ�Կ� �°� Object�� �迭�� �����Ѵ�.
     */
    private Object[] getArgs(Class fieldType, String initValue){
        if(initValue != null){
            try{
                if(fieldType == Integer.TYPE){
                    return new Object[]{new Integer(initValue)};
                }else if(fieldType == Long.TYPE){
                    return new Object[]{new Long(initValue)};
                }else if(fieldType == Float.TYPE){
                    return new Object[]{new Float(initValue)};
                }else if(fieldType == Double.TYPE){
                    return new Object[]{new Double(initValue)};
                }else{
                    return new Object[]{initValue};
                }
            }catch(Exception ne){ }               
        }
        return null;
    }
    
    /**
     * �Ķ���͸� ������ multipart �����϶��� �Ϲ� ��û�� ��� �Ķ���� �ޱ⸦ �ٸ��� �Ѵ�.<br>
     * multipart �� ��� ���� ������ ���ϸ��� �޾ƿ��⸦ �õ��Ѵ�.
     */
    private String getParameter(String key){
        String str = null;
        if(!isMultipart){
            str = req.getParameter(key);
        }else{
            str = multi.getParameter(key);  
            if(str == null || str.length() == 0){
                str = multi.getFilesystemName(key);      
            }
        }
        return str;
    }
}
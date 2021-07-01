/*
 * Setter.java
 *
 * 1. JSP 에서의 <jsp:setProperty name="beanId" property="fieldName"/>
 *   <jsp:getProperty name="beanId" property="fieldName"/> 태그의 기능을 하는 클래스
 * 2. 사용예 (서블릿에서 Bean에 모든 파라미터의 값을 넣을때 사용하면 좋을것 같음)
 *     // bean  instance 생성
 *     JavaBeans bean = new JavaBeans();
 *     Setter set = new Setter(bean, req);
 *     // 1) HttpServletRequest로 부터 모든 파라미터로 받을때
 *     set.setProperty("*");
 *     // 2) 특정한 파라미터만 받을때
 *     set.setProperty("id");
 *     // 3) 특정한 파라미터에 지정한 값을 넣을때
 *     set.setProperty("id", "sim11");
 *
 * 3. 사용할수 있는 데이터 타입 : String, int, float, double, long
 *
 *
 * @ author : 심재진
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
     * Beans 클래스에 정의되어 있는 모든 FIELD의 정보를 로딩한다.<br>
     * 외부에서 Setter 객체가 생성되어 질때 한번 호출된다.
     */
    private void init(){
        fields = cls.getDeclaredFields();
    }
    
    public void setProperty(String property) throws NoSuchFieldException, NoSuchMethodException{
        setProperty(property, null);
    }
    
    /**
     * Beans 클래스에 실제로 값을 셋팅하는 메소드.<br>
     * NoSuchFieldException : 해당하는 property가 Beans클래스에 FIELD로 존재하지 않을때 던져짐<br>
     * NoSuchMethodException : 해당하는 FIELD에 대한 SETTER Method가 존재하지 않을때 던져짐<br>
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
     * 외부에서 요청한 property에 해당하는 FIELD를 Beans클래스에서 찾는 메소드
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
     * 특정 FIELD에 해당하는 Setter Method를 Beans클래스에서 찾는 메소드
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
     * 특정 FILED의 데이터 타입을 분석하여 실제로 setter method를 call할 경우 <br>
     * Argument의 데이터 타입에 맞게 Object의 배열로 리턴한다.
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
     * 파라미터를 받을때 multipart 형식일때와 일반 요청일 경우 파라미터 받기를 다르게 한다.<br>
     * multipart 일 경우 값이 없으면 파일명을 받아오기를 시도한다.
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
/*
 * Selecter.java
 *
 * 데이터 베이스에서 검색한 결과값을 특정한 Bean에 저장하여 배열로 리턴하는 클래스
 * 리플렉션 API를 사용하여 자바빈의 구조를 조사하고, ResultSetMetaData로 데이터베이스의 
 * 데이터 타입을 파악한다.
 * 
 * 제약 사항
 * - JDBC 2.0 API를 반드시 지원해 함
 * - 리턴되는 컬럼명 및 데이터 타입과 동일한 FIELD가  Bean 에 선언되어 있고 setXxx() 메소드가 존재하여야 함
 *
 * 사용방법
 *  > Selecter s = new Selecter(DB_SID[0], "com.miraenet.beans.AdmLecBean", true);
 *  > s.pageConfig(1, 10); // 페이지로 나누어서 특정한 페이지의 결과값만 리턴할때 사용 
 *  > Collection col = s.execute(sql, Selecter.NULL);
 *
 * @ author : 심재진
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
     * ResultSet을 입력받아 Bean 오브젝트에 담아 리턴
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
     * 데이터 베이스로 부터 읽은 컬럼명과 Beans의 Field를 비교하여 set 메소드가 있는지 검사한 후 <br>
     * Filed의 Object 형태를 파악하여 set메소드의 argument 로 넣어 메소드를 call 한다.<br>
     * java.lang.reflect API 를 이용하여 Beans를 파악한다.
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
                /* 빈객체랑 DB랑 타입을 맞추다 보니
                 * content가 fieldName==content, fieldType===class java.lang.String 이렇게 받아온다
                 * 따라서 여기서 분기를 해줘야 할 듯 함여..
                 * 테이블 TBRD_BOARD_MA의 CLOB 컬럼은 
                 *   CONTENT, REPLY_CONTENT 2개 
                 *   덕분에 TBRD_BOARD_DE의 content 컬럼은 이름을 바꿔주게 생겼음 _ㅠㅠ */
                if(fieldName.equals("content")||fieldName.equals("reply_content")){
	                //System.out.println("iniVal=="+ Util.weblogicClobToString((Clob) initValue));//이걸로 하니 읽어왔오!!!!
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
            	System.out.println("iniVal=="+ Util.weblogicClobToString((Clob) initValue));//이걸로 하니 읽어왔오!!!!
            	args [0] = Util.weblogicClobToString((Clob) initValue);
            	//args [0] = initValue.toString();
            // Unknown
            }else{
                args [0] = initValue.toString();                
            }
            method.invoke(beanObj, args);            
        }catch(NoSuchMethodException nsme){
             throw new NoSuchMethodException("변수에 해당하는 setter 메소드가 없습니다. -> " + fieldName);
        }catch(NoSuchFieldException nsfe){
            throw new NoSuchFieldException("빈 객체에 컬럼에 해당하는 변수가 없습니다. -> " + fieldName);
        }catch(IllegalAccessException iae){ 
        }catch(InvocationTargetException invte){
            throw new InvocationTargetException(invte);
        }catch(IllegalArgumentException iae2){
            throw new IllegalArgumentException("DB와 빈객체의 변수 타입이 일치 하지 않습니다. -> " + fieldName);
        }
    }
}
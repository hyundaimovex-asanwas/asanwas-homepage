package kr.co.imjk.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.sql.SQLException;
import java.sql.Types;

public class SqlUtil {
    
    /**
     * Long Raw 값 받아오기
     *
     * @ author : 심재진 
     * @ E-mail : sim11@miraenet.com
     *
     */
    public synchronized static String getLongRaw(java.sql.ResultSet rs, int columnIndex){
        /*
    	InputStream text_data = null;
    	StringBuffer str = new StringBuffer();
    	try{
    		text_data = rs.getBinaryStream(columnIndex);		
    		int c;
    		while ((c = text_data.read ())!= -1)
    			str.append((char)c);
    			
    		text_data.close();
    	}catch(IOException ie){
    		try{
    			if(text_data != null) text_data.close();
    		}catch(IOException ignored){}
    	}catch(java.sql.SQLException se){}
    	*/
        Reader r = null;
        StringBuffer str = new StringBuffer();
        try{
            r = rs.getCharacterStream(columnIndex);
            int c;
            while((c = r.read ())!= -1){
                str.append((char)c);
            }
            r.close();
        }catch(Exception ie){
            try{
                if(r != null) r.close();
            }catch(IOException ignored){}
        }
    	return str.toString();
    }
	
    /**
     * Long Raw 값 받아오기
     *
     * @ author : 심재진 
     * @ E-mail : sim11@miraenet.com
     *
     */
    public synchronized static String getLongRaw(java.sql.ResultSet rs, String columnName){
    	InputStream text_data = null;
    	StringBuffer str = new StringBuffer();
    	try{
    		text_data = rs.getBinaryStream(columnName);		
    		int c;
    		while ((c = text_data.read ())!= -1)
    			str.append((char)c);
    			
    		text_data.close();
    	}catch(IOException ie){
    		try{
    			if(text_data != null) text_data.close();
    		}catch(IOException ignored){}
    	}catch(java.sql.SQLException se){}
    	
    	// return Util.toKSC(str.toString());
        return str.toString();
    }
    
    /** 
     * Long Raw 값 입력하기
     *
     * @ author : 심재진 
     * @ E-mail : sim11@miraenet.com
     *
     */
    public synchronized static void setLongRaw(java.sql.PreparedStatement pstmt, int columnIndex, String text){
    	InputStream bis = null;
    	try{
    		bis = new ByteArrayInputStream(text.getBytes());
    		pstmt.setBinaryStream (columnIndex, bis, bis.available());
    		bis.close();
    	}catch(IOException ie){
    		try{
    			if(bis != null) bis.close();
    		}catch(IOException ignored){}
    	}catch(java.sql.SQLException se){}
    }
    
    /** 
         * Long Raw 값 입력하기
         *
         * @ author : 심재진
         * @ E-mail : sim11@miraenet.com
         *
         */
        public synchronized static void setLongRaw(java.sql.CallableStatement  cstmt, int columnIndex, String text){
            InputStream bis = null;
            try{
                //text = Util.toKSC(text);                
                bis = new ByteArrayInputStream(text.getBytes());
                cstmt.setBinaryStream (columnIndex, bis, bis.available());
                bis.close();
            }catch(IOException ie){
                try{
                    if(bis != null) bis.close();
                }catch(IOException ignored){}
            }catch(java.sql.SQLException se){}
        }
    
    /**
     * PreparedStatment 에 데이터를 바인딩시 null 값이 들어올 경우 null을 바인딩하는 메소드
     *
     * @ author : 심재진 
     * @ E-mail : sim11@miraenet.com
     *
     */
    public static synchronized void setBinding(java.sql.PreparedStatement pstmt, Object value, int columnIndex, int sqlType) throws java.sql.SQLException{
        if(value == null || value.toString().equals("")){
            pstmt.setNull(columnIndex, sqlType);
        }else{
            pstmt.setObject(columnIndex, value);
        }
    }

    /**
     * Varchar2(4000)에 데이터를 넣을 때 쓰는 Method
     *
     * @ author : 정철우 
     * @ E-mail : cwjung@miraenet.com
     *
     */
    public static void setCharString(java.sql.PreparedStatement pstmt, int columIndex, String en) throws SQLException{
        if(en == null){
            pstmt.setNull(columIndex, Types.VARCHAR);
        }else{
            // 오라클일때
            StringReader sr = new StringReader(en);
            pstmt.setCharacterStream(columIndex, sr, en.length());
            // sr.close(); --> 이놈 넣으면 죽어버림
            
    	    // MS-SQL 에서는 그냥 입력해도 됨
            // pstmt.setString(columIndex, en);
        }
    }
    
    
    /**
     * Varchar2(4000)에 데이터를 넣을 때 쓰는 Method
     * 
     * String 문자가 2000 이상일때와 이하일때 구분함
     *
     * @ author : hslim
     * @ E-mail : 
     *
     */
    public static void setLong(java.sql.PreparedStatement pstmt, int columIndex, String en) throws SQLException{
        if(en == null){
            pstmt.setNull(columIndex, Types.VARCHAR);
        }else{
            // 오라클일때
            StringReader sr = new StringReader(en);
            pstmt.setCharacterStream(columIndex, sr, en.length());
            // sr.close(); --> 이놈 넣으면 죽어버림
            
    	    // MS-SQL 에서는 그냥 입력해도 됨
            // pstmt.setString(columIndex, en);
        }
    }
    
    
    
    
    /**
     *  문자를 잘라서 여러  3 개 의 Column 에 저장한다.
     * 
     * @ author : hslim
     * @ E-mail : 
     * 
     */
    public static void setThreeColumn(java.sql.PreparedStatement pstmt, int startColumIndex, String en) throws SQLException{
        
        String content01 = "";
		String content02 = "";
		String content03 = "";
        
         if(en.length() <= 2000){
	         content01 = en.substring(0, en.length());
	     }
	     else if(en.length() <= 4000){
	        content01 = en.substring(0, 2000);
            content02 = en.substring(2000,en.length());

	     }else if(en.length() <= 6000){
	         content01 = en.substring(0, 2000);
             content02 = en.substring(2000, 4000);
             content03 = en.substring(4000, en.length());
	     }else{
	         content01 = en.substring(0, 2000);
             content02 = en.substring(2000, 4000);
             content03 = en.substring(4000, 6000);
	     }
	     System.out.println("content.length ==>"+en.length()+"\n");
	     //System.out.println("content ==>"+en+"\n");
	     System.out.println("content01==>"+content01+"\n");
	     System.out.println("content02==>"+content02+"\n");
	     System.out.println("content03==>"+content03+"\n");
	     
	     
	     System.out.println("content01.length()==>"+content01.length()+"\n");
	     System.out.println("content02.length()==>"+content02.length()+"\n");
	     System.out.println("content03.length()==>"+content03.length()+"\n");
	     
	     setCharString(pstmt, startColumIndex, content01);
	     setCharString(pstmt, startColumIndex+1, content02);
	     setCharString(pstmt, startColumIndex+2, content03);
 
    }
    
    
    
    
    
    
    /**
     * Varchar2(4000)에 데이터를 넣을 때 쓰는 Method
     * 
     * String 문자가 2000 이상일때와 이하일때 구분함
     *
     * @ author : hslim
     * @ E-mail : 
     *
     */
    public static void setLongRow(java.sql.PreparedStatement pstmt, int columIndex, String en) throws SQLException{
      
        if(en == null){
            pstmt.setNull(columIndex, Types.VARCHAR);
        }
        else if(en.length()<2000)
        {
            pstmt.setString(columIndex , en);
            ////System.out.println("ps.setString()");
        }
        else
        {
            Reader bis = new StringReader(en);
            pstmt.setCharacterStream(columIndex, bis, en.length());
        }
    
        
       
  
        
        
        
        
       
    }
    
    /**
     * 가나다 검색시 조건문을 만들어 주는 메소드 
     * 
     * @ author : 심재진
     * @ E-mail : sim11@miraenet.com
     * 
     */
    public static String getIndexWhere(String columnName, int index){
        String [] item = {"가","나","다","라","마","바","사","아","자","차","카","타","파","하"};
        // String [] itemName = {"ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"};
        int len = item.length;
        String where = null;
        for(int i=0; i<len; i++){
            if(i == index){
                if(i == len-1){
                    where = columnName + ">='" + item[i] +"'";                
                }else{
                    where = columnName + ">='" + item[i] +"' and "+ columnName + "<'" + item[i+1] +"'";
                }
                break;
            }   
        }
        return where;
    }


    /**
    * 오라클에서 order by가 들어갔을 경우 해당 개수만큼의 row를 얻기 위한 sql query<br>
    * Inserted by Jeonghwa, Kim
    * 사용 : 얻기 위한 field list(select list 만)와 from 절 이후의 qeury를 분리해서 넣어주어야   
    */
    public static  String getListQuery(int page, int max, String field_list1, String field_list2, String subquery)
    {  
        String query ="select "+field_list1+" from (  select "+field_list1+", rownum as row_number from ( select "+field_list2+subquery+" ) )";
        query=query+  getBetweenClause(page, max);
        return query;
    }
    /**
    * 해당 개수만큼의 row를 얻기 위한 between clause<br>
    * Inserted by Jeonghwa, Kim
    */
    public static String getBetweenClause(int page, int max)
    {
            String betweenClause = " where row_number between ";
            int absolutepage=(page-1) * max; // 찾아갈 로우의 위치 
            betweenClause = betweenClause+(absolutepage+1)+" and "+(absolutepage+max);
            return betweenClause;
    }
}

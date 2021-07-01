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
     * Long Raw �� �޾ƿ���
     *
     * @ author : ������ 
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
     * Long Raw �� �޾ƿ���
     *
     * @ author : ������ 
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
     * Long Raw �� �Է��ϱ�
     *
     * @ author : ������ 
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
         * Long Raw �� �Է��ϱ�
         *
         * @ author : ������
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
     * PreparedStatment �� �����͸� ���ε��� null ���� ���� ��� null�� ���ε��ϴ� �޼ҵ�
     *
     * @ author : ������ 
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
     * Varchar2(4000)�� �����͸� ���� �� ���� Method
     *
     * @ author : ��ö�� 
     * @ E-mail : cwjung@miraenet.com
     *
     */
    public static void setCharString(java.sql.PreparedStatement pstmt, int columIndex, String en) throws SQLException{
        if(en == null){
            pstmt.setNull(columIndex, Types.VARCHAR);
        }else{
            // ����Ŭ�϶�
            StringReader sr = new StringReader(en);
            pstmt.setCharacterStream(columIndex, sr, en.length());
            // sr.close(); --> �̳� ������ �׾����
            
    	    // MS-SQL ������ �׳� �Է��ص� ��
            // pstmt.setString(columIndex, en);
        }
    }
    
    
    /**
     * Varchar2(4000)�� �����͸� ���� �� ���� Method
     * 
     * String ���ڰ� 2000 �̻��϶��� �����϶� ������
     *
     * @ author : hslim
     * @ E-mail : 
     *
     */
    public static void setLong(java.sql.PreparedStatement pstmt, int columIndex, String en) throws SQLException{
        if(en == null){
            pstmt.setNull(columIndex, Types.VARCHAR);
        }else{
            // ����Ŭ�϶�
            StringReader sr = new StringReader(en);
            pstmt.setCharacterStream(columIndex, sr, en.length());
            // sr.close(); --> �̳� ������ �׾����
            
    	    // MS-SQL ������ �׳� �Է��ص� ��
            // pstmt.setString(columIndex, en);
        }
    }
    
    
    
    
    /**
     *  ���ڸ� �߶� ����  3 �� �� Column �� �����Ѵ�.
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
     * Varchar2(4000)�� �����͸� ���� �� ���� Method
     * 
     * String ���ڰ� 2000 �̻��϶��� �����϶� ������
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
     * ������ �˻��� ���ǹ��� ����� �ִ� �޼ҵ� 
     * 
     * @ author : ������
     * @ E-mail : sim11@miraenet.com
     * 
     */
    public static String getIndexWhere(String columnName, int index){
        String [] item = {"��","��","��","��","��","��","��","��","��","��","ī","Ÿ","��","��"};
        // String [] itemName = {"��","��","��","��","��","��","��","��","��","��","��","��","��","��"};
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
    * ����Ŭ���� order by�� ���� ��� �ش� ������ŭ�� row�� ��� ���� sql query<br>
    * Inserted by Jeonghwa, Kim
    * ��� : ��� ���� field list(select list ��)�� from �� ������ qeury�� �и��ؼ� �־��־��   
    */
    public static  String getListQuery(int page, int max, String field_list1, String field_list2, String subquery)
    {  
        String query ="select "+field_list1+" from (  select "+field_list1+", rownum as row_number from ( select "+field_list2+subquery+" ) )";
        query=query+  getBetweenClause(page, max);
        return query;
    }
    /**
    * �ش� ������ŭ�� row�� ��� ���� between clause<br>
    * Inserted by Jeonghwa, Kim
    */
    public static String getBetweenClause(int page, int max)
    {
            String betweenClause = " where row_number between ";
            int absolutepage=(page-1) * max; // ã�ư� �ο��� ��ġ 
            betweenClause = betweenClause+(absolutepage+1)+" and "+(absolutepage+max);
            return betweenClause;
    }
}

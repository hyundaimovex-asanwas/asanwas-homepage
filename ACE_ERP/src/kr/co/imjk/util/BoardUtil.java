/*
 * Author(s) Park Sang Bae 
 * Date: 2003.12.22
 */
package kr.co.imjk.util; 

import java.util.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.lib.exception.DbException;

public class BoardUtil extends DAOHome{
 
    private static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
    private static SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss"); 
    private static java.util.Date today = new java.util.Date();


    public String  getVirtualFileName() throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        String rtnValue = "";

        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT LPAD(VIRTUAL_FILE_NAME_SEQ.NEXTVAL, 10, '0') FROM DUAL ");


	     
        System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = rs.getString(1);
	            }
	             
	            rs.close();
	            pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{ 
            release(pstmt);
            freeConnection(dbconn);
        }
        System.out.println("rtnValue  --  => \n"+rtnValue);
        return rtnValue;
    }  
    
     

    public int  updateRecomm(int board_seq) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        int exe = 0;
        
        StringBuffer sql = new StringBuffer();
        sql.append(" UPDATE TBRD_BOARD_MA SET RECOMM_NUM = RECOMM_NUM+1 WHERE BOARD_SEQ = ?  ");

        //System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           pstmt.setInt(1, board_seq);
	           exe = pstmt.executeUpdate();
	            
	           pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{ 
            release(pstmt);
            freeConnection(dbconn);
        }

        return exe;
    }  
    
    /**
     * 게시물 삭제<p>    
     */  
    public  int delList(String seqList) 
        throws DbException , Exception 
    {
        System.out.println("seqList => \n"+seqList);
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
       
        // SQL
        String sql = new StringBuffer()
           .append("DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ IN ("+seqList+") ").toString();
        int exe = 0;
        System.out.println("getTotalCount  --  query  => \n"+sql);
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩
            //pstmt.setString(1,seqList);
            exe = pstmt.executeUpdate();
            System.out.println("seqList => \n"+seqList);
            pstmt.close();
            dbconn.commit();
        } catch (SQLException e) {
            // Rollback
            rollback(dbconn);
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return exe ;
    }  
    

    
    /** 
     * 게시물 읽은 횟수 증가<p>
     */
    public  int updateReadnum(int board_seq) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append(" UPDATE TBRD_BOARD_MA set READ_NUM=READ_NUM+1 ")
           .append(" WHERE  BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩            

            pstmt.setInt(1, board_seq);
            
            exe = pstmt.executeUpdate();
            pstmt.close();
            dbconn.commit();
        } catch (SQLException e) {
            // Rollback
            rollback(dbconn);
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return exe ;
    }
    
    
    public static String getNewArticle(String writeday,String contextRoot){
        String nowdate	= "";
		String newImg	= "";
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
		java.util.Date currentTime = new java.util.Date(); 
		nowdate = formatter.format(currentTime); 

        //nowdate = formatter.format(today);
        //wrtday  = formatter.format(writeday);
        if (nowdate.equals(writeday)) {
			newImg = "<img src='"+contextRoot+"admin/a_new.gif' align='absmiddle' border='0'>" ;
		}
		/*
		if (today.getTime()-writeday.getTime() < (1000*60*60*24*1)){
            newImg = "<img src='"+contextRoot+"/br_img/a_new.gif' align='absmiddle' border='0'>" ;
        }
		*/
        return newImg;
    }  
    
    public static String getNewArticle(java.util.Date writeday,String contextRoot){
        String newImg=""; 		
        if (today.getTime()-writeday.getTime() < (1000*60*60*24*2)){
            newImg = "<img src='"+contextRoot+"imjk_img/a_new.gif' align='absmiddle' border='0'>" ;
        }
        return newImg;
    }  
	
	/*
    public static String getReImg(int level,int t,String contextRoot) {
        int wid = t*level;
        return (level > 0)? "<img src='"+contextRoot+"/kBoard/images/sp.gif' width="+wid+" height='5' border=0><img src='"+contextRoot+"/kBoard/images/re.gif' border=0>" : "";
    }
	*/

	public static String getReImg(int level,int sort,String contextRoot) {
        StringBuffer sb = new StringBuffer();
		if(level > 0){
			for(int i=0; i<level*2 ; i++){				
				sb.append("&nbsp;");
			}
		}

		if(sort > 0){
			sb.append("<img src='"+contextRoot+"/imjk_img/a_reply.gif' align='absmiddle' border='0'>");
		}		
        return (level > 0)? sb.toString() : "";
    }

	public static String getReImg(String phone_yn, int level,String contextRoot) {
        StringBuffer sb = new StringBuffer();
		if(level > 0){
			for(int i=0; i<level*2 ; i++){				
				sb.append("&nbsp;");
			}
			sb.append("<img src='"+contextRoot+"admin/a_reply.gif' align='absmiddle' border='0'>");

			if(phone_yn.equals("Y")){
				sb.append("&nbsp;");
				sb.append("[전화]");
			}
		}		
        return (level > 0)? sb.toString() : "";
    }
	
	/*
    public static String getNum(int level,int ref) {
        return (level > 0)? "&nbsp;" : Integer.toString(ref);
    }
	*/

	public static int getNum(int recordCount,int gotoPage,int pageSize,int a) {
		int num = recordCount-(gotoPage-1)*pageSize-(a-1);
		return num;
	}

    public static String getEmailnName(String email,String name) {
        return (email == "")? name:"<a href='mailto:"+email+"'>"+name+"</a>";
    }

    public static String getDateFormat(java.util.Date writeday){
        String wrtday  = "";
        String nowdate = "";
        nowdate = formatter.format(today);
        wrtday  = formatter.format(writeday);
        if (nowdate.equals(wrtday)) {
            wrtday = formatter2.format(writeday);
        } 
        return wrtday;
    }

	public static String getView(String view_yn,String contextRoot){
		StringBuffer sb = new StringBuffer();
		sb.append("&nbsp;");
		if(view_yn.equals("Y")){
			sb.append("<img src='/br_img/a_end.gif' align='absmiddle' width='19' height='17' border='0'>");
		}else{
			sb.append("<img src='/br_img/a_ing.gif' align='absmiddle' width='19' height='17' border='0'>");
		}

		return sb.toString();
	}
}
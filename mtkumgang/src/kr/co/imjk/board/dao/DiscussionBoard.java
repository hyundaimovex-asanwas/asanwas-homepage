/*
 * Created on 2006. 4. 19.
 * 
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.util.Util;
import kr.co.imjk.board.bean.Tbrd_attach_file_de_bean;
import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.board.bean.Tbrd_comment_de_bean;
/** 
 * @author 임형수
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DiscussionBoard  extends DAOHome{

     
    /**
     * 토론형 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수 
     */
	public int  getTotalCount(String part, String keyword) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        int rtnValue = 0;
        if(!keyword.equals("")){
            if(part.equals("2")){
                tempPart = "CONTENT";
            }else{
                tempPart = "TITLE";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }	 
        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT count(*) from TBRD_BOARD_MA ");
        sql.append(" WHERE BOARD_TYPE='11' ");
        sql.append(subSql);
	    
       // //System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{ 
	           pstmt = dbconn.prepareStatement(sql.toString());
	           
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = rs.getInt(1);
	            }
	             
	            rs.close();
	            pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        
        return rtnValue;
    }  
    
	 /**  
     * 토론형  게시판 진행이 기간이 지난 게시물의 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수
     */
    
	 public int getExpireTotalCount( String part, String keyword,
			   String from_date, String to_date) throws  Exception{
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	        StringBuffer query = null;
	        StringBuffer sql = null;
	        StringBuffer subSql = new StringBuffer();
	        String tempPart = "";
	        int rtnValue = 0;
	        
	        if(!keyword.equals("")){
				if(part.equals("1")){
					subSql.append(" AND TITLE LIKE '%"+keyword+"%' \n");
				}else{
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					subSql.append(" AND CONTENT LIKE '%"+keyword+"%' \n");
				}  
	        }	
	        


	       //      SQL  
	         sql = new StringBuffer();
	            sql.append(" SELECT  \n");
	            sql.append(" COUNT(*)   \n");
	            sql.append(" FROM TBRD_BOARD_MA   \n");
				sql.append(" WHERE BOARD_TYPE = '11' AND  NVL(FROM_DATE,' ') <> ' ' \n");
	            sql.append(subSql.toString());
	            sql.append(" AND ( 1 < CASE WHEN  TO_DATE(TO_DATE,'YYYY-MM-DD') >= TO_DATE(?,'YYYY-MM-DD') AND  TO_DATE(TO_DATE,'YYYY-MM-DD') <= TO_DATE(?,'YYYY-MM-DD') THEN 2 END  \n");
		        sql.append("  OR 1 < CASE WHEN  TO_DATE(FROM_DATE,'YYYY-MM-DD') >= TO_DATE(?,'YYYY-MM-DD') AND  TO_DATE(FROM_DATE,'YYYY-MM-DD') <= TO_DATE(?,'YYYY-MM-DD') THEN 2 END )  \n");
	            sql.append(" ORDER BY REG_DATE DESC  \n"); 
	        
	         
	        
	  
	         
	        System.out.println("^^  sql  => \n"+sql);
		
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	            // 변수 바인딩
	            pstmt.setString(1, from_date);
	            pstmt.setString(2, to_date);
	            pstmt.setString(3, from_date);
	            pstmt.setString(4, to_date);
                rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = rs.getInt(1);
	            }
	             
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return rtnValue;

	        
	    }
	  
	  
    /**
     * 꼬리말의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return rtnValue int  꼬리말의 전체 총 갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	public int  getCommentTotalCount(String part, String keyword, int board_seq) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        int rtnValue = 0;
        if(!keyword.equals("")){
            if(part.equals("2")){
                tempPart = "CONTENT";
            }else{
                tempPart = "TITLE";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }	 
        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT count(*) from TBRD_COMMENT_DE ");
        sql.append(" WHERE BOARD_SEQ= ? ");
        sql.append(subSql);
	    
       // System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{ 
	           pstmt = dbconn.prepareStatement(sql.toString());
	           pstmt.setInt(1, board_seq);
	           rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = rs.getInt(1);
	            }
	             
	            rs.close();
	            pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        
        return rtnValue;
    }  
	
	 /**
     * 의견의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return rtnValue int  꼬리말의 전체 총 갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	public int  getOpinionTotalCount(String part, String keyword, int ref_no) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        int rtnValue = 0;
        if(!keyword.equals("")){
            if(part.equals("2")){
                tempPart = "CONTENT";
            }else{
                tempPart = "TITLE";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }	 
        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT count(*) from TBRD_BOARD_MA ");
        sql.append(" WHERE BOARD_TYPE ='11' AND REF_NO= ? AND TO_DATE IS NULL ");
        sql.append(subSql);
	    
       // System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{ 
	           pstmt = dbconn.prepareStatement(sql.toString());
	           pstmt.setInt(1, ref_no);
	           rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = rs.getInt(1);
	            }
	             
	            rs.close();
	            pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        
        return rtnValue;
    }  
    /**  
     * 토론형  게시판 진행이 기간이 지난 게시물의 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수
     */
	 public Tbrd_board_ma_bean[] getExpireList(int rowsPerPage, int requestedPage, String part, String keyword,
			   String from_date, String to_date) throws  Exception{
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
		 System.out.println("getList () from_date:"+from_date+"/to_date:"+to_date);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	        StringBuffer query = null;
	        StringBuffer sql = null;
	        StringBuffer subSql = new StringBuffer();
	        String tempPart = "";
	        
	        
	        if(!keyword.equals("")){
				if(part.equals("1")){
					subSql.append(" AND TITLE LIKE '%"+keyword+"%' \n");
				}else{
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					subSql.append(" AND CONTENT LIKE '%"+keyword+"%' \n");
				}  
	        }	
	        


	       //      SQL  
	         sql = new StringBuffer();
	            sql.append(" SELECT  \n");
	            sql.append(" BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
	            sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,     \n");
	            sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM, FROM_DATE, TO_DATE      \n");
	            sql.append(" FROM TBRD_BOARD_MA   \n");
				sql.append(" WHERE BOARD_TYPE = '11' AND  NVL(FROM_DATE,' ') <> ' ' \n");
				sql.append(" AND ( 1 < CASE WHEN  TO_DATE(TO_DATE,'YYYY-MM-DD') >= TO_DATE(?,'YYYY-MM-DD') AND  TO_DATE(TO_DATE,'YYYY-MM-DD') <= TO_DATE(?,'YYYY-MM-DD') THEN 2 END  \n");
		        sql.append("  OR 1 < CASE WHEN  TO_DATE(FROM_DATE,'YYYY-MM-DD') >= TO_DATE(?,'YYYY-MM-DD') AND  TO_DATE(FROM_DATE,'YYYY-MM-DD') <= TO_DATE(?,'YYYY-MM-DD') THEN 2 END )  \n");
	            sql.append(subSql.toString());
	            sql.append(" ORDER BY REG_DATE DESC  \n"); 
	        
	         
	        // 페이징 처리
	        // JDBC 2.0 의 CURSOR 사용시 속도 저하. QUERY로 해결 
	            query = new StringBuffer();
	            query.append("\n select *  from \n");
	            query.append("(");
	            query.append(" select rownum as rownum_idx, inlineView.* from \n");
	            query.append(" ( \n");
	            query.append(sql.toString());
	            query.append(" )inlineView \n");
	            query.append(")where rownum_idx between ? and ? \n"); 
	  
	         
	        System.out.println("^^  query  => \n"+query);
		
	        try {         
	            pstmt = dbconn.prepareStatement(query.toString());
	            // 변수 바인딩
	            pstmt.setString(1, from_date.trim());
	            pstmt.setString(2, to_date.trim());
	            pstmt.setString(3, from_date.trim());
	            pstmt.setString(4, to_date.trim());
	            pstmt.setInt(5, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
	            pstmt.setInt(6, requestedPage * rowsPerPage); // 가져올 개수
	            System.out.println(" start :"+((requestedPage * rowsPerPage) - rowsPerPage) + 1 + "/end:"+requestedPage * rowsPerPage);
	            // 결과 담기
	            rs = pstmt.executeQuery();
	            System.out.println(" rs="+rs);
	            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
	            System.out.println(" list="+list);
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

	        
	    }
	  
	  
	    /**  
	     * 토론형 게시판의  현재 진행중인 게시물 목록
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     */
	    public Tbrd_board_ma_bean[] getNowList() 
	    throws  DbException , Exception {
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	 
	  
	       //      SQL  
 
	        StringBuffer sql = new StringBuffer();
			sql.append(" SELECT							");
	        sql.append(" MIN(A.BOARD_SEQ) BOARD_SEQ , MIN(A.TITLE) TITLE, MIN(A.CONTENT) CONTENT, 					");
			sql.append(" MIN(A.REG_DATE) REG_DATE , MIN(A.FROM_DATE) FROM_DATE, MIN(A.TO_DATE) TO_DATE , 			");
			sql.append(" COUNT(B.BOARD_SEQ)-1 TOTAL_COUNT , MIN(A.REF_NO)	REF_NO						");
			sql.append(" FROM (								");
			sql.append("     SELECT   BOARD_SEQ ,REF_NO, TITLE, CONTENT, READ_NUM,			");
			sql.append("         REG_DATE ,RECOMM_NUM, FROM_DATE, TO_DATE 													");
			sql.append("     FROM  TBRD_BOARD_MA A 	 				");
			sql.append("     WHERE    BOARD_TYPE ='11'				");
			sql.append("     AND SYSDATE  BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')							");
			sql.append(" ) A, TBRD_BOARD_MA B		");
			sql.append(" WHERE A.BOARD_SEQ = B.REF_NO(+)   				");
			sql.append(" GROUP BY A.BOARD_SEQ    			");
			
 

	        //System.out.println("getList  --  query  => \n"+sql);
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	           
	            // 결과 담기
	            rs = pstmt.executeQuery();
	            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
	           
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

	        
	    }
	    
	    /**  
	     * 토론형 게시판의  토론 주제 게시물 
	     * @param board_seq  
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     */
	    public Tbrd_board_ma_bean[] getDiscussionView(int board_seq) 
	    throws  DbException , Exception {
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	 
	  
	       //      SQL  
 
	        StringBuffer sql = new StringBuffer();
			sql.append(" SELECT							");
	        sql.append(" MIN(A.BOARD_SEQ) BOARD_SEQ , MIN(A.TITLE) TITLE, MIN(A.CONTENT) CONTENT, 					");
			sql.append(" MIN(A.REG_DATE) REG_DATE , MIN(A.FROM_DATE) FROM_DATE, MIN(A.TO_DATE) TO_DATE , 			");
			sql.append(" COUNT(B.BOARD_SEQ)-1 TOTAL_COUNT , MIN(A.REF_NO)	REF_NO						");
			sql.append(" FROM (								");
			sql.append("     SELECT   BOARD_SEQ ,REF_NO, TITLE, CONTENT, READ_NUM,			");
			sql.append("         REG_DATE ,RECOMM_NUM, FROM_DATE, TO_DATE 													");
			sql.append("     FROM  TBRD_BOARD_MA A 	 				");
			sql.append("     WHERE    BOARD_TYPE ='11' 				");
			sql.append("     AND BOARD_SEQ = ?						");
			sql.append(" ) A, TBRD_BOARD_MA B		");
			sql.append(" WHERE A.BOARD_SEQ = B.REF_NO    AND  NVL(B.FROM_DATE,' ') <> ' ' 				");
			sql.append(" GROUP BY A.BOARD_SEQ    			");
			
		

	        System.out.println("getList  --  query  => \n"+sql);
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	            pstmt.setInt(1, board_seq);
	            // 결과 담기
	            rs = pstmt.executeQuery();
	            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
	           
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

	        
	    }
  
	    
	  
	    
	    /**  
	     * 토론형 게시판의  의견 리스트
	     * @param rowsPerPage 페이지별 row 수 
	     * @param requestedPage 호출 페이지 번호
	     * @param part 검색할 디비컬럼
	     * @param keyword 검색한 단어
	     * @param ref_no 관련글 번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @author 임형수
	     */
	    
      
		 public Tbrd_board_ma_bean[] getOpinionList(int rowsPerPage, int requestedPage, 
		         String part, String keyword, int ref_no) throws  Exception{
		        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
		        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
		         
		        
		        Connection dbconn = getConnection();
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        Tbrd_board_ma_bean bean = null;
		        Collection list = null; 
		        String query = "";
		        String subSql =" ";
		        String tempPart = "";
		        
		        
		        if(!keyword.equals("")){
					if(part.equals("1")){
						subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
					}else{
						//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
						subSql = " AND CONTENT LIKE '%"+keyword+"%' \n";
					}
		            
		        }	 

		       //      SQL  
		        
		        StringBuffer sql = new StringBuffer();
				sql.append(" SELECT							");
				sql.append("   BOARD_SEQ ,TITLE , CONTENT , REG_DATE ,				");
				sql.append("   RECOMM_NUM, FROM_DATE, TO_DATE , READ_NUM ,		");
				sql.append("   USER_ID , USER_NICK, USE_YN , REF_NO		");
				sql.append(" FROM  TBRD_BOARD_MA A							");
				sql.append(" WHERE    BOARD_TYPE ='11'  			");
				sql.append("   AND 	REF_NO= ? AND  NVL(A.FROM_DATE,' ') = ' ' 	  	");
				sql.append(subSql);
				sql.append("   ORDER BY REG_DATE  DESC 	");
		        
				//System.out.println("getList  --  query  => \n"+query);
		        // 페이징 처리
		        // JDBC 2.0 의 CURSOR 사용시 속도 저하. QUERY로 해결 
		        query = new StringBuffer()
		            .append("\n select *  from \n")
		            .append("(")
		            .append(" select rownum as rownum_idx, inlineView.* from \n")
		            .append(" ( \n")
		            .append(sql)
		            .append(" )inlineView \n")
		            .append(")where rownum_idx between ? and ? \n").toString(); 
		  
		         
		        //System.out.println("getList  --  query  => \n"+query);
			
		        try {         
		            pstmt = dbconn.prepareStatement(query);
		            // 변수 바인딩
		            pstmt.setInt(1, ref_no); 
		            pstmt.setInt(2, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
		            pstmt.setInt(3, requestedPage * rowsPerPage); // 가져올 개수
		            //System.out.println(" start :"+((requestedPage * rowsPerPage) - rowsPerPage) + 1 + "/end:"+requestedPage * rowsPerPage);
		            // 결과 담기
		            rs = pstmt.executeQuery();
		            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
		           
		            rs.close();
		            pstmt.close();
		        } catch (SQLException e) {
		            throw new DbException(e.getMessage());
		        }finally{
		            release(pstmt);
		            freeConnection(dbconn);
		        }
		        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

		        
		    }
	   

	    /**  
	     * 토론형 게시판의  마감된 게시물과  이전,이후 게시물의 목록
	     * @param board_seq 메인 게시판 일련번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     */
	    public Tbrd_board_ma_bean[] getExpirePrevAndNextBoard(int board_seq ) 
	    throws  DbException , Exception {
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	 
	 
	       //      SQL  
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
			sql.append("   TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE				");
			sql.append(" FROM  TBRD_BOARD_MA								");
			sql.append(" WHERE BOARD_TYPE ='11' and BOARD_SEQ = ?			");
			sql.append(" AND SYSDATE NOT BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')			");
			sql.append(" UNION ALL												");
			sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,				");
			sql.append("   TITLE , CONTENT , READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE				");
			sql.append(" FROM TBRD_BOARD_MA 								");
			sql.append(" WHERE BOARD_SEQ = (			");
			sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
			sql.append("     FROM TBRD_BOARD_MA 			");
			sql.append("     WHERE BOARD_TYPE ='11' AND  BOARD_SEQ > ?		");
			sql.append("     AND SYSDATE NOT BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')			");
			sql.append(" )	UNION ALL		");		
			sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,			");
			sql.append("   TITLE , CONTENT , READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE				");
			sql.append(" FROM TBRD_BOARD_MA 								");
			sql.append(" WHERE BOARD_SEQ = (			");
			sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
			sql.append("     FROM TBRD_BOARD_MA 			");
			sql.append("     WHERE BOARD_TYPE ='11' AND  BOARD_SEQ < ?		");
			sql.append("     AND SYSDATE NOT BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')			");
			sql.append(" )		");	 


	        //System.out.println("getList  --  query  => \n"+sql);
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	            // 변수 바인딩
	            pstmt.setInt(1, board_seq);  
	            pstmt.setInt(2, board_seq);  
	            pstmt.setInt(3, board_seq);  
	           
	            // 결과 담기
	            rs = pstmt.executeQuery();
	            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
	           
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

	        
	    }
	    

	    /**  
	     * 토론형 게시판의  마감된 게시물과  이전,이후 게시물의 목록
	     * @param board_seq 메인 게시판 일련번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     */
	    public Tbrd_board_ma_bean[] getPrevAndNextBoard(int board_seq, int ref_no ) 
	    throws  DbException , Exception {
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	        
	   	 
	       //      SQL  
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
			sql.append("   TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE ,REF_NO , USER_ID				");
			sql.append(" FROM  TBRD_BOARD_MA							");
			sql.append(" WHERE BOARD_TYPE ='11' and BOARD_SEQ = ?	 			");
			sql.append("     AND REF_NO = ?	 AND  NVL(FROM_DATE,' ') = ' ' 		 			");
			sql.append(" UNION ALL												");
			sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,				");
			sql.append("   TITLE , CONTENT , READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE ,REF_NO	, USER_ID				");
			sql.append(" FROM TBRD_BOARD_MA 								");
			sql.append(" WHERE BOARD_SEQ = (			");
			sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
			sql.append("     FROM TBRD_BOARD_MA 			");
			sql.append("     WHERE BOARD_TYPE ='11' AND  BOARD_SEQ > ?		");
			sql.append("       AND REF_NO = ?	 AND  NVL(FROM_DATE,' ') = ' ' 	");
			sql.append(" )	UNION ALL		");		
			sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,			");
			sql.append("   TITLE , CONTENT , READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE ,REF_NO	, USER_ID				");
			sql.append(" FROM TBRD_BOARD_MA 								");
			sql.append(" WHERE BOARD_SEQ = (			");
			sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
			sql.append("     FROM TBRD_BOARD_MA 			");
			sql.append("     WHERE BOARD_TYPE ='11' AND  BOARD_SEQ < ?		");
			sql.append("       AND REF_NO = ?	 AND  NVL(FROM_DATE,' ') = ' ' 		");
			sql.append(" )		");	 


	        //System.out.println("getList  --  query  => \n"+sql);
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	            // 변수 바인딩
	            pstmt.setInt(1, board_seq);  
	            pstmt.setInt(2, ref_no); 
	            pstmt.setInt(3, board_seq); 
	            pstmt.setInt(4, ref_no); 
	            pstmt.setInt(5, board_seq); 
	            pstmt.setInt(6, ref_no); 
	           
	            // 결과 담기
	            rs = pstmt.executeQuery();
	            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
	           
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

	        
	    }
	    

	    /**  
	     * 토론형 게시판의  진행중인 게시물과  이전,이후 게시물의 목록
	     * @param board_seq 메인 게시판 일련번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     */
	    public Tbrd_board_ma_bean[] getNowPrevAndNextBoard(int board_seq ) 
	    throws  DbException , Exception {
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	 
	 
	       //      SQL  
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
	        sql.append("   TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE				");
			sql.append(" FROM  TBRD_BOARD_MA								");
			sql.append(" WHERE BOARD_TYPE ='11' and BOARD_SEQ = ?			");
			sql.append(" AND SYSDATE  BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')			");
			sql.append(" UNION ALL												");
			sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,				");
			sql.append("   TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE				");
			sql.append(" FROM TBRD_BOARD_MA 								");
			sql.append(" WHERE BOARD_SEQ = (			");
			sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
			sql.append("     FROM TBRD_BOARD_MA 			");
			sql.append("     WHERE BOARD_TYPE ='11' AND  BOARD_SEQ > ?		");
			sql.append("     AND SYSDATE  BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')			");
			sql.append(" )	UNION ALL		");		
			sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,				");
			sql.append("   TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,			");
			sql.append("   FROM_DATE, TO_DATE				");
			sql.append(" FROM TBRD_BOARD_MA 								");
			sql.append(" WHERE BOARD_SEQ = (			");
			sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
			sql.append("     FROM TBRD_BOARD_MA 			");
			sql.append("     WHERE BOARD_TYPE ='11' AND  BOARD_SEQ < ?		");
			sql.append("     AND SYSDATE  BETWEEN TO_DATE(FROM_DATE,'YYYY-MM-DD') AND TO_DATE(TO_DATE,'YYYY-MM-DD')			");
			sql.append(" )		");	 


	        //System.out.println("getList  --  query  => \n"+sql);
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	            // 변수 바인딩
	            pstmt.setInt(1, board_seq);  
	            pstmt.setInt(2, board_seq);  
	            pstmt.setInt(3, board_seq);  
	           
	            // 결과 담기
	            rs = pstmt.executeQuery();
	            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
	           
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

	        
	    }
	    	    
    /**  
     * 꼬리말 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수
     */
    public Tbrd_comment_de_bean[] getCommentList(int rowsPerPage, int requestedPage, String part,
                 String keyword, int board_seq )  throws  DbException , Exception {
        //System.out.println("!getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
         
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        String subSql =" ";
        String tempPart = "";
        

       //      SQL  
        StringBuffer sql = new StringBuffer();
		sql.append(" SELECT   \n");
		sql.append(" BOARD_SEQ, COMMENT_SEQ, USER_ID, USER_NICK ,    \n");
		sql.append(" CONTENT, STAR_NUM , REG_DATE   \n");
		sql.append(" FROM TBRD_COMMENT_DE  \n");
		sql.append(" WHERE BOARD_SEQ=?  \n");
		sql.append(" ORDER BY  REG_DATE DESC  \n"); 
		         
         
        // 페이징 처리
        // JDBC 2.0 의 CURSOR 사용시 속도 저하. QUERY로 해결 
		StringBuffer query = new StringBuffer();
			query.append("\n select  *   from \n");
			query.append("(");
			query.append(" select rownum as rownum_idx, inlineView.* from \n");
			query.append(" ( \n");
			query.append(sql);
			query.append(" )inlineView \n");
			query.append(")where rownum_idx between ? and ? \n"); 
  
        
        //System.out.println("getList  --  query  => \n"+query);
        try {         
            pstmt = dbconn.prepareStatement(query.toString());
            // 변수 바인딩
            pstmt.setInt(1, board_seq);
            pstmt.setInt(2, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
            pstmt.setInt(3, requestedPage * rowsPerPage); // 가져올 개수
            //System.out.println(" start :"+((requestedPage * rowsPerPage) - rowsPerPage) + 1 + "/end:"+requestedPage * rowsPerPage);
            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Tbrd_comment_de_bean());
           
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Tbrd_comment_de_bean [])list.toArray(new Tbrd_comment_de_bean[0]);

        
    }
   
    /**
     * 꼬리말 등록 
     * @param bean Tbrd_comment_de_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
    public int insertComment(Tbrd_comment_de_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        ResultSet rs = null;



        // SQL 
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO TBRD_COMMENT_DE  ");
        sql.append("     (COMMENT_SEQ, USER_ID, USER_NICK, REG_DATE,  ");
        sql.append("     CONTENT,   BOARD_SEQ )  ");
        sql.append(" VALUES (TBRD_COMMENT_DE_SEQ.NEXTVAL , ? , ?, SYSDATE,  ");
        sql.append("     ?, ?  )");
        
 
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setString(1, bean.getUser_id());
            pstmt.setString(2, bean.getUser_nick());
            pstmt.setString(3, bean.getContent());
            pstmt.setInt(4, bean.getBoard_seq());
           
          
            exe = pstmt.executeUpdate();
            pstmt.close();
            dbconn.commit();
             
            dbconn.commit();
        } catch (SQLException e) {
            // Rollback
            rollback(dbconn);
            e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return exe;
    }
  
    
    
  
     
    /**
     *  꼬리글  삭제 
     * @param board_seq 메인 게시판 일련번호
     * @param comment_seq 꼬리글 일련번호
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */ 
    public  int deleteComment(int board_seq, int comment_seq) 
        throws DbException , Exception 
    {    //System.out.println("board_seq=="+board_seq);
         //System.out.println("comment_seq=="+comment_seq);
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append("DELETE FROM TBRD_COMMENT_DE WHERE COMMENT_SEQ=?").toString();
        
        //System.out.println("sql=="+sql);
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩
            pstmt.setInt(1,comment_seq);
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
    
     
    /**
     * 게시물 읽은 횟수 증가 
     * @param board_seq 메인 게시판 일련번호
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
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
    
    
 
    /**
     * 주제 게시글 내용 등록 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
	public int insertDiscussion(Tbrd_board_ma_bean data) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int	result			= 0;
		int board_seq		= 0;
		 
		try {     

			dbconn.setAutoCommit(false);
			
			if(data != null){	
				String rtnValue = "";

				StringBuffer sql = new StringBuffer();
				sql.append(" SELECT TBRD_BOARD_MA_SEQ.NEXTVAL FROM DUAL ");
				pstmt = dbconn.prepareStatement(sql.toString());
	           
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = Util.getString(rs.getString(1),"");
	            }
				
				if(!rtnValue.equals("")){
					board_seq = Integer.parseInt(rtnValue);
				}


				pstmt.close();
				rs.close();

				String query = new StringBuffer()
				.append("  INSERT INTO TBRD_BOARD_MA   ")
				.append("  	(BOARD_SEQ, BOARD_TYPE, REF_NO, LEVEL_NO, SORT_NO, TITLE, CONTENT, USER_ID, USER_NAME,   ")
				.append("  	USER_NICK, USER_LEVEL, USER_ICON,  ")
				.append("  	FROM_DATE, TO_DATE, PASSWORD)   ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?, ?, ?, ?, ?, ?,   ")
				.append("  	?, ?, ?,   ")
				.append("  	? ,?, ?)   ").toString(); 
                System.out.println("query==>"+query+"\n");
				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,data.getBoard_type());
				pstmt.setInt(3,board_seq);					
				pstmt.setInt(4,data.getLevel_no());
				pstmt.setInt(5,data.getSort_no());
 
				pstmt.setString(6,data.getTitle());
				pstmt.setString(7,data.getContent());
				pstmt.setString(8,data.getUser_id());
				pstmt.setString(9,data.getUser_name());

				pstmt.setString(10,data.getUser_nick());
				pstmt.setString(11,data.getUser_level());
				pstmt.setString(12,data.getUser_icon());

				pstmt.setString(13,data.getFrom_date());
				pstmt.setString(14,data.getTo_date());
				pstmt.setString(15,data.getPassword());

				result = pstmt.executeUpdate();
			}

			
				dbconn.commit();
		

		} catch (SQLException e) {
        	e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return result;

	 }


    /**
     * 의견 게시글 내용 등록 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
	public int insertOpinion(Tbrd_board_ma_bean data) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int	result			= 0;
		int board_seq		= 0;
		
		try {     

			dbconn.setAutoCommit(false);
			
			if(data != null){	
				String rtnValue = "";

				StringBuffer sql = new StringBuffer();
				sql.append(" SELECT TBRD_BOARD_MA_SEQ.NEXTVAL FROM DUAL ");
				pstmt = dbconn.prepareStatement(sql.toString());
	           
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = Util.getString(rs.getString(1),"");
	            }
				
				if(!rtnValue.equals("")){
					board_seq = Integer.parseInt(rtnValue);
				}


				pstmt.close();
				rs.close();

				String query = new StringBuffer()
				.append("  INSERT INTO TBRD_BOARD_MA   ")
				.append("  	(BOARD_SEQ, BOARD_TYPE, REF_NO, LEVEL_NO, SORT_NO, TITLE, CONTENT, USER_ID, USER_NAME,   ")
				.append("  	USER_NICK, USER_LEVEL, USER_ICON,  ")
				.append("  	FROM_DATE, TO_DATE, PASSWORD)   ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?, ?, ?, ?, ?, ?,   ")
				.append("  	?, ?, ?,   ")
				.append("  	? ,?, ?)   ").toString(); 
                
				System.out.println("*query==>\n"+query+"\n");
				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,data.getBoard_type());
				pstmt.setInt(3,data.getRef_no());					
				pstmt.setInt(4,data.getLevel_no());
				pstmt.setInt(5,data.getSort_no());
 
				pstmt.setString(6,data.getTitle());
				pstmt.setString(7,data.getContent());
				pstmt.setString(8,data.getUser_id());
				pstmt.setString(9,data.getUser_name());

				pstmt.setString(10,data.getUser_nick());
				pstmt.setString(11,data.getUser_level());
				pstmt.setString(12,data.getUser_icon());

				pstmt.setString(13,data.getFrom_date());
				pstmt.setString(14,data.getTo_date());
				pstmt.setString(15,data.getPassword());

				result = pstmt.executeUpdate();
			}

			
				dbconn.commit();
		

		} catch (SQLException e) {
        	e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return result;

	 }

   
	
	 /**
     *  토론형 게시판  의견 내용 보기
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */ 
	public Tbrd_board_ma_bean[] getOpinionView(int board_seq) 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
 
        // SQL
        StringBuffer query = new StringBuffer();
            query.append(" SELECT	");												
			query.append(" BOARD_SEQ ,REF_NO, TITLE, CONTENT, READ_NUM, 		");
			query.append(" REG_DATE ,RECOMM_NUM, FROM_DATE, TO_DATE		");	
			query.append(" USER_ID , USER_NICK,USE_YN		");	
			query.append(" FROM TBRD_BOARD_MA						");								
			query.append(" WHERE BOARD_SEQ = ?			");
			//System.out.println("query=="+query);
        try {         
            pstmt = dbconn.prepareStatement(query.toString());
            // 변수 바인딩
            pstmt.setInt(1, board_seq); 

            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);
    }

	

    /**
     * 게시글 내용 수정 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	 public int updateDiscussion(Tbrd_board_ma_bean data) throws DbException , Exception {
			Connection dbconn = getConnection();	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result			= 0;
			int attach_result	= 0;
			
			try { 
				dbconn.setAutoCommit(false);

				if(data != null){
					String query = new StringBuffer()
					.append(" UPDATE TBRD_BOARD_MA			")
					.append(" SET TITLE=?,					")
					.append(" 	CONTENT=?,					")
					.append(" 	PASSWORD=?,					")
					.append(" 	FROM_DATE=?,					")
					.append(" 	TO_DATE=?					")
					.append(" WHERE BOARD_SEQ=?				").toString(); 
					System.out.println("query=="+query);
					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setString(1,data.getTitle());
					pstmt.setString(2,data.getContent());					
					pstmt.setString(3,data.getPassword());
					pstmt.setString(4,data.getFrom_date());
					pstmt.setString(5,data.getTo_date());
					pstmt.setInt(6,data.getBoard_seq());

					result = pstmt.executeUpdate();
					System.out.println("result=="+result);
					
					dbconn.commit();
					
					
				}

			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return result;
		 }
 
	
    /**
     * 게시글 내용 수정 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	 public int updateOpinion(Tbrd_board_ma_bean data) throws DbException , Exception {
			Connection dbconn = getConnection();	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result			= 0;
			int attach_result	= 0;
			
			try { 
				dbconn.setAutoCommit(false);

				if(data != null){
					String query = new StringBuffer()
					.append(" UPDATE TBRD_BOARD_MA			")
					.append(" SET TITLE=?,					")
					.append(" 	CONTENT=?,					")
					.append(" 	PASSWORD=?					")
					.append(" WHERE BOARD_SEQ=?				").toString(); 
					System.out.println("query=="+query);
					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setString(1,data.getTitle());
					pstmt.setString(2,data.getContent());					
					pstmt.setString(3,data.getPassword());
					pstmt.setInt(4,data.getBoard_seq());

					result = pstmt.executeUpdate();
					System.out.println("result=="+result);
					
					dbconn.commit();
					
					
				}

			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return result;
		 }
 
	
		 
		    /**
		     *  꼬리말 삭제 + 게시글 내용 삭제 
		     * @param board_seq 메인 게시판 일련번호
		     * @return exe int 1:성공 , 0:실패
		     * @throws DbException
		     * @throws Exception
		     */
		 public int delete(int board_seq) throws DbException , Exception {

			Connection dbconn = getConnection();	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result			= 0;
			int attach_result	= 0;
 
			String sql = "";

			try { 
				

				sql ="";
				sql =" DELETE FROM TBRD_COMMENT_DE WHERE BOARD_SEQ=? ";			
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setInt(1,board_seq);

				pstmt.executeUpdate();
				pstmt.close();

				
				
				result = deleteMaster(dbconn, board_seq);
				if(result > 0){					
						dbconn.commit();
				}else{
						dbconn.rollback();
				}
 

				pstmt.close();
				dbconn.commit();
			} catch (SQLException e) {
	        	e.printStackTrace();
	        	dbconn.rollback();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        
	        return result;

		 }

		 
		 /**
		  * 게시글 내용 삭제 
		  * @param dbconn 컨넥션 
		  * @param board_seq 메인 게시판 일련번호
		  * @return exe int 1:성공 , 0:실패
		  * @throws DbException
		  * @throws Exception
		  */
		 public int deleteMaster(Connection dbconn, int board_seq) throws DbException , Exception {
			PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result	= 0;

			StringBuffer sql = new StringBuffer();

			try { 
				sql.append(" DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ=? ");			
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				result = pstmt.executeUpdate();

				pstmt.close();
				
			} catch (SQLException e) {
	        	e.printStackTrace();
	        	dbconn.rollback();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	        }
	        return result;
		 }
		 

		    
		    /**
		     * 여러개의 코멘트 내용 삭제 + 여러개의 게시글 내용 삭제 
		     * @param board_seq 메인 게시판 일련번호
		     * @return exe int 1:성공 , 0:실패
		     * @throws DbException
		     * @throws Exception 
		     */
			 public int deleteMulti(String boardSeqList) throws DbException , Exception {

				Connection dbconn = getConnection();	
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;        
		       int result			= 0;
	

				String sql = "";

				try { 
					dbconn.setAutoCommit(false);
					//코멘트  내용 삭제
					sql =" DELETE FROM TBRD_COMMENT_DE WHERE BOARD_SEQ IN ("+boardSeqList+") ";				
					pstmt = dbconn.prepareStatement(sql);
					pstmt.executeUpdate();
					pstmt.close();
					
					
					//게시판 글 내용  삭제
					result = deleteMasterMulti(dbconn, boardSeqList);
					
					//System.out.println("게시판 글 내용  삭제 :"+result);
					if(result > 0){					
							dbconn.commit();
					}else{
							dbconn.rollback();
					}

	 
					pstmt.close();
					dbconn.commit();
				} catch (SQLException e) {
		       	e.printStackTrace();
		       	dbconn.rollback();
		           throw new DbException(e.getMessage());
		       }finally{
		           release(pstmt);
		           freeConnection(dbconn);
		       }
		       
		       return result;

			 }
		      
			 /**
			  * 여러개의 게시글 내용 삭제 
			  * @param dbconn  컨넥션
			  * @param board_seq 메인 게시판 일련번호
			  * @return exe int 1:성공 , 0:실패
			  * @throws DbException
			  * @throws Exception
			  */
			 private int deleteMasterMulti(Connection dbconn, String boardSeqList) throws DbException , Exception {
				PreparedStatement pstmt = null;
		       ResultSet rs = null;        
		       int result	= 0;

				StringBuffer sql = new StringBuffer();

				try { 
					sql.append(" DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ IN ("+boardSeqList+") ");			
					
					pstmt = dbconn.prepareStatement(sql.toString());
					result = pstmt.executeUpdate();

					pstmt.close();
					
				} catch (SQLException e) {
		       	e.printStackTrace();
		       	dbconn.rollback();
		           throw new DbException(e.getMessage());
		       }finally{
		           release(pstmt);
		       }
		       return result;
			 }




}

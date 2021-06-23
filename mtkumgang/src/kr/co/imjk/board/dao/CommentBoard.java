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
 * @author 박상배
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CommentBoard  extends DAOHome{

     
    /**
     * 별점코멘트형 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼 
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 박상배
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
        sql.append(" WHERE BOARD_TYPE='07' ");
        sql.append(subSql);
	    
       // System.out.println("getTotalCount  --  query  => \n"+sql);
       
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
     * 꼬리말의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return rtnValue int  꼬리말의 전체 총 갯수
     * @throws DbException
     * @throws Exception
     * @author 박상배
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
     * 별점코멘트형  게시판 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 박상배
     */
    
	public Tbrd_comment_de_bean[] getList(int requestedPage, int pageSize, String part,
            String keyword, int board_seq )  throws  DbException , Exception {
	   //System.out.println("!getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	   //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	    
	   
		Connection dbconn = getConnection();
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   Tbrd_comment_de_bean bean = null;
	   Collection list = null; 
	   String query = "";
	   String subSql =" ";
	   String tempPart = "";
	   
	   int chk_page = requestedPage-1;
	   
	   if(!keyword.equals("")){
	       if(part.equals("1")){
	           tempPart = "CONTENT";
	       }else if(part.equals("2")){
	           tempPart = "USER_NICK";
	       }else if(part.equals("3")){           	
	       	tempPart = "USER_ID";
	       }
	       subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
	   }
	
	   // 페이징 처리
	   if(chk_page > 0){
	   	query = new StringBuffer()
	   	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NICK , USER_LEVEL , USER_ICON, \n")
	       .append(" REG_DATE, TITLE , CONTENT, STAR_NUM, \n")
	       .append(" BOARD_SEQ , BEST  \n")
	       .append(" from asan.TBRD_COMMENT_DE where BOARD_SEQ = "+board_seq+" and  COMMENT_SEQ not in \n")
	       .append(" ( select COMMENT_SEQ from  \n")
	       .append(" 		( select COMMENT_SEQ from asan.TBRD_COMMENT_DE where BOARD_SEQ = "+board_seq+" \n")
	       .append(subSql)			
	       .append(" 		  order by COMMENT_SEQ DESC \n")
	       .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	       .append(" as tmp )  \n")
	       .append(subSql)	
	       .append(" order by COMMENT_SEQ DESC ")
	       .append(" fetch first "+pageSize+" rows only  \n").toString();
			
	   }else{        	
	   	query = new StringBuffer()
	   	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NICK , USER_LEVEL , USER_ICON,  \n")
	   	.append(" REG_DATE, TITLE , CONTENT, STAR_NUM, \n")
	   	.append(" BOARD_SEQ , BEST \n")
	   	.append(" from asan.TBRD_COMMENT_DE  \n")
	   	.append(" where BOARD_SEQ="+board_seq+" \n")
	   	.append(subSql)			
	   	.append(" order by COMMENT_SEQ DESC \n")
	   	.append(" fetch first 10 rows only  \n").toString(); 
	   }
	   
	   //System.out.println("###########################getCommentList  --  query  => \n"+query);
	
	   try {         
			//System.out.println("1111111111111\n");
	       pstmt = dbconn.prepareStatement(query);
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
     * 꼬리말 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 박상배
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
     * 별점코멘트형 게시판의  현재 게시물과 이전,이후 게시물의 목록
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @throws Exception
     */
    public Tbrd_board_ma_bean[] getPrevAndNextBoard(int board_seq ) 
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
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM				");
		sql.append(" FROM  TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='07' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='07' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='07' AND  BOARD_SEQ < ?		");
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
     * 꼬리말 등록 + 별점 평균 update
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
        sql.append("     CONTENT, STAR_NUM,  BOARD_SEQ )  ");
        sql.append(" VALUES (TBRD_COMMENT_DE_SEQ.NEXTVAL , ? , ?, SYSDATE,  ");
        sql.append("     ?, ?, ?  )");
        
 
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setString(1, bean.getUser_id());
            pstmt.setString(2, bean.getUser_nick());
            pstmt.setString(3, bean.getContent());
            pstmt.setInt(4, bean.getStar_num());
            pstmt.setInt(5, bean.getBoard_seq());
           
          
            exe = pstmt.executeUpdate();
            pstmt.close();
            dbconn.commit();


            //별점 평균 업데이트
            exe = updateStarAver(dbconn, bean.getBoard_seq());
             
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
     * 별점 평균 update
     * @param  dbconn Connection
     * @param board_seq
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
    public int updateStarAver(Connection dbconn, int board_seq) 
        throws DbException , Exception 
    {
             System.out.println("updateStarAver board_seq==>"+board_seq);
        PreparedStatement pstmt = null;

        int exe = 0;
        try { 
            //별점 평균 UPDATE
            StringBuffer sql = new StringBuffer();
            sql.append(" UPDATE TBRD_BOARD_MA   ");
            sql.append(" SET STAR_AVER =(  ");
            sql.append("      SELECT NVL(AVG(STAR_NUM),0 )         ");
            sql.append("      FROM TBRD_COMMENT_DE ");
            sql.append("      WHERE BOARD_SEQ =?  ");
            sql.append(" ) WHERE BOARD_SEQ =?  ");
            System.out.println("UPDATE  --  query  => \n"+sql);
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setInt(1, board_seq);
            pstmt.setInt(2, board_seq);
           
            
            exe = pstmt.executeUpdate();
            pstmt.close();

            System.out.println("UPDATE  --  exe  => \n"+exe);
            
            

        } catch (SQLException e) {
            // Rollback
            rollback(dbconn);
            e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
        }
        return exe;
    }
    
    /**
     * 게시글 내용 수정
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
    public  int update(Tbrd_board_ma_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append(" UPDATE TBRD_BOARD_MA set TITLE=?, CONTENT=? ")
           .append(" WHERE  BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩            
            pstmt.setString(1, bean.getTitle());
            pstmt.setString(2, bean.getContent());
            pstmt.setInt(3, bean.getBoard_seq());
            
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
     *  꼬리글  삭제 
     * @param board_seq 메인 게시판 일련번호
     * @param comment_seq 꼬리글 일련번호
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */ 
    public  int deleteComment(int board_seq, int comment_seq) 
        throws DbException , Exception 
    {    
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
            
           //별점 평균 업데이트
            exe = updateStarAver(dbconn, board_seq);
            
            
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
    
 
    public  int deleteComment2(int comment_seq)  throws DbException , Exception  {    
    // Get connection(auto commit false)            
    Connection dbconn = getConnection(false);
    PreparedStatement pstmt = null;
    
    // SQL
    String sql = new StringBuffer()
       .append("DELETE FROM ASAN.TBRD_COMMENT_DE WHERE COMMENT_SEQ=?").toString();
    
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
            rollback(dbconn);
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return exe ;
    }
    
    
 
    /**
     * 게시글 내용 등록 + 첨부파일 내용 등록
     * @param data Tbrd_board_ma_bean
     * @param attach_date  Map 첨부파일 정보
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
	public int insert(Tbrd_board_ma_bean data, Map attach_date) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int	result			= 0;
		int attach_result	= 0;
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
				.append("  	NOTICE_FROM, NOTICE_TO, PASSWORD)   ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?, ?, ?, ?, ?, ?,   ")
				.append("  	?, ?, ?,   ")
				.append("  	? ,?, ?)   ").toString(); 

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

			if(result > 0){
				//System.out.println("#####################" + attach_date + "#######################");
				if(attach_date != null){
					attach_result = insertAttachFile(dbconn, attach_date, board_seq);
					if(attach_result > 0){
						dbconn.commit();
					}else{
						dbconn.rollback();
					}
				}else{
					attach_result = 1;
					dbconn.commit();
				}
			}else{
				dbconn.rollback();
			}

		} catch (SQLException e) {
        	e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return attach_result;

	 }

	
	 /**
	  * 첨부파일 내용 등록
	  * @param dbconn Connection 
	  * @param data Map 첨부파일 정보
	  * @param board_seq
	  * @return exe int 1:성공 , 0:실패
	  * @throws DbException
	  * @throws Exception
	  */
	private int insertAttachFile(Connection dbconn, Map data, int board_seq) throws DbException , Exception {
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
		
		try {     
			dbconn.setAutoCommit(false);

			if(data != null){	
				for(int pos = 0; pos<data.size()/2; pos++){
					String real_name	= (String)data.get("real_name"+pos);
					String vir_name		= (String)data.get("virtual_name"+pos);

					String query = new StringBuffer()
					.append("  INSERT INTO TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?)   ").toString(); 

					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩

					pstmt.setString(1,real_name);	
					pstmt.setString(2,vir_name);	
					pstmt.setInt(3,board_seq);

					result = pstmt.executeUpdate();

					pstmt.close();
					
				}
				
			}
			
		} catch (SQLException e) {
        	e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
        }
        return result;

	}

	

    /**
     *  게시물 내용 보기
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
	public Tbrd_board_ma_bean [] getBoardView(int board_seq) 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
        // SQL
		String query = new StringBuffer()
			.append(" SELECT	")												
			.append(" a.REF_NO , a.LEVEL_NO , a.SORT_NO , a.TITLE,		")		
			.append(" a.CONTENT, a.USER_ID , a.USER_NICK, a.USE_YN,		")				
			.append(" a.BOARD_TOP_NO , a.READ_NUM , a.REG_DATE, b.REAL_NAME, b.VIRTUAL_NAME , b.WIDTH				")				
			.append(" FROM TBRD_BOARD_MA a left outer join TBRD_ATTACH_FILE_DE b on (a.board_seq = b.board_seq)		")								
			.append(" WHERE a.BOARD_SEQ = ?			").toString();

        try {         
            pstmt = dbconn.prepareStatement(query);
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
     * 첨부 파일 내용 보기 
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_attach_file_de_bean[]
     * @throws DbException
     * @throws Exception
     */
	public Tbrd_attach_file_de_bean[] getFileView(int board_seq) 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
        // SQL
		String query = new StringBuffer()
			.append(" SELECT	")												
			.append(" ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME		")		
			.append(" FROM TBRD_ATTACH_FILE_DE						")								
			.append(" WHERE BOARD_SEQ = ?			").toString();

        try {         
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
            pstmt.setInt(1, board_seq); 

            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Tbrd_attach_file_de_bean());
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Tbrd_attach_file_de_bean [])list.toArray(new Tbrd_attach_file_de_bean[0]);
    }

	
	
    /**
     * 게시글 내용 수정 + 첨부파일 내용 수정
     * @param data Tbrd_board_ma_bean
     * @param attach_data Map 첨부파일 정보
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
	 public int update(Tbrd_board_ma_bean data, Map attach_data) throws DbException , Exception {
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

					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setString(1,data.getTitle());
					pstmt.setString(2,data.getContent());					
					pstmt.setString(3,data.getPassword());
					pstmt.setInt(4,data.getBoard_seq());

					result = pstmt.executeUpdate();

					if(result > 0){
						if(attach_data != null){
							attach_result = updateAttachFile(dbconn, attach_data, data.getBoard_seq());
							if(attach_result > 0){
								dbconn.commit();
							}else{
								dbconn.rollback();
							}
						}else{
							attach_result = 1;
							dbconn.commit();
						}
					}else{
						dbconn.rollback();
					}
					
				}

			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return attach_result;
		 }
 
	 
     /**
      * 첨부파일 내용 수정 
      * @param dbconn Connection 
      * @param data  Map 첨부파일 정보
      * @param board_seq 메인 게시판 일련번호
      * @return exe int 1:성공 , 0:실패
      * @throws DbException
      * @throws Exception
      * @author 박상배
      */
	 private int updateAttachFile(Connection dbconn, Map data, int board_seq) throws DbException , Exception {
			
			PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result  = 0;
			
			try {
				if(data != null){
					dbconn.setAutoCommit(false);
				
					String sql = new StringBuffer()
					.append("  DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ = ?  ").toString();
					pstmt = dbconn.prepareStatement(sql);
					pstmt.setInt(1,board_seq);
					result = pstmt.executeUpdate();
				
					pstmt.close();
				
					
					for(int pos = 0; pos<data.size()/2; pos++){
						String real_name	= (String)data.get("real_name"+pos);
						String vir_name		= (String)data.get("virtual_name"+pos);
						
						
						

						String query = new StringBuffer()
						.append("  INSERT INTO TBRD_ATTACH_FILE_DE   ")
						.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
						.append("  VALUES   ")
						.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?)   ").toString();

						pstmt = dbconn.prepareStatement(query);
						// 변수 바인딩
					

						pstmt.setString(1,real_name);	
						pstmt.setString(2,vir_name);	
						pstmt.setInt(3,board_seq);

						result = pstmt.executeUpdate();

						pstmt.close();
						
					}
				}else{
					dbconn.rollback();
				}

			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }
	        return result;

		 }

     /**
      * 첨부파일 내용 삭제
      * @param vir_name 첨부파일 가상 이름
      * @return exe int 1:성공 , 0:실패
      * @throws DbException
      * @throws Exception
      */
		 public int deleteAttachFile(String vir_name) throws DbException , Exception {
			Connection dbconn = getConnection();	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result			= 0;
			
			StringBuffer sql = new StringBuffer();
			try { 

				sql.append(" DELETE FROM TBRD_ATTACH_FILE_DE WHERE VIRTUAL_NAME=? ");	
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setString(1,vir_name);
				
				
				result = pstmt.executeUpdate();
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
		     * 첨부파일 내용 삭제 + 꼬리말 삭제 + 게시글 내용 삭제 
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
				dbconn.setAutoCommit(false);
				sql =" DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ=? ";				
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setInt(1,board_seq);
				pstmt.executeUpdate();
				pstmt.close();


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


}

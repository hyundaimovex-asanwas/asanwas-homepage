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
public class TourSympathyComment  extends DAOHome{  

     
    /**
     * 별점코멘트형 게시판의 전체 총 갯수
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
     * 별점코멘트형  게시판 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수
     */
    
    public ArrayList getList(int rowsPerPage, int requestedPage, String part, String keyword ) throws  Exception{
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
        
         
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        ArrayList list =  new ArrayList();; 
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

       //SQL  
        String sql = new StringBuffer()
		
		.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2,B.ATTACH_FILE_SEQ) */  \n")
		.append(" A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,  \n")
		.append(" A.CONTENT, A.USER_ID , A.USER_NICK, A.USE_YN,     \n")
		.append(" A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE,  \n")
		.append(" B.REAL_NAME, B.VIRTUAL_NAME ,  A.STAR_AVER  \n")
		.append(" FROM \n")
		.append(" ( \n") 
		.append(" SELECT  \n")
		.append(" BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
		.append(" CONTENT, USER_ID , USER_NICK, USE_YN,      \n")
		.append(" BOARD_TOP_NO , READ_NUM , REG_DATE ,STAR_AVER \n")
		.append(" from TBRD_BOARD_MA  \n")
		.append(" WHERE BOARD_TYPE = '07' \n")
		.append(subSql)
		.append(" ) A, \n")
		.append(" (SELECT  \n")
		.append(" MIN(BOARD_SEQ) AS BOARD_SEQ , MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ, MIN(REAL_NAME) AS REAL_NAME, MIN(VIRTUAL_NAME) AS VIRTUAL_NAME \n")
		.append(" FROM TBRD_ATTACH_FILE_DE GROUP BY BOARD_SEQ) B \n")
		.append(" WHERE A.BOARD_SEQ = B.BOARD_SEQ ORDER BY A.BOARD_SEQ DESC \n").toString(); 

		
        //System.out.println("sql--------\n"+sql);
        
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
  
        
            //System.out.println("query--------\n"+query);
	
        try {         
            Tbrd_board_ma_bean  tbean = null;
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
            pstmt.setInt(1, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
            pstmt.setInt(2, requestedPage * rowsPerPage); // 가져올 개수
            //System.out.println(" start :"+((requestedPage * rowsPerPage) - rowsPerPage) + 1 + "/end:"+requestedPage * rowsPerPage);
            // 결과 담기
            rs = pstmt.executeQuery();
            //list = Selecter.execute(rs, new Tbrd_board_ma_bean());
            
            while(rs.next()){
                tbean = new Tbrd_board_ma_bean();
               // System.out.println("1  STAR_AVER===>"+rs.getString("STAR_AVER"));
                tbean.setBoard_seq(rs.getInt("BOARD_SEQ"));
                tbean.setTitle(rs.getString("TITLE"));
                tbean.setContent(rs.getString("CONTENT"));
                tbean.setUser_id(rs.getString("USER_ID"));
                tbean.setUser_nick(rs.getString("USER_NICK"));
                //tbean.setStar_aver(rs.getDouble("STAR_AVER"));
                tbean.setReg_date(rs.getDate("REG_DATE"));
                tbean.setReal_name(rs.getString("REAL_NAME"));
                tbean.setVirtual_name(rs.getString("VIRTUAL_NAME"));
                list.add(tbean);
                
            }
            
            
            //System.out.println("list--------\n"+list.size());
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return list;

        
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
            if(part.equals("1")){
                tempPart = "CONTENT_DE";
            }else if(part.equals("2")){
                tempPart = "USER_NICK";
            }else if(part.equals("3")){           	
            	tempPart = "USER_ID";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }	 
        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT count(*) from asan.TBRD_COMMENT_DE ");
        sql.append(" WHERE BOARD_SEQ= ? ");
        sql.append(subSql);
	    
       
        //System.out.println("####################### getTotalCount  --  query  => \n"+sql);
       
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
    public Tbrd_comment_de_bean[] getCommentList(int requestedPage, int pageSize, String part,
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
                tempPart = "CONTENT_DE";
            }else if(part.equals("2")){
                tempPart = "USER_NICK";
            }else if(part.equals("3")){           	
            	tempPart = "USER_ID";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }

        
        
    	query = new StringBuffer()
        .append("SELECT COMMENT_SEQ, USER_ID , USER_NAME , USER_LEVEL , USER_ICON," +
        		"REG_DATE, TITLE , CONTENT_DE, STAR_NUM," +
        		"BOARD_SEQ , BEST, USE_YN FROM ( \n")
        .append(" SELECT RowNum as RNUM, X.* FROM ( \n")
    	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NAME , USER_LEVEL , USER_ICON,  \n")
    	.append(" REG_DATE, TITLE , CONTENT_DE, STAR_NUM, \n")
    	.append(" BOARD_SEQ , BEST, USE_YN \n")
    	.append(" from asan.TBRD_COMMENT_DE  \n")
    	.append(" where BOARD_SEQ="+board_seq+" \n")
    	.append(subSql)			
    	.append(" order by COMMENT_SEQ DESC \n")
    	.append("      ) X \n")
        .append(" ) X1 \n")
        .append("WHERE X1.RNum <= "+ pageSize +" \n").toString();
    	
        /* 페이징 처리
        if(chk_page > 0){
        	query = new StringBuffer()
        	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NAME , USER_LEVEL , USER_ICON, \n")
	        .append(" REG_DATE, TITLE , CONTENT, STAR_NUM, \n")
	        .append(" BOARD_SEQ , BEST, USE_YN  \n")
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
        	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NAME , USER_LEVEL , USER_ICON,  \n")
        	.append(" REG_DATE, TITLE , CONTENT, STAR_NUM, \n")
        	.append(" BOARD_SEQ , BEST, USE_YN \n")
        	.append(" from asan.TBRD_COMMENT_DE  \n")
        	.append(" where BOARD_SEQ="+board_seq+" \n")
        	.append(subSql)			
        	.append(" order by COMMENT_SEQ DESC \n")
        	.append(" fetch first "+pageSize+" rows only  \n").toString(); 
        }*/
        
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
     * 꼬리말의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return rtnValue int  꼬리말의 전체 총 갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	public int  getCommentAdminTotalCount(String part, String keyword, int board_seq) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        int rtnValue = 0;
        
        
        if(!keyword.equals("")){
            if(part.equals("1")){
                tempPart = "CONTENT_DE";
            }else if(part.equals("2")){
                tempPart = "USER_NICK";
            }else if(part.equals("3")){           	
            	tempPart = "USER_ID";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }	 
        
        subSql = subSql + " AND USE_YN = '1' ";
        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT count(*) from asan.TBRD_COMMENT_DE ");
        sql.append(" WHERE BOARD_SEQ= ? ");
        sql.append(subSql);
	    
       
        //System.out.println("####################### getTotalCount  --  query  => \n"+sql);
       
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
    public Tbrd_comment_de_bean[] getCommentAdminList(int requestedPage, int pageSize, String part,
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
                tempPart = "CONTENT_DE";
            }else if(part.equals("2")){
                tempPart = "USER_NICK";
            }else if(part.equals("3")){           	
            	tempPart = "USER_ID";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }
        
        subSql = subSql + " AND USE_YN = '1' ";
   
        // 페이징 처리
        if(chk_page > 0){
        	query = new StringBuffer()
        	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NICK , USER_NAME, USER_LEVEL , USER_ICON, \n")
	        .append(" REG_DATE, TITLE , CONTENT_DE, STAR_NUM, \n")
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
        	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NICK , USER_NAME, USER_LEVEL , USER_ICON,  \n")
        	.append(" REG_DATE, TITLE , CONTENT_DE, STAR_NUM, \n")
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
     * 베스트 꼬리말 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 박상배
     */
    public Tbrd_comment_de_bean[] getBestCommentView(int board_seq)  throws  DbException , Exception {
        //System.out.println("!getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
         
        
    	Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_comment_de_bean bean = null;
        Collection list = null; 
        String query = "";
       
        
   
        
        
    	query = new StringBuffer()
    	.append(" SELECT COMMENT_SEQ, USER_ID , USER_NICK , USER_LEVEL , USER_ICON, \n")
        .append(" REG_DATE, TITLE , CONTENT_DE, STAR_NUM, \n")
        .append(" BOARD_SEQ , BEST  \n")
        .append(" from asan.TBRD_COMMENT_DE where BOARD_SEQ = "+board_seq+" and  BEST = '1'  \n").toString();
			
     
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
     * 여러개의 게시글 내용 삭제 
     * @param seqList String 게시글 일련번호들. ex) "45,23,12"
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
    public  int deleteList(String seqList, int board_seq, int delcount) 
        throws DbException , Exception 
    {
        //System.out.println("seqList => \n"+seqList);
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
       
        // SQL
        String sql = new StringBuffer()
           .append("update asan.TBRD_COMMENT_DE set USE_YN = '0' WHERE COMMENT_SEQ IN ("+seqList+") ").toString();
        int exe = 0;
       
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩
            //pstmt.setString(1,seqList);
            exe = pstmt.executeUpdate();
           // System.out.println("exe => \n"+exe);
            pstmt.close();
            
            exe = updateCommentLine(dbconn, board_seq, "0", delcount);
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
     * best선정 처리 
     * @param comment_seq int 게시글 일련번호. 
     * @param mode String 1:BEST선정, 0:BEST비선정 
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
    public  int updateBest(int comment_seq, String mode) 
        throws DbException , Exception 
    {
        //System.out.println("seqList => \n"+seqList);
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
       
        // SQL
        String sql = new StringBuffer()
           .append("UPDATE asan.TBRD_COMMENT_DE SET BEST = '"+mode+"' WHERE COMMENT_SEQ ="+comment_seq+" ").toString();
        int exe = 0;
        
        //System.out.println("######################## > : " + sql);
       
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩
            //pstmt.setString(1,seqList);
            exe = pstmt.executeUpdate();
           // System.out.println("exe => \n"+exe);
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

        CommonBoard commonDao = new CommonBoard();
		
		
		int comment_seq = commonDao.getCommendDeNextSeq(dbconn);

        // SQL 
 
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO asan.TBRD_COMMENT_DE  ");
        sql.append("     (COMMENT_SEQ, USER_ID, USER_NAME,  ");
        sql.append("     CONTENT_DE, STAR_NUM,  BOARD_SEQ )  ");
        sql.append(" VALUES (? , ? , ?, ");
        sql.append("     ?, ?, ?  )");
        
        int board_seq = bean.getBoard_seq();
        
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setInt(1, comment_seq);
            pstmt.setString(2, bean.getUser_id());
            pstmt.setString(3, bean.getUser_name());
            pstmt.setString(4, bean.getContent_de());
            pstmt.setInt(5, bean.getStar_num());
            pstmt.setInt(6, board_seq);
           
          
            exe = pstmt.executeUpdate();
            pstmt.close();
            dbconn.commit(); 


            //별점 평균 업데이트
            //exe = updateStarAver(dbconn, bean.getBoard_seq());
            exe = updateCommentLine(dbconn, board_seq, "1", 1);
             
            //dbconn.commit();
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
             //System.out.println("updateStarAver board_seq==>"+board_seq);
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
            //System.out.println("UPDATE  --  query  => \n"+sql);
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setInt(1, board_seq);
            pstmt.setInt(2, board_seq);
           
            
            exe = pstmt.executeUpdate();
            pstmt.close();

            //System.out.println("UPDATE  --  exe  => \n"+exe);
            
            

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
     * @author 임형수
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
    {    //System.out.println("board_seq=="+board_seq);
         //System.out.println("comment_seq=="+comment_seq);
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append("DELETE FROM asan.TBRD_COMMENT_DE WHERE COMMENT_SEQ=?").toString();
        
        //System.out.println("sql=="+sql);
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩
            pstmt.setInt(1,comment_seq);
            exe = pstmt.executeUpdate();
            pstmt.close();
            dbconn.commit();
            
//          별점 평균 업데이트
            //exe = updateStarAver(dbconn, board_seq);
            exe = updateCommentLine(dbconn, board_seq, "0", 1);
            
            
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
     * 별점 평균 update
     * @param  dbconn Connection
     * @param board_seq
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
    public int updateCommentLine(Connection dbconn, int board_seq, String mode, int delcount) 
        throws DbException , Exception 
    {
        //System.out.println("updateStarAver board_seq==>"+board_seq);
        PreparedStatement pstmt = null;

        int exe = 0;
        try { 
            //별점 평균 UPDATE
            StringBuffer sql = new StringBuffer();
            sql.append(" UPDATE asan.TBRD_BOARD_MA   ");
            if(mode.equals("0")){
            	sql.append(" SET COMMENT_NUM = COMMENT_NUM - "+delcount+"  ");
            }else{            	
            	sql.append(" SET COMMENT_NUM = COMMENT_NUM + "+delcount+"  ");	
            }
            sql.append(" WHERE BOARD_SEQ =?  ");
            //System.out.println("UPDATE  --  query  => \n"+sql);
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setInt(1, board_seq);
            
           
            
            exe = pstmt.executeUpdate();
            pstmt.close();

            //System.out.println("UPDATE  --  exe  => \n"+exe);
            
            

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
     * @author 임형수
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
     * @author 임형수
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
      * @author 임형수
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
		 
		 /**
		     *  게시글 내용 삭제 (USE_YN = 0)
		     * @param board_seq 메인 게시판 일련번호
		     * @return exe int 1:성공 , 0:실패
		     * @throws DbException
		     * @throws Exception
		     */
		 public int deleteUpdate(int comment_seq) throws DbException , Exception {
			Connection dbconn = getConnection();	
		     PreparedStatement pstmt = null;
		     ResultSet rs = null;        
		     int result  = 0;
	
				StringBuffer sql = new StringBuffer();
	
				try { 
					sql.append(" UPDATE asan.TBRD_COMMENT_DE SET USE_YN='0' WHERE COMMENT_SEQ=? ");			
					
					pstmt = dbconn.prepareStatement(sql.toString());
					pstmt.setInt(1,comment_seq);
					
					
					result = pstmt.executeUpdate();
	
					pstmt.close();
	
				} catch (SQLException e) {
		     	e.printStackTrace();
		         throw new DbException(e.getMessage());
		     }
		     return result;

		 }


}

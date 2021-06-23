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
import java.util.Collection;

import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.board.bean.Tbrd_board_ma_bean;

/** 
 * @author 임형수
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ReplyBoard  extends DAOHome{

     
    /**
     * 답변형 게시판의 전체 총 갯수
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
        sql.append(" WHERE BOARD_TYPE='02' ");
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
     * 답변형 게시판 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수
     */
    
    public Tbrd_board_ma_bean[] getList(int rowsPerPage, int requestedPage, String part, String keyword ) 
    throws  DbException , Exception {
        //System.out.println("!getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
         
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        String subSql =" ";
        String tempPart = "";
        
        
        if(!keyword.equals("")){
            if(part.equals("2")){
                tempPart = "CONTENT";
            }else{
                tempPart = "TITLE";
            }
            subSql = " AND  "+tempPart+" LIKE '%"+keyword+"%' \n";
        }	
 
       //      SQL  
        StringBuffer sql = new StringBuffer();
		sql.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n");
		sql.append(" BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
		sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,   \n");
		sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM, USER_NAME    \n");
		sql.append(" FROM TBRD_BOARD_MA  \n");
		sql.append(" WHERE BOARD_TYPE='02'  \n");
		sql.append(subSql);
		sql.append(" ORDER BY   BOARD_TOP_NO, REF_NO DESC,SORT_NO, LEVEL_NO , REG_DATE DESC  \n"); 
		         
         
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
            pstmt.setInt(1, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
            pstmt.setInt(2, requestedPage * rowsPerPage); // 가져올 개수
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
     *  게시물 내용 보기
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
    public Tbrd_board_ma_bean[] getBoardView(int board_seq ) 
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
		sql.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n");
		sql.append(" BOARD_SEQ,  REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
		sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,    \n");
		sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM ,   \n");
		sql.append(" USER_NAME    \n");
		sql.append(" FROM TBRD_BOARD_MA  \n");
		sql.append(" WHERE BOARD_SEQ=?  \n");


        //System.out.println("getList  --  query  => \n"+query);
        try {         
            pstmt = dbconn.prepareStatement(sql.toString());
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
     *  관련 게시물 리스트  
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean[] 
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */  
    public Tbrd_board_ma_bean[] getRefList(int board_seq ) 
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
		sql.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n");
		sql.append(" BOARD_SEQ,  REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
		sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,   \n");
		sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM    \n");
		sql.append(" FROM TBRD_BOARD_MA  \n");
		sql.append(" WHERE REF_NO = ?  \n");
		sql.append(" ORDER BY   BOARD_TOP_NO ,REF_NO DESC,SORT_NO, LEVEL_NO , REG_DATE DESC  \n"); 

        //System.out.println("getList  --  query  => \n"+query);
        try {         
            pstmt = dbconn.prepareStatement(sql.toString());
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
     * 답변형 게시판  게시글 내용 등록
     * @param bean  Tbrd_board_ma_bean
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
    public int insert(Tbrd_board_ma_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int seq = 0;
        //메세지 시퀀스 따기
        StringBuffer seqSql  = new StringBuffer();
        seqSql.append("SELECT TBRD_BOARD_MA_SEQ.NEXTVAL FROM DUAL").toString();
        
        pstmt = dbconn.prepareStatement(seqSql.toString());            
        rs = pstmt.executeQuery();
        
        while(rs.next()){
            seq = rs.getInt(1);
        }
        
        rs.close();
        pstmt.close();
 
        // SQL
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO TBRD_BOARD_MA  ");
        sql.append("     (BOARD_SEQ, REF_NO, SORT_NO, LEVEL_NO,  ");
        sql.append("     TITLE, CONTENT,  USER_ID, REG_DATE,   ");
        sql.append("     BOARD_TYPE, BOARD_TOP_NO ,USER_NAME )  ");
        sql.append(" VALUES (?, ? , 0, 0,  ");
        sql.append("     ?, ?, ?,  SYSDATE, ");
        sql.append("     '02' , ?, ? ) ");
        int exe = 0;
        try { 
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setInt(1, seq);
            pstmt.setInt(2, seq);
            pstmt.setString(3, bean.getTitle());
            // varchar2(4000) 은 stream 으로 반드시 처리
            java.io.StringReader sr = new java.io.StringReader(bean.getContent());
            pstmt.setCharacterStream(4, sr, bean.getContent().length());
            
            pstmt.setString(5, bean.getUser_id());
            pstmt.setInt(6, bean.getBoard_top_no() );
            pstmt.setString(7, bean.getUser_name() );
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
        return exe;
    }
  
    /**
     * 게시글 내용 수정 
     * @param data Tbrd_board_ma_bean
     * @return Tbrd_board_ma_bean []
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
     * 답변형 게시글 답변글 등록 
     * @param data Tbrd_board_ma_bean
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
    public  int reply(Tbrd_board_ma_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int seq = 0;
        
        //자신보다 큰 정렬 번호 1씩 증가 update
        StringBuffer updateSql = new StringBuffer();
        updateSql.append(" UPDATE TBRD_BOARD_MA SET SORT_NO=SORT_NO+1  ");
        updateSql.append(" WHERE REF_NO=? AND SORT_NO > ? AND BOARD_TYPE = '02' ").toString();;
        
        pstmt = dbconn.prepareStatement(updateSql.toString()); 
        pstmt.setInt(1, bean.getRef_no());
        pstmt.setInt(2, bean.getSort_no());
        pstmt.executeUpdate();
        
        pstmt.close();           
        
        
        //메세지 시퀀스 따기
        StringBuffer seqSql  = new StringBuffer();
        seqSql.append("SELECT TBRD_BOARD_MA_SEQ.NEXTVAL FROM DUAL").toString();
        
        pstmt = dbconn.prepareStatement(seqSql.toString());            
        rs = pstmt.executeQuery();
        
        while(rs.next()){
            seq = rs.getInt(1);
        }
        
        rs.close();
        pstmt.close();

        // SQL
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO TBRD_BOARD_MA  ");
        sql.append("    (BOARD_SEQ, REF_NO, SORT_NO, LEVEL_NO,  ");
        sql.append("     TITLE, CONTENT, USER_ID,READ_NUM,  ");
        sql.append("     REG_DATE ,BOARD_TYPE)  ");
        sql.append(" VALUES ( ? , ? , ?, ?,  ");
        sql.append("     ?, ?, ?, 0, ");
        sql.append("     SYSDATE, '02')  ");
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // 변수 바인딩
            pstmt.setInt(1, seq);
            pstmt.setInt(2, bean.getRef_no());
            pstmt.setInt(3, bean.getSort_no()+1);
            pstmt.setInt(4, bean.getLevel_no()+1);
            pstmt.setString(5, bean.getTitle());
            // varchar2(4000) 은 stream 으로 반드시 처리
            java.io.StringReader sr = new java.io.StringReader(bean.getContent());
            pstmt.setCharacterStream(6, sr, bean.getContent().length());
            
            pstmt.setString(7, bean.getUser_id());

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
        return exe;
    }
    
    /**
     *  게시글 내용 삭제 
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     */
    public  int delete(int board_seq) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append("DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // 변수 바인딩
            pstmt.setInt(1,board_seq);
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
     * @return Tbrd_board_ma_bean []
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
}

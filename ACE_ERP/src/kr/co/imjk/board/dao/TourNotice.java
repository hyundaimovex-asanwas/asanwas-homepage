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
 * @author 박상배
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourNotice  extends DAOHome{  

    /**
     * 공지형  게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
    public Tbrd_board_ma_bean[] getList(int requestedPage, int pageSize, String part, String keyword ) throws  Exception{
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
        
        int chk_page = requestedPage-1;
        
        
        if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
			}else if(part.equals("2")){
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND USER_NAME LIKE '%"+keyword+"%' \n";
			}else if(part.equals("3")){
				subSql = " AND USER_ID LIKE '%"+keyword+"%' \n";
			}
        }	  

    
        // 페이징 처리
        if(chk_page > 0){      
        	query = new StringBuffer() 
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n")
	        .append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
	        .append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST \n")
	        .append(" from asan.TBRD_BOARD_MA where board_seq not in \n")
	        .append(" ( select board_seq from  \n")
	        .append(" 		( select board_seq from asan.TBRD_BOARD_MA where board_type='08' and USE_YN = '1' \n")
	        .append(subSql)			
	        .append(" 		  order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	        .append(" as tmp ) and \n")
	        .append(" board_type='08'  and USE_YN = '1' \n")
	        .append(subSql)	
	        .append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO ")
	        .append(" fetch first "+pageSize+" rows only  \n").toString();
			
        }else{         	
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
        	.append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
        	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST \n")
        	.append(" from asan.TBRD_BOARD_MA  \n")
        	.append(" where board_type='08'  and USE_YN = '1' \n")
        	.append(subSql)			
        	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
        	.append(" fetch first 10 rows only  \n").toString();
        }
        
        //System.out.println("getList  --  query  => \n"+query); 
	 
        try {         
			//System.out.println("1111111111111\n");
            pstmt = dbconn.prepareStatement(query);
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
			.append(" SELECT												")
			.append(" REF_NO , LEVEL_NO , SORT_NO , TITLE,		")
			.append(" CONTENT, USER_ID , USER_NICK, USE_YN,					")
			.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, EMAIL, USER_NAME					")
			.append(" FROM asan.TBRD_BOARD_MA									")
			.append("  WHERE BOARD_SEQ = ?			").toString(); 

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
     * 공지형 게시판의  현재 게시물과 이전,이후 게시물의 목록
     * @param board_seq 메인 게시판 일련번호
     * @return Tbrd_board_ma_bean [] 
     * @throws DbException
     * @throws Exception
     */
    public Tbrd_board_ma_bean [] getPrevAndNextBoard(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Collection list = null;
	
		StringBuffer sql = new StringBuffer(); 
		sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , USER_NAME	, USER_ID,				");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM, BEST				");
		sql.append(" FROM  asan.TBRD_BOARD_MA											");
		sql.append(" WHERE BOARD_TYPE ='08' and BOARD_SEQ = ?							");
		sql.append(" UNION ALL															");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ , USER_NAME, USER_ID, TITLE , CONTENT ,	");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM, BEST	 								");
		sql.append(" FROM asan.TBRD_BOARD_MA 											");
		sql.append(" WHERE BOARD_SEQ = (												");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ							");
		sql.append("     FROM asan.TBRD_BOARD_MA 										");
		sql.append("     WHERE BOARD_TYPE ='08' AND USE_YN='1' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL														");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ , USER_NAME	, USER_ID, TITLE , CONTENT ,");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM, BEST	 							");
		sql.append(" FROM asan.TBRD_BOARD_MA 											");
		sql.append(" WHERE BOARD_SEQ = (												");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ							");
		sql.append("     FROM asan.TBRD_BOARD_MA 										");
		sql.append("     WHERE BOARD_TYPE ='08' AND USE_YN='1' AND  BOARD_SEQ < ?		");
		sql.append(" )		");	  
	
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
     * 공지형 게시판  게시글 내용 등록
     * @param bean  Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
	 public int insert(Tbrd_board_ma_bean data) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
        int board_seq = 0;
        String board_type = data.getBoard_type();
		
		try {     

			dbconn.setAutoCommit(false);
			
			CommonBoard commonDao = new CommonBoard();
			
			
			board_seq = commonDao.getBoardMaNextSeq(dbconn);
			System.out.println("===============================");
			System.out.println("board_seq : " + board_seq);
			System.out.println("===============================");
			if(data != null){	
				String query = new StringBuffer()
				.append("  INSERT INTO asan.TBRD_BOARD_MA   ")
				.append("  	(BOARD_SEQ, BOARD_TYPE, REF_NO, LEVEL_NO, SORT_NO, TITLE, CONTENT, USER_ID, USER_NAME,   ")
				.append("  	USER_NICK, USER_LEVEL, USER_ICON,  ")
				.append("  	PASSWORD,EMAIL)   ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?, ?, ?, ?, ?, ?,   ")
				.append("  	?, ?, ?,   ")
				.append("  	?,?)   ").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,board_type);
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

				pstmt.setString(13,data.getPassword());
				pstmt.setString(14,data.getEmail());

				result = pstmt.executeUpdate();
			}

			if(result > 0){
				dbconn.commit();
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
        return result;

	 }
	 
	 
	 /**
     * 게시글 내용 수정 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 박상배
     */
	 public int update(Tbrd_board_ma_bean data) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
		
         
        
		try { 
			dbconn.setAutoCommit(false);

			if(data != null){
				String query = new StringBuffer()
				.append(" UPDATE asan.TBRD_BOARD_MA		")
				.append(" SET TITLE=?,					")
				.append(" 	CONTENT=?,					")
				.append(" 	USER_NAME=?,				")
				.append(" 	EMAIL=?						")
				.append(" WHERE BOARD_SEQ=?				").toString(); 
				
				
				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setString(1,data.getTitle());
				pstmt.setString(2,data.getContent());					
				pstmt.setString(3,data.getUser_name());
				pstmt.setString(4,data.getEmail());
				pstmt.setInt(5,data.getBoard_seq());

				result = pstmt.executeUpdate();

				if(result > 0){
					dbconn.commit();
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
        return result;

	 }
	 
	  /**
     *  게시글 내용 삭제 
     * @param board_seq 메인 게시판 일련번호
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
	 public int delete(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();	
	     PreparedStatement pstmt = null;
	     ResultSet rs = null;        
	     int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try { 
				sql.append(" DELETE FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ=? ");			
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				
				
				result = pstmt.executeUpdate();
	
				pstmt.close();
	
			} catch (SQLException e) {
	     	e.printStackTrace();
	         throw new DbException(e.getMessage());
	     }
	     return result;
	
	}
	 
	 /**
	     * 게시물 읽은 횟수 증가 
	     * @param board_seq 메인 게시판 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public void updateReadnum(int board_seq) throws DbException , Exception {
		 Connection dbconn = getConnection();	
	     PreparedStatement pstmt = null;
	     ResultSet rs = null;        
	     int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try {
				sql.append(" UPDATE asan.TBRD_BOARD_MA  ");	
				sql.append(" SET READ_NUM = READ_NUM + 1  ");		
				sql.append(" WHERE BOARD_SEQ = ?  ");		
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				
				
				result = pstmt.executeUpdate();
	
				pstmt.close();
	
			} catch (SQLException e) {
	     	e.printStackTrace();
	         throw new DbException(e.getMessage());
	     }
	 } 
}
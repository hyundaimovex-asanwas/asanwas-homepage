/*
 * Created on 2006. 7. 10.
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
 * @author 이소연
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourProductReview  extends DAOHome{  

    /**
     * 상품후기 리스트
     * @param  reviewType 후기타입 
     * @return rtnValue int 리스트
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
    public Tbrd_board_ma_bean[] getList(int requestedPage, int pageSize, String reviewType) throws  Exception{
       
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        String query = "";
        String subSql ="";
        String tempPart = "";
        
        int chk_page = requestedPage-1;
        
        if(!reviewType.equals("")){
		  subSql = " AND TITLE LIKE '%"+reviewType+"%' \n";
        }
        
        // 페이징 처리
        if(chk_page > 0){      
        	query = new StringBuffer() 
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO ,           \n")
	        .append(" CASE TITLE WHEN '01' THEN '온천관광'				        \n")
	        .append("  WHEN '02' THEN '북측체험관광'				        \n")
	        .append("  WHEN '03' THEN '효도관광'				        \n")
	        .append("  WHEN '04' THEN '산악/등산관광'				    \n")
	        .append("  WHEN '05' THEN '수학여행/MT'				        \n")
	        .append("  WHEN '06' THEN '기업연수/워크샵'				    \n")
	        .append(" END AS TITLE,			                            \n")			
	        .append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
	        .append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST \n")
	        .append(" from asan.TBRD_BOARD_MA where board_seq not in \n")
	        .append(" ( select board_seq from  \n")
	        .append(" 		( select board_seq from asan.TBRD_BOARD_MA where board_type='08' and USE_YN = '1' \n")
	        .append(subSql)			
	        .append(" 		  order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	        .append(" as tmp ) and \n")
	        .append(" board_type='11'  and USE_YN = '1' \n")
	        .append(subSql)	
	        .append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO ")
	        .append(" fetch first "+pageSize+" rows only  \n").toString();
			
        }else{         	
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , \n")
	        .append(" CASE TITLE WHEN '01' THEN '온천관광'				        \n")
	        .append("  WHEN '02' THEN '북측체험관광'				        \n")
	        .append("  WHEN '03' THEN '효도관광'				        \n")
	        .append("  WHEN '04' THEN '산악/등산관광'				    \n")
	        .append("  WHEN '05' THEN '수학여행/MT'				        \n")
	        .append("  WHEN '06' THEN '기업연수/워크샵'				    \n")
	        .append(" END AS TITLE,			                            \n")		
        	.append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
        	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST \n")
        	.append(" from asan.TBRD_BOARD_MA  \n")
        	.append(" where board_type='11'  and USE_YN = '1' \n")
        	.append(subSql)			
        	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
        	.append(" fetch first 10 rows only  \n").toString();
        }
	 
        try {
        	
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
     * 상품후기  게시글 내용 등록
     * @param bean  Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 이소연
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
     * 상품후기 내용 수정 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 이소연
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
     *  상품후기 내용 삭제 
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
	 
}
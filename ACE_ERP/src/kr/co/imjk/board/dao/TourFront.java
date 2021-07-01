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
 * @author 이소연
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourFront  extends DAOHome{  

    /**
     * 공지사항 리스트
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
    public Tbrd_board_ma_bean[] getNoticeList() throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        String query = "";
        String subSql =" ";
        String tempPart = "";
        
    	query = new StringBuffer()
    	.append(" SELECT BOARD_SEQ, TITLE       \n")
    	.append(" from asan.TBRD_BOARD_MA       \n")
    	.append(" where board_type='08'  and USE_YN = '1' \n")
    	.append(" order by BOARD_SEQ DESC         \n")
    	.append(" fetch first 4 rows only        \n").toString();
       
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
     * 자주 묻는 질문  게시판의 리스트
     * @param pageSize 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[] 
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */ 
    public Tbrd_board_ma_bean[] getQuestionList() throws  Exception{

        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        StringBuffer sql  = null;
        String subSql =" ";
       	
		query = new StringBuffer();
    	query.append(" SELECT BOARD_SEQ , TITLE, TYPE_CODE  \n");
        query.append(" FROM asan.TBRD_BOARD_MA   \n");
        query.append(" WHERE BOARD_TYPE = '06' AND USE_YN='1' \n");
        query.append(" ORDER BY BOARD_SEQ DESC  \n");
    	query.append(" FETCH FIRST 4 ROWS ONLY  \n");
 
        try {
            pstmt = dbconn.prepareStatement(query.toString());
          
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
    
}
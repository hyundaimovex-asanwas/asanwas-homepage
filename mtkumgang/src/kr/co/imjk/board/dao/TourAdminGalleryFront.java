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
import java.util.*;

import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.util.Util;
import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.board.bean.Tbrd_attach_file_de_bean;

/**
 * @author 이소연
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourAdminGalleryFront  extends DAOHome{
    
    /**
     * 겔러리형 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	 public int getMaxSeq(String type_code, int board_seq) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

		String query = "";
        String subSql =" ";
        
        if (board_seq > 0){ //board_seq 가 있다는 건 첫번째 게시물이 아니라는거다~~
        	subSql = " AND BOARD_SEQ < "+board_seq ;
        }else{
        	subSql = "";
        }
		int maxSeq = 0;
		
		query = new StringBuffer()
		.append(" SELECT MAX(BOARD_SEQ) AS BOARD_SEQ    ")
		.append("    FROM asan.TBRD_BOARD_MA            ")
		.append(" WHERE BOARD_TYPE='09'                 ")
		.append(" AND USE_YN='1'                        ")
		.append("    AND TYPE_CODE=?                    ")
		.append(subSql).toString();
		
		try {         
            pstmt = dbconn.prepareStatement(query);
            pstmt.setString(1, type_code);
            
            // 변수 바인딩
			rs = pstmt.executeQuery();

			if(rs.next()){
				maxSeq = rs.getInt("BOARD_SEQ");
			}

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return maxSeq;

	 }


	    /**
	     *  해당 정보 보기
	     * @param type_code 게시물 분류 (4계절 금강산)
	     * @return Tbrd_board_ma_bean []
	     * @throws DbException
	     * @throws Exception
	     * @author 이소연
	     */
	public Tbrd_board_ma_bean [] getBoardView(String type_code, int board_seq) 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;

        // SQL
		String query = new StringBuffer()
			.append(" SELECT A.BOARD_SEQ, A.TITLE, A.CONTENT,                                                         ")
			.append("        A.REG_DATE, B.REAL_NAME, B.VIRTUAL_NAME,                                                 ")
			.append("        ( SELECT MAX(BOARD_SEQ) FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ < ?                      ")
			.append("              AND BOARD_TYPE = '09' AND USE_YN='1' AND TYPE_CODE = ?) AS PRE_SEQ,                ")
			.append("        ( SELECT MIN(BOARD_SEQ) FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ > ?                      ")
			.append("              AND BOARD_TYPE = '09' AND USE_YN='1' AND TYPE_CODE = ?) AS NEXT_SEQ                ")
			.append("  FROM asan.TBRD_BOARD_MA  A left  outer join (                                                  ")
			.append("      SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ                         ")
			.append("      FROM asan.TBRD_ATTACH_FILE_DE A,(                                                          ")
			.append("          SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ                ")
			.append("          FROM asan.TBRD_ATTACH_FILE_DE                                                          ")
			.append("          GROUP BY BOARD_SEQ                                                                     ")
			.append("          )  B                                                                                 ")
			.append("      WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ                                                ")
			.append("  )  B                                                                                         ")
			.append("  ON A.BOARD_SEQ = B.BOARD_SEQ                                                                   ")
			.append("  WHERE A.BOARD_TYPE='09' AND USE_YN='1'                                                         ")
			.append("  AND TYPE_CODE = ?                                                                              ")
			.append("  AND A.BOARD_SEQ = ?                                                                            ")
			.append(" ORDER BY  A.BOARD_SEQ  DESC                                                                     ").toString();

			//System.out.println("--------------------------"+query.toString());
        try {         
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
            pstmt.setInt(1, board_seq); 
            pstmt.setString(2, type_code);
            pstmt.setInt(3, board_seq); 
            pstmt.setString(4, type_code);
            pstmt.setString(5, type_code);
            pstmt.setInt(6, board_seq);
            //System.out.println("--------------------------"+ board_seq);
            //System.out.println("--------------------------"+ type_code);
            
            
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
			.append(" SELECT	                                    ")												
			.append(" ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME		")		
			.append(" FROM asan.TBRD_ATTACH_FILE_DE					")								
			.append(" WHERE BOARD_SEQ = ?			                ").toString();

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

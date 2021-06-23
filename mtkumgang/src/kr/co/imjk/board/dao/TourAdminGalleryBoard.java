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
 * @author 임형수
 * @modify 이소연 (2006.7)
 * 
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourAdminGalleryBoard  extends DAOHome{
 
    /**  
     * 겔러리형  게시판 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수 
     * @modify 이소연
     * 
     */  
    
    public Tbrd_board_ma_bean[] getList(int pageSize, int requestedPage,  String part, String keyword) throws  Exception{
      
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        String subSql =" ";
        String tempPart = "";
        int chk_page = requestedPage-1;

        if(!keyword.equals("") && !part.equals("")){
				subSql = " AND TYPE_CODE LIKE '%"+part+"%' AND TITLE LIKE '%"+keyword+"%' \n";
        }	

        StringBuffer sql = new StringBuffer();
        
        sql.append(" SELECT  \n");
		sql.append("     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    \n");
		sql.append("     A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,      \n");
		sql.append("     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM, A.TYPE_CODE,   \n");
		sql.append("     B.REAL_NAME, B.VIRTUAL_NAME  \n");
		sql.append(" FROM asan.TBRD_BOARD_MA  A left  outer join (   \n");
		sql.append("     SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   \n");
		sql.append("     FROM asan.TBRD_ATTACH_FILE_DE A,(  \n");
		sql.append("         SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   \n");
		sql.append("         FROM asan.TBRD_ATTACH_FILE_DE    \n");
		sql.append("         GROUP BY BOARD_SEQ    \n");
		sql.append("         ) AS B     \n");
		sql.append("     WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ   \n");
		sql.append(" ) AS B   \n");
		sql.append(" ON A.BOARD_SEQ = B.BOARD_SEQ   \n");
		sql.append(" WHERE A.BOARD_TYPE='09' AND USE_YN='1'  \n");
		sql.append(subSql);
		sql.append(" ORDER BY  A.BOARD_SEQ  DESC  \n"); 
	
		
//		 페이징 처리
        if(chk_page > 0){
			query = new StringBuffer();
			query.append(" SELECT   \n");
			query.append(" A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,   \n");   
			query.append(" A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,        \n");
			query.append(" A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM, A.BOARD_TYPE,  \n");
			query.append(" B.REAL_NAME, B.VIRTUAL_NAME  \n");
			query.append(" FROM  \n");
			query.append(" (  \n");
			query.append(" 	 SELECT   \n");
			query.append("         BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,     \n"); 
			query.append(" 	    CONTENT, USER_ID , USER_NAME, USE_YN,        \n");
			query.append(" 	    BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM, BOARD_TYPE  \n");
			query.append(" 	 FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ not in   \n");
			query.append(" 	         ( SELECT BOARD_SEQ from    \n");
			query.append(" 	         	( SELECT BOARD_SEQ FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '09'  AND USE_YN='1'  \n");            
			query.append(" 	                ORDER BY BOARD_SEQ DESC   \n");
			query.append(" 	                FETCH FIRST "+((requestedPage-1) * pageSize)+"    \n");
			query.append(" 	                ROWS ONLY       \n");
			query.append(" 	             ) AS TMP         \n");
			query.append(" 	         ) AND   \n");
			query.append(" 	  BOARD_TYPE = '09' AND USE_YN='1'   \n");
			query.append(subSql);
			query.append(" 	  ORDER BY BOARD_SEQ DESC   \n");
			query.append(" 	  FETCH FIRST "+pageSize+" ROWS ONLY  \n");
			query.append(" ) A left  outer join (     \n");
			query.append(" 			           SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ     \n");
			query.append(" 			           FROM asan.TBRD_ATTACH_FILE_DE A,(    \n");
			query.append(" 			              SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ     \n");
			query.append(" 			              FROM asan.TBRD_ATTACH_FILE_DE      \n");
			query.append(" 			              GROUP BY BOARD_SEQ      \n");
			query.append(" 			              ) AS B       \n");
			query.append(" 			         WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ     \n");
			query.append(" 			        ) AS B     \n");
			query.append(" ON A.BOARD_SEQ = B.BOARD_SEQ     \n");
			query.append(" WHERE A.BOARD_TYPE='09' AND A.USE_YN='1'    \n");
			query.append(" ORDER BY  A.BOARD_SEQ DESC     \n");
			
	 
        }else{        	
			query = new StringBuffer();
	        query.append(sql);			
        	query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
        }
       
		
		System.out.println("getList  --  query  => \n"+query);
		
		
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
    
    
    /**
     * 겔러리형 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	 public int getTotalCount(String part, String keyword ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

		String query = "";
        String subSql =" ";

		int totalCount = 0;
		
		 if(!keyword.equals("")){
				if(part.equals("1")){
					subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
				}else if(part.equals("2")){
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					subSql = " AND USER_NAME LIKE '%"+keyword+"%' \n";
				}else{
					subSql = " AND USER_ID LIKE '%"+keyword+"%' \n";
				}
	            
	        }	

		query = new StringBuffer()
		.append(" SELECT COUNT(*) as TOTAL \n")
		.append(" from asan.TBRD_BOARD_MA \n")
		.append(" WHERE BOARD_TYPE = '09' AND USE_YN='1' \n")
		.append(subSql).toString(); 
		
			
		//System.out.println("getList  --  query  => \n"+query);
		try {         
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
			rs = pstmt.executeQuery();

			if(rs.next()){
				totalCount = rs.getInt("TOTAL");
			}

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return totalCount;

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
        System.out.println("board_seq===>"+board_seq);
        // SQL
		String query = new StringBuffer()
			.append(" SELECT	")												
			.append(" a.REF_NO , a.LEVEL_NO , a.SORT_NO , a.TITLE,		")		
			.append(" a.CONTENT, a.USER_ID , a.USER_NAME, a.USE_YN,	 a.TYPE_CODE,	")				
			.append(" a.BOARD_TOP_NO , a.READ_NUM , a.REG_DATE, a.RECOMM_NUM, b.REAL_NAME, b.VIRTUAL_NAME				")				
			.append(" FROM asan.TBRD_BOARD_MA a left outer join asan.TBRD_ATTACH_FILE_DE b on (a.board_seq = b.board_seq)		")								
			.append(" WHERE a.BOARD_SEQ = ?			").toString();
            System.out.println("query  ===>"+query);
        try {         
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
            pstmt.setInt(1, board_seq); 

            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
            rs.close();
            pstmt.close();
            System.out.println("query  ===> ok");
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
			.append(" FROM asan.TBRD_ATTACH_FILE_DE						")								
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
     * 게시글 내용 등록 , 첨부파일 등록 
     * @param data Tbrd_board_ma_bean
     * @param Tbrd_attach_file_de_bean  fileBean 첨부파일 정보
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
	public int insert(Tbrd_board_ma_bean data , Tbrd_attach_file_de_bean fileBean ) throws DbException , Exception {
		Connection dbconn = getConnection();
	    CommonBoard commonDao  = new CommonBoard();
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int	result			= 0;
		int attach_result	= 0;
		int board_seq		= 0;
		
		try {     

			dbconn.setAutoCommit(false);
			
			if(data != null){	
				
				board_seq = commonDao.getBoardMaNextSeq(dbconn);

				String query = new StringBuffer()
				.append("  INSERT INTO asan.TBRD_BOARD_MA   ")
				.append("  	(BOARD_SEQ, BOARD_TYPE,  TITLE, CONTENT,    ")
				.append("  	USER_ID, USER_NAME, PASSWORD, TYPE_CODE ) ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?,   ")
				.append("  	?, ?, ?,?)   ").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,"09");
				pstmt.setString(3,data.getTitle());
				pstmt.setString(4,data.getContent());
				pstmt.setString(5,data.getUser_id());
				pstmt.setString(6,data.getUser_name());
				pstmt.setString(7,data.getPassword());
				pstmt.setString(8,data.getType_code());

				result = pstmt.executeUpdate();
				
				fileBean.setBoard_seq(board_seq);
			}

			if(result > 0){
                   
					attach_result = insertAttachFile(dbconn, fileBean);
					if(attach_result > 0){
						dbconn.commit();
					}else{
						dbconn.rollback();
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
	  * @param Tbrd_attach_file_de_bean fileBean 첨부파일 정보
	  * @param board_seq int 메인 게시판 일련번호
	  * @return exe int 1:성공 , 0:실패
	  * @throws DbException
	  * @throws Exception
	  */
	 private int insertAttachFile(Connection dbconn, Tbrd_attach_file_de_bean fileBean) throws DbException , Exception {
       PreparedStatement pstmt = null;      
       int result  = 0;
       CommonBoard commonDao  = new CommonBoard();

		
       int attache_seq = commonDao.getAttachFileNextSeq(dbconn);
		try {     
			dbconn.setAutoCommit(false);

			String query = new StringBuffer()
			.append("  INSERT INTO asan.TBRD_ATTACH_FILE_DE   ")
			.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
			.append("  VALUES   ")
			.append("  	(?, ?, ?, ?)   ").toString(); 
			
			if(fileBean != null){	
                   //첨부 파일 정보가 없을 경우에도 real_name 과 vertual_name 이 없는 ROW 가 항상  추가 된다. 	
					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setInt(1,attache_seq);
					pstmt.setString(2,fileBean.getReal_name());	
					pstmt.setString(3,fileBean.getVirtual_name());	
					pstmt.setInt(4,fileBean.getBoard_seq());

					result = pstmt.executeUpdate();

					pstmt.close();
			
			}else{
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
      * 게시글 내용 수정 
      * @param data Tbrd_board_ma_bean
      * @return exe int 1:성공 , 0:실패
      * @throws DbException
      * @throws Exception
      * @author 임형수
      */
	 public int update(Tbrd_board_ma_bean data) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;   
        int result			= 0;
		int attach_result	= 0;
		
		try { 

			if(data != null){
				String query = new StringBuffer()
				.append(" UPDATE asan.TBRD_BOARD_MA			")
				.append(" SET TITLE=?,					")
				.append(" 	CONTENT=?,					")
				.append(" 	PASSWORD=?,					")
				.append(" 	TYPE_CODE=?					")
				.append(" WHERE BOARD_SEQ=?				").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setString(1,data.getTitle());
				pstmt.setString(2,data.getContent());					
				pstmt.setString(3,data.getPassword());
				pstmt.setString(4,data.getType_code());
				pstmt.setInt(5,data.getBoard_seq());

				result = pstmt.executeUpdate();

				

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
      * 게시글 내용 수정 + 첨부파일 수정
      * @param data Tbrd_board_ma_bean
      * @return exe int 1:성공 , 0:실패
      * @throws DbException
      * @throws Exception
      * @author 임형수
      */
	 public int update(Tbrd_board_ma_bean data, Tbrd_attach_file_de_bean fileBean) throws DbException , Exception {
		Connection dbconn = getConnection();
		dbconn.setAutoCommit(false);
        PreparedStatement pstmt = null;   
        int result			= 0;
		int attach_result	= 0;
		
		try { 

			if(data != null){
				String query = new StringBuffer()
				.append(" UPDATE asan.TBRD_BOARD_MA			")
				.append(" SET TITLE=?,					")
				.append(" 	CONTENT=?,					")
				.append(" 	PASSWORD=?	,				")
				.append(" 	TYPE_CODE=?					")
				.append(" WHERE BOARD_SEQ=?				").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setString(1,data.getTitle());
				pstmt.setString(2,data.getContent());					
				pstmt.setString(3,data.getPassword());
				pstmt.setString(4,data.getType_code());
				pstmt.setInt(5,data.getBoard_seq());

				result = pstmt.executeUpdate();

				if(result > 0){

					attach_result = updateAttachFile(dbconn, fileBean);
					if(attach_result > 0){
						dbconn.commit();
					}else{
						dbconn.rollback();
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
      * @param board_seq int  메인 게시판 일련번호
      * @return exe int 1:성공 , 0:실패
      * @throws DbException
      * @throws Exception
      * @author 박상배 
      */
	 private int updateAttachFile(Connection dbconn, Tbrd_attach_file_de_bean fileBean) throws DbException , Exception {

		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
		
        String query = new StringBuffer()
		.append(" UPDATE asan.TBRD_ATTACH_FILE_DE			")
		.append(" SET VIRTUAL_NAME=?,					")
		.append(" 	REAL_NAME=?					")
		.append(" WHERE ATTACH_FILE_SEQ=?	").toString(); 
        
		try {
			if(fileBean != null){
					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setString(1,fileBean.getVirtual_name());	
					pstmt.setString(2,fileBean.getReal_name());	
					pstmt.setInt(3,fileBean.getAttach_file_seq());

					result = pstmt.executeUpdate();

					pstmt.close();
					
			}else{
			} 
		} catch (SQLException e) {
			dbconn.rollback();
        	e.printStackTrace();
            throw new DbException(e.getMessage());
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
				sql = new StringBuffer();
				sql.append(" UPDATE asan.TBRD_BOARD_MA			");
				sql.append(" SET USE_YN='0'					");
				sql.append(" WHERE BOARD_SEQ=?				");		
				
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
	     * @param board_seq  int 메인 게시판 일련번호
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
 
	 
	    /**  
	     *  게시판의  현재 게시물과 이전,이후 게시물의 목록
	     * @param board_seq int 메인 게시판 일련번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     */
	 public Tbrd_board_ma_bean [] getPrevAndNextBoard(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Collection list = null;

		// SQL
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM				");
		sql.append(" FROM  asan.TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='09' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='09' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='09' AND  BOARD_SEQ < ?		");
		sql.append(" )		");	 
		//System.out.println("------------------------------>"+sql);

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
}

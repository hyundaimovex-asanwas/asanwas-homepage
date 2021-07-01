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
 * @author 박상배
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class GalleryBoard  extends DAOHome{

    /**  
     * 겔러리형  게시판 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 박상배
     */ 
    
    public Tbrd_board_ma_bean[] getList(int rowsPerPage, int requestedPage, String part, String keyword ) throws  Exception{
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

       //SQL
        /*
		SELECT   
		     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    
		     A.CONTENT, A.USER_ID , A.USER_NICK, A.USE_YN,      
		     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    
		     B.REAL_NAME, B.VIRTUAL_NAME  
		FROM TBRD_BOARD_MA  A , (   
			 SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ 
			 FROM TBRD_ATTACH_FILE_DE A,(
			 	  SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ 
		     	  FROM TBRD_ATTACH_FILE_DE 
		     	  GROUP BY BOARD_SEQ  
		     ) B  
		     WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ  
		) B   
		WHERE A.BOARD_SEQ = B.BOARD_SEQ(+)   
		AND A.BOARD_TYPE='04'  
       */
        StringBuffer sql = new StringBuffer();
        
        sql.append(" SELECT  \n");
		sql.append("     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    \n");
		sql.append("     A.CONTENT, A.USER_ID , A.USER_NICK, A.USE_YN,      \n");
		sql.append("     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    \n");
		sql.append("     B.REAL_NAME, B.VIRTUAL_NAME  \n");
		sql.append(" FROM TBRD_BOARD_MA  A , (   \n");
		sql.append("     SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   \n");
		sql.append("     FROM TBRD_ATTACH_FILE_DE A,( \n");
		sql.append("         SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   \n");
		sql.append("         FROM TBRD_ATTACH_FILE_DE    \n");
		sql.append("         GROUP BY BOARD_SEQ    \n");
		sql.append("         ) B     \n");
		sql.append("     WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ   \n");
		sql.append(" ) B   \n");
		sql.append(" WHERE A.BOARD_SEQ = B.BOARD_SEQ(+)   \n");
		sql.append(" AND A.BOARD_TYPE='04'  \n");
		sql.append(subSql);
		sql.append(" ORDER BY  A.REG_DATE DESC   \n"); 
		

        
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
  
        
         
	
        try {         
            pstmt = dbconn.prepareStatement(query);
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
     * 겔러리형 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 박상배
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
			}else{
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND CONTENT LIKE '%"+keyword+"%' \n";
			}
            
        }	

		query = new StringBuffer()
		.append(" SELECT COUNT(*) as TOTAL \n")
		.append(" from TBRD_BOARD_MA \n")
		.append(" WHERE BOARD_TYPE = '04' \n")
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
	  * @param board_seq int 메인 게시판 일련번호
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
      * @param board_seq int  메인 게시판 일련번호
      * @return exe int 1:성공 , 0:실패
      * @throws DbException
      * @throws Exception
      * @author 박상배 
      */
	 private int updateAttachFile(Connection dbconn, Map data, int board_seq) throws DbException , Exception {
		//System.out.println("########################1111###############################");
		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
		//System.out.println("########################22222###############################");
		try {
			if(data != null){
				dbconn.setAutoCommit(false);
			
				String sql = new StringBuffer()
				.append("  DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ = ?  ").toString();
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setInt(1,board_seq);
				result = pstmt.executeUpdate();
				//System.out.println("########################3333###############################");
				pstmt.close();
				//System.out.println("########################result###############################" + result);
				//System.out.println("########################board_seq###############################" + board_seq);
				//if(result > 0){
				
				for(int pos = 0; pos<data.size()/2; pos++){
					String real_name	= (String)data.get("real_name"+pos);
					String vir_name		= (String)data.get("virtual_name"+pos);
					
					
					//System.out.println("real_name : " + real_name);
					//System.out.println("vir_name : " + vir_name);
					//System.out.println("board_seq : " + board_seq);
					/*
					String query = new StringBuffer()
					.append("  INSERT INTO TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, WIDTH, HEIGHT, FILE_SIZE, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)   ").toString(); 
					*/

					String query = new StringBuffer()
					.append("  INSERT INTO TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?)   ").toString();

					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					/*
					pstmt.setInt(1,data.getWidth());	
					pstmt.setInt(2,data.getHeight());	
					pstmt.setInt(3,data.getFile_size());	
					pstmt.setString(4,data.getReal_name());	
					pstmt.setString(5,data.getVirtual_name());	
					pstmt.setInt(6,data.getBoard_seq());
					*/

					pstmt.setString(1,real_name);	
					pstmt.setString(2,vir_name);	
					pstmt.setInt(3,board_seq);

					result = pstmt.executeUpdate();

					pstmt.close();
					
				}
			}else{
				dbconn.rollback();
			}
			//}
		} catch (SQLException e) {
        	e.printStackTrace();
            throw new DbException(e.getMessage());
        }
        return result;

	 }
    
	    /**
	     * 첨부파일 내용 삭제 + 게시글 내용 삭제 
	     * @param board_seq int 메인 게시판 일련번호
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

		StringBuffer sql = new StringBuffer();

		try { 
			dbconn.setAutoCommit(false);
			sql.append(" DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ=? ");			
			
			pstmt = dbconn.prepareStatement(sql.toString());
			pstmt.setInt(1,board_seq);
			
			
			result = pstmt.executeUpdate();

			if(result > 0){
				attach_result = deleteMaster(dbconn, board_seq);
				if(attach_result > 0){					
					dbconn.commit();
				}else{
					dbconn.rollback();
				}
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
        return attach_result;

	 }

	 
	 /**
	  * 게시글 내용 삭제 
	  * @param dbconn Connection 
	  * @param board_seq int 메인 게시판 일련번호
	  * @return exe int 1:성공 , 0:실패
	  * @throws DbException
	  * @throws Exception
	  */
	 private int deleteMaster(Connection dbconn, int board_seq) throws DbException , Exception {
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
			sql.append(" UPDATE TBRD_BOARD_MA  ");	
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
	     * 겔러리형 게시판의  현재 게시물과 이전,이후 게시물의 목록
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
		sql.append(" FROM  TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='04' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='04' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='04' AND  BOARD_SEQ < ?		");
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

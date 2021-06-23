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
 * @modify 이소연
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class KsQnABoard  extends DAOHome{

    /** 
     * QnA  게시판의 리스트 
     * @param pageSize 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[] 
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
    public Tbrd_board_ma_bean[] getList(int pageSize, int requestedPage, String part, String keyword, String orderBy ) throws  Exception{
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () orderBy:"+orderBy+"/keyword:"+keyword);
         
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        StringBuffer sql  = null;
        StringBuffer orderbySql = null;
        String subSql =" ";
        int chk_page = requestedPage-1;
         
        if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%'  \n";
			}else if(part.equals("2")){
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND USER_NAME LIKE '%"+keyword+"%'  \n";
			}else{
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND USER_ID LIKE '%"+keyword+"%'  \n";
			}
            
        }	
        
        orderbySql = new StringBuffer();
        if(orderBy.equals("replyN")){
        	orderbySql.append(" ORDER BY REPLY_YN, BOARD_SEQ DESC \n"); 
		}else if(orderBy.equals("replyY")){
			orderbySql.append(" ORDER BY REPLY_YN DESC, BOARD_SEQ DESC \n"); 
		}else{
			orderbySql.append(" ORDER BY BOARD_SEQ DESC \n"); 
		}
        
        
    
        // 페이징 처리
        if(chk_page > 0){
			query = new StringBuffer();
	    	query.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n");
	        query.append(" CONTENT, USER_ID , USER_NAME, USE_YN,  \n");
	        query.append(" READ_NUM , REG_DATE, TYPE_CODE, OPEN_YN ,REPLY_YN  \n");
	        query.append(" FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ not in \n");
	        query.append(" ( SELECT BOARD_SEQ from  \n");
	        query.append(" 		( SELECT BOARD_SEQ from asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '21' AND USE_YN='1' \n");
	        query.append(          subSql              );
	        query.append(          orderbySql          );
	        query.append("        FETCH FIRST "+((requestedPage-1) * pageSize)+"   \n");
	        query.append("        ROWS ONLY     ");
	        query.append("       ) as tmp       ");
	        query.append(" ) AND \n");
	        query.append(" BOARD_TYPE = '21' AND USE_YN='1'  \n");
	        query.append(subSql);
	        query.append(orderbySql);
	        query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
	 
        }else{        	
			query = new StringBuffer();
	    	query.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n");
	        query.append(" CONTENT, USER_ID , USER_NAME, USE_YN,  \n");
	        query.append(" READ_NUM , REG_DATE, TYPE_CODE, OPEN_YN ,REPLY_YN  \n");
	        query.append(" FROM asan.TBRD_BOARD_MA   \n");
	        query.append(" WHERE BOARD_TYPE = '21' AND USE_YN='1'  \n");
	        query.append(subSql);			
	        query.append(orderbySql);
        	query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
        }
        
        //System.out.println("getList  ++ query  => \n"+query);
	
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
     * QnA 게시판의 전체 총 갯수
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

        StringBuffer query = null;
        String subSql =" ";

		int totalCount = 0;
		
 
		  if(!keyword.equals("")){
				if(part.equals("1")){
					subSql = " AND TITLE LIKE '%"+keyword+"%'  \n";
				}else if(part.equals("2")){
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					subSql = " AND USER_NAME LIKE '%"+keyword+"%'  \n";
				}else{
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					subSql = " AND USER_ID LIKE '%"+keyword+"%'  \n";
				}
	            
	        }	

		query = new StringBuffer();
			query.append(" SELECT COUNT(*) as TOTAL \n");
			query.append(" from asan.TBRD_BOARD_MA \n");
			query.append(" WHERE BOARD_TYPE = '21'  AND USE_YN='1' \n");
		    query.append(subSql).toString(); 

		try {         
            pstmt = dbconn.prepareStatement(query.toString());
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
     * QnA  게시판의 리스트 
     * @param pageSize 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[] 
     * @throws DbException
     * @throws Exception
     * @author 임형수
     * @modify 이소연 2006.7
     */
    public Tbrd_board_ma_bean[] getFrontList(int pageSize, int requestedPage, String part, String keyword, String orderBy ) throws  Exception{
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () orderBy:"+orderBy+"/keyword:"+keyword);
         
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        StringBuffer sql  = null;
        StringBuffer orderbySql = null;
        String subSql =" ";
        int chk_page = requestedPage-1;
         
        if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%' AND USE_YN='1' \n";
			}else if(part.equals("2")){
				subSql = " AND USER_NAME LIKE '%"+keyword+"%' AND USE_YN='1' \n";
			}else if(part.equals("5")){ //아이디
				subSql = " AND USER_ID LIKE '%"+keyword+"%' AND USE_YN='1' \n";
			}else if(part.equals("6")){  //이메일
				subSql = " AND EMAIL LIKE '%"+keyword+"%' AND USE_YN='1' \n";
			}else{
				subSql = " AND USER_ID LIKE '%"+keyword+"%' AND USE_YN='1' \n";
			}
            
        }	
        
        orderbySql = new StringBuffer();
        if(orderBy.equals("replyN")){
        	orderbySql.append(" ORDER BY REPLY_YN, BOARD_SEQ DESC \n"); 
		}else if(orderBy.equals("replyY")){
			orderbySql.append(" ORDER BY REPLY_YN DESC, BOARD_SEQ DESC \n"); 
		}else{
			orderbySql.append(" ORDER BY BOARD_SEQ DESC \n"); 
		}
        
        
    
        // 페이징 처리
        if(chk_page > 0){
			query = new StringBuffer();
	    	query.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n");
	        query.append(" CONTENT, USER_ID , USER_NAME, USE_YN,  \n");
	        query.append(" READ_NUM , REG_DATE, TYPE_CODE, OPEN_YN ,REPLY_YN  \n");
	        query.append(" FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ not in \n");
	        query.append(" ( SELECT BOARD_SEQ from  \n");
	        query.append(" 		( SELECT BOARD_SEQ from asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '21'  AND USE_YN = '1' \n");
	        query.append(          subSql              );
	        query.append(          orderbySql          );
	        query.append("        FETCH FIRST "+((requestedPage-1) * pageSize)+"   \n");
	        query.append("        ROWS ONLY     ");
	        query.append("       ) as tmp       ");
	        query.append(" ) AND \n");
	        query.append(" BOARD_TYPE = '21' AND USE_YN='1'  \n"); 
	        query.append(subSql);
	        query.append(orderbySql);
	        query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
	 
        }else{        	
			query = new StringBuffer();
	    	query.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n");
	        query.append(" CONTENT, USER_ID , USER_NAME, USE_YN,  \n");
	        query.append(" READ_NUM , REG_DATE, TYPE_CODE, OPEN_YN ,REPLY_YN  \n");
	        query.append(" FROM asan.TBRD_BOARD_MA   \n");
	        query.append(" WHERE BOARD_TYPE = '21'  AND USE_YN = '1' \n");
	        query.append(subSql);			
	        query.append(orderbySql);
        	query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
        }
        
        //System.out.println("getList  ++ query  => \n"+query);
	
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
     * QnA 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	public int getFrontTotalCount(String part, String keyword ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuffer query = null;
        String subSql =" ";

		int totalCount = 0;
		
 
		  //if(!keyword.equals("")){
		//		if(part.equals("1")){
					//subSql = " AND TITLE LIKE '%"+keyword+"%' AND USE_YN='1' \n";
			//	}else if(part.equals("2")){
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				//	subSql = " AND USER_NAME LIKE '%"+keyword+"%' AND USE_YN='1' \n";
				//}else{
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					//subSql = " AND USER_ID LIKE '%"+keyword+"%' AND USE_YN='1' \n";
				//}
	            
	        //}	

			        if(!keyword.equals("")){
						if(part.equals("1")){
							subSql = " AND TITLE LIKE '%"+keyword+"%' AND USE_YN='1' \n";
						}else if(part.equals("2")){
							subSql = " AND USER_NAME LIKE '%"+keyword+"%' AND USE_YN='1' \n";
						}else if(part.equals("5")){ //아이디
							subSql = " AND USER_ID LIKE '%"+keyword+"%' AND USE_YN='1' \n";
						}else if(part.equals("6")){  //이메일
							subSql = " AND EMAIL LIKE '%"+keyword+"%' AND USE_YN='1' \n";
						}else{
							subSql = " AND USER_ID LIKE '%"+keyword+"%' AND USE_YN='1' \n";
						}
			            
			        }	
			        
		query = new StringBuffer();
			query.append(" SELECT COUNT(*) as TOTAL \n");
			query.append(" from asan.TBRD_BOARD_MA \n");
			query.append(" WHERE BOARD_TYPE = '21'  AND USE_YN = '1' \n");
		    query.append(subSql).toString(); 

		try {         
            pstmt = dbconn.prepareStatement(query.toString());
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
        StringBuffer query = null;
          
        // SQL  
		 query = new StringBuffer();
			query.append(" SELECT												");
			query.append(" REF_NO ,  TITLE,	CONTENT, USER_ID ,	");
			query.append(" TYPE_CODE,  USE_YN, READ_NUM , REG_DATE, OPEN_YN, 	");
			query.append(" REPLY_YN, REPLY_CONTENT, REPLY_REG_DATE, USER_NAME,	");
			query.append(" EMAIL , TEL, PASSWORD	");
			query.append(" FROM asan.TBRD_BOARD_MA									");
			query.append("  WHERE BOARD_SEQ = "+board_seq+" 	").toString(); 

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
     *  게시판 NEXT SEQ 값 구하기 
     * @param Connection dbconn  
      * @return int nextSeq 최대값+1
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	private int getNextSeq(Connection dbconn) 
        throws DbException , Exception 
    {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String count = "0";
        int nextSeq = 0;
 
        String query = "SELECT MAX(BOARD_SEQ) count FROM asan.TBRD_BOARD_MA";
         
        try {         
            pstmt = dbconn.prepareStatement(query);
            // 결과 담기
            rs = pstmt.executeQuery();
            if(rs.next()){
            	
            	count = rs.getString(1);
            	
            	 if(count == null){
            		
            		 nextSeq = 1;
                 }else{
                	
                	 nextSeq = Integer.parseInt(count);
                 }
            }else{	      
            	
            	nextSeq = 1;
            }
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
        }
        return nextSeq+1;
    } 
 
    /**
     * QnA 게시판  게시글 내용 등록
     * @param bean  Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	public int insert(Tbrd_board_ma_bean data) throws DbException , Exception {
	
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;    
        int result  = 0;
        int nextSeq = 0;
		 
		try {     

			dbconn.setAutoCommit(false);
			 
			
			nextSeq   =getNextSeq(dbconn);
		         
			if(data != null){	
				String query = new StringBuffer()
				.append("  INSERT INTO asan.TBRD_BOARD_MA   ")
				.append("  	(BOARD_TYPE, BOARD_SEQ,  OPEN_YN, TITLE,    ")
				.append("  	 CONTENT, USER_ID, USER_NAME , PASSWORD,   ")
				.append("  	 EMAIL, TEL )  ")
				.append("  VALUES   ")
				.append("  	( ?, ?, ?, ?,   ")
				.append("  	  ?, ?, ?, ?,   ")
				.append("  	?, ?)   ").toString(); 

				//System.out.println("query=>"+query+"\n");
				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setString(1,"21");
				pstmt.setInt(2,nextSeq);
				pstmt.setString(3,data.getOpen_yn());					
				pstmt.setString(4,data.getTitle());
				pstmt.setString(5,data.getContent());
				pstmt.setString(6,data.getUser_id());
				pstmt.setString(7,data.getUser_name());
				pstmt.setString(8,data.getPassword());
				pstmt.setString(9,data.getEmail());
				pstmt.setString(10,data.getTel());

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
     * QnA 게시판  게시글 답변  등록
     * @param bean  Tbrd_board_ma_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */  
	 public int insertReply(Tbrd_board_ma_bean data) throws DbException , Exception {
			Connection dbconn = getConnection();	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result  = 0;
			
			try { 
				dbconn.setAutoCommit(false);

				if(data != null){
					String query = new StringBuffer()
					.append(" UPDATE asan.TBRD_BOARD_MA			")
					.append(" SET REPLY_CONTENT=?,					")
					.append(" 	REPLY_REG_DATE= current date ,					")
					.append(" 	REPLY_YN= '1'					")
					.append(" WHERE BOARD_SEQ=?				").toString(); 

					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setString(1,data.getReply_content());
					pstmt.setInt(4,data.getBoard_seq());

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
        ResultSet rs = null;        
        int result  = 0;
		
		try { 
			dbconn.setAutoCommit(false);

			if(data != null){
				String query = new StringBuffer()
				.append(" UPDATE asan.TBRD_BOARD_MA			")
				.append(" SET TITLE=?,					")
				.append(" 	CONTENT=?,					")
				.append(" 	USER_NAME=?,					")
				.append(" 	USER_ID=?,					")
				.append(" 	OPEN_YN=?,					")
				.append(" 	EMAIL=?,					")
				.append(" 	TEL=?					")
				.append(" WHERE BOARD_SEQ=?				").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setString(1,data.getTitle());
				pstmt.setString(2,data.getContent());	
				pstmt.setString(3,data.getUser_name());
				pstmt.setString(4,data.getUser_id());
				pstmt.setString(5,data.getOpen_yn());
				pstmt.setString(6,data.getEmail());
				pstmt.setString(7,data.getTel());
				pstmt.setInt(8,data.getBoard_seq());

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
	     * 게시글 답변 내용 수정 
	     * @param data Tbrd_board_ma_bean
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     * @author 임형수
	     */
		 public int updateReply(Tbrd_board_ma_bean data) throws DbException , Exception {
			Connection dbconn = getConnection();	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result  = 0;
			
			try { 
				dbconn.setAutoCommit(false);

				if(data != null){
					String query = new StringBuffer()
					.append(" UPDATE asan.TBRD_BOARD_MA			")
					.append(" SET REPLY_CONTENT=?,					")
					.append("  OPEN_YN=?,					")
					.append(" 	REPLY_REG_DATE= current date ,					")
					.append(" 	REPLY_YN= '1'					")
					.append(" WHERE BOARD_SEQ=?				").toString(); 

					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setString(1,data.getReply_content());
					pstmt.setString(2,data.getOpen_yn());					
					pstmt.setInt(3,data.getBoard_seq());

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
	     *  게시글 내용 사용 안함으로 수정  
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
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return result;

	 }

	 
	    /**
	     *  게시글 내용 완전  삭제 
	     * @param board_seq 메인 게시판 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteComplete(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();
		dbconn.setAutoCommit(false);
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;

		StringBuffer sql = new StringBuffer();
 
		try { 
			sql = new StringBuffer();
			sql.append(" DELETE FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ=?			");
			
			pstmt = dbconn.prepareStatement(sql.toString());
			pstmt.setInt(1,board_seq);
			//System.out.println("sql query => "+sql);
			
			result = pstmt.executeUpdate();
			//System.out.println("sql result => "+result);
			pstmt.close();
			
			if(result>0){
				sql = new StringBuffer();
				sql.append(" DELETE FROM asan.TBRD_RECOMMEND_HS WHERE BOARD_SEQ=?			");
				
				//System.out.println("sql query => "+sql);
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				
				
				result = pstmt.executeUpdate();	
				
				//System.out.println("sql result => "+result);
				dbconn.commit();
			}else{
				result = 0;
				dbconn.rollback();
			}
			

			pstmt.close();
			

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
		}finally{
            release(pstmt);
            freeConnection(dbconn);
        }
	 } 

	 
	    /**  
	     * QnA 게시판의  현재 게시물과 이전,이후 게시물의 목록
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
		sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,			");
		sql.append(" USER_NAME, OPEN_YN, USE_YN, REPLY_YN,				");
		sql.append(" EMAIL , TEL, REPLY_REG_DATE REPLY_CONTENT				");
		sql.append(" FROM  asan.TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='21' and USE_YN='1' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM ,				");
		sql.append(" USER_NAME, OPEN_YN, USE_YN, REPLY_YN,				");
		sql.append(" EMAIL , TEL, REPLY_REG_DATE REPLY_CONTENT				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='21'  and USE_YN='1' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM ,				");
		sql.append(" USER_NAME, OPEN_YN, USE_YN, REPLY_YN	,			");
		sql.append(" EMAIL , TEL, REPLY_REG_DATE REPLY_CONTENT				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='21'  and USE_YN='1' AND  BOARD_SEQ < ?		");
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
}

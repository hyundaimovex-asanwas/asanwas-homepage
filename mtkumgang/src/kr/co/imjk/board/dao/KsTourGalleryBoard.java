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
import kr.co.imjk.board.bean.Tbrd_comment_de_bean;

/**
 * @author 임형수
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class KsTourGalleryBoard  extends DAOHome{
 
	
	
	

	
    /**  
     * 겔러리 게시판  어드민 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수 
     */  
    
    public Tbrd_board_ma_bean[] getList(int pageSize, int requestedPage,  String part, String keyword ) throws  Exception{
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
         
         
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        String subSql =" ";
        String tempPart = "";
        int chk_page = requestedPage-1;
        
  
        
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

         
       
        StringBuffer sql = new StringBuffer();
        
        sql.append(" SELECT  \n");
		sql.append("     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    \n");
		sql.append("     A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,      \n");
		sql.append("     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    \n");
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
		sql.append(" WHERE A.BOARD_TYPE='19' AND USE_YN='1'  \n");
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
			query.append(" 	         	( SELECT BOARD_SEQ FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '19'  AND USE_YN='1'  \n");            
			query.append(" 	                ORDER BY BOARD_SEQ DESC   \n");
			query.append(" 	                FETCH FIRST "+((requestedPage-1) * pageSize)+"    \n");
			query.append(" 	                ROWS ONLY       \n");
			query.append(" 	             ) AS TMP         \n");
			query.append(" 	         ) AND   \n");
			query.append(" 	  BOARD_TYPE = '19' AND USE_YN='1'   \n");
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
			query.append(" WHERE A.BOARD_TYPE='19' AND A.USE_YN='1'    \n");
			query.append(" ORDER BY  A.BOARD_SEQ DESC     \n");
	 
        }else{        	
			query = new StringBuffer();
	        query.append(sql);			
        	query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
        }
       
		
		//System.out.println("getList  --  query  => \n"+query);
		
		
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
     * 겔러리 게시판  사용자  리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author 임형수 
     */  
    
    public Tbrd_board_ma_bean[] getFrontList(int pageSize, int requestedPage,  String part, String keyword ) throws  Exception{
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
         
         
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        String subSql =" ";
        String tempPart = "";
        int chk_page = requestedPage-1;
        
        
  
        
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

        StringBuffer sql = new StringBuffer();
        
        sql.append("SELECT * FROM ( \n");
        sql.append(" SELECT RowNum as RNUM, X.* FROM ( \n");        
	        sql.append(" SELECT  \n");
			sql.append("     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    \n");
			sql.append("     A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,      \n");
			sql.append("     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    \n");
			sql.append("     B.REAL_NAME, B.VIRTUAL_NAME  \n");
			sql.append(" FROM asan.TBRD_BOARD_MA  A left  outer join (   \n");
			sql.append("     SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   \n");
			sql.append("     FROM asan.TBRD_ATTACH_FILE_DE A,(  \n");
			sql.append("         SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   \n");
			sql.append("         FROM asan.TBRD_ATTACH_FILE_DE    \n");
			sql.append("         GROUP BY BOARD_SEQ    \n");
			sql.append("         ) B1     \n");
			sql.append("     WHERE A.ATTACH_FILE_SEQ = B1.ATTACH_FILE_SEQ   \n");
			sql.append("  ) B   \n");
			sql.append(" ON A.BOARD_SEQ = B.BOARD_SEQ   \n");
			sql.append(" WHERE A.BOARD_TYPE='19' AND USE_YN='1'  \n");
			sql.append(subSql);
			sql.append(" ORDER BY  A.BOARD_SEQ  DESC  \n"); 
	        sql.append("      ) X \n");
	        sql.append(" )X1 \n");
            sql.append("WHERE X1.RNum > "+ (requestedPage-1)*pageSize +" and X1.RNum <= "+ requestedPage*pageSize +" \n");
		
		

		//System.out.println("chk_page===="+chk_page);
//		 페이징 처리
		query = new StringBuffer();
        query.append(sql);			

    	
		// 예전 DB2 쿼리
		/*
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
			query.append(" 	         	( SELECT BOARD_SEQ FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '19' AND USE_YN='1'   \n");            
			query.append(" 	                ORDER BY BOARD_SEQ DESC   \n");
			query.append(" 	                FETCH FIRST "+((requestedPage-1) * pageSize)+"    \n");
			query.append(" 	                ROWS ONLY       \n");
			query.append(" 	             ) AS TMP         \n");
			query.append(" 	         ) AND   \n");
			query.append(" 	  BOARD_TYPE = '19'    \n");
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
			query.append(" WHERE A.BOARD_TYPE='19' AND A.USE_YN='1'    \n");
			query.append(" ORDER BY  A.BOARD_SEQ DESC     \n");
	 
        }else{        	
			query = new StringBuffer();
	        query.append(sql);			
        	query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
        }
       */
		
		
        try {
        	//System.out.println("query===="+query.toString());
        	
        	
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
     * 겔러리 어드민 게시판의 전체 총 갯수
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
		.append(" WHERE BOARD_TYPE = '19' AND USE_YN='1' \n")
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
	     * 겔러리형 사용자 게시판의 전체 총 갯수
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
			.append(" WHERE BOARD_TYPE = '19' AND USE_YN='1' \n")
			.append(subSql).toString(); 

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
	     * 꼬리말 어드민 리스트 정보를 가져온다. </br>
	     * @param rowsPerPage 페이지별 row 수 
	     * @param requestedPage 호출 페이지 번호
	     * @param part 검색할 디비컬럼
	     * @param keyword 검색한 단어
	     * @param board_seq 메인 게시판 일련번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @author 임형수
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
	        StringBuffer query = new StringBuffer();
	        int chk_page = requestedPage-1;


			         
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
		      
//			 페이징 처리
	        if(chk_page > 0){
				query = new StringBuffer();
		    	query.append(" SELECT  BOARD_SEQ, COMMENT_SEQ, USER_ID,   \n");
		        query.append(" USER_NAME , CONTENT , REG_DATE, TITLE  \n");
		        query.append(" FROM asan.TBRD_COMMENT_DE WHERE COMMENT_SEQ not in \n");
		        query.append(" ( SELECT COMMENT_SEQ from  \n");
		        query.append(" 		( SELECT COMMENT_SEQ FROM asan.TBRD_COMMENT_DE WHERE BOARD_SEQ = "+board_seq+"  AND USE_YN='1' \n");
		        query.append(          subSql              );
		        query.append("        ORDER BY COMMENT_SEQ DESC \n");
		        query.append("        FETCH FIRST "+((requestedPage-1) * rowsPerPage)+"   \n");
		        query.append("        ROWS ONLY     ");
		        query.append("       ) AS TMP       ");
		        query.append(" ) AND \n");
		        query.append(" BOARD_SEQ = "+board_seq+"  AND USE_YN='1' \n");
		        query.append(subSql);
		        query.append("   ORDER BY COMMENT_SEQ DESC \n");
		        query.append(" FETCH FIRST "+rowsPerPage+" ROWS ONLY  \n");
		 
	        }else{        	
				query = new StringBuffer();
		    	query.append(" SELECT  BOARD_SEQ, COMMENT_SEQ, USER_ID,   \n");
		        query.append(" USER_NAME , CONTENT , REG_DATE, TITLE  \n");
		        query.append(" FROM asan.TBRD_COMMENT_DE   \n");
		        query.append(" WHERE BOARD_SEQ = "+board_seq+"  AND USE_YN='1' \n");
		        query.append(subSql);			
		        query.append(" ORDER BY COMMENT_SEQ DESC \n");
	        	query.append(" FETCH FIRST "+rowsPerPage+" ROWS ONLY  \n");
	        }
	        
	  
	        
	        //System.out.println("getList  --  query  => \n"+query);
	        try {         
	            pstmt = dbconn.prepareStatement(query.toString());
	            // 변수 바인딩
	            //pstmt.setInt(1, board_seq);
	            //pstmt.setInt(2, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
	            //pstmt.setInt(3, requestedPage * rowsPerPage); // 가져올 개수
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
	     * 꼬리말의 어드민 전체 총 갯수
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
					subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
				}else if(part.equals("2")){
					//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
					subSql = " AND USER_NAME LIKE '%"+keyword+"%' \n";
				}else{
					subSql = " AND USER_ID LIKE '%"+keyword+"%' \n";
				}
	            
	     }	 
	        
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT count(*) from asan.TBRD_COMMENT_DE ");
	        sql.append(" WHERE BOARD_SEQ= ?  AND USE_YN='1' ");
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
	     * 꼬리말 사용자 리스트 정보를 가져온다. </br>
	     * @param rowsPerPage 페이지별 row 수 
	     * @param requestedPage 호출 페이지 번호
	     * @param part 검색할 디비컬럼
	     * @param keyword 검색한 단어
	     * @param board_seq 메인 게시판 일련번호
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @author 임형수
	     */
	    public Tbrd_comment_de_bean[] getFrontCommentList(int rowsPerPage, int requestedPage, String part,
	                 String keyword, int board_seq )  throws  DbException , Exception {
	        //System.out.println("!getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	         
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	        String subSql =" ";
	        StringBuffer query = new StringBuffer();
	        int chk_page = requestedPage-1;


			         
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
		      
//			 페이징 처리
			 /*
	        if(chk_page > 0){
				query = new StringBuffer();
		    	query.append(" SELECT  BOARD_SEQ, COMMENT_SEQ, USER_ID,   \n");
		        query.append(" USER_NAME , CONTENT , REG_DATE, TITLE ,USE_YN \n");
		        query.append(" FROM asan.TBRD_COMMENT_DE WHERE COMMENT_SEQ not in \n");
		        query.append(" ( SELECT COMMENT_SEQ from  \n");
		        query.append(" 		( SELECT COMMENT_SEQ FROM asan.TBRD_COMMENT_DE WHERE BOARD_SEQ = "+board_seq+"  \n");
		        query.append(          subSql              );
		        query.append("        ORDER BY COMMENT_SEQ DESC \n");
		        query.append("        FETCH FIRST "+((requestedPage-1) * rowsPerPage)+"   \n");
		        query.append("        ROWS ONLY     ");
		        query.append("       ) AS TMP       ");
		        query.append(" ) AND \n");
		        query.append(" BOARD_SEQ = "+board_seq+"   \n");
		        query.append(subSql);
		        query.append("   ORDER BY COMMENT_SEQ DESC \n");
		        query.append(" FETCH FIRST "+rowsPerPage+" ROWS ONLY  \n");
		 
	        }else{        	
				query = new StringBuffer();
		    	query.append(" SELECT  BOARD_SEQ, COMMENT_SEQ, USER_ID,   \n");
		        query.append(" USER_NAME , CONTENT , REG_DATE, TITLE ,USE_YN  \n");
		        query.append(" FROM asan.TBRD_COMMENT_DE   \n");
		        query.append(" WHERE BOARD_SEQ = "+board_seq+"   \n");
		        query.append(subSql);			
		        query.append(" ORDER BY COMMENT_SEQ DESC \n");
	        	query.append(" FETCH FIRST "+rowsPerPage+" ROWS ONLY  \n");
	        }*/
	        
			query.append(" SELECT * FROM ( SELECT RowNum AS RNUM, X.* FROM ( \n");
		    	query.append(" SELECT  BOARD_SEQ, COMMENT_SEQ, USER_ID,   \n");
		        query.append(" USER_NAME , CONTENT , REG_DATE, TITLE ,USE_YN  \n");
		        query.append(" FROM asan.TBRD_COMMENT_DE   \n");
		        query.append(" WHERE BOARD_SEQ = "+board_seq+"   \n");
		        query.append(subSql);			
		        query.append(" ORDER BY COMMENT_SEQ DESC \n");
		    query.append(" ) X ) X1 \n");
	        query.append("WHERE X1.RNum > "+ (requestedPage-1)*rowsPerPage +" and X1.RNum <= "+ requestedPage*rowsPerPage +" \n");
	  
	        
	        //System.out.println("getList  --  query  => \n"+query);
	        try {         
	            pstmt = dbconn.prepareStatement(query.toString());
	            // 변수 바인딩
	            //pstmt.setInt(1, board_seq);
	            //pstmt.setInt(2, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // 시작페이지
	            //pstmt.setInt(3, requestedPage * rowsPerPage); // 가져올 개수
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
	     * 꼬리말의 사용자 전체 총 갯수
	     * @param part 검색할 디비컬럼
	     * @param keyword 검색한 단어
	     * @param board_seq 메인 게시판 일련번호
	     * @return rtnValue int  꼬리말의 전체 총 갯수
	     * @throws DbException
	     * @throws Exception
	     * @author 임형수
	     */
		public int  getFrontCommentTotalCount(String part, String keyword, int board_seq) throws  DbException , Exception  { 
	        
		    Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String query = "";
	        String subSql =" ";
	        String tempPart = "";
	        int rtnValue = 0;
	          
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
	        
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT count(*) from asan.TBRD_COMMENT_DE ");
	        sql.append(" WHERE BOARD_SEQ= ?   ");
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
			.append(" a.CONTENT, a.USER_ID , a.USER_NAME, a.USE_YN,		")				
			.append(" a.BOARD_TOP_NO , a.READ_NUM , a.REG_DATE, a.RECOMM_NUM, b.REAL_NAME, b.VIRTUAL_NAME				")				
			.append(" FROM asan.TBRD_BOARD_MA a left outer join asan.TBRD_ATTACH_FILE_DE b on (a.board_seq = b.board_seq)		")								
			.append(" WHERE a.BOARD_SEQ = ?			").toString();
          
  		//System.out.println("getBoardView  --    => \n"+query);
		
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
     * 게시글 내용 등록 + 첨부파일 내용 등록
     * @param data Tbrd_board_ma_bean
     * @param attach_date  Map 첨부파일 정보
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     */
	public int insert(Tbrd_board_ma_bean data, Map attach_data) throws DbException , Exception {
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
				.append("  	USER_ID, USER_NAME, PASSWORD ) ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?,   ")
				.append("  	?, ?, ?)   ").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,"19");
				pstmt.setString(3,data.getTitle());
				pstmt.setString(4,data.getContent());
				pstmt.setString(5,data.getUser_id());
				pstmt.setString(6,data.getUser_name());
				pstmt.setString(7,data.getPassword());

				result = pstmt.executeUpdate();
			}

			//System.out.println("inert result==>"+result);
			if(result > 0){

					attach_result = insertAttachFile(dbconn, attach_data, board_seq);
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
        CommonBoard commonDao  = new CommonBoard();
        int attache_seq = 0;
		try {     
			dbconn.setAutoCommit(false);

			if(data != null){	
				for(int pos = 0; pos<data.size()/2; pos++){
					
					attache_seq = commonDao.getAttachFileNextSeq(dbconn);
					
					String real_name	= (String)data.get("real_name"+pos);
					String vir_name		= (String)data.get("virtual_name"+pos);
					
					String query = new StringBuffer()
					.append("  INSERT INTO asan.TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(?, ?, ?, ?)   ").toString(); 

					pstmt = dbconn.prepareStatement(query);
					// 변수 바인딩
					pstmt.setInt(1,attache_seq);
					pstmt.setString(2,real_name);	
					pstmt.setString(3,vir_name);	
					pstmt.setInt(4,board_seq);

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
	     * 꼬리말 등록 + 꼬리말 갯수 update
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
	        int commentSeq = commonDao.getCommendDeNextSeq(dbconn);

  
             
	        // SQL 
	          
	        StringBuffer sql = new StringBuffer();
	        sql.append(" INSERT INTO asan.TBRD_COMMENT_DE  ");
	        sql.append("     (COMMENT_SEQ, USER_ID, USER_NAME,   ");
	        sql.append("     CONTENT,   BOARD_SEQ )  ");
	        sql.append(" VALUES (? , ? , ?,  ");
	        sql.append("     ?, ?  )");
	        
	        //System.out.println("sql==========>"+sql);
	        //System.out.println("commentSeq==========>"+commentSeq);
	        int exe = 0;
	        try {
	            pstmt = dbconn.prepareStatement(sql.toString()); 
	            // 변수 바인딩
	            pstmt.setInt(1, commentSeq);
	            pstmt.setString(2, bean.getUser_id());
	            pstmt.setString(3, bean.getUser_name());
	            pstmt.setString(4, bean.getContent());
	            pstmt.setInt(5, bean.getBoard_seq());
	           
	          
	            exe = pstmt.executeUpdate();
	            pstmt.close();
	            dbconn.commit();


	            //코멘트 겟수 증가 
	            exe = commonDao.updateCommentNum(dbconn, bean.getBoard_seq());
	             
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
				.append(" UPDATE asan.TBRD_BOARD_MA			")
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
      * @author 임형수 
      */
	 private int updateAttachFile(Connection dbconn, Map data, int board_seq) throws DbException , Exception {

		PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
        CommonBoard commonDao  = new CommonBoard();
        int attache_seq = -1;

		try {
			if(data != null){
				dbconn.setAutoCommit(false);
			
				String sql = new StringBuffer()
				.append("  DELETE FROM asan.TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ = ?  ").toString();
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setInt(1,board_seq);
				result = pstmt.executeUpdate();
				
				pstmt.close();

				
				for(int pos = 0; pos<data.size()/2; pos++){
					String real_name	= (String)data.get("real_name"+pos);
					String vir_name		= (String)data.get("virtual_name"+pos);
					

			        attache_seq = commonDao.getAttachFileNextSeq(dbconn);
			        
					String query = new StringBuffer()
					.append("  INSERT INTO asan.TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(?, ?, ?, ?)   ").toString();

					pstmt = dbconn.prepareStatement(query);

					pstmt.setInt(1,attache_seq);	
					pstmt.setString(2,real_name);	
					pstmt.setString(3,vir_name);	
					pstmt.setInt(4,board_seq);

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
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return result;

		 }
	    /**
	     *  게시글  내용 완전  삭제 
	     * @param comment_seq  꼬릿말 일련번호
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
			
			 
			result = pstmt.executeUpdate();
			
			if(result>0){
			    deleteRefCommentComplete(dbconn,board_seq);
			    deleteRefAttachComplete(dbconn,board_seq);
			    deleteRecommComplete(dbconn,board_seq);
			    dbconn.commit();
			}else{
				dbconn.rollback();
			}
			

			pstmt.close();

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
	     *  꼬리글  삭제 
	     * @param board_seq 메인 게시판 일련번호
	     * @param comment_seq 꼬리글 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */ 
	    public  int deleteComment(int comment_seq) 
	        throws DbException , Exception 
	    {   
	         //System.out.println("comment_seq=="+comment_seq);
	        // Get connection(auto commit false)            
	        Connection dbconn = getConnection(false);
	        PreparedStatement pstmt = null;

	        // SQL
	        StringBuffer sql = new StringBuffer();
			sql.append(" UPDATE asan.TBRD_COMMENT_DE			");
			sql.append(" SET USE_YN='0'					");
			sql.append(" WHERE COMMENT_SEQ=?				");	
			
	        
	        //System.out.println("sql=="+sql);
	        int exe = 0;
	        try {
	            pstmt = dbconn.prepareStatement(sql.toString()); 
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
	     *  게시글 꼬릿말 내용 완전  삭제 
	     * @param comment_seq  꼬릿말 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteCommentComplete(int comment_seq) throws DbException , Exception {
		Connection dbconn = getConnection();	
     PreparedStatement pstmt = null;
     ResultSet rs = null;        
     int result  = 0;

		StringBuffer sql = new StringBuffer();

		try { 
			sql = new StringBuffer();
			sql.append(" DELETE FROM asan.TBRD_COMMENT_DE WHERE COMMENT_SEQ=?			");
			
			pstmt = dbconn.prepareStatement(sql.toString());
			pstmt.setInt(1,comment_seq);
			
			
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
	     *  관련 꼬릿말 내용 완전  삭제 
	     * @param board_seq  
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteRefCommentComplete(Connection dbconn, int board_seq) throws DbException , Exception {
	
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;        
	  int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try { 
				sql = new StringBuffer();
				sql.append(" DELETE FROM asan.TBRD_COMMENT_DE WHERE BOARD_SEQ=?			");
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				
				
				result = pstmt.executeUpdate();
	
				pstmt.close();
	
			} catch (SQLException e) {
			  	e.printStackTrace();
			      throw new DbException(e.getMessage());
			  }finally{
		          release(pstmt);
		      }
			  return result;

	 }
	 
	    /**
	     *  첨부파일 내용 완전  삭제 
	     * @param attach_seq  첨부파일 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteAttachComplete(Connection dbconn, int attach_seq) throws DbException , Exception {
	
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;        
	  int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try { 
				sql = new StringBuffer();
				sql.append(" DELETE FROM asan.TBRD_ATTACH_FILE_DE ATTACH_FILE_SEQ=?			");
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,attach_seq);
				
				
				result = pstmt.executeUpdate();
	
				pstmt.close();
	
			} catch (SQLException e) {
			  	e.printStackTrace();
			      throw new DbException(e.getMessage());
			  }finally{
		          release(pstmt);
		      }
			  return result;

	 }
	 
	    /**
	     *  관련 첨부파일 내용 완전  삭제 
	     * @param comment_seq  꼬릿말 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteRefAttachComplete(Connection dbconn, int board_seq) throws DbException , Exception {
	
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;        
	  int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try { 
				sql = new StringBuffer();
				sql.append(" DELETE FROM asan.TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ=?			");
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				
				
				result = pstmt.executeUpdate();
	
				pstmt.close();
	
			} catch (SQLException e) {
			  	e.printStackTrace();
			      throw new DbException(e.getMessage());
			  }finally{
		          release(pstmt);
		      }
			  return result;

	 }
	 
	 

	    /**
	     *  추천인 목록  완전  삭제 
	     * @param comment_seq  꼬릿말 일련번호
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteRecommComplete(Connection dbconn, int board_seq) throws DbException , Exception {
	
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;        
	  int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try { 
				sql = new StringBuffer();
				sql.append(" DELETE FROM asan.TBRD_RECOMMEND_HS WHERE BOARD_SEQ=?			");
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,board_seq);
				
				
				result = pstmt.executeUpdate();
	
				pstmt.close();
	
			} catch (SQLException e) {
			  	e.printStackTrace();
			      throw new DbException(e.getMessage());
			  }finally{
		          release(pstmt);
		      }
			  return result;

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
			sql.append(" DELETE FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ=? ");			
			
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
		sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , USER_ID, USER_NAME,					");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM				");
		sql.append(" FROM  asan.TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='19' and BOARD_SEQ = ?	AND USE_YN='1'		");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,  USER_ID, USER_NAME,		");
		sql.append("  TITLE , CONTENT ,	READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='19' AND  BOARD_SEQ > ?	AND USE_YN='1'		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ , USER_ID, USER_NAME,		");
		sql.append("  TITLE , CONTENT ,	READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='19' AND  BOARD_SEQ < ?	AND USE_YN='1'		");
		sql.append(" )		");	 
		
		
		//System.out.println("------------------------------>\n"+sql);

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

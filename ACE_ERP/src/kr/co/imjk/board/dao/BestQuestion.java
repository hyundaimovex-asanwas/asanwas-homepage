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
public class BestQuestion  extends DAOHome{

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
    public Tbrd_board_ma_bean[] getList(int pageSize, int requestedPage, String searchTypeCode, String part, String keyword ) throws  Exception{
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
        
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        StringBuffer sql  = null;
        String subSql =" ";
        int chk_page = requestedPage-1;
        
        /*
        int allListNum = 0;  //가져올 전체 리스트 ROW 사이즈 
        int viewRowNum = 0;  //보여줄  ROW 수 
        
        int lastPageNum = (allCount/pageSize)+1; //현재 개시된 게시물의  최종 페이지  넘버
        int requestPageRowNum = allCount%pageSize;    //요청된 페이지에서서 보여줄 ROW 수   
        if(requestPageRowNum==0) requestPageRowNum =pageSize; //나머지가  [0] 이면 페이지 싸이즈 만큼 가져온다. 

        
        allListNum = (requestedPage * pageSize);
        
        //최종 페이지를 호출한 상태 
        if(requestedPage == lastPageNum){
        	//보여줄 ROW수 = 전체 ROW수 의 나머지 이다 .
        	viewRowNum = requestPageRowNum;
        }else{        	
        	//보여줄 ROW 수 = 페이지 싸이즈 이다 .
        	viewRowNum = pageSize;
        }
        

       //      SQL  
        sql = new StringBuffer();
        sql.append("   SELECT  \n");
		sql.append("   BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
        sql.append("   CONTENT, USER_ID , USE_YN, TYPE_CODE   \n");
		sql.append("   FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '06'  AND USE_YN='1' \n");
		sql.append(subSql);
		sql.append("   ORDER BY BOARD_SEQ  \n");
		
          
		
		 
		query = new StringBuffer();
        query.append(" SELECT * 	\n");
		query.append(" FROM TABLE ( \n");
		query.append("   SELECT *  \n");
		query.append("   FROM TABLE  ( \n");
		query.append(sql.toString());
		query.append("     FETCH FIRST "+allListNum+" ROWS ONLY) AS TMP  \n").toString();
		query.append("   ORDER BY BOARD_SEQ DESC \n");
		query.append(" FETCH FIRST "+viewRowNum+" ROWS ONLY) AS TMP1 \n");
		query.append(" ORDER BY BOARD_SEQ DESC \n"); 
  
        
		
        */

        
        if(!keyword.equals("")){
        	if(searchTypeCode.equals("")){
        		//키워드 O, 분류선택 X, 검색종류 X 
        		if(part.equals("1")){
    				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
                //키워드 O ,분류선택 X, 검색종류 O 
    			}else{
    				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
    				//subSql = " AND CONTENT LIKE '%"+keyword+"%'  \n";
    				subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
    			}	
        	}else{ 
                //키워드 O, 분류선택 O, 검색종류 X  
        		if(part.equals("")){
        				subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
                //키워드 O, 분류선택 O, 검색종류 O
        		}else{
            		if(part.equals("1")){
        				subSql = " AND TITLE LIKE '%"+keyword+"%' AND TYPE_CODE = '"+searchTypeCode+"'  \n";
        			}else{
        				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
        				subSql = " AND CONTENT LIKE '%"+keyword+"%' AND TYPE_CODE LIKE '"+searchTypeCode+"' \n";
        			}		
        		}
        	}  
        }else{
            // 키워드 X, 분류선택 O, 검색종류 X 
        	if(!searchTypeCode.equals("")){
        		subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  \n";
        	//키워드 X, 분류 선택 X ,검색종류 X 
        	}else{
        		subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
        	}
        	
        }
        
//		 페이징 처리
        if(chk_page > 0){
			query = new StringBuffer();
	    	query.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n");
	        query.append(" CONTENT, USER_ID , USE_YN, TYPE_CODE , READ_NUM \n");
	        query.append(" FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ not in \n");
	        query.append(" ( SELECT BOARD_SEQ from  \n");
	        query.append(" 		( SELECT BOARD_SEQ FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '06'  AND USE_YN='1' \n");
	        query.append(          subSql              );
	        query.append("        ORDER BY BOARD_SEQ DESC \n");
	        query.append("        FETCH FIRST "+((requestedPage-1) * pageSize)+"   \n");
	        query.append("        ROWS ONLY     ");
	        query.append("       ) AS TMP       ");
	        query.append(" ) AND \n");
	        query.append(" BOARD_TYPE = '06' AND USE_YN='1' \n");
	        query.append(subSql);
	        query.append("   ORDER BY BOARD_SEQ DESC \n");
	        query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
	 
        }else{        	
			query = new StringBuffer();
	    	query.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n");
	        query.append(" CONTENT, USER_ID , USE_YN, TYPE_CODE, READ_NUM  \n");
	        query.append(" FROM asan.TBRD_BOARD_MA   \n");
	        query.append(" WHERE BOARD_TYPE = '06' AND USE_YN='1' \n");
	        query.append(subSql);			
	        query.append(" ORDER BY BOARD_SEQ DESC \n");
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
     * 자주 묻는 질문 게시판의 전체 총 갯수
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author 임형수
     */
	public int getTotalCount(String searchTypeCode,String part, String keyword ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuffer query = null;
        String subSql =" ";

		int totalCount = 0;
		
        if(!keyword.equals("")){
        	if(searchTypeCode.equals("")){
        		//키워드 O, 분류선택 X, 검색종류 X 
        		if(part.equals("1")){
    				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
                //키워드 O ,분류선택 X, 검색종류 O 
    			}else{
    				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
    				//subSql = " AND CONTENT LIKE '%"+keyword+"%'  \n";
    				subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
    			}	
        	}else{ 
                //키워드 O, 분류선택 O, 검색종류 X  
        		if(part.equals("")){
        				subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
                //키워드 O, 분류선택 O, 검색종류 O
        		}else{
            		if(part.equals("1")){
        				subSql = " AND TITLE LIKE '%"+keyword+"%' AND TYPE_CODE = '"+searchTypeCode+"'  \n";
        			}else{
        				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
        				subSql = " AND CONTENT LIKE '%"+keyword+"%' AND TYPE_CODE LIKE '"+searchTypeCode+"' \n";
        			}		
        		}
        	} 
        }else{
            // 키워드 X, 분류선택 O, 검색종류 X 
        	if(!searchTypeCode.equals("")){
        		subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  \n";
        	//키워드 X, 분류 선택 X ,검색종류 X 
        	}else{
        		subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
        	}
        	
        }

		query = new StringBuffer();
			query.append(" SELECT COUNT(*) as TOTAL \n");
			query.append(" from asan.TBRD_BOARD_MA \n");
			query.append(" WHERE BOARD_TYPE = '06' AND USE_YN='1' \n");
		    query.append(subSql).toString(); 

		    System.out.println("getTotalCount  --  query  => \n"+query);
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
        System.out.println("totalCount====>"+totalCount);
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
			query.append(" TYPE_CODE,  USE_YN, READ_NUM , REG_DATE	");
			query.append(" FROM asan.TBRD_BOARD_MA									");
			query.append("  WHERE BOARD_SEQ = "+board_seq+"	").toString(); 
			
			System.out.println("getBoardView  --  query  => \n"+query);
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
     * 자주 묻는 질문 게시판  게시글 내용 등록
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
			//System.out.println("data.getContent()=>"+data.getContent()+"\n");
			dbconn.setAutoCommit(false);
			 
			
			nextSeq   =getNextSeq(dbconn);
		         
			if(data != null){	
				String query = new StringBuffer()
				.append("  INSERT INTO asan.TBRD_BOARD_MA   ")
				.append("  	(BOARD_TYPE, BOARD_SEQ,  REF_NO, TITLE,    ")
				.append("  	CONTENT, USER_ID, TYPE_CODE )  ")
				.append("  VALUES   ")
				.append("  	( '06', ?, ?, ?,   ")
				.append("  	?, ?, ?)   ").toString(); 

				System.out.println("query=>"+query+"\n");
				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setInt(1,nextSeq);
				pstmt.setInt(2,data.getRef_no());					
				pstmt.setString(3,data.getTitle());
				pstmt.setString(4,data.getContent());
				pstmt.setString(5,data.getUser_id());
				pstmt.setString(6,data.getType_code());

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
				.append(" 	TYPE_CODE=?					")
				.append(" WHERE BOARD_SEQ=?				").toString(); 

				pstmt = dbconn.prepareStatement(query);
				// 변수 바인딩
				pstmt.setString(1,data.getTitle());
				pstmt.setString(2,data.getContent());					
				pstmt.setString(3,data.getType_code());
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

	 
	    /**  
	     * 자주 묻는 질문 게시판의  현재 게시물과 이전,이후 게시물의 목록
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
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM	,TYPE_CODE			");
		sql.append(" FROM  asan.TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='06' and USE_YN='1' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM ,TYPE_CODE				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='06' and USE_YN='1' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM ,TYPE_CODE				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='06' and USE_YN='1' AND  BOARD_SEQ < ?		");
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

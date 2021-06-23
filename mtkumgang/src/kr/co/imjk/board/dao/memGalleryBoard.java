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
 * @author �ڻ��
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class memGalleryBoard  extends DAOHome{

    /**  
     * �ַ�����  �Խ��� ����Ʈ ������ �����´�. </br>
     * @param rowsPerPage �������� row �� 
     * @param requestedPage ȣ�� ������ ��ȣ
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author ������ 
     */  
    
    public Tbrd_board_ma_bean[] getList(int pageSize, int requestedPage, int allCount, String part, String keyword ) throws  Exception{
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
        
       /*
        int allListNum = 0;  //������ ��ü ����Ʈ ROW ������ 
        int viewRowNum = 0;  //������  ROW �� 
        
        int lastPageNum = (allCount/pageSize)+1; //���� ���õ� �Խù���  ���� ������  �ѹ�
        int requestPageRowNum = allCount%pageSize;    //��û�� ������������ ������ ROW ��   
        if(requestPageRowNum==0) requestPageRowNum =pageSize; //��������  [0] �̸� ������ ������ ��ŭ �����´�. 

        
        allListNum = (requestedPage * pageSize);
        
        //���� �������� ȣ���� ���� 
        if(requestedPage == lastPageNum){
        	//������ ROW�� = ��ü ROW�� �� ������ �̴� .
        	viewRowNum = requestPageRowNum;
        }else{        	
        	//������ ROW �� = ������ ������ �̴� .
        	viewRowNum = pageSize;
        }
        
        */
        
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

       //SQL
        /*
          SELECT  
		     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    
		     A.CONTENT, A.USER_ID , A.USER_NICK, A.USE_YN,      
		     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    
		     B.REAL_NAME, B.VIRTUAL_NAME  
		 FROM asan.TBRD_BOARD_MA  A right outer join (   
			SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   
			FROM asan.TBRD_ATTACH_FILE_DE A,( 
				SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   
				FROM asan.TBRD_ATTACH_FILE_DE    
				GROUP BY BOARD_SEQ  
				) AS B
			WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ   
		 ) AS B   ON A.BOARD_SEQ = B.BOARD_SEQ
                 where A.BOARD_TYPE='04'  
		 ORDER BY  A.REG_DATE DESC  
       */
        
       
        StringBuffer sql = new StringBuffer();
        
        sql.append(" SELECT  \n");
		sql.append("     A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    \n");
		sql.append("     A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,      \n");
		sql.append("     A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    \n");
		sql.append("     B.REAL_NAME, B.VIRTUAL_NAME  \n");
		sql.append(" FROM asan.TBRD_BOARD_MA  A right outer join (   \n");
		sql.append("     SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   \n");
		sql.append("     FROM asan.TBRD_ATTACH_FILE_DE A,(  \n");
		sql.append("         SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   \n");
		sql.append("         FROM asan.TBRD_ATTACH_FILE_DE    \n");
		sql.append("         GROUP BY BOARD_SEQ    \n");
		sql.append("         ) AS B     \n");
		sql.append("     WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ   \n");
		sql.append(" ) AS B   \n");
		sql.append(" ON A.BOARD_SEQ = B.BOARD_SEQ   \n");
		sql.append(" WHERE A.BOARD_TYPE='04' AND USE_YN='1'  \n");
		sql.append(subSql);
		sql.append(" ORDER BY  A.BOARD_SEQ  DESC  \n"); 
		

        /*
		 if(requestedPage != lastPageNum){
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
		 }else{
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
			 
		 }
		
       
        */
         
		/*
	
		SELECT 
		A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    
		A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,      
		A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM, A.BOARD_TYPE,
		B.REAL_NAME, B.VIRTUAL_NAME
		FROM
		(
			 SELECT 
		        BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,    
			    CONTENT, USER_ID , USER_NAME, USE_YN,      
			    BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM, BOARD_TYPE
			 FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ not in 
			         ( SELECT BOARD_SEQ from  
			         	( SELECT BOARD_SEQ FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '04'  AND USE_YN='1'            
			                ORDER BY BOARD_SEQ DESC 
			                FETCH FIRST 6  
			                ROWS ONLY     
			             ) AS TMP       
			         ) AND 
			  BOARD_TYPE = '04' AND USE_YN='1' 
			  ORDER BY BOARD_SEQ DESC 
			  FETCH FIRST 6 ROWS ONLY
		) A right outer join (   
					           SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   
					           FROM asan.TBRD_ATTACH_FILE_DE A,(  
					              SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   
					              FROM asan.TBRD_ATTACH_FILE_DE    
					              GROUP BY BOARD_SEQ    
					              ) AS B     
					         WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ   
					        ) AS B   
		ON A.BOARD_SEQ = B.BOARD_SEQ   
		WHERE A.BOARD_TYPE='04'  AND A.USE_YN='1' 
		ORDER BY  A.BOARD_SEQ DESC ;  



                   SELECT  
			        A.BOARD_SEQ, A.REF_NO , A.LEVEL_NO , A.SORT_NO , A.TITLE,    
			        A.CONTENT, A.USER_ID , A.USER_NAME, A.USE_YN,      
			        A.BOARD_TOP_NO , A.READ_NUM , A.REG_DATE, A.RECOMM_NUM,    
			        B.REAL_NAME, B.VIRTUAL_NAME  
			        FROM asan.TBRD_BOARD_MA  A right outer join (   
			           SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ   
			           FROM asan.TBRD_ATTACH_FILE_DE A,(  
			              SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ   
			              FROM asan.TBRD_ATTACH_FILE_DE    
			              GROUP BY BOARD_SEQ    
			              ) AS B     
			         WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ   
			        ) AS B   
			        ON A.BOARD_SEQ = B.BOARD_SEQ   
			        WHERE A.BOARD_TYPE='04'  
			        ORDER BY  A.BOARD_SEQ DESC  
                    FETCH FIRST 6 ROWS ONLY 

	       */ 
		
		
//		 ����¡ ó��
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
			query.append(" 	         	( SELECT BOARD_SEQ FROM asan.TBRD_BOARD_MA WHERE BOARD_TYPE = '04'  AND USE_YN='1'  \n");            
			query.append(" 	                ORDER BY BOARD_SEQ DESC   \n");
			query.append(" 	                FETCH FIRST "+((requestedPage-1) * pageSize)+"    \n");
			query.append(" 	                ROWS ONLY       \n");
			query.append(" 	             ) AS TMP         \n");
			query.append(" 	         ) AND   \n");
			query.append(" 	  BOARD_TYPE = '04' AND USE_YN='1'   \n");
			query.append(subSql);
			query.append(" 	  ORDER BY BOARD_SEQ DESC   \n");
			query.append(" 	  FETCH FIRST "+pageSize+" ROWS ONLY  \n");
			query.append(" ) A right outer join (     \n");
			query.append(" 			           SELECT A.BOARD_SEQ ,A.REAL_NAME, A.VIRTUAL_NAME, A.ATTACH_FILE_SEQ     \n");
			query.append(" 			           FROM asan.TBRD_ATTACH_FILE_DE A,(    \n");
			query.append(" 			              SELECT  BOARD_SEQ AS BOARD_SEQ, MIN(ATTACH_FILE_SEQ) AS ATTACH_FILE_SEQ     \n");
			query.append(" 			              FROM asan.TBRD_ATTACH_FILE_DE      \n");
			query.append(" 			              GROUP BY BOARD_SEQ      \n");
			query.append(" 			              ) AS B       \n");
			query.append(" 			         WHERE A.ATTACH_FILE_SEQ = B.ATTACH_FILE_SEQ     \n");
			query.append(" 			        ) AS B     \n");
			query.append(" ON A.BOARD_SEQ = B.BOARD_SEQ     \n");
			query.append(" WHERE A.BOARD_TYPE='04' AND A.USE_YN='1'    \n");
			query.append(" ORDER BY  A.BOARD_SEQ DESC     \n");
	 
        }else{        	
			query = new StringBuffer();
	        query.append(sql);			
        	query.append(" FETCH FIRST "+pageSize+" ROWS ONLY  \n");
        }
       
		
		System.out.println("getList  --  query  => \n"+query);
		
		
        try {         
            pstmt = dbconn.prepareStatement(query.toString());
 
            // ��� ���
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
     * �ַ����� �Խ����� ��ü �� ����
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
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
		.append(" WHERE BOARD_TYPE = '04' AND USE_YN='1' \n")
		.append(subSql).toString(); 
		
			
		//System.out.println("getList  --  query  => \n"+query);
		try {         
            pstmt = dbconn.prepareStatement(query);
            // ���� ���ε�
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
	     *  �Խù� ���� ����
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return Tbrd_board_ma_bean []
	     * @throws DbException
	     * @throws Exception
	     * @author �ڻ��
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

        try {         
            pstmt = dbconn.prepareStatement(query);
            // ���� ���ε�
            pstmt.setInt(1, board_seq); 

            // ��� ���
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
     * ÷�� ���� ���� ���� 
     * @param board_seq ���� �Խ��� �Ϸù�ȣ
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
            // ���� ���ε�
            pstmt.setInt(1, board_seq); 

            // ��� ���
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
     * �Խñ� ���� ��� + ÷������ ���� ���
     * @param data Tbrd_board_ma_bean
     * @param attach_date  Map ÷������ ����
     * @return exe int 1:���� , 0:����
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
				// ���� ���ε�
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,"04");
				pstmt.setString(3,data.getTitle());
				pstmt.setString(4,data.getContent());
				pstmt.setString(5,data.getUser_id());
				pstmt.setString(6,data.getUser_name());
				pstmt.setString(7,data.getPassword());

				result = pstmt.executeUpdate();
			}

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
	  * ÷������ ���� ���
	  * @param dbconn Connection 
	  * @param data Map ÷������ ����
	  * @param board_seq int ���� �Խ��� �Ϸù�ȣ
	  * @return exe int 1:���� , 0:����
	  * @throws DbException
	  * @throws Exception
	  */
	 private int insertAttachFile(Connection dbconn, Map data, int board_seq) throws DbException , Exception {
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result  = 0;
        CommonBoard commonDao  = new CommonBoard();
        int attache_seq = commonDao.getAttachFileNextSeq(dbconn);
		try {     
			dbconn.setAutoCommit(false);

			if(data != null){	
				for(int pos = 0; pos<data.size()/2; pos++){
					String real_name	= (String)data.get("real_name"+pos);
					String vir_name		= (String)data.get("virtual_name"+pos);
					
					String query = new StringBuffer()
					.append("  INSERT INTO asan.TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(?, ?, ?, ?)   ").toString(); 

					pstmt = dbconn.prepareStatement(query);
					// ���� ���ε�
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
      * �Խñ� ���� ���� + ÷������ ���� ����
      * @param data Tbrd_board_ma_bean
      * @param attach_data Map ÷������ ����
      * @return exe int 1:���� , 0:����
      * @throws DbException
      * @throws Exception
      * @author �ڻ��
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
				// ���� ���ε�
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
      * ÷������ ���� ���� 
      * @param dbconn Connection 
      * @param data  Map ÷������ ����
      * @param board_seq int  ���� �Խ��� �Ϸù�ȣ
      * @return exe int 1:���� , 0:����
      * @throws DbException
      * @throws Exception
      * @author �ڻ�� 
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
				.append("  DELETE FROM asan.TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ = ?  ").toString();
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
					.append("  INSERT INTO asan.TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?)   ").toString();

					pstmt = dbconn.prepareStatement(query);
					// ���� ���ε�
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
	     *  �Խñ� ���� ���� 
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return exe int 1:���� , 0:����
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
	  * �Խñ� ���� ���� 
	  * @param dbconn Connection 
	  * @param board_seq int ���� �Խ��� �Ϸù�ȣ
	  * @return exe int 1:���� , 0:����
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
	     * �Խù� ���� Ƚ�� ���� 
	     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
	     * @return exe int 1:���� , 0:����
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
	     * �ַ����� �Խ�����  ���� �Խù��� ����,���� �Խù��� ���
	     * @param board_seq int ���� �Խ��� �Ϸù�ȣ
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
		sql.append(" WHERE BOARD_TYPE ='04' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='04' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM asan.TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM asan.TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='04' AND  BOARD_SEQ < ?		");
		sql.append(" )		");	 
		//System.out.println("------------------------------>"+sql);

		try {         
            pstmt = dbconn.prepareStatement(sql.toString());
            // ���� ���ε�
            pstmt.setInt(1, board_seq); 
			pstmt.setInt(2, board_seq); 
			pstmt.setInt(3, board_seq); 

            // ��� ���
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

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
 * @author ������ 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class BestQuestion  extends DAOHome{

    /**
     * ���� ���� ����  �Խ����� ����Ʈ
     * @param pageSize �������� row �� 
     * @param requestedPage ȣ�� ������ ��ȣ
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return Tbrd_board_ma_bean[] 
     * @throws DbException
     * @throws Exception
     * @author ������
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
        		//Ű���� O, �з����� X, �˻����� X 
        		if(part.equals("1")){
    				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
                //Ű���� O ,�з����� X, �˻����� O 
    			}else{
    				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
    				//subSql = " AND CONTENT LIKE '%"+keyword+"%'  \n";
    				subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
    			}	
        	}else{ 
                //Ű���� O, �з����� O, �˻����� X  
        		if(part.equals("")){
        				subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
                //Ű���� O, �з����� O, �˻����� O
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
            // Ű���� X, �з����� O, �˻����� X 
        	if(!searchTypeCode.equals("")){
        		subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  \n";
        	//Ű���� X, �з� ���� X ,�˻����� X 
        	}else{
        		subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
        	}
        	
        }
        
//		 ����¡ ó��
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
     * ���� ���� ���� �Խ����� ��ü �� ����
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author ������
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
        		//Ű���� O, �з����� X, �˻����� X 
        		if(part.equals("1")){
    				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
                //Ű���� O ,�з����� X, �˻����� O 
    			}else{
    				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
    				//subSql = " AND CONTENT LIKE '%"+keyword+"%'  \n";
    				subSql = " AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
    			}	
        	}else{ 
                //Ű���� O, �з����� O, �˻����� X  
        		if(part.equals("")){
        				subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  AND  (TITLE LIKE '%"+keyword+"%' OR  CONTENT LIKE '%"+keyword+"%')   \n";
                //Ű���� O, �з����� O, �˻����� O
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
            // Ű���� X, �з����� O, �˻����� X 
        	if(!searchTypeCode.equals("")){
        		subSql = "  AND TYPE_CODE = '"+searchTypeCode+"'  \n";
        	//Ű���� X, �з� ���� X ,�˻����� X 
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
        System.out.println("totalCount====>"+totalCount);
        return totalCount;

	 }
 
	
    /**
     *  �Խù� ���� ����
     * @param board_seq ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author ������
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
     *  �Խ��� NEXT SEQ �� ���ϱ� 
     * @param Connection dbconn  
      * @return int nextSeq �ִ밪+1
     * @throws DbException
     * @throws Exception
     * @author ������
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
            // ��� ���
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
     * ���� ���� ���� �Խ���  �Խñ� ���� ���
     * @param bean  Tbrd_board_ma_bean
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     * @author ������
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
				// ���� ���ε�
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
     * �Խñ� ���� ���� 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     * @author ������
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
				// ���� ���ε�
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
	     * �Խù� ���� Ƚ�� ���� 
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
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
	     * ���� ���� ���� �Խ�����  ���� �Խù��� ����,���� �Խù��� ���
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
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

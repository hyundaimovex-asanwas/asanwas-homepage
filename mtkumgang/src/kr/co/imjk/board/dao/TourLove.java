/*
 * Created on 2006. 4. 19.
 *
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
 * @author �ɵ���
 * @modiry : ����� ���� �̺�Ʈ. 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourLove  extends DAOHome{ 

    /**
     * ������  �Խ����� ��ü �� ����
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
     */
    public Tbrd_board_ma_bean[] getList(int requestedPage, int pageSize, String part, String keyword ) throws  Exception{
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
        
        int chk_page = requestedPage-1;
        
        
        if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
			}else if(part.equals("2")){
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND USER_NAME LIKE '%"+keyword+"%' \n";
			}else if(part.equals("3")){
				subSql = " AND USER_ID LIKE '%"+keyword+"%' \n";
			}
        }	  

        // 2014-11-14 SDH ����Ŭ ������ ����
        query = new StringBuffer()
        .append("SELECT * FROM ( \n")
        .append(" SELECT RowNum as RNUM, X.* FROM ( \n")
        .append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
    	.append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
    	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, RECOMM_NUM \n")
    	.append(" from asan.TBRD_BOARD_MA  \n")
    	.append(" where board_type='13'  and USE_YN = '1' \n")
    	.append(subSql)			
    	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
    	.append("      ) X \n")
        .append(" ) X1 \n")
        .append("WHERE X1.RNum > "+ (requestedPage-1)*pageSize +" and X1.RNum <= "+ requestedPage*pageSize +" \n").toString();
	        
        /* ����¡ ó��
        if(chk_page > 0){      
        	query = new StringBuffer() 
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n")
	        .append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
	        .append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, RECOMM_NUM \n")
	        .append(" from asan.TBRD_BOARD_MA where board_seq not in \n")
	        .append(" ( select board_seq from  \n")
	        .append(" 		( select board_seq from asan.TBRD_BOARD_MA where board_type='13' and USE_YN = '1' \n")
	        .append(subSql)			
	        .append(" 		  order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	        .append(" as tmp ) and \n")
	        .append(" board_type='13'  and USE_YN = '1' \n")
	        .append(subSql)	
	        .append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO ")
	        .append(" fetch first "+pageSize+" rows only  \n").toString();
			
        }else{         	
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
        	.append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
        	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, RECOMM_NUM \n")
        	.append(" from asan.TBRD_BOARD_MA  \n")
        	.append(" where board_type='13'  and USE_YN = '1' \n")
        	.append(subSql)			
        	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
        	.append(" fetch first 10 rows only  \n").toString();
        }
        */
        //System.out.println("getList  --  query  => \n"+query);
	 
        try {         
			//System.out.println("1111111111111\n");
            pstmt = dbconn.prepareStatement(query);
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
     * ������  �Խ����� ��ü �� ����(������ �Խù�����)
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
     */
    public Tbrd_board_ma_bean[] getFrontList(int requestedPage, int pageSize, String part, String keyword ) throws  Exception{
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
        
        int chk_page = requestedPage-1;
        
        
        if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
			}else if(part.equals("2")){
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND USER_NAME LIKE '%"+keyword+"%' \n";
			}else if(part.equals("3")){
				subSql = " AND USER_ID LIKE '%"+keyword+"%' \n";
			}
        }	  


        // 2014-11-14 SDH ����Ŭ ������ ����
        query = new StringBuffer()
        .append("SELECT * FROM ( \n")
        .append(" SELECT RowNum as RNUM, X.* FROM ( \n")
        .append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
    	.append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
    	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, RECOMM_NUM \n")
    	.append(" from asan.TBRD_BOARD_MA  \n")
    	.append(" where board_type='13'  and USE_YN = '1' \n")
    	.append(subSql)			
    	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
    	.append("      ) X \n")
        .append(" ) X1 \n")
        .append("WHERE X1.RNum > "+ (requestedPage-1)*pageSize +" and X1.RNum <= "+ requestedPage*pageSize +" \n").toString();
	      
        /* ����¡ ó��
        if(chk_page > 0){      
        	query = new StringBuffer() 
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n")
	        .append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
	        .append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, RECOMM_NUM, COMMENT_NUM \n")
	        .append(" from asan.TBRD_BOARD_MA where board_seq not in \n")
	        .append(" ( select board_seq from  \n")
	        .append(" 		( select board_seq from asan.TBRD_BOARD_MA where board_type='13'  AND USE_YN = '1' \n")
	        .append(subSql)			
	        .append(" 		  order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	        .append(" as tmp ) and \n")
	        .append(" board_type='13'  \n")
	        .append(subSql)	
	        .append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO ")
	        .append(" fetch first "+pageSize+" rows only  \n").toString();
			
        }else{         	
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
        	.append(" CONTENT, USER_ID , USER_NAME, USE_YN, \n")
        	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, RECOMM_NUM, COMMENT_NUM \n")
        	.append(" from asan.TBRD_BOARD_MA  \n")
        	.append(" where board_type='13' AND USE_YN='1'\n")
        	.append(subSql)			
        	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
        	.append(" fetch first 10 rows only  \n").toString();
        }
        */
        //System.out.println("getList  --  query  => \n"+query);
	 
        try {         
			//System.out.println("1111111111111\n");
            pstmt = dbconn.prepareStatement(query);
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
     * �����ı� �Խ����� ����Ʈ���� ����
     * @param board_seq ����Ʈ������ ������ ��ȣ    
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
     */
    public int setBest(int board_seq, String mode ) throws  Exception{
    	Connection dbconn = getConnection();
        PreparedStatement pstmt = null; 
        String query = "";
        int result = 0;

        query = new StringBuffer()
        .append(" UPDATE asan.TBRD_BOARD_MA	 SET BEST = '"+mode+"' WHERE  BOARD_SEQ = "+board_seq+"").toString();
        //System.out.println("==board_seq==>"+board_seq);
        System.out.println("==+++++++++++++++++++==>"+query);
        
        

        
        try {  
        	dbconn.setAutoCommit(false);
        	
        	pstmt = dbconn.prepareStatement(query); 
        	result = pstmt.executeUpdate();

			if(result > 0){
				dbconn.commit();
			}else{
				dbconn.rollback();
			}
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return result;
    }
    
    
	public String getTestString(String str) throws Exception{
		return str;
	}
 
    
    /**
     * ������ �Խ����� ��ü �� ����
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author ������
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
			}else if(part.equals("2")){
				subSql = " AND USER_ID LIKE '%"+keyword+"%' \n";
			}
            
        }	

		query = new StringBuffer()
			.append(" SELECT COUNT(*) as TOTAL \n")
			.append(" from asan.TBRD_BOARD_MA \n")
			.append(" WHERE BOARD_TYPE = '13'  and USE_YN = '1' \n")
			.append(subSql).toString(); 

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
     * @author ������
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
			.append(" SELECT												")
			.append(" REF_NO , LEVEL_NO , SORT_NO , TITLE,		")
			.append(" CONTENT, USER_ID , USER_NICK, USE_YN, USER_ICON, 					")
			.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, EMAIL, USER_NAME					")
			.append(" FROM asan.TBRD_BOARD_MA									")
			.append("  WHERE BOARD_SEQ = ?			").toString(); 

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
     *  �Խù� BEST ����
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
     */
	public Tbrd_board_ma_bean [] getBestList() 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
        
      
        
        // SQL
		String query = new StringBuffer()
			.append(" SELECT												")
			.append(" REF_NO , LEVEL_NO , SORT_NO , TITLE,		")
			.append(" CONTENT, USER_ID , USER_NICK, USE_YN,					")
			.append(" BOARD_TOP_NO , READ_NUM , REG_DATE					")
			.append(" FROM asan.TBRD_BOARD_MA									")
			.append(" WHERE board_type='13' and USE_YN = '1' AND BEST = '1'		")
        	.append(" ORDER BY BOARD_SEQ DESC FETCH FIRST 1 ROWS ONLY ").toString(); 
        try {         
            pstmt = dbconn.prepareStatement(query);
            // ���� ���ε�

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
     * ������ �Խ���  �Խñ� ���� ���
     * @param bean  Tbrd_board_ma_bean
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
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
			System.out.println("===============================");
			System.out.println("board_seq : " + board_seq);
			System.out.println("===============================");
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
				// ���� ���ε�
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
     * �亯�� �Խñ� �亯�� ��� 
     * @param data Tbrd_board_ma_bean
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author ������
     */
    public  int reply(Tbrd_board_ma_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int seq = 0;
        
        //�ڽź��� ū ���� ��ȣ 1�� ���� update
        StringBuffer updateSql = new StringBuffer();
        updateSql.append(" UPDATE asan.TBRD_BOARD_MA SET SORT_NO=SORT_NO+1  ");
        updateSql.append(" WHERE REF_NO=? AND SORT_NO > ? AND BOARD_TYPE = '13' ").toString();;
        
        pstmt = dbconn.prepareStatement(updateSql.toString()); 
        pstmt.setInt(1, bean.getRef_no());
        pstmt.setInt(2, bean.getSort_no());
        pstmt.executeUpdate();
        
        pstmt.close();           
        
        
        //�޼��� ������ ����
        CommonBoard commonDao = new CommonBoard();
		
		
		seq = commonDao.getBoardMaNextSeq(dbconn);

        // SQL
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO asan.TBRD_BOARD_MA  ");
        sql.append("    (BOARD_SEQ, REF_NO, SORT_NO, LEVEL_NO,  ");
        sql.append("     TITLE, CONTENT, USER_ID, USER_NAME, READ_NUM,  ");
        sql.append("     BOARD_TYPE, EMAIL)  ");
        sql.append(" VALUES ( ? , ? , ?, ?,  ");
        sql.append("     ?, ?, ?, ?, 0, ");
        sql.append("     '13', ?)  ");
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // ���� ���ε�
            pstmt.setInt(1, seq);
            pstmt.setInt(2, bean.getRef_no());
            pstmt.setInt(3, bean.getSort_no()+1);
            pstmt.setInt(4, bean.getLevel_no()+1);
            pstmt.setString(5, bean.getTitle());
            pstmt.setString(6,bean.getContent());
			pstmt.setString(7,bean.getUser_id());
			pstmt.setString(8,bean.getUser_name());
			pstmt.setString(9,bean.getEmail());

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
        return exe;
    }
    
    /**
     * �Խñ� ���� ���� 
     * @param data Tbrd_board_ma_bean
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
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
				// ���� ���ε�
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
	 
	 
	 /**
	     *  �Խñ� ���� ���� (USE_YN = 0)
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return exe int 1:���� , 0:����
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteUpdate(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();	
     PreparedStatement pstmt = null;
     ResultSet rs = null;        
     int result  = 0;

		StringBuffer sql = new StringBuffer();

		try { 
			sql.append(" UPDATE asan.TBRD_BOARD_MA SET USE_YN='0' WHERE BOARD_SEQ=? ");			
			
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
	     * ��õ�ϱ� ȸ�� ���� 
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return exe int 1:���� , 0:����
	     * @throws DbException
	     * @throws Exception
	     */
	 public int updateRecommnum(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();	
     PreparedStatement pstmt = null;
     ResultSet rs = null;        
     int result  = 0;

		StringBuffer sql = new StringBuffer();

		try {
			sql.append(" UPDATE asan.TBRD_BOARD_MA  ");	
			sql.append(" SET RECOMM_NUM = RECOMM_NUM + 1  ");		
			sql.append(" WHERE BOARD_SEQ = ?  ");		
			
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
	     * ������ �Խ�����  ���� �Խù��� ����,���� �Խù��� ���
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
		sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , USER_NAME	, USER_ID, USER_NICK, USER_ICON,							");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM, BEST ,REG_DATE, REF_NO, SORT_NO, LEVEL_NO				");
		sql.append(" FROM  asan.TBRD_BOARD_MA											");
		sql.append(" WHERE BOARD_TYPE ='13' and BOARD_SEQ = ?							");
		sql.append(" UNION ALL															");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ , USER_NAME, USER_ID, USER_NICK, USER_ICON, TITLE , CONTENT ,					");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM, BEST ,REG_DATE, REF_NO, SORT_NO, LEVEL_NO		 									");
		sql.append(" FROM asan.TBRD_BOARD_MA 											");
		sql.append(" WHERE BOARD_SEQ = (												");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ							");
		sql.append("     FROM asan.TBRD_BOARD_MA 										");
		sql.append("     WHERE BOARD_TYPE ='13' AND  BOARD_SEQ > ?						");
		sql.append(" )	UNION ALL														");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ , USER_NAME	, USER_ID, USER_NICK, USER_ICON, TITLE , CONTENT ,					");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM, BEST ,REG_DATE, REF_NO, SORT_NO, LEVEL_NO		 									");
		sql.append(" FROM asan.TBRD_BOARD_MA 											");
		sql.append(" WHERE BOARD_SEQ = (												");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ							");
		sql.append("     FROM asan.TBRD_BOARD_MA 										");
		sql.append("     WHERE BOARD_TYPE ='13' AND  BOARD_SEQ < ?						");
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
	 
	 
	 /**
	     *  ���� �Խù� ����Ʈ  
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return Tbrd_board_ma_bean[] 
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */  
	    public Tbrd_board_ma_bean[] getRefList(int board_seq ) 
	    throws  DbException , Exception {
	        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
	        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
	        
	        
	        Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_board_ma_bean bean = null;
	        Collection list = null; 
	 
	  
	       //      SQL  
	        StringBuffer sql = new StringBuffer();
			sql.append(" SELECT  \n");
			sql.append(" BOARD_SEQ,  REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
			sql.append(" CONTENT, USER_ID , USER_NAME, USER_NICK, USE_YN,   \n");
			sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM    \n");
			sql.append(" FROM asan.TBRD_BOARD_MA  \n");
			sql.append(" WHERE REF_NO = ?  \n");
			sql.append(" ORDER BY   BOARD_TOP_NO ,REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC  \n"); 

	        //System.out.println("getList  --  query  => \n"+query);
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
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
}

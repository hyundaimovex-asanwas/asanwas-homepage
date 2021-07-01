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
 * @author �ڻ��
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class NoticeBoard  extends DAOHome{

    /**
     * ������  �Խ����� ��ü �� ����
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
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

       //      SQL  
        String sql = new StringBuffer()
            .append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n")
            .append(" BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n")
            .append(" CONTENT, USER_ID , USER_NICK, USE_YN,   \n")
            .append(" BOARD_TOP_NO , READ_NUM , REG_DATE    \n")
            .append(" FROM TBRD_BOARD_MA  \n")
			.append(" WHERE BOARD_TYPE = '01' \n")
            .append(subSql)
            .append(" ORDER BY REF_NO DESC,SORT_NO, LEVEL_NO , REG_DATE DESC, BOARD_TOP_NO  \n").toString(); 
        
         
        // ����¡ ó��
        // JDBC 2.0 �� CURSOR ���� �ӵ� ����. QUERY�� �ذ� 
        query = new StringBuffer()
            .append("\n select *  from \n")
            .append("(")
            .append(" select rownum as rownum_idx, inlineView.* from \n")
            .append(" ( \n")
            .append(sql)
            .append(" )inlineView \n")
            .append(")where rownum_idx between ? and ? \n").toString(); 
  
        
        //System.out.println("getList  --  query  => \n"+query);
	
        try {         
            pstmt = dbconn.prepareStatement(query);
            // ���� ���ε�
            pstmt.setInt(1, ((requestedPage * rowsPerPage) - rowsPerPage) + 1);  // ����������
            pstmt.setInt(2, requestedPage * rowsPerPage); // ������ ����
            //System.out.println(" start :"+((requestedPage * rowsPerPage) - rowsPerPage) + 1 + "/end:"+requestedPage * rowsPerPage);
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
			}else{
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND CONTENT LIKE '%"+keyword+"%' \n";
			}
            
        }	

		query = new StringBuffer()
			.append(" SELECT COUNT(*) as TOTAL \n")
			.append(" from TBRD_BOARD_MA \n")
			.append(" WHERE BOARD_TYPE = '01' \n")
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
			.append(" CONTENT, USER_ID , USER_NICK, USE_YN,					")
			.append(" BOARD_TOP_NO , READ_NUM , REG_DATE					")
			.append(" FROM TBRD_BOARD_MA									")
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
		
		try {     
			System.out.println("data.getContent()=>"+data.getContent()+"\n");
			dbconn.setAutoCommit(false);
			
			if(data != null){	
				String query = new StringBuffer()
				.append("  INSERT INTO TBRD_BOARD_MA   ")
				.append("  	(BOARD_SEQ, BOARD_TYPE, REF_NO, LEVEL_NO, SORT_NO, TITLE, CONTENT, USER_ID, USER_NAME,   ")
				.append("  	USER_NICK, USER_LEVEL, USER_ICON,  ")
				.append("  	PASSWORD)   ")
				.append("  VALUES   ")
				.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?,   ")
				.append("  	?, ?, ?,   ")
				.append("  	?)   ").toString(); 

				System.out.println("query=>"+query+"\n");
				pstmt = dbconn.prepareStatement(query);
				// ���� ���ε�
				pstmt.setString(1,data.getBoard_type());
				pstmt.setInt(2,data.getRef_no());					
				pstmt.setInt(3,data.getLevel_no());
				pstmt.setInt(4,data.getSort_no());

				pstmt.setString(5,data.getTitle());
				pstmt.setString(6,data.getContent());
				pstmt.setString(7,data.getUser_id());
				pstmt.setString(8,data.getUser_name());

				pstmt.setString(9,data.getUser_nick());
				pstmt.setString(10,data.getUser_level());
				pstmt.setString(11,data.getUser_icon());

				pstmt.setString(12,data.getPassword());

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
				.append(" UPDATE TBRD_BOARD_MA			")
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
			sql.append(" DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ=? ");			
			
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
		sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM				");
		sql.append(" FROM  TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='01' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
		sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='01' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
		sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='01' AND  BOARD_SEQ < ?		");
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

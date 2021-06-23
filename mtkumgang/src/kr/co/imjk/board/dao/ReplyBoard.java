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
public class ReplyBoard  extends DAOHome{

     
    /**
     * �亯�� �Խ����� ��ü �� ����
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author ������
     */
	public int  getTotalCount(String part, String keyword) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        int rtnValue = 0;
        if(!keyword.equals("")){
            if(part.equals("2")){
                tempPart = "CONTENT";
            }else{
                tempPart = "TITLE";
            }
            subSql = " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
        }	 
        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT count(*) from TBRD_BOARD_MA ");
        sql.append(" WHERE BOARD_TYPE='02' ");
        sql.append(subSql);
	    
       // System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           
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
     * �亯�� �Խ��� ����Ʈ ������ �����´�. </br>
     * @param rowsPerPage �������� row �� 
     * @param requestedPage ȣ�� ������ ��ȣ
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author ������
     */
    
    public Tbrd_board_ma_bean[] getList(int rowsPerPage, int requestedPage, String part, String keyword ) 
    throws  DbException , Exception {
        //System.out.println("!getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
         
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        String subSql =" ";
        String tempPart = "";
        
        
        if(!keyword.equals("")){
            if(part.equals("2")){
                tempPart = "CONTENT";
            }else{
                tempPart = "TITLE";
            }
            subSql = " AND  "+tempPart+" LIKE '%"+keyword+"%' \n";
        }	
 
       //      SQL  
        StringBuffer sql = new StringBuffer();
		sql.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n");
		sql.append(" BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
		sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,   \n");
		sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM, USER_NAME    \n");
		sql.append(" FROM TBRD_BOARD_MA  \n");
		sql.append(" WHERE BOARD_TYPE='02'  \n");
		sql.append(subSql);
		sql.append(" ORDER BY   BOARD_TOP_NO, REF_NO DESC,SORT_NO, LEVEL_NO , REG_DATE DESC  \n"); 
		         
         
        // ����¡ ó��
        // JDBC 2.0 �� CURSOR ���� �ӵ� ����. QUERY�� �ذ� 
		StringBuffer query = new StringBuffer();
			query.append("\n select  *   from \n");
			query.append("(");
			query.append(" select rownum as rownum_idx, inlineView.* from \n");
			query.append(" ( \n");
			query.append(sql);
			query.append(" )inlineView \n");
			query.append(")where rownum_idx between ? and ? \n"); 
  
        
        //System.out.println("getList  --  query  => \n"+query);
        try {         
            pstmt = dbconn.prepareStatement(query.toString());
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
     *  �Խù� ���� ����
     * @param board_seq ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @throws Exception
     * @author ������
     */
    public Tbrd_board_ma_bean[] getBoardView(int board_seq ) 
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
		sql.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n");
		sql.append(" BOARD_SEQ,  REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
		sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,    \n");
		sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM ,   \n");
		sql.append(" USER_NAME    \n");
		sql.append(" FROM TBRD_BOARD_MA  \n");
		sql.append(" WHERE BOARD_SEQ=?  \n");


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
		sql.append(" SELECT /*+ INDEX(TBRD_BOARD_MA_IDX_2) */ \n");
		sql.append(" BOARD_SEQ,  REF_NO , LEVEL_NO , SORT_NO , TITLE,   \n");
		sql.append(" CONTENT, USER_ID , USER_NICK, USE_YN,   \n");
		sql.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM    \n");
		sql.append(" FROM TBRD_BOARD_MA  \n");
		sql.append(" WHERE REF_NO = ?  \n");
		sql.append(" ORDER BY   BOARD_TOP_NO ,REF_NO DESC,SORT_NO, LEVEL_NO , REG_DATE DESC  \n"); 

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
    
    /**
     * �亯�� �Խ���  �Խñ� ���� ���
     * @param bean  Tbrd_board_ma_bean
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author ������
     */
    public int insert(Tbrd_board_ma_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int seq = 0;
        //�޼��� ������ ����
        StringBuffer seqSql  = new StringBuffer();
        seqSql.append("SELECT TBRD_BOARD_MA_SEQ.NEXTVAL FROM DUAL").toString();
        
        pstmt = dbconn.prepareStatement(seqSql.toString());            
        rs = pstmt.executeQuery();
        
        while(rs.next()){
            seq = rs.getInt(1);
        }
        
        rs.close();
        pstmt.close();
 
        // SQL
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO TBRD_BOARD_MA  ");
        sql.append("     (BOARD_SEQ, REF_NO, SORT_NO, LEVEL_NO,  ");
        sql.append("     TITLE, CONTENT,  USER_ID, REG_DATE,   ");
        sql.append("     BOARD_TYPE, BOARD_TOP_NO ,USER_NAME )  ");
        sql.append(" VALUES (?, ? , 0, 0,  ");
        sql.append("     ?, ?, ?,  SYSDATE, ");
        sql.append("     '02' , ?, ? ) ");
        int exe = 0;
        try { 
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // ���� ���ε�
            pstmt.setInt(1, seq);
            pstmt.setInt(2, seq);
            pstmt.setString(3, bean.getTitle());
            // varchar2(4000) �� stream ���� �ݵ�� ó��
            java.io.StringReader sr = new java.io.StringReader(bean.getContent());
            pstmt.setCharacterStream(4, sr, bean.getContent().length());
            
            pstmt.setString(5, bean.getUser_id());
            pstmt.setInt(6, bean.getBoard_top_no() );
            pstmt.setString(7, bean.getUser_name() );
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
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     * @author ������
     */
    public  int update(Tbrd_board_ma_bean bean) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append(" UPDATE TBRD_BOARD_MA set TITLE=?, CONTENT=? ")
           .append(" WHERE  BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // ���� ���ε�            
            pstmt.setString(1, bean.getTitle());
            pstmt.setString(2, bean.getContent());
            pstmt.setInt(3, bean.getBoard_seq());
            
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
        updateSql.append(" UPDATE TBRD_BOARD_MA SET SORT_NO=SORT_NO+1  ");
        updateSql.append(" WHERE REF_NO=? AND SORT_NO > ? AND BOARD_TYPE = '02' ").toString();;
        
        pstmt = dbconn.prepareStatement(updateSql.toString()); 
        pstmt.setInt(1, bean.getRef_no());
        pstmt.setInt(2, bean.getSort_no());
        pstmt.executeUpdate();
        
        pstmt.close();           
        
        
        //�޼��� ������ ����
        StringBuffer seqSql  = new StringBuffer();
        seqSql.append("SELECT TBRD_BOARD_MA_SEQ.NEXTVAL FROM DUAL").toString();
        
        pstmt = dbconn.prepareStatement(seqSql.toString());            
        rs = pstmt.executeQuery();
        
        while(rs.next()){
            seq = rs.getInt(1);
        }
        
        rs.close();
        pstmt.close();

        // SQL
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO TBRD_BOARD_MA  ");
        sql.append("    (BOARD_SEQ, REF_NO, SORT_NO, LEVEL_NO,  ");
        sql.append("     TITLE, CONTENT, USER_ID,READ_NUM,  ");
        sql.append("     REG_DATE ,BOARD_TYPE)  ");
        sql.append(" VALUES ( ? , ? , ?, ?,  ");
        sql.append("     ?, ?, ?, 0, ");
        sql.append("     SYSDATE, '02')  ");
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql.toString()); 
            // ���� ���ε�
            pstmt.setInt(1, seq);
            pstmt.setInt(2, bean.getRef_no());
            pstmt.setInt(3, bean.getSort_no()+1);
            pstmt.setInt(4, bean.getLevel_no()+1);
            pstmt.setString(5, bean.getTitle());
            // varchar2(4000) �� stream ���� �ݵ�� ó��
            java.io.StringReader sr = new java.io.StringReader(bean.getContent());
            pstmt.setCharacterStream(6, sr, bean.getContent().length());
            
            pstmt.setString(7, bean.getUser_id());

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
     *  �Խñ� ���� ���� 
     * @param board_seq ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     */
    public  int delete(int board_seq) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append("DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // ���� ���ε�
            pstmt.setInt(1,board_seq);
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
     * �Խù� ���� Ƚ�� ���� 
     * @param board_seq ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean []
     * @throws DbException
     * @throws Exception
     */
    public  int updateReadnum(int board_seq) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append(" UPDATE TBRD_BOARD_MA set READ_NUM=READ_NUM+1 ")
           .append(" WHERE  BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // ���� ���ε�            

            pstmt.setInt(1, board_seq);
            
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
}

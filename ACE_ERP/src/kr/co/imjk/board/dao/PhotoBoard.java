/*
 * Created on 2006. 4. 25.
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
import java.util.Map;

import kr.co.imjk.board.bean.Tbrd_attach_file_de_bean;
import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.util.Util;

/**
 * @author ������
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PhotoBoard extends DAOHome{

    /**
     * ���� �Խ����� ��ü �� ����
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
        sql.append(" WHERE BOARD_TYPE='09' ");
        sql.append(subSql);
        /*
        sql.append(" SELECT   \n");
		sql.append("   count(*)  \n");
		sql.append(" FROM( \n");
		sql.append("     SELECT \n");
		sql.append("       BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n");
		sql.append("       CONTENT, USER_ID , USER_NICK, USE_YN,  \n");
		sql.append("       BOARD_TOP_NO , READ_NUM , REG_DATE, RECOMM_NUM  \n");
		sql.append("     FROM TBRD_BOARD_MA  WHERE BOARD_TYPE = '09'  \n");
		sql.append(subSql);
		sql.append(" ) A,(  \n");
		sql.append("  SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ ,  \n");
		sql.append("      COUNT(BOARD_SEQ) FILE_NUM  \n");
		sql.append("  FROM  \n");
		sql.append("  TBRD_ATTACH_FILE_DE \n" );
		sql.append("  GROUP BY BOARD_SEQ \n");
		sql.append(" ) B \n");
		sql.append(" WHERE A.BOARD_SEQ = B.BOARD_SEQ(+) \n");
		*/
		
       //System.out.println("getTotalCount  --  query  => \n"+sql);
       
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
     * ���� �Խ��� ����Ʈ ������ �����´�. </br>
     * @param rowsPerPage �������� row �� 
     * @param requestedPage ȣ�� ������ ��ȣ
     * @param part �˻��� ����÷�
     * @param keyword �˻��� �ܾ�
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @author ������
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
		sql.append(" AND A.BOARD_TYPE='09'  \n");
		sql.append(subSql);
		sql.append(" ORDER BY  A.REG_DATE DESC   \n"); 
		

        
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
     * ���� �Խ�����  ���� �Խù��� ����,���� �Խù��� ���
     * @param board_seq int ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @throws Exception
     */
    public Tbrd_board_ma_bean[] getPrevAndNextBoard(int board_seq ) 
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
        sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM				");
		sql.append(" FROM  TBRD_BOARD_MA								");
		sql.append(" WHERE BOARD_TYPE ='09' and BOARD_SEQ = ?			");
		sql.append(" UNION ALL												");
        sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='09' AND  BOARD_SEQ > ?		");
		sql.append(" )	UNION ALL		");		
        sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,				");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				");
		sql.append(" FROM TBRD_BOARD_MA 								");
		sql.append(" WHERE BOARD_SEQ = (			");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
		sql.append("     FROM TBRD_BOARD_MA 			");
		sql.append("     WHERE BOARD_TYPE ='09' AND  BOARD_SEQ < ?		");
		sql.append(" )		");	


        //System.out.println("getList  --  query  => \n"+sql);
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
		sql.append(" SELECT  \n");
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
    * �Խñ� ���� + ÷������ ���� ����
    * @param board_seq ���� �Խ��� �Ϸù�ȣ
    * @return Tbrd_board_ma_bean []
    * @throws DbException
    * @throws Exception
    */
	public Tbrd_board_ma_bean [] getBoardAndFileView(int board_seq) 
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
			.append(" FROM TBRD_ATTACH_FILE_DE						")								
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
     * ���ñ� ����� ����.
     * @param board_seq ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @throws Exception
     * @author ������
     */
    
    public Tbrd_board_ma_bean[] getRefBoardList(int board_seq ) 
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
     * ���� �Խ���  �Խñ� ���� ���
     * @param bean  Tbrd_board_ma_bean
     * @return  exe int  1:���� , 0:����
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
        sql.append("     TITLE, CONTENT,  USER_ID, REG_DATE,  ");
        sql.append("     BOARD_TYPE, BOARD_TOP_NO)  ");
        sql.append(" VALUES (?, ? , 0, 0,  ");
        sql.append("     ?, ?, ?,  SYSDATE, ");
        sql.append("     '09' , ? ) ");
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
     * �Խñ� ���� ��� + ÷������ ���� ���
     * @param data Tbrd_board_ma_bean
     * @param attach_date  Map ÷������ ����
     * @return  exe int  1:���� , 0:����
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
				// ���� ���ε�
				pstmt.setInt(1,board_seq);
				pstmt.setString(2,data.getBoard_type());
				pstmt.setInt(3,data.getRef_no());					
				pstmt.setInt(4,data.getLevel_no());
				pstmt.setInt(5,data.getSort_no());
 
				pstmt.setString(6,data.getTitle());
				 // varchar2(4000) �� stream ���� �ݵ�� ó��
	            java.io.StringReader sr = new java.io.StringReader(data.getContent());
	            pstmt.setCharacterStream(7, sr, data.getContent().length());
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
				    //÷������ ���� ���
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
	  * ÷������ ���� ���
	  * @param dbconn Connection 
	  * @param data Map ÷������ ����
	  * @param board_seq int  ���� �Խ��� �Ϸù�ȣ
	  * @return exe int 1:���� , 0:����
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
					
					//System.out.println("real_name : " + real_name);
					//System.out.println("vir_name : " + vir_name);
					//System.out.println("board_seq : " + board_seq);

					String query = new StringBuffer()
					.append("  INSERT INTO TBRD_ATTACH_FILE_DE   ")
					.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
					.append("  VALUES   ")
					.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?)   ").toString(); 

					pstmt = dbconn.prepareStatement(query);
					// ���� ���ε�

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
      * �Խñ� ���� ���� + ÷������ ���� ����
      * @param data Tbrd_board_ma_bean
      * @param attach_data Map ÷������ ����
      * @return exe int  1:���� , 0:����
      * @throws DbException
      * @throws Exception
      * @author ������
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
					// ���� ���ε�
					pstmt.setString(1,data.getTitle());	
					 // varchar2(4000) �� stream ���� �ݵ�� ó��
		            java.io.StringReader sr = new java.io.StringReader(data.getContent());
		            pstmt.setCharacterStream(2, sr, data.getContent().length());
					pstmt.setString(3,data.getPassword());
					pstmt.setInt(4,data.getBoard_seq());

					result = pstmt.executeUpdate();

					if(result > 0){
						if(attach_data != null){
						    //÷������ ����  ����
							attach_result = updateAttacheFile(dbconn, attach_data, data.getBoard_seq());
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
	        	dbconn.rollback();
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
	      * @param board_seq int ���� �Խ��� �Ϸù�ȣ
	      * @return exe int 1:���� , 0:����
	      * @throws DbException
	      * @throws Exception
	      * @author ������
	      */
		 private int updateAttacheFile(Connection dbconn, Map data, int board_seq) throws DbException , Exception {
			
			PreparedStatement pstmt = null;
	        ResultSet rs = null;        
	        int result  = 0;
			
			try {
				if(data != null){
					dbconn.setAutoCommit(false);
				
					String sql = new StringBuffer()
					.append("  DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ = ?  ").toString();
					pstmt = dbconn.prepareStatement(sql);
					pstmt.setInt(1,board_seq);
					result = pstmt.executeUpdate();
					
					pstmt.close();
					
					for(int pos = 0; pos<data.size()/2; pos++){
						String real_name	= (String)data.get("real_name"+pos);
						String vir_name		= (String)data.get("virtual_name"+pos);
						
						
						

						String query = new StringBuffer()
						.append("  INSERT INTO TBRD_ATTACH_FILE_DE   ")
						.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
						.append("  VALUES   ")
						.append("  	(TBRD_BOARD_MA_SEQ.NEXTVAL, ?, ?, ?)   ").toString();

						pstmt = dbconn.prepareStatement(query);
						// ���� ���ε�

						pstmt.setString(1,real_name);	
						pstmt.setString(2,vir_name);	
						pstmt.setInt(3,board_seq);

						result = pstmt.executeUpdate();

						pstmt.close();
						
					}
				}else{
					dbconn.rollback();
				}

			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }
	        return result;

		 }


    
    /**
     * ÷������ ���� ���� + �Խñ� ���� ���� 
     * @param board_seq int ���� �Խ��� �Ϸù�ȣ
     * @return 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
	 public int delete(int board_seq) throws DbException , Exception {

		Connection dbconn = getConnection();	
       PreparedStatement pstmt = null;
       ResultSet rs = null;        
       int result			= 0;
		int attach_result	= 0;

		String sql = "";

		try { 
			dbconn.setAutoCommit(false);
			//÷������  ���� ����
			sql =" DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ=? ";				
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setInt(1,board_seq);
			pstmt.executeUpdate();
			pstmt.close();
			
			//�Խ��� �� ����  ����
			result = deleteMaster(dbconn, board_seq);
			if(result > 0){					
					dbconn.commit();
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
	     * �������� ÷������ ���� ���� + �������� �Խñ� ���� ���� 
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return exe int 1:���� , 0:����
	     * @throws DbException
	     * @throws Exception 
	     */
		 public int deleteMulti(String boardSeqList) throws DbException , Exception {

			Connection dbconn = getConnection();	
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;        
	       int result			= 0;
			int attach_result	= 0;

			String sql = "";

			try { 
				dbconn.setAutoCommit(false);
				//÷������  ���� ����
				sql =" DELETE FROM TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ IN ("+boardSeqList+") ";				
				pstmt = dbconn.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
				
				
				//�Խ��� �� ����  ����
				result = deleteMasterMulti(dbconn, boardSeqList);
				
				//System.out.println("�Խ��� �� ����  ���� :"+result);
				if(result > 0){					
						dbconn.commit();
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
	       
	       return result;

		 }
	      
		 /**
		  * �������� �Խñ� ���� ���� 
		  * @param dbconn  ���ؼ�
		  * @param board_seq ���� �Խ��� �Ϸù�ȣ
		  * @return exe int 1:���� , 0:����
		  * @throws DbException
		  * @throws Exception
		  */
		 private int deleteMasterMulti(Connection dbconn, String boardSeqList) throws DbException , Exception {
			PreparedStatement pstmt = null;
	       ResultSet rs = null;        
	       int result	= 0;

			StringBuffer sql = new StringBuffer();

			try { 
				sql.append(" DELETE FROM TBRD_BOARD_MA WHERE BOARD_SEQ IN ("+boardSeqList+") ");			
				
				pstmt = dbconn.prepareStatement(sql.toString());
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
      * ÷������ ���� ����
      * @param vir_name ÷������ ���� �̸�
      * @return exe int 1:���� , 0:����
      * @throws DbException
      * @throws Exception
      */
	 public int deleteAttachFile(String vir_name) throws DbException , Exception {
		Connection dbconn = getConnection();	
        PreparedStatement pstmt = null;
        ResultSet rs = null;        
        int result			= 0;
		
		StringBuffer sql = new StringBuffer();
		try { 

			sql.append(" DELETE FROM TBRD_ATTACH_FILE_DE WHERE VIRTUAL_NAME=? ");	
			pstmt = dbconn.prepareStatement(sql.toString());
			pstmt.setString(1,vir_name);
			
			 
			result = pstmt.executeUpdate();
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
     * �Խù� ���� Ƚ�� ���� 
     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
     * @return exe int 1:���� , 0:����
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

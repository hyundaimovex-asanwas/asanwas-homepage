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
public class TourSympathy  extends DAOHome{

	/**
	 * �����ڸ�Ʈ�� �Խ����� ��ü �� ����
	 * @param part �˻��� ����÷�
	 * @param keyword �˻��� �ܾ�
	 * @return rtnValue int �Ѱ���
	 * @throws DbException
	 * @throws Exception
	 * @author ������ 
	 */
	public int  getTotalCount(String part, String keyword, String board_type) throws  DbException , Exception  { 
	    
	    Connection dbconn = getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "";
	    String subSql = " ";
	    String tempPart = "";
	    int rtnValue = 0;
	    
	    subSql = " AND STATUS = '0' ";
	    
	    if(!keyword.equals("")){
	        if(part.equals("2")){
	            tempPart = "CONTENT";
	        }else{
	            tempPart = "TITLE";
	        }
	        subSql = subSql + " AND "+tempPart+" LIKE '%"+keyword+"%'  \n";
	    }	 
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append(" SELECT count(*) from asan.TBRD_BOARD_MA ");
	    sql.append(" WHERE BOARD_TYPE='"+board_type+"' ");
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
			subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
        }	 

   
        // ����¡ ó��
        if(chk_page > 0){
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n")
	        .append(" CONTENT, USER_ID , USER_NICK, USE_YN, \n")
	        .append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, COMMENT_NUM, STATUS \n")
	        .append(" from asan.TBRD_BOARD_MA where board_seq not in \n")
	        .append(" ( select board_seq from  \n")
	        .append(" 		( select board_seq from asan.TBRD_BOARD_MA where board_type='02' and USE_YN = '1' \n")
	        .append(subSql)			
	        .append(" 		  order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	        .append(" as tmp ) and \n")
	        .append(" board_type='02'  and USE_YN = '1' \n")
	        .append(subSql)	
	        .append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO ")
	        .append(" fetch first "+pageSize+" rows only  \n").toString();
			
        }else{        	
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
        	.append(" CONTENT, USER_ID , USER_NICK, USE_YN, \n")
        	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, COMMENT_NUM, STATUS \n")
        	.append(" from asan.TBRD_BOARD_MA  \n")
        	.append(" where board_type='02'  and USE_YN = '1' \n")
        	.append(subSql)			
        	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
        	.append(" fetch first 10 rows only  \n").toString();
        }
        
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
     * ������  �Խ����� ��ü �� ����
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
        
        subSql = " AND STATUS = '0' ";
        if(!keyword.equals("")){
			subSql = subSql + " AND TITLE LIKE '%"+keyword+"%' \n";
        }	 

   
        // ����¡ ó��
        if(chk_page > 0){
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE, \n")
	        .append(" CONTENT, USER_ID , USER_NICK, USE_YN, \n")
	        .append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, COMMENT_NUM, STATUS \n")
	        .append(" from asan.TBRD_BOARD_MA where board_seq not in \n")
	        .append(" ( select board_seq from  \n")
	        .append(" 		( select board_seq from asan.TBRD_BOARD_MA where board_type='02' and USE_YN = '1' \n")
	        .append(subSql)			
	        .append(" 		  order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )  \n")
	        .append(" as tmp ) and \n")
	        .append(" board_type='02'  and USE_YN = '1' \n")
	        .append(subSql)	
	        .append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO ")
	        .append(" fetch first "+pageSize+" rows only  \n").toString();
			
        }else{        	
        	query = new StringBuffer()
        	.append(" SELECT BOARD_SEQ, REF_NO , LEVEL_NO , SORT_NO , TITLE,  \n")
        	.append(" CONTENT, USER_ID , USER_NICK, USE_YN, \n")
        	.append(" BOARD_TOP_NO , READ_NUM , REG_DATE, BEST, COMMENT_NUM, STATUS \n")
        	.append(" from asan.TBRD_BOARD_MA  \n")
        	.append(" where board_type='02'  and USE_YN = '1' \n")
        	.append(subSql)			
        	.append(" order by REF_NO DESC,SORT_NO, LEVEL_NO , BOARD_SEQ DESC, BOARD_TOP_NO \n")
        	.append(" fetch first 10 rows only  \n").toString();
        }
        
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
		.append(" a.BOARD_SEQ, a.REF_NO , a.LEVEL_NO , a.SORT_NO , a.TITLE,		")		
		.append(" a.CONTENT, a.USER_ID , a.USER_NICK, a.USE_YN,		")				
		.append(" a.BOARD_TOP_NO , a.READ_NUM , a.REG_DATE, a.STATUS, b.REAL_NAME, b.VIRTUAL_NAME , b.WIDTH				")				
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
 *  �Խù� ���� ����
 * @param board_seq ���� �Խ��� �Ϸù�ȣ
 * @return Tbrd_board_ma_bean []
 * @throws DbException
 * @throws Exception
 * @author �ڻ��
 */
public Tbrd_board_ma_bean [] getBoardView() 
throws DbException , Exception 
{
Connection dbconn = getConnection();
PreparedStatement pstmt = null;
ResultSet rs = null;
Collection list = null;

// SQL
String query = new StringBuffer()
	.append(" SELECT	")												
	.append(" a.BOARD_SEQ, a.REF_NO , a.LEVEL_NO , a.SORT_NO , a.TITLE,		")		
	.append(" a.CONTENT, a.USER_ID , a.USER_NICK, a.USE_YN,		")				
	.append(" a.BOARD_TOP_NO , a.READ_NUM , a.REG_DATE, a.STATUS, b.REAL_NAME, b.VIRTUAL_NAME , b.WIDTH				")				
	.append(" FROM asan.TBRD_BOARD_MA a left outer join asan.TBRD_ATTACH_FILE_DE b on (a.board_seq = b.board_seq)		")
	.append(" WHERE BOARD_TYPE = '02' AND USE_YN='1' AND STATUS = '1' ")
	.append(" ORDER BY a.BOARD_SEQ DESC fetch first 1 rows only 		").toString();

try {         
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
			CommonBoard commonDao = new CommonBoard();
			
			
			board_seq = commonDao.getBoardMaNextSeq(dbconn);

			String query = new StringBuffer()
			.append("  INSERT INTO asan.TBRD_BOARD_MA   ")
			.append("  	(BOARD_SEQ, BOARD_TYPE, REF_NO, LEVEL_NO, SORT_NO, TITLE, CONTENT, USER_ID, USER_NAME,   ")
			.append("  	USER_NICK, USER_LEVEL, USER_ICON,  ")
			.append("  	PASSWORD, STATUS)   ")
			.append("  VALUES   ")
			.append("  	(?, ?, ?, ?, ?, ?, ?, ?, ?,   ")
			.append("  	?, ?, ?,   ")
			.append("  	?, ?)   ").toString(); 

			pstmt = dbconn.prepareStatement(query);
			// ���� ���ε�
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
			pstmt.setString(13,data.getPassword());
			pstmt.setString(14,data.getStatus());

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
	
	try {     
		dbconn.setAutoCommit(false);

		if(data != null){	
			for(int pos = 0; pos<data.size()/2; pos++){
				String real_name	= (String)data.get("real_name"+pos);
				String vir_name		= (String)data.get("virtual_name"+pos);
				
				CommonBoard commonDao = new CommonBoard();
				
				
				int attach_file_seq = commonDao.getAttachFileNextSeq(dbconn);


				String query = new StringBuffer()
				.append("  INSERT INTO asan.TBRD_ATTACH_FILE_DE   ")
				.append("  	(ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ)   ")
				.append("  VALUES   ")
				.append("  	(?, ?, ?, ?)   ").toString(); 
				
				System.out.println("@@@@@@@@@@@@@@@@@@ query : " + query );

				pstmt = dbconn.prepareStatement(query);
				// ���� ���ε�
				pstmt.setInt(1,attach_file_seq);
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
    int board_seq		= 0;
	int attach_result	= 0;
	
	try { 
		dbconn.setAutoCommit(false);

		if(data != null){
			board_seq = data.getBoard_seq();
			
			String query = new StringBuffer()
			.append(" UPDATE asan.TBRD_BOARD_MA		")
			.append(" SET TITLE=?,					")
			.append(" 	CONTENT=?,					")
			.append(" 	PASSWORD=?,					")
			.append(" 	STATUS=?					")
			.append(" WHERE BOARD_SEQ=?				").toString(); 

			pstmt = dbconn.prepareStatement(query);
			// ���� ���ε�
			pstmt.setString(1,data.getTitle());
			pstmt.setString(2,data.getContent());					
			pstmt.setString(3,data.getPassword());
			pstmt.setString(4,data.getStatus());
			pstmt.setInt(5,board_seq);

			result = pstmt.executeUpdate();
			
			System.out.println("##################attach_data : " + attach_data);
			System.out.println("##################size : " + attach_data.size());
			//String real_name	= (String)attach_data.get("real_name");	
			//System.out.println("##################real_name : " + real_name + "#####");
			//real_name = real_name.trim();
			System.out.println("##################result : " + result + "#####");
			if(result > 0){
				if(attach_data.size() > 0){
					System.out.println("**************#####");
					attach_result = updateAttachFile(dbconn, attach_data,board_seq);
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
	
	PreparedStatement pstmt = null;
    ResultSet rs = null;        
    int result  = 0;
	
	try {
		if(data != null){
			dbconn.setAutoCommit(false);
		
			int attach_seq = 0;
			//String sql = new StringBuffer()
			//.append("  DELETE FROM asan.TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ = ?  ").toString();
			//pstmt = dbconn.prepareStatement(sql);
			//pstmt.setInt(1,board_seq);
			//result = pstmt.executeUpdate();
			//System.out.println("########################3333###############################");
			//pstmt.close();
			//System.out.println("########################result###############################" + result);
			//System.out.println("########################board_seq###############################" + board_seq);
			//if(result > 0){
			
			//for(int pos = 0; pos<data.size()/2; pos++){
			String real_name	= (String)data.get("real_name");
			String vir_name		= (String)data.get("virtual_name");
			String seq			= Util.getString((String)data.get("attach_file_seq"),"");	
			
			if(!seq.equals("")){
				attach_seq = Integer.parseInt(seq);
			}
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
				
				if(attach_seq > 0){
					String query = new StringBuffer()
					.append("  UPDATE asan.TBRD_ATTACH_FILE_DE   ")
					.append("  SET REAL_NAME = ? , VIRTUAL_NAME = ?   ")
					.append("  WHERE ATTACH_FILE_SEQ = ?   ").toString();
	
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
					pstmt.setInt(3,attach_seq);
	
					result = pstmt.executeUpdate();
	
					pstmt.close();
				}else{					
					result = insertAttachFile(dbconn, data, board_seq);	
				}
				
			//}
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
     * ÷������ ���� ���� + �Խñ� ���� ���� 
     * @param board_seq int ���� �Խ��� �Ϸù�ȣ
     * @return exe int 1:���� , 0:����
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
		sql.append(" DELETE FROM asan.TBRD_ATTACH_FILE_DE WHERE BOARD_SEQ=? ");			
		
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
	sql.append(" REF_NO , LEVEL_NO , SORT_NO , TITLE, CONTENT, USER_ID , USER_NICK, USE_YN, BOARD_TOP_NO , READ_NUM , REG_DATE, STATUS, RECOMM_NUM				");
	sql.append(" FROM  asan.TBRD_BOARD_MA								");
	sql.append(" WHERE BOARD_TYPE ='02' and BOARD_SEQ = ?			");
	sql.append(" UNION ALL												");
	sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,				");
	sql.append(" REF_NO , LEVEL_NO , SORT_NO , TITLE, CONTENT, USER_ID , USER_NICK, USE_YN, BOARD_TOP_NO , READ_NUM , REG_DATE, STATUS, RECOMM_NUM				");
	sql.append(" FROM asan.TBRD_BOARD_MA 								");
	sql.append(" WHERE BOARD_SEQ = (			");
	sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			");
	sql.append("     FROM asan.TBRD_BOARD_MA 			");
	sql.append("     WHERE BOARD_TYPE ='02' AND  BOARD_SEQ > ?		");
	sql.append(" )	UNION ALL		");		
	sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,				");
	sql.append(" REF_NO , LEVEL_NO , SORT_NO , TITLE, CONTENT, USER_ID , USER_NICK, USE_YN, BOARD_TOP_NO , READ_NUM , REG_DATE, STATUS, RECOMM_NUM				");
	sql.append(" FROM asan.TBRD_BOARD_MA 								");
	sql.append(" WHERE BOARD_SEQ = (			");
	sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			");
	sql.append("     FROM asan.TBRD_BOARD_MA 			");
	sql.append("     WHERE BOARD_TYPE ='02' AND  BOARD_SEQ < ?		");
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

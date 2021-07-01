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
 * @author �̼ҿ�
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TourFront  extends DAOHome{  

    /**
     * �������� ����Ʈ
     * @throws DbException
     * @throws Exception
     * @author �̼ҿ�
     */
    public Tbrd_board_ma_bean[] getNoticeList() throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        String query = "";
        String subSql =" ";
        String tempPart = "";
        
    	query = new StringBuffer()
    	.append(" SELECT BOARD_SEQ, TITLE       \n")
    	.append(" from asan.TBRD_BOARD_MA       \n")
    	.append(" where board_type='08'  and USE_YN = '1' \n")
    	.append(" order by BOARD_SEQ DESC         \n")
    	.append(" fetch first 4 rows only        \n").toString();
       
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
    public Tbrd_board_ma_bean[] getQuestionList() throws  Exception{

        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
        StringBuffer query = null;
        StringBuffer sql  = null;
        String subSql =" ";
       	
		query = new StringBuffer();
    	query.append(" SELECT BOARD_SEQ , TITLE, TYPE_CODE  \n");
        query.append(" FROM asan.TBRD_BOARD_MA   \n");
        query.append(" WHERE BOARD_TYPE = '06' AND USE_YN='1' \n");
        query.append(" ORDER BY BOARD_SEQ DESC  \n");
    	query.append(" FETCH FIRST 4 ROWS ONLY  \n");
 
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
    
}
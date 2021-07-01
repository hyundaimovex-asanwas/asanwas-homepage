/*
 * Created on 2006. 7. 6.
 * 
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.reservation.dao;

import java.sql.CallableStatement;
import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.io.*;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.util.Util;
import kr.co.imjk.reservation.bean.Schedule_bean;
 
/** 
 * @author �̼ҿ�
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 * 
 * @history
 * 	2008.07.16 �ݰ���/�������� ���࿡�� ���� ������ ���ڸ� �̾ƿ��� �Լ�(getMonthResv) �߰�
 */

public class ScheduleInfo  extends DAOHome{

    /**
     *  ��������
     * @return Schedule_bean []
     * @throws DbException
     * @throws Exception
     * @author �̼ҿ�
     */
	public Schedule_bean [] getHotelList()  throws DbException , Exception 
{
    Connection dbconn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Collection list = null;

    // SQL
	String query = new StringBuffer()
	.append(" SELECT                 \n")
	.append("   UPJANG_SID,          \n")
	.append("   UPJANG_CD,           \n")
	.append("   UPJANG_NM            \n")
	.append(" FROM SALES.TRM010      \n")
	.append(" WHERE UPJANG_TYPE='10'   ").toString();
	
    try {         
        pstmt = dbconn.prepareStatement(query);

        // ��� ���
        rs = pstmt.executeQuery();
        list = Selecter.execute(rs, new Schedule_bean());

        rs.close();
        pstmt.close();
    
    } catch (SQLException e) {
        throw new DbException(e.getMessage());
    }finally{
        release(pstmt);
        freeConnection(dbconn);
    }
    return (Schedule_bean [])list.toArray(new Schedule_bean[0]);
}
	
	
	
    /**
     *  ��������
     * @param upjang_sid ����SID
     * @return Schedule_bean []
     * @throws DbException
     * @throws Exception
     * @author �̼ҿ�
     */	
	public Schedule_bean [] getRoomList()  throws DbException , Exception 
	{
	    Connection dbconn = getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Collection list = null;

	    // SQL
		String query = new StringBuffer()
		.append(" SELECT               \n")
		.append("   UPJANG_SID,        \n") 
		.append("   ROOM_TYPE_SID,     \n")
		.append("   ROOM_TYPE_CD,      \n")
		.append("   ROOM_TYPE_NM       \n")
		.append(" FROM SALES.TRM030      ").toString();

	    try {         
	        pstmt = dbconn.prepareStatement(query);

	        // ��� ���
	        rs = pstmt.executeQuery();
	        list = Selecter.execute(rs, new Schedule_bean());

	        rs.close();
	        pstmt.close();
	    
	    } catch (SQLException e) {
	        throw new DbException(e.getMessage());
	    }finally{
	        release(pstmt);
	        freeConnection(dbconn);
	    }
	    return (Schedule_bean [])list.toArray(new Schedule_bean[0]);
	}
	
	/**
	 * �ݰ���/���� ���డ������ ��ȸ
	 * @return �Է��� ���� ���� ��û�������� ��� ��ȸ
	 * @throws DbException
	 * @throws Exception
	 */
	public Schedule_bean [] getMonthResv(Schedule_bean param) throws DbException, Exception	
	{
		Connection dbconn = getConnection();
		CallableStatement stpCall = null;
	    ResultSet rs = null;
	    Collection list = null;

	    String flag_ymd  = param.getFlag_ymd();				//�޷��� ǥ���ϴ� ��������
	    String saup_sid = param.getSaup_sid();					//�������ڵ�
	    String good_sid = param.getGoods_sid();					//������ǰ�ڵ�
	    
	    StringBuffer query = new StringBuffer("");

	    //�����ۼ�
	    query.append("CALL SALES.PR_OL_01(?,?,?)");
	    
	    try {

	    	//��������
	    	stpCall = dbconn.prepareCall(query.toString());

	    	stpCall.setString(1, flag_ymd);
	    	stpCall.setInt(2, Integer.parseInt(saup_sid));
	    	stpCall.setInt(3, Integer.parseInt(good_sid));

	    	//������ 
	    	rs = stpCall.executeQuery();
	    	list = Selecter.execute(rs, new Schedule_bean());

	    	rs.close();
	    	stpCall.close();
	    } catch (SQLException e) {
	        throw new DbException(e.getMessage());
	    }finally{
	        release(stpCall);
	        freeConnection(dbconn);
	    }
	    
	    return (Schedule_bean [])list.toArray(new Schedule_bean [0]);
		
	}
		 
}


package kr.co.imjk.reservation.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.reservation.bean.Room_bean;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;

/**
 * �ݰ��� ������ ���� ������ ��ȸ�ϱ� ����    ����
 * @author Ȳ�Ǽ�(espooh)
 * @since 2008.07.17
 * @description �������� ��ȸ 
 *
 */
public class RoomInfo extends DAOHome{

	/**
	 * ������� ��ȸ
	 * @return
	 * @throws DbException
	 * @throws Exception
	 */
	public Room_bean [] getHotelList(Room_bean param) throws DbException, Exception {
			
		System.out.println("START=========================================");
		Connection dbconn = getConnection();
		CallableStatement stpCall = null;
	    ResultSet rs = null;
	    Collection list = null;
	    
	    String start_ymd = param.getStart_ymd();			//�������
	    String saup_sid = param.getSaup_sid();				//���ID
	    String goods_sid = param.getGoods_sid();			//��ǰID
	    
	    StringBuffer query = new StringBuffer("");
	    query.append("CALL SALES.PR_OL_02(?,?,?)");
	    System.out.println(query.toString());
	    try {
	    	//��������
	    	stpCall = dbconn.prepareCall(query.toString());
	    	System.out.println("1");
	    	//�Ķ���� ����
	    	stpCall.setString(1, start_ymd);
	    	stpCall.setInt(2, Integer.parseInt(saup_sid));
	    	stpCall.setInt(3, Integer.parseInt(goods_sid));
	    	System.out.println(start_ymd);
	    	System.out.println(saup_sid);
	    	System.out.println(goods_sid);
	    	//������ 
	    	rs = stpCall.executeQuery();
	    	System.out.println("3");
	    	list = Selecter.execute(rs, new Room_bean()); 
	    	System.out.println("4");
	    	rs.close();
	    	stpCall.close();
	    	System.out.println("END=========================================");
	    } catch (SQLException e) {
	        throw new DbException(e.getMessage());
	    } catch (Exception e) {
	    	throw new Exception(e.getMessage());
	    } finally{
	        release(stpCall);
	        freeConnection(dbconn);
	    }
	    
	    return (Room_bean [])list.toArray(new Room_bean[0]);
	}
	
	/**
	 * ������ ������ ���ǿ��θ� ��ȸ
	 * @param param
	 * @return
	 * @throws DbException
	 * @throws Exception
	 */
	public Room_bean [] getRoomList(Room_bean param) throws DbException, Exception {
		
		Connection dbconn = getConnection();
		CallableStatement stpCall = null;
	    ResultSet rs = null;
	    Collection list = null;
	    
	    String start_ymd = param.getStart_ymd();			//�������
	    String saup_sid = param.getSaup_sid();				//���ID
	    String goods_sid = param.getGoods_sid();			//��ǰID
	    String upjang_sid = param.getUpjang_sid();			//ȣ��ID
	    
	    StringBuffer query = new StringBuffer("");
	    if(goods_sid.equals("61")||goods_sid.equals("30")||goods_sid.equals("35")){
			query.append("CALL SALES.PR_OL_03_1(?,?,?,?)");
	    }else{
			query.append("CALL SALES.PR_OL_03(?,?,?,?)");
	    }
	    
	    
	    try {
	    	//��������
	    	stpCall = dbconn.prepareCall(query.toString());

	    	//�Ķ���� ����
	    	stpCall.setString(1, start_ymd);
	    	stpCall.setInt(2, Integer.parseInt(saup_sid));
	    	stpCall.setInt(3, Integer.parseInt(goods_sid));
	    	stpCall.setInt(4, Integer.parseInt(upjang_sid));

	    	//������ 
	    	rs = stpCall.executeQuery();
	    	list = Selecter.execute(rs, new Room_bean());

	    	rs.close();
	    	stpCall.close();

	    } catch (SQLException e) {
	        throw new DbException(e.getMessage());
	    } catch (Exception e) {
	    	throw new Exception(e.getMessage());
	    } finally{
	        release(stpCall);
	        freeConnection(dbconn);
	    }
	    
	    return (Room_bean [])list.toArray(new Room_bean[0]);		
	}
}

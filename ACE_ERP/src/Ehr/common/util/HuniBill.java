package Ehr.common.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HuniBill {

    /**
     * Huni-Bill�� ��ȸ�Ѵ�(������Ʈ �������� ������ ��ȸ�Ѵ�)
     * @param p_box
     * @throws CException
     */

	public   boolean getDateCheck( String paramDate) {
		boolean flag = false;

		try{
			System.out.println("������ [" + paramDate + "]");
			Connection conn = DbManager.getFrsConnection();
			PreparedStatement pstmt = null;
	        StringBuffer query = new StringBuffer();
	        int colCnt = 0;
    		query.append(" SELECT * FROM VPOSTING_DATE_CHECK WHERE from_date <= ? AND to_date >= ? \n");

    		System.out.println(query.toString());
    		pstmt = conn.prepareStatement(query.toString());
    		pstmt.setString(++colCnt, paramDate);
    		pstmt.setString(++colCnt, paramDate);
    		ResultSet rs = pstmt.executeQuery();

            if(rs.next()){
	        	flag = true;
            }else{
            	flag = false;
            }

		}catch(Exception ex){
			ex.printStackTrace();
		}
        return flag;
	}

    /**
     * Huni-Bill�� ��ȸ�Ѵ�(COST ������ ��ȸ�Ѵ�)
     * @param p_box
     * @throws CException
     */

	public   boolean getVendorInfoCheck( String paramEnono) {
		boolean flag = false;

		try{
			System.out.println("��� [" + paramEnono + "]");
			Connection conn = DbManager.getFrsConnection();
			PreparedStatement pstmt = null;
	        StringBuffer query = new StringBuffer();
	        int colCnt = 0;
    		query.append(" SELECT * FROM vvendor_info WHERE vendor_code = ? \n");

    		System.out.println(query.toString());
    		pstmt = conn.prepareStatement(query.toString());
    		pstmt.setString(++colCnt, "E"+paramEnono);
    		ResultSet rs = pstmt.executeQuery();

            if(rs.next()){
	        	flag = true;
            }else{
            	flag = false;
            }

		}catch(Exception ex){
			ex.printStackTrace();
		}
        return flag;
	}
}

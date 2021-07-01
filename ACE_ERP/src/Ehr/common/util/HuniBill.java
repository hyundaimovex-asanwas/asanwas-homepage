package Ehr.common.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HuniBill {

    /**
     * Huni-Bill를 조회한다(프로젝트 가능일자 내역을 조회한다)
     * @param p_box
     * @throws CException
     */

	public   boolean getDateCheck( String paramDate) {
		boolean flag = false;

		try{
			System.out.println("전기일 [" + paramDate + "]");
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
     * Huni-Bill를 조회한다(COST 내역을 조회한다)
     * @param p_box
     * @throws CException
     */

	public   boolean getVendorInfoCheck( String paramEnono) {
		boolean flag = false;

		try{
			System.out.println("사번 [" + paramEnono + "]");
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

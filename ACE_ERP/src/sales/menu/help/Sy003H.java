package sales.menu.help;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
 
import oracle.jdbc.OracleTypes;

public class Sy003H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		 for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	 }
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {

		/* DataBase */
		//GauceStatement stmt = null;
		ResultSet rs = null;
		CallableStatement cstmt = null;

		
		/* DataSet */
		GauceDataSet ds1 = null;
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		String query = "";			// SELECT��  ���� 
		String whereQuery =  "";	// WHERE��  ���� 
		try {
			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset(TSY200) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			String  s_SaupSid	= HDUtil.nullCheckStr(greq.getParameter("s_SaupSid"));
			String	s_SaupCd	= HDUtil.nullCheckStr(greq.getParameter("s_SaupCd"));
			String 	s_BoundGu	= HDUtil.nullCheckStr(greq.getParameter("s_BoundGu"));	//�ٿ��	2009-03-23
			String 	s_UseYn	= HDUtil.nullCheckStr(greq.getParameter("s_UseYn"));	//��뿩��	2009-04-16
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//ù��° �׸���
		
			switch(dsType) {
				case 1: //detail�� ������ �ƴ� �����ڵ� �˻�
					int sCnt1 = 1;
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	saup_sid, " 
							+ "\n\t" + "	saup_cd, " 
							+ "\n\t" + "	saup_nm, " 
							+ "\n\t" + "	saup_no, " 
							+ "\n\t" + "	saup_eng_nm, " 
							+ "\n\t" + "	ceo_nm, "
							+ "\n\t" + "	ceo_eng_nm, " 
							+ "\n\t" + "	zip_cd, " 
							+ "\n\t" + "	address1, " 
							+ "\n\t" + "    address2, "
							+ "\n\t" + "	address_eng, "
							+ "\n\t" + "	tel_no1, " 
							+ "\n\t" + "	tel_no2, " 							
							+ "\n\t" + "	tel_no3, " 
							+ "\n\t" + "	fax_no1, " 
							+ "\n\t" + "	fax_no2, " 
							+ "\n\t" + "	fax_no3, " 
							+ "\n\t" + "	uptae, "
							+ "\n\t" + "	jongmok, " 							
							+ "\n\t" + "	homepage, " 							
							+ "\n\t" + "	e_mail, " 							
							+ "\n\t" + "	u_empno, "
							+ "\n\t" + "	to_char(u_date) u_date, " 
							+ "\n\t" + "	u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY200 " 
							+ "\n\t" + "WHERE SAUP_CD > '0' ";

					if (!"".equals(s_SaupSid)) {
						whereQuery += ""
								   + "\n\t" + " AND saup_sid=? ";
					}					
					if (!"".equals(s_SaupCd)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND (saup_cd LIKE ? OR saup_nm LIKE ?)";
					}
					if (!"".equals(s_BoundGu)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND BOUND_GU = ? ";
					}
					if (!"".equals(s_UseYn)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND USE_YN = ? ";
					}

					whereQuery 	+=" ORDER BY DISPLAY_SEQ ";
					

					//System.out.println("# s_BoundGu : " + s_BoundGu);
					
					query += whereQuery;
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					/*ds1.addDataColumn(new GauceDataColumn("saup_sid",		GauceDataColumn.TB_DECIMAL, 10));
					ds1.addDataColumn(new GauceDataColumn("saup_cd",		GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("saup_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("saup_no", 		GauceDataColumn.TB_STRING, 12));
					ds1.addDataColumn(new GauceDataColumn("saup_eng_nm", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("ceo_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("ceo_eng_nm", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("zip_cd", 		GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("address1", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("address2", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("address_eng", 	GauceDataColumn.TB_STRING, 80));
					ds1.addDataColumn(new GauceDataColumn("tel_no1", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("tel_no2", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("tel_no3", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("fax_no1", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("fax_no2", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("fax_no3", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("uptae", 			GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("jongmok", 		GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("homepage", 		GauceDataColumn.TB_STRING, 25));
					ds1.addDataColumn(new GauceDataColumn("e_mail", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));	*/				
					
					// ���� ����
					cstmt = conn.prepareCall(query);
					//System.out.println("# query : " + query);
					
					if (!"".equals(s_SaupSid)) {	
						cstmt.setString(sCnt1++, s_SaupSid);
					}					
					if (!"".equals(s_SaupCd)) {	
						cstmt.setString(sCnt1++, "%" + s_SaupCd +"%");
						cstmt.setString(sCnt1++, "%" + s_SaupCd +"%");
					}
					if (!"".equals(s_BoundGu)) {
						cstmt.setString(sCnt1++, s_BoundGu );
					}	
					if (!"".equals(s_UseYn)) {
						cstmt.setString(sCnt1++, s_UseYn );
					}	
					//System.out.println("# s_UseYn : " + s_UseYn);
					//stmt.executeQuery(ds1); // DataSet set
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				break;
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}	
}

package sales.menu.help;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Sy004H extends SuperServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
        for(int i=0; i<arr_sql.length; i++)
           arr_sql[i] = new StringBuffer();
    }
	
	/*****************************************************************************
	 * Gauce Object ����
	 * Select �� �� Project Name , Project Id�� ��ȸ�Ѵ�
	 * ������ �ε��ÿ� �ʱ�ȭ �۾��̴� 
	 *****************************************************************************/
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		String query = "";			// SELECT��  ���� 
		String whereQuery =  "";	// WHERE��  ���� 
		try {
			// DataSet ���� 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));		// ������ڵ�
			String sHead = HDUtil.nullCheckStr(greq.getParameter("sHead"));		// Head			
			String sDetail = HDUtil.nullCheckStr(greq.getParameter("sDetail"));		// Detail	
			
			switch(dsType) {
				case 1 :
					//res.enableFirstRow(ds1);
					
					// ������Ʈ���� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	saup_sid, " 
							+ "\n\t" + "	saup_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY200 " 
							+ "\n\t" + "ORDER BY saup_sid ";
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					cstmt = conn.prepareCall(query);
					//stmt = conn.getGauceStatement(query); 
				
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
					
					if(rs!=null) rs.close();
			        if(cstmt!=null) cstmt.close();
			        
			        break;
				case 2 :
					int sCnt2 = 1;					
					//res.enableFirstRow(ds1);
					
					// ������Ʈ���� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	upjang_sid, " 
							+ "\n\t" + "	upjang_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TRM010 " 
							+ "\n\t" + "WHERE upjang_type='10' "; 
				
					if (!"".equals(sSaupSid)) {
						whereQuery += ""
								   + "\n\t" + " AND saup_sid =? ";
						}
					query += whereQuery;
					query += "\n\t" + " ORDER BY  upjang_sid ";	
					
					//stmt = conn.getGauceStatement(query); 
					cstmt = conn.prepareCall(query);
				
					if (!"".equals(sSaupSid)) {
						cstmt.setString(sCnt2++, sSaupSid);
					}
					
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
				
					cstmt.close();
					break;		
					
				case 3:
					int sCnt3 = 1;
					//res.enableFirstRow(ds1);
					
					// ��� ����� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	head, " 
							+ "\n\t" + "	detail, " 
							+ "\n\t" + "	detail_nm, " 
							+ "\n\t" + "	item1, " 
							+ "\n\t" + "	item2, "
							
							+ "\n\t" + "	item3, "
							+ "\n\t" + "	item4, "
							+ "\n\t" + "	item5, "
							+ "\n\t" + "	item6, "
							+ "\n\t" + "	item7, "
							
							+ "\n\t" + "	item8, "
							+ "\n\t" + "	item9, "
							+ "\n\t" + "	item10, "
							+ "\n\t" + "	item11, "
							+ "\n\t" + "	item12, "
							
							+ "\n\t" + "	item13, "
							+ "\n\t" + "	item14, "
							+ "\n\t" + "	item15, "
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	to_char(u_date) u_date, " 
							
							+ "\n\t" + "	u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY010 " 
							+ "\n\t" + "WHERE 1=1 ";

					whereQuery += "\n\t" + " AND head=? ";
					if (!"".equals(sDetail)) {
					whereQuery 	+= ""
								+ "\n\t" + " AND detail= ? ";
					}
					whereQuery	+= " ORDER BY detail ";
					query += whereQuery;
		
//					 ���� ����
					//stmt = conn.getGauceStatement(query); 
					cstmt = conn.prepareCall(query);
					cstmt.setString(sCnt3++, sHead);
					if (!"".equals(sDetail)) {
						cstmt.setString(sCnt3++, sDetail);
					}
					
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
					
					cstmt.close();
					break;
			 }
			 //gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	
	}

	// ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		String query = "";			// SELECT��  ���� 
		String whereQuery =  "";	// WHERE��  ���� 
		try {
			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset(TRM010) 
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput();
			// �˻��� ����
			String 	s_UpjangSid	 = HDUtil.nullCheckStr(greq.getParameter("s_UpjangSid"));
			String	s_UpjangCd	 = HDUtil.nullCheckStr(greq.getParameter("s_UpjangCd"));
			String  s_UpjangType = HDUtil.nullCheckStr(greq.getParameter("s_UpjangType"));
			String  s_SaupSid    = HDUtil.nullCheckStr(greq.getParameter("s_SaupSid"));
			String  s_use_yn	 = HDUtil.nullCheckStr(greq.getParameter("s_use_yn"));
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//ù��° �׸���
			int sCnt1 = 1;
			//StringUtil.printMsg("# Query",dsType,this);
			switch(dsType) {
				case 1: //detail�� ������ �ƴ� �����ڵ� �˻�
					//res.enableFirstRow(ds1);
					query   += "" 		
							+ "\n\t" + "(SELECT " 									
							+ "\n\t" + "	upjang_sid, " 
							+ "\n\t" + "	upjang_cd, " 
							+ "\n\t" + "	upjang_nm  " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TRM010 " 
							+ "\n\t" + "WHERE 1=1 ";
					
					if (!"".equals(s_UpjangSid)) {
						whereQuery += ""
								   + "\n\t" + " AND upjang_sid=? ";
					}					
					if (!"".equals(s_UpjangCd)) {
						whereQuery 	+= ""
									+ "\n\t" + "AND (upjang_cd LIKE ? OR upjang_nm LIKE ?)";
					}
					if (!"".equals(s_use_yn)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND USE_YN = ?";
					}
					if (!"".equals(s_UpjangType)) {
						if(s_UpjangType.equals("99"))
							whereQuery 	+= " AND upjang_type IN ('20', '30', '40', '50')";
						else
							whereQuery 	+= " AND upjang_type = ?";
					}
					if (!"".equals(s_SaupSid)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND saup_sid = ?";
					}

					whereQuery 	+= ") ORDER BY DISPLAY_SEQ ";
					
					query += whereQuery;
					
					// ���� ����
					//stmt = conn.getGauceStatement(query); 
					cstmt = conn.prepareCall(query); 
					
					if (!"".equals(s_UpjangSid)) {	
						cstmt.setString(sCnt1++, s_UpjangSid);
					}	
					if (!"".equals(s_UpjangCd)) {	
						cstmt.setString(sCnt1++, "%" + s_UpjangCd + "%");
						cstmt.setString(sCnt1++, "%" + s_UpjangCd + "%");
					}
					if (!"".equals(s_use_yn)) {	
						cstmt.setString(sCnt1++, s_use_yn );
					}
					if (!"".equals(s_UpjangType)) {	
						if(!s_UpjangType.equals("99"))
							cstmt.setString(sCnt1++,s_UpjangType);
					}
					if (!"".equals(s_SaupSid)) {	
						cstmt.setString(sCnt1++,s_SaupSid);
					}
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
					
					if(rs!=null) rs.close();
					if(cstmt!=null)cstmt.close();
				break;
				case 2: //detail�� ������ �ƴ� �����ڵ� �˻�
					//res.enableFirstRow(ds1);
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	0 upjang_sid, " 
							+ "\n\t" + "	' ' upjang_cd, " 
							+ "\n\t" + "	'��ü' upjang_nm  " 
							+ "\n\t" + "FROM DUAL"
							+ "\n\t" + "UNION ALL"
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	upjang_sid, " 
							+ "\n\t" + "	upjang_cd, " 
							+ "\n\t" + "	upjang_nm  " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TRM010 " 
							+ "\n\t" + "WHERE 1=1 ";
					
					if (!"".equals(s_UpjangSid)) {
						whereQuery += ""
								   + "\n\t" + " AND upjang_sid=? ";
					}					
					if (!"".equals(s_UpjangCd)) {
						whereQuery 	+= ""
									+ "\n\t" + "AND (upjang_cd LIKE ? OR upjang_nm LIKE ?)";
					}
					if (!"".equals(s_use_yn)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND USE_YN = ?";
					}
					if (!"".equals(s_UpjangType)) {
						if(s_UpjangType.equals("99"))
							whereQuery 	+= " AND upjang_type IN ('20', '30', '40', '50')";
						else
							whereQuery 	+= " AND upjang_type = ?";
					}
					if (!"".equals(s_SaupSid)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND saup_sid = ?";
					}

					query += whereQuery;
					
					// ���� ����
					//stmt = conn.getGauceStatement(query); 
					cstmt = conn.prepareCall(query); 
					
					if (!"".equals(s_UpjangSid)) {	
						cstmt.setString(sCnt1++, s_UpjangSid);
					}	
					if (!"".equals(s_UpjangCd)) {	
						cstmt.setString(sCnt1++, "%" + s_UpjangCd + "%");
						cstmt.setString(sCnt1++, "%" + s_UpjangCd + "%");
					}
					if (!"".equals(s_use_yn)) {	
						cstmt.setString(sCnt1++, s_use_yn );
					}
					if (!"".equals(s_UpjangType)) {	
						if(!s_UpjangType.equals("99"))
							cstmt.setString(sCnt1++,s_UpjangType);
					}
					if (!"".equals(s_SaupSid)) {	
						cstmt.setString(sCnt1++,s_SaupSid);
					}
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
					
					if(rs!=null) rs.close();
					if(cstmt!=null)cstmt.close();
				break;
			}
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	
	}

    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
}
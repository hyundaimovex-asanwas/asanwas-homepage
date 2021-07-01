/**
 * 
 */
package sales.menu.cu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;

import javax.servlet.ServletException;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
 
import oracle.jdbc.OracleTypes;

/**
 * @author �츮��
 *
 */
public class Cu100S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#makeSql()
	 */
	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT 																						\n")
				  .append ("       T3.CLIENT_CD             /* ���¾�ü�ڵ�    */                                       \n")
				  .append ("      ,T3.CLIENT_NM             /* ���¾�ü��      */                                       \n")
				  .append ("      ,T2.CUST_NM               /* ������          */                                       \n")
				  .append ("      ,SALES.FN_SECURE_RETURN(T2.MANAGE_NO,7) AS MANAGE_NO   /* �ֹ�/���� ��ȣ  */          \n")
				  .append ("      ,T1.DRIVE_NO              /* ���������ȣ    */                                       \n")
				  .append ("      ,T1.LICENSE_DATE          /* ��������        */                                       \n")
				  .append ("      ,T1.RENEWAL_DATE          /* ���űⰣ        */                                       \n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'CU007',T1.LICENSE_TYPE) AS LICENSE_TYPE_NAME                   \n")
				  .append ("FROM                                                                                        \n")
				  .append ("   SALES.TCU040 T1                                                                          \n")
				  .append ("  ,SALES.TCU010 T2 LEFT OUTER JOIN  SALES.TCU030 T3 ON  T2.CLIENT_SID  = T3.CLIENT_SID      \n")
				  .append ("WHERE 1 = 1                                                                                 \n")
				  .append ("  AND T1.CUST_SID   = T2.CUST_SID                                                           \n");
	}

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#init(com.gauce.db.GauceDBConnection, com.gauce.io.GauceRequest, com.gauce.io.GauceResponse)
	 */
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    //StringUtil.printMsg("DS TYPE","����ȸ",this);
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("ds1")){//������
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		    		arr_sql[0].append (" AND T1.LICENSE_DATE = '11111212' ");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
							}
						}
		 	gos.close();
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

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#select(com.gauce.db.GauceDBConnection, com.gauce.io.GauceRequest, com.gauce.io.GauceResponse)
	 */
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter ����
		 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
		 **********************************************************************************/

		// �˻��� ����
		String  sClientCd	= HDUtil.nullCheckStr(greq.getParameter("sClientCd")); 	// ����ó
		String	sDriveNo	= HDUtil.nullCheckStr(greq.getParameter("sDriveNo"));		// ������
		String  sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));		// ����
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){// || dSets[i].getName().equals("imgDs")){
				int sCnt1 = 1;
				GauceDataSet ds1 = gis.read("DEFAULT");
	
					if (!"".equals(sClientCd)) 
						arr_sql[0].append (" AND T2.CLIENT_SID = ? ");
					
					if (!"".equals(sDriveNo))
						arr_sql[0].append (" AND T1.DRIVE_NO LIKE ? ");
	
					if (!"".equals(sCustNm)) 
						arr_sql[0].append (" AND T2.CUST_NM LIKE ? ");
					
					arr_sql[0].append ("ORDER BY T3.CLIENT_CD, T2.CUST_NM");
					
					//StringUtil.printMsg("arr_sql[0].toString() : " + arr_sql[0].toString(), this);
	
					//���� ����
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
	
					if (!"".equals(sClientCd)) 
						cstmt.setString(sCnt1++, sClientCd);
					
					if (!"".equals(sDriveNo)) 
						cstmt.setString(sCnt1++, "%" +sDriveNo+"%");
					
					if (!"".equals(sCustNm)) 
						cstmt.setString(sCnt1++, sCustNm +"%");
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1)); // DataSet set & ����
											
				}
			gos.close();
			}
		} catch (SQLException sqle){
			//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//gres..writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#apply(com.gauce.db.GauceDBConnection, com.gauce.io.GauceRequest, com.gauce.io.GauceResponse)
	 */
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}
package sales.menu.rm;


import oracle.jdbc.OracleTypes;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceException;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Rm520I extends SuperServlet {
	
	private static final long serialVersionUID = 1L;

    public void makeSql(){
		/**
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ�
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;

		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//�׸���(LOOKUP) - �𰴷�Ÿ��
		arr_sql[6].append ("SELECT '' CUST_RATE_TYPE FROM dual \n")
						.append ("UNION ALL \n")
						.append ("SELECT CUST_RATE_TYPE FROM SALES.TRM072 GROUP BY CUST_RATE_TYPE \n");

		//�׸���(LOOKUP) - ��������
		arr_sql[7].append ("SELECT 0 DETAIL FROM dual \n")
					.append ("UNION ALL \n")
					.append ("SELECT DETAIL FROM SALES.TSY010 WHERE HEAD='RM011' AND Length(rtrim(detail)) > 0 \n");

		//��ǰ����
		arr_sql[8].append ("SELECT										\n")
					.append ("	0 GOODS_SID, '��ü' GOODS_NM, 0 DISPLAY_SEQ    \n")
					.append ("FROM dual                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT GOODS_SID,					\n")		
					.append ("			GOODS_NM,				\n")
					.append ("			DISPLAY_SEQ				\n")					
					.append ("FROM SALES.TRM200					\n")
					.append ("WHERE SAUP_SID    =  ?				\n")
					.append ("	AND USE_YN      = 'Y'				\n")
					.append ("ORDER BY DISPLAY_SEQ					\n");

   }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		StringUtil.printMsg("# Command : ","����ȸ",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		// �˻��� �ʿ��� ����
		int dsType 			= HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int sSaupSid		= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));	//����� ���̵�	20071112 �߰�

		StringUtil.printMsg("dsType- ",dsType , this);  
		StringUtil.printMsg("sSaupSid- ",sSaupSid , this);

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds4")){
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[6].toString());
					//rs = (ResultSet)cstmt.getObject(10);	//���ν��� ��ȸ-Ŀ�� OUT param. 			
					rs = cstmt.executeQuery();				//������ ��ȸ 
					gos.write(getDataSet(rs, ds1));
					
				}
				
				if(dSets[i].getName().equals("ds5")){
					GauceDataSet ds1 = gis.read("DS5");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					//rs = (ResultSet)cstmt.getObject(10);	//���ν��� ��ȸ-Ŀ�� OUT param. 			
					rs = cstmt.executeQuery();				//������ ��ȸ 
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds7")){	//ds_goods
					GauceDataSet ds1 = gis.read("DS7");
					cstmt = conn.prepareCall(arr_sql[8].toString());
					cstmt.setInt(1, sSaupSid);	
					//rs = (ResultSet)cstmt.getObject(10);	//���ν��� ��ȸ-Ŀ�� OUT param. 			
					rs = cstmt.executeQuery();				//������ ��ȸ 
					gos.write(getDataSet(rs, ds1));

				}				
			}
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", sqle.getErrorCode()+"", sqle.getMessage())
			);
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", " ", e.toString())
			);
			throw e;
		} finally {
			gos.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command : ","��ȸ",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;

		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		// �˻��� ����
		String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
		String 	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
		String 	sClientSid	= HDUtil.nullCheckStr(greq.getParameter("sClientSid"));
		String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
		String 	sBlockStatusCd	= HDUtil.nullCheckStr(greq.getParameter("sBlockStatusCd"));
		String 	sAcceptBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sAcceptBgnDate"));
		String 	sAcceptEndDate	= HDUtil.nullCheckStr(greq.getParameter("sAcceptEndDate"));
		String 	sTlBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sTlBgnDate"));
		String 	sTlEndDate	= HDUtil.nullCheckStr(greq.getParameter("sTlEndDate"));
		String 	sQTypeCd	= HDUtil.nullCheckStr(greq.getParameter("sQTypeCd"));
		String 	sQTypeStr	= HDUtil.nullCheckStr(greq.getParameter("sQTypeStr"));
		String 	sBlockNo	= HDUtil.nullCheckStr(greq.getParameter("sBlockNo"));
		String 	sMBlockSid	= HDUtil.nullCheckStr(greq.getParameter("sMBlockSid"));
		int 	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));	//����� ���̵�	20071112 �߰�
		String    sResultsYn		= HDUtil.nullCheckStr(greq.getParameter("sResultsYn"));
	
		/*
				 StringUtil.printMsg("sBgnDate",sBgnDate,this);
				 StringUtil.printMsg("sEndDate",sEndDate,this);
				 StringUtil.printMsg("sGoodssid",sGoodsSid,this);
				 StringUtil.printMsg("sClientSid",sClientSid,this);
				 StringUtil.printMsg("sBlockStatusCd",sBlockStatusCd,this);
				 StringUtil.printMsg("sAcceptBgnDate",sAcceptBgnDate,this);
				 StringUtil.printMsg("sAcceptEndDate",sAcceptEndDate,this);
				 StringUtil.printMsg("sQTypeCd",sQTypeCd,this);
				 StringUtil.printMsg("sQTypeStr",sQTypeStr,this);
				 StringUtil.printMsg("sTlBgnDate",sTlBgnDate,this);
				 StringUtil.printMsg("sTlEndDate",sTlEndDate,this);
				 StringUtil.printMsg("sBlockNo",sBlockNo,this);
				 StringUtil.printMsg("sCfBgnDate",sTlBgnDate,this);
				 StringUtil.printMsg("sCfEndDate",sTlEndDate,this);
				 StringUtil.printMsg("sResultsYn",sResultsYn,this);
		 */
		try {
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall("{call SALES.PR_RM520I_01(?,?,?,?,?,    ?,?,?,?,?,   ?,?,?,?,?) }");
					cstmt.setString(1, sBgnDate);
					cstmt.setString(2, sEndDate);
					cstmt.setInt(3, Integer.parseInt(sGoodsSid));
					cstmt.setInt(4, Integer.parseInt(sClientSid));
					cstmt.setString(5, sBlockStatusCd);
					cstmt.setString(6, sAcceptBgnDate);
					cstmt.setString(7, sAcceptEndDate);
					cstmt.setString(8, sQTypeCd);
					cstmt.setString(9, sQTypeStr);
					cstmt.setString(10, sTlBgnDate);
					cstmt.setString(11, sTlEndDate);
					cstmt.setString(12, sBlockNo);
					cstmt.setInt(13, sSaupSid);
					cstmt.setString (14, sResultsYn);
					cstmt.registerOutParameter(15, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(15);	//���ν��� ��ȸ-Ŀ�� OUT param. 			
					//rs = cstmt.executeQuery();				//������ ��ȸ 
					gos.write(getDataSet(rs, ds1));
					
				}

				if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall("{call SALES.PR_RM520I_02(?,?) }");
					cstmt.setString(1, sMBlockSid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//���ν��� ��ȸ-Ŀ�� OUT param. 			
					//rs = cstmt.executeQuery();				//������ ��ȸ 
					gos.write(getDataSet(rs, ds1));
				}
									
			}
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", sqle.getErrorCode()+"", sqle.getMessage())
			);
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", " ", e.toString())
			);
			throw e;
		} finally {
			gos.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}


	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* 2013.10.22 �ɵ���
		 * �̷��� TR�� ȣ���մϴ�. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	���� gis.read�� �������� ��.
		 * 
		 * */
	
		StringUtil.printMsg("# Command","����",this);
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        //JSP(I:DEFAULT=ds2,O:msgDS=msgDS)
		GauceDataSet inputDs = gis.read("DEFAULT");
		GauceDataSet msgDS = gis.read("msgDS");

		boolean fail=false;	//���� ó����
	
		
		
		try{
			inner: {	//���ܽ� break
			
			if(inputDs!=null){

				int colNm_MBlockSid 		= inputDs.indexOfColumn("M_BLOCK_SID");
				int colNm_BlockStatusCd 	= inputDs.indexOfColumn("BLOCK_STATUS_CD");
				int colNm_CRoomTypeSid 		= inputDs.indexOfColumn("C_ROOM_TYPE_SID");
				int colNm_CRoomCnt 			= inputDs.indexOfColumn("C_ROOM_CNT");
				int colNm_ConfirmPersons 	= inputDs.indexOfColumn("CONFIRM_PERSONS");
				int colNm_TlDate 			= inputDs.indexOfColumn("TL_DATE");
				int colNm_PlanPayDate 		= inputDs.indexOfColumn("PLAN_PAY_DATE");
				int colNm_CustRateType 		= inputDs.indexOfColumn("CUST_RATE_TYPE");
				int colNm_DepartDate 		= inputDs.indexOfColumn("DEPART_DATE");
				int colNm_Nights 			= inputDs.indexOfColumn("NIGHTS");
				int colNm_DepositRate 		= inputDs.indexOfColumn("DEPOSIT_RATE");
				int colNm_CRemarks 			= inputDs.indexOfColumn("C_REMARKS");
				int colNm_BlockSid 			= inputDs.indexOfColumn("BLOCK_SID");

				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();

				//StringUtil.printMsg("colNm_CRoomTypeSid",colNm_CRoomTypeSid,this);
				
				
				//�޽���ó��
				//gres.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pYn", GauceDataColumn.TB_STRING, 1));
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING, 200));
				
				

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","SALES.PR_RM520I_03-INSERT",this);
						cstmt = conn.prepareCall("{call SALES.PR_RM520I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

						cstmt.setInt(1, rows[i].getInt(colNm_BlockSid));
						cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
						cstmt.setInt(2, rows[i].getInt(colNm_MBlockSid));
						cstmt.setString(3, rows[i].getString(colNm_BlockStatusCd));
						cstmt.setInt(4, rows[i].getInt(colNm_CRoomTypeSid));
						cstmt.setInt(5, rows[i].getInt(colNm_CRoomCnt));
						cstmt.setInt(6, rows[i].getInt(colNm_ConfirmPersons));
						cstmt.setString(7, rows[i].getString(colNm_TlDate));
						cstmt.setString(8, rows[i].getString(colNm_PlanPayDate));
						cstmt.setString(9, rows[i].getString(colNm_CRemarks));
						cstmt.setString(10, rows[i].getString(colNm_CustRateType));
						cstmt.setInt(11, rows[i].getInt(colNm_DepositRate));
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "1");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);

						cstmt.executeUpdate();

						//�޽���ó��
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								//StringUtil.printMsg("�����޽���",cstmt.getString(17),this);
								msgDS.put("pYn",cstmt.getString(15),1);
								msgDS.put("pMsg",cstmt.getString(17),200);
								msgDS.heap();
								
							}
						} else {
							StringUtil.printMsg("���и޽���",cstmt.getString(17),this);
							conn.rollback();
							msgDS.put("pYn",cstmt.getString(15),1);
							msgDS.put("pMsg",cstmt.getString(17),200);
							msgDS.heap();
	
							fail = true;
							break inner;
						}

						if(cstmt!=null) cstmt.close();
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RM520I_03-UPDATE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RM520I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

						cstmt.setInt(1, rows[i].getInt(colNm_BlockSid));
						cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
						cstmt.setInt(2, rows[i].getInt(colNm_MBlockSid));
						cstmt.setString(3, rows[i].getString(colNm_BlockStatusCd));
						cstmt.setInt(4, rows[i].getInt(colNm_CRoomTypeSid));
						cstmt.setInt(5, rows[i].getInt(colNm_CRoomCnt));
						cstmt.setInt(6, rows[i].getInt(colNm_ConfirmPersons));
						cstmt.setString(7, rows[i].getString(colNm_TlDate));
						cstmt.setString(8, rows[i].getString(colNm_PlanPayDate));
						cstmt.setString(9, rows[i].getString(colNm_CRemarks));
						cstmt.setString(10, rows[i].getString(colNm_CustRateType));
						cstmt.setInt(11, rows[i].getInt(colNm_DepositRate));
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "3");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);

						cstmt.executeUpdate();

						//�޽���ó��
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								//StringUtil.printMsg("�����޽���",cstmt.getString(17),this);
								msgDS.put("pYn",cstmt.getString(15),1);
								msgDS.put("pMsg",cstmt.getString(17),200);
								msgDS.heap();
								
							}
						} else {
							StringUtil.printMsg("���и޽���",cstmt.getString(17),this);
							conn.rollback();
							msgDS.put("pYn",cstmt.getString(15),1);
							msgDS.put("pMsg",cstmt.getString(17),200);
							msgDS.heap();
	
							fail = true;
							break inner;
						}

						if(cstmt!=null) cstmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_RM520I_03-DELETE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RM520I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

						cstmt.setInt(1, rows[i].getInt(colNm_BlockSid));
						cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
						cstmt.setInt(2, rows[i].getInt(colNm_MBlockSid));
						cstmt.setString(3, rows[i].getString(colNm_BlockStatusCd));
						cstmt.setInt(4, rows[i].getInt(colNm_CRoomTypeSid));
						cstmt.setInt(5, rows[i].getInt(colNm_CRoomCnt));
						cstmt.setInt(6, rows[i].getInt(colNm_ConfirmPersons));
						cstmt.setString(7, rows[i].getString(colNm_TlDate));
						cstmt.setString(8, rows[i].getString(colNm_PlanPayDate));
						cstmt.setString(9, rows[i].getString(colNm_CRemarks));
						cstmt.setString(10, rows[i].getString(colNm_CustRateType));
						cstmt.setInt(11, rows[i].getInt(colNm_DepositRate));
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "2");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);

						cstmt.executeUpdate();

						//�޽���ó��
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								//StringUtil.printMsg("�����޽���",cstmt.getString(17),this);
								msgDS.put("pYn",cstmt.getString(15),1);
								msgDS.put("pMsg",cstmt.getString(17),200);
								msgDS.heap();
								
							}
						} else {
							StringUtil.printMsg("���и޽���",cstmt.getString(17),this);
							conn.rollback();
							msgDS.put("pYn",cstmt.getString(15),1);
							msgDS.put("pMsg",cstmt.getString(17),200);
							msgDS.heap();
	
							fail = true;
							break inner;
						}
							

						if(cstmt!=null) cstmt.close();
						break;						
					}
				}
			}
			gos.close();
			}
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			gos.write(msgDS);
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}		
	}

}

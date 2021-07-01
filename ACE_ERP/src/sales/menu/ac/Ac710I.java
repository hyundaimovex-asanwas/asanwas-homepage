package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

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

public class Ac710I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC710I_01(?, ?)");
		
		arr_sql[2].append("CALL SALES.PR_AC710I_02(?)");
		
		arr_sql[3].append("CALL SALES.PR_AC710I_03(?, ?, ?, ?, ?, ?, ?, ?, ?)");
		
		arr_sql[4].append("CALL SALES.PR_AC710I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		
		arr_sql[5].append("CALL SALES.PR_AC710I_05(?, ?, ?, ?, ?, ?, ?)");
		
//		��ǰ�ǹ�ȣ�� �ش��ϴ� �ż� �� �ݾ� ����
		arr_sql[0].append ("SELECT COUNT(*)       AS PAY_QTY			/* �ż� */                           	\n")
				  .append ("    ,SUM(T1.AMT)/1000 AS PAY_AMT			/* �Ǽ� */                           	\n")
				  .append ("FROM SALES.TAC070 T1                                                        \n")
				  .append ("WHERE T1.GIFT_STATE    = '3'			/* ��ǰ�ǻ��� :AC004 3:�Ǹ�*/        	\n")
				  .append ("  AND T1.GIFT_TYPE     = ?				/* ��ǰ�Ǳ��� */                     	\n")
				  .append ("  AND T1.GIFT_SEQ BETWEEN ? AND ?											\n");
		//		��ǰ�ǹ�ȣ�� �ش��ϴ� ������ȸ
		arr_sql[7].append ("SELECT 																							\n")
				  .append ("       T1.GIFT_TYPE||'-'||T1.GIFT_SEQ              AS GIFT_SEQ        /* ��ǰ�� �Ϸù�ȣ   */   \n")
				  .append ("      ,SALES.FN_DETAIL_NM ('AC004',T1.GIFT_STATE)  AS GIFT_STATE      /* ��ǰ�ǻ��� :AC004 */   \n")
				  .append ("      ,CEIL(CEIL(T1.AMT)/1000)                     AS PAY_AMT         /* �ݾ�              */   \n")
				  .append (" FROM SALES.TAC070 T1                                                                           \n")
				  .append ("WHERE T1.GIFT_TYPE     = ? 											                            \n")
				  .append ("  AND T1.GIFT_STATE    = '3'							/* ��ǰ�ǻ��� :AC004 6:�Ǹ�*/        	\n")
				  .append ("  AND T1.GIFT_SEQ BETWEEN ? AND ?													        \n");
	}
	
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt;
		
		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		String sSDate = HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// ��������
		String sEDate = HDUtil.nullCheckStr(req.getParameter("sEDate")); 	// �������� 
		String sIpgoNo = HDUtil.nullCheckStr(req.getParameter("sIpgoNo"));
		
		String v_gift_type 		= HDUtil.nullCheckStr(req.getParameter("v_gift_type"));
		String v_fr_gift_seq 	= HDUtil.nullCheckStr(req.getParameter("v_fr_gift_seq"));
		String v_to_gift_seq 	= HDUtil.nullCheckStr(req.getParameter("v_to_gift_seq"));
		
		StringUtil.printMsg("PR_AC710I_01",arr_sql[1].toString()+"",this);
		StringUtil.printMsg("������ S",sSDate,this);
		StringUtil.printMsg("������ E",sEDate,this);
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						res.enableFirstRow(ds1);
					
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, sSDate);
						cstmt.setString(2, sEDate);
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					
					} 
					
					if ("DS2".equals(gauceName)) {
						res.enableFirstRow(ds1);
					
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1,sIpgoNo);
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					
						StringUtil.printMsg("PR_AC710I_02",arr_sql[2].toString()+"",this);
						StringUtil.printMsg("�԰��ȣ",sIpgoNo,this);
					} 
					if ("GIFTAMT".equals(gauceName)){
						res.enableFirstRow(ds1);
		
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						
						StringUtil.printMsg("gift_type",v_gift_type,this);
						StringUtil.printMsg("fr_gift_type",v_fr_gift_seq,this);
						StringUtil.printMsg("to_gift_type",v_to_gift_seq,this);
						
						stmt.setString(1,v_gift_type);
						stmt.setString(2,v_fr_gift_seq);
						stmt.setString(3,v_to_gift_seq);
						rs = stmt.executeQuery();
						
						StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
						getDataSet(rs, ds1).flush();
					}else if("GIFTLIST".equals(gauceName)){
						res.enableFirstRow(ds1);
						
						stmt = conn.getGauceStatement(arr_sql[7].toString());
						
						stmt.setString(1,v_gift_type);
						stmt.setString(2,v_fr_gift_seq);
						stmt.setString(3,v_to_gift_seq);
						rs = stmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}

				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet inputDs = req.getGauceDataSet("DS1");
		GauceDataSet inputDs2 = req.getGauceDataSet("DS2");
		CallableStatement cstmt = null;		
		GauceDataSet ipgonoDs = req.getGauceDataSet("ipgonoDs");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		int mIpgono=0;
		ResultSet rs = null;
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		String fIpGoNo = "";
		try{
			inner: {
			if(inputDs!=null){
				int colNm_IpgoNo 		= inputDs.indexOfColumn("IPGO_NO");
				int colNm_IPgoDate 		= inputDs.indexOfColumn("IPGO_DATE");				
				int colNm_IpgoEmpno 	= inputDs.indexOfColumn("IPGO_EMPNO");	
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//�԰��ȣ
				res.enableFirstRow(ipgonoDs);
				ipgonoDs.addDataColumn(new GauceDataColumn("ipgonoDs", GauceDataColumn.TB_STRING));
				
				//�޽���ó��
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						StringUtil.printMsg("call","SALES.PR_AC710I_03-INSERT",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						
						StringUtil.printMsg("colNm_IpgoNo",rows[i].getString(colNm_IpgoNo),this);
						StringUtil.printMsg("colNm_IPgoDate",rows[i].getString(colNm_IPgoDate),this);
						StringUtil.printMsg("colNm_IpgoEmpno",rows[i].getString(colNm_IpgoEmpno),this);
						
						cstmt.setString(1, rows[i].getString(colNm_IpgoNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_IPgoDate));
						cstmt.setString(3, rows[i].getString(colNm_IpgoEmpno));
						cstmt.setString(4, iParamEmpno);
						cstmt.setString(5, iParamIp);
						cstmt.setString(6, "1");
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
//						
//						mIpgono = cstmt.getBigDecimal(1).intValue();
//						StringUtil.printMsg("����Ʈ�� �԰��ȣ",mIpgono,this);
//						GauceDataRow row = ipgonoDs.newDataRow();
//						row.addColumnValue(cstmt.getBigDecimal(1).intValue());
//						row.addColumnValue(cstmt.getString(2));
//						row.addColumnValue(cstmt.getString(11));						
//						ipgonoDs.addDataRow(row);
						//�޽���ó��
						if (cstmt.getString(7).equals("Y") ) {
							if ( !cstmt.getString(8).equals("0000") ) {
								StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(9));
								msgDS.addDataRow(row1);
							}
						} else {
							StringUtil.printMsg("���и޽���","���и޽���",this);								
							conn.rollback();
							GauceDataRow row1 = msgDS.newDataRow();								
							row1.addColumnValue(cstmt.getString(9));
							msgDS.addDataRow(row1);
							break inner;						
						} 						
						
						fIpGoNo = cstmt.getString(1);
						
						StringUtil.printMsg("�԰��ȣ ", fIpGoNo,this);
						if(cstmt!=null) cstmt.close();		
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","SALES.PR_AC710I_03-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_IpgoNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_IPgoDate));
						cstmt.setString(3, rows[i].getString(colNm_IpgoEmpno));
						cstmt.setString(4, iParamEmpno);
						cstmt.setString(5, iParamIp);
						cstmt.setString(6, "3");
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//�޽���ó��
						if (cstmt.getString(7).equals("Y") ) {
							if ( !cstmt.getString(8).equals("0000") ) {
								StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(9));
								msgDS.addDataRow(row1);
							}
						} else {
							StringUtil.printMsg("���и޽���","���и޽���",this);								
							conn.rollback();
							GauceDataRow row1 = msgDS.newDataRow();								
							row1.addColumnValue(cstmt.getString(9));
							msgDS.addDataRow(row1);
							break inner;						
						}						
						
						if(cstmt!=null) cstmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						StringUtil.printMsg("call","SALES.PR_AC710I_05-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[5].toString());
						
						StringUtil.printMsg("data",rows[i].getString(colNm_IpgoNo),this);
						
						cstmt.setString(1, rows[i].getString(colNm_IpgoNo));
				//		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, iParamEmpno);
						cstmt.setString(3, iParamIp);
						cstmt.setString(4, "2");
						cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//�޽���ó��
						if (cstmt.getString(5).equals("Y") ) {
							if ( !cstmt.getString(6).equals("0000") ) {
								StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(7));
								msgDS.addDataRow(row1);
							}
						} else {
							StringUtil.printMsg("���и޽���","���и޽���",this);								
							conn.rollback();
							GauceDataRow row1 = msgDS.newDataRow();								
							row1.addColumnValue(cstmt.getString(9));
							msgDS.addDataRow(row1);
							break inner;						
						}
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				ipgonoDs.flush();
			}
				if(inputDs2!=null){
					try {
						throw new Exception();
					} catch ( Exception e) {
						
					}
					
					int colNm_IpgoNo 		= inputDs2.indexOfColumn("IPGO_NO");
					int colNm_GiftType 		= inputDs2.indexOfColumn("GIFT_TYPE");
					int colNm_FrGiftSeq 	= inputDs2.indexOfColumn("FR_GIFT_SEQ");
					int colNm_ToGiftSeq 	= inputDs2.indexOfColumn("TO_GIFT_SEQ");
					int colNm_IpgoQty 		= inputDs2.indexOfColumn("IPGO_QTY");
					int colNm_IpgoPrice 	= inputDs2.indexOfColumn("IPGO_PRICE");
					int colNm_IpgoAmt 		= inputDs2.indexOfColumn("IPGO_AMT");
					
					GauceDataRow[] rows = inputDs2.getDataRows();
					GauceDataColumn[] cols = inputDs2.getDataColumns();
					
					//�԰��ȣ
					res.enableFirstRow(ipgonoDs);
					ipgonoDs.addDataColumn(new GauceDataColumn("ipgo_no", GauceDataColumn.TB_STRING));					
					
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							StringUtil.printMsg("call","SALES.PR_AC710I_04-INSERT",this);
							cstmt = conn.prepareCall(arr_sql[4].toString());

							StringUtil.printMsg("colNm_IpgoNo",rows[i].getString(colNm_IpgoNo),this);
							StringUtil.printMsg("colNm_GiftType", rows[i].getString(colNm_GiftType),this);
							StringUtil.printMsg("colNm_FrGiftSeq",rows[i].getString(colNm_FrGiftSeq),this);
							StringUtil.printMsg("colNm_ToGiftSeq",rows[i].getString(colNm_ToGiftSeq),this);
							StringUtil.printMsg("colNm_IpgoQty",rows[i].getInt(colNm_IpgoQty),this);
							StringUtil.printMsg("colNm_IpgoPrice",rows[i].getInt(colNm_IpgoPrice),this);
							StringUtil.printMsg("colNm_IpgoAmt",rows[i].getInt(colNm_IpgoAmt),this);	
							
							if (rows[i].getString(colNm_IpgoNo) != null && !rows[i].getString(colNm_IpgoNo).equals("")) {
								cstmt.setString(1, rows[i].getString(colNm_IpgoNo));
							} else {
								cstmt.setString(1, fIpGoNo);
							}
					//		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
					//		StringUtil.printMsg("rows[i].getString(colNm_IpgoNo)",rows[i].getString(colNm_IpgoNo),this);
							
							cstmt.setString(2, rows[i].getString(colNm_GiftType));							
							cstmt.setString(3, rows[i].getString(colNm_FrGiftSeq));
							cstmt.setString(4, rows[i].getString(colNm_ToGiftSeq));
							cstmt.setInt(5, rows[i].getInt(colNm_IpgoQty));
							cstmt.setInt(6, rows[i].getInt(colNm_IpgoPrice));
							cstmt.setInt(7, rows[i].getInt(colNm_IpgoAmt));
							cstmt.setString(8, iParamEmpno);
							cstmt.setString(9, iParamIp);
							cstmt.setString(10, "1");
							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							
							GauceDataRow row = ipgonoDs.newDataRow();	
			//				StringUtil.printMsg("cstmt.getBigDecimal(1).intValue()",cstmt.getBigDecimal(1).intValue(),this);
			//				StringUtil.printMsg("cstmt.getBigDecimal(2).intValue()",rows[i].getString(colNm_IpgoNo),this);							
			//				row.addColumnValue(cstmt.getBigDecimal(1).intValue());
							row.addColumnValue(rows[i].getString(colNm_IpgoNo));							
							ipgonoDs.addDataRow(row);
							
							//�޽���ó��
							if (cstmt.getString(11).equals("Y") ) {
								if ( !cstmt.getString(12).equals("0000") ) {
									StringUtil.printMsg("�����޽���","�����޽���",this);
									GauceDataRow row1 = msgDS.newDataRow();									
									row1.addColumnValue(cstmt.getString(13));
									msgDS.addDataRow(row1);
								}
							} else {
								StringUtil.printMsg("���и޽���","���и޽���",this);								
								conn.rollback();
								GauceDataRow row1 = msgDS.newDataRow();								
								row1.addColumnValue(cstmt.getString(13));
								msgDS.addDataRow(row1);
								break inner;						
							}							
							
							if(cstmt!=null) cstmt.close();						
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							StringUtil.printMsg("call","SALES.PR_AC710I_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[4].toString());
							
							StringUtil.printMsg("colNm_IpgoNo",rows[i].getString(colNm_IpgoNo),this);
							StringUtil.printMsg("colNm_GiftType", rows[i].getString(colNm_GiftType),this);
							StringUtil.printMsg("colNm_FrGiftSeq",rows[i].getString(colNm_FrGiftSeq),this);
							StringUtil.printMsg("colNm_ToGiftSeq",rows[i].getString(colNm_ToGiftSeq),this);
							StringUtil.printMsg("colNm_IpgoQty",rows[i].getInt(colNm_IpgoQty),this);
							StringUtil.printMsg("colNm_IpgoPrice",rows[i].getInt(colNm_IpgoPrice),this);
							StringUtil.printMsg("colNm_IpgoAmt",rows[i].getInt(colNm_IpgoAmt),this);
							
							cstmt.setString(1, rows[i].getString(colNm_IpgoNo));
							cstmt.setString(2, rows[i].getString(colNm_GiftType));							
							cstmt.setString(3, rows[i].getString(colNm_FrGiftSeq));
							cstmt.setString(4, rows[i].getString(colNm_ToGiftSeq));
							cstmt.setInt(5, rows[i].getInt(colNm_IpgoQty));
							cstmt.setInt(6, rows[i].getInt(colNm_IpgoPrice));
							cstmt.setInt(7, rows[i].getInt(colNm_IpgoAmt));
							cstmt.setString(8, iParamEmpno);
							cstmt.setString(9, iParamIp);
							cstmt.setString(10, "3");
							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							
							//�޽���ó��
							if (cstmt.getString(11).equals("Y") ) {
								if ( !cstmt.getString(12).equals("0000") ) {
									StringUtil.printMsg("�����޽���","�����޽���",this);
									GauceDataRow row1 = msgDS.newDataRow();									
									row1.addColumnValue(cstmt.getString(13));
									msgDS.addDataRow(row1);
								}
							} else {
								StringUtil.printMsg("���и޽���","���и޽���",this);								
								conn.rollback();
								GauceDataRow row1 = msgDS.newDataRow();								
								row1.addColumnValue(cstmt.getString(13));
								msgDS.addDataRow(row1);
								break inner;						
							}								
							
							if(cstmt!=null) cstmt.close();						
							break;
						case GauceDataRow.TB_JOB_DELETE:
							StringUtil.printMsg("call","SALES.PR_AC710I_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[4].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_IpgoNo));
							cstmt.setString(2, rows[i].getString(colNm_GiftType));							
							cstmt.setString(3, rows[i].getString(colNm_FrGiftSeq));
							cstmt.setString(4, rows[i].getString(colNm_ToGiftSeq));
							cstmt.setInt(5, rows[i].getInt(colNm_IpgoQty));
							cstmt.setInt(6, rows[i].getInt(colNm_IpgoPrice));
							cstmt.setInt(7, rows[i].getInt(colNm_IpgoAmt));
							cstmt.setString(8, iParamEmpno);
							cstmt.setString(9, iParamIp);
							cstmt.setString(10, "2");
							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							
							//�޽���ó��
							if (cstmt.getString(11).equals("Y") ) {
								if ( !cstmt.getString(12).equals("0000") ) {
									StringUtil.printMsg("�����޽���","�����޽���",this);
									GauceDataRow row1 = msgDS.newDataRow();									
									row1.addColumnValue(cstmt.getString(13));
									msgDS.addDataRow(row1);
								}
							} else {
								StringUtil.printMsg("���и޽���","���и޽���",this);								
								conn.rollback();
								GauceDataRow row1 = msgDS.newDataRow();								
								row1.addColumnValue(cstmt.getString(13));
								msgDS.addDataRow(row1);
								break inner;						
							}								
							
							if(cstmt!=null) cstmt.close();						
							break;					
						}
					}	
					ipgonoDs.flush();					
				}
			}
			conn.commit();			
			msgDS.flush();
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}

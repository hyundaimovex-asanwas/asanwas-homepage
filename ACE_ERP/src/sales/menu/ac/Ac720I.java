package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac720I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC720I_01(?,?,?)");
		
		arr_sql[2].append("CALL SALES.PR_AC720I_02(?,?)");
		
		arr_sql[3].append("CALL SALES.PR_AC720I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		
		arr_sql[4].append("CALL SALES.PR_AC720I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		
		arr_sql[5].append("CALL SALES.PR_AC720I_05(?, ?, ?, ?, ?, ?, ?)");
		
		//FOC����
		arr_sql[6].append ("SELECT													\n")
					.append ("	' '		HEAD,												\n")
					.append ("	' '		DETAIL,												\n")
					.append ("	'��ü'	DETAIL_NM										\n")
					.append ("FROM DUAL                      \n")
				    .append ("UNION ALL                                   \n")
				    .append ("SELECT													\n")
					.append ("			HEAD,												\n")
					.append ("			DETAIL,												\n")
					.append ("			DETAIL_NM										\n")
					.append ("FROM															\n")
					.append ("SALES.TSY010												\n")
					.append ("WHERE 1=1													\n")
					.append ("		AND LENGTH(RTRIM(DETAIL)) > 0			\n")
					.append ("		AND HEAD='AC005'											\n");
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
	
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this); 
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		 GauceInputStream gis = greq.getGauceInputStream();
	     GauceOutputStream gos = gres.getGauceOutputStream();
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("initds1")){
					GauceDataSet ds1 = gis.read("initds1");			// �������
					cstmt = conn.prepareCall(arr_sql[6].toString());
		        	rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
            	}
			}
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

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		String sSDate = HDUtil.nullCheckStr(greq.getParameter("sSDate")); 	// ��������
		String sEDate = HDUtil.nullCheckStr(greq.getParameter("sEDate")); 	// �������� 
		String sSaleNo = HDUtil.nullCheckStr(greq.getParameter("sSaleNo"));
		
		String v_gift_type 		= HDUtil.nullCheckStr(greq.getParameter("v_gift_type"));
		String v_fr_gift_seq 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_gift_seq"));
		String v_to_gift_seq 	= HDUtil.nullCheckStr(greq.getParameter("v_to_gift_seq"));
		/*
		StringUtil.printMsg("PR_AC720I_01",arr_sql[1].toString()+"",this);
		StringUtil.printMsg("������ S",sSDate,this);
		StringUtil.printMsg("������ E",sEDate,this);
		*/
		try {
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, sSDate);
					cstmt.setString(2, sEDate);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				} 
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1,sSaleNo);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
					
					//StringUtil.printMsg("PR_AC710I_02",arr_sql[2].toString()+"",this);
					//StringUtil.printMsg("�԰��ȣ",sSaleNo,this);
				} 
            	if(dSets[i].getName().equals("ds_giftAmt")){
					GauceDataSet ds1 = gis.read("GIFTAMT");
	
					cstmt = conn.prepareCall(arr_sql[0].toString());
					/*
					StringUtil.printMsg("gift_type",v_gift_type,this);
					StringUtil.printMsg("fr_gift_type",v_fr_gift_seq,this);
					StringUtil.printMsg("to_gift_type",v_to_gift_seq,this);
					*/
					cstmt.setString(1,v_gift_type);
					cstmt.setString(2,v_fr_gift_seq);
					cstmt.setString(3,v_to_gift_seq);
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}else if(dSets[i].getName().equals("ds_giftlist")){
					GauceDataSet ds1 = gis.read("GIFTLIST"); 
					
					cstmt = conn.prepareCall(arr_sql[7].toString());
					
					cstmt.setString(1,v_gift_type);
					cstmt.setString(2,v_fr_gift_seq);
					cstmt.setString(3,v_to_gift_seq);
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
			}							
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
	
		    if(cstmt!=null) cstmt.close();
		}
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;	
		ResultSet rs = null;
		// "JSP(I:DS1=ds1,O:msgDS=msgDS,O:ipgonoDs=ipgonoDs,I:DS2=ds2)",
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		GauceDataSet inputDs 	= gis.read("DS1");	
		GauceDataSet inputDs2 	= gis.read("DS2");	
		GauceDataSet ipgonoDs 	= gis.read("ipgonoDs");	
		GauceDataSet msgDS 	= gis.read("msgDS");	
		/*
		GauceDataSet inputDs = req.getGauceDataSet("DS1");
		GauceDataSet inputDs2 = req.getGauceDataSet("DS2");
		GauceDataSet ipgonoDs = req.getGauceDataSet("ipgonoDs");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		*/
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		String fSaleNo = "";
		try{
			inner: {
			if(inputDs!=null){
				
				int colNm_SaleNo                = inputDs.indexOfColumn("SALE_NO");
				int colNm_SaleDate              = inputDs.indexOfColumn("SALE_DATE");
				int colNm_VendCd                = inputDs.indexOfColumn("VEND_CD");
				int colNm_FocGu                 = inputDs.indexOfColumn("FOC_GU");
				int colNm_SaleEmpno             = inputDs.indexOfColumn("SALE_EMPNO");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				
				//�԰��ȣ
				ipgonoDs.addDataColumn(new GauceDataColumn("SALE_NO", GauceDataColumn.TB_STRING));
				
				//�޽���ó��
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","SALES.PR_AC720I_03-INSERT",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_SaleNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_SaleDate));
						cstmt.setString(3, rows[i].getString(colNm_VendCd));
						cstmt.setString(4, rows[i].getString(colNm_FocGu));
						cstmt.setString(5, rows[i].getString(colNm_SaleEmpno));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, iParamIp);
						cstmt.setString(8, "1");
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();

						//�޽���ó��
						if (cstmt.getString(9).equals("Y") ) {
							if ( !cstmt.getString(10).equals("0000") ) {
								//StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(11));
								msgDS.addDataRow(row1);
							}
						} else {
							throw new Exception(cstmt.getString(11));
						} 						
						
						fSaleNo = cstmt.getString(1);
						
						GauceDataRow ipgoRow = ipgonoDs.newDataRow();									
						ipgoRow.addColumnValue(cstmt.getString(1));
						ipgonoDs.addDataRow(ipgoRow);
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_AC720I_03-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						/*
						StringUtil.printMsg("colNm_SaleNo",rows[i].getString(colNm_SaleNo),this);
						StringUtil.printMsg("colNm_SaleDate",rows[i].getString(colNm_SaleDate),this);
						StringUtil.printMsg("colNm_VendCd",rows[i].getString(colNm_VendCd),this);
						StringUtil.printMsg("colNm_FocGu",rows[i].getString(colNm_FocGu),this);
						StringUtil.printMsg("colNm_SaleEmpno",rows[i].getString(colNm_SaleEmpno),this);
						*/
						cstmt.setString(1, rows[i].getString(colNm_SaleNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_SaleDate));
						cstmt.setString(3, rows[i].getString(colNm_VendCd));
						cstmt.setString(4, rows[i].getString(colNm_FocGu));
						cstmt.setString(5, rows[i].getString(colNm_SaleEmpno));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, iParamIp);
						cstmt.setString(8, "3");
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//�޽���ó��
						if (cstmt.getString(9).equals("Y") ) {
							if ( !cstmt.getString(10).equals("0000") ) {
								//StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(11));
								msgDS.addDataRow(row1);
							}
						} else {
							throw new Exception(cstmt.getString(11));
						}						
						
						if(cstmt!=null) cstmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_AC720I_05-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[5].toString());
						
						//StringUtil.printMsg("data",rows[i].getString(colNm_SaleNo),this);
						
						cstmt.setString(1, rows[i].getString(colNm_SaleNo));
		//				cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
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
								//StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(7));
								msgDS.addDataRow(row1);
							}
						} else {
							throw new Exception(cstmt.getString(7));
						}
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				gos.write(ipgonoDs);
				//ipgonoDs.flush();
			}
				if(inputDs2!=null){
					try {
						throw new Exception();
					} catch ( Exception e) {
						
					}
					int v_gift_cnt 	= HDUtil.nullCheckNum(greq.getParameter("v_gift_cnt"));
					int v_gift_amt 	= HDUtil.nullCheckNum(greq.getParameter("v_gift_amt"));
					
					int colNm_SaleNo                = inputDs2.indexOfColumn("SALE_NO");
					int colNm_GiftType              = inputDs2.indexOfColumn("GIFT_TYPE");
					int colNm_GiftType_nm           = inputDs2.indexOfColumn("GIFT_TYPE_NM");
					int colNm_FrGift_seq            = inputDs2.indexOfColumn("FR_GIFT_SEQ");
					int colNm_ToGift_seq            = inputDs2.indexOfColumn("TO_GIFT_SEQ");
					int colNm_SaleQty               = inputDs2.indexOfColumn("SALE_QTY");
					int colNm_SalePrice             = inputDs2.indexOfColumn("SALE_PRICE");
					int colNm_SaleAmt               = inputDs2.indexOfColumn("SALE_AMT");

					GauceDataRow[] rows = inputDs2.getDataRows();
					GauceDataColumn[] cols = inputDs2.getDataColumns();
					
					//�԰��ȣ
					for(int i=0; i<rows.length; i++){
						int j=1;
						String v_status = "";
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_INSERT:
								v_status = "1";
								break;
							case GauceDataRow.TB_JOB_UPDATE:
								v_status = "3";
								break;
							case GauceDataRow.TB_JOB_DELETE:
								v_status = "2";
								break;
						}
						//StringUtil.printMsg("call","SALES.PR_AC720I_04-INSERT",this);
						cstmt = conn.prepareCall(arr_sql[4].toString());
						/*
						StringUtil.printMsg("colNm_GiftType=",rows[i].getString(colNm_GiftType)  ,this);
						StringUtil.printMsg("colNm_FrGift_seq=",rows[i].getString(colNm_FrGift_seq),this);
						StringUtil.printMsg("colNm_ToGift_seq=",rows[i].getString(colNm_ToGift_seq),this);
						StringUtil.printMsg("colNm_SaleQty=",rows[i].getInt(colNm_SaleQty),this);
						StringUtil.printMsg("colNm_SalePrice=",rows[i].getInt(colNm_SalePrice),this);
						StringUtil.printMsg("colNm_SaleAmt=",rows[i].getInt(colNm_SaleAmt),this);
						*/
						
						
						
						if (rows[i].getString(colNm_SaleNo) != null && !rows[i].getString(colNm_SaleNo).equals("")) {
							cstmt.setString(1, rows[i].getString(colNm_SaleNo));
						} else {
							cstmt.setString(1, fSaleNo);
						}
						
						cstmt.setString(2, rows[i].getString(colNm_GiftType));							
						cstmt.setString(3, rows[i].getString(colNm_FrGift_seq));
						cstmt.setString(4, rows[i].getString(colNm_ToGift_seq));
						//cstmt.setInt(5, v_gift_cnt);						//����
						cstmt.setInt(5, rows[i].getInt(colNm_SaleQty));						//����
						cstmt.setInt(6, rows[i].getInt(colNm_SalePrice));	//�ܰ�
						//cstmt.setInt(7, v_gift_amt);						//�ݾ�
						cstmt.setInt(7, rows[i].getInt(colNm_SaleAmt));						//�ݾ�
						
						
						cstmt.setString(8, iParamEmpno);
						cstmt.setString(9, iParamIp);
						cstmt.setString(10, v_status);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//�޽���ó��
						if (cstmt.getString(11).equals("Y") ) {
							if ( !cstmt.getString(12).equals("0000") ) {
								//StringUtil.printMsg("�����޽���","�����޽���",this);
								GauceDataRow row1 = msgDS.newDataRow();									
								row1.addColumnValue(cstmt.getString(13));
								msgDS.addDataRow(row1);
							}
						} else {
							throw new Exception(cstmt.getString(13));
						}							
						
						if(cstmt!=null) cstmt.close();						
					}	
				}
			}
			conn.commit();			
			if(msgDS!=null) gos.write(msgDS);
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}

package sales.menu.rv;

import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import java.math.BigDecimal;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.*;
import sales.common.HDUtil;
import sales.common.SuperServlet;

public class Rv200I_BACK20090420 extends SuperServlet {
   
	public void makeSql() {
		//��û�� ��ȣ ��ȸ��....
		arr_sql[0].append ("SELECT R1.ACCEPT_SID,                                    /*  ��û�� SID		 */	\n")
				  .append ("       R1.ACCEPT_NO,                                     /*  ��û�� ��ȣ     */	\n")
				  .append ("       R1.DEPART_DATE,                                   /*  �������        */	\n")
				  .append ("       R2.DEPART_TIME,                                   /*  ��߽ð�        */	\n")
				  .append ("       R2.NIGHTS,                                        /*  �ڼ�            */	\n")
				  .append ("       R1.GOODS_SID,                                     /*  ��ǰSID         */	\n")
				  .append ("	   SALES.FN_GOODS_NM(R1.GOODS_SID, '') AS GOODS_NM,  /*  ��ǰ��		*/	\n")
				  .append ("       R2.ARRIVE_DATE,                                   /*  ��������        */	\n")
				  .append ("       R2.ARRIVE_TIME,                                   /*  ���ͽð�        */	\n")
				  .append ("       R1.SAUP_SID,                                      /*  �����          */	\n")
				  .append ("       R1.CLIENT_SID,                                    /*  ����ó/�븮��   */	\n")
				  .append ("       SALES.FN_CLIENT_NM(CLIENT_SID, '') AS CLIENT_NM,  /*  ����ó��        */	\n")
				  .append ("       R1.EVENT_SID,                                     /*  ���SID         */	\n")
				  .append ("       R3.EVENT_NO,                                      /*  ����ȣ        */	\n")
				  .append ("       R3.EVENT_NM                                       /*  ����          */	\n")
				  .append ("  FROM SALES.TRV010 R1                                                       	\n")
				  .append ("  LEFT OUTER JOIN SALES.TRM220 R2  ON R2.GOODS_SID = R1.GOODS_SID            	\n")
				  .append ("   AND  R2.DEPART_DATE = R1.DEPART_DATE                                      	\n")
				  .append ("  LEFT OUTER JOIN SALES.TRV060 R3  ON R3.EVENT_SID = R1.EVENT_SID            	\n")
				  .append (" WHERE R1.ACCEPT_NO  =  ?													 	\n");
		
		//��ǰ���� ��ȸ��....
		arr_sql[1].append ("SELECT R1.GOODS_SID,     /* ��ǰSID     */		\n")
				  .append ("       R1.GOODS_NM,      /* ��ǰ��      */      \n")
				  .append ("       R2.DEPART_DATE,   /* �������    */      \n")
				  .append ("       R2.DEPART_TIME,   /* ��߽ð�    */      \n")
				  .append ("       R2.NIGHTS,        /* �ڼ�        */      \n")
				  .append ("       R2.ARRIVE_DATE,   /* ��������    */      \n")
				  .append ("       R2.ARRIVE_TIME    /* ���ͽð�	*/      \n")
				  .append ("  FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2     \n")
				  .append ("    ON R2.GOODS_SID = R1.GOODS_SID              \n")
				  .append (" WHERE R1.SAUP_SID     =  ?						\n")
				  .append ("   AND R2.DEPART_DATE  =  ?						\n")
				  .append (" ORDER BY R1.GOODS_NM, R2.DEPART_TIME			\n");

		//���� Ÿ�� / ���氡�� ����
		arr_sql[2].append ("{call SALES.PR_RV200I_22(?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//������ ��� ��ȸ
		arr_sql[3].append ("{call SALES.PR_RV200I_23(?, ?, ?, ?, ?)}");
		
		//�ɼ� ��ݳ��� ����
		arr_sql[4].append ("SELECT R1.MENU_SID,                                                   /* �޴�SID	*/	\n")
				  .append ("       R2.KEY_SEQ,                                                    /* ����       */  \n")
				  .append ("       (CASE WHEN R2.SALE_QTY > 0 THEN 'T' ELSE 'F' END) AS USE_YN,   /* ����       */  \n")
				  .append ("       (CASE WHEN R2.RSV_PAY_YN > 0 THEN 'T' ELSE 'F' END) AS RSV_PAY_YN, /* ����ð��� */  \n")
				  .append ("       R1.MENU_NM,                                                    /* �׸�       */  \n")
				  .append ("       COALESCE(R2.USE_AMT, R1.UNIT_AMT) AS USE_AMT,                  /* �ݾ�       */  \n")
				  .append ("       R2.SALE_QTY,                                                   /* �Ǹż���   */  \n")
				  .append ("       R2.USE_AMT * R2.SALE_QTY          AS TOT_USE_AMT,              /* �հ�       */  \n")
				  .append ("       R2.REMARKS                                                     /* �������   */  \n")
				  .append ("  FROM SALES.TRV100 R1 LEFT OUTER JOIN SALES.TRV030 R2                                  \n")
				  .append ("    ON R2.MENU_SID    =  R1.MENU_SID AND R2.RSV_SID = ?			                        \n")
				  .append (" WHERE R1.BGN_DATE   <=  ?				                                                \n")
				  .append ("   AND R1.END_DATE   >=  ?				                                                \n")
				  .append ("   AND R1.OPTION_YN   =  'Y'                                                            \n");
				  //.append ("   AND R1.OPTION_VIEW_CD IN ('1', '2')													\n");

		//Block ����: ds_block
		arr_sql[7].append ("{call SALES.PR_RV200I_21(?, ?, ?, ?, ?, ?, ?) }");
		
		//������ ���
		arr_sql[8].append ("{call SALES.PR_RV200I_20(?, ?) }");
		
		//������ �߰��� ����üũ
		arr_sql[9].append ("{call SALES.PR_DC_MAIN(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//������ ���� ����
		arr_sql[10].append ("{call SALES.PR_RV200I_01(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//Option ��� ����
		arr_sql[11].append ("{call SALES.PR_RV200I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//���Ǻ��� ����
		arr_sql[12].append ("{call SALES.PR_RV200I_05(?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//�ǸŰ� ��� ����
		arr_sql[13].append ("{call SALES.PR_RV200I_06(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

		//��ĳ���� ���� ��ȸ
		arr_sql[14].append ("{call SALES.PR_RV200I_24(?, ?, ?, ?, ?, ?) }");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
	}

	/**
	 * �⺻���� ��ȸ ó�� ���
	 * ��Ÿ �б��� �� �ִٸ�... �̰����� ó���Ͽ� �Ѱ��ش�.
	 */
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		GauceStatement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			int    v_business    = HDUtil.nullCheckNum(req.getParameter("v_business")); 	//�����
			String v_accept_check= HDUtil.nullCheckStr(req.getParameter("v_accept_check")); //üũ�ڽ�
			String v_accept_no   = HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	//��û����ȣ
			String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));	//�������
			String v_depart_time = HDUtil.nullCheckStr(req.getParameter("v_depart_time"));	//��߽ð�
			String v_arrive_date = HDUtil.nullCheckStr(req.getParameter("v_arrive_date"));	//��������
			String v_arrive_time = HDUtil.nullCheckStr(req.getParameter("v_arrive_time"));	//�����ð�
			String v_blockType   = HDUtil.nullCheckStr(req.getParameter("v_blockType")); 	//���/�Ϲ� ���� ����
			
			String v_fr_date 	 = HDUtil.nullCheckStr(req.getParameter("v_fr_date"));	//��������
			String v_to_date 	 = HDUtil.nullCheckStr(req.getParameter("v_to_date"));	//��������

			int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//���� SID
			int    v_client_sid  = HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//����ó�ڵ�
			int    v_goods_sid   = HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));	//��ǰ SID
			int    v_roomType    = HDUtil.nullCheckNum(req.getParameter("v_roomType"));		//ROOMTYPE SID
			//StringUtil.printMsg("v_roomType sid �޾ƿ� ��?????==", v_roomType, this);
			int    v_room_sid    = HDUtil.nullCheckNum(req.getParameter("v_room_sid"));		//ROOM SID
			int    v_block_sid    = HDUtil.nullCheckNum(req.getParameter("v_block_sid"));	//BLOCK SID
			int    v_event_sid   = HDUtil.nullCheckNum(req.getParameter("v_event_sid"));	//��ü���SID
			int    v_nights      = HDUtil.nullCheckNum(req.getParameter("v_nights"));		//�ڼ�
			int    v_m_rsv_sid   = HDUtil.nullCheckNum(req.getParameter("v_m_rsv_sid"));	//���� SID
			int    v_rsv_sid     = HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));		//���� SID
			//StringUtil.printMsg("v_rsv_sid �޾ƿ� ��?????==", v_rsv_sid, this);

			//������ȣ�� ������ ��� ��ȸ
			String v_manage_no   = HDUtil.nullCheckStr(req.getParameter("v_manage_no"));//�� ������ȣ

			/* DataSet */
			GauceDataSet ds_search 		= req.getGauceDataSet("SEARCH");	//�˻�����
			GauceDataSet ds_room   		= req.getGauceDataSet("ROOM");		//��Ÿ��
			GauceDataSet ds_block  		= req.getGauceDataSet("BLOCK");		//���/�Ϲ�
			GauceDataSet ds_roomChange  = req.getGauceDataSet("ROOMCHANGE");//���氡�ɰ���
			GauceDataSet ds_cust   		= req.getGauceDataSet("CUST");		//������ ���
			GauceDataSet ds_tour   		= req.getGauceDataSet("TOUR");		//�ɼ� ��� ����
			GauceDataSet ds_forecasting = req.getGauceDataSet("FORECASTING");		//FORECASTING

			GauceDataSet ds_cust_temp   = req.getGauceDataSet("CUST_TEMP");	//����� ��ȸ
			GauceDataSet ds_cust_result = req.getGauceDataSet("CUST_RESULT");	//����� ���� ���

			Properties pt_cust_temp   = null;


			//�⺻ �˻� ����
			if(ds_search!=null){
				res.enableFirstRow(ds_search);

				if(!v_accept_no.equals("")){
					if(v_client_sid!=0)
						arr_sql[0].append ("  AND R1.CLIENT_SID = ?			\n");
					stmt = conn.getGauceStatement(arr_sql[0].toString());
					stmt.setString(1, v_accept_no);
					if(v_client_sid!=0)
						stmt.setInt(2, v_client_sid);
				} else if(!v_depart_date.equals("")){
					stmt = conn.getGauceStatement(arr_sql[1].toString());
					stmt.setInt(1, v_business);
					stmt.setString(2, v_depart_date);
				}
				rs = stmt.executeQuery();
				
				getDataSet(rs, ds_search).flush();
				
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
			}
			
			//��Ÿ��
			if(ds_room!=null){
				res.enableFirstRow(ds_room);
				cstmt = conn.prepareCall(arr_sql[2].toString());
				cstmt.setString(1, v_blockType);
				cstmt.setString(2, "N");
				cstmt.setInt   (3, v_client_sid);
				cstmt.setString(4, v_depart_date);
				cstmt.setInt   (5, v_goods_sid);
				cstmt.setInt   (6, 0);
				cstmt.setInt   (7, v_accept_sid);
				cstmt.setInt   (8, v_nights);
				cstmt.setInt   (9, v_business);
				
				rs = cstmt.executeQuery();

				getDataSet(rs, ds_room).flush();
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//block info
			if(ds_block!=null){
				res.enableFirstRow(ds_block);
				cstmt = conn.prepareCall(arr_sql[7].toString());
				cstmt.setString(1, v_blockType);
				cstmt.setInt   (2, v_client_sid);
				cstmt.setString(3, v_depart_date);
				cstmt.setInt   (4, v_goods_sid);
				cstmt.setInt   (5, v_roomType);
				cstmt.setInt   (6, v_accept_sid);
				cstmt.setInt   (7, v_nights);
				
				
				//StringUtil.printMsg("��Ÿ�� - ", v_blockType, this);
				//StringUtil.printMsg("�븮��SID - ", v_client_sid, this);
				//StringUtil.printMsg("����� - ", v_depart_date, this);
				//StringUtil.printMsg("��ǰSID - ", v_goods_sid, this);
				//StringUtil.printMsg("����Ÿ�� - ", v_roomType, this);
				//StringUtil.printMsg("��û��SID - ", v_accept_sid, this);
				//StringUtil.printMsg("�ڼ�  - ", v_nights, this);
								
				
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_block).flush();
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//���氡�ɰ���
			if(ds_roomChange!=null){
				res.enableFirstRow(ds_roomChange);

				cstmt = conn.prepareCall(arr_sql[2].toString());
				cstmt.setString(1, v_blockType);
				cstmt.setString(2, "Y");
				cstmt.setInt   (3, v_client_sid);
				cstmt.setString(4, v_depart_date);
				cstmt.setInt   (5, v_goods_sid);
				cstmt.setInt   (6, v_roomType);
				cstmt.setInt   (7, v_accept_sid);
				cstmt.setInt   (8, v_nights);
				cstmt.setInt   (9, v_business);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_roomChange).flush();
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//������ ���

		
			//StringUtil.printMsg("��������ȸ-�������.", v_depart_date, this);
			//StringUtil.printMsg("��������ȸ-��ǰ.", v_goods_sid, this);
			//StringUtil.printMsg("��������ȸ-�ֹ�.", v_manage_no, this);
			
			if(ds_cust!=null){
				//StringUtil.printMsg("ds_cust�ϱ��???", "", this);
				res.enableFirstRow(ds_cust);
				cstmt = conn.prepareCall(arr_sql[3].toString()); //ds_cust������ �̰� ��ȸ�Ѵ�.SALES.PR_RV200I_23
				if(v_rsv_sid==0){
					if(!v_manage_no.equals("")){
						//StringUtil.printMsg("1����ȸ", v_goods_sid, this);
						cstmt.setInt(1, 0);
						cstmt.setInt(2, 0);
						cstmt.setString(3, v_manage_no);
						cstmt.setString(4, v_depart_date);
						cstmt.setInt   (5, v_goods_sid);
					} else {
						//StringUtil.printMsg("2����ȸ", v_m_rsv_sid, this);
						cstmt.setInt(1, 0);
						cstmt.setInt(2, v_m_rsv_sid);
						cstmt.setString(3, "");
						cstmt.setString(4, v_depart_date);
						cstmt.setInt   (5, v_goods_sid);
						
					}
				} else {
					//StringUtil.printMsg("3����ȸ", v_goods_sid, this);
					cstmt.setInt(1, v_rsv_sid);
					cstmt.setInt(2, 0);
					cstmt.setString(3, v_manage_no);
					cstmt.setString(4, v_depart_date);
					cstmt.setInt   (5, v_goods_sid);
				}
				
				rs = cstmt.executeQuery();
				pt_cust_temp = getDataSet1(rs, ds_cust);
							
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();

				if(pt_cust_temp!=null){
					cstmt = conn.prepareCall(arr_sql[9].toString());	//pr_dc_main. �׸��� ����..
					cstmt.setString (1, "G15");				//��ûâ����ȣ: ���� ��׸��� Ŭ���� ��, ��� ������
					StringUtil.printMsg("304���� pACCEPT_SEQ", "G15", this);	// ���� ���� �ƴϳ�..
					cstmt.setInt	(2, v_accept_sid);		//��û��SID
					//StringUtil.printMsg("v_accept_sid==", v_accept_sid, this);
					cstmt.setString (3, v_depart_date);		//�������
					//StringUtil.printMsg("v_depart_date==", v_depart_date, this);
					cstmt.setInt	(4, v_goods_sid);		//��ǰSID
					//StringUtil.printMsg("v_goods_sid==", v_goods_sid, this);
					cstmt.setInt	(5, v_client_sid);		//����óSID
					//StringUtil.printMsg("v_client_sid==", v_client_sid, this);
					cstmt.setInt	(6, v_event_sid);		//��ü���SID
					//StringUtil.printMsg("v_event_sid==", v_accept_sid, this);
					cstmt.setString (7, "1");				//�۾�����[RM013] ��������/��Ͻ�û
					cstmt.setInt	(8, v_rsv_sid);			//����SID
					//StringUtil.printMsg("v_rsv_sid==", v_rsv_sid, this);//0���� ��������.
					cstmt.setInt	(9, v_m_rsv_sid);		//���ο���SID
					//StringUtil.printMsg("v_m_rsv_sid==", v_m_rsv_sid, this);
					cstmt.setInt	(10, v_roomType);		//����SID
					//StringUtil.printMsg("�����ϱ� ds_cust", v_roomType, this);//���⼭ ���� �߻�.
					cstmt.setInt	(11, v_room_sid);		//��SID
					//StringUtil.printMsg("v_room_sid==", v_room_sid, this);
					cstmt.setInt	(12, v_block_sid);		//���SID
					//StringUtil.printMsg("v_block_sid==", v_block_sid, this);
					cstmt.setString (13, v_blockType);		//����Ÿ�� -- ���/�Ϲ�
					//StringUtil.printMsg("v_blockType==", v_blockType, this);
					cstmt.setString (14, v_depart_time);	//��߽ð�
					//StringUtil.printMsg("v_depart_time==", v_depart_time, this);
					cstmt.setInt	(15, v_nights);			//�ڼ�
					//StringUtil.printMsg("v_nights==", v_nights, this);
					cstmt.setString (16, v_arrive_date);	//��������
					//StringUtil.printMsg("v_arrive_date==", v_arrive_date, this);
					cstmt.setString (17, v_arrive_time);	//���ͽð�
					//StringUtil.printMsg("v_arrive_time==", v_arrive_time, this);

					cstmt.setInt	(18, Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")));//��SID
					//StringUtil.printMsg("CUST_SID==", Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")), this);
					cstmt.registerOutParameter(18, java.sql.Types.DECIMAL);	//��SID
					cstmt.setString (19, pt_cust_temp.getProperty("MANAGE_NO"));	//��������ȣ
					StringUtil.printMsg("MANAGE_NO==", pt_cust_temp.getProperty("MANAGE_NO"), this);
					cstmt.setString (20, pt_cust_temp.getProperty("CUST_GU"));	//������
					//StringUtil.printMsg("CUST_GU==", pt_cust_temp.getProperty("CUST_GU"), this);
					cstmt.setString (21, pt_cust_temp.getProperty("SAUP_GU"));	//�������
					//StringUtil.printMsg("SAUP_GU==", pt_cust_temp.getProperty("SAUP_GU"), this);
					cstmt.setString (22, pt_cust_temp.getProperty("CUST_TYPE"));	//������
					//StringUtil.printMsg("CUST_TYPE==", pt_cust_temp.getProperty("CUST_TYPE"), this);
					cstmt.setString (23, pt_cust_temp.getProperty("AGE_CD"));	//���ɱ���
					//StringUtil.printMsg("AGE_CD==", pt_cust_temp.getProperty("AGE_CD"), this);
					cstmt.setString (24, pt_cust_temp.getProperty("JOIN_CD"));	//�����ڵ�[RV006] ����/�����/...
					//StringUtil.printMsg("JOIN_CD==", pt_cust_temp.getProperty("JOIN_CD"), this);
					cstmt.setString (25, "1");								//�����û���[RV020] CS/WEB/...
					cstmt.setString (26, fParamEmpno);							//���������ڻ��
					cstmt.registerOutParameter(27, java.sql.Types.DECIMAL);	//�������
					cstmt.registerOutParameter(28, java.sql.Types.DECIMAL);	//�ɼǿ��
					cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);	//�������� : �̰� ����� �ȳѾ�� ����..
					cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
					cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);	//�޼���
					
					cstmt.executeUpdate();
					//StringUtil.printMsg("���� : 355 ==================", cstmt.getString(29)+ "[]", this);
					
					if(cstmt.getString(29).equals("N")){	//-- ���� ����..
						throw new Exception(cstmt.getString(31));
					}

					
					if(ds_cust_result!=null){
						res.enableFirstRow(ds_cust_result);
						ds_cust_result.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("TOUR_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("OPTION_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						
						GauceDataRow row = ds_cust_result.newDataRow();
						
						row.addColumnValue(cstmt.getBigDecimal(18).intValue());
						row.addColumnValue(cstmt.getBigDecimal(27).intValue());
						row.addColumnValue(cstmt.getBigDecimal(28).intValue());
						row.addColumnValue(cstmt.getString(29));
						row.addColumnValue(cstmt.getString(30));
						row.addColumnValue(cstmt.getString(31));
						
						ds_cust_result.addDataRow(row);
						ds_cust_result.flush();
					}

					if(cstmt!=null) cstmt.close();
				}
				
				//StringUtil.printMsg("ds_cust ���� ��-------------------------", "", this);
			}
			
			//ForeCasting ���� ��ȸ
			if(ds_forecasting!=null){
				res.enableFirstRow(ds_forecasting);
				cstmt = conn.prepareCall(arr_sql[14].toString());
				
				cstmt.setString(1, v_blockType);
				//StringUtil.printMsg("�����ϱ� ds_forecasting", v_blockType, this);//���⼭ ���� �߻�.
				cstmt.setInt(2, v_client_sid);
				cstmt.setInt(3, v_goods_sid);
				cstmt.setInt(4, v_nights);
				cstmt.setString(5, v_fr_date);
				cstmt.setString(6, v_to_date);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_forecasting).flush();
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//������ ��� info
			if(ds_tour!=null){
				res.enableFirstRow(ds_tour);
				cstmt = conn.prepareCall(arr_sql[8].toString());
				cstmt.setInt   (1, v_accept_sid);
				cstmt.setString(2, v_accept_check);
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_tour).flush();

				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			if(ds_cust_temp!=null){
				//StringUtil.printMsg("ds_cust_temp�ϱ��???", "", this);
				res.enableFirstRow(ds_cust_temp);

				cstmt = conn.prepareCall(arr_sql[3].toString()); //�������� ��ȸ�ؿͼ� PR_RV200I_23(?, ?, ?, ?, ?)
				cstmt.setInt(1, 0);
				cstmt.setInt(2, 0);
				cstmt.setString(3, v_manage_no);
				cstmt.setString(4, v_depart_date);	//�߰� - ���λ� ����� ���� �Ķ����.
				cstmt.setInt   (5, v_goods_sid);	//�߰� 
				
				//StringUtil.printMsg("ds_cust_temp ::::::::::::", arr_sql[3].toString(), this);				
				//StringUtil.printMsg("arr_sql[3] v_manage_no", v_manage_no, this);
				rs = cstmt.executeQuery();
				pt_cust_temp = getDataSet1(rs, ds_cust_temp);
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();

				if(pt_cust_temp!=null){
					cstmt = conn.prepareCall(arr_sql[9].toString());	//����üũ�۾��� �Ѵ�(PR_DC_MAIN)
					//StringUtil.printMsg("449���� arr_sql[9] ::::::::::::", arr_sql[9].toString(), this);
					cstmt.setString (1, "G14");				//��ûâ����ȣ: ������ �߰���ư Ŭ���� ��. �̶��� �ߺ�üũ
					StringUtil.printMsg("451���� pACCEPT_SEQ", "G14", this);	// ���� ���� �ƴϳ�..
					cstmt.setInt	(2, v_accept_sid);		//��û��SID
					cstmt.setString (3, v_depart_date);		//�������
					//StringUtil.printMsg("ds_cust_temp:3", v_depart_date, this);	// ���� ���� �ƴϳ�..
					cstmt.setInt	(4, v_goods_sid);		//��ǰSID
					cstmt.setInt	(5, v_client_sid);		//����óSID
					cstmt.setInt	(6, v_event_sid);		//��ü���SID
					cstmt.setString (7, "1");				//�۾�����[RM013] ��������/��Ͻ�û
					cstmt.setInt	(8, v_rsv_sid);			//����SID
					//StringUtil.printMsg("ds_cust_temp:8", v_rsv_sid, this);	// ���� ���� �ƴϳ�..
					cstmt.setInt	(9, v_m_rsv_sid);		//���ο���SID
					cstmt.setInt	(10, v_roomType);		//����SID
					//StringUtil.printMsg("�����ϱ� ds_cust_temp", v_roomType, this);	// ���� ���� �ƴϳ�..
					cstmt.setInt	(11, v_room_sid);		//��SID
					cstmt.setInt	(12, v_block_sid);		//���SID
					cstmt.setString (13, v_blockType);		//����Ÿ�� -- ���/�Ϲ�
					cstmt.setString (14, v_depart_time);	//��߽ð�
					cstmt.setInt	(15, v_nights);			//�ڼ�
					cstmt.setString (16, v_arrive_date);	//��������
					//StringUtil.printMsg("ds_cust_temp:16", v_arrive_date, this);	// ���� ���� �ƴϳ�..
					cstmt.setString (17, v_arrive_time);	//���ͽð�

					cstmt.setInt	(18, Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")));//��SID
					cstmt.registerOutParameter(18, java.sql.Types.DECIMAL);	//��SID
					//StringUtil.printMsg("ds_cust_temp:18", pt_cust_temp.getProperty("CUST_SID"), this);	//
					cstmt.setString (19, pt_cust_temp.getProperty("MANAGE_NO"));	//��������ȣ
					StringUtil.printMsg("ds_cust_temp:19", pt_cust_temp.getProperty("MANAGE_NO"), this);	//
					cstmt.setString (20, pt_cust_temp.getProperty("CUST_GU"));	//������
					cstmt.setString (21, pt_cust_temp.getProperty("SAUP_GU"));	//�������
					cstmt.setString (22, pt_cust_temp.getProperty("CUST_TYPE"));	//������
					cstmt.setString (23, pt_cust_temp.getProperty("AGE_CD"));	//���ɱ���
					cstmt.setString (24, pt_cust_temp.getProperty("JOIN_CD"));	//�����ڵ�[RV006] ����/�����/...
					cstmt.setString (25, "1");								//�����û���[RV020] CS/WEB/...
					cstmt.setString (26, fParamEmpno);							//���������ڻ��
					cstmt.registerOutParameter(27, java.sql.Types.DECIMAL);	//�������
					cstmt.registerOutParameter(28, java.sql.Types.DECIMAL);	//�ɼǿ��
					cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);	//��������
					cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
					cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);	//�޼���
					
					cstmt.executeUpdate();
					
					//StringUtil.printMsg("�Ǹ�Ȯ��üũ ����޼���?",cstmt.getString(29), this);
					//StringUtil.printMsg("�Ǹ�Ȯ��üũ ����޼���?",cstmt.getString(31), this);
					if(cstmt.getString(29).equals("N"))
						throw new Exception(cstmt.getString(31));
					
					if(ds_cust_result!=null){
						res.enableFirstRow(ds_cust_result);
						ds_cust_result.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("TOUR_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("OPTION_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						
						GauceDataRow row = ds_cust_result.newDataRow();
						
						row.addColumnValue(cstmt.getBigDecimal(18).intValue());
						row.addColumnValue(cstmt.getBigDecimal(27).intValue());
						row.addColumnValue(cstmt.getBigDecimal(28).intValue());
						row.addColumnValue(cstmt.getString(29));
						row.addColumnValue(cstmt.getString(30));
						row.addColumnValue(cstmt.getString(31));
						
						ds_cust_result.addDataRow(row);
						ds_cust_result.flush();
					}

					if(cstmt!=null) cstmt.close();
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	/**
	 * CUD �۾� ó��...
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		try{
			String v_accept_no   = HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	//��û����ȣ
			String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));	//�������
			String v_depart_time = HDUtil.nullCheckStr(req.getParameter("v_depart_time"));	//��߽ð�
			String v_arrive_date = HDUtil.nullCheckStr(req.getParameter("v_arrive_date"));	//��������
			String v_arrive_time = HDUtil.nullCheckStr(req.getParameter("v_arrive_time"));	//�����ð�
			String v_blockType   = HDUtil.nullCheckStr(req.getParameter("v_blockType")); 	//���/�Ϲ� ���� ����
			int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//���� SID
			int    v_client_sid  = HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//����ó�ڵ�
			int    v_goods_sid   = HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));	//��ǰ SID
			int    v_roomType    = HDUtil.nullCheckNum(req.getParameter("v_roomType"));		//ROOMTYPE SID
			int    v_room_sid    = HDUtil.nullCheckNum(req.getParameter("v_room_sid"));		//ROOM SID
			int    v_block_sid   = HDUtil.nullCheckNum(req.getParameter("v_block_sid"));	//BLOCK SID
			int    v_event_sid   = HDUtil.nullCheckNum(req.getParameter("v_event_sid"));	//��ü���SID
			int    v_nights      = HDUtil.nullCheckNum(req.getParameter("v_nights"));		//�ڼ�
			int    v_m_rsv_sid   = HDUtil.nullCheckNum(req.getParameter("v_m_rsv_sid"));	//���� SID
			int    v_rsv_sid     = HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));		//���� SID
			
			//ds_cust ���� ���� ���� ����
			String r_manage_no 	= "";										//������ �ֹι�ȣ
			int    r_rsv_sid 	= 0;										//������ ���� ��ȣ
			int    r_cust_sid 	= 0;										//���� �� �Ϸ� ��ȣ
			String r_saup_gu	= "";										//�������
			String r_cust_type	= "";										//��������
			String r_age_cd		= "";										//����
			String r_join_cd	= "";										//�����ڵ�[RV006] ����/�����/...
			String r_mobile_no	= "";										//�޴���ȭ��ȣ
			String r_remark		= "";										//���
				//���λ󼼿� 4�� �߰�.
			String r_carowner_yn= "";										//��������
			String r_jeju_yn	= "";										//���ֿ���
			String r_weekend_yn	= "";										//�ָ�����
			String r_theme_cd	= "";										//�׸�����
			
			
			int    r_key_seq 	= 0;										//�ɼ� ����

			//���� ����
			String v_edit_styatus = "";										//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
			String v_send_id 	= "";
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			//ds_option 
			GauceDataSet ds_cust 			= req.getGauceDataSet("REG_CUST");		//������ ����
			GauceDataSet ds_option 			= req.getGauceDataSet("REG_OPTION");	//�ɼ� ����
			GauceDataSet ds_amt		 		= req.getGauceDataSet("REG_AMT");		//�� ���� ����
			
			GauceDataSet ds_result 			= req.getGauceDataSet("SAVE_RESULT");	//������ ���� ���� ���
			GauceDataSet ds_option_result 	= req.getGauceDataSet("OPTION_RESULT");	//�ɼ� ���� ���� ���
			GauceDataSet ds_amt_result 		= req.getGauceDataSet("AMT_RESULT");	//�ǸŰ� ��� ���
			GauceDataSet ds_room_result 	= req.getGauceDataSet("ROOM_RESULT");	//������ ���� ���
			
			int v_row = 1;
			
			if(ds_cust!=null){
				if(ds_result!=null){
					res.enableFirstRow(ds_result);
					ds_result.addDataColumn(new GauceDataColumn("MANAGE_NO", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("ACCEPT_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("ACCEPT_NO", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("RSV_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("M_RSV_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("ROOM_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				GauceDataRow[] row = ds_cust.getDataRows();

				for(int i=0; i<row.length; i++){
					if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
						v_send_id = "G11";
					} else if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
						v_send_id = "G13";
					} if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
						v_send_id = "G12";
					}

					//���⼭�� �迭 ������ PR_RV200I_23 ���� select �ϴ� ds_cust�� �÷�������. by �ɵ� 2007-05-14
					r_rsv_sid 		= row[i].getInt(0);							//������ ���� ��ȣ
					r_cust_sid 		= row[i].getInt(3);							//���� �� �Ϸ� ��ȣ
					r_manage_no		= row[i].getString(4);						//������ �ֹι�ȣ
					r_saup_gu		= row[i].getString(9);						//�������
					r_cust_type		= row[i].getString(7);						//��������
					r_age_cd		= row[i].getString(6);						//����
					r_join_cd		= row[i].getString(10);						//�����ڵ�[RV006] ����/�����/...
					r_mobile_no		= row[i].getString(13);						//�޴���ȭ��ȣ
					r_remark		= row[i].getString(14);						//���
					//���λ󼼿� 4�� �߰�.
					r_carowner_yn	= row[i].getString(28);						//��������
					r_jeju_yn		= row[i].getString(29);						//���ֿ���
					r_weekend_yn	= row[i].getString(30);						//�ָ�����
					r_theme_cd		= row[i].getString(31);						//�׸�����

					
					if(v_edit_styatus.equals("1")){
						if(r_rsv_sid!=0) v_edit_styatus = "3";
					}
//StringUtil.printMsg("arr_sql[10].toString()", arr_sql[10].toString(), this);	// call SALES.PR_RV200I_01()

				    v_row = 1;
				    cstmt = conn.prepareCall(arr_sql[10].toString());
					cstmt.setInt	(v_row, v_accept_sid);						//��û��SID
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);
					cstmt.setString (v_row, v_accept_no);						//��û��NO
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);
					cstmt.setString (v_row++, v_depart_date);						//�������
					cstmt.setInt	(v_row++, v_goods_sid);						//��ǰSID
		//StringUtil.printMsg("��ǰsid", v_goods_sid, this);
					cstmt.setInt	(v_row++, v_client_sid);						//����óSID
		//StringUtil.printMsg("����ósid", v_client_sid, this);					
					cstmt.setInt	(v_row++, v_event_sid);						//��ü���SID
		//StringUtil.printMsg("�̺�Ʈ sid", v_event_sid, this);					
					cstmt.setString (v_row++, "1");								//�۾�����[RM013] ��������/��Ͻ�û
		//StringUtil.printMsg("�۾�����", "1", this);
					cstmt.setInt	(v_row, r_rsv_sid);							//����SID
		//StringUtil.printMsg("����sid ", r_rsv_sid, this);					
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);	//����SID
					cstmt.setInt	(v_row, v_m_rsv_sid);						//���ο���SID
		//StringUtil.printMsg("���ο���id ", v_m_rsv_sid, this);					
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);	//���ο���SID
					cstmt.setInt	(v_row++, v_roomType);						//����SID
		//StringUtil.printMsg("����Ÿ�� sid", v_roomType, this);					
					cstmt.setInt	(v_row, v_room_sid);						//��SID
		//StringUtil.printMsg("�� sid ", v_room_sid, this);					
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);	//��SID
					cstmt.setInt	(v_row++, v_block_sid);						//���SID
		//StringUtil.printMsg("��� sid ", v_block_sid, this);					
					cstmt.setString (v_row++, v_blockType);						//����Ÿ�� -- ���/�Ϲ�
		//StringUtil.printMsg("����Ÿ�� ", v_blockType, this);					
					cstmt.setString (v_row++, v_depart_time);					//��߽ð�
					cstmt.setInt	(v_row++, v_nights);							//�ڼ�
		//StringUtil.printMsg("�ڼ� ", v_nights, this);					
					cstmt.setString (v_row++, v_arrive_date);					//��������
		//StringUtil.printMsg("�������� ", v_arrive_date, this);					
					cstmt.setString (v_row++, v_arrive_time);					//���ͽð�
					cstmt.setInt	(v_row++, r_cust_sid);						//��SID
					cstmt.setString (v_row++, "1");								//������[CU001] ������/�����       Defaul '1'
					cstmt.setString (v_row++, r_saup_gu);						//�������
					cstmt.setString (v_row++, r_cust_type);						//��������
					cstmt.setString (v_row++, r_age_cd);							//����
					cstmt.setString (v_row++, r_join_cd);						//�����ڵ�[RV006] ����/�����/...
		//StringUtil.printMsg("�������� ", r_join_cd, this);					
					cstmt.setString (v_row++, r_mobile_no);						//�޴���ȭ��ȣ
//StringUtil.printMsg("��ġ��", row[i].getString(ds_cust.indexOfColumn("HOLD_EMPNO")), this);
					cstmt.setString(v_row++, row[i].getString(ds_cust.indexOfColumn("HOLD_EMPNO")));
					cstmt.setString (v_row++, "1");								//�����û���[RV020] CS/WEB/...
		//StringUtil.printMsg("������ ", "1", this);					
					cstmt.setString (v_row++, r_remark);							//���
					cstmt.setString (v_row++, fParamEmpno);							//���������ڻ��
					cstmt.setString (v_row++, fParamIp);							//29 ��������IP
					/*---���λ� �Ķ���� �߰� 2007-0514 by �ɵ���--------------------------------*/
		//StringUtil.printMsg("�������� ", r_carowner_yn, this);
					cstmt.setString (v_row++, r_carowner_yn);						//30 ��������
							
					cstmt.setString (v_row++, r_jeju_yn);							//31 ���ֿ���
		//StringUtil.printMsg("���ֿ��� ", r_jeju_yn, this);
					cstmt.setString (v_row++, r_weekend_yn);						//32 �ָ�����
		//StringUtil.printMsg("�ָ����� ", r_weekend_yn, this);
					cstmt.setString (v_row++, r_theme_cd);							//33 �׸�����[RM018] �ܱ�/����/����
		//StringUtil.printMsg("�׸����� ", r_theme_cd, this);
		 			/*---���λ� �Ķ���� �߰� 2007-0514 by �ɵ���--------------------------------*/
					cstmt.setString (v_row++, v_edit_styatus);						//34 ��������     1: INSERT, 2: DELETE, 3: UPDATE
		//StringUtil.printMsg("��������  ", v_edit_styatus, this);								
					cstmt.setString (v_row++, v_send_id);							//35 ���ν��� ȣ�� ID (41, 42, 43)
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);	//36 ��������
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);	//37 �޼��� �ڵ�
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);	//38 �޼���

					cstmt.executeUpdate();
					
					v_accept_sid = cstmt.getBigDecimal(1).intValue();
					v_accept_no	 = cstmt.getString(2);
					r_rsv_sid	 = cstmt.getBigDecimal(8).intValue();
					v_m_rsv_sid	 = cstmt.getBigDecimal(9).intValue();
					v_room_sid	 = cstmt.getBigDecimal(11).intValue();
					r_s_yn		 = cstmt.getString(36);
					r_msg_cd	 = cstmt.getString(37);
					r_msg		 = cstmt.getString(38);					
					
					if(!r_s_yn.equals("Y"))
						throw new Exception (r_msg);
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(r_manage_no);
						row1.addColumnValue(v_accept_sid);
						row1.addColumnValue(v_accept_no);
						row1.addColumnValue(r_rsv_sid);
						row1.addColumnValue(v_m_rsv_sid);
						row1.addColumnValue(v_room_sid);
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_result.addDataRow(row1);
					}
					if(cstmt!=null) cstmt.close();
				}
				
				if(ds_result!=null) ds_result.flush();
			}
			
			if(ds_option!=null){
				if(ds_option_result!=null){
					res.enableFirstRow(ds_option_result);
					ds_option_result.addDataColumn(new GauceDataColumn("KEY_SEQ", GauceDataColumn.TB_NUMBER));
					ds_option_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_option_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_option_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				GauceDataRow[] row = ds_option.getDataRows();
				
				for(int i=0; i<row.length; i++){
					r_key_seq = row[i].getInt(0);
					
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setInt        (1, v_rsv_sid);
					if(r_key_seq==0)
						cstmt.setInt	    (2, row[i].getInt(0));
					else
						cstmt.setInt	    (2, r_key_seq);
					cstmt.setString     (3, v_depart_date);
					cstmt.setInt		(4, row[i].getInt(1));
					cstmt.registerOutParameter(4, java.sql.Types.DECIMAL);
					cstmt.setString     (5, row[i].getString(2).equals("T") ? "Y" : "N");
					cstmt.setString     (6, row[i].getString(3).equals("T") ? "Y" : "N");
					cstmt.setInt		(7, row[i].getInt(5));
					cstmt.setInt		(8, row[i].getInt(6));
					cstmt.setString		(9, row[i].getString(8));
					
					cstmt.setString     (10, fParamEmpno);
					cstmt.setString     (11, fParamIp);
					cstmt.setString     (12, "3");
					cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);

					cstmt.executeUpdate();
					
					r_key_seq 	= cstmt.getBigDecimal(4).intValue();

					r_s_yn 		= cstmt.getString(13);
					r_msg_cd 	= cstmt.getString(14);
					r_msg 		= cstmt.getString(15);

					if(!r_s_yn.equals("Y"))
						throw new Exception (r_msg);
					
					if(ds_option_result!=null){
						GauceDataRow row1 = ds_option_result.newDataRow();
						row1.addColumnValue(r_key_seq);
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_option_result.addDataRow(row1);
					}

					if(cstmt!=null) cstmt.close();
				}
				
				if(ds_option_result!=null) ds_option_result.flush();
			}

			//�� ���� ����
			if(ds_room_result!=null){
				if(ds_room_result!=null){
					res.enableFirstRow(ds_room_result);
					ds_room_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_room_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_room_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}

				cstmt = conn.prepareCall(arr_sql[12].toString());
				cstmt.setInt        (1, v_m_rsv_sid);
				cstmt.setInt        (2, v_roomType);
				cstmt.setString     (3, fParamEmpno);
				cstmt.setString     (4, fParamIp);
				cstmt.setString     (5, "3");
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
				cstmt.executeUpdate();
					
				r_s_yn 		= cstmt.getString(6);
				r_msg_cd 	= cstmt.getString(7);
				r_msg 		= cstmt.getString(8);
					
				if(!r_s_yn.equals("Y")){
					throw new Exception (r_msg);
				}
				
				if(ds_room_result!=null){
					GauceDataRow row1 = ds_room_result.newDataRow();
					row1.addColumnValue(r_s_yn);
					row1.addColumnValue(r_msg_cd);
					row1.addColumnValue(r_msg);
					
					ds_room_result.addDataRow(row1);
				}
				
				if(ds_room_result!=null) ds_room_result.flush();
			}

			//�ǸŰ� ��� ���� ����
			if(ds_amt!=null){
				if(ds_amt_result!=null){
					res.enableFirstRow(ds_amt_result);
					ds_amt_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_amt_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_amt_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}

				if(v_accept_sid!=0){
					cstmt = conn.prepareCall(arr_sql[13].toString());

					cstmt.setInt        (1,  v_accept_sid);
					cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
					cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);
					cstmt.setString(	4, "RV200I");
					cstmt.setString     (5, fParamEmpno);
					cstmt.setString     (6, fParamIp);
					cstmt.setString     (7, v_edit_styatus);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();
					
					r_s_yn 		= cstmt.getString(8);
					r_msg_cd 	= cstmt.getString(9);
					r_msg 		= cstmt.getString(10);
					
					if(!r_s_yn.equals("Y")){
						res.writeException("ERROR", r_msg_cd, r_msg);
					}
					
					if(ds_amt_result!=null){
						GauceDataRow row1 = ds_amt_result.newDataRow();
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_amt_result.addDataRow(row1);
					}
				}
				
				if(ds_amt_result!=null) ds_amt_result.flush();
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

    /**
     * �����û���� ����ϱ� ���Ͽ� ���Ƿ� ����
     * DataSet flush ȣ����
     * @param rs
     * @param ds
     * @return Vector
     * @throws ServletException
     * @throws Exception
     */
    public Properties getDataSet1(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
		int v_rowcnt = 0;
		Properties pt = new Properties();
		
		ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[] = new String[rsmd.getColumnCount()]; // ��ȸ�ؿ� �÷� ��ŭ �迭�� �����Ѵ� 
    	
    	//StringUtil.printMsg("�����ͼ�  =" , ds.getName() , this);	//�ش� �����ͼ� �̸� Ȯ�� 
    	
		
    	for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
			//StringUtil.printMsg("�÷��̸�-" + i +"==" , columnName[i], this);			//�����ͼ��� �÷� Ȯ��.
			
			if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER")) {
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
			} else {
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			}
		}
		
		// ������ DataSet�� ����� �ִ´�
		while(rs.next()) {
			GauceDataRow row = ds.newDataRow();
			
			for(int i=0; i<columnName.length; i++) {
				if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER")){
					row.addColumnValue(rs.getInt(columnName[i]));
					if(v_rowcnt==0){
						pt.setProperty(columnName[i], rs.getInt(columnName[i])+"");
					}
				} else {
					row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]).trim());
					if(v_rowcnt==0) {
						pt.setProperty(columnName[i], rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]).trim());
					}
				}
			}

			ds.addDataRow(row);
			v_rowcnt++;
		}
//StringUtil.printMsg("getDataSet1 v_rowcnt", v_rowcnt+"", this);

		ds.flush();
		
		if(v_rowcnt>0) 	return pt;
		else return null;
    }
}

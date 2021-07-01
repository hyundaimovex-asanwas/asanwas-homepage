package sales.menu.rv;

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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv331S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {   
		// TODO Auto-generated method stub
		//Master
		arr_sql[0].append ("SELECT 																						 \n")
				  .append ("       T4.GOODS_NM                                   AS GOODS_NM     /* ��ǰ      */         \n")
				  .append ("      ,SUBSTR(T1.ACCEPT_NO, 1,5)||'-'||                                                      \n")
				  .append ("       SUBSTR(T1.ACCEPT_NO, 6,6)||'-'||                                                      \n")
				  .append ("       SUBSTR(T1.ACCEPT_NO,12,3)                     AS VIEW_ACCEPT_NO    /* ��û����ȣ */   \n")
				  .append ("      ,T1.ACCEPT_NO                                  AS ACCEPT_NO    /* ��û����ȣ */        \n")
				  .append ("      ,T3.CUST_NM                                    AS CUST_NM      /* ����       */        \n")
				  .append ("      ,SALES.FN_DETAIL_NM('RV001',T2.STATUS_CD)      AS STATUS_CD     /* �������         */    \n")
				  .append ("      ,SALES.FN_SECURE_RETURN(T3.MANAGE_NO,7)        AS MANAGE_NO    /* ������ȣ(�ֹ�/����)*/\n")
				  .append ("      ,SALES.FN_ROOM_TYPE_CD(T2.ROOM_TYPE_SID)       AS ROOM_TYPE    /* ��������   */        \n")
				  .append ("      ,SALES.FN_DETAIL_NM('RV003',T2.CUST_TYPE)      AS CUST_TYPE    /* �����ڵ�   */        \n")
				  .append ("      ,SALES.FN_TOUR_AMT('3', T2.RSV_SID, $OPTION_YN) 		 AS TOT_TOUR_AMT /* �ǸŰ�     */              \n")
				  .append ("      ,TO_NUMBER(SALES.FN_PAY_AMT('3', T2.RSV_SID, $OPTION_YN) " +
				 		   "		- SALES.FN_FUND_AMT( T2.RSV_SID, $OPTION_YN)" +
						   "		- SALES.FN_REFUND_AMT( T2.RSV_SID, $OPTION_YN) ) AS TOT_PAY_AMT  /* �Աݾ�     */           \n")
				  .append ("	  ,T2.RSV_SID									 AS RSV_SID		 /* ���� SID */			 \n")
				  .append ("	  ,T2.DEPART_DATE								 AS	DEPART_DATE  /* ���ð� */			 \n")
				  .append ("      ,COALESCE(T5.PAY_DATE,'-')               		 AS PAY_DATE      /* �Ա����� */               \n")
				  .append ("      ,COALESCE(T5.PAY_MANAGE_NO,'-')          		 AS PAY_MANAGE_NO /* ������ȣ */               \n")
				  .append ("      ,COALESCE(T5.PAY_CD,'-')                 		 AS PAY_SID1       /* �����ڵ� */              \n")
				  .append ("      ,COALESCE(SALES.FN_DETAIL_NM('AC001',T5.PAY_CD),'-') AS PAY_CD_NM       /* �Աݰ����ڵ�:AC001 */   \n")
				  .append ("      ,COALESCE(T5.PAY_CD,'-')                 		 AS PAY_CD        /* �Աݰ����ڵ�:AC001 */     \n")
				  .append ("      ,COALESCE(T5.PAY_YN,'N')                 		 AS PAY_YN        /* �������� */               \n")
				  .append ("      ,CASE WHEN T5.ACCT_GUBN IN ('1','8') THEN T5.PAY_AMT 												\n")
				  .append ("            ELSE TO_NUMBER(T5.PAY_AMT * -1)  END       AS PAY_AMT       /* �����ݾ� */                  \n")
				  .append ("      ,SALES.FN_DETAIL_NM('AC022',T5.ACCT_GUBN) 	 AS ACCT_GUBN_NM       /* �Աݰ����ڵ�:AC001 */        \n")
				  .append ("	  ,$OPTION_YN									 AS OPTION_YN	 /* OPTION YN */		\n")		  
				  .append ("  FROM SALES.TRV010 T1 JOIN SALES.TRV020 T2 ON (T1.ACCEPT_SID  = T2.ACCEPT_SID)              \n")
				  .append ("       				   JOIN SALES.TCU010 T3 ON (T2.CUST_SID    = T3.CUST_SID)                \n")
				  .append ("					   JOIN SALES.TRM200 T4 ON (T1.GOODS_SID   = T4.GOODS_SID)               \n")
				  .append ("					   LEFT JOIN SALES.TRV200 T5 ON (T2.RSV_SID = T5.RSV_SID AND T5.OPTION_YN = $OPTION_YN )   \n");
		
		
		//�Ⱓ��ȸ
		arr_sql[2].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM DUAL");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int    v_cnt 			= 1;
		int    v_client_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));	//�븮�� SID
		int    v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));		//��ǰ SID
		String v_depart_date1 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date1"));	//�������
		String v_depart_date2 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date2"));	//�������
		String v_accept_no   	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));		//��û����ȣ
		String v_cust_nm	   	= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));		//����
		String v_ipkum_gu	   	= HDUtil.nullCheckStr(greq.getParameter("v_ipkum_gu"));		//�Աݿ���
		String v_pay_gubn	   	= HDUtil.nullCheckStr(greq.getParameter("v_pay_gubn"));		//OPTION ����
		int    v_rsv_sid	   	= HDUtil.nullCheckNum(greq.getParameter("v_rsv_sid"));		//�����ȣ
		
		//StringUtil.printMsg("v_client_sid", v_client_sid+"", this);
		//StringUtil.printMsg("v_goods_sid", v_goods_sid+"", this);
		//StringUtil.printMsg("v_depart_date1", v_depart_date1+"", this);
		//StringUtil.printMsg("v_depart_date2", v_depart_date2+"", this);
		//StringUtil.printMsg("v_accept_no", v_accept_no+"", this);
		//StringUtil.printMsg("v_cust_nm", v_cust_nm+"", this);
		//StringUtil.printMsg("v_ipkum_gu", v_ipkum_gu+"", this);
		//StringUtil.printMsg("v_pay_gubn", v_pay_gubn+"", this);
		//StringUtil.printMsg("v_rsv_sid", v_rsv_sid+"", this);

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		try{
			
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
            	//O:DEFAULT=ds_main
            	if(dSets[i].getName().equals("ds_main")){
					GauceDataSet ds1 = gis.read("DEFAULT");
            
					String temp_sql = arr_sql[2].toString();
					temp_sql = StringUtil.strReplace(temp_sql, "$1", v_depart_date1);
					temp_sql = StringUtil.strReplace(temp_sql, "$2", v_depart_date2);
						
					cstmt = conn.prepareCall(temp_sql);
					rs = cstmt.executeQuery();
					
					if(rs.next()){
						if(rs.getInt("DAY_CNT")>3){
							//res.writeException("ERROR", "0000", "�Ⱓ�� 3���̳��� �Ͻñ� �ٶ��ϴ�.");
							break;
						}
					} else {
						//res.writeException("ERROR", "0000", "�Ⱓ���� ���ڸ� ����ϴ��� ������ �߻��߽��ϴ�.");
						break;
					}

					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();

					if(!v_depart_date1.equals("") || !v_depart_date2.equals(""))
						arr_sql[0].append ("  WHERE T1.DEPART_DATE BETWEEN ? AND ?\n");
					if(v_client_sid!=0)
						arr_sql[0].append ("  AND T1.CLIENT_SID = ? 		\n");
					if(v_goods_sid!=0)
						arr_sql[0].append ("  AND T1.GOODS_SID = ? 			\n");
					if(!v_accept_no.equals(""))
						arr_sql[0].append ("  AND T1.ACCEPT_NO LIKE ? 		\n");
					if(!v_cust_nm.equals(""))
						arr_sql[0].append ("  AND T3.CUST_NM LIKE ? 		\n");
					//�Ա���
					if(v_ipkum_gu.equals("T"))
						arr_sql[0].append ("  AND SALES.FN_TOUR_AMT('3', T2.RSV_SID, $OPTION_YN)=SALES.FN_PAY_AMT('3', T2.RSV_SID, $OPTION_YN)\n");
					//���Ա���
					if(v_ipkum_gu.equals("F"))
						arr_sql[0].append ("  AND SALES.FN_TOUR_AMT('3', T2.RSV_SID, $OPTION_YN)<>SALES.FN_PAY_AMT('3', T2.RSV_SID, $OPTION_YN)\n");
						
					arr_sql[0].append ("    ORDER BY T2.DEPART_TIME					\n")
							  .append ("            ,T4.GOODS_CD                    \n")
							  .append ("            ,T1.ACCEPT_NO                   \n")
							  .append ("            ,T3.CUST_NM                     \n")
							  .append ("            ,T5.PAY_MANAGE_NO               \n");

					cstmt = conn.prepareCall(StringUtil.strReplace(arr_sql[0].toString(), "$OPTION_YN", "'"+v_pay_gubn+"'"));

					if(!v_depart_date1.equals("") || !v_depart_date2.equals("")){
						cstmt.setString(v_cnt++, v_depart_date1);
						cstmt.setString(v_cnt++, v_depart_date2);
					}
					if(v_client_sid!=0)
						cstmt.setInt(v_cnt++, v_client_sid);
					if(v_goods_sid!=0)
						cstmt.setInt(v_cnt++, v_goods_sid);
					if(!v_accept_no.equals(""))
						cstmt.setString(v_cnt++, v_accept_no+"%");
					if(!v_cust_nm.equals(""))
						cstmt.setString(v_cnt++, v_cust_nm+"%");

					//StringUtil.printMsg("��1111�� ", arr_sql[0].toString(),this);

					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
					
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
				}
			}
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

		// TODO Auto-generated method stub
	}

}
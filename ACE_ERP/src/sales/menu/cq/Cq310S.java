package sales.menu.cq;

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

public class Cq310S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * �븮�� ��ȸ
		 */
		arr_sql[1].append("")
					.append("SELECT  																					\n")
					.append("	CASE WHEN T3.COUNTRY_GU = '10' THEN														\n")							
					.append("    	T3.COMPANY_NM 																		\n")
					.append("	ELSE																					\n")
					.append("    	CASE WHEN T3.ENG_COMPANY_NM = null  THEN												\n")
					.append("         	T3.COMPANY_NM 																	\n")
					.append("    	ELSE																				\n")
					.append("         	RTRIM(T3.COMPANY_NM)|| '(' ||RTRIM(T3.ENG_COMPANY_NM)||')'						\n")
					.append("    	END																					\n")
					.append("	END                                                                   AS  COMPANY_NM 	\n")     /* �Ҽ�   */
					.append("	,CASE WHEN T3.COUNTRY_GU = '10' THEN													\n")
					.append(" 	        T3.POSITIONS																	\n")
					.append("	ELSE																					\n")
					.append("	    CASE WHEN T3.ENG_POSITION = null  THEN												\n")
					.append("	         T3.POSITIONS																	\n")
					.append("	    ELSE																				\n")
					.append("	         RTRIM(T3.POSITIONS)|| '(' ||RTRIM(T3.ENG_POSITION)||')'						\n")
					.append("    	END																					\n")
					.append("	END                                                                  AS  POSITIONS  	\n")     /* ��å   */
					.append("	,CASE WHEN T3.COUNTRY_GU = '10' THEN													\n")
					.append("	    T3.CUST_NM																			\n")
					.append("	ELSE																					\n")
					.append("	    CASE WHEN T3.FIRST_NM = null  AND T3.LAST_NM = null THEN								\n")
					.append("	         T3.CUST_NM																		\n")
					.append("	    ELSE																				\n")
					.append("	         RTRIM(T3.CUST_NM)|| '(' ||T3.FIRST_NM||' '||T3.LAST_NM||')'					\n")
					.append("	    END																					\n")
					.append("	END                                                                  AS  CUST_NM   		\n")      /* ����         */
					.append("      ,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)           AS  SEX								\n")             /* ���� :SY009  */
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN										\n")
					.append("            SUBSTR(T3.REGI_NO,1,6)||'-'||													\n")
					.append("            SUBSTR(T3.REGI_NO,7,7)															\n")
					.append("       ELSE																				\n")
					.append("            T3.PASS_NO||'('||																\n")
					.append("            SUBSTR(T3.BIRTHDAY,1,4)||'.'||													\n")
					.append("            SUBSTR(T3.BIRTHDAY,5,2)||'.'||													\n")
					.append("            SUBSTR(T3.BIRTHDAY,7,2)||')'													\n")
					.append("       END                                         AS  REGI_NO								\n")         /* �ֹε�Ϲ�ȣ */
					.append("     ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                     														\n")
					//�ּ� �θ��� �κ� ���� by 20140206 �ɵ���
					.append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					//.append("          RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))				\n")                           
					.append("      ELSE																												\n")
					.append("           T3.ADDRESS1                                    																\n")                               
					.append ("          END                                            AS ADDRESS1                                            \n")    
					.append("     ,T3.CUST_SID, T3.CUST_GU, T3.COUNTRY_GU, T3.COUNTRY_CD								\n")
					.append("      ,RTRIM(SALES.FN_DETAIL_NM('RV017',T2.CLASS))||'/'||T2.TEAMS							\n")
					.append("                                                      AS  CAR_NO							\n")         /* �������      */
					.append("      ,SUBSTR(T3.BIRTHDAY,1,4)||'.'||														\n")
					.append("       SUBSTR(T3.BIRTHDAY,5,2)||'.'||														\n")
					.append("       SUBSTR(T3.BIRTHDAY,7,2)                     AS  BIRTHDAY							\n")       /* �������      */
					.append("      ,RTRIM(SALES.FN_DETAIL_NM('RV017', T2.CLASS))   AS  CLASS							\n")          /* ��            */
					.append("      ,T2.TEAMS                                       AS  TEAMS							\n")          /* ��            */
					.append("      ,T2.TOUR_NO                                     AS  TOUR_NO							\n")        /* ����(��������ȣ) */
					.append("      ,SALES.FN_CUST_GU(T2.RSV_SID, 'SN')           AS  ETC								\n")             /* ���         */
					.append("  FROM SALES.TRV010 T1																		\n")
					.append("      ,SALES.TRV020 T2  													\n")
					.append("      ,SALES.TCU010 T3    												\n")
					.append("      ,SALES.TRM200 T4																		\n")
					.append(" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID														\n")
					.append("   AND T2.CUST_SID    = T3.CUST_SID														\n")
					.append("   AND T1.GOODS_SID   = T4.GOODS_SID														\n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		int v_rowcnt = 0;

		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sSaup_sid 	= HDUtil.nullCheckStr(greq.getParameter("sSaup_sid"));	// �����
		String sDepart_date = HDUtil.nullCheckStr(greq.getParameter("sDepart_date")); 	// �������
		String sDepart_time = HDUtil.nullCheckStr(greq.getParameter("sDepart_time")); 	// ���ð� 
		String sGoods_sid 	= HDUtil.nullCheckStr(greq.getParameter("sGoods_sid"));			// ��ǰSID 
		String sClass		= HDUtil.nullCheckStr(greq.getParameter("sClass")); //��
		String sTeam		= HDUtil.nullCheckStr(greq.getParameter("sTeam"));  //��
		String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel")); //�ź�
		String sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm")); //�ź�
		
		//StringUtil.printMsg("�����====",sSaup_sid,this);
		//StringUtil.printMsg("�������==",sDepart_date,this);
		//StringUtil.printMsg("���ð�==",sDepart_time,this);
		//StringUtil.printMsg("��ǰSID==",sGoods_sid+"",this);
		//StringUtil.printMsg("��=======",sClass+"",this);
		//StringUtil.printMsg("��=======",sTeam+"",this);
		//StringUtil.printMsg("�ź�======",sJobsel+"",this);
		
		try {
			int sCnt1 = 1;
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					
						if (!"".equals(sSaup_sid)) { 
							arr_sql[1].append("   AND T1.SAUP_SID    = ?																	\n");	/* ����� 										*/
						}
						if (!"".equals(sDepart_date)) {
							arr_sql[1].append("   AND T2.DEPART_DATE = ?																	\n");	/* ������� 										*/
						}
						if (!"".equals(sDepart_time)) { 
							arr_sql[1].append("   AND T2.DEPART_TIME = ?																	\n");	/* ���ð� 										*/ 
						}
						
						if (!"0".equals(sGoods_sid)) {
							arr_sql[1].append("   AND T1.GOODS_SID   = ?															\n");	/* ��ǰSID  										*/
						}
						if (!"".equals(sClass)) {
							arr_sql[1].append("   AND T2.CLASS   = ?																	\n");	/* ��ǰSID  										*/
						}
						if (!"".equals(sTeam)) {
							arr_sql[1].append("   AND T2.TEAMS   = ?																	\n");	/* ��ǰSID  										*/
						}
						if (!"".equals(sCustNm)) {
							arr_sql[1].append("   AND T3.CUST_NM = ?			\n");	/* ����	*/
						}
						if (!"".equals(sJobsel)) {
							arr_sql[1].append("AND ( ("+sJobsel+"=''							)	\n")
									.append("OR ("+sJobsel+"='1' AND T2.CUST_GU='1'               )	\n")
									.append("OR ("+sJobsel+"='2' AND T2.CUST_GU='2' AND T2.SAUP_GU NOT IN ('50','55') )	\n")
									.append("OR ("+sJobsel+"='3' AND T2.CUST_GU='2' AND T2.SAUP_GU IN ('50','55') ) ) 	\n");  										
						}
						
						arr_sql[1].append("   AND T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR')														\n")	/* �����ڷ����(RR:����/RC:���/NS/DP:���/AR:�԰�) */
							.append("ORDER BY T2.CLASS																						\n")
							.append("        ,T2.TEAMS																						\n")
							.append("        ,T2.TOUR_NO																					\n")
							.append("        ,T2.RSV_SID																					\n");  
		
				  		// ���� ����
				  		 
						
						cstmt = conn.prepareCall(arr_sql[1].toString()); 
				  		//StringUtil.printMsg("����",arr_sql[1].toString(),this);
				  		// ����
				  		if (!"".equals(sSaup_sid)) {
					  		cstmt.setInt(sCnt1++, Integer.parseInt(sSaup_sid));		// �����
					  		 
						}
						if (!"".equals(sDepart_date)) { 
							cstmt.setString(sCnt1++, sDepart_date );			// ������� 
						}
						if (!"".equals(sDepart_time)) { 
					  		 cstmt.setString(sCnt1++, sDepart_time);				// ���ð� 
						}
						if (!"0".equals(sGoods_sid)) {
					  		 cstmt.setInt(sCnt1++, Integer.parseInt(sGoods_sid));				// ��ǰSID 
						}
						if (!"".equals(sClass)) { 
					  		 cstmt.setString(sCnt1++, sClass);				// ���ð� 
						}
						if (!"".equals(sTeam)) { 
					  		 cstmt.setString(sCnt1++, sTeam);
						}
						if (!"".equals(sCustNm)) {
							cstmt.setString(sCnt1++, sCustNm);
						}
				
						rs = cstmt.executeQuery(); 
						gos.write(getDataSet(rs, ds1));// DataSet set
//						if (!"".equals(sJobsel)) { 
//					  		 stmt.setString(sCnt1++, sJobsel);
//						}
						
					}
					//StringUtil.printMsg("�����====",sSaup_sid,this);
					//StringUtil.printMsg("�������==",sDepart_date,this);
					//StringUtil.printMsg("���ð�==",sDepart_time,this);
					//StringUtil.printMsg("��ǰSID==",sGoods_sid+"",this);
					//StringUtil.printMsg("��=======",sClass+"",this);
					//StringUtil.printMsg("��=======",sTeam+"",this);
					//StringUtil.printMsg("�ź�======",sJobsel+"",this);
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
	}
}
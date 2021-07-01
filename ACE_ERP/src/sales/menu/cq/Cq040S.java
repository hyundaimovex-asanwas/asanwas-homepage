package sales.menu.cq;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
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

public class Cq040S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		// ��ȸ 
		arr_sql[0].append("SELECT 		\n")
					.append("       SALES.FN_DETAIL_NM ( 'RM014',T2.DEPART_TIME)  AS  DEPART_TIME		\n")   /* ���ð�  */
					.append("	 ,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)  AS SEX 									\n")                       /* ���� :SY009  */
					.append("      ,M1.SNP_YN AS  CHOICE		\n")      /* ����     */
					.append("      ,T4.GOODS_NM                                   AS  GOODS_NM		\n")      /* ��ǰ      */
					.append("      ,SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS)        AS  CLASS		\n")         /* ��        */
					.append("      ,SUBSTR(T2.TEAMS,1,2)                          AS  TEAMS		\n")         /* ��        */
					.append(" 	 ,RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD))|| ' / ' || SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD)  AS COUNTRY_NM      	\n")
					.append("      ,T2.RSV_SID                                    	AS  RSV_SID		\n")       /* RSV_SID      */
					.append("      ,T2.TOUR_NO                                    AS  TOUR_NO		\n")       /* ����      */
					.append("      ,T3.CUST_NM                                    AS  CUST_NM		\n")       /* ����      */
					.append("      ,T3.BIRTHDAY                                   AS  BIRTHDAY		\n")      /* �������  */
					.append("      ,T3.COMPANY_NM || ' ' ||T3.POSITIONS           AS  COMPANY_NM		\n")    /* ����/���� */
					.append("      ,T3.ADDRESS1                                   AS ADDRESS1        \n")
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN											\n")
					.append("            ''																					\n")
					.append("       ELSE																					\n")
					.append("            SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD) || ' ' ||								\n") 
					.append("            SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD )										\n")
					.append("       END                                            AS  COUNTRY_CD							\n")  /* ����/����    */
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN											\n")
					.append("            ''																					\n")
					.append("       ELSE																					\n")
					.append("            T3.PASS_NO																			\n")
					.append("       END                                            AS  PASS_NO								\n")      /* ���ǹ�ȣ    */
					.append("      ,T4.GOODS_NM                               || '-' ||										\n")    
					.append("       SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS) || '-' ||										\n")     
					.append("       SUBSTR(T2.TEAMS,1,2)                      || '-' ||										\n")     
					.append("       T2.TOUR_NO		as tour_no2																		\n") /* ������ȣ   */
					.append("      ,CASE WHEN T2.STATUS_CD IN ('RC','NS') THEN                                             	\n")
					.append("  		    	  '���'                                                                        \n")
					.append("		     END AS STATUS_CD 																	\n")
				  
					.append("  FROM SALES.TRV010 T1																			\n")    
					.append("      ,SALES.TRV020 T2																			\n")    
					.append("      ,SALES.TCU010 T3 																		\n")
					//.append("      ,SALES.TCU010 T3 LEFT OUTER JOIN  SALES.TSY110 T5 ON  T3.ZIP_SID    = T5.ZIP_SID			\n")    
					.append("      ,SALES.TRM200 T4																			\n")    
					.append("      ,SALES.TCM040 M1																			\n")
					.append(" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID															\n")    
					.append("   AND T2.CUST_SID    = T3.CUST_SID															\n")    
					.append("   AND T1.GOODS_SID   = T4.GOODS_SID															\n")    
					.append("   AND T2.RSV_SID    = M1.RSV_SID															\n")
					.append("   AND T2.SAUP_GU     <> '65'																								\n");
		
		//	���
		arr_sql[1].append (" SELECT																										    		\n")
					  .append ("	t3.cust_nm AS cust_nm,                     																			\n")
					  .append ("	t2.north_purpose AS north_purpose,                     																			\n")
					  .append ("	SUBSTR(t3.birthday,3,2)||'-'||SUBSTR(t3.birthday,5,2)||'-'||SUBSTR(t3.birthday,7,2) AS birthday, 					\n")
					  .append ("    SUBSTR(T3.MANAGE_NO,1,1)||'/'||T3.MANAGE_NO            AS PIC_ADDR,												\n")	  /* [����FILE��] */					  
					  .append ("    sales.fn_detail_nm('SY009',t3.sex) AS sex, 																			\n")
					  .append ("    t3.company_nm||'/'||t3.positions AS company_nm, 																	\n")
					  .append ("         CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                                          				\n")
					  .append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					  //.append ("           RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))	\n")
					  .append ("          ELSE                                                                                                  		\n")
					  .append ("               T3.ADDRESS1                                                                                      		\n")
					  .append ("          END                                            AS ADDRESS1,                                            		\n")
					  .append ("    	SUBSTR(t2.depart_date,1,4)||'.'||         																		\n")
					  .append ("    	SUBSTR(t2.depart_date,5,2)||'.'||         																		\n")
					  .append ("    	SUBSTR(t2.depart_date,7,2)||' - '||      																		\n")
					  .append ("    	SUBSTR(t2.arrive_date,1,4)||'.'||         																		\n")
					  .append ("    	SUBSTR(t2.arrive_date,5,2)||'.'||         																		\n")
					  .append ("    	SUBSTR(t2.arrive_date,7,2)||''   																				\n")
					  .append ("         												AS fr_to_date1,  												\n")
					  .append(" RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD)) AS COUNTRY_NM      	\n")
					  .append(",RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))    AS NATION_NM                         									\n")
					  .append(",SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)           AS SEX_NM                            									\n")
					  .append (", t6.upjang_nm AS upjang_eng_nm             																			\n")
					  .append(",T3.SEX                                         AS SEX_ENM                           									\n")
			
					  .append(",(SELECT RTRIM(ITEM15)                                                                        							\n")
					  .append("  FROM SALES.TSY010 T9                                                                 									\n")
					  .append(" WHERE HEAD = 'SY005'                                                                 	 								\n")
					  .append("   AND DETAIL  =  T3.COUNTRY_CD                                                       	 								\n")
					  .append("   AND DETAIL  >  ' ')                                                                 									\n")
					  .append("|| ' / ' ||                                                                                                              \n")
					  .append("(SELECT RTRIM(ITEM15)                                                                        							\n")	    
					  .append("FROM SALES.TSY010 T9                                                                 								    \n")
					  .append("WHERE HEAD = 'SY005'                                                                 	 							    \n")
					  .append("AND DETAIL  =  T3.NATION_CD                                                       	 							        \n")
					  .append("AND DETAIL  >  ' ')                       AS COUNTRY_EFNM                                                                \n")
					  .append(",(SELECT ITEM2                                                                         									\n")
					  .append("  FROM SALES.TSY010 T9                                                                 									\n")
					  .append(" WHERE HEAD = 'RV017'                                                                  									\n")
					  .append("   AND DETAIL  =  T2.CLASS                                                             									\n")
					  .append("   AND DETAIL  >  ' ')                        AS CLASS_ENM		    													\n")
					                                                                                                                                    
					  .append(",CASE WHEN T2.CUST_GU ='1' THEN             																			    \n")
					  .append("T4.ENG_NM ||'-'|| (SELECT RTRIM(ITEM2) FROM SALES.TSY010 WHERE HEAD='RV017' AND DETAIL=T2.CLASS AND DETAIL>' ')          \n")
					  .append("||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no))                                                           \n")
					  .append("WHEN T2.CUST_GU = '2' AND T2.TEAMS = '88' THEN '' 											                            \n")
					  .append("ELSE t3.work_no END AS WORK_ENO                                                                                          \n")
					  .append(", RTRIM(T3.ENG_COMPANY_NM) || '/' ||RTRIM(T3.ENG_POSITION) AS COMPANY_ENM												\n")
					  .append(", RTRIM(T3.ENG_ADDR1) || ' ' ||RTRIM(T3.ENG_ADDR2) AS ADDRESS1ENM         												\n")
					  .append(", T2.REMARKS                                       AS REMARKS         													\n")
					  .append(",CASE WHEN (T1.SAUP_SID=1 AND T2.CUST_TYPE IN ('020','021','022','161') ) THEN 'AD'										\n")
					  .append("      WHEN (T2.CUST_GU='1' AND T2.GOODS_SID=51 AND T2.UPJANG_SID=73) THEN 'A'   											\n")
					  .append("      WHEN (T2.CUST_GU='1' AND T2.GOODS_SID=51 AND T2.UPJANG_SID<>73) THEN 'G'   										\n")
					  .append("	 	 ELSE T2.OLD_ROOM_NO END 					  AS SECRET_MARK					  									\n")
					  .append(", T9.GROUP_NM                                      AS GROUP_NM         													\n")
					  .append(", CASE T2.GOODS_SID WHEN 50 THEN 'http://erp.hdasan.com/services/Sales/images/naekum.jpg' 								\n")
					  .append("                    WHEN 54 THEN 'http://erp.hdasan.com/services/Sales/images/ks_pm.jpg'   ELSE '' END AS TAG_NK,  		\n")
					  //.append("                    WHEN 51 THEN 'http://erp.hdasan.com/services/Sales/images/mark_golf.jpg'  ELSE '' END AS TAG_NK,     \n")					  

					  .append ("    CASE WHEN (T2.CUST_GU ='2' OR (T2.CUST_GU ='1' AND T2.GOODS_SID IN (35,54)) ) THEN             						\n")
					  .append ("         '' 																											\n")
					  .append ("         ELSE '�� ��湮 ������ 10% ���������� �帳�ϴ�.' END AS COMMENT1,        												\n")
					  .append ("    CASE WHEN (T2.CUST_GU ='2' OR (T2.CUST_GU ='1' AND T2.GOODS_SID IN (35,54)) ) THEN             						\n")
					  .append ("         ''																												\n")
					  .append ("         ELSE '(���� 1��  ����, �ߺ����� �Ұ�)' END AS COMMENT2        													\n")
					  
					  .append("    FROM sales.trv010 t1  	LEFT OUTER JOIN sales.tcu020 t9 ON (t1.event_sid=t9.group_sid), 								\n")
					  .append(" 		sales.trv020 t2  	LEFT OUTER JOIN sales.trm040 t7 ON (t2.room_sid=t7.room_sid) 									\n")
					  .append(" 						 	LEFT OUTER JOIN sales.trm020 t8 ON (t7.dong_sid=t8.dong_sid), 								\n")
					  .append("         sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5 ON (t3.zip_sid=t5.zip_sid), 										\n")
					  .append("         sales.trm200 t4, sales.trm010 t6 ,     																			\n")
					  .append("         sales.tcm040 m1      																			\n")
					  .append("    WHERE t1.accept_sid=t2.accept_sid          																			\n")
					  .append("    	AND t2.cust_sid=t3.cust_sid                																		\n")
					  .append("    	AND t1.goods_sid=t4.goods_sid              																		\n")
					  .append("    	AND t2.upjang_sid=t6.upjang_sid            																		\n")
					  .append("    	AND t2.rsv_sid=m1.rsv_sid            																		\n")
					  .append("   	AND T2.SAUP_GU     <> '65'																							\n");



	//���� _����ο�_tcm040�� snp_yn=>Y
		arr_sql[2].append("{call SALES.PR_CQ040S_02 (?,?,?,?,?,   ?,?,? ) }");			
	//	���� _������ο�_tcm040�� snp_yn=>N
		  arr_sql[3].append("{call SALES.PR_CQ040S_03 (?,?,?,?,?,   ?,?) }");			
	  }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataBase */
	}	
	
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//System.out.println("# Command : ��ȸ");

		/* DataBase */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		try {
			// �˻��� ����
			int     sSaupSid = HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
			String  sCountryGu = HDUtil.nullCheckStr(greq.getParameter("sCountryGu"));
			String  sDepartDate = HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
			String  sDepartTime = HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			int 	sGoodsSid = HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));
			String  sClass = HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String  sTeams = HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			String  sManageNo = HDUtil.nullCheckStr(greq.getParameter("sManageNo"));
			String  sStatusCd = HDUtil.nullCheckStr(greq.getParameter("sStatusCd"));


//			StringUtil.printMsg("sStatusCd ::", sStatusCd+"::", this);
			//System.out.println(sSaupSid+":"+sCountryGu+":"+sDepartDate+":"+sDepartTime+":"+sGoodsSid+":"+sClass+":"+sTeams+":"+sManageNo);
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
	        GauceDataSet[] dSets = gis.readAllOutput(); 
	        
	        for(int j=0; j<dSets.length;j++){
				if(dSets[j].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							//res.enableFirstRow(ds1);
							
							if (0!=sSaupSid) {
								arr_sql[0].append("   AND T1.SAUP_SID    = ?		\n");               /* ����� */
							}
							if (!"".equals(sCountryGu)) {
								arr_sql[0].append("   AND T3.COUNTRY_GU  = ?		\n");             /* ��������      */
							}
							if (!"".equals(sDepartDate)) {
								arr_sql[0].append("   AND T2.DEPART_DATE = ?		\n");            /* ������� */
							}
							if (!"".equals(sDepartTime)) {
								arr_sql[0].append("   AND T2.DEPART_TIME = ?		\n");            /* ���ð� */
							}
							if (0!=sGoodsSid) {
								arr_sql[0].append("   AND T1.GOODS_SID   = ?		\n");              /* ��ǰSID  */
							}
							if (!"".equals(sClass)) {
								arr_sql[0].append("   AND T2.CLASS       = ?		\n");                  /* �� �ڵ� */
							}
							if (!"".equals(sTeams)) {
								arr_sql[0].append("   AND T2.TEAMS       = ?		\n");                  /* ��      */
							}
							if (!"".equals(sManageNo)) {
								arr_sql[0].append("   AND T3.MANAGE_NO   = ?		\n");              /* �ֹ�/���ǹ�ȣ */
							}
							if ("true".equals(sStatusCd)) {
								arr_sql[0].append("   AND M1.SNP_YN	=  'T'	\n");
							}
							
							arr_sql[0].append("ORDER BY T2.DEPART_TIME		\n")    
							.append("        ,T4.GOODS_CD		\n")    
							.append("        ,T2.CLASS		\n")    
							.append("        ,T2.TEAMS		\n")      
							.append("        ,T2.TOUR_NO		\n")    
							.append("        ,T2.RSV_SID 		\n");
							
							//StringUtil.printMsg("��ȸ����",arr_sql[0].toString(),this);
							cstmt = conn.prepareCall(arr_sql[0].toString());

							if (0 != sSaupSid) 
								cstmt.setInt(sCnt1++, sSaupSid);
							if (!"".equals(sCountryGu))
								cstmt.setString(sCnt1++, sCountryGu);
							if (!"".equals(sDepartDate))
								cstmt.setString(sCnt1++, sDepartDate);
							if (!"".equals(sDepartTime))
								cstmt.setString(sCnt1++, sDepartTime);							
							if (0 != sGoodsSid) 
								cstmt.setInt(sCnt1++, sGoodsSid);
							if (!"".equals(sClass))
								cstmt.setString(sCnt1++, sClass);
							if (!"".equals(sTeams))
								cstmt.setString(sCnt1++, sTeams);
							if (!"".equals(sManageNo))
								cstmt.setString(sCnt1++, sManageNo);							
							
							rs = cstmt.executeQuery(); // DataSet set
							gos.write(getDataSet(rs, ds1));
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
							}
		
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();								
								for(int i=0; i<columnName.length; i++) {
//									System.out.println("ColumnType:"+i+rsmd.getColumnTypeName(i+1));
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}		
								ds1.addDataRow(row);
							}//End of while
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
							
						break;
						case 2:
					break;
					}
				}
				if(dSets[j].getName().equals("ds9")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					//StringUtil.printMsg("��ȸ���� ds9","���",this);
					switch(dsType){
						case 1:
						break;
						case 2:
						int sCnt2 = 1;
						//res.enableFirstRow(ds1);
						//StringUtil.printMsg("case 2: ","case 2:",this);
						if (0 !=sSaupSid)
							arr_sql[1].append (" AND t1.saup_sid = ? \n");
						if (!"".equals(sCountryGu))
							arr_sql[1].append (" AND t3.country_gu = ? \n");
						if (!"".equals(sDepartDate))
							arr_sql[1].append (" AND t2.depart_date = ? \n");
						if (!"".equals(sDepartTime))
							arr_sql[1].append (" AND t2.depart_time = ? \n");							
						if (0!=sGoodsSid)
							arr_sql[1].append (" AND t1.goods_sid = ? \n");
						if (!"".equals(sClass))
							arr_sql[1].append (" AND t2.class = ? \n");
						if (!"".equals(sTeams))
							arr_sql[1].append (" AND t2.teams = ? \n");
						if (!"".equals(sManageNo))
							arr_sql[1].append (" AND t3.manage_no = ? \n");
						if ("true".equals(sStatusCd)) {
							arr_sql[1].append (" AND m1.snp_yn  = 'T'	\n");
						}

						arr_sql[1].append (" ORDER BY t2.depart_time,t4.goods_cd,t2.class,t2.teams,t2.tour_no,t2.rsv_sid \n");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						//StringUtil.printMsg("��ȸ���� arr_sql[1].toString()",arr_sql[1].toString(),this);
						if (0 != sSaupSid) 
							cstmt.setInt(sCnt2++, sSaupSid);
						if (!"".equals(sCountryGu))
							cstmt.setString(sCnt2++, sCountryGu);
						if (!"".equals(sDepartDate))
							cstmt.setString(sCnt2++, sDepartDate);
						if (!"".equals(sDepartTime))
							cstmt.setString(sCnt2++, sDepartTime);							
						if (0 != sGoodsSid) 
							cstmt.setInt(sCnt2++, sGoodsSid);
						if (!"".equals(sClass))
							cstmt.setString(sCnt2++, sClass);
						if (!"".equals(sTeams))
							cstmt.setString(sCnt2++, sTeams);
						if (!"".equals(sManageNo))
							cstmt.setString(sCnt2++, sManageNo);							

						rs = cstmt.executeQuery(); // DataSet set
						
						rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];
							
						//������ ������ �����  �ҷ��� �����ͼ¿� �ֿ� �߰��ϰ�..
						for(int i=0; i<columnName.length; i++){
							columnName[i] = rsmd.getColumnName(i+1);
							if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
							else
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
						}
						//���������� ���������� �����ͼ¿� �߰��ϰ�.
						ds1.addDataColumn(new GauceDataColumn("picture_info",GauceDataColumn.TB_STRING));
						ds1.addDataColumn(new GauceDataColumn("picture_url",GauceDataColumn.TB_URL,1024));						
							
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();								
							for(int i=0; i<columnName.length; i++) {
//								System.out.println("ColumnType:"+i+rsmd.getColumnTypeName(i+1));
//								System.out.println("ColumnName:"+i+rsmd.getColumnName(i+1)+"��");									
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
										
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}		
							//StringUtil.printMsg("�������",HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG",this);
								
							//row.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG");
							//row.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG");
							row.addColumnValue(HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG");
							row.addColumnValue(HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG");
							ds1.addDataRow(row);
						}//End of while
						gos.write(getDataSet(rs, ds1));
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
							
					break;
					}
				}
			}
		} catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		//StringUtil.printMsg("���� - ", "����", this);
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        GauceDataSet ds_result = gis.read("RESULT");
        GauceDataSet ds1 = gis.read("DS1");
		
		try {
			//�޽���ó��
			if(ds_result!=null){
				//res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

				if(ds1!=null){
						GauceDataRow[] 		rows = ds1.getDataRows();
						
						for(int i=0; i<rows.length; i++){
							int colNm_RsvSid			= ds1.indexOfColumn("RSV_SID");
							int colNm_SnpYN			= ds1.indexOfColumn("CHOICE");
							
							//StringUtil.printMsg("���� - ", "����", this);
							//StringUtil.printMsg("colNm_RsvSid - ", rows[i].getInt(colNm_RsvSid), this);
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								cstmt = conn.prepareCall(arr_sql[2].toString());
														
								cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
								cstmt.setString(2, rows[i].getString(colNm_SnpYN));
								cstmt.setString(3, fParamEmpno);
								cstmt.setString(4, fParamIp);
								cstmt.setString(5, "3");
								cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);								
								
								cstmt.executeUpdate();
								//if(cstmt!=null) cstmt.close();
								
								String r_s_yn		= cstmt.getString(6);
								String r_msg_cd	 	= cstmt.getString(7);
								String r_msg		= cstmt.getString(8);
								
								if(!r_s_yn.equals("Y"))
									throw new Exception(r_msg);
								
								if(ds_result!=null){
									ds_result.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
									ds_result.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
									ds_result.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
									ds_result.heap();	
								}
							}
							if(ds_result!=null) gos.write(ds_result);
						}
					}			
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
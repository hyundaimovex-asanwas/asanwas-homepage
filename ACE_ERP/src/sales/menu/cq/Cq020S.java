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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.HDConstant;

 
public class Cq020S extends SuperServlet { 

	private static final long serialVersionUID = 1L;
	
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		arr_sql[0].append ("")
		  			.append("SELECT 																												\n") 
					.append("       T2.TOUR_NO                                  AS TOUR_NO               											\n")
					.append("      ,T2.PAGE_NO                                    AS PAGE_NO															\n")        /* PAGE 번호 */
					.append("     ,SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS)      AS CLASS																\n")
					.append("     ,SUBSTR(T2.TEAMS,1,2)                        AS TEAMS																\n")
					.append("     ,T2.CUST_SID                                 AS CUST_SID															\n")
					.append("     ,T3.CUST_NM                                  AS CUST_NM															\n")
					.append("     ,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)        AS SEX       														\n")
					.append("     ,T3.BIRTHDAY                                 AS BIRTHDAY 			 												\n")
					.append("     ,RTRIM(T3.COMPANY_NM)|| ' ' ||T3.POSITIONS   AS COMP_NM															\n")
					.append("     ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                     														\n")
					//주소 부르는 부분 수정 by 20140206 심동현
					.append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					//.append("          RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))				\n")                           
					.append("      ELSE																												\n")
					.append("           T3.ADDRESS1                                    																\n")                               
					.append("      END                                         AS ADDRESS1    														\n")                     
					.append("     ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN																			\n")
					.append("           ''																											\n")
					.append("      ELSE																												\n")
					.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD)) || ' / ' || 												\n")
					.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))															\n")
					.append("      END                                          AS COUNTRY_CD														\n")
					.append("     ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                        													\n")
					.append("            ''                                             															\n")
					.append("      ELSE																												\n")
					.append("            SALES.FN_DETAIL_NM ( 'CU008',T3.PASS_TYPE) END  AS PASS_NO													\n")
					.append("     ,T4.GOODS_NM                            || '-' ||               													\n")
					.append("      SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS) || '-' || 																\n")
					.append("      SUBSTR(T2.TEAMS,1,2)                   || '-' || 																\n")
					.append("      T2.TOUR_NO                                   AS  TOUR_CODE														\n")
					.append("      ,T1.ACCEPT_NO                                 AS  ACCEPT_NO														\n")
					.append("      ,SALES.FN_CLIENT_NM(T1.CLIENT_SID,'')         AS  CLIENT_NM														\n")
					.append("      ,T2.STATUS_CD 								AS STATUS_CD														\n")
					.append ("     ,SUBSTR(T3.MANAGE_NO,1,1)||'/'||T3.MANAGE_NO            AS PIC_ADDR			\n")					
					.append("  FROM SALES.TRV010 T1																									\n")
					.append("      ,SALES.TRV020 T2																									\n")
					.append("      ,SALES.TCU010 T3 LEFT OUTER JOIN  SALES.TSY110 T5 ON  T3.ZIP_SID    = T5.ZIP_SID									\n")
					.append("      ,SALES.TRM200 T4																									\n")
					.append(" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID																					\n")
					.append("   AND T2.CUST_SID    = T3.CUST_SID																					\n")
					.append("   AND T1.GOODS_SID   = T4.GOODS_SID																					\n")
					.append("   AND ((T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR')) 																	\n")  /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */
					.append("	 OR (T2.STATUS_CD IN ('RC', 'NS') AND T2.TOUR_NO <> '')) \n")
					
					.append("   AND T2.SAUP_GU     <> '65'																							\n");
					

		arr_sql[1].append ("")
					.append("  SELECT																														\n")
					.append("  t2.depart_date||t2.class||t4.goods_cd||LPAD(t2.page_no,3,'0') AS page_skip										\n")      /* PAGE를 넘기는 변수 */
				    .append("  ,CASE WHEN T1.SAUP_SID = 1 THEN '금강산 관광객 명단          '				\n")
				    .append("        WHEN T1.SAUP_SID = 2 THEN '개성 관광객 명단'				\n")
				    .append("        END  AS DOC_TITLE    /* 문서 제목 (2007.08.10 심동현 추가)  */         			\n")
					.append("  ,t2.page_no AS page_no																								\n")        /* PAGE 번호 */
					.append("  ,t3.manage_no AS manage_no																							\n")      /* 관리번호(주민/여권)*/
					.append("  ,SUBSTR(T3.MANAGE_NO,1,1)||'/'||T3.MANAGE_NO            AS PIC_ADDR												\n")	  /* [사진FILE명] */
					.append("  ,t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2) ||								\n")  
					.append("  '                    ( Page : '||TO_CHAR(t2.page_no)||' )' AS team_nm1												\n")      /* 관광단체명        */
					.append("  ,'( Page : '||TO_CHAR(t2.page_no)||' )'|| t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||					\n")  
					.append("  '-'||SUBSTR(t2.teams,1,2) AS skip																					\n")  
					.append("  ,t2.depart_date AS depart_date																						\n")      /* 관광기간:시작일자 */
					.append("  ,t2.arrive_date AS arrive_date																						\n")      /* 관광기간:종료일자 */
					.append("  ,CASE WHEN t4.nights = 0               THEN '('||RTRIM(TO_CHAR(t4.days))||'일)'											\n")  
					.append("  ELSE '('||RTRIM(TO_CHAR(t4.nights))||'박'||RTRIM(TO_CHAR(t4.days))||'일)' END AS nights_days								\n")    /*  박수/일수       */
					.append("  ,t4.nights AS nights																									\n")   /* 박수            */
					.append("  ,t4.days AS days																										\n")   /* 일수            */
					.append("  ,t2.STATUS_CD AS STATUS_CD																							\n")   /* 예약상태            */
					
					.append("  ,CASE WHEN t3.country_gu IN('10') THEN t3.cust_nm ELSE '' END AS cust_nm1											\n")   /* 성명1        */
					.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE t3.cust_nm END AS cust_nm2												\n")    /* 성명2        */
					.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE t3.first_nm||' '||t3.last_nm END AS cust_enm 	\n")   /* 영문성명     */
					.append("  ,t3.birthday birthday																										\n")             /* 생년월일     */
					.append("  ,CASE WHEN t3.country_gu IN('10')THEN t3.company_nm||' '||t3.positions ELSE '' END AS comp_nm1	 \n")    /* 직장/직위1   */
					.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE t3.company_nm||' '||t3.positions END AS comp_nm2	 \n")   /* 직장/직위2   */
					.append("  ,CASE WHEN t3.country_gu IN('10')      THEN '' ELSE t3.eng_company_nm||' '||t3.eng_position END AS comp_enm		\n")    /* 영문직장/직위*/
					.append("  ,CASE WHEN T3.COUNTRY_GU='10' THEN																					\n")
					//주소 부르는 부분 수정 by 20140206 심동현
					.append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					//.append("       RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))					\n")   
					//.append("             SUBSTRING(T5.ADDRESS1 ||' '||T5.ADDRESS2,1, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' '))					\n")   
					//.append("           ||SUBSTRING(T5.ADDRESS1 ||' '||T5.ADDRESS2, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1 ,						\n")   
					//.append("           LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ', LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1  ))  		\n")        
					.append("       ELSE																												\n")   
					.append("            T3.ADDRESS1																									\n")   
					.append("       END                                            AS ADDRESS1															\n")    /* 사는 곳       */
					.append("      ,CASE WHEN T3.COUNTRY_GU ='10' THEN																				\n")   
					.append("            ''																														\n")   
					.append("       ELSE																														\n")   
					.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD)) || ' / ' || 				\n")
					.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))									\n")
					.append("       END                                            AS COUNTRY_CD 												\n")   /* 국적/민족    */
					.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE sales.fn_detail_nm('CU008',t3.pass_type) END AS pass_type		\n")   /* 여권종류:CU008  */
					.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE t3.pass_no END AS pass_no														\n")    /* 여권번호    */
					.append("  ,t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2)||'-'||t2.tour_no AS tour_no	\n")   /* 관광번호   */
					.append("  FROM sales.trv010 t1, sales.trv020 t2, sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5		\n")  
					.append("  ON t3.zip_sid=t5.zip_sid, sales.trm200 t4																				\n")  
					.append("  WHERE t1.accept_sid=t2.accept_sid																					\n")  
					.append("  AND t2.cust_sid=t3.cust_sid																								\n")  
					.append("  AND t1.goods_sid=t4.goods_sid																							\n")  
					.append("   AND ((T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR'))  																				\n")    /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */
					.append("    OR (T2.STATUS_CD IN('RC', 'NS') AND T2.TOUR_NO <> '')) 																	\n")
					.append("   AND T2.SAUP_GU     <> '65'																								\n");  
					
										   
							
    }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			// 검색시 조건
			int 	sGoodsSid 		= HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));
			String  sDepartDate 	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
			int 	sSaupSid 		= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
			String  sDepartTime 	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			String  sClass 			= HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String  sTeams 			= HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			int 	sPageNo 		= HDUtil.nullCheckNum(greq.getParameter("sPageNo"));
			String 	sCustGu 		= HDUtil.nullCheckStr(greq.getParameter("sCustGu"));			

			
			//StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			//StringUtil.printMsg("sDepartDate",sDepartDate,this);
			//StringUtil.printMsg("sSaupSid",sSaupSid,this);
			//StringUtil.printMsg("sDepartTime",sDepartTime,this);
			//StringUtil.printMsg("sClass",sClass,this);
			//StringUtil.printMsg("sTeams",sTeams,this);
			//StringUtil.printMsg("sPageNo",sPageNo,this);
			//StringUtil.printMsg("sCustGu",sCustGu,this);
			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput();			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DS1=ds1, 					DEFAULT=ds9 (리포트용)
				int sCnt1 = 1; 
				int sCnt2 = 1;            
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");			
							
					if (0 < sSaupSid) {
						StringUtil.printMsg("1", this);
						arr_sql[0].append ("  AND T1.SAUP_SID = ?     	\n"); /* 사업소 */
					}
					   
					if (!"".equals(sDepartDate)) {
						StringUtil.printMsg("2", this);
						arr_sql[0].append ("  AND T2.DEPART_DATE = ?   	\n");  /* 출경일자 */
					}
					
					if (!"".equals(sDepartTime)) {
						StringUtil.printMsg("3", this);
						arr_sql[0].append ("  AND T2.DEPART_TIME = ? 	\n");  /* 출경시간 */
					}
					if (0 < sGoodsSid) {
						StringUtil.printMsg("4", this);
						arr_sql[0].append ("   AND T1.GOODS_SID = ? 	\n"); /* 상품 */
					}
					
					if (!"".equals(sClass)) {
						StringUtil.printMsg("5", this);
						arr_sql[0].append ("  AND T2.CLASS = ? 			\n"); /* 반 코드 */
					}
					
					if (!"".equals(sTeams)) {
						StringUtil.printMsg("6", this);
						arr_sql[0].append (" AND T2.TEAMS  = ? 			\n"); /* 팀      */
					}
					
					if (0 < sPageNo) {
						StringUtil.printMsg("7", this);
						arr_sql[0].append ("AND T2.PAGE_NO    = ? 		\n");    /* 페이지 NO */
					}

					if (!"".equals(sCustGu)) {
						StringUtil.printMsg("8", this);
						arr_sql[0].append ("AND T2.CUST_GU    = ? 		\n");    /* 페이지 NO */
					}
					
					arr_sql[0].append (" ORDER BY T2.CLASS 				\n")
								.append (" ,T2.TEAMS 					\n")
								.append (" ,T2.TOUR_NO 					\n")
								.append (" ,T2.RSV_SID  				\n");
							
					//StringUtil.printMsg("쿼리 ", arr_sql[0].toString(), this);
					cstmt = conn.prepareCall(arr_sql[0].toString());							

					if (0 < sSaupSid) {
						cstmt.setInt(sCnt1++, sSaupSid);
					}
					   
					if (!"".equals(sDepartDate)) {
						cstmt.setString(sCnt1++, sDepartDate);		
					}
					
					if (!"".equals(sDepartTime)) {
						cstmt.setString(sCnt1++, sDepartTime);		
					}
					if (0 < sGoodsSid) {
						cstmt.setInt(sCnt1++, sGoodsSid);
					}
					
					if (!"".equals(sClass)) {
						cstmt.setString(sCnt1++, sClass);		
					}
					
					if (!"".equals(sTeams)) {
						cstmt.setString(sCnt1++, sTeams);
					}
					
					if (0 < sPageNo) {
						cstmt.setInt(sCnt1++, sPageNo);
					}

					if (!"".equals(sCustGu)) {
						cstmt.setString(sCnt1++, sCustGu);
					}
				
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds9")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					if (0!=sSaupSid) {
						arr_sql[1].append ("  AND T1.SAUP_SID = ?     	\n"); /* 사업소 */
					}
					   
					if (!"".equals(sDepartDate)) {
						arr_sql[1].append ("  AND T2.DEPART_DATE = ?   	\n");  /* 출경일자 */
					}
					
					if (!"".equals(sDepartTime)) {
						arr_sql[1].append ("  AND T2.DEPART_TIME = ? 	\n");  /* 출경시간 */
					}
					if (0!=sGoodsSid) {
						arr_sql[1].append ("   AND T1.GOODS_SID = ? 	\n"); /* 상품 */
					}
					
					if (!"".equals(sClass)) {
						arr_sql[1].append ("  AND T2.CLASS = ? 			\n"); /* 반 코드 */
					}
					
					if (!"".equals(sTeams)) {
						arr_sql[1].append (" AND T2.TEAMS  = ? 			\n"); /* 팀      */
					}
					
					if (0!=sPageNo) {
						arr_sql[1].append ("AND T2.PAGE_NO    = ? 		\n");    /* 페이지 NO */
					}
					
					arr_sql[1].append (" ORDER BY T2.CLASS 				\n")
								.append (" ,T2.TEAMS 					\n")
								.append (" ,T2.TOUR_NO 					\n")
								.append (" ,T2.RSV_SID  				\n");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					StringUtil.printMsg("쿼리 ", arr_sql[1].toString(), this);
					if (0!=sSaupSid) {
						cstmt.setInt(sCnt2++, sSaupSid);
					}
					   
					if (!"".equals(sDepartDate)) {
						cstmt.setString(sCnt2++, sDepartDate);		
					}
					
					if (!"".equals(sDepartTime)) {
						cstmt.setString(sCnt2++, sDepartTime);		
					}
					if (0!=sGoodsSid) {
						cstmt.setInt(sCnt2++, sGoodsSid);
					}
					
					if (!"".equals(sClass)) {
						cstmt.setString(sCnt2++, sClass);		
					}
					
					if (!"".equals(sTeams)) {
						cstmt.setString(sCnt2++, sTeams);
					}
					
					if (0!=sPageNo) {
						cstmt.setInt(sCnt2++, sPageNo);
					}
					
					rs = cstmt.executeQuery(); // DataSet set

					rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
					
					//위에서 실행한 결과를  불러서 데이터셋에 주욱 추가하고..
					for(int j=0; j<columnName.length; j++){
						columnName[j] = rsmd.getColumnName(j+1);
						if(rsmd.getColumnTypeName(j+1).equals("NUMERIC"))
							ds1.addDataColumn(new GauceDataColumn(columnName[j], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(j+1)));
						else
							ds1.addDataColumn(new GauceDataColumn(columnName[j], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(j+1)));
					}
					//마지막으로 사진정보를 데이터셋에 추가하고.
					ds1.addDataColumn(new GauceDataColumn("picture_info",GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("picture_url",GauceDataColumn.TB_URL,1024));	
					while ( rs.next()) {
						//GauceDataRow row = ds1.newDataRow();								
						for(int j=0; j<columnName.length; j++) {
//									System.out.println("ColumnType:"+i+rsmd.getColumnTypeName(i+1));
//									System.out.println("ColumnName:"+i+rsmd.getColumnName(i+1)+"끝");									
							if(rsmd.getColumnTypeName(j+1).equals("NUMERIC"))
								//row.addColumnValue(rs.getInt(columnName[j]));
								ds1.put(columnName[j], rs.getLong(columnName[j]), rsmd.getColumnDisplaySize(j+1));
							else
								//row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								ds1.put(columnName[j], HDUtil.nullCheckStr(rs.getString(columnName[j])), rsmd.getColumnDisplaySize(j+1));
						}		
						//StringUtil.printMsg("사진경로",HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG",this);
									
						//row.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG");
						//row.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG");
						//row.addColumnValue(HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG");
						//row.addColumnValue(HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG");
						ds1.put("picture_info",HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG", rsmd.getColumnDisplaySize(i+1));
						ds1.put("picture_url",HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG", rsmd.getColumnDisplaySize(i+1));
						ds1.heap();//put메소드를 통해 순차적으로 입력된 컬럼의 값을 하나의 행으로 인식하고 GauceDataSet에 적재 ds1.addDataRow(row);
					}//End of while
					gos.write(ds1);
					
				}
			}
			gos.close();
		} catch (SQLException sqle){
//			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
//			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
}
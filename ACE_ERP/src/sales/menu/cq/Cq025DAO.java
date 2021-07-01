package sales.menu.cq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.menu.cq.Cq025DTO;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;


public class Cq025DAO extends CommonDAO {
    public Cq025DAO() {
        super(); 
    }
    
    // �Խ��� ��� �ҷ����� ��...�޼ҵ�� 2���� �ʿ��ѵ�. ����Ʈ�� ī��Ʈ~
    // �� list �ϳ��� ī��Ʈ�� Ŀ�� �����ϴ� �� �غ���:)
    public ArrayList list(Cq025DTO entity, Connection conn) throws SQLException {
        java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null; 

       	int 	 	 sSaupSid	   ;	
    	String       sDepartDate   ;	
    	String       sDepartTime   ;	
    	int 		 sGoodsSid     ;	
    	String       sClass        ;	
    	String       sTeams        ;	
    	int 		 sPageNo       ; 
    	String		 sCustGu       ;
        
        sql.append ("")
			.append("  SELECT																														\n")
			.append("  t2.depart_date||t2.class||t4.goods_cd||DIGITS(t2.page_no) AS page_skip										\n")      /* PAGE�� �ѱ�� ���� */
		    .append("  ,CASE WHEN T1.SAUP_SID = 1 THEN '�ݰ��� ������ ���'				\n")
		    .append("        WHEN T1.SAUP_SID = 2 THEN '���� ������ ���'				\n")
		    .append("        END  AS DOC_TITLE    /* ���� ���� (2007.08.10 �ɵ��� �߰�)  */         			\n")
			.append("  ,t2.page_no AS page_no																								\n")        /* PAGE ��ȣ */
			.append("  ,t3.manage_no AS manage_no																							\n")      /* ������ȣ(�ֹ�/����)*/
			.append("  ,SUBSTRING(T3.MANAGE_NO,1,1)||'/'||T3.MANAGE_NO            AS PIC_ADDR												\n")	  /* [����FILE��] */
			.append("  ,t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2) ||								\n")  
			.append("  '                    ( Page : '||varchar(t2.page_no)||' )' AS team_nm1												\n")      /* ������ü��        */
			.append("  ,'( Page : '||varchar(t2.page_no)||' )'|| t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||					\n")  
			.append("  '-'||SUBSTR(t2.teams,1,2) AS skip																					\n")  
			.append("  ,t2.depart_date AS depart_date																						\n")      /* �����Ⱓ:�������� */
			.append("  ,t2.arrive_date AS arrive_date																						\n")      /* �����Ⱓ:�������� */
			.append("  ,CASE WHEN t4.nights = 0               THEN '('||RTRIM(CHAR(t4.days))||'��)'											\n")  
			.append("  ELSE '('||RTRIM(CHAR(t4.nights))||'��'||RTRIM(CHAR(t4.days))||'��)' END AS nights_days								\n")    /*  �ڼ�/�ϼ�       */
			.append("  ,t4.nights AS nights																									\n")   /* �ڼ�            */
			.append("  ,t4.days AS days																										\n")   /* �ϼ�            */
			.append("  ,t2.STATUS_CD AS STATUS_CD																							\n")   /* �������            */
			
			.append("  ,t3.cust_nm AS cust_nm1																								\n")   /* ����1        */
			.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.cust_nm END AS cust_nm2											\n")    /* ����2        */
			.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.first_nm||' '||t3.last_nm END AS cust_enm 							\n")   /* ��������     */
			.append("  ,SUBSTR(t3.birthday,1,4)||'.'||SUBSTR(t3.birthday,5,2)||'.'||SUBSTR(t3.birthday,7,2) AS birthday						\n")             /* �������     */
			.append("  ,t3.company_nm||t3.positions 																			AS comp_nm1	\n")    /* ����/����1   */
//			.append("  ,'=\"' ||SUBSTRING(t3.company_nm||t3.positions,1,13)||'\"&CHAR(10)&\"'||SUBSTRING(t3.company_nm||t3.positions,14,30) ||'\"' AS comp_nm1	\n")    /* ����/����1   */
			
			//.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.company_nm||' '||t3.positions END AS comp_nm2	 					\n")   /* ����/����2   */
			//.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.eng_company_nm||' '||t3.eng_position END AS comp_enm				\n")    /* ��������/����*/
			.append("  ,CASE WHEN T3.COUNTRY_GU='10' THEN																\n")   
			.append("          RTRIM(T5.ADDRESS1) || SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))				\n")		
			.append("        WHEN T3.COUNTRY_GU='20' THEN																						\n")
			.append("            '[���ֱ�]'|| T3.ADDRESS1																						\n")
			.append("        WHEN T3.COUNTRY_GU='30' THEN																						\n")
			.append("            '[�ùα�]'|| T3.ADDRESS1																						\n")
			.append("        WHEN T3.COUNTRY_GU='40' THEN																						\n")
			.append("            '[�ܱ���]'|| T3.ADDRESS1																						\n")
			.append("       ELSE																												\n")   
			.append("            T3.ADDRESS1																									\n")   
			.append("       END                                            AS ADDRESS1															\n")    /* ��� ��.�������� �ƴϸ� �տ� ����ǥ��       */
			.append("      ,CASE WHEN T3.COUNTRY_GU ='10' THEN																				\n")   
			.append("            ''																														\n")   
			.append("       ELSE																														\n")   
			.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD)) || ' / ' || 				\n")
			.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))									\n")
			.append("       END                                            AS COUNTRY_CD 												\n")   /* ����/����    */
			.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE sales.fn_detail_nm('CU008',t3.pass_type) END AS pass_type		\n")   /* ��������:CU008  */
			.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE t3.pass_no END AS pass_no														\n")    /* ���ǹ�ȣ    */
			.append("  ,CASE t2.cust_gu WHEN 1 THEN t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2)||'-'||t2.tour_no    \n")
			.append("                   WHEN 2 THEN sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2) END AS tour_no	\n")   /* ������ȣ   */
			
			.append("  ,CASE t3.sex WHEN 'M' THEN '��' WHEN 'F' THEN '��' END as gender_nm \n") //����
			.append("  ,SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2)||' 08:00' AS sn_datetime  \n") //�԰��Ͻ�
			.append("  ,SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2)||' 17:00' AS ns_datetime  \n") //����Ͻ�
			.append("  ,CASE t2.cust_gu WHEN '1' THEN '��������' \n")
			.append("                   WHEN '2' THEN '�������� �ȳ����� ����' END AS north_purpose \n") //���Ը���
			.append("  ,'('||SUBSTR(t2.depart_date,1,4)||'.'||SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2)||')' AS title_date  \n") //����ڿ� ��¥			
			.append("  ,sales.fn_detail_nm('RV017',t2.class)||' '||SUBSTR(t2.teams,1,2) ||'��' AS title_class \n") //����ڿ� ����

			.append("  FROM sales.trv010 t1, sales.trv020 t2, sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5		\n")  
			.append("  ON t3.zip_sid=t5.zip_sid, sales.trm200 t4																				\n")  
			.append("  WHERE t1.accept_sid=t2.accept_sid																					\n")  
			.append("  AND t2.cust_sid=t3.cust_sid																								\n")  
			.append("  AND t1.goods_sid=t4.goods_sid																							\n")  
			.append("  AND T2.CONFIRM_YN='Y'      										\n")	/* ����üũ */    
			.append("   AND ((T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR'))  																				\n")    /* �����ڷ����(RR:����/RC:���/NS/DP:���/AR:�԰�) */
			.append("    OR (T2.STATUS_CD IN('RC', 'NS') AND T2.TOUR_NO <> '')) 																	\n")
			.append("   AND T2.SAUP_GU     <> '65'																								\n");

        

		sSaupSid	= HDUtil.nullCheckNum(entity.getsSaupSid());
		sDepartDate = entity.getsDepartDate();
		sDepartTime = entity.getsDepartTime();
		sGoodsSid   = HDUtil.nullCheckNum(entity.getsGoodsSid());
		sClass      = entity.getsClass();
		sTeams      = entity.getsTeams();
		sPageNo     = HDUtil.nullCheckNum(entity.getsPageNo());
		sCustGu		= HDUtil.nullCheckStr(entity.getsCustGu());
		
		//StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
		//StringUtil.printMsg("sDepartDate",sDepartDate,this);
		//StringUtil.printMsg("sSaupSid",sSaupSid,this);
		//StringUtil.printMsg("sDepartTime",sDepartTime,this);
		//StringUtil.printMsg("sClass",sClass,this);
		//StringUtil.printMsg("sTeams",sTeams,this);
		//StringUtil.printMsg("sPageNo",sPageNo,this);
		
		if (0 < sSaupSid) {
			sql.append ("  AND T1.SAUP_SID = ?     	\n"); /* ����� */
		}
		   
		if (!"".equals(sDepartDate)) {
			sql.append ("  AND T2.DEPART_DATE = ?   	\n");  /* ������� */
		}
		
		if (!"".equals(sDepartTime)) {
			sql.append ("  AND T2.DEPART_TIME = ? 	\n");  /* ���ð� */
		}
		if (0 < sGoodsSid) {
			sql.append ("   AND T1.GOODS_SID = ? 	\n"); /* ��ǰ */
		}
		
		if (!"".equals(sClass)) {
			sql.append ("  AND T2.CLASS = ? 			\n"); /* �� �ڵ� */
		}
		
		if (!"".equals(sTeams)) {
			sql.append (" AND T2.TEAMS  = ? 			\n"); /* ��      */
		}
		
		if (0 < sPageNo) {
			sql.append ("AND T2.PAGE_NO    = ? 		\n");    /* ������ NO */
		}
		
		if (!"".equals(sCustGu)) {
			sql.append ("AND T2.CUST_GU    = ? 		\n");    /* ������ NO */
		}		

		
		sql.append (" ORDER BY T2.CLASS 				\n")
				.append (" ,T2.TEAMS 					\n")
				.append (" ,T2.TOUR_NO 					\n")
				.append (" ,T2.RSV_SID  				\n");

		
        
		try {
        	//sales.common.StringUtil.printMsg("����",sql.toString(),this);
			int sCnt1 = 1;
        	pstmt =  new PreparedStatement(conn,sql.toString());
//        	pstmt.setString(1, entity.getBrd_gu());
			if (0 < sSaupSid) {
				pstmt.setInt(sCnt1++, sSaupSid);
			}
			   
			if (!"".equals(sDepartDate)) {
				pstmt.setString(sCnt1++, sDepartDate);		
			}
			
			if (!"".equals(sDepartTime)) {
				pstmt.setString(sCnt1++, sDepartTime);		
			}
			if (0 < sGoodsSid) {
				pstmt.setInt(sCnt1++, sGoodsSid);
			}
			
			if (!"".equals(sClass)) {
				pstmt.setString(sCnt1++, sClass);		
			}
			
			if (!"".equals(sTeams)) {
				pstmt.setString(sCnt1++, sTeams);
			}
			
			if (0 < sPageNo) {
				pstmt.setInt(sCnt1++, sPageNo);
			}        

			if (!"".equals(sCustGu)) {
				pstmt.setString(sCnt1++, sCustGu);
			}

	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            data = new BaseDataClass();
	            data.setValues(rs);
	            arrBeans.add(data);
	        }
	        
	        //System.out.println(sql.toString());

	    }catch(Exception e){
	    	e.printStackTrace();
	        LogUtil.error(e);
	    }finally{
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	    }
    return arrBeans;
    }
}
    
    
    
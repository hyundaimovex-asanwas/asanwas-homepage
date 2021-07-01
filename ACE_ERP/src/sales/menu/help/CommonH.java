package sales.menu.help;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class CommonH extends SuperServlet {

   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

public void makeSql(){

	  /* @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ�  */
	  String iParamEmpno = fParamEmpno;
	  String iParamIp = fParamIp;

	  for(int i=0; i<arr_sql.length; i++)
		 arr_sql[i] = new StringBuffer();

	  //�����
	  arr_sql[0]
		 .append (" SELECT SAUP_SID,                            \n")
		 .append ("        SAUP_NM                              \n")
		 .append ("   FROM SALES.TSY200                         \n")
		 .append ("  WHERE SAUP_NM is not null                        \n");         

	  //   ���ð�
	  arr_sql[1]
		 .append (" SELECT ' '                AS DEPART_TIME,                    \n")
		 .append ("       '��ü'             AS DEPART_TIME_NM                  \n")
		 .append (" FROM DUAL                                       \n")
		 .append (" UNION ALL                                                   \n")
		 .append (" SELECT R2.DEPART_TIME,                                      \n")
		 .append ("         SALES.FMT_TIME(R2.DEPART_TIME) AS DEPART_TIME_NM    \n")
		 .append ("   FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2                 \n")
		 .append ("     ON R2.GOODS_SID   = R1.GOODS_SID                        \n")
		 .append ("  WHERE R1.SAUP_SID    = ?                                   \n")
		 .append ("    AND trim(R2.DEPART_DATE) = ?                                   \n")
		 .append ("    AND R2.DEPART_TIME is not null                                  \n")         
		 .append ("  GROUP BY R2.DEPART_TIME                                    \n")
		 .append ("  ORDER BY DEPART_TIME                                       \n");
         

	  //��ǰ - editted by �ɵ��� 2006-08-07
	  // 		�ش� ������ڿ� �ִ� ��ǰ�� �ҷ��ɴϴ�.
	  //       ��ǰ���� ���̺��� �߰��Ǹ鼭 JOIN�� ������ TRV015�� �Ǿ�� �մϴ�. 
	  // 		�̰� �����ؼ� ��ĥ�� ����̰ڱ���..
	  arr_sql[2]
		 .append("SELECT 0                   AS GOODS_SID,           \n")     //��ǰSID
		 .append("       '��ü'              AS GOODS_NM,            \n")     // ��ǰ��
		 .append("       0                   AS DISPLAY_SEQ          \n")     // ��ǰ��
		 .append("  FROM DUAL                            \n")
		 .append(" UNION ALL                                         \n")
		 .append("SELECT DISTINCT R15.GOODS_SID 	AS GOODS_SID,        \n")
		 .append("       R2.GOODS_NM 			AS GOODS_NM,         \n")
		 .append("       R2.DISPLAY_SEQ 		AS DISPLAY_SEQ       \n")
		 .append("  FROM SALES.TRV015 R15 JOIN SALES.TRM200 R2  \n")
		 .append("    ON R15.GOODS_SID   = R2.GOODS_SID               \n")
		 .append(" WHERE R2.USE_YN = 'Y' 				     \n");


	  //������
	  arr_sql[3]
		 .append ("SELECT                                            \n")
		 .append ("   '' DETAIL, '��ü' DETAIL_NM                    \n")
		 .append ("FROM DUAL                             \n")
		 .append ("UNION ALL                                         \n")
		 .append ("SELECT                                            \n")
		 .append ("      DETAIL,                                     \n")
		 .append ("      DETAIL_NM                                   \n")
		 .append ("FROM SALES.TSY010                                 \n")
		 .append ("WHERE HEAD    =  'CU001'                          \n")
		 .append ("   AND DETAIL  is not null                             \n")
		 .append ("   AND ITEM1   =  'Y'                             \n");
	  //��
	  arr_sql[4]
		 .append("")
		 .append("   SELECT ' '                             AS CLASS        \n")
		 .append("     ,'��ü'                             AS CLASS_NM     \n")
		 .append("   FROM DUAL                                 \n")
		 .append("   UNION ALL                                             \n")
		 .append("   SELECT DISTINCT CLASS                 AS CLASS        \n")
		 .append("     ,SALES.FN_DETAIL_NM('RV017', CLASS) AS CLASS_NM     \n")
		 .append("   FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2             \n")
		 .append("   ON R2.ACCEPT_SID  =  R1.ACCEPT_SID                    \n")
		 .append("   WHERE R2.CLASS IS NOT NULL                            \n");


	  //��
	  arr_sql[5]
		 .append("")
		 .append("SELECT ' '                 AS TEAMS                       \n")
		 .append("     ,'��ü  '                             AS TEAMS_NM     \n")
		 .append("  FROM DUAL                                  \n")
		 .append(" UNION ALL                                               \n")
		 .append("SELECT DISTINCT                                          \n")
		 .append("       R2.TEAMS           AS TEAMS                       \n")
		 .append("      ,R2.TEAMS           AS TEAMS_NM                    \n")
		 .append("  FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2              \n")
		 .append("    ON R2.ACCEPT_SID  =  R1.ACCEPT_SID                   \n")
		 .append(" WHERE R2.TEAMS IS NOT NULL                              \n");

	  // ������
	  arr_sql[6]
		 .append("SELECT                                       \n")
		 .append ("   0 upjang_sid,   '��ü' upjang_nm         \n")
		 .append ("FROM DUAL                       \n")
		 .append ("UNION ALL                                   \n")
		 .append("SELECT                                       \n")
		 .append("      upjang_sid,                            \n")
		 .append("     upjang_nm                               \n")
		 .append("FROM                                         \n")
		 .append("      SALES.TRM010                           \n")
		 .append("WHERE upjang_type = 10                       \n")
		 .append("      and use_yn='Y'						   \n");

	  //��������
	  arr_sql[7]
		 .append("SELECT                              \n")
		 .append("   ' '     AS detail,                \n")
		 .append("   '��ü' AS detail_nm              \n")
		 .append("FROM DUAL               \n")
		 .append("UNION ALL                           \n")
		 .append("SELECT    detail,                   \n")
		 .append("          detail_nm                 \n")
		 .append("FROM sales.tsy010                   \n")
		 .append("WHERE head='CU009'                  \n");

	  //�԰�ð�
	  arr_sql[8]
		 .append ("SELECT ' '                AS detail,               \n")
		 .append ("      '��ü'             AS detail_nm              \n")
		 .append ("FROM DUAL                                   \n")
		 .append ("UNION ALL                                               \n")
		 .append ("SELECT R2.ARRIVE_TIME    AS detail,                     \n")
		 .append ("      SALES.FMT_TIME(R2.ARRIVE_TIME) AS detail_NM	   \n")
		 .append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2               \n")
		 .append ("   ON R2.GOODS_SID   = R1.GOODS_SID                     \n")
		 .append ("WHERE R1.SAUP_SID    = ?                                \n")
		 .append ("  AND R2.ARRIVE_DATE = ?                                \n")
		 .append ("  AND R2.ARRIVE_TIME is not null                               \n")
		 .append ("GROUP BY R2.ARRIVE_TIME                                 \n")
		 .append ("ORDER BY detail                                    \n");
         

	  //�԰��ǰ - �׳� ��ü ��ǰ�ε�..?
	  arr_sql[9]
			  .append(" SELECT R1.GOODS_SID,                               \n") 
			  .append("        R1.GOODS_NM                                 \n") 
			  .append("   FROM (                                           \n") 
			  .append("         SELECT 0                   AS GOODS_SID,   \n") 
			  .append("                '��ü'              AS GOODS_NM,    \n") 
			  .append("                0                   AS DISPLAY_SEQ  \n") 
			  .append("           FROM DUAL                    \n") 
			  .append("          UNION ALL                                 \n") 
			  .append("         SELECT GOODS_SID,                          \n") 
			  .append("                GOODS_NM            AS GOODS_NM,    \n") 
			  .append("                DISPLAY_SEQ         AS DISPLAY_SEQ  \n") 
			  .append("           FROM SALES.TRM200                        \n") 
			  .append("          WHERE USE_YN = 'Y'                        \n") 
			  .append("        ) R1                                        \n") 
			  .append("  ORDER BY R1.DISPLAY_SEQ                           \n");

	  // �ڵ� (�԰�ð�)
	  arr_sql[10].append("SELECT HEAD, DETAIL, DETAIL_NM FROM SALES.TSY010 WHERE HEAD = 'RM015' AND DETAIL<>'' ORDER BY DETAIL ASC ");

	  // ������
	  arr_sql[11]
		 .append("SELECT                                  \n")
		 .append("      upjang_sid,                       \n")
		 .append("     upjang_nm                          \n")
		 .append("FROM                                    \n")
		 .append("      SALES.TRM010                      \n")
		 .append("WHERE upjang_type = 10                  \n");

	  //�����ڵ� (��ü ����)
	  arr_sql[12]
		 .append("SELECT                                                         \n")
		 .append("   ' '     AS detail,                                           \n")
		 .append("   '��ü' AS detail_nm                                         \n")
		 .append("FROM DUAL                                          \n")
		 .append("UNION ALL                                                      \n")
		 .append("SELECT    detail,                                              \n")
		 .append("          detail_nm                                            \n")
		 .append("FROM sales.tsy010                                              \n")
		 .append("WHERE head='CU021'        AND DETAIL_NM<>'���ɱ���'            \n");

//		�����ڵ� (��ü ����)
	  arr_sql[13]
		 .append("SELECT                                                         \n")
		 .append("   ' '     AS detail,                                           \n")
		 .append("   '��ü' AS detail_nm                                         \n")
		 .append("FROM DUAL                                          \n")
		 .append("UNION ALL                                                      \n")
		 .append("SELECT    detail,                                              \n")
		 .append("          detail_nm                                            \n")
		 .append("FROM sales.tsy010                                              \n")
		 .append("WHERE head='SY006' AND DETAIL_NM <> '�����ڵ�'                 \n");

	  // �����ڵ� : 2008-03-18 ���� : �Ӽ�1=Y ������� �͸�. 	�ɵ�
	  arr_sql[14]
		 .append("                                    \n")
		 .append("SELECT    detail,                   \n")
		 .append("          detail_nm                 \n")
		 .append("FROM sales.tsy010                   \n")
		 .append("WHERE head='RV003' AND ITEM1='Y'    \n");
         

	  // ���ɱ���
	  arr_sql[15]
		 .append("                     \n")
		 .append("SELECT    detail,    \n")
		 .append("          detail_nm  \n")
		 .append("FROM sales.tsy010    \n")
		 .append("WHERE head='RV014'   \n");

	  //�����(��ü ����)
	  arr_sql[16]
		  .append("SELECT                                       \n")
		  .append("   0     AS SAUP_SID,                       \n")
		  .append("   '��ü' AS SAUP_NM,                        \n")
		  .append("       0  AS DISPLAY_SEQ          			\n")		  
		  .append("FROM DUAL                        \n")
		  .append("UNION ALL                                    \n")
		 .append (" SELECT SAUP_SID,                            \n")
		 .append ("        SAUP_NM,                             \n")
		 .append ("        DISPLAY_SEQ   				        \n")
		 .append ("   FROM SALES.TSY200                         \n")
		 .append ("  WHERE SAUP_NM is not null AND USE_YN='Y'         \n");
	  
	//��ǰ - �������θ� �θ���
	// 		������� �����ϰ� ������ �����ǰ�� �θ���
	arr_sql[17]
	   .append("SELECT 0                   AS GOODS_SID,           \n")     //��ǰSID
	   .append("       '��ü'              AS GOODS_NM,            \n")     // ��ǰ��
	   .append("       0                   AS DISPLAY_SEQ          \n")     // ��ǰ��
	   .append("  FROM DUAL                            \n")
	   .append(" UNION ALL                                         \n")
	   .append("SELECT R2.GOODS_SID 		AS GOODS_SID,        \n")
	   .append("       R2.GOODS_NM 			AS GOODS_NM,         \n")
	   .append("       R2.DISPLAY_SEQ 		AS DISPLAY_SEQ       \n")
	   .append("  FROM SALES.TRM200 R2  \n")
	   .append(" WHERE R2.USE_YN = 'Y' 				     \n");
   




	//   ���ð� �� : �÷��� ���� : 2010-03-19
	arr_sql[18]
	   .append (" SELECT ' '                AS detail,                    \n")
	   .append ("       '��ü'             AS detail_nm                  \n")
	   .append (" FROM DUAL                                       \n")
	   .append (" UNION ALL                                                   \n")
	   .append (" SELECT R2.DEPART_TIME as detail,                                      \n")
	   .append ("         SALES.FMT_TIME(R2.DEPART_TIME) AS detail_nm    \n")
	   .append ("   FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2                 \n")
	   .append ("     ON R2.GOODS_SID   = R1.GOODS_SID                        \n")
	   .append ("  WHERE R1.SAUP_SID    = ?                                   \n")
	   .append ("    AND R2.DEPART_DATE = ?                                   \n")
	   .append ("    AND R2.DEPART_TIME IS NOT NULL                           \n")         
	   .append ("  GROUP BY R2.DEPART_TIME                                    \n")
	   .append ("  ORDER BY detail                                       \n");


         



   }

   public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	  //System.out.println("# Command : ����ȸ");
	  CallableStatement cstmt = null;
	  ResultSet rs = null;
	  ResultSetMetaData rsmd = null;
	  String[] columnName = null;

	  int v_rowcnt = 0;

	  int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
	  String   sSaupSid       =  HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
	  String   sDepartDate    =  HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
	  String   sDepartTime    =  HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
	  String   sArriveDate    =  HDUtil.nullCheckStr(greq.getParameter("sArriveDate"));
	  String   sArriveTime    =  HDUtil.nullCheckStr(greq.getParameter("sArriveTime"));
	  String   sClass         =  HDUtil.nullCheckStr(greq.getParameter("sClass"));
	  String   sGoodSid       =  HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
	  int menuIdx = HDUtil.nullCheckNum(greq.getParameter("menuIdx")); //�߰� 20140210
	  //StringUtil.printMsg("menuIdx      ",menuIdx      ,this);
	  //StringUtil.printMsg("sSaupSid      ",sSaupSid      ,this);
	  //StringUtil.printMsg("sDepartDate   ",sDepartDate   ,this);
	  //StringUtil.printMsg("sDepartTime   ",sDepartTime   ,this);
	  //StringUtil.printMsg("sArriveDate   ",sArriveDate   ,this);
	  //StringUtil.printMsg("sArriveTime   ",sArriveTime   ,this);
	  //StringUtil.printMsg("sClass         ",sClass       ,this);
	  //StringUtil.printMsg("sGoodSid       ",sGoodSid     ,this);

	  try{
		  GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    int sCnt1 = 1;
			int sCnt2 = 1;
		    for(int i=0; i<dSets.length;i++){
		    	//StringUtil.printMsg(" for(int i=0; i<dSets.length;i++)       ","  for(int i=0; i<dSets.length;i++)"    ,this);
			   	if(dSets[i].getName().equals("ds_saup")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_SAUP_DS");
		   			cstmt = conn.prepareCall(arr_sql[0].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("codeDs1")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_SAUP_DS_ALL");
		   			arr_sql[16].append(" ORDER BY DISPLAY_SEQ        \n"); //������� ǥ��
		   			cstmt = conn.prepareCall(arr_sql[16].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if((dSets[i].getName().equals("ds_time")) && dsType!=2 && dsType!=3){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		//StringUtil.printMsg(" dsType==1 ",dsType,this);
		   			GauceDataSet ds1 = gis.read("S_DEPART_TIME_DS");
		   			cstmt = conn.prepareCall(arr_sql[1].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if((dSets[i].getName().equals("ds_time")) && dsType==2 && dsType!=3){ //Ȩ>����>���԰���>���԰�ȹ>New���뿬���(�ο�) �԰�
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		//StringUtil.printMsg(" dsType==2 ",dsType,this);
			   		GauceDataSet ds1 = gis.read("S_ARRIVE_TIME_DS");
		   			cstmt = conn.prepareCall(arr_sql[8].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sArriveDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("ds3") && menuIdx!=338){	//Ȩ>����>���԰���>���԰�ȹ>New���뿬���(�ο�)
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_DEPART_TIME_DS");
		   			cstmt = conn.prepareCall(arr_sql[1].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("initDs2")){	//Ȩ>����>���԰���>���� �����ڼ���>���� �����ڼ���
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_DEPART_TIME_DS");
		   			cstmt = conn.prepareCall(arr_sql[1].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("ds3") && menuIdx==338){	//Ȩ>����>���԰���>ü������>�԰��� ü������
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		GauceDataSet ds1 = gis.read("S_ARRIVE_TIME_DS");
		   			cstmt = conn.prepareCall(arr_sql[8].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sArriveDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			  	if(dSets[i].getName().equals("ds_ar_time")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_ARRIVE_TIME_DS");
		   			cstmt = conn.prepareCall(arr_sql[8].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sArriveDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			  	if(dSets[i].getName().equals("codeDs7")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_ARRIVE_GOODS_DS");
		   			cstmt = conn.prepareCall(arr_sql[9].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("ds_goods")){
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		GauceDataSet ds1 = gis.read("S_GOODS_DS");
				   	if (!"".equals(sSaupSid)) {
					   arr_sql[2].append(" AND R2.SAUP_SID    = ?      \n");
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[2].append("   AND R15.DEPART_DATE = ?   \n");
					}
					arr_sql[2].append(" ORDER BY DISPLAY_SEQ        \n"); //������� ǥ��
					//StringUtil.printMsg("arr_sql[2]:::::::::",arr_sql[2].toString(),this);
					//StringUtil.printMsg("sSaupSid:::::::::",sSaupSid,this);
					//StringUtil.printMsg("sDepartDate:::::::::",sDepartDate,this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					if ((!"".equals(sSaupSid)) && sSaupSid != null){
					   cstmt.setString(sCnt2++, sSaupSid);
					}
					if((!"".equals(sDepartDate)) && sDepartDate != null) {
					   cstmt.setString(sCnt2++, sDepartDate);
					}
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
			   	if(dSets[i].getName().equals("initDs3")){ //Ȩ>����>���԰���>���� �����ڼ���>���� �����ڼ���
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		GauceDataSet ds1 = gis.read("S_GOODS_DS");
				   	if (!"".equals(sSaupSid)) {
					   arr_sql[2].append(" AND R2.SAUP_SID    = ?      \n");
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[2].append("   AND R15.DEPART_DATE = ?   \n");
					}
					arr_sql[2].append(" ORDER BY DISPLAY_SEQ        \n"); //������� ǥ��
					//StringUtil.printMsg("arr_sql[2]:::::::::",arr_sql[2].toString(),this);
					//StringUtil.printMsg("sSaupSid:::::::::",sSaupSid,this);
					//StringUtil.printMsg("sDepartDate:::::::::",sDepartDate,this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					if ((!"".equals(sSaupSid)) && sSaupSid != null){
					   cstmt.setString(sCnt2++, sSaupSid);
					}
					if((!"".equals(sDepartDate)) && sDepartDate != null) {
					   cstmt.setString(sCnt2++, sDepartDate);
					}
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
			   	if(dSets[i].getName().equals("ds4")  && menuIdx!=266){ //Ȩ>����>���԰���>���԰�ȹ>��� UNC���
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		GauceDataSet ds1 = gis.read("S_GOODS_DS");
				   	if (!"".equals(sSaupSid)) {
					   arr_sql[2].append(" AND R2.SAUP_SID    = ?      \n");
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[2].append("   AND R15.DEPART_DATE = ?   \n");
					}
					arr_sql[2].append(" ORDER BY DISPLAY_SEQ        \n"); //������� ǥ��
					//StringUtil.printMsg("arr_sql[2]:::::::::",arr_sql[2].toString(),this);
					//StringUtil.printMsg("sSaupSid:::::::::",sSaupSid,this);
					//StringUtil.printMsg("sDepartDate:::::::::",sDepartDate,this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					if ((!"".equals(sSaupSid)) && sSaupSid != null){
					   cstmt.setString(sCnt2++, sSaupSid);
					}
					if((!"".equals(sDepartDate)) && sDepartDate != null) {
					   cstmt.setString(sCnt2++, sDepartDate);
					}
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
			   	if(dSets[i].getName().equals("ds4")	 && menuIdx==266){ //Ȩ>����>���ǰ���>��ϰ���>�����ȸ	IDX=266
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("S_GOODS_DS_ONLY");
		   			if (!"".equals(sSaupSid)) {
						arr_sql[17].append(" AND R2.SAUP_SID    = ?      \n");
					}
						arr_sql[17].append(" ORDER BY DISPLAY_SEQ        \n"); //������� ǥ��
					cstmt = conn.prepareCall(arr_sql[17].toString());
				   if (!"".equals(sSaupSid)) {
						  cstmt.setString(sCnt2++, sSaupSid);
				   }
				   rs = cstmt.executeQuery(); // DataSet set
				   gos.write(getDataSet(rs, ds1));
			   	} 
			   	if(dSets[i].getName().equals("codeDs2") && menuIdx!=341&& menuIdx!=355){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS5");
		   			cstmt = conn.prepareCall(arr_sql[3].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("codeDs2") && menuIdx==341 && menuIdx!=355 ){
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("RM015");
		   			cstmt = conn.prepareCall(arr_sql[10].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("codeDs2") && menuIdx!=341 && menuIdx==355 ){//Ȩ>����>�������>������ڰ���>���������ȸ
			   	//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		GauceDataSet ds1 = gis.read("S_GOODS_DS");
				   	if (!"".equals(sSaupSid)) {
					   arr_sql[2].append(" AND R2.SAUP_SID    = ?      \n");
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[2].append("   AND R15.DEPART_DATE = ?   \n");
					}
					arr_sql[2].append(" ORDER BY DISPLAY_SEQ        \n"); //������� ǥ��
					//StringUtil.printMsg("arr_sql[2]:::::::::",arr_sql[2].toString(),this);
					//StringUtil.printMsg("sSaupSid:::::::::",sSaupSid,this);
					//StringUtil.printMsg("sDepartDate:::::::::",sDepartDate,this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					if ((!"".equals(sSaupSid)) && sSaupSid != null){
					   cstmt.setString(sCnt2++, sSaupSid);
					}
					if((!"".equals(sDepartDate)) && sDepartDate != null) {
					   cstmt.setString(sCnt2++, sDepartDate);
					}
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("ds_ban")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS6");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[4].append("   AND R1.SAUP_SID     = ?                       \n");
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   arr_sql[4].append("   AND R1.GOODS_SID    = ?                      \n") ;
					}
					if (!"".equals(sDepartDate)) {//��������� ��..����..
					   arr_sql[4].append (" AND R2.DEPART_DATE = ? \n");
					}
					arr_sql[4].append(" ORDER BY CLASS ASC        \n"); //������� ǥ��
					cstmt = conn.prepareCall(arr_sql[4].toString());
					if (!"".equals(sSaupSid)) {
					   cstmt.setString(sCnt1++, sSaupSid);
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   cstmt.setString(sCnt1++, sGoodSid);
					}
					if (!"".equals(sDepartDate)) {
					   cstmt.setString(sCnt1++, sDepartDate);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	} 
			   	if(dSets[i].getName().equals("ds6")){//Ȩ>����>���԰���>���԰�ȹ>��� UNC��� ����ȸ
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS6");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[4].append("   AND R1.SAUP_SID     = ?                       \n");
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   arr_sql[4].append("   AND R1.GOODS_SID    = ?                      \n") ;
					}
					if (!"".equals(sDepartDate)) {//��������� ��..����..
					   arr_sql[4].append (" AND R2.DEPART_DATE = ? \n");
					}
					arr_sql[4].append(" ORDER BY CLASS ASC        \n"); //������� ǥ��
					cstmt = conn.prepareCall(arr_sql[4].toString());
					if (!"".equals(sSaupSid)) {
					   cstmt.setString(sCnt1++, sSaupSid);
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   cstmt.setString(sCnt1++, sGoodSid);
					}
					if (!"".equals(sDepartDate)) {
					   cstmt.setString(sCnt1++, sDepartDate);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	} 
			   	if(dSets[i].getName().equals("ds_class")){ //Ȩ>����>���԰���>���԰�ȹ>New���뿬���(�ο�)
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS6");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[4].append("   AND R1.SAUP_SID     = ?                       \n");
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   arr_sql[4].append("   AND R1.GOODS_SID    = ?                      \n") ;
					}
					if (!"".equals(sDepartDate)) {//��������� ��..����..
					   arr_sql[4].append (" AND R2.DEPART_DATE = ? \n");
					}
					arr_sql[4].append(" ORDER BY CLASS ASC        \n"); //������� ǥ��
					cstmt = conn.prepareCall(arr_sql[4].toString());
					//StringUtil.printMsg(" arr_sql[4].toString() ",arr_sql[4].toString(),this);
					//StringUtil.printMsg(" sSaupSid ",sSaupSid,this);
					//StringUtil.printMsg(" sGoodSid ",sGoodSid,this);
					//StringUtil.printMsg(" sDepartDate ",sDepartDate,this);
					if (!"".equals(sSaupSid)) {
					   cstmt.setString(sCnt1++, sSaupSid);
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   cstmt.setString(sCnt1++, sGoodSid);
					}
					if (!"".equals(sDepartDate)) {
					   cstmt.setString(sCnt1++, sDepartDate);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			   	if(dSets[i].getName().equals("ds_jo")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS7");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[5].append("   AND R1.SAUP_SID     = ? \n");
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   arr_sql[5].append("   AND R1.GOODS_SID    = ? \n") ;
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[5].append (" AND R2.DEPART_DATE = ? \n");
					}
					if (!"".equals(sDepartTime)) {
					   arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
					}
					if (!"".equals(sClass)) {
					   arr_sql[5].append("   AND R2.CLASS        = ?                        \n")  ;
					}
					arr_sql[5].append ("ORDER BY TEAMS ASC            ");
					cstmt = conn.prepareCall(arr_sql[5].toString());

					if (!"".equals(sSaupSid)) {
					   cstmt.setString(sCnt1++, sSaupSid);
					}

					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   cstmt.setString(sCnt1++, sGoodSid);
					}

					if (!"".equals(sDepartDate)) {
					   cstmt.setString(sCnt1++, sDepartDate);
					}

					if (!"".equals(sDepartTime)) {
					   cstmt.setString(sCnt1++, sDepartTime);
					}

					if (!"".equals(sClass)) {
					   cstmt.setString(sCnt1++, sClass);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	} 
			   	if(dSets[i].getName().equals("ds7")){//Ȩ>����>���԰���>���԰�ȹ>��� UNC��� ��ȸ
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS7");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[5].append("   AND R1.SAUP_SID     = ? \n");
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   arr_sql[5].append("   AND R1.GOODS_SID    = ? \n") ;
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[5].append (" AND R2.DEPART_DATE = ? \n");
					}
					if (!"".equals(sDepartTime)) {
					   arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
					}
					if (!"".equals(sClass)) {
					   arr_sql[5].append("   AND R2.CLASS        = ?                        \n")  ;
					}
					arr_sql[5].append ("ORDER BY TEAMS ASC            ");
					cstmt = conn.prepareCall(arr_sql[5].toString());

					if (!"".equals(sSaupSid)) {
					   cstmt.setString(sCnt1++, sSaupSid);
					}

					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   cstmt.setString(sCnt1++, sGoodSid);
					}

					if (!"".equals(sDepartDate)) {
					   cstmt.setString(sCnt1++, sDepartDate);
					}

					if (!"".equals(sDepartTime)) {
					   cstmt.setString(sCnt1++, sDepartTime);
					}

					if (!"".equals(sClass)) {
					   cstmt.setString(sCnt1++, sClass);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	} 
			   	if(dSets[i].getName().equals("ds_team")){ //Ȩ>����>���԰���>���԰�ȹ>New���뿬���(�ο�)
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS7");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[5].append("   AND R1.SAUP_SID     = ? \n");
					}
					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   arr_sql[5].append("   AND R1.GOODS_SID    = ? \n") ;
					}
					if (!"".equals(sDepartDate)) {
					   arr_sql[5].append (" AND R2.DEPART_DATE = ? \n");
					}
					if (!"".equals(sDepartTime)) {
					   arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
					}
					if (!"".equals(sClass)) {
					   arr_sql[5].append("   AND R2.CLASS        = ?                        \n")  ;
					}
					arr_sql[5].append ("ORDER BY TEAMS ASC            ");
					cstmt = conn.prepareCall(arr_sql[5].toString());

					if (!"".equals(sSaupSid)) {
					   cstmt.setString(sCnt1++, sSaupSid);
					}

					if (!"".equals(sGoodSid) && !"0".equals(sGoodSid)) {
					   cstmt.setString(sCnt1++, sGoodSid);
					}

					if (!"".equals(sDepartDate)) {
					   cstmt.setString(sCnt1++, sDepartDate);
					}

					if (!"".equals(sDepartTime)) {
					   cstmt.setString(sCnt1++, sDepartTime);
					}

					if (!"".equals(sClass)) {
					   cstmt.setString(sCnt1++, sClass);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	} 
			   	if(dSets[i].getName().equals("ds_upjang")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("UPJANG");
		   			if (!"".equals(sSaupSid)) {
						   arr_sql[6].append(" AND saup_sid =?    \n");
					}
		   			cstmt = conn.prepareCall(arr_sql[6].toString());
		   			if (!"".equals(sSaupSid)) {
						   cstmt.setString(1, sSaupSid);
					}
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			  	if(dSets[i].getName().equals("ds8")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("COUNTRY");
		   			cstmt = conn.prepareCall(arr_sql[7].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			  	if(dSets[i].getName().equals("111111111111111")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("CU021");
		   			cstmt = conn.prepareCall(arr_sql[12].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			 	if(dSets[i].getName().equals("111111111111111")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("SY006");
		   			cstmt = conn.prepareCall(arr_sql[13].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
                if(dSets[i].getName().equals("111111111111111")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("RV003");
		   			cstmt = conn.prepareCall(arr_sql[14].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}  
                if(dSets[i].getName().equals("codeDs6")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("RV014");
		   			cstmt = conn.prepareCall(arr_sql[15].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}	 
                if((dSets[i].getName().equals("ds_time")) && dsType!=2 && dsType==3){ //Ȩ>����>���԰���>���԰�ȹ>New���뿬���(�ο�)
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
			   		//StringUtil.printMsg(" sSaupSid== ",sSaupSid,this);
			   		//StringUtil.printMsg(" sDepartDate== ",sDepartDate,this);
		   			GauceDataSet ds1 = gis.read("S_DEPART_TIME_DS_NEW");
		   			//StringUtil.printMsg(" sDepartDate== ",arr_sql[18].toString(),this);
		   			cstmt = conn.prepareCall(arr_sql[18].toString());
		   			cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
			   	}
			 }
		    //StringUtil.printMsg(" try       ","  try"    ,this);
		    //gos.close();
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
   
   // ��ȸ method
   public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
   }

   public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
   }
}
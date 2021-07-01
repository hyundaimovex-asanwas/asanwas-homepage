package sales.menu.rm;

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

public class Rm030I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      /**
       * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ�
       **/
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();
      //�����
      arr_sql[0].append ("SELECT                               \n")
                .append ("   SAUP_SID,                         \n")
                .append ("   SAUP_NM                           \n")
                .append ("FROM SALES.TSY200                    \n")
                .append ("ORDER BY SAUP_SID                    \n");

      //������
      arr_sql[1].append ("SELECT                               \n")
                .append ("   0 UPJANG_SID, '��ü' UPJANG_NM    \n")
                .append ("FROM DUAL               \n")
                .append ("UNION ALL                            \n")
                .append ("SELECT                               \n")
                .append ("   UPJANG_SID,                       \n")
                .append ("   UPJANG_NM                         \n")
                .append ("FROM SALES.TRM010                    \n")
                .append ("WHERE UPJANG_TYPE = '10'             \n")
                .append ("  AND USE_YN        = 'Y'            \n");

      //���ǵ��
      arr_sql[2].append ("SELECT                                        \n")
                .append ("       HEAD,                                  \n")
                .append ("       DETAIL,                                \n")
                .append ("       DETAIL_NM                              \n")
                .append ("  FROM SALES.TSY010                           \n")
                .append (" WHERE HEAD  = 'RM012'                        \n")
                .append ("   AND ITEM1 = 'Y'                            \n");

      //�����ڵ� �Է½� ���� ��ȸ
      arr_sql[3].append ("SELECT                                        				\n")
                .append ("        T1.UPJANG_SID                                  		\n")
                .append ("       ,T1.UPJANG_NM		                                 	\n")
                .append ("       ,'$1' ROOM_GRADE_CD                                 	\n")
                .append ("       ,SALES.FN_DETAIL_NM ( 'RM012', '$1') AS ROOM_GRADE_NM 	\n")
                .append ("       ,'$2' BED_TYPE_CD	                                 	\n")
                .append ("       ,SALES.FN_DETAIL_NM ( 'RM003', '$2') AS BED_TYPE_NM	\n")
                .append ("  FROM SALES.TRM010 T1                           				\n")
                .append (" WHERE T1.UPJANG_CD  = ?                        				\n");

      //����Ÿ������ ��ȸ
      arr_sql[4].append ("SELECT 																			\n")
				.append ("     T1.ROOM_TYPE_SID         /* ����Ÿ�� SID  */                               \n")
				.append ("    ,T1.UPJANG_SID            /* ���� SID      */                               \n")
				.append ("    ,T1.ROOM_GRADE_CD         /* ���ǵ���ڵ�  */                               \n")
				.append ("    ,T1.BED_TYPE_CD           /* ���Ÿ��      */                               \n")
				.append ("    ,T1.ROOM_TYPE_CD          /* ����Ÿ��      */                               \n")
				.append ("    ,T1.ROOM_TYPE_NM          /* ����Ÿ�Ը�    */                               \n")
				.append ("    ,T1.PYUNG                 /* ����          */                               \n")
				.append ("    ,T1.STD_PERSONS           /* �ּ��ο�      */                               \n")
				.append ("    ,T1.MAX_PERSONS           /* �ִ��ο�      */                               \n")
				.append ("    ,T1.DISPLAY_SEQ           /* ȭ��ǥ�ü���  */                               \n")
				.append ("    ,CASE WHEN T1.USE_YN='Y' THEN 'T' ELSE 'F' END USE_YN /* ��뿩��      */   \n")
				.append ("    ,SALES.FN_DETAIL_NM ( 'RM012',T1.ROOM_GRADE_CD) AS ROOM_GRADE_NM            \n")
				.append ("    ,SALES.FN_DETAIL_NM ( 'RM003',T1.BED_TYPE_CD)   AS BED_TYPE_NM              \n")
				.append ("    ,T2.UPJANG_NM             /* �����        */                               \n")
				.append ("FROM SALES.TRM030 T1 LEFT OUTER JOIN  SALES.TRM010 T2                           \n")
				.append ("		ON  T1.UPJANG_SID  = T2.UPJANG_SID                                      \n")
				.append ("WHERE 1 = 1																	\n");

      //�������� �Է�
      arr_sql[5].append ("INSERT INTO SALES.TRM030                                                                                                                        \n")
                .append ("       (ROOM_TYPE_SID,UPJANG_SID, ROOM_GRADE_CD, BED_TYPE_CD, ROOM_TYPE_CD, ROOM_TYPE_NM, PYUNG, STD_PERSONS, MAX_PERSONS, DISPLAY_SEQ, USE_YN, U_EMPNO,U_IP) \n")
                .append ("VALUES ((SELECT COALESCE(MAX(ROOM_TYPE_SID), 0) + 1 FROM SALES.TRM030),?, ?, ?, ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?, ?)                                                                                              \n");

      //�������� ����
      arr_sql[6].append(" UPDATE SALES.TRM030                           \n")
                .append("    SET                                        \n")
                .append("        UPJANG_SID     =  ?,                   \n")
                .append("        ROOM_GRADE_CD  =  ?,                   \n")
                .append("        BED_TYPE_CD    =  ?,                   \n")
                .append("        ROOM_TYPE_CD   =  ?,                   \n")
                .append("        ROOM_TYPE_NM   =  ?,                   \n")
                .append("        PYUNG          =  ?,                   \n")
                .append("        STD_PERSONS    =  ?,                   \n")
                .append("        MAX_PERSONS    =  ?,                   \n")
                .append("        DISPLAY_SEQ    =  ?,                   \n")
                .append("        USE_YN         =  ?,                   \n")
                .append("        U_EMPNO        =  ?,                   \n")
                .append("        U_DATE         =  SYSTIMESTAMP,   \n")
                .append("        U_IP           =  ?                    \n")
                .append("  WHERE ROOM_TYPE_SID  =  ?                    \n");

      //�������� ����
      arr_sql[7].append ("DELETE FROM SALES.TRM030 WHERE ROOM_TYPE_SID = ?   \n");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
      /* DataSet */
      CallableStatement cstmt = null;
      ResultSet rs = null;

      int dsType        = HDUtil.nullCheckNum(greq.getParameter("dsType"));
      String sSaupSid   = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));

      try{
    	GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
	    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
	    GauceDataSet[] dSets = gis.readAllOutput(); 
	    
	    	for(int i=0; i<dSets.length;i++){
	    		if(dSets[i].getName().equals("ds1")){//������
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		arr_sql[4].append("		 AND ROOM_TYPE_SID = 999999      						\n");
		    		cstmt = conn.prepareCall(arr_sql[4].toString());
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
	    		}
	    	}
	    }catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	
	}

   // ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
      /*****************************************************************************
       * Gauce Object ����
       *****************************************************************************/
      //System.out.println("# Command : ��ȸ");

      CallableStatement cstmt = null;
      ResultSet rs = null;
      try {
         // �˻��� ����
         int    v_saup_sid    = HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
         int    v_upjang_sid  = HDUtil.nullCheckNum(greq.getParameter("v_upjang_sid"));
         String  v_room_type_cd   = HDUtil.nullCheckStr(greq.getParameter("v_room_type_cd"));
         String  v_room_type_nm   = HDUtil.nullCheckStr(greq.getParameter("v_room_type_nm"));

         // dataset ���� param
         int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

         GauceInputStream gis = greq.getGauceInputStream();
		 GauceOutputStream gos = gres.getGauceOutputStream();
		 //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		 GauceDataSet[] dSets = gis.readAllOutput();
			
		 for(int j=0; j<dSets.length;j++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[j].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		int sCnt1 = 1;
                     if (v_saup_sid!=0)
                         arr_sql[4].append (" AND T2.SAUP_SID = ? \n");
                     if (v_upjang_sid!=0)
                         arr_sql[4].append (" AND T1.UPJANG_SID = ? \n");
                     if (!"".equals(v_room_type_cd))
                         arr_sql[4].append (" AND T1.ROOM_TYPE_CD = ? \n");
                     if (!"".equals(v_room_type_nm))
                         arr_sql[4].append (" AND T1.ROOM_TYPE_NM LIKE ? \n");
                     
                     cstmt = conn.prepareCall(arr_sql[4].toString()); 
	                     
                     if (v_saup_sid!=0)
                    	 cstmt.setInt(sCnt1++, v_saup_sid);
                     if (v_upjang_sid!=0)
                    	 cstmt.setInt(sCnt1++, v_upjang_sid);
                     if (!"".equals(v_room_type_cd))
                    	 cstmt.setString(sCnt1++, v_room_type_cd);
                     if (!"".equals(v_room_type_nm))
                    	 cstmt.setString(sCnt1++, v_room_type_nm+"%");

                     rs = cstmt.executeQuery(); 
			   		 gos.write(getDataSet(rs, ds1));// DataSet set
                     if(rs!=null) rs.close();
                     if(cstmt!=null) cstmt.close();
                     
	                 //�����ڵ� ��ȸ�� ���� SID, ���ǵ���ڵ�, ����Ÿ���� ������.
                  } else if(dSets[j].getName().equals("ds_temp")){
  		    			GauceDataSet ds1 = gis.read("TEMP");
                    	 String temp = arr_sql[3].toString();
                    	 temp = StringUtil.strReplace(temp, "$1", v_room_type_cd.substring(2, 4));
                    	 temp = StringUtil.strReplace(temp, "$2", v_room_type_cd.substring(4));

                    	 cstmt = conn.prepareCall(temp); 
                    	 cstmt.setString(1, v_room_type_cd.substring(0, 2));
                    	 
                    	 rs = cstmt.executeQuery(); 
    			   		 gos.write(getDataSet(rs, ds1));// DataSet set
	                     
    			   		 if(rs!=null) rs.close();
	                     if(cstmt!=null) cstmt.close();
                     }

                     break;
               }
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
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
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
      CallableStatement cstmt = null;	
	  ResultSet 		rs 			= null;

	  GauceInputStream gis = greq.getGauceInputStream();
	  GauceOutputStream gos = gres.getGauceOutputStream();
		
	  /* DataSet */
	  GauceDataSet inputDs = gis.read("DEFAULT");
		
      /**
       * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ�
       **/
      String iParamEmpno = fParamEmpno;
      String iParamIp = fParamIp;
      try{
         if(inputDs!=null){
            GauceDataRow[]       rows = inputDs.getDataRows();
            GauceDataColumn[]    cols = inputDs.getDataColumns();

            for(int i=0; i<rows.length; i++){
               int j=1;
               switch(rows[i].getJobType()){
               case GauceDataRow.TB_JOB_INSERT:
            	  cstmt = conn.prepareCall(arr_sql[5].toString());
                  
                  for(j=1; j<10; j++){
                	  if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
							cstmt.setInt(j, rows[i].getInt(j));
					  else
							cstmt.setString(j, rows[i].getString(j).trim());
                  }

                  if (  rows[i].getString(j).equals("T") ) {
                     cstmt.setString(j++, "Y");
                  } else {
                     cstmt.setString(j++, "N");
                  }

                  cstmt.setString(j++, iParamEmpno);
                  cstmt.setString(j++, iParamIp);

                  cstmt.executeUpdate();
                  if(cstmt!=null) cstmt.close();
                  break;
                  //�������� ����
               case GauceDataRow.TB_JOB_UPDATE:
            	  cstmt = conn.prepareCall(arr_sql[6].toString());
                  
                  for(j=1; j<10; j++){
                	  if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
							cstmt.setInt(j, rows[i].getInt(j));
					  else
							cstmt.setString(j, rows[i].getString(j).trim());
                  }

                  if (  rows[i].getString(j).equals("T") ) {
                     cstmt.setString(j++, "Y");
                  } else {
                     cstmt.setString(j++, "N");
                  }
                  cstmt.setString(j++, iParamEmpno);
                  cstmt.setString(j++, iParamIp);
                  cstmt.setInt(j++, rows[i].getInt(0));

                  cstmt.executeUpdate();
 				  if(cstmt!=null) cstmt.close();
                  break;
               case GauceDataRow.TB_JOB_DELETE:
            	  cstmt = conn.prepareCall(arr_sql[7].toString());
                  
                  cstmt.setInt(1, rows[i].getInt(0));
                  cstmt.executeUpdate();
                  if(cstmt!=null) cstmt.close();
                  break;
               }
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
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
	}
}

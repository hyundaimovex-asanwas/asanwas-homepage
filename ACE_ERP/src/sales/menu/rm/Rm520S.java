package sales.menu.rm;

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

public class Rm520S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      /**
       * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
       **/
       String iParamEmpno = fParamEmpno;
       String iParamIp = fParamIp;

      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();
      //블럭상태
      arr_sql[0].append ("SELECT                               \n")
                .append ("   ' ' DETAIL, '전체' DETAIL_NM       \n")
                .append ("FROM DUAL                \n")
                .append ("UNION ALL                            \n")
                .append ("SELECT                               \n")
                .append ("      DETAIL,                 \n")
                .append ("      DETAIL DETAIL_NM                 \n")
                .append ("FROM SALES.TSY010            \n")
                .append ("WHERE HEAD    =  'RM010'      \n")
                .append ("   AND rtrim(DETAIL)  >  ' '                  \n")
                .append ("   AND ITEM1   =  'Y'                  \n");

      //블록조회
      arr_sql[1].append ("SELECT                                                               \n")
               .append ("         R1.BLOCK_NO,                                                                            \n")
               .append ("         SALES.FN_GOODS_NM(R1.GOODS_SID,           '') AS GOODS_NM,           \n")
               .append ("         DEPART_DATE,                                                                                        \n")
               .append ("         SALES.FN_CLIENT_NM(R1.CLIENT_SID,         '') AS CLIENT_NM,                       \n")
               .append ("         SALES.FN_ROOM_TYPE_NM(R2.A_ROOM_TYPE_SID, '') AS A_ROOM_TYPE_NM,     \n")
               .append ("         R2.A_ROOM_CNT,                                                                                      \n")
               .append ("         R2.ACCEPT_PERSONS,                                                                               \n")
               .append ("         R1.GROUP_NM,                                                                                           \n")
               .append ("         R2.A_REMARKS,                                                                                          \n")
               .append ("         R2.BLOCK_STATUS_CD,                                                                              \n")
               .append ("         SALES.FN_ROOM_TYPE_NM(C_ROOM_TYPE_SID, '')   AS C_ROOM_TYPE_NM,          \n")
               .append ("         C_ROOM_CNT,                                                                                                 \n")
               .append ("         CONFIRM_PERSONS,                                                                                         \n")
               .append ("         TL_DATE,                                                                                                          \n")
               .append ("         PLAN_PAY_DATE,                                                                                                    \n")
               .append ("         CUST_RATE_TYPE,                                                                                             \n")
               .append ("         DEPOSIT_RATE,                                                                                               \n")
               .append ("         DEPOSIT_AMT,                                                                                                \n")
               .append ("         ACTUAL_PERSONS,                                                                                                                              \n")
               .append ("         ROUND(TO_NUMBER(ACTUAL_PERSONS)/TO_NUMBER(CONFIRM_PERSONS) * 100, 0) AS ACTUAL_RATE,                       \n")
               .append ("         C_REMARKS                                                                                                                             \n")
               .append ("FROM SALES.TRM070 R1 JOIN                                                                                                           \n")
               .append ("      SALES.TRM071 R2                                                                                                                    \n")
               .append ("      ON R2.M_BLOCK_SID   =  R1.M_BLOCK_SID                                                                                      \n")
               .append ("WHERE    1=1                                                                                                                              \n");

   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
      //StringUtil.printMsg("# Command","선조회",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;
	
	    GauceInputStream gis = greq.getGauceInputStream();
	    GauceOutputStream gos = gres.getGauceOutputStream();
     
        ResultSetMetaData rsmd = null;
        String[] columnName = null;

      int v_rowcnt = 0;

      int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

      try{
    	  GauceDataSet[] dSets = gis.readAllOutput();
    	  
    	  for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
          	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
				    cstmt = conn.prepareCall(arr_sql[0].toString());
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

   // 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
      /*****************************************************************************
       * Gauce Object 설정
       *****************************************************************************/
      //StringUtil.printMsg("# Command","조회",this);

      /* DataBase */
    	CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
	      try {
	    	  
	    	  GauceDataSet[] dSets = gis.readAllOutput(); 
	    	  
	    	  
	         // 검색시 조건
			 String    sSalDamSid   	= HDUtil.nullCheckStr(greq.getParameter("sSalDamSid"));
	         String    sBgnDate   		= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
	         String    sEndDate   		= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			 int 	   sClientSid   	= HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
			 int 	   sGoodsSid  		= HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));
	         String    sBlockStatusCd   = HDUtil.nullCheckStr(greq.getParameter("sBlockStatusCd"));
	         String    sAcceptBgnDate   = HDUtil.nullCheckStr(greq.getParameter("sAcceptBgnDate"));
	         String    sAcceptEndDate   = HDUtil.nullCheckStr(greq.getParameter("sAcceptEndDate"));
	         String    sQTypeCd   		= HDUtil.nullCheckStr(greq.getParameter("sQTypeCd"));
	         String    sQTypeStr   		= HDUtil.nullCheckStr(greq.getParameter("sQTypeStr"));
	         String    sTlBgnDate 	    = HDUtil.nullCheckStr(greq.getParameter("sTlBgnDate"));
	         String    sTlEndDate   	= HDUtil.nullCheckStr(greq.getParameter("sTlEndDate"));
	         String    sBlockNo		   	= HDUtil.nullCheckStr(greq.getParameter("sBlockNo"));
			 String    sCfBgnDate	    = HDUtil.nullCheckStr(greq.getParameter("sCfBgnDate"));
			 String    sCfEndDate  		= HDUtil.nullCheckStr(greq.getParameter("sCfEndDate"));
			 String    sResultsYn		= HDUtil.nullCheckStr(greq.getParameter("sResultsYn"));
			int 	   sSaupSid  		= HDUtil.nullCheckNum(greq.getParameter("sSaupSid")); 	
			
		/*
		 StringUtil.printMsg("sSalDamSid",sSalDamSid,this);
		 StringUtil.printMsg("sBgnDate",sBgnDate,this);
         StringUtil.printMsg("sEndDate",sEndDate,this);
         StringUtil.printMsg("sGoodssid",sGoodsSid,this);
		 StringUtil.printMsg("sClientSid",sClientSid,this);
		 StringUtil.printMsg("sBlockStatusCd",sBlockStatusCd,this);
		 StringUtil.printMsg("sAcceptBgnDate",sAcceptBgnDate,this);
		 StringUtil.printMsg("sAcceptEndDate",sAcceptEndDate,this);
		 StringUtil.printMsg("sQTypeCd",sQTypeCd,this);
		 StringUtil.printMsg("sQTypeStr",sQTypeStr,this);
		 StringUtil.printMsg("sTlBgnDate",sTlBgnDate,this);
		 StringUtil.printMsg("sTlEndDate",sTlEndDate,this);
		 StringUtil.printMsg("sBlockNo",sBlockNo,this);
		 StringUtil.printMsg("sCfBgnDate",sTlBgnDate,this);
		 StringUtil.printMsg("sCfEndDate",sTlEndDate,this);
		 StringUtil.printMsg("sResultsYn",sResultsYn,this);
		 */

         // dataset 구분 param
         int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

         for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
         	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					    cstmt = conn.prepareCall("{call SALES.PR_RM520S_01N(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?  ,?,?,?) }");
						cstmt.setInt(1, Integer.parseInt(sSalDamSid));
                        cstmt.setString (2, sBgnDate);
                        cstmt.setString (3, sEndDate);
						cstmt.setInt(4, sGoodsSid);
						cstmt.setInt(5, sClientSid);
                        cstmt.setString (6, sBlockStatusCd);
                        cstmt.setString (7, sAcceptBgnDate);
                        cstmt.setString (8, sAcceptEndDate);
                        cstmt.setString (9, sQTypeCd);
                        cstmt.setString (10, sQTypeStr);
                        cstmt.setString (11, sTlBgnDate);
                        cstmt.setString (12, sTlEndDate);
                        cstmt.setString (13, sBlockNo);
						cstmt.setString (14, sCfBgnDate);
						cstmt.setString (15, sCfEndDate);
						cstmt.setString (16, sResultsYn);
						cstmt.setInt(17, sSaupSid);
						cstmt.registerOutParameter(18, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(18);	//커서 OUT param. 					
						gos.write(getDataSet(rs, ds1));
						
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
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

   /**
    * 기능 :
    * @param req
    * @param res
    * @param dsNum = 1
    *
    */
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
   }
}
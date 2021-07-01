package sales.menu.sy;


import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

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

public class Sy120I extends SuperServlet {

    public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call SALES.PR_SY120I_01(?) }" );

      //Main 저장
      arr_sql[1].append ("{call SALES.PR_SY120I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

   }

   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
   }

   // 조회 method
   public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      /* DataBase */
      GauceDataSet ds1 = null;
      CallableStatement cstmt = null;
//      PreparedStatement stmt = null;
      ResultSet rs = null;
      try {
         // 검색시 조건
         String    v_msg_cd      = HDUtil.nullCheckStr(req.getParameter("v_msg_cd"));

         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();
            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               res.enableFirstRow(ds1);
               if (gauceName.equals("Main")) {
                  cstmt = conn.prepareCall(arr_sql[0].toString());
                  cstmt.setString(1, v_msg_cd);

                  rs = cstmt.executeQuery(); // DataSet set

                  getDataSet(rs, ds1).flush();
               }
            }

            if(rs!=null) rs.close();
            if(cstmt!=null) cstmt.close();
         }
      } catch (SQLException sqle){
         res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
         throw sqle;
      } catch (Exception e) {
         res.writeException("ERROR", "", e.toString());
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
    *
    */
   public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
      CallableStatement cstmt = null;
      GauceDataSet ds1 = null;
      GauceDataSet dsResult = req.getGauceDataSet("RESULT");
     

      try{
          String    v_msg_cd      = HDUtil.nullCheckStr(req.getParameter("v_msg_cd"));

		  //메시지처리
         if(dsResult!=null){
            res.enableFirstRow(dsResult);
            dsResult.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
            dsResult.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
            dsResult.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
         }

         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();
            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               GauceDataRow[]       rows = ds1.getDataRows();

               if(gauceName.equals("Main")){
                  for(int i=0; i<rows.length; i++){
                      String pEditStatus = "";
                     
                	  if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
                		  pEditStatus = "1";
                      if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
                    	  pEditStatus = "2";
                      if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
                    	  pEditStatus = "3";
                      
                      //switch(rows[i].getJobType()){
                        //case GauceDataRow.TB_JOB_INSERT:
                        //case GauceDataRow.TB_JOB_DELETE:
                        //case GauceDataRow.TB_JOB_UPDATE:
                           cstmt = conn.prepareCall(arr_sql[1].toString());
                           
                           StringUtil.printMsg("pEditStatus", pEditStatus, this);
                           
                           //StringUtil.printMsg("cstmt.getInt(PS_MSG_CD)", cstmt.getInt("ps_msg_cd"), this);

                            cstmt.setString(1, 	      rows[i].getString(ds1.indexOfColumn("S_MSG_CD")));
							cstmt.setString(2, 		  rows[i].getString(ds1.indexOfColumn("S_MSG")));
							
							cstmt.setString(3,        rows[i].getString(ds1.indexOfColumn("S_S_YN")).equals("T") ? "Y" : "N");
							cstmt.setString(4,        rows[i].getString(ds1.indexOfColumn("WEB_MSG")));
							cstmt.setString(5,        rows[i].getString(ds1.indexOfColumn("WEB_S_YN")).equals("T") ? "Y" : "N");
							cstmt.setString(6,        rows[i].getString(ds1.indexOfColumn("REMARKS")));
							cstmt.setString(7,        fParamEmpno);
							cstmt.setString(8,        fParamIp);
							cstmt.setString(9,        pEditStatus);

                           cstmt.registerOutParameter(10,   java.sql.Types.VARCHAR);
                           cstmt.registerOutParameter(11,   java.sql.Types.VARCHAR);
                           cstmt.registerOutParameter(12,  	java.sql.Types.VARCHAR);

                           cstmt.executeUpdate();

                           String r_s_yn      = cstmt.getString(10);
                           String r_msg_cd    = cstmt.getString(11);
                           String r_msg       = cstmt.getString(12);

                           if(!r_s_yn.equals("Y"))
                              throw new Exception(r_msg);

                           if(dsResult!=null){
                              GauceDataRow row1 = dsResult.newDataRow();
                              row1.addColumnValue(r_s_yn);
                              row1.addColumnValue(r_msg_cd);
                              row1.addColumnValue(r_msg);

                              dsResult.addDataRow(row1);
                           }
                           if(cstmt!=null) cstmt.close();

                           //break;
                     //}//switch(rows[i].getJobType()) the end...                     
                  }//for(int i=0; i<rows.length; i++) the end...
               }//if(gauceName.equals("Main")) the end...               
            }//if(ds1!=null) the end...
         }
         if(dsResult!=null) dsResult.flush();
      } catch (SQLException sqle){
         throw sqle;
      } finally {
         if(cstmt!=null) cstmt.close();
      }
   }  
}

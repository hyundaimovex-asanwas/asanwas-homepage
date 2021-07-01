
package sales.menu.rv;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
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
import sales.common.SuperServlet;
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

public class Rv512S extends SuperServlet {

   String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;

    public void makeSql(){
      /**
       * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
       **/
       String iParamEmpno = fParamEmpno;
       String iParamIp = fParamIp;

      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      arr_sql[0].append (" SELECT                            \n")
        .append ("   T1.CLIENT_SID,                  \n")
        .append ("   T1.CLIENT_DAM_NM,                  \n")
        .append ("   T1.TEL_NO                      \n")
        .append("   FROM SALES.TCU030   T1      \n");

   }

   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      //StringUtil.printMsg("# Command","선조회",this);

      /* DataSet */
      GauceDataSet ds1 = null;
      GauceStatement stmt = null;
      ResultSet rs = null;
      ResultSetMetaData rsmd = null;
      String[] columnName = null;

      int v_rowcnt = 0;

      int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

      try{
         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();

            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               switch(dsType){
                  case 1:
                     res.enableFirstRow(ds1);
                     if(gauceName.equals("IMAGE")){
                        ds1.addDataColumn(new GauceDataColumn("REQ_NO", GauceDataColumn.TB_STRING));
                        ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
                        ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
                        //StringUtil.printMsg("IMAGE","HEAD CREATE",this);
                        ds1.flush();
                     }
                     if(gauceName.equals("CLIENTINFO")){
                        //StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
                        stmt = conn.getGauceStatement(arr_sql[0].toString());

                        rs = stmt.executeQuery(); // DataSet set
                        getDataSet(rs, ds1).flush();
                     }
                     break;
               }
            }
         }
      } catch (Exception e) {
         res.writeException("ERROR", "", e.toString());
         throw e;
      } finally {
         if(rs!=null) rs.close();
         if(stmt!=null) stmt.close();
      }

   }

   // 조회 method
   public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      /*****************************************************************************
       * Gauce Object 설정
       *****************************************************************************/
      //StringUtil.printMsg("# Command","조회",this);

      /* DataBase */
      GauceDataSet ds1 = null;
      GauceDataSet ds2 = null;
      GauceDataSet ds3 = null;
      GauceDataSet ds4 = null;
      GauceDataSet imgDs = null;
      CallableStatement cstmt = null;
      GauceStatement stmt = null;
      ResultSet rs = null;
      ResultSetMetaData rsmd = null;
      String[] columnName = null;
      try {
         // 검색시 조건
         int       sSalDamSid    = HDUtil.nullCheckNum(req.getParameter("sSalDamSid"));
         int       sClientSid    = HDUtil.nullCheckNum(req.getParameter("sClientSid"));
         String    sStatusCd     = HDUtil.nullCheckStr(req.getParameter("sStatusCd"));
         String    sBgnDate      = HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
         String    sEndDate      = HDUtil.nullCheckStr(req.getParameter("sEndDate"));
         String    sAcceptNo     = HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
         String    sCustNm       = HDUtil.nullCheckStr(req.getParameter("sCustNm"));
		 String    sJobType      = HDUtil.nullCheckStr(req.getParameter("sJobType"));
		 String    sDpBgnDate    = HDUtil.nullCheckStr(req.getParameter("sDpBgnDate"));
		 String    sDpEndDate    = HDUtil.nullCheckStr(req.getParameter("sDpEndDate"));
		 int       sSaup_sid     = HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));
		 int       sGoods_sid    = HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));
         
         // dataset 구분 param
         int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

            ds1 = req.getGauceDataSet("DS1");
 
            if(ds1!=null){
                 res.enableFirstRow(ds1);

                 cstmt = conn.prepareCall("{call SALES.PR_RV512S_01(?,?,?,?,?,  ?,?,?,?,?,  ?,?) }");

                 cstmt.setInt(1, sSalDamSid);
                 cstmt.setInt(2, sClientSid);
                 cstmt.setString(3, sStatusCd);
                 cstmt.setString(4, sBgnDate);
                 cstmt.setString(5, sEndDate);
                 cstmt.setString(6, sAcceptNo);
                 cstmt.setString(7, sCustNm);
				 cstmt.setString(8, sJobType);
				 cstmt.setString(9, sDpBgnDate);
				 cstmt.setString(10, sDpEndDate);
				 cstmt.setInt(11, sSaup_sid);
				 cstmt.setInt(12, sGoods_sid);
                 

                 rs = cstmt.executeQuery(); // DataSet set
				
				 getDataSet(rs, ds1).flush();	                     

            }

      } catch (SQLException sqle){
         res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
         throw sqle;
      } catch (Exception e) {
         res.writeException("ERROR", "", e.toString());
         throw e;
      } finally {
         if(rs!=null) rs.close();
         if(stmt!=null) stmt.close();
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
   public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

   }
}

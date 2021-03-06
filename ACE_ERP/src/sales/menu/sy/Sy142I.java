package sales.menu.sy;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
public class Sy142I extends SuperServlet {

    public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call SALES.PR_SY142I_01(?,?) }" ); //
	  arr_sql[1].append ("{call SALES.PR_SY142I_02(?,?) }" );	//권한요청 테이블 검색
	}

   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
   }

   // 조회 method
   public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      /* DataBase */
      GauceDataSet ds1 = null;
      CallableStatement cstmt = null;
      ResultSet rs = null;
	
      try {
        // 검색시 조건
		String sEmpno	=	HDUtil.nullCheckStr(req.getParameter("sEmpno"));
		String sEMPNMK	=	HDUtil.nullCheckStr(req.getParameter("sEMPNMK")); 	
		
        Iterator it = req.getGauceDataSetKeys();
        while(it.hasNext()){
            String gauceName = (String)it.next();
            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               res.enableFirstRow(ds1);
               if (gauceName.equals("Main")) {
                  cstmt = conn.prepareCall(arr_sql[0].toString());
				  cstmt.setString(1,sEmpno);
				  cstmt.setString(2,sEMPNMK);				  
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
      CallableStatement cstmt = null;
      GauceDataSet ds1 = null;
      GauceDataSet dsResult = req.getGauceDataSet("RESULT");
     
	
      try{

         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();
            ds1 = req.getGauceDataSet(gauceName);
			//StringUtil.printMsg("이름?", gauceName, this);

            if(ds1!=null){
               GauceDataRow[]       rows = ds1.getDataRows();

               if(gauceName.equals("DS1")){
                  for(int i=0; i<rows.length; i++){
					  if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE){
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt   (1, rows[i].getInt(ds1.indexOfColumn("TREE_IDX")) );
						cstmt.setString(2, rows[i].getString(ds1.indexOfColumn("U_EMPNO")) );
						
						cstmt.executeUpdate();                     
                      }
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

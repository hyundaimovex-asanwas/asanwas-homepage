/*사용하지 않음
 * 2013-11-20 
 * sales 쪽에서 config로 옮겨간 메뉴
 * 
 * 사용하지 않음
 *  
 *  프로시저들도 SALES에서 COMMON 스키마로 이동
 * */



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
public class Sy140I extends SuperServlet {

    public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call SALES.PR_SY140I_01(?) }" ); //
	  arr_sql[1].append ("{call SALES.PR_SY140I_03(?) }" );	//권한요청 테이블 검색
	  arr_sql[2].append ("{call SALES.PR_SY140I_02(?,?,?,?,?,?,?,?) }" );
	  
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

         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();
            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               res.enableFirstRow(ds1);
               if (gauceName.equals("Main")) {
                  cstmt = conn.prepareCall(arr_sql[0].toString());
				  cstmt.setString(1,fParamEmpno);
                  rs = cstmt.executeQuery(); // DataSet set

                  getDataSet(rs, ds1).flush();
               }

			   if (gauceName.equals("Sub")) {
				  cstmt = conn.prepareCall(arr_sql[1].toString());
				  cstmt.setString(1,fParamEmpno);
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
			StringUtil.printMsg("이름?", gauceName, this);

            if(ds1!=null){
               GauceDataRow[]       rows = ds1.getDataRows();

               if(gauceName.equals("DS2")){
                  for(int i=0; i<rows.length; i++){
                      String pEditStatus = "";
                     
                	  if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
                		  pEditStatus = "1";
                      if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
                    	  pEditStatus = "2";
                      if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
                    	  pEditStatus = "3";
                      
                           cstmt = conn.prepareCall(arr_sql[2].toString());
                           
					//StringUtil.printMsg("상태", rows[i].getString(ds1.indexOfColumn("AUTH_RQ")), this);
					//StringUtil.printMsg("인덱스", rows[i].getString(ds1.indexOfColumn("TREE_IDX")), this);
					//StringUtil.printMsg("로그인 사용자", fParamEmpno, this);
					//StringUtil.printMsg("요청날짜", rows[i].getString(ds1.indexOfColumn("U_DATE")), this);
					//StringUtil.printMsg("pEditStatus", rows[i].getJobType(), this);

                            cstmt.setString(1, 	      rows[i].getString(ds1.indexOfColumn("AUTH_RQ")) );
							cstmt.setString(2, 		  rows[i].getString(ds1.indexOfColumn("TREE_IDX")) );
							cstmt.setString(3,        fParamEmpno);
							cstmt.setString(4,        rows[i].getString(ds1.indexOfColumn("U_DATE")));
							cstmt.setString(5,        pEditStatus);
							cstmt.registerOutParameter(6,   java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(7,   java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(8,  	java.sql.Types.VARCHAR);

                           cstmt.executeUpdate();
					//StringUtil.printMsg("요기?", "기본 쿼리 실행 끝", this);
                           String r_s_yn      = cstmt.getString(6);
                           String r_msg_cd    = cstmt.getString(7);
                           String r_msg       = cstmt.getString(8);

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
					//StringUtil.printMsg("아니면 여기?", "결과값 리턴", this);
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

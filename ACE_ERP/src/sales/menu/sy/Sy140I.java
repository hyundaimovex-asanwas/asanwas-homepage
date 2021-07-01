/*������� ����
 * 2013-11-20 
 * sales �ʿ��� config�� �Űܰ� �޴�
 * 
 * ������� ����
 *  
 *  ���ν����鵵 SALES���� COMMON ��Ű���� �̵�
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

      //Main ��ȸ
      arr_sql[0].append ("{call SALES.PR_SY140I_01(?) }" ); //
	  arr_sql[1].append ("{call SALES.PR_SY140I_03(?) }" );	//���ѿ�û ���̺� �˻�
	  arr_sql[2].append ("{call SALES.PR_SY140I_02(?,?,?,?,?,?,?,?) }" );
	  
   }

   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
   }

   // ��ȸ method
   public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      /* DataBase */
      GauceDataSet ds1 = null;
      CallableStatement cstmt = null;
      ResultSet rs = null;
      try {
         // �˻��� ����

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
    * ��� :
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
			StringUtil.printMsg("�̸�?", gauceName, this);

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
                           
					//StringUtil.printMsg("����", rows[i].getString(ds1.indexOfColumn("AUTH_RQ")), this);
					//StringUtil.printMsg("�ε���", rows[i].getString(ds1.indexOfColumn("TREE_IDX")), this);
					//StringUtil.printMsg("�α��� �����", fParamEmpno, this);
					//StringUtil.printMsg("��û��¥", rows[i].getString(ds1.indexOfColumn("U_DATE")), this);
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
					//StringUtil.printMsg("���?", "�⺻ ���� ���� ��", this);
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
					//StringUtil.printMsg("�ƴϸ� ����?", "����� ����", this);
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

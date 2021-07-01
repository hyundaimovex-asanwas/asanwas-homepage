/*
 * 2013-11-20 
 * sales �ʿ��� config�� �Űܿ� �޴�
 * 
 * */

package config.menu.sy;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
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

import sales.common.HDUtil;
import sales.common.StringUtil;
import config.common.SuperServlet;

public class Sy141I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main ��ȸ
      arr_sql[0].append ("{call COMMON.PR_SY141I_01(?,?, ?) }" ); //
	  arr_sql[1].append ("{call COMMON.PR_SY141I_02(?,?,?) }" );	//���ѿ�û ���̺� �˻�
	  
   }

   public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
   }

   // ��ȸ method
   public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
           GauceInputStream gis = greq.getGauceInputStream();
           GauceOutputStream gos = gres.getGauceOutputStream();

           //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
           GauceDataSet[] dSets = gis.readAllOutput(); 
           
           // �˻��� ����
           String sEmpno  = HDUtil.nullCheckStr(greq.getParameter("sEmpno"));
           String sStatus = HDUtil.nullCheckStr(greq.getParameter("sStatus"));
           //StringUtil.printMsg(" sEmpno===",sEmpno,this);
           //StringUtil.printMsg(" sStatus===",sStatus,this);
           
           for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//JSP(O:Main=ds1)",
        	   if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("Main");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					  cstmt.setString(1,sEmpno);
					  cstmt.setString(2,sStatus);				  
					  // ���ν����� ���� ���� ���ν�����.. ���� ���� ������.. ���...;;;
					  cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					  cstmt.executeQuery();
					  rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					
					  gos.write(getDataSet(rs, ds1));
				}
           	

           }

         
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

   /**
    * ��� :
    * @param req
    * @param res
    *
    */
   public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
     
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
       
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet dsResult = gis.read("RESULT");
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();      

				int colNm_TreeIdx 		        = ds1.indexOfColumn("TREE_IDX");
				int colNm_Uempno                = ds1.indexOfColumn("U_EMPNO");

				
				for(int i=0; i<rows.length; i++){
					
				
					//StringUtil.printMsg("ds1�� "+i+"�� �۾�===",rows[i].getJobType(),this);
					StringUtil.printMsg("TREE_IDX", rows[i].getInt(ds1.indexOfColumn("TREE_IDX")), this);
					StringUtil.printMsg("U_EMPNO", rows[i].getString(ds1.indexOfColumn("U_EMPNO")), this);
					
			
	                if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE){
						//StringUtil.printMsg("call","COMMON.PR_141I_02-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, "3");
						cstmt.setInt   (2, rows[i].getInt(colNm_TreeIdx) );
						cstmt.setString(3, rows[i].getString(colNm_Uempno) );
						cstmt.executeUpdate();
	                }
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE){
						//StringUtil.printMsg("call","COMMON.PR_141I_02-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, "2");
						cstmt.setInt   (2, rows[i].getInt(colNm_TreeIdx) );
						cstmt.setString(3, rows[i].getString(colNm_Uempno) );
						cstmt.executeUpdate();
					}                      
                           
				}//for(int i=0; i<rows.length; i++) the end...
			}//if(ds1!=null) the end...

		} catch (SQLException sqle){
         throw sqle;
		} finally {
         if(cstmt!=null) cstmt.close();
		}
   	}  
}


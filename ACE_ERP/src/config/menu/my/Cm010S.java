package config.menu.my;

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

public class Cm010S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call COMMON.PR_CMU010S_01(?) }" ); //
	  
   }

   public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
   }

   // 조회 method
   public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

       GauceInputStream gis = greq.getGauceInputStream();
       GauceOutputStream gos = gres.getGauceOutputStream();
      try {
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
          GauceDataSet[] dSets = gis.readAllOutput(); 

          for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//"JSP(O:Main=ds1,O:Sub=ds2)",
          	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
			}
            if(rs!=null) rs.close();
            if(cstmt!=null) cstmt.close();
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
    * 기능 :
    * @param req
    * @param res
    *
    */
   public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	   
   }  
}
	

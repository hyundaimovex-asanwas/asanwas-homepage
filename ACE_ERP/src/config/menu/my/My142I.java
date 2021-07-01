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


public class My142I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call COMMON.PR_SY142I_01(?,?, ?) }" ); //
      arr_sql[1].append ("{call COMMON.PR_SY142I_02(?,?,?) }" ); //      
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
        // 검색시 조건
		String sEmpno	=	HDUtil.nullCheckStr(greq.getParameter("sEmpno"));
		String sEMPNMK	=	HDUtil.nullCheckStr(greq.getParameter("sEMPNMK")); 	
		//StringUtil.printMsg("sEmpno",sEmpno,this);		
        //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
        GauceDataSet[] dSets = gis.readAllOutput(); 
        
        
        for(int i=0; i<dSets.length;i++){
			//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
			//O:Main=ds1
        	if(dSets[i].getName().equals("ds1")){
				GauceDataSet ds1 = gis.read("Main");
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setString(1,sEmpno);
				cstmt.setString(2,sEMPNMK);				  
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
				cstmt.executeQuery();
				rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
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

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
       
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");	//		I:DS1=ds1
		
		//StringUtil.printMsg("로그인 사용자 찍자~", fParamEmpno, this);
		//StringUtil.printMsg("로그인 사용자 IP~", fParamIp, this);
		

		try{
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				int colNm_PGM_IDX	= ds1.indexOfColumn("PGM_IDX");
				int colNm_FAVYN		= ds1.indexOfColumn("FAV_YN");
				
				for(int i=0; i<rows.length; i++){
					
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
		
						cstmt = conn.prepareCall(arr_sql[1].toString());
						//StringUtil.printMsg("# Command","업데이트",this);
						//StringUtil.printMsg("# colNm_PGM_IDX",rows[i].getInt(colNm_PGM_IDX),this);
						//StringUtil.printMsg("# colNm_FAVYN", rows[i].getString(colNm_FAVYN),this);
						cstmt.setInt(1, rows[i].getInt(colNm_PGM_IDX));
						cstmt.setString(2, rows[i].getString(colNm_FAVYN));
						cstmt.setString(3,fParamEmpno);				//사용자
						cstmt.execute();
						if(cstmt!=null) cstmt.close();
						break;
					}
				}
				
			}
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} finally {
			if(cstmt!=null) cstmt.close();
		}		
   }  
}

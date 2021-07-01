package sales.menu.rm;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.sql.CallableStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.*;
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


public class Rm210B extends SuperServlet {

	public void makeSql(){
	  /**
	   * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
	   **/
	  for(int i=0; i<arr_sql.length; i++)
		 arr_sql[i] = new StringBuffer();
	  //사업소
	  arr_sql[0].append ("SELECT                               \n")
				.append ("   SAUP_SID,                         \n")
				.append ("   SAUP_NM                           \n")
				.append ("FROM SALES.TSY200                    \n")
				.append ("ORDER BY SAUP_SID                    \n");

	  //영업장
	  arr_sql[1].append ("SELECT                               \n")
				.append ("   0 UPJANG_SID, '전체' UPJANG_NM    \n")
				.append ("FROM SYSIBM.SYSDUMMY1                \n")
				.append ("UNION ALL                            \n")
				.append ("SELECT                               \n")
				.append ("   UPJANG_SID,                       \n")
				.append ("   UPJANG_NM                         \n")
				.append ("FROM SALES.TRM010                    \n")
				.append ("WHERE UPJANG_TYPE = '10'             \n")
				.append ("  AND USE_YN        = 'Y'            \n");


	  //호텔별 시즌생성 조회 프로시저 CALL
	  arr_sql[2].append("CALL SALES.PR_RM210B_01(?,?)");
	  //호텔별 시즌생성 저장 프로시저 CALL
	  arr_sql[3].append("CALL SALES.PR_RM210B_02(?,?,?,?,?)");
   }

   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	  /* DataSet */
   }

   // 조회 method
   public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	  /*****************************************************************************
	   * Gauce Object 설정
	   *****************************************************************************/
	  //System.out.println("# Command : 조회");
	  //StringUtil.printMsg("select진입 ","select 진입",this);
	  /* DataBase */
	  GauceDataSet 			ds1			= null;
	  GauceStatement 		stmt 		= null;
	  ResultSet 			rs 			= null;
	  ResultSetMetaData 	rsmd 		= null;
	  String[] 				columnName 	= null;
	  CallableStatement cstmt;
		
	  int v_rowcnt = 0;
		
	  try {
		 // 검색시 조건
		 int    v_saup_sid    = HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
		 int    v_upjang_sid  = HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		 // dataset 구분 param
		 int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

		 Iterator it = req.getGauceDataSetKeys();
		 while(it.hasNext()){
			String gauceName = (String)it.next();
			ds1 = req.getGauceDataSet(gauceName);

			if(ds1!=null){
						res.enableFirstRow(ds1);
							if(gauceName.equals("DEFAULT")){
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setInt(1,v_saup_sid);
							cstmt.setInt(2, v_upjang_sid);
							
							rs = cstmt.executeQuery();			
							}
						getDataSet(rs, ds1).flush();
			}
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
				
		CallableStatement cstmt = null;
		boolean fail=false;			
		ResultSet 			rs 			= null;
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno  = fParamEmpno;
		String iParamIp 	= fParamIp;
		GauceDataSet ds1	= req.getGauceDataSet("DEFAULT");
		
		try{
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_SaupSid 		= ds1.indexOfColumn("SAUP_SID");				
				int colNm_UpjangSid 	= ds1.indexOfColumn("UPJANG_SID");	
				int colNm_UseYn 		= ds1.indexOfColumn("USE_YN");			
				int colNm_BgnDate 		= ds1.indexOfColumn("BGN_DATE");	
				int colNm_EndDate 		= ds1.indexOfColumn("END_DATE");
							
				/*StringUtil.printMsg("colNm_SaupSid",colNm_SaupSid,this);
				StringUtil.printMsg("colNm_UpjangSid",colNm_UpjangSid,this);
				StringUtil.printMsg("colNm_UseYn",colNm_UseYn,this);
				StringUtil.printMsg("colNm_BgnDate",colNm_BgnDate,this);
				StringUtil.printMsg("colNm_EndDate",colNm_EndDate,this);*/
				
				
				
				for(int i=0; i<rows.length; i++){
					if ( rows[i].getString(3).equals("T") ) {
						 cstmt = conn.prepareCall(arr_sql[3].toString());
						/*StringUtil.printMsg("rows[i].getInt(colNm_SaupSid)", rows[i].getInt(colNm_SaupSid),this);
						StringUtil.printMsg("rows[i].getInt(colNm_UpjangSid)",rows[i].getInt(colNm_UpjangSid),this);
						StringUtil.printMsg("rows[i].getString(colNm_UseYn)", rows[i].getString(colNm_UseYn),this);
						StringUtil.printMsg("rows[i].getString(colNm_BgnDate)",rows[i].getString(colNm_BgnDate) ,this);
						StringUtil.printMsg("rows[i].getString(colNm_EndDate)",rows[i].getString(colNm_EndDate),this);*/
						
						 cstmt.setInt	(1, rows[i].getInt(colNm_SaupSid));
						 cstmt.setInt	(2, rows[i].getInt(colNm_UpjangSid));
						 cstmt.setString(3, rows[i].getString(colNm_UseYn));
						 cstmt.setString(4, rows[i].getString(colNm_BgnDate));
						 cstmt.setString(5, rows[i].getString(colNm_EndDate));
								 		
						 cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
					}
				}
			}
		}
		 catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}
}

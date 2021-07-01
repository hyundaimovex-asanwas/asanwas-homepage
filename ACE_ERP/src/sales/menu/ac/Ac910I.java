package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
  
public class Ac910I extends SuperServlet {
	                                       
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC910I_01(?,?)"); // 조회1
		
		arr_sql[2].append("CALL SALES.PR_AC910I_02(?,?)"); // 조회2
		
		arr_sql[3].append("CALL SALES.PR_AC910I_03(?,?,?,?,?, ?,?,?)");	// 저장
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String sFr_date 	= HDUtil.nullCheckStr(req.getParameter("sFr_date"));	// 시작일자
		String sTo_date 	= HDUtil.nullCheckStr(req.getParameter("sTo_date")); 	// 종료일자
		
		StringUtil.printMsg("시작일자",sFr_date+"",this);
		StringUtil.printMsg("종료일자",sTo_date+"",this);
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				//StringUtil.printMsg("이름 ", "---"+gauceName+"===" ,this);
				ds1 = req.getGauceDataSet(gauceName);
				
				if ("DS1".equals(gauceName)) {
					if(ds1!=null){
						switch(dsType){
							case 1:
								res.enableFirstRow(ds1);
								
								cstmt = conn.prepareCall(arr_sql[1].toString());
								cstmt.setString(1,sFr_date);
								cstmt.setString(2,sTo_date);
								rs = cstmt.executeQuery();							
								
								getDataSet(rs, ds1).flush();
								break;
							case 2:
								break;
							case 3:
								break;
						}
					}
				} else if ("DS2".equals(gauceName)){
					if(ds1!=null){
						switch(dsType){
							case 1:
								res.enableFirstRow(ds1);
								
								cstmt = conn.prepareCall(arr_sql[2].toString());
								cstmt.setString(1,sFr_date);
								cstmt.setString(2,sTo_date);
								rs = cstmt.executeQuery();							
								
								getDataSet(rs, ds1).flush();
								break;
							case 2:
								break;
							case 3:
								break;
						}
					}					
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
//		String sCaln_date 	= HDUtil.nullCheckStr(req.getParameter("sCaln_date"));	// 출경일자
//		String sClose_yn 	= HDUtil.nullCheckStr(req.getParameter("sClose_yn"));	// 마감여부
//		StringUtil.printMsg("출경일자",sCaln_date+"",this);
//		StringUtil.printMsg("마감여부",sClose_yn+"",this);
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
//		if (iParamIp.length() > 13) {
//			 iParamIp = "AC900I IP".substring(0,13);	
//		}
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						int colNm_CalnDate    = ds1.indexOfColumn("DEPART_DATE");
						int colNm_GoodsSid    = ds1.indexOfColumn("GOODS_SID");
						int colNm_CloseYn	  = ds1.indexOfColumn("CLOSE_YN");

						//StringUtil.printMsg("출발일",colNm_CalnDate+"",this);
						//StringUtil.printMsg("상품",colNm_GoodsSid+"",this);
						//StringUtil.printMsg("마감여부",colNm_CloseYn+"",this);
						
						
						 
						for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								
								cstmt = conn.prepareCall(arr_sql[3].toString());
								
								//StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
								
								cstmt.setString(1, rows[i].getString(colNm_CalnDate));
								cstmt.setInt(2, rows[i].getInt(colNm_GoodsSid));
								cstmt.setString(3, rows[i].getString(colNm_CloseYn));
								cstmt.setString(4, iParamEmpno);
								cstmt.setString(5, iParamIp);
								cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
								// 쿼리실행
								cstmt.executeUpdate();
								
								break;
							}
						}
					}
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}
}

package sales.menu.cq;

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

import common.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cq740I extends SuperServlet {
	 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ740I_01(?,?,?)"); // 조회
		
		arr_sql[2].append("CALL SALES.PR_CQ740I_02(?,?,?,?,?,?,?)");	// 저장
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String sFr_date 	= HDUtil.nullCheckStr(greq.getParameter("sFr_date"));	// 시작일자
		String sTo_date 	= HDUtil.nullCheckStr(greq.getParameter("sTo_date")); 	// 종료일자
		
		//StringUtil.printMsg("시작일자",sFr_date+"",this);
		//StringUtil.printMsg("종료일자",sTo_date+"",this);
		
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DEFAULT=ds_main, O:DETAIL=ds_detail
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					switch(dsType){
						case 1:
							//res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setString(1,sFr_date);
							cstmt.setString(2,sTo_date);
							cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
							gos.write(getDataSet(rs, ds1));
							break;
						case 2:
							break;
						case 3:
							break;
					}
				}
			}
		} catch (SQLException sqle){
//			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
//			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
//		String sCaln_date 	= HDUtil.nullCheckStr(req.getParameter("sCaln_date"));	// 출경일자
//		String sClose_yn 	= HDUtil.nullCheckStr(req.getParameter("sClose_yn"));	// 마감여부
//		StringUtil.printMsg("출경일자",sCaln_date+"",this);
//		StringUtil.printMsg("마감여부",sClose_yn+"",this);
		
		
		try {
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
												
				int colNm_CalnDate    = ds1.indexOfColumn("CALN_DATE");
				int colNm_CloseYn	  = ds1.indexOfColumn("CLOSE_YN");
				
				for(int i=0; i<rows.length; i++){
				switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						
						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						//StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
						
						cstmt.setString(1, rows[i].getString(colNm_CalnDate));
						cstmt.setString(2, rows[i].getString(colNm_CloseYn));
						cstmt.setString(3, iParamEmpno);
						cstmt.setString(4, iParamIp);
						cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
						// 쿼리실행
						cstmt.executeUpdate();
						
						break;
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}

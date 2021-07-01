package common;


import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;


public class Cm010I extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//메뉴 트리 만들기
        arr_sql[0].append ("{CALL COMMON.PR_CM010S_01()}");	//전체조회용
        
        arr_sql[1].append ("{CALL COMMON.PR_CM010S_03()}");	//관광조회용
        
        arr_sql[2].append ("{CALL COMMON.PR_CM010S_04( ?, ?, ? )}");	//타이틀 리턴용.
				      
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","조회",this);
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		//StringUtil.printMsg("로그인 사용자", fParamEmpno, this);
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				String menu_nm = "";
				String full_dir_nm = "";
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){	//메뉴트리 부를 때

						cstmt = conn.prepareCall(arr_sql[0].toString());

						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}

					if(gauceName.equals("TITLE")){		//타이틀 부를 때
						int tree_idx = HDUtil.nullCheckNum(req.getParameter("tree_idx"));
						res.enableFirstRow(ds1);
						ds1.addDataColumn(new GauceDataColumn("MENU_NM", GauceDataColumn.TB_STRING));
						ds1.addDataColumn(new GauceDataColumn("FULL_DIR_NM", GauceDataColumn.TB_STRING));
						
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);	//메뉴명
						cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);	//풀 경로명
						cstmt.setInt	          (3, tree_idx);				//인덱스
						cstmt.executeUpdate();
						
						menu_nm 		= cstmt.getString(1);
						full_dir_nm 	= cstmt.getString(2);
						
						//StringUtil.printMsg("메뉴명", menu_nm, this);
						//StringUtil.printMsg("풀 경로명", full_dir_nm, this);
						
						GauceDataRow row1 = ds1.newDataRow();
						row1.addColumnValue(menu_nm);
						row1.addColumnValue(full_dir_nm);
						
						ds1.addDataRow(row1);		//데이터셋에 결과행 추가!

						if(cstmt!=null) cstmt.close();
						if(ds1!=null)
							ds1.flush();
						
					}					
				}
			}		
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DS1");
		GauceStatement stmt = null;

		int menu_idx = HDUtil.nullCheckNum(req.getParameter("menu_idx"));
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){

				int colNm_PGM_IDX				= inputDs.indexOfColumn("PGM_IDX");
				int colNm_SEQ					= inputDs.indexOfColumn("SEQ");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						
						StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);		
						stmt = conn.getGauceStatement(arr_sql[5].toString());
						stmt.setGauceDataRow(rows[i]);
						
						/*stmt.bindColumn(j++, colNm_RoomNo);
						stmt.bindColumn(j++, colNm_BgnDate);
						stmt.bindColumn(j++, colNm_EndDate);
						stmt.bindColumn(j++, colNm_RoomView_cd);
						stmt.bindColumn(j++, colNm_Floors);*/
						/*
						if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							stmt.setString(j++, "Y");
						} else {
							stmt.setString(j++, "N");							
						}
						stmt.bindColumn(j++, colNm_UpjangSid);
						stmt.bindColumn(j++, colNm_RoomTypeSid);
						stmt.bindColumn(j++, colNm_DongSid);
						stmt.bindColumn(j++, colNm_Remarks);						
						stmt.setString(j++, iParamEmpno);
						stmt.setString(j++, iParamIp);*/						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
						//객실정보 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);						
						stmt = conn.getGauceStatement(arr_sql[4].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_SEQ);
						stmt.bindColumn(j++, colNm_PGM_IDX);
						/*if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							stmt.setString(j++, "Y");
						} else {
							stmt.setString(j++, "N");							
						}						*/
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:

						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);						
						stmt = conn.getGauceStatement(arr_sql[5].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_PGM_IDX);
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;						
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(stmt!=null) stmt.close();
		}
	}

}

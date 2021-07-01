package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv770S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
        
        //경찰청 (내국인) 출력
        arr_sql[0].append ("{call SALES.PR_RV770S_01(?, ?)}");
        
        //경찰청(영주권) 출력
        arr_sql[1].append ("{call SALES.PR_RV770S_02(?, ?)}");
        
        //법무부 출력
        arr_sql[2].append ("{call SALES.PR_RV770S_03(?, ?)}");
        
        //통일부 조회
        arr_sql[3].append ("{call SALES.PR_RV770S_04(?, ?, ?)}");
        
        
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String v_depart_date 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date"));
		String v_gubn		 	= HDUtil.nullCheckStr(req.getParameter("v_gubn"));
		int     v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));	//지역구분 추가
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, v_depart_date);
					cstmt.setString(2, v_gubn);
					cstmt.setInt   (3, v_saup_sid);
					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();

					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
				}
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");

		String v_depart_date 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date"));
		String v_gubn		 	= HDUtil.nullCheckStr(req.getParameter("v_gubn"));
		String v_file_name 		= "";
		int     v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));	//지역구분 추가		

		try{
			
			if(v_gubn.equals("1"))
				v_file_name = "Police_in_"+v_depart_date;
			else if(v_gubn.equals("2"))
				v_file_name = "Police_out_"+v_depart_date;
			else if(v_gubn.equals("3"))
				v_file_name = "Police_raw_"+v_depart_date;
			else
				throw new Exception("텍스트 파일 출력양식이 아닙니다.");
			
			if(v_saup_sid==1)
				v_file_name = "KG_" + v_file_name;
			else if (v_saup_sid==2)
				v_file_name = "KS_" + v_file_name;
			
			
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("FILE_NAME", GauceDataColumn.TB_STRING));
			}

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null && gauceName.equals("DEFAULT")){
					res.enableFirstRow(ds1);
					if(v_gubn.equals("1"))
						cstmt = conn.prepareCall(arr_sql[0].toString());
					else if(v_gubn.equals("2"))
						cstmt = conn.prepareCall(arr_sql[1].toString());
					else if(v_gubn.equals("3"))
						cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_depart_date);
					cstmt.setInt   (2, v_saup_sid);
					rs = cstmt.executeQuery();
					
					String getFileName = getDataFileMakeNew(rs, HDConstant.FILE_UPLOAD_PATH_POLICE, v_file_name);
					//StringUtil.printMsg("getFileName", getFileName, this);

					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(getFileName);
						
						ds_result.addDataRow(row1);
					}
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
				}
			}
			if(ds_result!=null) ds_result.flush();
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		
	}
	
}

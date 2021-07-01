package sales.menu.ac;

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

public class Ac810B extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
        
        //매입자료 조회
        arr_sql[0].append ("{ CALL SALES.PR_AC810B_02 (?, ?) }");
        
        //매입자료 생성
        arr_sql[1].append ("{ CALL SALES.PR_AC810B_01 (?, ?, ?, ?, ?, ?, ?) }");
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		//상품권 리스트에 필요한 입력 파라미터 정의
		String v_fr_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
		String v_to_date 	= HDUtil.nullCheckStr(req.getParameter("v_to_date"));

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
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

		//상품권 리스트에 필요한 입력 파라미터 정의
		String v_fr_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
		String v_to_date 	= HDUtil.nullCheckStr(req.getParameter("v_to_date"));

		try{
			//메시지처리
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("FILE_NAME", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null && gauceName.equals("DEFAULT")){
					res.enableFirstRow(ds1);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					
					rs = cstmt.executeQuery();
					
					String r_s_yn		= cstmt.getString(5);
					String r_msg_cd	 	= cstmt.getString(6);
					String r_msg		= cstmt.getString(7);

StringUtil.printMsg("r_s_yn", r_s_yn, this);
StringUtil.printMsg("r_msg_cd", r_msg_cd, this);
StringUtil.printMsg("r_msg", r_msg, this);

					String getFileName = getDataFileMake(rs, HDConstant.FILE_UPLOAD_PATH_CARD, "HDASAN_SND_20060803");
StringUtil.printMsg("getFileName", getFileName, this);

					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(getFileName);
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
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

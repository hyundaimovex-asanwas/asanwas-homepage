package sales.menu.cq;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

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

public class Cq550S_05 extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		//조회 및 생성
		arr_sql[0].append("{CALL SALES.PR_CQ550S_05(?, ?, ?, ?, ?, ?)}");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet 		  rs 	= null;
		GauceDataSet 	  ds1 	= null; 

		int     v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));		//NIGHTS INFO
		String	v_depart_date 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date"));		//SEASON INFO
		String	v_depart_time 	= HDUtil.nullCheckStr(req.getParameter("v_depart_time"));		//SEASON INFO
		int     v_goods_sid		= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));		//NIGHTS INFO

		int v_cnt = 1;
		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(v_cnt++, v_saup_sid);
				cstmt.setString	(v_cnt++, v_depart_date);
				cstmt.setString	(v_cnt++, v_depart_time);
				cstmt.setInt	(v_cnt++, v_goods_sid);
				cstmt.setString	(v_cnt++, fParamEmpno);
				cstmt.setString (v_cnt++, fParamIp);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds1).flush();
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet 		  rs 	= null;
		GauceDataSet 	  ds1 	= null; 
		GauceDataSet 	  ds_result 	= null; 

		int     v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));		//NIGHTS INFO
		String	v_depart_date 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date"));		//SEASON INFO
		String	v_depart_time 	= HDUtil.nullCheckStr(req.getParameter("v_depart_time"));		//SEASON INFO
		int     v_goods_sid		= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));		//NIGHTS INFO

	    java.util.Calendar date = java.util.Calendar.getInstance();
	    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	    String v_today = m_today.format(date.getTime());

	    int v_cnt = 1;
		try {
			ds1 		= req.getGauceDataSet("MASTER");
			ds_result 	= req.getGauceDataSet("RESULT");
			
			//메시지처리
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("FILE_NAME", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(ds1!=null){
				res.enableFirstRow(ds1);
			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(v_cnt++, v_saup_sid);
				cstmt.setString	(v_cnt++, v_depart_date);
				cstmt.setString	(v_cnt++, v_depart_time);
				cstmt.setInt	(v_cnt++, v_goods_sid);
				cstmt.setString	(v_cnt++, fParamEmpno);
				cstmt.setString (v_cnt++, fParamIp);
				
				rs = cstmt.executeQuery();

				String getFileName = getDataFileNew(rs, HDConstant.FILE_UPLOAD_PATH_POLICE+v_today, "POLICE_RAW_"+v_today);
//StringUtil.printMsg("getFileName", getFileName, this);

				if(ds_result!=null){
					GauceDataRow row1 = ds_result.newDataRow();
					row1.addColumnValue(getFileName);
					row1.addColumnValue("Y");
					row1.addColumnValue("0000");
					row1.addColumnValue("");
					
					ds_result.addDataRow(row1);
				}
			}
			if(ds_result!=null) ds_result.flush();
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

    /**
     * @param rs
     * @param dirPath
     * @param makeFileName
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public String getDataFileNew(ResultSet rs, String dirPath, String makeFileName) throws ServletException, Exception{
    	int v_cnt = 1;
    	
    	String makeFile = dirPath+ File.separator + makeFileName;
    	
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[] = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 
		
		for (int i = 0; i < columnName.length; i++) 
			columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
		
		PrintWriter log;
		File dirFile = new File(dirPath);

StringUtil.printMsg("dirPath", dirPath, this);
StringUtil.printMsg("makeFileName", makeFileName, this);

		if(!dirFile.exists()){
			dirFile.mkdir(); 
		}
		
		log = new PrintWriter(new FileWriter(makeFile, false), true);
        
		while(rs.next()) {
			if(v_cnt==1){
				log.print("H");
				log.print(StringUtil.rPad(rs.getString("JOB_TIME"), 13, ' '));		//자료생성일시
				log.print(StringUtil.rPad(rs.getString("PRT_NO"), 10, ' '));			//관리번호
				log.print(StringUtil.rPad(rs.getString("GOODS_ENG_NM"), 8, ' '));	//항차
				log.print(StringUtil.rPad(rs.getString("GOODS_NM"), 21, ' '));		//상품명
				log.print(StringUtil.rPad(rs.getString("DEPART_DATE1"), 9, ' '));	//출경일
				log.print(StringUtil.rPad(rs.getString("ARRIVE_DATE1"), 9, ' '));	//입경일
				log.println(StringUtil.rPad("", 229, ' '));						//Remark
			}
			
			log.print("D");
			log.print(StringUtil.lPad(v_cnt+"", 5, '0'));							//일련번호
			log.print(StringUtil.rPad(rs.getString("MANAGE_NO"), 13, ' '));			//관리번호
			log.print(StringUtil.rPad(rs.getString("UNITY_NO"), 13, ' '));			//통일부번호
			log.print(StringUtil.rPad(rs.getString("DEPART_DATE"), 8, ' '));		//출발일자
			log.print(StringUtil.rPad(rs.getString("ARRIVE_DATE"), 8, ' '));		//도착일자
			log.print(StringUtil.rPad(rs.getString("IN_OUT_GU"), 1, ' '));			//입출항구분
			log.print(StringUtil.rPad(rs.getString("CUST_NM"), 39, ' '));			//성명
			log.print(StringUtil.rPad(rs.getString("BIRTHDAY"), 8, ' '));			//생년월일
			log.print(StringUtil.rPad(rs.getString("REGI_NO"), 13, ' '));			//주민번호
			log.print(StringUtil.rPad(rs.getString("OLD_UNITY_NO"), 8, ' '));		//구 통일부넘버
			log.print(StringUtil.rPad(rs.getString("SEX"), 1, ' '));				//성별
			log.print(StringUtil.rPad(rs.getString("COUNTRY_CD"), 3, ' '));			//국적코드
			log.print(StringUtil.rPad(rs.getString("PASS_NO"), 13, ' '));			//여권번호
			log.print(StringUtil.rPad(rs.getString("ADDRESS1").trim(), 50, ' '));	//주소
			log.print(StringUtil.rPad(rs.getString("TEL_NO").trim(), 20, ' '));		//전화번호
			log.print("  ");														//직종코드
			log.print(StringUtil.rPad(rs.getString("COMPANY_NM").trim(), 30, ' '));		//직장명
			log.print("Y");															//방북허가여부
			log.print("  ");														//여행목적코드
			log.print(StringUtil.rPad(rs.getString("JOB_OBJ"), 20, ' '));			//여행목적 서술
			log.print(StringUtil.rPad(rs.getString("START_GU"), 20, ' '));			//출발지
			log.print(StringUtil.rPad(rs.getString("END_GU"), 20, ' '));			//도착지
			log.println(StringUtil.rPad(rs.getString("PROCE_GU"), 1, ' '));			//처리구분
				
			v_cnt++;
		}
		
		log.print("T");
		if(v_cnt>0)
			log.print(StringUtil.lPad(--v_cnt+"", 8, '0'));
		else
			log.print(StringUtil.lPad(v_cnt+"", 8, '0'));
		log.println(StringUtil.rPad("", 291,' '));
		
		if(log!=null) log.close();
		
		return makeFileName;
    }
}

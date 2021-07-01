package pms.menu.cc;

//	si110i_h1 사용

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

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cc130S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//처리자별 [처리]내역 조회
		arr_sql[0].append ("{call PMS.PR_CC130S_01(?,?,?,?) }" );

		//계정별 법카 거래내역
		arr_sql[1].append ("{call PMS.PR_CC130S_02(?,?,?) }" );

		//카드별 거래내역
		arr_sql[2].append ("{call PMS.PR_CC130S_03(?,?,?) }" );
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("초기화~!","",this);


		

		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//String iParamEmpno 		= fParamEmpno;
		String v_empno	 		= HDUtil.nullCheckStr(greq.getParameter("v_empno"));			//처리자 사번
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//조회기간
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//조회기간
		String v_fsdat	        = HDUtil.nullCheckStr(greq.getParameter("v_fsdat"));      	    // 접수일자
		String v_fsnbr	        = HDUtil.nullCheckStr(greq.getParameter("v_fsnbr"));      	    // 접수번호

		//내부 변수
		//String r_s_yn		= null;
		//String r_msg_cd		= null;
		//String r_msg		= null;
		
		//StringUtil.printMsg("v_empno",v_empno,this);
		//StringUtil.printMsg("v_fdcode",v_fdcode,this);
		//StringUtil.printMsg("v_fsdat",v_fsdat,this);
		//StringUtil.printMsg("v_fsnbr",v_fsnbr,this);
		//StringUtil.printMsg("v_frdt",v_frdt,this);
		//StringUtil.printMsg("v_todt",v_todt,this);
		//StringUtil.printMsg("v_pl_dept",v_pl_dept,this);
		
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		

            	
				if(dSets[i].getName().equals("ds_cul")){
					GauceDataSet ds1 = gis.read("DS_CUL");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_frdt);
					cstmt.setString(2, v_todt);
					cstmt.setString(3, v_empno);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_culd")){
					GauceDataSet ds1 = gis.read("DS_CULD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_fsdat);
					cstmt.setString(2, v_fsnbr);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}

            	if(dSets[i].getName().equals("ds_culd1")){
					GauceDataSet ds1 = gis.read("DS_CULD1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_fsdat);
					cstmt.setString(2, v_fsnbr);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}

            	            	
            	
        		

            }
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
}
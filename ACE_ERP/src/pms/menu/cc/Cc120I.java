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

public class Cc120I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//처리자별 [처리]내역 조회
		arr_sql[0].append ("{call PMS.PR_CC120I_01(?,?,?,?) }" );

		//전표 생성 데이터 조회 = 1:1매칭건,  공제여부=T
		arr_sql[1].append ("{call PMS.PR_CC120I_02(?,?,?,?,?,  ?,?) }" );
		
		//전표 생성 후 접수번호 업뎃할 기초데이터 조회 
		arr_sql[2].append ("{call PMS.PR_CC120I_03(?,?,?,?,?,  ?,?) }" );

		//전표 생성 데이터 조회 = 1:n 매칭 건, 공제여부=T
		arr_sql[3].append ("{call PMS.PR_CC120I_04(?,?,?,?,?,  ?,?) }" );
		
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("초기화~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds_slipdtl")){
					GauceDataSet ds1 = gis.read("DS_SLIPDTL");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "02");
					cstmt.setString(2, "A19000201");
					cstmt.setString(3, "20010101");
					cstmt.setString(4, "20010101");
					cstmt.setString(5, "6050006");
					cstmt.setString(6, "1000");
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 					
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String iParamEmpno 		= fParamEmpno;
		String v_empno	 		= HDUtil.nullCheckStr(greq.getParameter("v_empno"));			//처리자 사번
		String v_fdcode	        = HDUtil.nullCheckStr(greq.getParameter("v_fdcode"));      		// 지점
		String v_fsdat	        = HDUtil.nullCheckStr(greq.getParameter("v_fsdat"));      	    // 접수일자
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//조회기간
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//조회기간
		String v_pl_dept		= HDUtil.nullCheckStr(greq.getParameter("v_pl_dept"));			// 귀속코드
		String v_group_nm		= HDUtil.nullCheckStr(greq.getParameter("v_group_nm"));			// 그룹명
		int	   v_avgcnt			= HDUtil.nullCheckNum(greq.getParameter("v_avgcnt"));			// 매칭 갯수 평균값
		//내부 변수
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;
		
		//StringUtil.printMsg("v_empno",v_empno,this);
		//StringUtil.printMsg("v_fdcode",v_fdcode,this);
		//StringUtil.printMsg("v_fsdat",v_fsdat,this);
		//StringUtil.printMsg("v_frdt",v_frdt,this);
		//StringUtil.printMsg("v_todt",v_todt,this);
		//StringUtil.printMsg("v_group_nm",v_group_nm,this);
		
		
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
            	if(dSets[i].getName().equals("ds_slipdtl")){
					GauceDataSet ds1 = gis.read("DS_SLIPDTL");
					
					//20151207
					StringUtil.printMsg("v_group_nm",v_group_nm,this);
					//StringUtil.printMsg("v_avgcnt",v_avgcnt+"",this);
					//String[] pl_dept = v_pl_dept.split(":");
					//String v_pl_depts = "";	//프로시저 전달용 부서s 값. in 쿼리용
						//StringUtil.printMsg("pl_dept[0]",pl_dept[0],this);
						//StringUtil.printMsg("pl_dept[1]",pl_dept[1],this);
						//StringUtil.printMsg("pl_dept배열 사이즈",pl_dept.length+"",this);
					
					//3280,1220 → 이러면 숫자로 C12.PL_DEPT 컬럼이 형변환이 될것이다.
					//	''3280'',''1220'' 이런 형태로 날아가야 하는데 변수가.. 움..   라고 생각했으나
					//	'3280','1220' 으로 보내면 받네요.. 허허허허 문자열로
					//for (int j = 0; j < pl_dept.length; j++) {
					//	v_pl_depts += "'"+pl_dept[j]+"',"; // 각 배열 요소의 글자 수 합계 구하기
					//}
						//StringUtil.printMsg("v_pl_depts",v_pl_depts.substring(0, v_pl_depts.length()),this);
						//StringUtil.printMsg("v_pl_depts",v_pl_depts.substring(0, v_pl_depts.length()-1),this); //마지막 쉼표 자르기
					
					//20160108 그룹명 조건이 들어가면서 위에 복잡이가 사라짐..^^
					
					if(v_avgcnt>1){	//1보다 크면 다중 귀속정보란 이야기임..
						StringUtil.printMsg("다중 귀속 쿼리","",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setString(1, v_fdcode);
						cstmt.setString(2, v_fsdat);
						cstmt.setString(3, v_frdt);
						cstmt.setString(4, v_todt);
						cstmt.setString(5, v_empno);
						cstmt.setString(6, v_group_nm);
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					}else{
						StringUtil.printMsg("단일 귀속 쿼리","",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, v_fdcode);
						cstmt.setString(2, v_fsdat);
						cstmt.setString(3, v_frdt);
						cstmt.setString(4, v_todt);
						cstmt.setString(5, v_empno);
						cstmt.setString(6, v_group_nm);
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					}
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_cus")){
					GauceDataSet ds1 = gis.read("DS_CUS");
					
					/*String[] pl_dept = v_pl_dept.split(":");
					String v_pl_depts = "";	//프로시저 전달용 부서s 값. in 쿼리용
					for (int j = 0; j < pl_dept.length; j++) {
						v_pl_depts += "'"+pl_dept[j]+"',"; // 각 배열 요소의 글자 수 합계 구하기
					}*/
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_fdcode);
					cstmt.setString(2, v_fsdat);
					cstmt.setString(3, v_frdt);
					cstmt.setString(4, v_todt);
					cstmt.setString(5, v_empno);
					cstmt.setString(6, v_group_nm);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 					
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
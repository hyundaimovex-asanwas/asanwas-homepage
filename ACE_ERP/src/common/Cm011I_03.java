package common;



import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.ServletException;

import common.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import oracle.jdbc.OracleTypes;



public class Cm011I_03 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql(){

		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//메뉴 트리 만들기
		arr_sql[0].append ("{CALL COMMON.PR_CM010S_13(?, ?)}");	//권한 * 시스템만 - 조회용
        
        arr_sql[1].append ("{CALL COMMON.PR_CM010S_04( ?, ?, ? )}");	//타이틀 리턴용.
				      
   }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
	}	
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","조회",this);
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		//StringUtil.printMsg("로그인 사용자 찍자~", fParamEmpno, this);
		//StringUtil.printMsg("로그인 사용자 IP~", fParamIp, this);
		
		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            String paramDEPTNO = greq.getParameter("goods_cd");	//테스트 파라미터
            int tree_idx = HDUtil.nullCheckNum(greq.getParameter("tree_idx"));
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			String menu_nm = "";
			String full_dir_nm = "";
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				if(dSets[i].getName().equals("ds_tree")){	//메뉴트리 부를 때
					GauceDataSet ds1 = gis.read("DEFAULT");	//어쩐지 이곳이 수상했어 ㅠ_ㅠ.. 젝일~!!
					//StringUtil.printMsg(" ddd",ds1.getName(),this);
					//gos.fragment(ds1);
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1,fParamEmpno);				//사용자
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
				}
				
				if(dSets[i].getName().equals("ds_title")){	//제목줄 부를 때
					GauceDataSet ds1 = gis.read("TITLE");
					//gos.fragment(ds1);
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);	//메뉴명
					cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);	//풀 경로명
					cstmt.setInt	          (3, tree_idx);				//인덱스
					cstmt.executeUpdate();
					
					menu_nm 		= cstmt.getString(1);
					full_dir_nm 	= cstmt.getString(2);
					ds1.put("MENU_NM",menu_nm, 100);
					ds1.put("FULL_DIR_NM",full_dir_nm, 300);
					ds1.heap();
					gos.write(ds1);
					
					
					//StringUtil.printMsg("메뉴명", menu_nm, this);
					//StringUtil.printMsg("메뉴명", menu_nm.length(), this);
					//StringUtil.printMsg("풀 경로명", full_dir_nm, this);
					//StringUtil.printMsg("풀 경로명", full_dir_nm.length(), this);
					
					
				}				
			}
            gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

}

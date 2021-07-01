package Account.menu.tp;

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

import sales.common.HDConstant;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.HDUtil;			//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.StringUtil;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.SuperServlet;	//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로

//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
public class Tp020I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//마스터 조회
		arr_sql[0].append ("{call SALES.GPR_AC_TP020I_01(?,?,?,?,?,   ?) }" );
	
   }

	//init method
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		//System.out.println("init::");
		try {
		    GauceInputStream gis = greq.getGauceInputStream();
	        GauceOutputStream gos = gres.getGauceOutputStream();
	            
	       //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
	        GauceDataSet[] dSets = gis.readAllOutput(); 

			
	        for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default

            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "02");
						cstmt.setString(2, "A19900201");
						cstmt.setString(3, "081102");
						cstmt.setString(4, "1");
						cstmt.setString(5, "19990101");
						cstmt.setString(6, "19990101");   
						cstmt.setString(7, "6070001");   
						cstmt.setString(8, "199001");   
						
						// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
						cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//결과를 받을 커서
						
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(9);	//커서 OUT param. 					
						
						//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
						//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
						gos.write(getDataSet(rs, ds1));
					}         	
				}
		}catch (SQLException sqle){
			gres.addException(sqle);
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}	
	
	//select method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//System.out.println("select::");
		//StringUtil.printMsg("v_cost_cd",v_cost_cd,this);
		String v_fdcode	        = HDUtil.nullCheckStr(greq.getParameter("v_fdcode"));      	// 지점
		String v_fsdat	        = HDUtil.nullCheckStr(greq.getParameter("v_fsdat"));      	    // 접수일자
		String v_fr_inout_dt 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_inout_dt")); 	// 출납일자 시작
		String v_to_inout_dt	= HDUtil.nullCheckStr(greq.getParameter("v_to_inout_dt")); 	// 출납일자 종료
		String v_empno	        = HDUtil.nullCheckStr(greq.getParameter("v_empno"));      	// 작성자
		
		try {
		    GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput();

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
            	//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_slipdtl")){
					GauceDataSet ds1 = gis.read("DS_SLIPDTL");

					//System.out.println("v_fdcode::"+v_fdcode);
					//System.out.println("v_fsdat::"+v_fsdat);
					//System.out.println("v_fr_inout_dt::"+v_fr_inout_dt);
					//System.out.println("v_to_inout_dt::"+v_to_inout_dt);
					//System.out.println("v_empno::"+v_empno);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fdcode);
					cstmt.setString(2, v_fsdat);
					cstmt.setString(3, v_fr_inout_dt);
					cstmt.setString(4, v_to_inout_dt);
					cstmt.setString(5, v_empno);
					// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
			}
        	gos.close();
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
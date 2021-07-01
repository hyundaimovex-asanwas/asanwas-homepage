package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;


import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Pu030I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//트리조회
		arr_sql[0].append ("{call PMS.PR_PU030I_01(?)}");
		//자재상세조회_트리
		arr_sql[1].append ("{call PMS.PR_PU030I_02(?,?)}");
		//자재상세조회_조회검색
		arr_sql[2].append ("{call PMS.PR_PU030I_04(?,?)}");
		//자재상세조회_저장
		arr_sql[3].append ("{call PMS.PR_PU030I_03(?,?,?,?,?	,?,?,?,?) }");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  
			throws ServletException, Exception {

		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
		   		//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);			//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
			   	if(dSets[i].getName().equals("ds1")){
		   			GauceDataSet ds1 = gis.read("DS1");
		   			cstmt = conn.prepareCall(arr_sql[0].toString());
			    	// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
			    	cstmt.registerOutParameter(1, OracleTypes.CURSOR);//결과를 받을 커서					
			    	cstmt.executeQuery();
			    	rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 									
	    			//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
	    			//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
			    	gos.write(getDataSet(rs, ds1));
			   	}
		    }
		}catch (SQLException sqle){
		} catch (Exception e){
		} finally {
		}
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) 
			throws ServletException, Exception {

		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String v_code_no 	= HDUtil.nullCheckStr(greq.getParameter("v_code_no"));
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
						
			for(int i=0; i<dSets.length;i++){
			//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
			//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_code_no);
				
					// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_code_no);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}            	
			 }
			 gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)
			throws ServletException, Exception {
		
		/* 2013.10.22 심동현
		* 이렇게 TR을 호출합니다. 
		* "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		* 따라서 gis.read로 가져오면 됨.
		* */
			
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		        
		/* DataSet */
		GauceDataSet ds2 = gis.read("DS2");
				
		int fSiteSid = 0;
		
		try{
			if (ds2 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				int colNm_ITEM_NM	  		 = ds2.indexOfColumn("ITEM_NM");
				int colNm_ITEM_SIZE          = ds2.indexOfColumn("ITEM_SIZE");
				int colNm_ITEM_UNIT  		 = ds2.indexOfColumn("ITEM_UNIT");
				int colNm_TEM_KIND           = ds2.indexOfColumn("ITEM_KIND");
				int colNm_CODE_NO            = ds2.indexOfColumn("CODE_NO");
				int colNm_ITEM_SID           = ds2.indexOfColumn("ITEM_SID");
				int colNm_ITEM_NM_S	  		 = ds2.indexOfColumn("ITEM_NM_S");
				//StringUtil.printMsg("colNm_ITEM_NM",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				//StringUtil.printMsg("colNm_SiteSid",colNm_SiteSid,this);	
				//StringUtil.printMsg("colNm_SiteJoint",colNm_SiteJoint,this);
				//StringUtil.printMsg("colNm_SiteMain",colNm_SiteMain,this);
				//StringUtil.printMsg("colNm_SiteAttr1",colNm_SiteAttr1,this);
				//StringUtil.printMsg("colNm_SiteAttr2",colNm_SiteAttr2,this);
				//StringUtil.printMsg("colNm_OrdererSid",colNm_OrdererSid,this);
							
				for(int i=0; i<rows.length; i++){
					int j=1;
					//StringUtil.printMsg("ds2의 "+i+"행 작업===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						/*
						StringUtil.printMsg("call","PMS.PR_CT010i_04-INSERT",this);
						StringUtil.printMsg("colNm_SiteNm",rows[i].getString(colNm_SiteNm),this);
						StringUtil.printMsg("colNm_OrdererNm",rows[i].getString(colNm_OrdererNm),this);
						StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						StringUtil.printMsg("colNm_SiteJoint",rows[i].getString(colNm_SiteJoint),this);
						StringUtil.printMsg("colNm_SiteMain",rows[i].getString(colNm_SiteMain),this);
						StringUtil.printMsg("colNm_SiteAttr1",rows[i].getString(colNm_SiteAttr1),this);
						StringUtil.printMsg("colNm_SiteAttr2",rows[i].getString(colNm_SiteAttr2),this);
						StringUtil.printMsg("colNm_OrdererSid",rows[i].getString(colNm_OrdererSid),this);
						 */
							//StringUtil.printMsg("call","PMS.PR_030i_03-INSERT",this);				
							cstmt = conn.prepareCall(arr_sql[3].toString());
							cstmt.setString(1, rows[i].getString(colNm_ITEM_NM));
							cstmt.setString(2, rows[i].getString(colNm_ITEM_SIZE));
							cstmt.setString(3, rows[i].getString(colNm_ITEM_UNIT));
							cstmt.setString(4, rows[i].getString(colNm_TEM_KIND));					
							cstmt.setString(5, rows[i].getString(colNm_CODE_NO));
							cstmt.setString(6, iParamEmpno);
							cstmt.setString(7, "1");
							cstmt.setInt(8, rows[i].getInt(colNm_ITEM_SID));
							cstmt.setString(9, rows[i].getString(colNm_ITEM_NM_S));
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();		
					break;				
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_030i_03-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[3].toString());
							cstmt.setString(1, rows[i].getString(colNm_ITEM_NM));
							cstmt.setString(2, rows[i].getString(colNm_ITEM_SIZE));
							cstmt.setString(3, rows[i].getString(colNm_ITEM_UNIT));
							cstmt.setString(4, rows[i].getString(colNm_TEM_KIND));					
							cstmt.setString(5, rows[i].getString(colNm_CODE_NO));
							cstmt.setString(6, iParamEmpno);
							cstmt.setString(7, "3");
							cstmt.setInt(8, rows[i].getInt(colNm_ITEM_SID));
							cstmt.setString(9, rows[i].getString(colNm_ITEM_NM_S));
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
					break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_030i_03-DELETE",this);
							//StringUtil.printMsg("colNm_SiteNm",rows[i].getString(colNm_SiteNm),this);
							//StringUtil.printMsg("colNm_OrdererNm",rows[i].getString(colNm_OrdererNm),this);
							//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
							//StringUtil.printMsg("colNm_SiteJoint",rows[i].getString(colNm_SiteJoint),this);
							//StringUtil.printMsg("colNm_SiteMain",rows[i].getString(colNm_SiteMain),this);
							//StringUtil.printMsg("colNm_SiteAttr1",rows[i].getString(colNm_SiteAttr1),this);
							//StringUtil.printMsg("colNm_SiteAttr2",rows[i].getString(colNm_SiteAttr2),this);
							//StringUtil.printMsg("colNm_OrdererSid",rows[i].getString(colNm_OrdererSid),this);
							
							cstmt = conn.prepareCall(arr_sql[3].toString());
							cstmt.setString(1, rows[i].getString(colNm_ITEM_NM));
							cstmt.setString(2, rows[i].getString(colNm_ITEM_SIZE));
							cstmt.setString(3, rows[i].getString(colNm_ITEM_UNIT));
							cstmt.setString(4, rows[i].getString(colNm_TEM_KIND));					
							cstmt.setString(5, rows[i].getString(colNm_CODE_NO));
							cstmt.setString(6, iParamEmpno);
							cstmt.setString(7, "2");
							cstmt.setInt(8, rows[i].getInt(colNm_ITEM_SID));
							cstmt.setString(9, rows[i].getString(colNm_ITEM_NM_S));
				
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
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
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}

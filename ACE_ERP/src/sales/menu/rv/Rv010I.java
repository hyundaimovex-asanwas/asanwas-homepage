package sales.menu.rv;

import oracle.jdbc.OracleTypes;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceException;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;


public class Rv010I extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
    public void makeSql(){
        for(int i=0; i<arr_sql.length; i++)
           arr_sql[i] = new StringBuffer();
        
		arr_sql[0].append ("SELECT 															    \n")
				  .append ("	  R1.MENU_SID		, R1.MENU_CD 		, R1.MENU_NM            \n")
				  .append ("    , R1.MENU_GUBUN_CD 	, R1.MENU_ITEM1 	, R1.MENU_ITEM2         \n")
				  .append ("    , R1.MENU_ITEM3     , R1.MENU_ITEM4     , R1.MENU_ITEM5         \n")
				  .append ("    , R1.BGN_PERSONS 	, R1.END_PERSONS    , R1.BGN_DATE           \n")
				  .append ("    , R1.END_DATE 	    , R1.MENU_ENG_NM    , R1.MENU_SHORT_NM      \n")
				  .append ("	, CASE WHEN R1.TAX_YN='Y' THEN 'T' ELSE 'F' END TAX_YN       	\n")
				  .append ("	, R1.TAX_CALCU_CD   , R1.UNIT_AMT           					\n")
				  .append ("    , R1.NET_AMT 	    , R1.VAT_AMT 		, R1.EXCISE_AMT         \n")
				  .append ("    , R1.EDU_AMT 	    , R1.VILLAGE_AMT    , R1.SPORTS_AMT         \n")
				  .append ("    , R1.TOUR_AMT 		, R1.ASSOC_AMT	    , R1.TIP_AMT            \n")
				  .append ("    , CASE WHEN R1.USE_YN='Y' THEN 'T' ELSE 'F' END USE_YN       	\n")
				  .append ("    , R1.SAUP_SID		, R1.UPJANG_SID                             \n")
				  .append ("FROM                                                                \n")
				  .append ("	SALES.TRV100 R1                                                 \n")
				  .append ("    LEFT JOIN SALES.TRM030 R2                                       \n")
				  .append ("    ON TO_CHAR(R2.ROOM_TYPE_SID) = R1.MENU_ITEM2                    \n")
				  .append ("WHERE 1=1															\n");
		
		arr_sql[1].append ("INSERT INTO SALES.TRV100  											\n")
				  .append ("	(                                                               \n")
				  .append ("		  MENU_CD			, MENU_NM			, MENU_GUBUN_CD     \n")
				  .append ("		, MENU_ITEM1		, MENU_ITEM2		, MENU_ITEM3        \n")
				  .append ("		, MENU_ITEM4		, MENU_ITEM5		, BGN_PERSONS       \n")
				  .append ("		, END_PERSONS		, BGN_DATE			, END_DATE          \n")
				  .append ("		, MENU_ENG_NM		, MENU_SHORT_NM		, TAX_YN            \n")
				  .append ("		, TAX_CALCU_CD		, UNIT_AMT			, NET_AMT           \n")
				  .append ("		, VAT_AMT			, EXCISE_AMT		, EDU_AMT           \n")
				  .append ("		, VILLAGE_AMT		, SPORTS_AMT		, TOUR_AMT          \n")
				  .append ("		, ASSOC_AMT			, TIP_AMT			, USE_YN            \n")
				  .append ("		, SAUP_SID			, UPJANG_SID		, U_EMPNO           \n")
				  .append ("        , U_DATE			, U_IP                                  \n")
				  .append ("	)                                                               \n")
				  .append ("VALUES (                                                            \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("    CURRENT_TIMESTAMP,?                                             \n")
				  .append ("       )                                                            \n");
		
		arr_sql[2].append ("UPDATE SALES.TRV100 					\n")
				  .append ("	SET                                 \n")
				  .append ("		  MENU_CD			= ?         \n")
				  .append ("		, MENU_NM			= ?         \n")
				  .append ("		, MENU_GUBUN_CD		= ?         \n")
				  .append ("		, MENU_ITEM1		= ?         \n")
				  .append ("		, MENU_ITEM2		= ?         \n")
				  .append ("		, MENU_ITEM3		= ?         \n")
				  .append ("		, MENU_ITEM4		= ?         \n")
				  .append ("		, MENU_ITEM5		= ?         \n")
				  .append ("		, BGN_PERSONS		= ?         \n")
				  .append ("		, END_PERSONS		= ?         \n")
				  .append ("		, BGN_DATE			= ?         \n")
				  .append ("		, END_DATE          = ?         \n")
				  .append ("		, MENU_ENG_NM		= ?         \n")
				  .append ("		, MENU_SHORT_NM		= ?         \n")
				  .append ("		, TAX_YN            = ?         \n")
				  .append ("		, TAX_CALCU_CD		= ?         \n")
				  .append ("		, UNIT_AMT			= ?         \n")
				  .append ("		, NET_AMT           = ?         \n")
				  .append ("		, VAT_AMT			= ?         \n")
				  .append ("		, EXCISE_AMT		= ?         \n")
				  .append ("		, EDU_AMT           = ?         \n")
				  .append ("		, VILLAGE_AMT		= ?         \n")
				  .append ("		, SPORTS_AMT		= ?         \n")
				  .append ("		, TOUR_AMT          = ?         \n")
				  .append ("		, ASSOC_AMT			= ?         \n")
				  .append ("		, TIP_AMT			= ?         \n")
				  .append ("		, USE_YN            = ?         \n")
				  .append ("		, SAUP_SID			= ?         \n")
				  .append ("		, UPJANG_SID		= ?         \n")
				  .append ("		, U_EMPNO           = ?         \n")
				  .append ("        , U_DATE = CURRENT_TIMESTAMP    \n")
				  .append ("		, U_IP              = ?         \n")
				  .append ("WHERE MENU_SID = ?		                \n");
			
		arr_sql[3].append ("DELETE FROM SALES.TRV100 	\n")
				  .append ("WHERE MENU_SID = ?			\n");
    }
    
	// 조회 method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		StringUtil.printMsg("# Command : ","선조회",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds4")){
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[6].toString());
					//rs = (ResultSet)cstmt.getObject(10);	//프로시저 조회-커서 OUT param. 			
					//rs = cstmt.executeQuery();				//평쿼리 조회 
					//gos.write(getDataSet(rs, ds1));
					
				}
	
			}
			/*
			ds1 = req.getGauceDataSet("DEFAULT");
			if(ds1!=null){
				res.enableFirstRow(ds1);
				stmt = conn.getGauceStatement(arr_sql[0].toString());
				rs = stmt.executeQuery();
				getDataSetHead(rs, ds1).flush();
			}*/
		
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", sqle.getErrorCode()+"", sqle.getMessage())
			);
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", " ", e.toString())
			);
			throw e;
		} finally {
			gos.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
    }
    
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command : ","조회",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;

		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		// 검색시 조건
		int 	v_saup_sid		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
		int		v_upjang_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_upjang_sid"));
		int     v_room		 	= HDUtil.nullCheckNum(greq.getParameter("v_room"));	//ROOM INFO
		String	v_season	 	= HDUtil.nullCheckStr(greq.getParameter("v_season"));		//SEASON INFO
		String	v_age			= HDUtil.nullCheckStr(greq.getParameter("v_age"));			//AGE INFO		
		int     v_goods			= HDUtil.nullCheckNum(greq.getParameter("v_goods"));		//NIGHTS INFO
		String	v_date			= HDUtil.nullCheckStr(greq.getParameter("v_date"));		//date INFO

		StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
		StringUtil.printMsg("v_upjang_sid", v_upjang_sid, this);
		StringUtil.printMsg("v_room", v_room, this);
		StringUtil.printMsg("v_season", v_season, this);
		StringUtil.printMsg("v_age", v_age, this);
		StringUtil.printMsg("v_goods", v_goods, this);

		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2
				if(dSets[i].getName().equals("ds1")){
					int sCnt = 1;					
					GauceDataSet ds1 = gis.read("DS1");
					if (v_saup_sid!=0)
						arr_sql[0].append ("	AND R1.SAUP_SID = ?			\n");
					if (v_upjang_sid!=0) 
						arr_sql[0].append ("	AND R1.UPJANG_SID = ? 		\n");
					if (!"".equals(v_season))
						arr_sql[0].append ("	AND R1.MENU_ITEM1 = ? 		\n");
					if (v_room!=0)
						arr_sql[0].append ("	AND R1.MENU_ITEM2 = ? 		\n");
					if (!"".equals(v_age))
						arr_sql[0].append ("	AND R1.MENU_ITEM3 = ? 		\n");
					if (v_goods!=0)
						arr_sql[0].append ("	AND R1.MENU_ITEM4 = ? 		\n");
					if (!"".equals(v_date))
						arr_sql[0].append ("	AND ? BETWEEN R1.BGN_DATE AND R1.END_DATE	\n");	//이용일자 추가				
					//StringUtil.printMsg("arr_sql[0].toString()", arr_sql[0].toString(), this);
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
					if (v_saup_sid!=0)
						cstmt.setInt(sCnt++, v_saup_sid);
					if (v_upjang_sid!=0) 
						cstmt.setInt(sCnt++, v_upjang_sid);
					if (!"".equals(v_season))
						cstmt.setString(sCnt++, v_season);
					if (v_room!=0)
						cstmt.setInt(sCnt++, v_room);
					if (!"".equals(v_age))
						cstmt.setString(sCnt++, v_age);
					if (v_goods!=0)
						cstmt.setInt(sCnt++, v_goods);
					if (!"".equals(v_date))
						cstmt.setString(sCnt++, v_date);

					//rs = (ResultSet)cstmt.getObject(10);	//프로시저 조회-커서 OUT param. 			
					rs = cstmt.executeQuery();				//평쿼리 조회 
					gos.write(getDataSet(rs, ds1));
					
				}
			}
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", sqle.getErrorCode()+"", sqle.getMessage())
			);
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", " ", e.toString())
			);
			throw e;
		} finally {
			gos.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		

	}
	
	// 입력, 수정, 삭제

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* 2013.10.22 심동현
		 * 이렇게 TR을 호출합니다. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	따라서 gis.read로 가져오면 됨.
		 * 
		 * */
	
		StringUtil.printMsg("# Command","저장",this);
		
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
        //JSP(I:DEFAULT=ds2,O:msgDS=msgDS)
		GauceDataSet ds1 = gis.read("DS1");
	
		try {
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[]   cols = ds1.getDataColumns();
	StringUtil.printMsg("rows.length", rows.length, this);
				// Grid 첫번째 
				for(int i = 0; i < rows.length; i++) {
					// 입력 
					int j = 1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString()); 
							for(j=1; j<30; j++){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ){
									cstmt.setInt(j, rows[i].getInt(j));
								} else {
									if(j==15 || j==27)
										cstmt.setString(j, rows[i].getString(j).equals("T") ? "Y" : "N");
									else
										cstmt.setString(j, rows[i].getString(j));
								}
							}
							cstmt.setString(j++, fParamEmpno);		// 수정자 사번 
							cstmt.setString(j++, fParamIp);			// 수정자 ip
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[2].toString()); 
							for(j=1; j<30; j++){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ){
									cstmt.setInt(j, rows[i].getInt(j));
								} else {
									if(j==15 || j==27)
										cstmt.setString(j, rows[i].getString(j).equals("T") ? "Y" : "N");
									else
										cstmt.setString(j, rows[i].getString(j));
								}
							}
							cstmt.setString(j++, fParamEmpno);		// 수정자 사번 
							cstmt.setString(j++, fParamIp);			// 수정자 ip
							cstmt.setInt(j++, rows[i].getInt(0));	// 					
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString()); 
							cstmt.setInt(1, rows[i].getInt(0));
							
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
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}		
	}
}

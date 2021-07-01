package sales.menu.rv;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv710I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//사업소
		arr_sql[0].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//	출경시간	
		arr_sql[1].append ("SELECT ''                 AS DEPART_TIME,			\n")
					.append ("		'전체  '             AS DEPART_TIME_NM			\n")
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT R2.DEPART_TIME,			\n")
					.append ("		SALES.FMT_TIME(R2.DEPART_TIME) AS DEPART_TIME_NM			\n")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2			\n")
					.append ("	ON R2.GOODS_SID   = R1.GOODS_SID			\n")
					.append ("WHERE R1.SAUP_SID    = ?			\n")
					.append ("	AND R2.DEPART_DATE = ?			\n")
					.append ("GROUP BY R2.DEPART_TIME			\n");
		
		//상품
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,    ")
					.append ("		'전체  '              AS GOODS_NM    ")       
					.append ("FROM DUAL    ")
					.append ("UNION ALL    ")
					.append ("SELECT R1.GOODS_SID,    ")
					.append ("		MIN(R1.GOODS_NM)   AS GOODS_NM    ")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2    ")
					.append ("ON R2.GOODS_SID   = R1.GOODS_SID    ")
					.append ("WHERE R1.SAUP_SID    = ?    ")
					.append ("	AND R2.DEPART_DATE = ?    ")
					.append ("GROUP BY R1.GOODS_SID    ");
		
		//고객구분
		arr_sql[3].append ("SELECT										\n")
					.append ("	'' DETAIL, '전체' DETAIL_NM    \n")
					.append ("FROM DUAL                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT  					\n")
					.append ("		DETAIL,  					\n") 
					.append ("		DETAIL_NM  					\n")         
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD    =  'CU001'		\n")
					.append ("	AND DETAIL  >  ' '						\n")
					.append ("	AND ITEM1   =  'Y'   					\n");
		
		//반
		arr_sql[4].append ("SELECT ' '                 AS CLASS,			\n")          
					.append ("			'전체  '             AS CLASS_NM			\n")         
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT CLASS,			\n")
					.append ("			SALES.FN_DETAIL_NM('RV017', CLASS) AS CLASS_NM			\n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2			\n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE			\n")
					.append ("WHERE 1=1			\n");
	
		//조
		arr_sql[5].append ("SELECT ' '                 AS TEAMS,  				    \n")
					.append ("		'전체  '             AS TEAMS_NM       				    \n")
					.append ("FROM DUAL  				    \n")
					.append ("UNION ALL  				    \n")
					.append ("SELECT TEAMS              AS TEAMS,  				    \n")
					.append ("		TEAMS              AS TEAMS_NM  				    \n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2  				    \n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE  				    \n")
					.append ("WHERE 1=1				   \n");
   }

    
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		

		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
		String 	sDepartDate	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
		String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
		String 	sClass		= HDUtil.nullCheckStr(greq.getParameter("sClass"));	

		try{

            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput();
			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
                int sCnt1 = 1;
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	
            	if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);						
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	
            	if(dSets[i].getName().equals("ds4")){
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);						
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds5")){
					GauceDataSet ds1 = gis.read("DS5");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds6")){
					GauceDataSet ds1 = gis.read("DS6");
					if (!"".equals(sDepartDate)) 
						arr_sql[4].append (" AND R1.DEPART_DATE = ? \n");
					if (!"".equals(sDepartTime)) 
						arr_sql[4].append (" AND R2.DEPART_TIME = ? \n");
					arr_sql[4].append ("GROUP BY CLASS			");
				
					cstmt = conn.prepareCall(arr_sql[4].toString());
					if (!"".equals(sDepartDate))
						cstmt.setString(sCnt1++, sDepartDate);
					if (!"".equals(sDepartTime))
						cstmt.setString(sCnt1++, sDepartTime);					
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds7")){
					GauceDataSet ds1 = gis.read("DS7");
					if (!"".equals(sDepartDate)) 
						arr_sql[5].append (" AND R1.DEPART_DATE = ? \n");
					if (!"".equals(sDepartTime)) 
						arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
					if (!"".equals(sClass)) 
						arr_sql[5].append (" AND R2.CLASS = ? \n");
					arr_sql[5].append ("GROUP BY TEAMS  ORDER BY TEAMS ");
				
					cstmt = conn.prepareCall(arr_sql[5].toString());
					if (!"".equals(sDepartDate))
						cstmt.setString(sCnt1++, sDepartDate);
					if (!"".equals(sDepartTime))
						cstmt.setString(sCnt1++, sDepartTime);
					if (!"".equals(sClass))
						cstmt.setString(sCnt1++, sClass);					
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		try {
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
			String 	sCustGu	= HDUtil.nullCheckStr(greq.getParameter("sCustGu"));
			String 	sClass	= HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String 	sTeams	= HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			String 	sCustNm	= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));
			String 	sNotAssignYn	= HDUtil.nullCheckStr(greq.getParameter("sNotAssignYn"));
			String 	sAcceptNo	= HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));			
			//StringUtil.printMsg(" 조는? ","^"+sTeams+"*",this);
			//널체크에서 공란은 ''로 ^^
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall("{call SALES.NPR_RV710I_01(?,?,?,?,?, ?,?,?,?,?,  ?) }");							
					cstmt.setString(1, sBgnDate);
					cstmt.setString(2, sDepartTime);
					cstmt.setInt(3, Integer.parseInt(sSaupSid));
					cstmt.setInt(4, Integer.parseInt(sGoodsSid));
					cstmt.setString(5, sCustGu);
					cstmt.setString(6, sClass);
					cstmt.setString(7, sTeams);
					cstmt.setString(8, sCustNm);
					cstmt.setString(9, sNotAssignYn);
					cstmt.setString(10, sAcceptNo);
					
					cstmt.registerOutParameter(11, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(11);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
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


	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
//		StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;

		boolean fail=false;			
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet DEFAULT=ds1,O:msgDS=msgDS*/
		GauceDataSet inputDs = gis.read("DEFAULT");
		GauceDataSet msgDS = gis.read("msgDS");
		
		try{
			
			if(inputDs!=null){
				
				int colNm_RsvSid         = inputDs.indexOfColumn("RSV_SID");
				int colNm_Class          = inputDs.indexOfColumn("CLASS");
				int colNm_Teams          = inputDs.indexOfColumn("TEAMS");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){

					int j=1;
					switch(rows[i].getJobType()){

					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV710I_02",this);						
						cstmt = conn.prepareCall("{call SALES.PR_RV710I_02(?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
					
						cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(2, rows[i].getString(colNm_Class));
						cstmt.setString(3, rows[i].getString(colNm_Teams));						
						cstmt.setString(4, fParamEmpno);
						cstmt.setString(5, fParamIp);
						cstmt.setString(6, "3");
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); 						
	
						cstmt.executeUpdate();		
						if(cstmt!=null) cstmt.close();
					};
					
				}
			}
				//메시지처리
				//res.enableFirstRow(msgDS);
				//msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
/*					//메시지처리
					if (cstmt.getString(7).equals("Y") ) {
						if ( !cstmt.getString(8).equals("0000") ) {
							//StringUtil.printMsg("성공메시지",cstmt.getString(9),this);
							GauceDataRow row = msgDS.newDataRow();
							row.addColumnValue(cstmt.getString(9));								
							msgDS.addDataRow(row);
						}
					} else {
						//StringUtil.printMsg("실패메시지",cstmt.getString(9),this);								
						conn.rollback();
						GauceDataRow row = msgDS.newDataRow();
						row.addColumnValue(cstmt.getString(9));							
						msgDS.addDataRow(row);
						fail = true;
						break inner;						
					}  	
					
					if(cstmt!=null) cstmt.close();
					break;*/

			gos.close();
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");				
		}
	}
}
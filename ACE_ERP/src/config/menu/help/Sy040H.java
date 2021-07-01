package config.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import config.common.SuperServlet;	//CforCommon
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Sy040H extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			//	default 조회
			arr_sql[0].append ("{call COMMON.PR_SY040H_00(?) }" );	// 조직트리
			arr_sql[1].append ("{call COMMON.PR_SY040H_01(?,?) }" );
			arr_sql[2].append ("{call COMMON.PR_SY040H_02(?,?,?) }" );
			arr_sql[3].append ("{call COMMON.PR_SY040H_03(?,? ) }" ); // 내 결재선 콤보
			arr_sql[4].append ("{call COMMON.PR_SY040H_04(?,? ) }" ); // 결재선 조회
			arr_sql[5].append ("{call COMMON.PR_SY040H_05(?,?,?,? ) }" ); // 결재선 마스터 저장
			arr_sql[6].append ("{call COMMON.PR_SY040H_06(?,?,?,?,? ) }" ); // 결재선 디테일 저장
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {

	}	
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;	

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			// 검색시 조건
			String 	v_cust_nm		 = HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));
			String 	v_dept_nm	     = HDUtil.nullCheckStr(greq.getParameter("v_dept_nm"));
			String 	v_dept_cd	     = HDUtil.nullCheckStr(greq.getParameter("v_dept_cd"));			
			String 	v_dept_lv	     = HDUtil.nullCheckStr(greq.getParameter("v_dept_lv"));
			String 	v_empno	    	 = HDUtil.nullCheckStr(greq.getParameter("v_empno"));	
			int 	v_sid	   			 = HDUtil.nullCheckNum(greq.getParameter("v_sid"));			
		
			//StringUtil.printMsg(" v_cust_nm ",v_cust_nm,this);
			//StringUtil.printMsg(" v_dept_nm ",v_dept_nm,this);
			//StringUtil.printMsg(" v_dept_cd ",v_dept_cd,this);
			//StringUtil.printMsg(" v_dept_lv ",v_dept_lv,this);
			//StringUtil.printMsg(" v_empno ",v_empno,this);
			//StringUtil.printMsg(" v_sid ",v_sid,this);
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//StringUtil.printMsg(" dsType ",dsType,this);

			for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds_org_tree")){
					GauceDataSet ds1 = gis.read("DS_ORG_TREE");
					//StringUtil.printMsg(" 조직트리 조회, ds_org_tree ", "!",this);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}

            	if(dSets[i].getName().equals("ds_emplist") && dsType==1){	//이름 검색에 의한 조회시
					GauceDataSet ds1 = gis.read("DS_EMPLIST");
					//StringUtil.printMsg(" 이름 검색시 ds_emplist 조회, dsType=1 ", "!",this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_cust_nm);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_emplist") && dsType==2){	//부서 클릭에 의한 조회시
					GauceDataSet ds1 = gis.read("DS_EMPLIST");
					//StringUtil.printMsg(" 트리 클릭시 ds_emplist 조회, dsType=2 ", "!",this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_dept_cd);
					cstmt.setString(2, v_dept_lv);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	
            	if(dSets[i].getName().equals("ds_my_apline")){
					GauceDataSet ds1 = gis.read("DS_MY_APLINE");
					//StringUtil.printMsg(" 내 결재선 목록-콤보 조회 ", "!",this);
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, fParamEmpno);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_apline")){
					GauceDataSet ds1 = gis.read("DS_APLINE");
					//StringUtil.printMsg(" 내 결재선 목록 선택시 결재선 조회 ", "!",this);
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, v_sid);
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


    //	저장 method
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet inputDs1 = gis.read("DS1");
		
		try{
			if (inputDs1 != null) {
				int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
				String 	v_app_nm	= HDUtil.nullCheckStr(greq.getParameter("v_app_nm"));	//결재선명
				int 	v_sid	    = HDUtil.nullCheckNum(greq.getParameter("v_sid"));
				int colNm_SEQ 	= inputDs1.indexOfColumn("SEQ");		
				int colNm_APPROVE_TYPE 	= inputDs1.indexOfColumn("APPROVE_TYPE");						
				int colNm_APPROVE_EMPNO	= inputDs1.indexOfColumn("ENO_NO");
	
				GauceDataRow[] 		rows2 = inputDs1.getDataRows();
				
				switch(dsType){
				//신규 저장시
				case 1:
					
					cstmt = conn.prepareCall(arr_sql[5].toString()); //
					/*
					  pEMPNO        IN      VARCHAR2,   -- 사번
					  pAPPROVE_NM   IN      VARCHAR2,   -- 결재선 명
					  pSID          IN OUT  NUMBER,     -- 결재선마스터SID
					  pEDITSTATUS   IN      NUMBER      -- 편집 상태=가우스 행 JobType : 2=insert, 3=update, 4=delete 이 방향으로 통일.. 안 헷갈리게~
					 */		
					cstmt.setString(1, iParamEmpno);	
					cstmt.setString(2, v_app_nm);	
					cstmt.setInt(3, v_sid);		//아마 저장시는 0일 듯.
					cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);	//SID						
					cstmt.setInt(4, 2);					
					cstmt.executeUpdate();
					int v_sid2	 = cstmt.getBigDecimal(3).intValue();	//저장 후 리턴받은 결재선SID
					if(cstmt!=null) cstmt.close();
							
					for(int i=0; i<rows2.length; i++){
						cstmt = conn.prepareCall(arr_sql[6].toString()); //5							
						/*
					    pSID          IN    NUMBER,     -- 결재선마스터SID
  						pSEQ          IN    NUMBER,     -- 결재디테일 순번
  						pAPPROVE_TYPE IN VARCHAR2,      -- 결재 유형
						pAPPROVE_EMPNO IN VARCHAR2,     -- 결재자 사번
					  	pEDITSTATUS   IN      NUMBER    -- 편집 상태=가우스 행 JobType : 2=insert, 3=update, 4=delete 이 방향으로 통일.. 안 헷갈리게~
						*/ 	

						cstmt.setInt(1, v_sid2);		
						cstmt.setInt(2, rows2[i].getInt(colNm_SEQ));
						cstmt.setString(3, rows2[i].getString(colNm_APPROVE_TYPE));
						cstmt.setString(4, rows2[i].getString(colNm_APPROVE_EMPNO));			
						cstmt.setInt(5, 2);
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();					
					}
					break;

				//수정시
				case 2:
					//StringUtil.printMsg("  v_app_nm", v_app_nm,this);
					//StringUtil.printMsg("  v_sid", v_sid,this);
					cstmt = conn.prepareCall(arr_sql[5].toString());
					/*
					  pEMPNO        IN      VARCHAR2,   -- 사번
					  pAPPROVE_NM   IN      VARCHAR2,   -- 결재선 명
					  pSID          IN OUT  NUMBER,     -- 결재선마스터SID
					  pEDITSTATUS   IN      NUMBER      -- 편집 상태=가우스 행 JobType : 2=insert, 3=update, 4=delete 이 방향으로 통일.. 안 헷갈리게~
					 */		
					cstmt.setString(1, iParamEmpno);	
					cstmt.setString(2, v_app_nm);	
					cstmt.setInt(3, v_sid);		//아마 저장시는 0일 듯.
					cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);	//SID						
					cstmt.setInt(4, 3);					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();

					// 결재선 디테일 전체 삭제	
					cstmt = conn.prepareCall(arr_sql[6].toString()); //5							
					/*
				    pSID          IN    NUMBER,     -- 결재선마스터SID
					pSEQ          IN    NUMBER,     -- 결재디테일 순번
					pAPPROVE_TYPE IN VARCHAR2,      -- 결재 유형
					pAPPROVE_EMPNO IN VARCHAR2,     -- 결재자 사번
				  	pEDITSTATUS   IN      NUMBER    -- 편집 상태=가우스 행 JobType : 2=insert, 3=update, 4=delete 이 방향으로 통일.. 안 헷갈리게~
					*/ 	
					cstmt.setInt(1, v_sid);		
					cstmt.setInt(2, colNm_SEQ);
					cstmt.setLong(3, colNm_APPROVE_TYPE);
					cstmt.setLong(4, colNm_APPROVE_EMPNO);			
					cstmt.setInt(5, 5);		//5로 던지면 해당 디테일을 전부 삭제									
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
					
					for(int i=0; i<rows2.length; i++){
						//StringUtil.printMsg(i+"번째 행 인서트", rows2[i].getString(colNm_APPROVE_EMPNO),this);
						cstmt = conn.prepareCall(arr_sql[6].toString());						
						cstmt.setInt(1, v_sid);		
						cstmt.setInt(2, rows2[i].getInt(colNm_SEQ));
						cstmt.setString(3, rows2[i].getString(colNm_APPROVE_TYPE));
						cstmt.setString(4, rows2[i].getString(colNm_APPROVE_EMPNO));			
						cstmt.setInt(5, 2);	//인서트
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();						
					}
					
					break;		

				//삭제시 : COMMON.APPROVE_LINE_M, APPROVE_LINE_D 의 FK 조건으로 디테일 부터 삭제
				case 3:
					cstmt = conn.prepareCall(arr_sql[6].toString()); //디테일 삭제							
					/*
				    pSID          IN    NUMBER,     -- 결재선마스터SID
						pSEQ          IN    NUMBER,     -- 결재디테일 순번
						pAPPROVE_TYPE IN VARCHAR2,      -- 결재 유형
					pAPPROVE_EMPNO IN VARCHAR2,     -- 결재자 사번
				  	pEDITSTATUS   IN      NUMBER    -- 편집 상태=가우스 행 JobType : 2=insert, 3=update, 4=delete 이 방향으로 통일.. 안 헷갈리게~
					*/ 	
					cstmt.setInt(1, v_sid);		
					cstmt.setInt(2, colNm_SEQ);
					cstmt.setLong(3, colNm_APPROVE_TYPE);
					cstmt.setLong(4, colNm_APPROVE_EMPNO);			
					cstmt.setInt(5, 5);		//5로 던지면 해당 디테일을 전부 삭제									
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();	

					
					cstmt = conn.prepareCall(arr_sql[5].toString());	// 마스터 삭제
					/*
					  pEMPNO        IN      VARCHAR2,   -- 사번
					  pAPPROVE_NM   IN      VARCHAR2,   -- 결재선 명
					  pSID          IN OUT  NUMBER,     -- 결재선마스터SID
					  pEDITSTATUS   IN      NUMBER      -- 편집 상태=가우스 행 JobType : 2=insert, 3=update, 4=delete 이 방향으로 통일.. 안 헷갈리게~
					 */		
					cstmt.setString(1, iParamEmpno);	
					cstmt.setString(2, v_app_nm);	
					cstmt.setInt(3, v_sid);		//아마 저장시는 0일 듯.
					cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);	//SID						
					cstmt.setInt(4, 4);					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
					
					
					break;		
							
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
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}
	}
}




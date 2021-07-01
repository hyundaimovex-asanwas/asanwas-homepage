package sales.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
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
			
		
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT HEAD, DETAIL, DETAIL_NM      \n")
				  .append ("FROM   SALES.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND DETAIL <> ' ' 	AND head = 'AP005'		\n");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	/* DataSet */
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
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
			String 	v_empno	    	 = HDUtil.nullCheckStr(greq.getParameter("v_empno"));	
			int 		v_sid	   			 = HDUtil.nullCheckNum(greq.getParameter("v_sid"));			
		
			//StringUtil.printMsg(" v_cust_nm ",v_cust_nm,this);
			//StringUtil.printMsg(" v_dept_nm ",v_dept_nm,this);
			//StringUtil.printMsg(" v_dept_cd ",v_dept_cd,this);
			//StringUtil.printMsg(" v_empno ",v_empno,this);
			//StringUtil.printMsg(" v_sid ",v_sid,this);
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//StringUtil.printMsg(" dsType ",dsType,this);

			for(int i=0; i<dSets.length;i++){
					if(dSets[i].getName().equals("gcds_data") & dsType==1){
						////StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
						//StringUtil.printMsg(" gcds_data_1 ","gcds_data_1",this);
						GauceDataSet ds1 = gis.read("DS1");
						cstmt = conn.prepareCall("{call SALES.PR_SY040H_01(?,?,?) }");
						cstmt.setString(1, v_cust_nm);
						cstmt.setString(2, v_dept_nm);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);
						gos.write(getDataSet(rs, ds1));
					}else if(dSets[i].getName().equals("gcds_data") & dsType==2){
						//StringUtil.printMsg(" gcds_data_2 ","gcds_data_2",this);
						//StringUtil.printMsg(" v_dept_cd ",v_dept_cd,this);
						GauceDataSet ds1 = gis.read("DS2");// 직원목록
						cstmt = conn.prepareCall("{call SALES.PR_SY040H_02(?,?) }");
						cstmt.setString(1, v_dept_cd);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);
						gos.write(getDataSet(rs, ds1));
					}else if(dSets[i].getName().equals("gcds_approve")){
						GauceDataSet ds1 = gis.read("DS3");
						cstmt = conn.prepareCall("{call SALES.PR_SY040H_03(?,?) }");
						cstmt.setString(1, v_empno);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);
						gos.write(getDataSet(rs, ds1));
					}else if(dSets[i].getName().equals("gcds_data2")){
						GauceDataSet ds1 = gis.read("DS4");
						cstmt = conn.prepareCall("{call SALES.PR_SY040H_04(?,?,?) }");
						cstmt.setString(1, v_empno);	
						cstmt.setInt(2, v_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);
						gos.write(getDataSet(rs, ds1));
					}else if(dSets[i].getName().equals("gcds_approve_type")){
						GauceDataSet ds1 = gis.read("DS5");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						rs=cstmt.executeQuery();
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
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
		int menu_idx = HDUtil.nullCheckNum(greq.getParameter("menu_idx"));
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		try{
			if (inputDs1 != null) {
				//StringUtil.printMsg("ds1","ds1",this);
				GauceDataRow[] 		rows = inputDs1.getDataRows();
				GauceDataColumn[] 	cols = inputDs1.getDataColumns();
				int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
				String 	v_empno	    	= HDUtil.nullCheckStr(greq.getParameter("v_empno"));	
				String 	v_app_nm	    = HDUtil.nullCheckStr(greq.getParameter("v_app_nm"));
				int 	v_sid	    = HDUtil.nullCheckNum(greq.getParameter("v_sid"));
				int colNm_SEQ 	= inputDs1.indexOfColumn("SEQ");		
				int colNm_APPROVE_TYPE 	= inputDs1.indexOfColumn("APPROVE_TYPE");						
				int colNm_APPROVE_EMPNO	= inputDs1.indexOfColumn("APPROVE_EMPNO");
	
				GauceDataRow[] 		rows2 = inputDs1.getDataRows();
				GauceDataColumn[] 	cols2= inputDs1.getDataColumns();
				
					switch(dsType){						
						case 1:
							//STRINGUTIL.printMsg("CASE1","CASE1",this);
							cstmt = conn.prepareCall("{call SALES.PR_SY040H_05( ?, ?, ?, ?) }"); //4	
					 /*   IN    pEMPNO       VARCHAR(7),       -- 사번
						   IN    pAPPROVE_NM    VARCHAR(20),     -- 결재선명
						   INOUT pSID NUMERIC(10),--SID 
						   IN      pEDITSTATUS        VARCHAR(1),    -- 편집상태     1: INSERT, 2: DELETE, 3: UPDATE */	  	   
		
							cstmt.setString(1, v_empno);	
							cstmt.setString(2, v_app_nm);	
							cstmt.setInt(3, v_sid);
							cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);	//SID						
							cstmt.setInt(4, 1);					
							cstmt.executeUpdate();
							
							int v_sid2	 = cstmt.getBigDecimal(3).intValue();
						
							if(cstmt!=null) cstmt.close();
							
					/*	선언해줄 부분 	
					       IN pSID NUMERIC(10),--SID 
					   	   IN pSEQ NUMERIC(5),--SEQ
					   	   IN pAPPROVE_TYPE    VARCHAR(10),     -- 결재타입   	   
						   IN pAPPROVE_EMPNO       VARCHAR(7),       -- 결재자사번
						   IN pEDITSTATUS        NUMERIC(1)    -- 편집상태     1: INSERT, 2: DELETE, 3: UPDATE  */
					
						
							for(int i=0; i<rows2.length; i++){
									cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
									cstmt.setInt(1, v_sid2);		
									cstmt.setInt(2, rows2[i].getInt(colNm_SEQ));
									cstmt.setString(3, rows2[i].getString(colNm_APPROVE_TYPE));
									cstmt.setString(4, rows2[i].getString(colNm_APPROVE_EMPNO));			
									cstmt.setInt(5, 1);										
									cstmt.executeUpdate();
									if(cstmt!=null) cstmt.close();					
							}
								break;
		
						case 2:
						//STRINGUTIL.printMsg("CASE2","CASE2",this);
						//StringUtil.printMsg("delete22getJobType","",this);	
						////StringUtil.printMsg("v_sid",v_sid,this);
						////StringUtil.printMsg("colNm_SEQ",colNm_SEQ,this);
						////StringUtil.printMsg("colNm_APPROVE_TYPE",colNm_APPROVE_TYPE,this);									
						////StringUtil.printMsg("APPROVE_EMPNO",colNm_APPROVE_EMPNO,this);					
												
						cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
						cstmt.setInt(1, v_sid);		
						cstmt.setInt(2, colNm_SEQ);
						cstmt.setLong(3, colNm_APPROVE_TYPE);
						cstmt.setLong(4, colNm_APPROVE_EMPNO);			
						cstmt.setInt(5, 4);										
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
						
						//StringUtil.printMsg(" rows2.length",rows2.length,this);
							for(int i=0; i<rows2.length; i++){
								if((rows2[i].getJobType()==GauceDataRow.TB_JOB_INSERT)|| (rows2[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)) {
		/*
										StringUtil.printMsg("---------------","-----------------",this);
										StringUtil.printMsg("name====",rows2[i].getString(inputDs1.indexOfColumn("EMPNMK")),this);
										StringUtil.printMsg("JobType====",rows2[i].getJobType(),this);
										StringUtil.printMsg("v_sid",v_sid,this);
										StringUtil.printMsg("colNm_SEQ",rows2[i].getInt(colNm_SEQ),this);
										StringUtil.printMsg("colNm_APPROVE_TYPE",rows2[i].getString(colNm_APPROVE_TYPE),this);									
										StringUtil.printMsg("APPROVE_EMPNO",rows2[i].getString(colNm_APPROVE_EMPNO),this);
		*/
										cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
										cstmt.setInt(1, v_sid);		
										cstmt.setInt(2, rows2[i].getInt(colNm_SEQ));
										cstmt.setString(3, rows2[i].getString(colNm_APPROVE_TYPE));
										cstmt.setString(4, rows2[i].getString(colNm_APPROVE_EMPNO));			
										cstmt.setInt(5, 1);										
										cstmt.executeUpdate();
										if(cstmt!=null) cstmt.close();					
								}
							}
							
						break;		
								
						case 3:
						//StringUtil.printMsg("CASE3","CASE3",this);
							for(int i=0; i<rows2.length; i++){												
								//STRINGUTIL.printMsg("CASE3_FOR","CASE3_FOR",this);
									cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
									cstmt.setInt(1, v_sid);		
									cstmt.setInt(2, rows2[i].getInt(colNm_SEQ));
									cstmt.setString(3, rows2[i].getString(colNm_APPROVE_TYPE));
									cstmt.setString(4, rows2[i].getString(colNm_APPROVE_EMPNO));			
									cstmt.setInt(5, 2);										
									cstmt.executeUpdate();
									if(cstmt!=null) cstmt.close();					
							}
							//STRINGUTIL.printMsg("CASE3_05","CASE3_05",this);
							 cstmt = conn.prepareCall("{call SALES.PR_SY040H_05( ?, ?, ?, ?) }"); //4	
							 cstmt.setString(1, v_empno);	
							 cstmt.setString(2, v_app_nm);	
							 cstmt.setInt(3, v_sid);
							 cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);	//SID						
							 cstmt.setInt(4, 2);					
							 cstmt.executeUpdate();
							
							 if(cstmt!=null) cstmt.close();	
							
							break;		
							
																																									
						case 4:
							//STRINGUTIL.printMsg("CASE4","CASE4",this);
					//		StringUtil.printMsg("delete22getJobType","",this);	
					//		StringUtil.printMsg("v_sid",v_sid,this);
					//		StringUtil.printMsg("colNm_SEQ",colNm_SEQ,this);
					//		StringUtil.printMsg("colNm_APPROVE_TYPE",colNm_APPROVE_TYPE,this);									
					//		StringUtil.printMsg("APPROVE_EMPNO",colNm_APPROVE_EMPNO,this);					
												
							cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
							cstmt.setInt(1, v_sid);		
							cstmt.setInt(2, colNm_SEQ);
							cstmt.setLong(3, colNm_APPROVE_TYPE);
							cstmt.setLong(4, colNm_APPROVE_EMPNO);			
							cstmt.setInt(5, 4);										
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
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}




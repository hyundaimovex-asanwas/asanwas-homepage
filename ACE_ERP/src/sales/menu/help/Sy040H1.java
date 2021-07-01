package sales.menu.help;


import java.sql.CallableStatement;
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
import sales.common.SuperServlet;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Sy040H1 extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
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

    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����ȸ",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

	}	
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","��ȸ",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// �˻��� ����
			String 	v_cust_nm		 = HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));
			String 	v_dept_nm	     = HDUtil.nullCheckStr(req.getParameter("v_dept_nm"));
			String 	v_dept_cd	     = HDUtil.nullCheckStr(req.getParameter("v_dept_cd"));			
			String 	v_empno	    	 = HDUtil.nullCheckStr(req.getParameter("v_empno"));	
			int 		v_sid	   			 = HDUtil.nullCheckNum(req.getParameter("v_sid"));			
		
/*			StringUtil.printMsg("v_cust_nm=", v_cust_nm, this);
			StringUtil.printMsg("v_dept_nm=", v_dept_nm, this);
			StringUtil.printMsg("v_dept_cd=", v_dept_cd, this);
*/
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							
							if ( gauceName.equals("DS1")) { //���缱����  - ��� ��ȸ ��ư
								//StringUtil.printMsg("call SALES.PR_RM310I_01","",this);
								cstmt = conn.prepareCall("{call SALES.PR_SY040H_01(?, ?) }");
								cstmt.setString(1, v_cust_nm);
								cstmt.setString(2, v_dept_nm);																								
							}
							if ( gauceName.equals("DS2")) {  //tree onclick�ÿ� 
								//StringUtil.printMsg("call SALES.PR_RM310I_02","",this);
								cstmt = conn.prepareCall("{call SALES.PR_SY040H_02(?) }");
								cstmt.setString(1, v_dept_cd);						
						   }							
						   if ( gauceName.equals("DS3")) {  //�����޺�
						//StringUtil.printMsg("call SALES.PR_RM310I_02","",this);
								cstmt = conn.prepareCall("{call SALES.PR_SY040H_03(?) }");
								cstmt.setString(1, v_empno);	
						   }
							if ( gauceName.equals("DS4")) {  //�����޺� ȭ�� ��
						 //StringUtil.printMsg("call SALES.PR_RM310I_02","",this);
								 cstmt = conn.prepareCall("{call SALES.PR_SY040H_04(?,?) }");
								cstmt.setString(1, v_empno);	
								cstmt.setInt(2, v_sid);
							}	
							if ( gauceName.equals("DS5")) {  //�׸��� ����Ÿ�� �����޺� ��
						 //StringUtil.printMsg("call SALES.PR_RM310I_02","",this);
						 		cstmt = conn.prepareCall(arr_sql[0].toString()); 
								//cstmt.setString(1, v_empno);	
							}						   
						   
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();							
							
					}
				}
				//ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�.				
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs1 = req.getGauceDataSet("DS1");		

		CallableStatement cstmt = null;
	//	GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		boolean fail=false;
		
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		try{

			if(inputDs1!=null){

				int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
				String 	v_empno	    	= HDUtil.nullCheckStr(req.getParameter("v_empno"));	
				String 	v_app_nm	    = HDUtil.nullCheckStr(req.getParameter("v_app_nm"));
				int 	v_sid	    = HDUtil.nullCheckNum(req.getParameter("v_sid"));
				int colNm_SEQ 	= inputDs1.indexOfColumn("SEQ");		
				int colNm_APPROVE_TYPE 	= inputDs1.indexOfColumn("APPROVE_TYPE");						
				int colNm_APPROVE_EMPNO	= inputDs1.indexOfColumn("APPROVE_EMPNO");
	
				GauceDataRow[] 		rows2 = inputDs1.getDataRows();
				GauceDataColumn[] 	cols2= inputDs1.getDataColumns();
				
//					inner2:
																	
					switch(dsType){						
						case 1:
//							StringUtil.printMsg("call SALES.PR_SY040H_05","",this);
							cstmt = conn.prepareCall("{call SALES.PR_SY040H_05( ?, ?, ?, ?) }"); //4	

							cstmt.setString(1, v_empno);	
							cstmt.setString(2, v_app_nm);	
							cstmt.setInt(3, v_sid);
//							cstmt.setInt	(18, Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")));//��SID
							cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);	//SID						
							cstmt.setInt(4, 1);					
							cstmt.executeUpdate();
							
							int v_sid2	 = cstmt.getBigDecimal(3).intValue();
						
							if(cstmt!=null) cstmt.close();
							
/*	�������� �κ� 	
       IN pSID NUMERIC(10),--SID 
   	   IN pSEQ NUMERIC(5),--SEQ
   	   IN pAPPROVE_TYPE    VARCHAR(10),     -- ����Ÿ��   	   
	   IN pAPPROVE_EMPNO       VARCHAR(7),       -- �����ڻ��
	   IN pEDITSTATUS        NUMERIC(1)    -- ��������     1: INSERT, 2: DELETE, 3: UPDATE  */
					
						
							for(int i=0; i<rows2.length; i++){
	/*								
									StringUtil.printMsg("call SALES.PR_SY040H_06","",this);
									
									StringUtil.printMsg("SEQ",rows2[i].getInt(colNm_SEQ),this);
									StringUtil.printMsg("APPROVE_TYPE",rows2[i].getString(colNm_APPROVE_TYPE),this);
									StringUtil.printMsg("APPROVE_EMPNO",rows2[i].getString(colNm_APPROVE_EMPNO),this);
									StringUtil.printMsg("getJobType",rows2[i].getJobType(),this);						
									StringUtil.printMsg("SEQ",rows2[i].getInt(colNm_SEQ),this);
*/									
									StringUtil.printMsg("JobType====",rows2[i].getJobType(),this);

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
						
							StringUtil.printMsg("����====","",this);	
							//StringUtil.printMsg("v_sid",v_sid,this);
							//StringUtil.printMsg("colNm_SEQ",colNm_SEQ,this);
							//StringUtil.printMsg("colNm_APPROVE_TYPE",colNm_APPROVE_TYPE,this);									
							//StringUtil.printMsg("APPROVE_EMPNO",colNm_APPROVE_EMPNO,this);					
													
							/*cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
							cstmt.setInt(1, v_sid);		
							cstmt.setInt(2, colNm_SEQ);
							cstmt.setLong(3, colNm_APPROVE_TYPE);
							cstmt.setLong(4, colNm_APPROVE_EMPNO);			
							cstmt.setInt(5, 4);										
							//cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();*/
						
							StringUtil.printMsg(" rows2.length",rows2.length,this);
						StringUtil.printMsg("tb_insert====",GauceDataRow.TB_JOB_INSERT+"",this);
						StringUtil.printMsg("tb_delete====",GauceDataRow.TB_JOB_DELETE+"",this);
						StringUtil.printMsg("tb_normal====",GauceDataRow.TB_JOB_NORMAL+"",this);
						StringUtil.printMsg("tb_update====",GauceDataRow.TB_JOB_UPDATE+"",this);							
							for(int i=0; i<rows2.length; i++){
						//		switch(rows2[i].getJobType()){
						//		case GauceDataRow.TB_JOB_INSERT:
						
								StringUtil.printMsg("---------------","-----------------",this);
								StringUtil.printMsg("name====",rows2[i].getString(inputDs1.indexOfColumn("EMPNMK")),this);
								StringUtil.printMsg("JobType====",rows2[i].getJobType(),this);
								
								//StringUtil.printMsg("v_sid",v_sid,this);
								//StringUtil.printMsg("colNm_SEQ",rows2[i].getInt(colNm_SEQ),this);
								//StringUtil.printMsg("colNm_APPROVE_TYPE",rows2[i].getString(colNm_APPROVE_TYPE),this);									
								//StringUtil.printMsg("APPROVE_EMPNO",rows2[i].getString(colNm_APPROVE_EMPNO),this);
							}
							

						break;		
								
						case 3:
					
						
							for(int i=0; i<rows2.length; i++){
								
									StringUtil.printMsg("call SALES.PR_SY040H_06","",this);
									
									StringUtil.printMsg("SEQ",rows2[i].getInt(colNm_SEQ),this);
									StringUtil.printMsg("APPROVE_TYPE",rows2[i].getString(colNm_APPROVE_TYPE),this);
									StringUtil.printMsg("APPROVE_EMPNO",rows2[i].getString(colNm_APPROVE_EMPNO),this);
									StringUtil.printMsg("getJobType",rows2[i].getJobType(),this);						
								
									
	
									cstmt = conn.prepareCall("{call SALES.PR_SY040H_06( ?, ?, ?, ?, ?) }"); //5							
									cstmt.setInt(1, v_sid);		
									cstmt.setInt(2, rows2[i].getInt(colNm_SEQ));
									cstmt.setString(3, rows2[i].getString(colNm_APPROVE_TYPE));
									cstmt.setString(4, rows2[i].getString(colNm_APPROVE_EMPNO));			
									cstmt.setInt(5, 2);										
									cstmt.executeUpdate();
									if(cstmt!=null) cstmt.close();					
							}
							
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
						
							StringUtil.printMsg("delete22getJobType","",this);	
							StringUtil.printMsg("v_sid",v_sid,this);
							StringUtil.printMsg("colNm_SEQ",colNm_SEQ,this);
							StringUtil.printMsg("colNm_APPROVE_TYPE",colNm_APPROVE_TYPE,this);									
							StringUtil.printMsg("APPROVE_EMPNO",colNm_APPROVE_EMPNO,this);					
												
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
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if( fail == true ) throw new Exception("");			
			if(cstmt!=null) cstmt.close();
		}
	}

}

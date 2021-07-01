package pms.menu.help;

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

public class Pu040H extends SuperServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			
		//StringUtil.printMsg("start::","1",this);		

		//���ڰ����� ���缱 ��ȸ1_���缱���� �ڵ����� /	����û�� ��� / ����û������ ��� / ǰ���ۼ� ���
		arr_sql[1].append ("{call PMS.PR_PU010HS_01(?,?) }" );
		 //���ڰ����� ���缱 ��ȸ2_���缱 �������� /	����û�� ��� / ����û������ ��� / ǰ���ۼ� ���
		 arr_sql[2].append ("{call PMS.PR_PU010HS_02(?,?,?,?,?) }" );
		//	����û�� ��� / ����û������ ��� / ǰ���ۼ� ���  
		arr_sql[3].append ("{call PMS.PR_PU010HI_02(?,?,?,?,?,             ?,?,?,?,?,              ?,?,?,?,?              , ?,?,?,?,?               , ?,?,?,?,?,                  ?,?,?,?,?) }");
		
		//	���Ű˼�_���ڰ����� �⺻���� ��ȸ 
		arr_sql[4].append ("{call PMS.PR_PU040HS_04(?,?,?,?) }" );
		//	���Ű˼�_���ڰ����� �⺻���� ��ȸ_����������ü�� LIST 
		arr_sql[5].append ("{call PMS.PR_PU040HS_05(?,?,?) }" );
		//	���Ű˼�_���ڰ����� �⺻���� ��ȸ_ǰ�� LIST 
		arr_sql[6].append ("{call PMS.PR_PU040HS_06(?,?,?) }" );
        
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			for(int i=0; i<dSets.length;i++){

				if(dSets[i].getName().equals("ds_default6")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT6");  
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						int  v_con_sid		= HDUtil.nullCheckNum(greq.getParameter("v_con_sid")); 			// �˼�������sid
						int  v_cgcd_sid	= HDUtil.nullCheckNum(greq.getParameter("v_cgcd_sid")); 		// �˼�������sid
						String  v_date_cgcd	= HDUtil.nullCheckStr(greq.getParameter("v_date_cgcd")); 		// �˼�����sid
						//StringUtil.printMsg("DS_DEFAULT_v_rqst_sid",v_est_sid,this);
						cstmt.setInt(1, v_con_sid);
						cstmt.setInt(2, v_cgcd_sid);
						cstmt.setString(3, v_date_cgcd);
						cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));				
					
				}else if(dSets[i].getName().equals("ds_default2") & dsType==2){
					//StringUtil.printMsg("dsType::","2",this);
					GauceDataSet ds1 = gis.read("DS_DEFAULT2");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						int  v_sid		= HDUtil.nullCheckNum(greq.getParameter("v_sid"));
						cstmt.setInt(1, v_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					
				}else if(dSets[i].getName().equals("ds_default2") & dsType==5){
					//StringUtil.printMsg("dsType::","5",this);
					GauceDataSet ds1 = gis.read("DS_DEFAULT5");  
						cstmt = conn.prepareCall(arr_sql[2].toString());
						String  v_empno1		= HDUtil.nullCheckStr(greq.getParameter("v_empno1")); 		// 
						String  v_empno2		= HDUtil.nullCheckStr(greq.getParameter("v_empno2")); 		// 
						String  v_empno3		= HDUtil.nullCheckStr(greq.getParameter("v_empno3"));  		// 
						String  v_empno4		= HDUtil.nullCheckStr(greq.getParameter("v_empno4")); 		// 
						cstmt.setString(1, v_empno1);
						cstmt.setString(2, v_empno2);
						cstmt.setString(3, v_empno3);
						cstmt.setString(4, v_empno4);
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
						
				}else if(dSets[i].getName().equals("ds_default7")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT7");  
						cstmt = conn.prepareCall(arr_sql[5].toString());
						int  v_est_sid	= HDUtil.nullCheckNum(greq.getParameter("v_est_sid")); 		// ����sid
						int  v_rqst_sid	= HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid")); 		// ����sid
						//StringUtil.printMsg("v_est_sid",v_est_sid,this);
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid,this);
						cstmt.setInt(1, v_est_sid);
						cstmt.setInt(2, v_rqst_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));	
				}else if(dSets[i].getName().equals("ds_default8")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT8");  
						cstmt = conn.prepareCall(arr_sql[6].toString());
						int  v_con_sid	= HDUtil.nullCheckNum(greq.getParameter("v_con_sid")); 		// ǰ��sid
						String  v_date_cgcd	= HDUtil.nullCheckStr(greq.getParameter("v_date_cgcd")); 		//�˼�����
						//StringUtil.printMsg("v_est_sid",v_est_sid,this);
						//StringUtil.printMsg("v_vend_cd",v_vend_cd,this);
						cstmt.setInt(1, v_con_sid);
						cstmt.setString(2, v_date_cgcd);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
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
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {	
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
	  
		GauceDataSet msgDS = gis.read("msgDS");
		GauceDataSet ds1 = gis.read("DS_APPROVE");
  
		try{
			  if (ds1 != null) {
				  //StringUtil.printMsg("ds1","ds1",this);
				  
				  GauceDataRow[] 		    rows = ds1.getDataRows();
				  GauceDataColumn[] 	cols = ds1.getDataColumns();
			  
			
			  int colNm_DOC_SID          = ds1.indexOfColumn("DOC_SID"); 
			  int colNm_DOC_GU          = ds1.indexOfColumn("DOC_GU");
			  int colNm_DOC_GU2         = ds1.indexOfColumn("DOC_GU2"); 
			  int colNm_AP_GU_1          = ds1.indexOfColumn("AP_GU_1"); 
			  int colNm_AP_SEQ_1       = ds1.indexOfColumn("AP_SEQ_1"); 
			  int colNm_AP_TYPE_1      = ds1.indexOfColumn("AP_TYPE_1"); 
			  int colNm_AP_EMPNO_1  = ds1.indexOfColumn("AP_EMPNO_1"); 
			  int colNm_AP_GU_2         = ds1.indexOfColumn("AP_GU_2"); 
			  int colNm_AP_SEQ_2       = ds1.indexOfColumn("AP_SEQ_2"); 
			  int colNm_AP_TYPE_2      = ds1.indexOfColumn("AP_TYPE_2"); 
			  int colNm_AP_EMPNO_2  = ds1.indexOfColumn("AP_EMPNO_2"); 
			  int colNm_AP_GU_3         = ds1.indexOfColumn("AP_GU_3"); 
			  int colNm_AP_SEQ_3       = ds1.indexOfColumn("AP_SEQ_3"); 
			  int colNm_AP_TYPE_3      = ds1.indexOfColumn("AP_TYPE_3"); 
			  int colNm_AP_EMPNO_3  = ds1.indexOfColumn("AP_EMPNO_3"); 
			  int colNm_AP_GU_4         = ds1.indexOfColumn("AP_GU_4"); 
			  int colNm_AP_SEQ_4       = ds1.indexOfColumn("AP_SEQ_4"); 
			  int colNm_AP_TYPE_4     = ds1.indexOfColumn("AP_TYPE_4"); 
			  int colNm_AP_EMPNO_4  = ds1.indexOfColumn("AP_EMPNO_4"); 
			  int colNm_AP_STATUS_M  = ds1.indexOfColumn("AP_STATUS_M"); 
			  
			int colNm_NUM_PARAM2          = ds1.indexOfColumn("NUM_PARAM2"); 
			int colNm_CH_PARAM1          = ds1.indexOfColumn("CH_PARAM1");
			int colNm_NUM_PARAM3          = ds1.indexOfColumn("NUM_PARAM3");
			int colNm_NUM_PARAM4          = ds1.indexOfColumn("NUM_PARAM4");
	
			/*
   		    StringUtil.printMsg("colNm_DOC_SID",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_DOC_GU",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_DOC_GU2",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_GU_1",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_SEQ_1",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_TYPE_1",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_EMPNO_1",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_GU_2",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_SEQ_2",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_TYPE_2",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_EMPNO_2",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_GU_3",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_SEQ_3",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_TYPE_3",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_EMPNO_3",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_GU_4",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_SEQ_4",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_TYPE_4",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_EMPNO_4",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_AP_STATUS_M",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_NUM_PARAM2",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_CH_PARAM1",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_NUM_PARAM3",colNm_DOC_SID,this);
			StringUtil.printMsg("colNm_NUM_PARAM4",colNm_DOC_SID,this);
			*/
			
			  for(int i=0; i<rows.length; i++){
				  int j=1;
				  switch(rows[i].getJobType()){
					  case GauceDataRow.TB_JOB_INSERT:
				   	  
						   // StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[3].toString());
						 	
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_SID));
					//StringUtil.printMsg("colNm_DOC_SID",rows[i].getString(colNm_DOC_SID),this);
							cstmt.setString(2, rows[i].getString(colNm_DOC_GU));
					//StringUtil.printMsg("colNm_DOC_GU",rows[i].getString(colNm_DOC_GU),this);
							cstmt.setString(3, rows[i].getString(colNm_DOC_GU2));
					//StringUtil.printMsg("colNm_DOC_GU2",rows[i].getString(colNm_DOC_GU2),this);
							cstmt.setString(4, rows[i].getString(colNm_AP_GU_1));
					//StringUtil.printMsg("colNm_AP_GU_1",rows[i].getString(colNm_AP_GU_1),this);
							cstmt.setInt(5, rows[i].getInt(colNm_AP_SEQ_1));
					//StringUtil.printMsg("colNm_AP_SEQ_1",rows[i].getString(colNm_AP_SEQ_1),this);
							cstmt.setString(6, rows[i].getString(colNm_AP_TYPE_1));
					//StringUtil.printMsg("colNm_AP_TYPE_1",rows[i].getString(colNm_AP_TYPE_1),this);
							cstmt.setString(7, rows[i].getString(colNm_AP_EMPNO_1));
					//StringUtil.printMsg("colNm_AP_EMPNO_1",rows[i].getString(colNm_AP_EMPNO_1),this);
							cstmt.setString(8, rows[i].getString(colNm_AP_GU_2));
					//StringUtil.printMsg("colNm_AP_GU_2",rows[i].getString(colNm_AP_GU_2),this);
							cstmt.setInt(9, rows[i].getInt(colNm_AP_SEQ_2));
					//StringUtil.printMsg("colNm_AP_SEQ_2",rows[i].getString(colNm_AP_SEQ_2),this);
							cstmt.setString(10, rows[i].getString(colNm_AP_TYPE_2));
					//StringUtil.printMsg("colNm_AP_TYPE_2",rows[i].getString(colNm_AP_TYPE_2),this);
							cstmt.setString(11, rows[i].getString(colNm_AP_EMPNO_2));
					//StringUtil.printMsg("colNm_AP_EMPNO_2",rows[i].getString(colNm_AP_EMPNO_2),this);
							cstmt.setString(12, rows[i].getString(colNm_AP_GU_3));
					//StringUtil.printMsg("colNm_AP_GU_3",rows[i].getString(colNm_AP_GU_3),this);
							cstmt.setInt(13, rows[i].getInt(colNm_AP_SEQ_3));
					//StringUtil.printMsg("colNm_AP_SEQ_3",rows[i].getString(colNm_AP_SEQ_3),this);
							cstmt.setString(14, rows[i].getString(colNm_AP_TYPE_3));
					//StringUtil.printMsg("colNm_AP_TYPE_3",rows[i].getString(colNm_AP_TYPE_3),this);
							cstmt.setString(15, rows[i].getString(colNm_AP_EMPNO_3));
					//StringUtil.printMsg("colNm_AP_EMPNO_3",rows[i].getString(colNm_AP_EMPNO_3),this);
							cstmt.setString(16, rows[i].getString(colNm_AP_GU_4));
					//StringUtil.printMsg("colNm_AP_GU_4",rows[i].getString(colNm_AP_GU_4),this);
							cstmt.setInt(17, rows[i].getInt(colNm_AP_SEQ_4));
					//StringUtil.printMsg("colNm_AP_SEQ_4",rows[i].getString(colNm_AP_SEQ_4),this);
							cstmt.setString(18, rows[i].getString(colNm_AP_TYPE_4));
					//StringUtil.printMsg("colNm_AP_TYPE_4",rows[i].getString(colNm_AP_TYPE_4),this);
							cstmt.setString(19, rows[i].getString(colNm_AP_EMPNO_4));
					//StringUtil.printMsg("colNm_AP_EMPNO_4",rows[i].getString(colNm_AP_EMPNO_4),this);
							cstmt.setString(20, rows[i].getString(colNm_AP_STATUS_M));
					//StringUtil.printMsg("colNm_AP_STATUS_M",rows[i].getString(colNm_AP_STATUS_M),this);
							cstmt.setInt(21, rows[i].getInt(colNm_NUM_PARAM2));
					//StringUtil.printMsg("colNm_NUM_PARAM2",rows[i].getString(colNm_NUM_PARAM2),this);
							cstmt.setString(22, rows[i].getString(colNm_CH_PARAM1));
					//StringUtil.printMsg("colNm_CH_PARAM1",rows[i].getString(colNm_CH_PARAM1),this);
							cstmt.setInt(23, rows[i].getInt(colNm_NUM_PARAM3));
					//StringUtil.printMsg("colNm_NUM_PARAM3",rows[i].getString(colNm_NUM_PARAM3),this);
							cstmt.setInt(24, rows[i].getInt(colNm_NUM_PARAM4));
					//StringUtil.printMsg("colNm_NUM_PARAM4",rows[i].getString(colNm_NUM_PARAM4),this);
							cstmt.setString(25, iParamEmpno);
							cstmt.setString(26, iParamIp);
							cstmt.setString(27, "1");				
							cstmt.registerOutParameter(28,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(29,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(30,  java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
						    
						    
						 //	StringUtil.printMsg("24RETRUN:::",cstmt.getString(24),this);
						  //  StringUtil.printMsg("26RETRUN:::",cstmt.getString(26),this);
		                   
//					�޽���ó��
							if (cstmt.getString(28).equals("Y") ) {
							   if ( !cstmt.getString(29).equals("0000") ) {
								  GauceDataRow row2 = msgDS.newDataRow();
								  row2.addColumnValue(cstmt.getString(30));
								  msgDS.addDataRow(row2);
							   }
							  if(cstmt!=null) cstmt.close();
							}	

			
			
			
			
							if(cstmt!=null) cstmt.close();		
						
							break;
					  case GauceDataRow.TB_JOB_UPDATE:
						  //StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
						/*
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_DOC_GRD));
							cstmt.setString(3, rows[i].getString(colNm_DOC_FRM));
							cstmt.setString(4, rows[i].getString(colNm_DOC_TLE));
							cstmt.setString(5, rows[i].getString(colNm_DOC_CTS));
							cstmt.setString(6, rows[i].getString(colNm_DOC_KWD));
							cstmt.setString(7, rows[i].getString(colNm_FLE_DRC));
							cstmt.setString(8, rows[i].getString(colNm_RAL_DRC));
							cstmt.setString(9, rows[i].getString(colNm_FLE_NM));
							cstmt.setString(10, rows[i].getString(colNm_OWN_DPT));
							cstmt.setString(11, rows[i].getString(colNm_PRD_DPT));
							cstmt.setString(12, rows[i].getString(colNm_PRD_PSN));
							cstmt.setString(13, rows[i].getString(colNm_PRD_DT));
							cstmt.setString(14, rows[i].getString(colNm_PRS_YR_LMT));
							cstmt.setString(15, rows[i].getString(colNm_DOC_SGN_STS));
							cstmt.setString(16, rows[i].getString(colNm_CRT_DIV));
							cstmt.setString(17, rows[i].getString(colNm_USE_YN));
							cstmt.setString(18, rows[i].getString(colNm_DUS_DT));
							cstmt.setInt(19, rows[i].getInt(colNm_ORG_MGN_NO));
							cstmt.setInt(20, rows[i].getInt(colNm_RCP_RDG_SID));
							cstmt.setString(21, rows[i].getString(colNm_RCP_STS));
							cstmt.setString(22, rows[i].getString(colNm_SND_DIV));
							cstmt.setString(23, rows[i].getString(colNm_RCP_DPT));
							cstmt.setString(24, iParamEmpno);
							cstmt.setString(25, iParamIp);
							cstmt.setString(26, "1");		
										
						   cstmt.executeUpdate();
						   */
			
						   if(cstmt!=null) cstmt.close();	
						   break;
					  case GauceDataRow.TB_JOB_DELETE:
							StringUtil.printMsg("TB_JOB_DELETE::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
							/*
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_DOC_GRD));
							cstmt.setString(3, rows[i].getString(colNm_DOC_FRM));
							cstmt.setString(4, rows[i].getString(colNm_DOC_TLE));
							cstmt.setString(5, rows[i].getString(colNm_DOC_CTS));
							cstmt.setString(6, rows[i].getString(colNm_DOC_KWD));
							cstmt.setString(7, rows[i].getString(colNm_FLE_DRC));
							cstmt.setString(8, rows[i].getString(colNm_RAL_DRC));
							cstmt.setString(9, rows[i].getString(colNm_FLE_NM));
							cstmt.setString(10, rows[i].getString(colNm_OWN_DPT));
							cstmt.setString(11, rows[i].getString(colNm_PRD_DPT));
							cstmt.setString(12, rows[i].getString(colNm_PRD_PSN));
							cstmt.setString(13, rows[i].getString(colNm_PRD_DT));
							cstmt.setString(14, rows[i].getString(colNm_PRS_YR_LMT));
							cstmt.setString(15, rows[i].getString(colNm_DOC_SGN_STS));
							cstmt.setString(16, rows[i].getString(colNm_CRT_DIV));
							cstmt.setString(17, rows[i].getString(colNm_USE_YN));
							cstmt.setString(18, rows[i].getString(colNm_DUS_DT));
							cstmt.setInt(19, rows[i].getInt(colNm_ORG_MGN_NO));
							cstmt.setInt(20, rows[i].getInt(colNm_RCP_RDG_SID));
							cstmt.setString(21, rows[i].getString(colNm_RCP_STS));
							cstmt.setString(22, rows[i].getString(colNm_SND_DIV));
							cstmt.setString(23, rows[i].getString(colNm_RCP_DPT));
							cstmt.setString(24, iParamEmpno);
							cstmt.setString(25, iParamIp);
							cstmt.setString(26, "2");							
								
							cstmt.executeUpdate();
						   */
						  if(cstmt!=null) cstmt.close();	
						  break;						
				  }//switch(rows[i].getJobType()){
			  }
		  }//if (ds1 != null) {
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
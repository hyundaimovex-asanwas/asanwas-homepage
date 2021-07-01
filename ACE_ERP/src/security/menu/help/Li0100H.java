package security.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

public class Li0100H extends SuperServlet {

	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			
		//StringUtil.printMsg("start::","1",this);		

		//�������_���ڰ����� �⺻���� ��ȸ 
		arr_sql[0].append ("{call SECURITY.PR_LI0100HS_01(?) }" );
		
        //�������_���ڰ����� ���缱 ��ȸ 
		arr_sql[1].append ("{call SECURITY.PR_LI0100HS_02(?) }" );
		//�������_���ڰ����� ���缱 ��ȸ 
		arr_sql[6].append ("{call SECURITY.PR_LI0100HS_03(?,?,?,?) }" );
		
		
       //�������_���ڰ����� �⺻���� ��ȸ 
	    arr_sql[2].append ("{call SECURITY.PR_LI0200HS_01(?) }" );
	    
       //����_���ڰ����� �⺻���� ��ȸ 
	    arr_sql[3].append ("{call SECURITY.PR_LI0300HS_01(?,?) }" );
	    
		//�������_���ڰ����� �⺻���� ��ȸ_���źμ� LIST 
	    arr_sql[5].append ("{call SECURITY.PR_LI0200HS_02(?) }" );
		
		//������� ��� / ������� ��� / ������� ���  
		arr_sql[4].append ("{call SECURITY.PR_LI0100HI_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?) }");
        
   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("gauceName::",gauceName,this);

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){              //�������� ��ȸ 
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//StringUtil.printMsg("������ȸ::","����",this);
						int  v_doc_mag_sid		= HDUtil.nullCheckNum(req.getParameter("v_doc_mag_sid")); 		// ��Ϲ�ȣ
						cstmt.setInt(1, v_doc_mag_sid);
						
						//StringUtil.printMsg("v_doc_mag_sid",v_doc_mag_sid,this);
	
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}
					
					
					if(gauceName.equals("DS_DEFAULT2")){              //���缱��ȸ (
						cstmt = conn.prepareCall(arr_sql[1].toString());
	
						//StringUtil.printMsg("���缱��ȸ::","����",this);
	
						int  v_sid		= HDUtil.nullCheckNum(req.getParameter("v_sid")); 		// ��Ϲ�ȣ
	
						cstmt.setInt(1, v_sid);
	
						//StringUtil.printMsg("v_sid::",v_sid,this);

						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}
					
					
					if(gauceName.equals("DS_DEFAULT5")){              //���缱��ȸ ( 
						cstmt = conn.prepareCall(arr_sql[6].toString());

						//StringUtil.printMsg("���缱��ȸ2::","222222222",this);

						String  v_empno1		= HDUtil.nullCheckStr(req.getParameter("v_empno1")); 		// 
						String  v_empno2		= HDUtil.nullCheckStr(req.getParameter("v_empno2")); 		// 
						String  v_empno3		= HDUtil.nullCheckStr(req.getParameter("v_empno3"));  		// 
						String  v_empno4		= HDUtil.nullCheckStr(req.getParameter("v_empno4")); 		// 
				
				
						cstmt.setString(1, v_empno1);
						cstmt.setString(2, v_empno2);
						cstmt.setString(3, v_empno3);
						cstmt.setString(4, v_empno4);

						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}
					
					
					if(gauceName.equals("DS_DEFAULT3")){              //�������� ��ȸ 
						cstmt = conn.prepareCall(arr_sql[2].toString());
	
						//StringUtil.printMsg("������ȸ[2]::","����",this);
	
						int  v_dtb_mag_sid		= HDUtil.nullCheckNum(req.getParameter("v_dtb_mag_sid")); 		// ������ȣ
	
						cstmt.setInt(1, v_dtb_mag_sid);
		
						//StringUtil.printMsg("v_dtb_mag_sid",v_dtb_mag_sid,this);

						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}

					
					if(gauceName.equals("DS_DEFAULT4")){              //���� ��ȸ 
						cstmt = conn.prepareCall(arr_sql[3].toString());

						//StringUtil.printMsg("������ȸ::","DS_DEFAULT4",this);

						int  txt_rcp_rdg_sid		= HDUtil.nullCheckNum(req.getParameter("v_rcp_rdg_sid")); 		//���ſ�����ȣ 
						String  txt_rcp_dpt     	= HDUtil.nullCheckStr(req.getParameter("v_rcp_dpt")); 	        	//���źμ�

						cstmt.setInt(1, txt_rcp_rdg_sid);
						cstmt.setString(2, txt_rcp_dpt);

						//StringUtil.printMsg("txt_rcp_rdg_sid",txt_rcp_rdg_sid,this);
						//StringUtil.printMsg("txt_rcp_dpt",txt_rcp_dpt,this);

						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}
					
					
					if(gauceName.equals("DS_DEFAULT9")){              //���źμ���ȸ 
						cstmt = conn.prepareCall(arr_sql[5].toString());

						//StringUtil.printMsg("������ȸ[5]::","����",this);

						int  v_dtb_mag_sid	= HDUtil.nullCheckNum(req.getParameter("v_dtb_mag_sid")); 		// ������ȣ
						cstmt.setInt(1, v_dtb_mag_sid);
						//StringUtil.printMsg("v_dtb_mag_sid",v_dtb_mag_sid,this);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}					
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {	
		
      StringUtil.printMsg("# Command","����",this);
	  CallableStatement cstmt = null;	
	  ResultSet 			   rs 	= null;
	  
	  GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
	  
	
	  /** 
	   * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
	   **/
	  String iParamEmpno 	= fParamEmpno;
	  String iParamIp 	= fParamIp;
	  
	  StringUtil.printMsg("# Command","iParamEmpno::"+iParamEmpno,this);
	  StringUtil.printMsg("# Command","iParamIp::"+iParamIp,this);
			
	  /* DataSet */
	  GauceDataSet ds1 = req.getGauceDataSet("DS_APPROVE");
	                                                                     
	 
	  try{
		  if (ds1 != null) {
			  StringUtil.printMsg("ds1","ds1",this);
			  
			  GauceDataRow[] 		    rows = ds1.getDataRows();
			  GauceDataColumn[] 	cols = ds1.getDataColumns();
			  
			  res.enableFirstRow(msgDS);
		  	  msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
			  
			
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
	
			   
			  StringUtil.printMsg("colNm_DOC_SID",colNm_DOC_SID,this);

			  for(int i=0; i<rows.length; i++){
				  int j=1;
				  switch(rows[i].getJobType()){
					  case GauceDataRow.TB_JOB_INSERT:
				   	  
					       // StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);
						 	cstmt = conn.prepareCall(arr_sql[4].toString());
						 	
					       // StringUtil.printMsg("# Command","1",this);
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_SID));
							
					       // StringUtil.printMsg("# Command","2",this);
					        cstmt.setString(2, rows[i].getString(colNm_DOC_GU));
							cstmt.setString(3, rows[i].getString(colNm_DOC_GU2));
							cstmt.setString(4, rows[i].getString(colNm_AP_GU_1));
							cstmt.setInt(5, rows[i].getInt(colNm_AP_SEQ_1));
							cstmt.setString(6, rows[i].getString(colNm_AP_TYPE_1));
							cstmt.setString(7, rows[i].getString(colNm_AP_EMPNO_1));
							cstmt.setString(8, rows[i].getString(colNm_AP_GU_2));
							cstmt.setInt(9, rows[i].getInt(colNm_AP_SEQ_2));
							cstmt.setString(10, rows[i].getString(colNm_AP_TYPE_2));
							cstmt.setString(11, rows[i].getString(colNm_AP_EMPNO_2));
							cstmt.setString(12, rows[i].getString(colNm_AP_GU_3));
							cstmt.setInt(13, rows[i].getInt(colNm_AP_SEQ_3));
							cstmt.setString(14, rows[i].getString(colNm_AP_TYPE_3));
							cstmt.setString(15, rows[i].getString(colNm_AP_EMPNO_3));
							cstmt.setString(16, rows[i].getString(colNm_AP_GU_4));
							cstmt.setInt(17, rows[i].getInt(colNm_AP_SEQ_4));
							cstmt.setString(18, rows[i].getString(colNm_AP_TYPE_4));
							cstmt.setString(19, rows[i].getString(colNm_AP_EMPNO_4));
					        cstmt.setString(20, rows[i].getString(colNm_AP_STATUS_M));
					        cstmt.setString(21, iParamEmpno);
							cstmt.setString(22, iParamIp);
							cstmt.setString(23, "1");				
							cstmt.registerOutParameter(24,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(25,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(26,  java.sql.Types.VARCHAR);
							
						    cstmt.executeUpdate();
						    
						    
				         //	StringUtil.printMsg("24RETRUN:::",cstmt.getString(24),this);
					      //  StringUtil.printMsg("26RETRUN:::",cstmt.getString(26),this);
		                   
//					�޽���ó��
							if (cstmt.getString(24).equals("Y") ) {
							   if ( !cstmt.getString(25).equals("0000") ) {
								  GauceDataRow row2 = msgDS.newDataRow();
								  row2.addColumnValue(cstmt.getString(26));
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
	
	  } catch (SQLException sqle){
		  throw sqle;
	  } catch (Exception e) {
		  throw e;
	  } finally {
		  //msgDS.flush();
		  if(rs!=null) rs.close();
//					  if(stmt!=null) stmt.close();			
		  if(cstmt!=null) cstmt.close();
		  //if( fail == true ) throw new Exception("");			
	  }
		
	}
}
package pms.menu.cc;
//	si110i
//	si110i_h1 ���

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

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cc010I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//card list : Master ��ȸ
		arr_sql[0].append ("{call PMS.PR_CC010I_01(?,?,?,?,?,  ?) }" );
		
		//card operation authority : Detail ��ȸ
		arr_sql[1].append ("{call PMS.PR_CC010I_02(?,?) }" );

		//card list : Master ����
		arr_sql[2].append ("{call PMS.PR_CC010I_03(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?) }" );
		
		//card operation authority : Detail ����
		arr_sql[3].append ("{call PMS.PR_CC010I_04(?,?,?,?,?, ?) }" );
		
	}
	
	

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("�ʱ�ȭ~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds_cl")){
					GauceDataSet ds1 = gis.read("DS_CL");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "0");
					cstmt.setString(2, "");
					cstmt.setString(3, "");
					cstmt.setString(4, "");
					cstmt.setString(5, "");
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_coa")){	//work detail ��ȸ
					GauceDataSet ds1 = gis.read("DS_COA");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            }
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_cardspec 			= HDUtil.nullCheckStr(greq.getParameter("v_cardspec"));				// ī������
		String v_cadiv 				= HDUtil.nullCheckStr(greq.getParameter("v_cadiv"));				// ī�屸��
		String v_mgr_no 			= HDUtil.nullCheckStr(greq.getParameter("v_mgr_no"));				// ó���� ���
		String v_useyn 				= HDUtil.nullCheckStr(greq.getParameter("v_useyn"));				// ��� ����
		String v_card_num 			= HDUtil.nullCheckStr(greq.getParameter("v_card_num"));				// ī���ȣ
		int    v_ca_sid				= HDUtil.nullCheckNum(greq.getParameter("v_ca_sid"));				// ī��sid

		//���� ����
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;		
		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		//StringUtil.printMsg("v_date",v_date,this);
		//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_cl")){
					GauceDataSet ds1 = gis.read("DS_CL");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_cardspec);
					cstmt.setString(2, v_cadiv);
					cstmt.setString(3, v_mgr_no);
					cstmt.setString(4, v_useyn);
					cstmt.setString(5, v_card_num);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}

            	if(dSets[i].getName().equals("ds_coa")){
					GauceDataSet ds1 = gis.read("DS_COA");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_ca_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}

            }
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
		//StringUtil.printMsg("����~!","",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        GauceDataSet ds_cl= gis.read("DS_CL");
        GauceDataSet ds_coa= gis.read("DS_COA");
        
        
		try{
			if (ds_cl != null) {
				GauceDataRow[] 		rows = ds_cl.getDataRows();
				int colNm_job_sel		= ds_cl.indexOfColumn("job_sel");
				int colNm_ca_sid  		= ds_cl.indexOfColumn("ca_sid");
				int colNm_CACARDSPEC    = ds_cl.indexOfColumn("CACARDSPEC");
				int colNm_CADIV      	= ds_cl.indexOfColumn("CADIV");
				int colNm_CADEPTCD		= ds_cl.indexOfColumn("CADEPTCD");	//�����μ��ڵ�                    
				int colNm_CAEMPNO		= ds_cl.indexOfColumn("CAEMPNO");	//������ ���
				int colNm_CANBR    		= ds_cl.indexOfColumn("CANBR");  	//ī���ȣ
				int colNm_CAUSEYYMM   	= ds_cl.indexOfColumn("CAUSEYYMM");	//��ȿ�Ⱓ           
				int colNm_CAMAX   		= ds_cl.indexOfColumn("CAMAX");		//�ѵ�        
				int colNm_CAETC     	= ds_cl.indexOfColumn("CAETC");		//���      
				int colNm_CAISSYYMM    	= ds_cl.indexOfColumn("CAISSYYMM");	//�߱޳��    
				int colNm_CASTTDAT 		= ds_cl.indexOfColumn("CASTTDAT");	//��������     
				int colNm_CAACCBANK		= ds_cl.indexOfColumn("CAACCBANK");	//���������ڵ�
				int colNm_CABANKNO     	= ds_cl.indexOfColumn("CABANKNO");	//���¹�ȣ    
				int colNm_CACUST      	= ds_cl.indexOfColumn("CACUST");	//������         
				int colNm_VEND_NM   	= ds_cl.indexOfColumn("VEND_NM");	//�ŷ�ó��   
				int colNm_VEND_CD   	= ds_cl.indexOfColumn("VEND_CD");	//(ȸ��)�ŷ�ó�ڵ�        
				int colNm_USE_TAG       = ds_cl.indexOfColumn("USE_TAG");	//��뿩��
				int colNm_DSUDT        	= ds_cl.indexOfColumn("DSUDT");		//�������
				int jobtype = 3;
				
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("ds_cl "+i+"�� �۾�===",rows[i].getJobType(),this);
					//StringUtil.printMsg("colNm_job_sel",rows[i].getString(colNm_job_sel),this);
					if(rows[i].getString(colNm_job_sel).equals("T")){//chk�� üũ�Ǹ� �ű� �μ�Ʈ��.. �������� �� ������Ʈ
						jobtype = 2;
					}
					//StringUtil.printMsg("ds_cl "+i+"�� �۾�===",jobtype,this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					/*StringUtil.printMsg("colNm_ca_sid",rows[i].getInt(colNm_ca_sid),this);
					StringUtil.printMsg("colNm_CACARDSPEC",rows[i].getString(colNm_CACARDSPEC),this);
					StringUtil.printMsg("colNm_CADIV",rows[i].getString(colNm_CADIV),this);
					StringUtil.printMsg("colNm_CADEPTCD",rows[i].getString(colNm_CADEPTCD),this);
					StringUtil.printMsg("colNm_CAEMPNO",rows[i].getString(colNm_CAEMPNO),this);
					StringUtil.printMsg("colNm_CANBR",rows[i].getString(colNm_CANBR),this);
					StringUtil.printMsg("colNm_CAUSEYYMM",rows[i].getString(colNm_CAUSEYYMM),this);
					StringUtil.printMsg("colNm_CAMAX",rows[i].getInt(colNm_CAMAX),this);
					StringUtil.printMsg("colNm_CAETC",rows[i].getString(colNm_CAETC),this);
					StringUtil.printMsg("colNm_CAISSYYMM",rows[i].getString(colNm_CAISSYYMM),this);
					StringUtil.printMsg("colNm_CASTTDAT",rows[i].getString(colNm_CASTTDAT),this);
					StringUtil.printMsg("colNm_CAACCBANK",rows[i].getString(colNm_CAACCBANK),this);
					StringUtil.printMsg("colNm_CABANKNO",rows[i].getString(colNm_CABANKNO),this);
					StringUtil.printMsg("colNm_CACUST",rows[i].getString(colNm_CACUST),this);
					StringUtil.printMsg("colNm_VEND_NM",rows[i].getString(colNm_VEND_NM),this);
					StringUtil.printMsg("colNm_VEND_CD",rows[i].getString(colNm_VEND_CD),this);
					StringUtil.printMsg("colNm_USE_TAG",rows[i].getString(colNm_USE_TAG),this);
					StringUtil.printMsg("colNm_DSUDT",rows[i].getString(colNm_DSUDT),this);
					StringUtil.printMsg("jobtype",jobtype+"",this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);*/
					
					
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_ca_sid) );
					cstmt.setString(2, rows[i].getString(colNm_CACARDSPEC));
					cstmt.setString(3, rows[i].getString(colNm_CADIV));
					cstmt.setString(4, rows[i].getString(colNm_CADEPTCD));
					cstmt.setString(5, rows[i].getString(colNm_CAEMPNO));
					cstmt.setString(6, rows[i].getString(colNm_CANBR));
					cstmt.setString(7, rows[i].getString(colNm_CAUSEYYMM));
					cstmt.setInt(8, rows[i].getInt(colNm_CAMAX) );
					cstmt.setString(9, rows[i].getString(colNm_CAETC));	
					cstmt.setString(10, rows[i].getString(colNm_CAISSYYMM));
					cstmt.setString(11, rows[i].getString(colNm_CASTTDAT));
					cstmt.setString(12, rows[i].getString(colNm_CAACCBANK));
					cstmt.setString(13, rows[i].getString(colNm_CABANKNO));
					cstmt.setString(14, rows[i].getString(colNm_CACUST));
					cstmt.setString(15, rows[i].getString(colNm_VEND_NM));
					cstmt.setString(16, rows[i].getString(colNm_VEND_CD));
					cstmt.setString(17, rows[i].getString(colNm_USE_TAG));
					cstmt.setString(18, rows[i].getString(colNm_DSUDT));
					cstmt.setInt(19, jobtype );	//���콺�� �۾� ��
					cstmt.setString(20, iParamEmpno);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
				}
			}
			if (ds_coa != null) {
				GauceDataRow[] 		rows = ds_coa.getDataRows();
				int colNm_ca_sid  = ds_coa.indexOfColumn("ca_sid");
				int colNm_bgndate = ds_coa.indexOfColumn("bgndate");
				int colNm_enddate = ds_coa.indexOfColumn("enddate");                    
				int colNm_mgr_no  = ds_coa.indexOfColumn("mgr_no");
				
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_coa "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete

					//StringUtil.printMsg("colNm_mgr_no",rows[i].getString(colNm_mgr_no),this);
					/*StringUtil.printMsg("colNm_dwr_sid",rows[i].getInt(colNm_dwr_sid),this);
					StringUtil.printMsg("colNm_wd_code",rows[i].getString(colNm_wd_code),this);
					StringUtil.printMsg("colNm_wd_now",rows[i].getString(colNm_wd_now),this);
					
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					*/
					//StringUtil.printMsg("iParamIp",iParamIp,this);
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					cstmt.setInt(1, rows[i].getInt(colNm_ca_sid) );
					cstmt.setString(2, rows[i].getString(colNm_bgndate));
					cstmt.setString(3, rows[i].getString(colNm_enddate));
					cstmt.setString(4, rows[i].getString(colNm_mgr_no));
					cstmt.setInt(5, rows[i].getJobType() );	//���콺�� �۾� ��
					cstmt.setString(6, iParamEmpno);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
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
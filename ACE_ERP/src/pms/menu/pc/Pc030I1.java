package pms.menu.pc;

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

public class Pc030I1 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PC030I_01(?,?,?,?,?, ?,?) }" );

		//������ ��ȸ
		arr_sql[1].append ("{call PMS.PR_PC030I_02(?, ?) }" );

		//Main ����
		arr_sql[2].append ("{call PMS.PR_PC030I_03(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?) }");
		//Detail ����
		arr_sql[3].append ("{call PMS.PR_PC030I_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?) }");

   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender)
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "19990101");
					cstmt.setString(2, "19990101");
					cstmt.setString(3, "");
					cstmt.setInt(4, 0);
					cstmt.setString(5, "");
					cstmt.setString(6, "");
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_tender")){
					GauceDataSet ds1 = gis.read("DS_TENDER");
					
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
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender)
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// ���� SID
					String v_bid_kind_cd 	= HDUtil.nullCheckStr(greq.getParameter("v_bid_kind_cd")); 	//  ǰ�� (����)
					String v_fr_bid_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_bid_date")); 	// �������� ����
					String v_to_bid_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_bid_date")); 			// �������� ����
					String v_bid_style		= HDUtil.nullCheckStr(greq.getParameter("v_bid_style")); 		// ��������(����)
					String v_bid_status		= HDUtil.nullCheckStr(greq.getParameter("v_bid_status")); 		// ��������

					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_bid_date);
					cstmt.setString(2, v_to_bid_date);
					cstmt.setString(3, v_bid_style);
					cstmt.setInt(4, v_site_sid);
					cstmt.setString(5, v_bid_kind_cd);
					cstmt.setString(6, v_bid_status);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));					
            	}
            	if(dSets[i].getName().equals("ds_tender")){
					GauceDataSet ds1 = gis.read("DS_TENDER");
					int v_bid_sid = HDUtil.nullCheckNum(greq.getParameter("v_bid_sid"));			// ���� SID
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_bid_sid);
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
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		//GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
			
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		GauceDataSet ds2 = gis.read("DS_TENDER");

		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_BID_SID        = ds1.indexOfColumn("BID_SID");
				int colNm_BID_DAY        = ds1.indexOfColumn("BID_DAY"); //����
				int colNm_BID_STYLE      = ds1.indexOfColumn("BID_STYLE");  // ����
				int colNm_SITE_SID       = ds1.indexOfColumn("SITE_SID"); //����SID
				int colNm_SITE_SEQ_CT    = ds1.indexOfColumn("SITE_SEQ_CT"); //�������
				int colNm_SITE_SEQ_CH    = ds1.indexOfColumn("SITE_SEQ_CH"); //��������
				int colNm_DATE_BEGIN     = ds1.indexOfColumn("DATE_BEGIN");    //��ǰ ������
				int colNm_DATE_END       = ds1.indexOfColumn("DATE_END");     //��ǰ ������
				int colNm_CT_KIND        = ds1.indexOfColumn("CT_KIND");  //ǰ��
				int colNm_BID_STATUS     = ds1.indexOfColumn("BID_STATUS");   //��������
				int colNm_ACT_AMT        = ds1.indexOfColumn("ACT_AMT");  //����
				int colNm_ACT_AMT_KOR    = ds1.indexOfColumn("ACT_AMT_KOR");  //����(��)
				int colNm_ACT_AMT_HA     = ds1.indexOfColumn("ACT_AMT_HA"); //����
				int colNm_ACT_AMT_HA_KOR = ds1.indexOfColumn("ACT_AMT_HA_KOR"); //����(��)
					
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);

				for(int i=0; i<rows.length; i++){
					int j=1;
					StringUtil.printMsg("ds1�� "+i+"�� �۾�===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_BID_SID));
							cstmt.setString(2, rows[i].getString(colNm_BID_DAY));
							cstmt.setString(3, rows[i].getString(colNm_BID_STYLE));
							cstmt.setInt(4, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_SEQ_CT));
							cstmt.setString(6, rows[i].getString(colNm_SITE_SEQ_CH));
							cstmt.setString(7, rows[i].getString(colNm_DATE_BEGIN));
							cstmt.setString(8, rows[i].getString(colNm_DATE_END));
							cstmt.setString(9, rows[i].getString(colNm_CT_KIND));
							cstmt.setString(10, rows[i].getString(colNm_BID_STATUS));
							cstmt.setInt(11, rows[i].getInt(colNm_ACT_AMT));
							cstmt.setString(12, rows[i].getString(colNm_ACT_AMT_KOR));
							cstmt.setInt(13, rows[i].getInt(colNm_ACT_AMT_HA));
							cstmt.setString(14, rows[i].getString(colNm_ACT_AMT_HA_KOR));
							cstmt.setString(15, iParamEmpno);
							cstmt.setString(16, iParamIp);
							cstmt.setString(17, "1");
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
							cstmt.setInt(1, rows[i].getInt(colNm_BID_SID));
							cstmt.setString(2, rows[i].getString(colNm_BID_DAY));
							cstmt.setString(3, rows[i].getString(colNm_BID_STYLE));
							cstmt.setInt(4, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_SEQ_CT));
							cstmt.setString(6, rows[i].getString(colNm_SITE_SEQ_CH));
							cstmt.setString(7, rows[i].getString(colNm_DATE_BEGIN));
							cstmt.setString(8, rows[i].getString(colNm_DATE_END));
							cstmt.setString(9, rows[i].getString(colNm_CT_KIND));
							cstmt.setString(10, rows[i].getString(colNm_BID_STATUS));
							cstmt.setInt(11, rows[i].getInt(colNm_ACT_AMT));
							cstmt.setString(12, rows[i].getString(colNm_ACT_AMT_KOR));
							cstmt.setInt(13, rows[i].getInt(colNm_ACT_AMT_HA));
							cstmt.setString(14, rows[i].getString(colNm_ACT_AMT_HA_KOR));
							cstmt.setString(15, iParamEmpno);
							cstmt.setString(16, iParamIp);
							cstmt.setString(17, "3");
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
							cstmt.setInt(1, rows[i].getInt(colNm_BID_SID));
							cstmt.setString(2, rows[i].getString(colNm_BID_DAY));
							cstmt.setString(3, rows[i].getString(colNm_BID_STYLE));
							cstmt.setInt(4, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_SEQ_CT));
							cstmt.setString(6, rows[i].getString(colNm_SITE_SEQ_CH));
							cstmt.setString(7, rows[i].getString(colNm_DATE_BEGIN));
							cstmt.setString(8, rows[i].getString(colNm_DATE_END));
							cstmt.setString(9, rows[i].getString(colNm_CT_KIND));
							cstmt.setString(10, rows[i].getString(colNm_BID_STATUS));
							cstmt.setInt(11, rows[i].getInt(colNm_ACT_AMT));
							cstmt.setString(12, rows[i].getString(colNm_ACT_AMT_KOR));
							cstmt.setInt(13, rows[i].getInt(colNm_ACT_AMT_HA));
							cstmt.setString(14, rows[i].getString(colNm_ACT_AMT_HA_KOR));
							cstmt.setString(15, iParamEmpno);
							cstmt.setString(16, iParamIp);
							cstmt.setString(17, "2");
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			
			if (ds2 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
					
			
				int colNm_BID_SID	      	= ds2.indexOfColumn("BID_SID");	       	// ���� SID
				int colNm_COOP_SID      	= ds2.indexOfColumn("COOP_SID");       	// ���� ��ü SID
				int colNm_SEQ        		= ds2.indexOfColumn("SEQ");        			// ���� ���
				int colNm_BID_AMT			= ds2.indexOfColumn("BID_AMT");					// 1�� ���� �ݾ�
				int colNm_BID_AMT_PCT1		= ds2.indexOfColumn("BID_AMT_PCT1");		// �������
				int colNm_BID_AMT_PCT2  	= ds2.indexOfColumn("BID_AMT_PCT2");    // ������
				int colNm_BID_AMT2      	= ds2.indexOfColumn("BID_AMT2");       	// 2�� ���� �ݾ�
				int colNm_BID_AMT2_PCT1 	= ds2.indexOfColumn("BID_AMT2_PCT1");   // �������
				int colNm_BID_AMT2_PCT2 	= ds2.indexOfColumn("BID_AMT2_PCT2");   // ������
				int colNm_RESULT_CP     	= ds2.indexOfColumn("RESULT_CP");      	// ���� ���
				int colNm_RESULT_AMT    	= ds2.indexOfColumn("RESULT_AMT");     	// ���� �ݾ�
				int colNm_RESULT_AMT_KOR	= ds2.indexOfColumn("RESULT_AMT_KOR");  // ���� �ݾ� �ѱ�
				int colNm_RECO_CD       	= ds2.indexOfColumn("RECO_CD");        	// ��õ�μ� CODE
				int colNm_REMARK     		= ds2.indexOfColumn("REMARK");     			// ���	

				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_BID_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_COOP_SID));
						cstmt.setInt(3, rows[i].getInt(colNm_SEQ));
						cstmt.setInt(4, rows[i].getInt(colNm_BID_AMT));
						cstmt.setDouble(5, rows[i].getDouble(colNm_BID_AMT_PCT1));	//�Ҽ��� ó��
						cstmt.setDouble(6, rows[i].getDouble(colNm_BID_AMT_PCT2));	//�Ҽ��� ó��
						cstmt.setInt(7, rows[i].getInt(colNm_BID_AMT2));
						cstmt.setDouble(8, rows[i].getDouble(colNm_BID_AMT2_PCT1));	//�Ҽ��� ó��
						cstmt.setDouble(9, rows[i].getDouble(colNm_BID_AMT2_PCT2));	//�Ҽ��� ó��
						cstmt.setString(10, rows[i].getString(colNm_RESULT_CP));
						cstmt.setInt(11, rows[i].getInt(colNm_RESULT_AMT));
						cstmt.setString(12, rows[i].getString(colNm_RESULT_AMT_KOR));
						cstmt.setString(13, rows[i].getString(colNm_RECO_CD));
						cstmt.setString(14, rows[i].getString(colNm_REMARK));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "1");
									
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
							
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_BID_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_COOP_SID));
						cstmt.setInt(3, rows[i].getInt(colNm_SEQ));
						cstmt.setInt(4, rows[i].getInt(colNm_BID_AMT));
						cstmt.setDouble(5, rows[i].getDouble(colNm_BID_AMT_PCT1));	//�Ҽ��� ó��
						cstmt.setDouble(6, rows[i].getDouble(colNm_BID_AMT_PCT2));	//�Ҽ��� ó��
						cstmt.setInt(7, rows[i].getInt(colNm_BID_AMT2));
						cstmt.setDouble(8, rows[i].getDouble(colNm_BID_AMT2_PCT1));	//�Ҽ��� ó��
						cstmt.setDouble(9, rows[i].getDouble(colNm_BID_AMT2_PCT2));	//�Ҽ��� ó��
						cstmt.setString(10, rows[i].getString(colNm_RESULT_CP));
						cstmt.setInt(11, rows[i].getInt(colNm_RESULT_AMT));
						cstmt.setString(12, rows[i].getString(colNm_RESULT_AMT_KOR));
						cstmt.setString(13, rows[i].getString(colNm_RECO_CD));
						cstmt.setString(14, rows[i].getString(colNm_REMARK));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "3");

						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_BID_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_COOP_SID));
						cstmt.setInt(3, rows[i].getInt(colNm_SEQ));
						cstmt.setInt(4, rows[i].getInt(colNm_BID_AMT));
						cstmt.setDouble(5, rows[i].getDouble(colNm_BID_AMT_PCT1));	//�Ҽ��� ó��
						cstmt.setDouble(6, rows[i].getDouble(colNm_BID_AMT_PCT2));	//�Ҽ��� ó��
						cstmt.setInt(7, rows[i].getInt(colNm_BID_AMT2));
						cstmt.setDouble(8, rows[i].getDouble(colNm_BID_AMT2_PCT1));	//�Ҽ��� ó��
						cstmt.setDouble(9, rows[i].getDouble(colNm_BID_AMT2_PCT2));	//�Ҽ��� ó��
						cstmt.setString(10, rows[i].getString(colNm_RESULT_CP));
						cstmt.setInt(11, rows[i].getInt(colNm_RESULT_AMT));
						cstmt.setString(12, rows[i].getString(colNm_RESULT_AMT_KOR));
						cstmt.setString(13, rows[i].getString(colNm_RECO_CD));
						cstmt.setString(14, rows[i].getString(colNm_REMARK));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "2");

						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}	//if (ds2 != null) {
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
			//if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
}
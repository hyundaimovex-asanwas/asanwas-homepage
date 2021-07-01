package sales.menu.rm;
/***********************************************************************
 * 	Ȩ>����>����>�������>ȣ�ں� �������
 * 2017.02.20
************************************************************************/
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


public class Rm210I extends SuperServlet {
	private static final long serialVersionUID = 1L;

    public void makeSql(){
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;

		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		// �����sid, ����� ����
		arr_sql[0].append ("SELECT saup_sid, saup_nm FROM SALES.TSY200 ORDER BY saup_sid \n");
		
		// ������� ����
		arr_sql[1].append ("SELECT upjang_sid, upjang_nm FROM SALES.TRM010 WHERE upjang_type='10' \n");

		// �⺻ ��ȸ - ȣ�ں� ������ȸ
		arr_sql[2].append ("{call SALES.PR_RM210I_01(?,?,?,?,?) }" );
		
		// ȣ�ں� ���� ������Ʈ
		arr_sql[3].append ("{call SALES.PR_RM210I_02(?,?,?,?,?,   ?) }" );

   }

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command : ","����ȸ",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		// �˻��� �ʿ��� ����
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int sSaupSid = HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));		// ������ڵ�
		String sHead = HDUtil.nullCheckStr(greq.getParameter("sHead"));		// Head			
		String sDetail = HDUtil.nullCheckStr(greq.getParameter("sDetail"));		// Detail

		//StringUtil.printMsg("dsType- ",dsType , this);  
		//StringUtil.printMsg("sSaupSid- ",sSaupSid , this);

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
		GauceDataSet ds1 = null;
		try {
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset(TSY010)
			
			switch(dsType) {
				case 2 : //������ȸ
				if (sSaupSid!=0) 
					arr_sql[1].append ("	AND SAUP_SID = ?	\n");
				arr_sql[1].append (" ORDER BY  upjang_sid \n");
				cstmt = conn.prepareCall(arr_sql[1].toString());				

				if (sSaupSid!=0)
					cstmt.setInt(1, sSaupSid);
				rs = cstmt.executeQuery();				//������ ��ȸ 
				gos.write(getDataSet(rs, ds1));
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

	
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		StringUtil.printMsg("# Command : ","��ȸ",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;

		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		// �˻��� ����
		int 	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));	//����� ���̵�	20071112 �߰�
		int 	sUpjangSid  = HDUtil.nullCheckNum(greq.getParameter("sUpjangSid"));	//����� ���̵�	20071112 �߰�
		String 	sBgnUseDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnUseDate"));
		String 	sEndUseDate	= HDUtil.nullCheckStr(greq.getParameter("sEndUseDate"));
		
		/*
		StringUtil.printMsg("sSaupSid",sSaupSid,this);
		StringUtil.printMsg("sUpjangSid",sUpjangSid,this);
		StringUtil.printMsg("sBgnUseDate",sBgnUseDate,this);
		StringUtil.printMsg("sEndUseDate",sEndUseDate,this);
		*/
		
		try {
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");

					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, sSaupSid);
					cstmt.setInt(2, sUpjangSid);
					cstmt.setString(3, sBgnUseDate);
					cstmt.setString(4, sEndUseDate);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//���ν��� ��ȸ-Ŀ�� OUT param. 			
					//rs = cstmt.executeQuery();				//������ ��ȸ 
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
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* 2013.10.22 �ɵ���
		 * �̷��� TR�� ȣ���մϴ�. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	���� gis.read�� �������� ��.
		 * 
		 * */
		StringUtil.printMsg("# Command","����",this);
		
		CallableStatement 	cstmt 	= null;	
		GauceStatement 		stmt 	= null;
		ResultSet 			rs 		= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        //JSP(I:DEFAULT=ds2,O:msgDS=msgDS)
		GauceDataSet inputDs = gis.read("DEFAULT");
		

		boolean fail=false;	//���� ó����
	
		
		try{
			inner: {	//���ܽ� break
			
			if(inputDs!=null){

				int colNm_SaupSid 		= inputDs.indexOfColumn("saup_sid");	
				int colNm_UpjangSid 	= inputDs.indexOfColumn("upjang_sid");	
				int colNm_UseDate 		= inputDs.indexOfColumn("use_date");	
				int colNm_SeasonCd 		= inputDs.indexOfColumn("season_cd");
				int colNm_SeasonCdStu 	= inputDs.indexOfColumn("season_cd_stu");

				GauceDataRow[] 		rows = inputDs.getDataRows();

				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){

					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","������Ʈ",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						
						cstmt.setInt(1, rows[i].getInt(colNm_SaupSid));
						cstmt.setInt(2, rows[i].getInt(colNm_UpjangSid));
						cstmt.setString(3, rows[i].getString(colNm_UseDate));
						cstmt.setString(4, rows[i].getString(colNm_SeasonCd));
						cstmt.setString(5, rows[i].getString(colNm_SeasonCdStu));
						cstmt.setString(6, iParamEmpno);
						cstmt.executeUpdate();

						if(cstmt!=null) cstmt.close();
						break;
					}
				}
			}
			gos.close();
			}
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
			//if( fail == true ) throw new Exception("");			
		}
		
	}
	
	
	
}

package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class tr00101_s1e3 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //�ŷ�ó �ڵ�
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }//�ŷ�ó��
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }//�ŷ�ó��
				 
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CORP_CD","VEND_GB","VEND_CD","VEND_NM","VD_DIRECT","BSNS_CND" , "VEND_PRS","VEND_PST","VEND_TEL","VEND_CPHN","VEND_FAX","VEND_EMAIL","VEND_LCT","PROJECT","EXT_TEX1","EXT_TEX2","EXT_TEX3","REMARK","ADDRESS1","ADDRESS2","VEND_ID"}; 

				int[] intArrCN = new int[] { 6,1,13,32,12,22,20,20,13,13,13,20,10,10,20,20,20,20 ,35 ,35,10  }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 ,-1,-1,-1  }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {	
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT '' AS CORP_CD,'' AS VEND_GB,A.VEND_CD, \n " )
					   .append("		A.VEND_NM,A.VD_DIRECT,A.BSNS_CND, \n " )
					   .append("		B.VEND_PRS,B.VEND_PST,B.VEND_TEL, \n " )
					   .append("		B.VEND_CPHN,B.VEND_FAX,B.VEND_EMAIL,'' as VEND_LCT,B.PROJECT_CD AS PROJECT, \n " )
					   .append(" 		'' AS EXT_TEX1,'' AS EXT_TEX2,'' AS EXT_TEX3,B.REMARK, \n" )
					   .append(" 		NVL(A.ADDRESS1,'') AS ADDRESS1,NVL(A.ADDRESS2,'') AS ADDRESS2, \n")
					   .append(" 		A.VEND_ID \n")
					   .append("   FROM ACCOUNT.GCZM_VENDER A \n" )
					   .append("   LEFT JOIN TRANSFER.LTCUSTMST B ON A.VEND_CD = B.VEND_CD  \n" )
					   .append("  WHERE A.VEND_CD IS NOT NULL \n " ); 

					if(str1 != null )       sql.append( " AND A.VEND_CD LIKE '" + str1 + "%' \n" ) ; 
					if(str2 != null )       sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%' " ) ; 
					if(str3 != null )       sql.append( " AND A.VEND_NM = '" + str3 + "' " ) ; 
					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}
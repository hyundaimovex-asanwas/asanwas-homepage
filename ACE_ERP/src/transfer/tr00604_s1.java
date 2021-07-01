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
public class tr00604_s1 extends HttpServlet {

	// ���������� ���� ���۹���� Get Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;
		GauceStatement gstmt =null;
		GauceDataSet dSet = null;
		StringBuffer query = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				gconn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }

				String  gstr1	= req.getParameter("v_str1");
				String  gstr2	= req.getParameter("v_str2");
				String  gstr3	= req.getParameter("v_str3");

				GauceRes.enableFirstRow(dSet);

				// ������ ��ȸ�� �ؾ� �� �÷��� Ÿ�Ժ��� ����
				String[] strArrCN = new String[]{ "APPL_NO", "ITEM_SEQ", "LINE_PART", "ITEM_DIV", "ITEM_NM" 
													, "HS_CODE", "MODEL_NM", "ITEM_SPC", "SERIAL_NO", "CPU_SPC"
														, "HARD_SPC", "RAM_SPC", "ITEM_UNIT", "ITEM_QTY", "UNIT_PRICE"
															, "ITEM_PRICE", "MANG_NM", "USE_PPS", "APPL_DT", "ETD_DT"
																, "REMARK", "CREATE_DT", "CREATE_USR", "UPDATE_DT", "UPDATE_USR"
																	,"I_DIV", "A_DT", "L_PART", "AA"
				
												}; 
				int[] intArrCN	= new int[]{  10,  4,  4,  1,  50,
												  10,  50,  50,  50,  50,
														20, 20, 20, 13, 13,
															13, 50, 100, 8, 8,
																100, 10, 10, 10, 10,
																	30, 30, 30, 30
												


															
													}; 
				int[] intArrCN2 = new int[]{ -1, 0, -1, -1, -1,
												 -1, -1, -1, -1, -1,
													-1, -1, -1, 2, 2,
														2, -1, -1, -1, -1,
															-1, -1, -1, -1, -1,
																-1, -1, -1, -1

																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING,intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				// ���� ������ �ۼ�
		   		if (isNotOnlyHeader) {					
					query = new StringBuffer();

					query.append(" SELECT A.APPL_NO, COALESCE(A.ITEM_SEQ,0) ITEM_SEQ, A.LINE_PART, A.ITEM_DIV, A.ITEM_NM \n ");
					query.append(" , A.HS_CODE, A.MODEL_NM, A.ITEM_SPC, A.SERIAL_NO, A.CPU_SPC \n ");
					query.append(" , A.HARD_SPC, A.RAM_SPC, A.ITEM_UNIT, COALESCE(A.ITEM_QTY,0) ITEM_QTY, COALESCE(A.UNIT_PRICE,0) UNIT_PRICE  \n ");
					query.append(" , COALESCE(A.ITEM_PRICE,0) ITEM_PRICE, A.MANG_NM, A.USE_PPS, A.APPL_DT, A.ETD_DT  \n ");
					query.append(" , A.REMARK, A.CREATE_DT, A.CREATE_USR, A.UPDATE_DT, A.UPDATE_USR \n ");
					query.append(" , CASE A.ITEM_DIV \n ");
					query.append("  WHEN 'C' THEN '��ǻ��' \n ");
					query.append(" ELSE '�Ϲݹ���' END I_DIV, \n ");
					query.append(" SUBSTR(A.APPL_DT,1,4)||'.'||SUBSTR(A.APPL_DT,5,2)||'.'||SUBSTR(A.APPL_DT,7,2) AS A_DT, \n ");
					query.append(" B.MINORNM L_PART,  \n ");
					query.append(" CASE A.LINE_PART \n ");
					query.append(" WHEN '0001' THEN '��������' \n ");
					query.append(" WHEN '0002' THEN '�ݰ�������' \n "); 
					query.append(" WHEN '0004' THEN '��������' \n ");  
					query.append(" ELSE '' END AA \n ");  
						
					query.append(" FROM TRANSFER.LTSTRITEM  A ");
					query.append(" LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.LINE_PART AND B.MAJORCD = '0002' \n ");

					query.append(" WHERE A.LINE_PART <> '' ");


				 if (gstr1 != null && !gstr1.equals("")) query.append( "  AND  A.LINE_PART =  '"+gstr1+"'  \n");//null�� üũ
				// if (gstr1 != null && !gstr1.equals("")) query.append( "  AND '"+gstr1+"' BETWEEN FROM_CBM AND TO_CBM  \n");//null�� üũ
				 if (gstr2 != null && !gstr2.equals("")) query.append( "  AND  A.ITEM_DIV =  '"+gstr2+"'  \n");//null�� üũ
				 //if (gstr2 != null && !gstr2.equals("")) query.append( "  AND '"+gstr2+"' BETWEEN FROM_CBM AND TO_CBM  \n");//null�� üũ
				   
				 if (gstr3 != null && !gstr3.equals("")) query.append( "  AND  A.ITEM_NM LIKE '%"+gstr3+"%'  \n");
			
				// if (!gstr1.equals("")) query.append("		AND RELPART = '" + gstr1 + "'") ;
				//null���� ������ ������ �ǹ����� ���� ��ȸ�Ҷ� �����Ͱ� �ȳ��´�
				    query.append(" ORDER BY A.APPL_NO ASC ") ; 
//if (isDebug) { GauceRes.writeException("Sql",":",query.toString()); }

//logger.dbg.println(this,sql.toString());

/*********************************************************************************************/

					gstmt = gconn.getGauceStatement(query.toString());
	 		    gstmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
				if (gconn != null) try {gconn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit( );
		  GauceRes.close();

		} catch (Exception e) {

			// GAUCE30/LOG/ERROR.LOG ȭ�Ϸ� �޼��� Ȯ��
			logger.err.println(this,e);

			// GAUCE30/LOG/DEBUG.LOG ȭ�Ϸ� �޼��� Ȯ��
			logger.dbg.println(this,e.toString());

		} finally {

			loader.restoreService(service);
  	}
	}
}




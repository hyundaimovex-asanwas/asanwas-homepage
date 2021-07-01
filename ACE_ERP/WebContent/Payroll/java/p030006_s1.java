package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p030006_s1 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//�����
				str[1]	= req.getParameter("v_str2");		//���


	/*	gcds_data.DataID = "/services/servlet/Payroll.p030006_s3";
		gcds_data.Reset();

		var str1 = gcem_curdt.text;		//������
		var str2 = txt_empnno1.value;	//���
		
		gcds_data02.DataID = "/services/servlet/Payroll.p030006_s1?v_str1="+gs_date+"&v_str2="+str2;
		gcds_data02.Reset();

*/

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
					"EMPNO","EMPNMK","RESINO","DEPTNM",//"PAYGNM",
					"PC11000","PC12000",
					"PBC1000","TWKSUM","PC21000","PC22000","PB20000",
					"PB30000","BAAMT01","BAAMT02","CNT01","BAAMT03",
					"CNT02","ADAMT01","AD0103CNT","ADAMT02","ADAMT03",
					"AD0105CNT","ADAMT04","ADAMT05","PENSUM","INSSUM",
					"EDUSUM","HOUSUM","CONSUM","MARSUM","STDSUM",
					"OFFSUM","ETCAMT011","ETCAMT01","ETCAMT02","ETCAMT03",
					"ETCAMT04","TSTDSUM","STDTAX","DEDAMT01","DEDAMT02",
					"DEDAMT03","DEDAMT05","DEDSUM","PB41000","PB42000",
					"PB43000","APPDT"		//46
				};

				int[] intArrCN = new int[]{  
						7,	//���
					 20,	//����
					 13,	//�ֹι�ȣ
					 30,	//�μ���
					 //30,	//����
						9,	//���ٹ��޿�		
						9,	//���ٹ���		
						9,	//�޿��Ѱ�		
						9,	//�հ�(��+��)		
						9,	//�߱ٱٷμҵ�		
						9,	//��Ÿ�����		
						9,	//�ٷμҵ����		
						9,	//�ٷμҵ�ݾ�		
						9,	//���ΰ���		
						9,	//����ڰ���		
						9,	//�ξ簡���ο�	        
						9,	//�ξ簡������		
						9,	//��ο���ο�		
						9,	//��ο�����		
						9,	//������ο�		
						9,	//����ο�����	
						9,	//�γ��ڰ���		
						9,	//�ڳ�������ο�	
						9,	//�ڳ���������	
						9,	//�Ҽ��������߰�����	
						9,	//���ݺ�������	
						9,	//��������		
						9,	//���������		
						9,	//�����ڱݰ���		
						9,	//��αݰ���		
						9,	//ȥ���̻���ʺ�	
						9,	//ǥ�ذ���		
						9,	//�����ҵ�		
						9,	//���ο�������ҵ����	
						9,	//�����������		
						9,	//�������հ���		
						9,	//�ſ�ī�����		
						9,	//�츮���ְ���		
						9,	//���ռҵ����ǥ��	
						9,	//���⼼��		
						9,	//�ٷμҵ漼�װ���	
						9,	//�������հ���		
						9,	//�������Ա�		
						9,	//�ܱ�����		
						9,	//���װ�����		
						9,	//�����ҵ漼		
						9,	//�����ֹμ�		
						9,		//������Ư��
						6
         }; 
				
				int[] intArrCN2 = new int[]{ 
					 -1,	//���
				 	 -1,	//����
					 -1,	//�ֹι�ȣ
					 -1,	//�μ���
					 //-1,  //����
						0,	//���ٹ��޿�		
						0,	//���ٹ���		
						0,	//�޿��Ѱ�		
						0,	//�հ�(��+��)		
						0,	//�߱ٱٷμҵ�		
						0,	//��Ÿ�����		
						0,	//�ٷμҵ����		
						0,	//�ٷμҵ�ݾ�		
						0,	//���ΰ���		
						0,	//����ڰ���		
						0,	//�ξ簡���ο�	        
						0,	//�ξ簡������		
						0,	//��ο���ο�		
						0,	//��ο�����		
						0,	//������ο�		
						0,	//����ο�����	
						0,	//�γ��ڰ���		
						0,	//�ڳ�������ο�	
						0,	//�ڳ���������	
						0,	//�Ҽ��������߰�����	
						0,	//���ݺ�������	
						0,	//��������		
						0,	//���������		
						0,	//�����ڱݰ���		
						0,	//��αݰ���		
						0,	//ȥ���̻���ʺ�	
						0,	//ǥ�ذ���		
						0,	//�����ҵ�		
						0,	//���ο�������ҵ����	
						0,	//�����������		
						0,	//�������հ���		
						0,	//�ſ�ī�����		
						0,	//�츮���ְ���		
						0,	//���ռҵ����ǥ��	
						0,	//���⼼��		
						0,	//�ٷμҵ漼�װ���	
						0,	//�������հ���		
						0,	//�������Ա�		
						0,	//�ܱ�����		
						0,	//���װ�����		
						0,	//�����ҵ漼		
						0,	//�����ֹμ�		
						0,	//������Ư��
					 -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT																\n");
						sql.append(" B.EMPNO,															\n");
						sql.append(" A.EMPNMK,														\n");
						sql.append(" B.RESINO,														\n");
						sql.append(" RTRIM(C.DEPTNM) DEPTNM,		--�μ���	\n");
						//sql.append(" RTRIM(D.MINORNM) PAYGNM,		--����		\n");
						sql.append(" B.PC11000,   --���ٹ��޿�						\n");
						sql.append(" B.PC12000,   --���ٹ���						\n");
						sql.append(" B.PBC1000,   --�޿��Ѱ�							\n");
						sql.append(" B.TWKSUM,    --�հ�(��+��)						\n");
						sql.append(" B.PC21000,   --�߱ٱٷμҵ�					\n");
						sql.append(" B.PC22000,   --��Ÿ�����						\n");
						sql.append(" B.PB20000,   --�ٷμҵ����					\n");
						sql.append(" B.PB30000,   --�ٷμҵ�ݾ�					\n");
						sql.append(" B.BAAMT01,   --���ΰ���							\n");
						sql.append(" B.BAAMT02,   --����ڰ���						\n");
						sql.append(" B.BA0102CNT+B.BA0103CNT+B.BA0104CNT+B.BA0105CNT AS CNT01, --�ξ簡���ο�	\n");
						sql.append(" B.BAAMT03,   --�ξ簡������					\n");
						sql.append(" B.AD0101CNT+B.AD0102CNT AS CNT02,  --��ο���ο�	\n");
						sql.append(" B.ADAMT01,   --��ο�����					\n");
						sql.append(" B.AD0103CNT, --������ο�						\n");
						sql.append(" B.ADAMT02,   --����ο�����				\n");
						sql.append(" B.ADAMT03,   --�γ��ڰ���						\n");
						sql.append(" B.AD0105CNT, --�ڳ�������ο�				\n");
						sql.append(" B.ADAMT04,   --�ڳ���������				\n");
						sql.append(" B.ADAMT05,   --�Ҽ��������߰�����		\n");
						sql.append(" B.PENSUM,    --���ݺ�������				\n");
						sql.append(" B.INSSUM,    --������(��������)	\n");
						sql.append(" B.EDUSUM,    --�������(���������)	\n");
						sql.append(" B.HOUSUM,    --�����ڱݰ�(�����ڱݰ���)	\n");
						sql.append(" B.CONSUM,    --��αݰ�(��αݰ���)			\n");
						sql.append(" B.MARSUM,    --ȥ������̻��(ȥ���̻���ʺ�)	\n");
						sql.append(" B.STDSUM,    --ǥ�ذ���						\n");
						sql.append(" B.OFFSUM,    --�����ҵ�						\n");
						sql.append(" B.ETCAMT011, --���ο�������ҵ����	\n");
						sql.append(" B.ETCAMT01,  --�����������					\n");
						sql.append(" B.ETCAMT02,  --�������հ���					\n");
						sql.append(" B.ETCAMT03,  --�ſ�ī�����					\n");
						sql.append(" B.ETCAMT04,  --�츮���ְ���					\n");
						sql.append(" B.TSTDSUM,   --���ռҵ����ǥ��			\n");
						sql.append(" B.STDTAX,    --���⼼��							\n");
						sql.append(" B.DEDAMT01,  --�ٷμҵ漼�װ���			\n");
						sql.append(" B.DEDAMT02,  --�������հ���					\n");
						sql.append(" B.DEDAMT03,  --�������Ա�						\n");
						sql.append(" B.DEDAMT05,  --�ܱ�����							\n");
						sql.append(" B.DEDSUM,    --���װ�����						\n");
						sql.append(" B.PB41000,   --�����ҵ漼						\n");
						sql.append(" B.PB42000,   --�����ֹμ�						\n");
						sql.append(" B.PB43000,   --������Ư��						\n");
						sql.append(" B.APPDT				--�ͼӳ⵵							\n");
						sql.append(" FROM PAYROLL.YCPAYCOL B							\n");
						sql.append(" LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO = B.EMPNO	\n");
						sql.append(" LEFT JOIN PAYROLL.HCDEPT C ON C.DEPTCD = B.DEPTCD \n");
						sql.append(" LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD =  A.PAYGRD AND D.MAJORCD='2002' ");
						sql.append(" WHERE ");

						if (!str[0].equals("")) {	sql.append(" B.APPDT = '"+str[0]+"' "); }
						if (!str[1].equals("")) { sql.append(" AND B.EMPNO = '"+str[1]+"' "); }

						sql.append( " ORDER BY C.TREECD, D.SEQ ");	

						//logger.dbg.println(this,sql.toString());
					
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				}
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
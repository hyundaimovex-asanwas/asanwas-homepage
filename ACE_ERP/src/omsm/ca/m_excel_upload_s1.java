package  omsm.ca;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import java.io.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.NumberFormulaCell;
import jxl.Sheet;
import jxl.Workbook;


import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;

public class m_excel_upload_s1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fExcelFilePath = "";
	
	/*********************************************************************
	* 파일 수신을 위한 함수 : 파일을 복사함.
	* @param in
	* @param out
	* @param bufferSize
	*********************************************************************/
	private void copy(InputStream in, OutputStream out, int bufferSize) {
		try {
				synchronized (in) {
						synchronized (out) {
								byte[] buffer = new byte[bufferSize];
								while (true) {
										int bytesRead = in.read(buffer);
										System.out.println("bytesRead : " + bytesRead + " : " + buffer.length);
										if (bytesRead == -1) break;
										out.write(buffer, 0, bytesRead);
								}
						}
				}
		} catch (IOException ioe) {
				throw new RuntimeException ("Can not copy stream\n\t"+ioe.toString());
		}
	}
	
	
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		//ServiceLoader loader = null;
		//GauceService service = null;
		//GauceContext context = null;
		//Logger logger = null;
		Connection conn = null;
	

		try{
			//loader = new ServiceLoader(req, res);
	 		//service = loader.newService();
	 		//context = service.getContext();
	 		//logger = context.getLogger();
	 	
			
	        //ResultSet rs = null;
	        //Statement stmt = null;
	        
	        //JNDI connection 호출 : import javax.naming.*; 필요
	        Context initContext = (Context) new InitialContext();
	    	//DataSource ds = (DataSource) initContext.lookup("CforPMS");
	    	DataSource ds = (DataSource) initContext.lookup("CforOMS");
	    	conn = ds.getConnection();
	        //JNDI connection 호출
	 		
	 		
	 		HttpGauceRequest greq 	= null;
			HttpGauceResponse gres	= null;
			greq = (HttpGauceRequest)  req;
			gres = (HttpGauceResponse) res;
	 		
	 		GauceStatement stmt =null;
		    GauceDataSet dSet = null;

			String strSeq = "";
			String strVend_CD="";

			try {
				
				//System.out.println("aaaa");
				


				String str1 = greq.getParameter("v_str1");
				
				
				//System.out.println("str1::"+ str1);
				
				GauceInputStream gis = greq.getGauceInputStream();
		        GauceOutputStream gos = gres.getGauceOutputStream();
				
				//GauceDataSet ds1 = gis.read("DS_DEFAULT");
				
				GauceDataSet excelDs = gis.read("USER");  
				GauceDataSet ds2 = gis.read("USER2"); 
				
				//데이타셋의 COLS
				//GauceDataColumn[] 	excelCol = excelDs.getDataColumns();
				
				int idxEXCEL_INFO = excelDs.indexOfColumn("EXCEL_INFO");
				int idxEXCEL_URL  = excelDs.indexOfColumn("EXCEL_URL");
				
				
				//데이타셋의 ROWS
				GauceDataRow[] 		excelRow = excelDs.getDataRows();  
				
				//System.out.println("length::"+ excelRow.length);
				
  
				/*
				String d_name = excelRow[0].getString(idxEXCEL_INFO);
				
				String o_name = excelRow[0].getString(0).trim();
				*/
				
				String d_name = null;
				String o_name = null;
				
				
				
				//System.out.println("step2");
				
				o_name = System.currentTimeMillis()+".xls";
				//fExcelFilePath = "/HdAsan/Account/file/excel" + o_name;	
				
				//로컬
				fExcelFilePath = "D:/myWorks/HDAsan/WebContent/Omsm/file/excel/"+ o_name;
				
				
				//System.out.println("step3");
                //logger.dbg.println(this,"엑셀 생성파일 경로:"+fExcelFilePath); 
				InputStream is = (InputStream)excelRow[0].getInputStream(idxEXCEL_URL);
				FileOutputStream os = new FileOutputStream(fExcelFilePath);
				int size = 1024*1024*10 ;   
				copy(is, os, size );
				is.close();
				os.close();
				
				
				

			    
				
				gos.close();
				
			}
			catch(Exception e){
				conn.rollback();
				//gres.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      
			
			
		}
		catch (Exception e) {

			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close();	}	catch (Exception e) {}}
			//loader.restoreService(service);
	 	}
	}
}
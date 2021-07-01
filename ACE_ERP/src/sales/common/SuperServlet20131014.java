package sales.common;

import java.sql.*;
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sales.common.HDConstant; 
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
 
 


 
 
public abstract class SuperServlet20131014 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * ���� ���� : SQL
	 */
	public StringBuffer[] arr_sql = new StringBuffer[50];
	
	public String fParamEmpno = "";
	public String fParamIp ="";
	
	public void setCookie(HttpServletRequest req, HttpServletResponse res)  {
		try {
			
			/* session ó���� ���� : 2011-07-29 by �ɵ��� */ 
			HttpSession session = req.getSession();
					
			fParamEmpno		= (String)session.getAttribute("vusrid");
			fParamIp 		= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ
			
			//���� ��Ű�ҽ� /////////////////////////////////////////////////////////////////			
			/*
			HDCookieManager hdCookie = new HDCookieManager(req, res);
			String vusrid = hdCookie.getCookieValue("vusrid",req); // empno
	
			if (vusrid != null || !vusrid.equals("") ||  vusrid.length() > 0) {
				fParamEmpno = vusrid;
			} else {
				fParamEmpno = "tester";
			}
			
			fParamIp = req.getRemoteAddr();*/
			//���� ��Ű�ҽ� /////////////////////////////////////////////////////////////////
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * ���뺯�� : Context Path 
	 */
	public String dir_path = "";

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
		 
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	/**
	 * ��� ������ �б� �� ó��
	 * @param req
	 * @param res
	 * @throws ServletException
	 */
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		setCookie(req, res);
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null;

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection

		dir_path = req.getContextPath();
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();

			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			conn.setAutoCommit(false);
			
			/*
			 * Parameter : proType (���� ���� �Ķ����)
			 */

			String proType = HDUtil.nullCheckStr(gceReq.getParameter("proType")); //��ȸ, ����
//StringUtil.printMsg("PROTYPE",proType, this);
//StringUtil.printMsg("############## START ################",this);

			/*
			 * DESC :  �������� 
			 */
			makeSql();
			if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// �ʱ�ȭ
				init(conn, gceReq, gceRes);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
				select(conn, gceReq, gceRes);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// ���� (����, ����, ����) 
				apply(conn, gceReq, gceRes);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_EXCEL_CUSTOMER)) {
				readCustExcel(conn,gceReq, gceRes);
			}
			
			conn.commit();
			
		}catch (Exception e) {
			try{
				conn.rollback();
			} catch (SQLException sqle){
				sqle.printStackTrace();
			}
			gceRes.writeException("ERROR", "9999", e.getMessage());
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if(conn!=null) conn.close(true);
					//���콺 Ŀ�ؼ��� close�� �� �Ķ���͸� true�� �����ϸ� ������ ��������ϴ�. 2007-06-08 �ɵ���
				} catch (Exception e) {
					e.printStackTrace();
					loader.restoreService(service);
				}
			}
			try{
				if(gceRes!=null)gceRes.flush();
				if(gceRes!=null)gceRes.commit();
				if(gceRes!=null)gceRes.close();
			} catch (Exception e){}
			loader.restoreService(service);
		}
	}

	/**
	 * ���� ������ ���� �Լ�
	 * @param in
	 * @param out
	 */
	public static final void copy(InputStream in, OutputStream out) {
        copy(in, out, 1024);
    }

	/**
	 * ���� ������ ���� �Լ�
	 * @param in
	 * @param out
	 * @param bufferSize
	 */
    public static final void copy(InputStream in, OutputStream out, int bufferSize) {
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
    
	/**
	 * �������� ���� sql ��ü�� ����
	 */
    public abstract void makeSql();
    
    /**
     * �׸��� �󿡼� �ʱ� ������ ����
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception ;

    /**
     * ������ ��ȸ�� ���
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception ;
    
    /**
     * ������ CUD ó���� ���� �Լ�
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception;
    
    public void readCustExcel(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {}
    
    /**
     * ������ ��� ����
     * @param rs
     * @param ds
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public GauceDataSet getDataSet(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[];
		columnName = new String[rsmd.getColumnCount()]; // ��ȸ�ؿ� �÷� ��ŭ �迭�� �����Ѵ� 
		 //DataSet�� ����� �����Ѵ� 
		
		for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
			if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER")) {
				
				
				if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1 || columnName[i].indexOf("AMT_")!= -1 || columnName[i].indexOf("RATE_")!= -1) {
					//StringUtil.printMsg("-------------------------------AMT",columnName[i],this);
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1)));
				}
				else{ 
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1),0 ));
					//StringUtil.printMsg("-------------------------------AMT NOT",columnName[i],this);
				}
			} else {
				//StringUtil.printMsg("-----------------------------------------STRING",this);
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			}
		}
		// ������ DataSet�� ����� �ִ´�
		while(rs.next()) {
			GauceDataRow row = ds.newDataRow();
			
			for(int i=0; i<columnName.length; i++) {
				if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") ||rsmd.getColumnTypeName(i+1).equals("INTEGER") ) {
					
					if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1){
						row.addColumnValue(rs.getDouble(columnName[i]));
						//StringUtil.printMsg("-------------------------------AMT",rs.getDouble(columnName[i])+"",this);
					}else{
						row.addColumnValue(rs.getLong(columnName[i]));
						//StringUtil.printMsg("-------------------------------AMT NOT int",rs.getInt(columnName[i])+"",this);
						//StringUtil.printMsg("-------------------------------AMT NOT long",rs.getLong(columnName[i])+"",this);
					}
				} else {
					row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]).trim());
				}
			}

			ds.addDataRow(row);
		}
		
		return ds;
    }

    /**
     * ������ ��� ����
     * @param rs
     * @param ds
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public GauceDataSet getDataSetHead(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[];
		columnName = new String[rsmd.getColumnCount()]; // ��ȸ�ؿ� �÷� ��ŭ �迭�� �����Ѵ� 
		 //DataSet�� ����� �����Ѵ� 
		
		for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
			
			if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") ||rsmd.getColumnTypeName(i+1).equals("INTEGER") ) {
				if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1)
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1)));
				else 
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
			} else {
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			}
		}
		return ds;
    }
    
    /**
     * �ſ�ī�� / ��Ÿ ���� ����
     * @param rs
     * @param dirPath (���� Dir)
     * @param makeFileName (���ϸ� �� ������)
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public String getDataFileMake(ResultSet rs, String dirPath, String makeFileName) throws ServletException, Exception{
    	String makeFile = dirPath+ File.separator + makeFileName;
    	
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[] = new String[rsmd.getColumnCount()]; // ��ȸ�ؿ� �÷� ��ŭ �迭�� �����Ѵ� 
		
		for (int i = 0; i < columnName.length; i++) 
			columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
		
		PrintWriter log;
		File dirFile = new File(dirPath);

//StringUtil.printMsg("dirPath", dirPath, this);
//StringUtil.printMsg("makeFileName", makeFileName, this);

		if(!dirFile.exists()){
			dirFile.mkdir(); 
		}
		
		File saveFile = new File(makeFile);
		if(saveFile.exists()){
			throw new Exception("������ ���ϸ��� �����մϴ�. �ٽ��ѹ� Ȯ�� �� �۾��Ͻñ� �ٶ��ϴ�.");
		}
		
		log = new PrintWriter(new FileWriter(makeFile, false), false);
        
		
		// ������ DataSet�� ����� �ִ´�
		while(rs.next()) {
			for(int i=0; i<columnName.length; i++) {
				if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") ||rsmd.getColumnTypeName(i+1).equals("INTEGER") ) {
					log.print(rs.getInt(columnName[i]));
				} else {
					log.print(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
				}
			}
			log.println("");
		}
		
		if(log!=null) log.close();
		
		return makeFileName;
    }

    public String getDataFileMakeNew(ResultSet rs, String dirPath, String makeFileName) throws ServletException, Exception{
    	String makeFile = dirPath+ File.separator + makeFileName;
    	
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[] = new String[rsmd.getColumnCount()]; // ��ȸ�ؿ� �÷� ��ŭ �迭�� �����Ѵ� 
		
		for (int i = 0; i < columnName.length; i++) 
			columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
		
		PrintWriter log;
		File dirFile = new File(dirPath);

//StringUtil.printMsg("dirPath", dirPath, this);
//StringUtil.printMsg("makeFileName", makeFileName, this);

		if(!dirFile.exists()){
			dirFile.mkdir(); 
		}
		
		log = new PrintWriter(new FileWriter(makeFile, false), true);
        
		
		// ������ DataSet�� ����� �ִ´�
		while(rs.next()) {
			for(int i=0; i<columnName.length; i++) {
				if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") ||rsmd.getColumnTypeName(i+1).equals("INTEGER") ) {
					log.print(rs.getInt(columnName[i]));
				} else {
					log.print(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
				}
			}
			log.println("");
		}
		
		if(log!=null) log.close();
		
		return makeFileName;
    }
}

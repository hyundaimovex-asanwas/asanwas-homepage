package config.common;

/*
 * 2013-10-14 �̰� ���� ����?
 
 * 5.x ���ø����� �ٽ� ¥��
 * 
 * �׹ۿ� ���ݾ� �ٵ��
 * 
 * 20131017	�ɵ���	GAUCE5.x �޼ҵ��� �����ϱ�~
 * 20131021	superServelt�� �� �����ܺ��� 1����.. �ֳĸ� ���⼭ JNDI�� �α� ������
 * 
 * */

import java.io.*;
import java.sql.*;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.sql.DataSource;

import javax.naming.*;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;

import sales.common.HDConstant; //�����
import sales.common.HDUtil;		//��ƿ �׳� sales�� ���
 


 
 
public abstract class SuperServlet extends HttpServlet{
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
	
	public void getSession(HttpServletRequest req, HttpServletResponse res)  {
		try {
			
			/* session ó���� ���� : 2011-07-29 by �ɵ��� */ 
			HttpSession session = req.getSession();
					
			fParamEmpno		= (String)session.getAttribute("vusrid");
			fParamIp 		= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	
	/**
	 * ���뺯�� : Context Path 
	 */
	public String dir_path = "";

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		try {
			command(req, res);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		 
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		try {
			command(req, res);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ��� ������ �б� �� ó��
	 * @param req
	 * @param res
	 * @throws ServletException
	 */
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException,SQLException, NamingException {
		res.setContentType("text/html;charset=EUC-KR");
		getSession(req, res);	//�α� ���� �б�
        
		Connection conn = null;
        //ResultSet rs = null;
        //Statement stmt = null;
        
        //JNDI connection ȣ�� : import javax.naming.*; �ʿ�
        Context initContext = (Context) new InitialContext();
    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
    	conn = ds.getConnection();
        //JNDI connection ȣ��
		
		
		
		dir_path = req.getContextPath();
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();	//�̰� ���� �θ��� ���̾���..

		HttpGauceRequest greq 	= null;
		HttpGauceResponse gres	= null;
		greq = (HttpGauceRequest) req;
		gres = (HttpGauceResponse) res;
		try {

			
			// Database Connection
			conn.setAutoCommit(false);
			
			/*
			 * Parameter : proType (���� ���� �Ķ����)
			 */
				String proType = HDUtil.nullCheckStr(req.getParameter("proType")); //��ȸ, ����
				//StringUtil.printMsg("PROTYPE",proType, this);
				//StringUtil.printMsg("############## START ################",this);

			/*
			 * DESC :  �������� 
			 */
			makeSql();
			if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// �ʱ�ȭ
				init(conn, greq, gres);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
				select(conn, greq, gres);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// ���� (����, ����, ����) 
				apply(conn, greq, gres);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_EXCEL_CUSTOMER)) {
				readCustExcel(conn,greq, gres);
			}
			
			conn.commit();
			
		}catch (Exception e) {
			try{
				conn.rollback();
			} catch (SQLException sqle){
				sqle.printStackTrace();
			}
			gres.addException(e);
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if(conn!=null) conn.close();
					//���콺 Ŀ�ؼ��� close�� �� �Ķ���͸� true�� �����ϸ� ������ ��������ϴ�. 2007-06-08 �ɵ���
				} catch (Exception e) {
					e.printStackTrace();
					//loader.restoreService(service);
				}
			}
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
    public abstract void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception ;

    /**
     * ������ ��ȸ�� ���
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception ;
    
    /**
     * ������ CUD ó���� ���� �Լ�
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception;
    
    public void readCustExcel(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {}
    
    /**
     * ������ ��� ����
     * @param rs
     * @param ds
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public static GauceDataSet getDataSet(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[];
		columnName = new String[rsmd.getColumnCount()]; // ��ȸ�ؿ� �÷� ��ŭ �迭�� �����Ѵ� 

		//DataSet�� ����� �����Ѵ� 
		for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
			if(rsmd.getColumnTypeName(i+1).equals("NUMBER") ){
				if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1 || columnName[i].indexOf("AMT_")!= -1 || columnName[i].indexOf("RATE_")!= -1) {
					//StringUtil.printMsg(" �÷���"+i+"===", columnName[i] ,this);
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1)));
				}
				else{ 
					//StringUtil.printMsg(" �÷���"+i+"===", columnName[i] ,this);
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1),0 ));
				}
			} else {
				//StringUtil.printMsg(" �÷���"+i+"===", columnName[i] ,this);
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			}
		}
		
		//DataSet�� ����� �ִ´�
		while(rs.next()) {
			for(int i=0; i<columnName.length; i++) {
				columnName[i] = rsmd.getColumnName(i+1); // �÷� �̸�
				//StringUtil.printMsg(" Ÿ  ��"+i+"===", rsmd.getColumnTypeName(i+1) ,this);	//�̰� �� �����ϴ�.
				
			
				if(rsmd.getColumnTypeName(i+1).equals("NUMBER") ){
					//StringUtil.printMsg(" ���ڰ� ===", rs.getInt(columnName[i]),this);					
					if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1){
						//StringUtil.printMsg(" �÷���"+i+"===", columnName[i] ,this);
						//System.out.println( " ����double===" + rs.getDouble(columnName[i])) ;
						ds.put(columnName[i], rs.getDouble(columnName[i]), rsmd.getColumnDisplaySize(i+1));
					}else{
						//StringUtil.printMsg(" �÷���"+i+"===", columnName[i] ,this);
						//System.out.println( " ����long ===" + rs.getLong(columnName[i]));
						//StringUtil.printMsg(" ũ  ��"+i+"===",rsmd.getColumnDisplaySize(i+1),this);
						ds.put(columnName[i], rs.getLong(columnName[i]), rsmd.getColumnDisplaySize(i+1));
					}
				} else {
					//StringUtil.printMsg(" �÷���"+i+"===", columnName[i] ,this);
					//StringUtil.printMsg(" ���ڰ�"+i+"===",HDUtil.nullCheckStr(rs.getString(columnName[i])),this);
					ds.put(columnName[i], HDUtil.nullCheckStr(rs.getString(columnName[i])), rsmd.getColumnDisplaySize(i+1));
				}
				//StringUtil.printMsg(" ũ  ��"+i+"===",rsmd.getColumnDisplaySize(i+1),this);
			}

			ds.heap();//put�޼ҵ带 ���� ���������� �Էµ� �÷��� ���� �ϳ��� ������ �ν��ϰ� GauceDataSet�� ����
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

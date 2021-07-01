package config.common;

/*
 * 2013-10-14 이걸 새로 도전?
 
 * 5.x 템플릿으로 다시 짜기
 * 
 * 그밖에 조금씩 다듬기
 * 
 * 20131017	심동현	GAUCE5.x 메소드들로 수정하기~
 * 20131021	superServelt도 각 업무단별로 1개씩.. 왜냐면 여기서 JNDI를 맺기 떄문에
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

import sales.common.HDConstant; //상수랑
import sales.common.HDUtil;		//유틸 그냥 sales쪽 사용
 


 
 
public abstract class SuperServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 공통 변수 : SQL
	 */
	public StringBuffer[] arr_sql = new StringBuffer[50];
	
	public String fParamEmpno = "";
	public String fParamIp ="";
	
	public void getSession(HttpServletRequest req, HttpServletResponse res)  {
		try {
			
			/* session 처리로 변경 : 2011-07-29 by 심동현 */ 
			HttpSession session = req.getSession();
					
			fParamEmpno		= (String)session.getAttribute("vusrid");
			fParamIp 		= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	
	/**
	 * 공통변수 : Context Path 
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
	 * 모든 서블릿을 분기 및 처리
	 * @param req
	 * @param res
	 * @throws ServletException
	 */
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException,SQLException, NamingException {
		res.setContentType("text/html;charset=EUC-KR");
		getSession(req, res);	//로긴 세션 읽기
        
		Connection conn = null;
        //ResultSet rs = null;
        //Statement stmt = null;
        
        //JNDI connection 호출 : import javax.naming.*; 필요
        Context initContext = (Context) new InitialContext();
    	DataSource ds = (DataSource) initContext.lookup("CforCommon");
    	conn = ds.getConnection();
        //JNDI connection 호출
		
		
		
		dir_path = req.getContextPath();
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();	//이건 쿼리 부르는 것이었고..

		HttpGauceRequest greq 	= null;
		HttpGauceResponse gres	= null;
		greq = (HttpGauceRequest) req;
		gres = (HttpGauceResponse) res;
		try {

			
			// Database Connection
			conn.setAutoCommit(false);
			
			/*
			 * Parameter : proType (업무 구분 파라미터)
			 */
				String proType = HDUtil.nullCheckStr(req.getParameter("proType")); //조회, 저장
				//StringUtil.printMsg("PROTYPE",proType, this);
				//StringUtil.printMsg("############## START ################",this);

			/*
			 * DESC :  업무구분 
			 */
			makeSql();
			if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// 초기화
				init(conn, greq, gres);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
				select(conn, greq, gres);
			} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// 적용 (저장, 삭제, 수정) 
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
					//가우스 커넥션을 close할 때 파라미터를 true로 세팅하면 강제로 끊어버립니다. 2007-06-08 심동현
				} catch (Exception e) {
					e.printStackTrace();
					//loader.restoreService(service);
				}
			}
		}
	}

	/**
	 * 파일 수신을 위한 함수
	 * @param in
	 * @param out
	 */
	public static final void copy(InputStream in, OutputStream out) {
        copy(in, out, 1024);
    }

	/**
	 * 파일 수신을 위한 함수
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
	 * 서블릿에서 사용될 sql 자체를 생성
	 */
    public abstract void makeSql();
    
    /**
     * 그리드 상에서 초기 데이터 설정
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception ;

    /**
     * 데이터 조회시 사용
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception ;
    
    /**
     * 데이터 CUD 처리를 위한 함수
     * @param conn
     * @param req
     * @param res
     * @throws ServletException
     * @throws Exception
     */
    public abstract void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception;
    
    public void readCustExcel(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {}
    
    /**
     * 데이터 헤더 생성
     * @param rs
     * @param ds
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public static GauceDataSet getDataSet(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[];
		columnName = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 

		//DataSet에 헤더를 생성한다 
		for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
			if(rsmd.getColumnTypeName(i+1).equals("NUMBER") ){
				if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1 || columnName[i].indexOf("AMT_")!= -1 || columnName[i].indexOf("RATE_")!= -1) {
					//StringUtil.printMsg(" 컬럼명"+i+"===", columnName[i] ,this);
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1)));
				}
				else{ 
					//StringUtil.printMsg(" 컬럼명"+i+"===", columnName[i] ,this);
					ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_DECIMAL, rsmd.getColumnDisplaySize(i+1),0 ));
				}
			} else {
				//StringUtil.printMsg(" 컬럼명"+i+"===", columnName[i] ,this);
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			}
		}
		
		//DataSet에 결과를 넣는다
		while(rs.next()) {
			for(int i=0; i<columnName.length; i++) {
				columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
				//StringUtil.printMsg(" 타  입"+i+"===", rsmd.getColumnTypeName(i+1) ,this);	//이건 잘 찍힙니다.
				
			
				if(rsmd.getColumnTypeName(i+1).equals("NUMBER") ){
					//StringUtil.printMsg(" 숫자값 ===", rs.getInt(columnName[i]),this);					
					if(columnName[i].indexOf("_AMT")!= -1 || columnName[i].indexOf("_RATE")!= -1){
						//StringUtil.printMsg(" 컬럼명"+i+"===", columnName[i] ,this);
						//System.out.println( " 숫자double===" + rs.getDouble(columnName[i])) ;
						ds.put(columnName[i], rs.getDouble(columnName[i]), rsmd.getColumnDisplaySize(i+1));
					}else{
						//StringUtil.printMsg(" 컬럼명"+i+"===", columnName[i] ,this);
						//System.out.println( " 숫자long ===" + rs.getLong(columnName[i]));
						//StringUtil.printMsg(" 크  기"+i+"===",rsmd.getColumnDisplaySize(i+1),this);
						ds.put(columnName[i], rs.getLong(columnName[i]), rsmd.getColumnDisplaySize(i+1));
					}
				} else {
					//StringUtil.printMsg(" 컬럼명"+i+"===", columnName[i] ,this);
					//StringUtil.printMsg(" 문자값"+i+"===",HDUtil.nullCheckStr(rs.getString(columnName[i])),this);
					ds.put(columnName[i], HDUtil.nullCheckStr(rs.getString(columnName[i])), rsmd.getColumnDisplaySize(i+1));
				}
				//StringUtil.printMsg(" 크  기"+i+"===",rsmd.getColumnDisplaySize(i+1),this);
			}

			ds.heap();//put메소드를 통해 순차적으로 입력된 컬럼의 값을 하나의 행으로 인식하고 GauceDataSet에 적재
		}
		
		return ds;

    }

    /**
     * 데이터 헤더 생성
     * @param rs
     * @param ds
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public GauceDataSet getDataSetHead(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[];
		columnName = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 
		 //DataSet에 헤더를 생성한다 
		
		for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
			
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
     * 신용카드 / 기타 파일 생성
     * @param rs
     * @param dirPath (생성 Dir)
     * @param makeFileName (파일명 및 절대경로)
     * @return
     * @throws ServletException
     * @throws Exception
     */
    public String getDataFileMake(ResultSet rs, String dirPath, String makeFileName) throws ServletException, Exception{
    	String makeFile = dirPath+ File.separator + makeFileName;
    	
    	ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[] = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 
		
		for (int i = 0; i < columnName.length; i++) 
			columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
		
		PrintWriter log;
		File dirFile = new File(dirPath);

//StringUtil.printMsg("dirPath", dirPath, this);
//StringUtil.printMsg("makeFileName", makeFileName, this);

		if(!dirFile.exists()){
			dirFile.mkdir(); 
		}
		
		File saveFile = new File(makeFile);
		if(saveFile.exists()){
			throw new Exception("동일한 파일명이 존재합니다. 다시한번 확인 후 작업하시길 바랍니다.");
		}
		
		log = new PrintWriter(new FileWriter(makeFile, false), false);
        
		
		// 생성된 DataSet에 결과를 넣는다
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
    	String columnName[] = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 
		
		for (int i = 0; i < columnName.length; i++) 
			columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
		
		PrintWriter log;
		File dirFile = new File(dirPath);

//StringUtil.printMsg("dirPath", dirPath, this);
//StringUtil.printMsg("makeFileName", makeFileName, this);

		if(!dirFile.exists()){
			dirFile.mkdir(); 
		}
		
		log = new PrintWriter(new FileWriter(makeFile, false), true);
        
		
		// 생성된 DataSet에 결과를 넣는다
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

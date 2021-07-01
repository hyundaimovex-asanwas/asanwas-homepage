/*
 * 2013-10-16
 * 여기에 주석을 달면서 gauce5.0을 정리해보고 있습니다.
 * 참고문서는 Gauce 5.2 Developer Guide Manual.pdf에서
 *  p42~ Gauce Server API 부분
 *  
 *  심동현
 * 
 * 
 * */
package common;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.sql.DataSource;
import javax.naming.*;	// 추가필요
import com.gauce.GauceDataRow;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

 
public class test131016 extends HttpServlet {
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        response.setContentType("text/html;charset=EUC-KR");
        Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
        
        
        try {
            String paramDEPTNO = request.getParameter("goods_cd");

            
            GauceInputStream gis = ((HttpGauceRequest) request).getGauceInputStream();
            GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
            
            //JNDI connection 호출 : import javax.naming.*; 필요
            Context initContext = (Context) new InitialContext();
        	DataSource ds = (DataSource) initContext.lookup("CforSales");
        	conn = ds.getConnection();
            //JNDI connection 호출
        	
        	
        	
        	
            //DataSource ds = (DataSource)((HttpGauceRequest)request).getAttribute("GauceDB");
            //conn = ds.getConnection();
        	
        	//GauceDataSet dSet = new GauceDataSet();	// 이름을 지정하지 않으면 내부적으로 Gauce로 생성. 중복 조심!
            GauceDataSet dSet = new GauceDataSet("OUTPUT_01");
            gos.fragment(dSet);
            
            //쿼리 만들기 : String Buffer
            StringBuffer buf_OUTPUT_01 = new StringBuffer();
            buf_OUTPUT_01.append("SELECT GOODS_CD, ");
            buf_OUTPUT_01.append("       GOODS_NM, ");
            buf_OUTPUT_01.append("       USE_YN ");
            buf_OUTPUT_01.append("  FROM SALES.TRM200   ");
            buf_OUTPUT_01.append(" WHERE saup_sid=1 ");
            String strQry = buf_OUTPUT_01.toString();

           
            stmt = conn.createStatement();
            rs = stmt.executeQuery(strQry);
            
            while(rs.next()) {
                //dSet.put("DEPTNO", rs.getInt("DEPTNO"), 2, GauceDataColumn.TB_NORMAL);
                //dSet.put("DNAME", rs.getString("DNAME"), 14, GauceDataColumn.TB_NORMAL);
                //dSet.put("LOC", rs.getString("LOC"), 13, GauceDataColumn.TB_NORMAL);

            	//put() 메소드 : 하나의 행이 가진 값을 삽입
            	//heap()이 호출되기 전까지 순차적으로 데이터셋의 행을 적재
            	//(1) 컬럼이름 (2)들어갈 데이터 (3) 데이터에 대한 길이
            	// put 첫번째 요청 only :  이름과 길이의 컬럼헤더 생성
            	//     두번째 이후부터는 : 행의 값만 저장~!!
    	  		dSet.put("GOODS_CD", rs.getString("GOODS_CD"), 10); 
    		  	dSet.put("GOODS_NM", rs.getString("GOODS_NM"), 100);
    	  		dSet.put("USE_YN", rs.getString("USE_YN"), 2);
    	  		
    	  		//put() 메소드를 통해 정의된 데이터를 실제로 dataset에 저장하는 메소드 heap()!
                dSet.heap();
            }
            
            //gos.fragment(dSet); //데이터셋에 대한 전송 단위설정
            //데이터를 컴포넌트로 전송
            gos.write(dSet);
            
            rs.close();
            stmt.close();
            conn.close();
            
        }catch (Exception e) {
            throw new ServletException(e.toString());
        }finally {
        if (conn != null) {try {conn.close();} catch (Exception e) {}}
        }
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        response.setContentType("text/html;charset=EUC-KR");
        Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
        
        try {
            String paramDEPTNO = request.getParameter("DEPTNO");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
            try { stmt.close(); } catch (SQLException e) {}
            }
            
            if (rs != null) {
            try { rs.close(); } catch (SQLException e) {}
            }
            
            if (conn != null) {
            try { conn.close(); } catch (SQLException e) {}
            }
        }
    }
}
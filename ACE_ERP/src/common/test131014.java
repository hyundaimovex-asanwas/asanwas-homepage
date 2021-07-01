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


public class test131014 extends HttpServlet {
    
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
    	  		dSet.put("GOODS_CD", rs.getString("GOODS_CD"), 10);
    		  	dSet.put("GOODS_NM", rs.getString("GOODS_NM"), 100);
    	  		dSet.put("USE_YN", rs.getString("USE_YN"), 2);
    	  		
                dSet.heap();
            }
            
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
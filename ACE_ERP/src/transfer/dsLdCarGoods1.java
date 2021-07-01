package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

import java.io.*;
import java.io.InputStream.*;
import java.io.IOException.*;
import java.io.ByteArrayInputStream.*;
import java.io.FileInputStream.*;
import java.io.FileOutputStream.*;
import java.util.*;
import java.lang.Object.*;

import java.text.DecimalFormat;

import org.apache.poi.poifs.filesystem.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem.*;
import org.apache.poi.poifs.dev.*;
import org.apache.poi.hssf.record.*;
import org.apache.poi.hssf.record.formula.*;
import org.apache.poi.hssf.model.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;

import java.awt.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsLdCarGoods1 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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

				getExcelData() ; 

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHECK","ARTC_NM","ORDER_NO","ORDER_SEQ","ARTC_CNT","ARTC_UNIT","PUNIT_CNT",
								"PUNIT_UNIT","PUNIT_WGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH",
								"PKG_CBM","PKG_CNT","SAMEAS","CAR_SEQ_NO","LD_ARTC_CNT","LD_ARTC_UNIT",
								"LD_PKG_CNT","LD_PKG_UNIT","LD_PKG_WGHT","LD_PKG_CBM", "EXT_ARTC_CNT","EXT_PKG_CNT",
								"EXT_PKG_CBM" }; 

				int[] intArrCN = new int[] {1,50,10,10,13,10,13,10,13,13,13,13,13,13,10,10,13,13,13,13,13,13,13,13,13 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,2,-1,2,-1,2,2,2,2,2,2,-1,-1,2,-1,2,-1,2,2,2,2,2}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT CASE WHEN CAR_SEQ_NO IS NULL THEN 'F' ELSE 'T' END AS CHECK,") ;  
						sql.append( " D.ARTC_NM,D.ORDER_NO, D.ORDER_SEQ ,D.ARTC_CNT, D.ARTC_UNIT ,   ") ;    
						sql.append( " D.PUNIT_CNT, D.PUNIT_UNIT,D.PUNIT_WGHT, D.PKG_LNGTH  ,   ") ;   
						sql.append( " D.PKG_HEIGHT, D.PKG_WIDTH,D.PKG_CBM,D.PKG_CNT  ,D.SAMEAS, ") ;  
						sql.append( " IFNULL(G.CAR_SEQ_NO,'') AS CAR_SEQ_NO, ") ;  
						sql.append( " IFNULL(G.ARTC_CNT,0) AS LD_ARTC_CNT,   ") ;  
						sql.append( " IFNULL(G.ARTC_UNIT,0) AS LD_ARTC_UNIT ,") ;  
						sql.append( " IFNULL(G.PKG_CNT,0) AS LD_PKG_CNT ,  ") ;  
						sql.append( " IFNULL(G.PKG_UNIT,0) AS LD_PKG_UNIT, ") ;  
						sql.append( " IFNULL(G.PKG_WGHT,0) AS LD_PKG_WGHT,   ") ;   
						sql.append( " IFNULL(G.PKG_CBM,0)  AS LD_PKG_CBM, ") ;  
						//sql.append( " IFNULL(G.PKG_HEIGHT,0) AS LD_PKG_HEIGHT,  ") ;     
						//sql.append( " IFNULL(G.PKG_WIDTH,0) AS LD_PKG_WIDTH, ") ;  
						//sql.append( " IFNULL(G.PKG_CBM,0) AS LD_PKG_CBM,  ") ;  
						//sql.append( " IFNULL(G.PKG_CNT,0) AS LD_PKG_CNT , ") ;  
						sql.append( " D.ARTC_CNT-(SELECT IFNULL(SUM(G1.ARTC_CNT),0) FROM  TRANSFER.LTCARGOODS G1  ") ;  
						sql.append( " WHERE D.ORDER_NO = G1.ORDER_NO  AND  D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_ARTC_CNT, ") ;  
						sql.append( " D.PKG_CNT-(SELECT IFNULL(SUM(G1.PKG_CNT),0) FROM  TRANSFER.LTCARGOODS G1  ") ;  
						sql.append( " WHERE D.ORDER_NO = G1.ORDER_NO  AND  D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CNT, ") ;  
						sql.append( " D.PKG_CBM-(SELECT IFNULL(SUM(G1.PKG_CBM),0) FROM  TRANSFER.LTCARGOODS G1  ") ;  
						sql.append( " WHERE D.ORDER_NO = G1.ORDER_NO  AND  D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CBM ") ;  
						sql.append( " FROM TRANSFER.LTORDERDTL D LEFT JOIN TRANSFER.LTCARGOODS G ") ;  
						sql.append( " ON D.ORDER_NO = G.ORDER_NO  AND  D.ORDER_SEQ = G.ORDER_SEQ   ") ; 
if(str2 !=null) {	sql.append( " AND G.CAR_SEQ_NO = '"  +  str2  + "'" ) ;  }
if(str1 !=null) {	sql.append( " WHERE D.ORDER_NO = '"  +  str1  + "'" ) ;  }

 //GauceRes.writeException("Sql",":",sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
					}
			
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
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
	


public  Vector getExcelData() {
    Vector vData = new Vector();

    int sheetNum = 0;
    HSSFWorkbook wb = null;
    HSSFSheet sheet = null;
    HSSFRow row = null;
    HSSFCell cell = null;
    String value = null;

    String filename;

    ///////////////////////////////
    // 화일 다이얼로그 박스를 오픈시킨다.
    DoFileDialog fd = new DoFileDialog(null, "Open a File");

	return vData;
	
}
 



// 화일 다이얼로그 생성 및 처리에 대한 클래스
  class DoFileDialog
  {
    FileDialog fd;
    Frame f = null;

    // 화일 다이얼로그 생성자.
    public DoFileDialog(Frame parent, String title, int mode) throws AWTError
    {
      if(parent == null)
      {
        f = new Frame(title);
        f.pack();
        fd = new FileDialog(f, title, mode);
      }else{
        fd = new FileDialog(parent, title, mode);
      }

      if(mode == FileDialog.LOAD){
        fd.setFile("*.xls");
      }
      fd.show();
      if(f != null){
        f.dispose();
      }
    }

    public DoFileDialog(Frame parent, String title)
    {
      this(parent, title, FileDialog.LOAD);
    }

    // 화일 다이얼로그에서 선택된 파일의 이름을 반환한다.
    String getFileName()
    {
      if(fd != null && fd.getDirectory() != null && fd.getFile() != null)
        return fd.getFile();
      return null;
    }

    // 화일 다이얼로그에서 선택된 파일의 디렉토리를 반환한다.
    String getPath()
    {
      if(fd != null && fd.getDirectory() != null && fd.getFile() != null)
        return fd.getDirectory();
      return null;
    }
  }
}

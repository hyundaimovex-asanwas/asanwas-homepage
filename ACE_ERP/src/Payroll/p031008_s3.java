package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p031008_s3 extends HttpServlet {

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

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				String [] str= new String[5] ;
        str[0]  = req.getParameter("v_str1");   // 귀속년도
				str[1]	= req.getParameter("v_str2");		//부서
				str[2]	= req.getParameter("v_str3");		//성명
				str[3]	= req.getParameter("v_str4");		//Level
				str[4]	= req.getParameter("v_str5");		//treecd

		  	for (int s=0;s<5;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
												"YYYY",			"EMPNO",		"EMPNMK",   "DEPTNM",			
												"INCYY01",	"INC01001",	"INC01002",	"INC01003",	"INC01004",	"INC01005",	
												"INCYY02",	"INC02001",	"INC02002",	"INC02003",	"INC02004",	"INC02005",	
												"INCYY03",	"INC03001", "INC03002",	"INC03003",	"INC03004",	"INC03005",
												"INCYY04",	"INC04001",	"INC04002",	"INC04003",	"INC04004",	"INC04005",	
												"INCYY05",	"INC05001",	"INC05002",	"INC05003",	"INC05004",	"INC05005",
												"INCYY06",	"INC06001",	"INC06002",	"INC06003",	"INC06004",	"INC06005",	
												"INCYY07",	"INC07001",	"INC07002",	"INC07003",	"INC07004",	"INC07005",	
												"INCYY08",	"INC08001",	"INC08002",	"INC08003",	"INC08004",	"INC08005",	
												"INCYY09",	"INC09001",	"INC09002",	"INC09003",	"INC09004", "INC09005",	
												"INCYY10",  "INC10001",	"INC10002",	"INC10003",	"INC10004",	"INC10005",								
												"INCYY11",  "INC11001",	"INC11002",	"INC11003",	"INC11004",	"INC11005",	
												"INCYY12",  "INC12001",	"INC12002",	"INC12003",	"INC12004", "INC12005",
												"SINC001",	"SINC002",  "SINC003",  "SINC004",	"SINC005",	
												"FREYY01",  "FRE01001",	"FRE01002", "FRE01003",	"FRE01005","FRE01006",					
												"FREYY02",	"FRE02001",	"FRE02002",	"FRE02003", "FRE02005","FRE02006",	
												"FREYY03",	"FRE03001",	"FRE03002",	"FRE03003", "FRE03005","FRE03006",
												"FREYY04", 	"FRE04001", "FRE04002", "FRE04003", "FRE04005","FRE04006", 
												"FREYY05", 	"FRE05001", "FRE05002", "FRE05003", "FRE05005","FRE05006",  
												"FREYY06", 	"FRE06001", "FRE06002", "FRE06003", "FRE06005","FRE06006",
												"FREYY07",	"FRE07001", "FRE07002", "FRE07003", "FRE07005","FRE07006",
												"FREYY08",	"FRE08001", "FRE08002", "FRE08003", "FRE08005","FRE08006",
												"FREYY09", 	"FRE09001", "FRE09002", "FRE09003", "FRE09005","FRE09006",
												"FREYY10",	"FRE10001", "FRE10002", "FRE10003", "FRE10005","FRE10006",
												"FREYY11",  "FRE11001", "FRE11002", "FRE11003", "FRE11005","FRE11006",
												"FREYY12",  "FRE12001", "FRE12002",	"FRE12003", "FRE12005","FRE12006", 
												"SFRE001", 	"SFRE002", 	"SFRE003", 	"SFRE005",  "SFRE006",  
												"COL01001", "COL01002",	"COL01003", "COL01004",	"COL01005",	"COL01006","COL01007",  "COL01008",		
												"COL02001", "COL02002",	"COL02003",	"COL02004",	"COL02005",	"COL02006","COL02007",	"COL02008",	
												"COL03001",	"COL03002",	"COL03003",	"COL03004",	"COL03005",	"COL03006","COL03007",	"COL03008",	
												"COL04001",	"COL04002",	"COL04003",	"COL04004",	"COL04005",	"COL04006","COL04007",	"COL04008",	
												"COL05001",	"COL05002",	"COL05003", "COL05004",	"COL05005",	"COL05006",	"COL05007",	"COL05008",	
												"COL06001",	"COL06002",	"COL06003", "COL06004",	"COL06005",	"COL06006","COL06007",	"COL06008",	
												"COL07001",	"COL07002",	"COL07003", "COL07004",	"COL07005",	"COL07006","COL07007",	"COL07008",	
												"COL08001",	"COL08002",	"COL08003", "COL08004",	"COL08005",	"COL08006","COL08007",	"COL08008",	
												"COL09001",	"COL09002",	"COL09003", "COL09004",	"COL09005",	"COL09006","COL09007",	"COL09008",	
												"COL10001",	"COL10002",	"COL10003", "COL10004",	"COL10005",	"COL10006","COL10007",	"COL10008",	
												"COL11001",	"COL11002",	"COL11003", "COL11004",	"COL11005",	"COL11006","COL11007",	"COL11008",	
												"COL12001",	"COL12002",	"COL12003", "COL12004",	"COL12005",	"COL12006","COL12007",	"COL12008",	
												"SCOL002",  "SCOL003",	"SCOL004",  "SCOL005",	"SCOL006",	"SCOL007", "SCOL008",
												"EXC01001","EXC01002", "EXC01003", "EXC01004", "EXC01005",
												"EXC02001","EXC02002", "EXC02003", "EXC02004", "EXC02005",
												"EXC03001","EXC03002", "EXC03003", "EXC03004", "EXC03005",
												"EXC04001","EXC04002", "EXC04003", "EXC04004", "EXC04005",
												"EXC05001","EXC05002", "EXC05003", "EXC05004", "EXC05005",
												"EXC06001","EXC06002", "EXC06003", "EXC06004", "EXC06005",
												"EXC07001","EXC07002", "EXC07003", "EXC07004", "EXC07005",
												"EXC08001","EXC08002", "EXC08003", "EXC08004", "EXC08005",
												"EXC09001","EXC09002", "EXC09003", "EXC09004", "EXC09005",
												"EXC10001","EXC10002", "EXC10003", "EXC10004", "EXC10005",
												"EXC11001","EXC11002", "EXC11003", "EXC11004", "EXC11005",
												"EXC12001","EXC12002", "EXC12003", "EXC12004", "EXC12005",
												"SEXC001", "SEXC002",  "SEXC003",  "SEXC004",  "SEXC005",
                        "EXCYY01", "EXCYY02",  "EXCYY03",  "EXCYY04",  "EXCYY05", "EXCYY06",
                        "EXCYY07", "EXCYY08",  "EXCYY09",  "EXCYY10",  "EXCYY11", "EXCYY12"
				};  
					                              
				int[] intArrCN = new int[]{ 
											4,	7, 20,	20,	
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
										 11, 11, 11, 11, 11,				
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											6,  9,  9,	9,  9,  9,
											9,  9,  9,	9,  9,													
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,  9,
											9,  9,  9,	9,  9,  9,	9,
											9,  9,  9,	9,  9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,  9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,	9,
											9,  9,  9,	9,  9, 9,
											9,  9,  9,	9,  9, 9
					                        }; 
			
				int[] intArrCN2 = new int[]{
					            -1, -1, -1,	 -1,	
											-1,  0,  0,	 0,  0,  0,    
											-1,  0,  0,	 0,  0,  0, 
											-1,  0,  0,	 0,  0,  0,   
											-1,  0,  0,	 0,  0,  0,     
											-1,  0,  0,	 0,  0,  0, 
											-1,  0,  0,	 0,  0,  0,  
											-1,  0,  0,	 0,  0,  0, 
											-1,  0,  0,	 0,  0,  0,  
											-1,  0,  0,	 0,  0,  0,    
											-1,  0,  0,	 0,  0,  0,   
											-1,  0,  0,	 0,  0,  0,    
											-1,  0,  0,	 0,  0,  0,   
											 0,  0,  0,	 0,	 0,											
											-1,  0,  0,  0,	 0,	 0, 	   
											-1,  0,  0,  0,	 0,	 0, 
											-1,  0,  0,  0,	 0,	 0,     
											-1,  0,  0,  0,	 0,	 0,   
											-1,  0,  0,  0,	 0,	 0, 														 
											-1,  0,  0,  0,	 0,	 0, 	   
											-1,  0,  0,  0,	 0,	 0, 
											-1,  0,  0,  0,	 0,	 0,  
											-1,  0,  0,  0,	 0,	 0,   
											-1,  0,  0,  0,	 0,	 0, 														 
											-1,  0,  0,  0,	 0,	 0,    
											-1,  0,  0,  0,	 0,	 0,    									
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,  0,  0,  0,      
											 0,  0,  0,  0,  0,  0,  0,  0,	       
											 0,  0,  0,  0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,  0,  0,  0, 	       
											 0,  0,  0,  0,  0,  0,  0,  0,       
											 0,  0,  0,  0,  0,  0,  0,  0,      
											 0,  0,  0,  0,  0,  0,  0,  0,       
											 0,  0,  0,  0,  0,  0,  0,  0,		   
											 0,  0,  0,  0,  0,  0,  0,  0,        
											 0,  0,  0,  0,  0,  0,  0,  0,       
											 0,  0,  0,  0,  0,  0,  0,  0, 	       
											 0,  0,  0,  0,  0,  0,  0,  0,       
											 0,  0,  0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,  0,
											 0,  0,  0,  0,  0,  0
                 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          sql.append(" SELECT  \n");
					sql.append("  A.YYYY,     A.EMPNO,    A.EMPNMK,   B.DEPTNM,                                                            \n");
					sql.append("  IFNULL(A.INCYY01,'')INCYY01,  A.INC01001, A.INC01002,A.INC01003, A.INC01004, A.INC01005,                 \n");
					sql.append("  IFNULL(A.INCYY02,'')INCYY02,  A.INC02001, A.INC02002,A.INC02003, A.INC02004, A.INC02005,                 \n");
					sql.append("  IFNULL(A.INCYY03,'')INCYY03,  A.INC03001, A.INC03002,A.INC03003, A.INC03004, A.INC03005,                 \n");
					sql.append("  IFNULL(A.INCYY04,'')INCYY04,  A.INC04001, A.INC04002,A.INC04003, A.INC04004, A.INC04005,                 \n");
					sql.append("  IFNULL(A.INCYY05,'')INCYY05,  A.INC05001, A.INC05002,A.INC05003, A.INC05004, A.INC05005,                 \n");
					sql.append("  IFNULL(A.INCYY06,'')INCYY06,  A.INC06001, A.INC06002,A.INC06003, A.INC06004, A.INC06005,                 \n");
					sql.append("  IFNULL(A.INCYY07,'')INCYY07,  A.INC07001, A.INC07002,A.INC07003, A.INC07004, A.INC07005,                 \n");
					sql.append("  IFNULL(A.INCYY08,'')INCYY08,  A.INC08001, A.INC08002,A.INC08003, A.INC08004, A.INC08005,                 \n");
					sql.append("  IFNULL(A.INCYY09,'')INCYY09,  A.INC09001, A.INC09002,A.INC09003, A.INC09004, A.INC09005,                 \n");
					sql.append("  IFNULL(A.INCYY10,'')INCYY10,  A.INC10001, A.INC10002,A.INC10003, A.INC10004, A.INC10005,                 \n");
					sql.append("  IFNULL(A.INCYY11,'')INCYY11,  A.INC11001, A.INC11002,A.INC11003, A.INC11004, A.INC11005,                 \n");
					sql.append("  IFNULL(A.INCYY12,'')INCYY12,  A.INC12001, A.INC12002,A.INC12003, A.INC12004, A.INC12005,                 \n");
					sql.append("  A.SINC001,  A.SINC002,  A.SINC003, A.SINC004, A.SINC005,                                                 \n");
					sql.append("  IFNULL(A.FREYY01,'')FREYY01,A.FRE01001, A.FRE01002, A.FRE01003, A.FRE01005, A.FRE01006,                  \n");
          sql.append("  IFNULL(A.FREYY02,'')FREYY02,A.FRE02001, A.FRE02002, A.FRE02003, A.FRE02005, A.FRE02006,                  \n");
					sql.append("  IFNULL(A.FREYY03,'')FREYY03,A.FRE03001, A.FRE03002, A.FRE03003, A.FRE03005, A.FRE03006,                  \n");
					sql.append("  IFNULL(A.FREYY04,'')FREYY04,A.FRE04001, A.FRE04002, A.FRE04003, A.FRE04005, A.FRE04006,                  \n");
					sql.append("  IFNULL(A.FREYY05,'')FREYY05,A.FRE05001, A.FRE05002, A.FRE05003, A.FRE05005, A.FRE05006,                  \n");
					sql.append("  IFNULL(A.FREYY06,'')FREYY06,A.FRE06001, A.FRE06002, A.FRE06003, A.FRE06005, A.FRE06006,                  \n");
					sql.append("  IFNULL(A.FREYY07,'')FREYY07,A.FRE07001, A.FRE07002, A.FRE07003, A.FRE07005, A.FRE07006,                  \n");
					sql.append("  IFNULL(A.FREYY08,'')FREYY08,A.FRE08001, A.FRE08002, A.FRE08003, A.FRE08005, A.FRE08006,                  \n");
					sql.append("  IFNULL(A.FREYY09,'')FREYY09,A.FRE09001, A.FRE09002, A.FRE09003, A.FRE09005, A.FRE09006,                  \n");
					sql.append("  IFNULL(A.FREYY10,'')FREYY10,A.FRE10001, A.FRE10002, A.FRE10003, A.FRE10005, A.FRE10006,                  \n");
					sql.append("  IFNULL(A.FREYY11,'')FREYY11,A.FRE11001, A.FRE11002, A.FRE11003, A.FRE11005, A.FRE11006,                  \n");
					sql.append("  IFNULL(A.FREYY12,'')FREYY12,A.FRE12001, A.FRE12002, A.FRE12003, A.FRE12005, A.FRE12006,                  \n");
					sql.append("  A.SFRE001, A.SFRE002,  A.SFRE003,  A.SFRE005, A.SFRE006,                                                 \n");
					sql.append("  A.COL01001, A.COL01002, A.COL01003, A.COL01004, A.COL01005, A.COL01006, A.COL01007, A.COL01008,          \n");
					sql.append("  A.COL02001, A.COL02002, A.COL02003, A.COL02004, A.COL02005, A.COL02006, A.COL02007, A.COL02008,          \n");
					sql.append("  A.COL03001, A.COL03002, A.COL03003, A.COL03004, A.COL03005, A.COL03006, A.COL03007, A.COL03008,          \n");
					sql.append("  A.COL04001, A.COL04002, A.COL04003, A.COL04004, A.COL04005, A.COL04006, A.COL04007, A.COL04008,          \n");
          sql.append("  A.COL05001, A.COL05002, A.COL05003, A.COL05004, A.COL05005, A.COL05006, A.COL05007, A.COL05008,          \n");
					sql.append("  A.COL06001, A.COL06002, A.COL06003, A.COL06004, A.COL06005, A.COL06006, A.COL06007, A.COL06008,          \n");
					sql.append("  A.COL07001, A.COL07002, A.COL07003, A.COL07004, A.COL07005, A.COL07006, A.COL07007, A.COL07008,          \n");
					sql.append("  A.COL08001, A.COL08002, A.COL08003, A.COL08004, A.COL08005, A.COL08006, A.COL08007, A.COL08008,          \n");
					sql.append("  A.COL09001, A.COL09002, A.COL09003, A.COL09004, A.COL09005, A.COL09006, A.COL09007, A.COL09008,          \n");
					sql.append("  A.COL10001, A.COL10002, A.COL10003, A.COL10004, A.COL10005, A.COL10006, A.COL10007, A.COL10008,          \n");
					sql.append("  A.COL11001, A.COL11002, A.COL11003, A.COL11004, A.COL11005, A.COL11006, A.COL11007, A.COL11008,          \n");
					sql.append("  A.COL12001, A.COL12002, A.COL12003, A.COL12004, A.COL12005, A.COL12006, A.COL12007, A.COL12008,          \n");
					sql.append("  A.SCOL002,  A.SCOL003,  A.SCOL004,  A.SCOL005,  A.SCOL006,  A.SCOL007, A.SCOL008,                        \n");
					sql.append("  A.EXC01001, A.EXC01002, A.EXC01003, A.EXC01004,A.EXC01005,                                               \n");
					sql.append("  A.EXC02001, A.EXC02002, A.EXC02003, A.EXC02004,A.EXC02005,                                               \n");
					sql.append("  A.EXC03001, A.EXC03002, A.EXC03003, A.EXC03004,A.EXC03005,                                               \n");
					sql.append("  A.EXC04001, A.EXC04002, A.EXC04003, A.EXC04004,A.EXC04005,                                               \n");
					sql.append("  A.EXC05001, A.EXC05002, A.EXC05003, A.EXC05004,A.EXC05005,                                               \n");
					sql.append("  A.EXC06001, A.EXC06002, A.EXC06003, A.EXC06004,A.EXC06005,                                               \n");
					sql.append("  A.EXC07001, A.EXC07002, A.EXC07003, A.EXC07004,A.EXC07005,                                               \n");
          sql.append("  A.EXC08001, A.EXC08002, A.EXC08003, A.EXC08004,A.EXC08005,                                               \n");
					sql.append("  A.EXC09001, A.EXC09002, A.EXC09003, A.EXC09004,A.EXC09005,                                               \n");
					sql.append("  A.EXC10001, A.EXC10002, A.EXC10003, A.EXC10004,A.EXC10005,                                               \n");
					sql.append("  A.EXC11001, A.EXC11002, A.EXC11003, A.EXC11004,A.EXC11005,                                               \n");
					sql.append("  A.EXC12001, A.EXC12002, A.EXC12003, A.EXC12004,A.EXC12005,                                               \n");
					sql.append("  COALESCE(A.EXC01001,0)+COALESCE(A.EXC02001,0)+COALESCE(A.EXC03001,0)+COALESCE(A.EXC04001,0)+             \n");
					sql.append("  COALESCE(A.EXC05001,0)+COALESCE(A.EXC06001,0)+COALESCE(A.EXC07001,0)+COALESCE(A.EXC08001,0)+             \n");
					sql.append("  COALESCE(A.EXC09001,0)+COALESCE(A.EXC10001,0)+COALESCE(A.EXC11001,0)+COALESCE(A.EXC12001,0) AS SEXC001,  \n");
					sql.append("  COALESCE(A.EXC01002,0)+COALESCE(A.EXC02002,0)+COALESCE(A.EXC03002,0)+COALESCE(A.EXC04002,0)+             \n");
					sql.append("  COALESCE(A.EXC05002,0)+COALESCE(A.EXC06002,0)+COALESCE(A.EXC07002,0)+COALESCE(A.EXC08002,0)+             \n");
					sql.append("  COALESCE(A.EXC09002,0)+COALESCE(A.EXC10002,0)+COALESCE(A.EXC11002,0)+COALESCE(A.EXC12002,0) AS SEXC002,  \n");
					sql.append("  COALESCE(A.EXC01003,0)+COALESCE(A.EXC02003,0)+COALESCE(A.EXC03003,0)+COALESCE(A.EXC04003,0)+             \n");
					sql.append("  COALESCE(A.EXC05003,0)+COALESCE(A.EXC06003,0)+COALESCE(A.EXC07003,0)+COALESCE(A.EXC08003,0)+             \n");
					sql.append("  COALESCE(A.EXC09003,0)+COALESCE(A.EXC10003,0)+COALESCE(A.EXC11003,0)+COALESCE(A.EXC12003,0) AS SEXC003,  \n");
					sql.append("  COALESCE(A.EXC01004,0)+COALESCE(A.EXC02004,0)+COALESCE(A.EXC03004,0)+COALESCE(A.EXC04004,0)+             \n");
					sql.append("  COALESCE(A.EXC05004,0)+COALESCE(A.EXC06004,0)+COALESCE(A.EXC07004,0)+COALESCE(A.EXC08004,0)+             \n");
					sql.append("  COALESCE(A.EXC09004,0)+COALESCE(A.EXC10004,0)+COALESCE(A.EXC11004,0)+COALESCE(A.EXC12004,0) AS SEXC004,  \n");
					sql.append("  COALESCE(A.EXC01005,0)+COALESCE(A.EXC02005,0)+COALESCE(A.EXC03005,0)+COALESCE(A.EXC04005,0)+             \n");
					sql.append("  COALESCE(A.EXC05005,0)+COALESCE(A.EXC06005,0)+COALESCE(A.EXC07005,0)+COALESCE(A.EXC08005,0)+             \n");
					sql.append("  COALESCE(A.EXC09005,0)+COALESCE(A.EXC10005,0)+COALESCE(A.EXC11005,0)+COALESCE(A.EXC12005,0) AS SEXC005,  \n");
					sql.append("  IFNULL(A.FREYY01,'') AS EXCYY01, IFNULL(A.FREYY02,'') AS EXCYY02, IFNULL(A.FREYY03,'') AS EXCYY03,       \n");
					sql.append("  IFNULL(A.FREYY04,'') AS EXCYY04, IFNULL(A.FREYY05,'') AS EXCYY05, IFNULL(A.FREYY06,'') AS EXCYY06,       \n");
					sql.append("  IFNULL(A.FREYY07,'') AS EXCYY07, IFNULL(A.FREYY08,'') AS EXCYY08, IFNULL(A.FREYY09,'') AS EXCYY09,       \n");
					sql.append("  IFNULL(A.FREYY10,'') AS EXCYY10, IFNULL(A.FREYY11,'') AS EXCYY11, IFNULL(A.FREYY12,'') AS EXCYY12        \n");
          /**
					sql.append(" SELECT ");    
					sql.append("\n").append( "A.YYYY,     A.EMPNO,    A.EMPNMK,	 B.DEPTNM,  ");	
					sql.append("\n").append( "IFNULL(A.INCYY01,'')INCYY01,  A.INC01001, A.INC01002,	"); 
					sql.append("\n").append( "A.INC01003, A.INC01004, A.INC01005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY02,'')INCYY02,  A.INC02001, A.INC02002,	"); 
					sql.append("\n").append( "A.INC02003, A.INC02004, A.INC02005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY03,'')INCYY03,  A.INC03001, A.INC03002,	"); 
					sql.append("\n").append( "A.INC03003, A.INC03004, A.INC03005, "); 
					sql.append("\n").append( "IFNULL(A.INCYY04,'')INCYY04,  A.INC04001, A.INC04002,	"); 
					sql.append("\n").append( "A.INC04003, A.INC04004, A.INC04005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY05,'')INCYY05,  A.INC05001, A.INC05002,	"); 
					sql.append("\n").append( "A.INC05003, A.INC05004, A.INC05005, ");
					sql.append("\n").append( "IFNULL(A.INCYY06,'')INCYY06,  A.INC06001, A.INC06002,	"); 
					sql.append("\n").append( "A.INC06003, A.INC06004, A.INC06005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY07,'')INCYY07,  A.INC07001, A.INC07002,	"); 
					sql.append("\n").append( "A.INC07003, A.INC07004, A.INC07005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY08,'')INCYY08,  A.INC08001, A.INC08002,	"); 
					sql.append("\n").append( "A.INC08003, A.INC08004, A.INC08005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY09,'')INCYY09,  A.INC09001, A.INC09002,	"); 
					sql.append("\n").append( "A.INC09003, A.INC09004, A.INC09005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY10,'')INCYY10,  A.INC10001, A.INC10002,	"); 
					sql.append("\n").append( "A.INC10003, A.INC10004, A.INC10005,	");
					sql.append("\n").append( "IFNULL(A.INCYY11,'')INCYY11,  A.INC11001, A.INC11002,	"); 
					sql.append("\n").append( "A.INC11003, A.INC11004, A.INC11005,	"); 
					sql.append("\n").append( "IFNULL(A.INCYY12,'')INCYY12,  A.INC12001, A.INC12002,	"); 
					sql.append("\n").append( "A.INC12003, A.INC12004, A.INC12005, "); 
					sql.append("\n").append( "A.SINC001,  A.SINC002,  A.SINC003,	"); 
					sql.append("\n").append( "A.SINC004, A.SINC005,								"); 
					sql.append("\n").append( "IFNULL(A.FREYY01,'')FREYY01,													"); 
					sql.append("\n").append( "A.FRE01001, A.FRE01002, A.FRE01003,	"); 
					sql.append("\n").append( "RTRIM(A.FRE01004) FRE01004, A.FRE01005, IFNULL(A.FREYY02,'')FREYY02,	"); 
					sql.append("\n").append( "A.FRE02001, A.FRE02002, A.FRE02003,	"); 
					sql.append("\n").append( "RTRIM(A.FRE02004) FRE02004, A.FRE02005, IFNULL(A.FREYY03,'')FREYY03,	"); 		
					sql.append("\n").append( "A.FRE03001, A.FRE03002, A.FRE03003,	");
					sql.append("\n").append( "RTRIM(A.FRE03004) FRE03004, A.FRE03005, IFNULL(A.FREYY04,'')FREYY04, 	");
					sql.append("\n").append( "A.FRE04001, A.FRE04002, A.FRE04003,	");
					sql.append("\n").append( "RTRIM(A.FRE04004) FRE04004, A.FRE04005, IFNULL(A.FREYY05,'')FREYY05, 	");
					sql.append("\n").append( "A.FRE05001, A.FRE05002, A.FRE05003, ");
					sql.append("\n").append( "RTRIM(A.FRE05004) FRE05004, A.FRE05005, IFNULL(A.FREYY06,'')FREYY06, 	");
					sql.append("\n").append( "A.FRE06001, A.FRE06002, A.FRE06003, ");
					sql.append("\n").append( "RTRIM(A.FRE06004) FRE06004, A.FRE06005, IFNULL(A.FREYY07,'')FREYY07,	");
					sql.append("\n").append( "A.FRE07001, A.FRE07002, A.FRE07003, ");
					sql.append("\n").append( "RTRIM(A.FRE07004) FRE07004, A.FRE07005, IFNULL(A.FREYY08,'')FREYY08,	");
					sql.append("\n").append( "A.FRE08001, A.FRE08002, A.FRE08003, ");    
					sql.append("\n").append( "RTRIM(A.FRE08004) FRE08004, A.FRE08005, IFNULL(A.FREYY09,'')FREYY09,  ");						
					sql.append("\n").append( "A.FRE09001, A.FRE09002, A.FRE09003, ");     
					sql.append("\n").append( "RTRIM(A.FRE09004) FRE09004, A.FRE09005, IFNULL(A.FREYY10,'')FREYY10,  ");	
					sql.append("\n").append( "A.FRE10001, A.FRE10002, A.FRE10003, ");    
					sql.append("\n").append( "RTRIM(A.FRE10004) FRE10004, A.FRE10005, IFNULL(A.FREYY11,'')FREYY11,  ");     
					sql.append("\n").append( "A.FRE11001, A.FRE11002, A.FRE11003, ");   
					sql.append("\n").append( "RTRIM(A.FRE11004) FRE11004, A.FRE11005, IFNULL(A.FREYY12,'')FREYY12,  ");   
					sql.append("\n").append( "A.FRE12001, A.FRE12002, A.FRE12003, ");   
					sql.append("\n").append( "RTRIM(A.FRE12004) FRE12004, A.FRE12005,   ");	
					sql.append("\n").append( "A.SFRE001,  ");	
					sql.append("\n").append( "A.SFRE002,  A.SFRE003,  A.SFRE005,  ");             
					sql.append("\n").append( "A.COL01001, A.COL01002, A.COL01003, "); 
					sql.append("\n").append( "A.COL01004, A.COL01005, A.COL01006,	");	
					sql.append("\n").append( "A.COL01007, A.COL01008,             ");	                                
					sql.append("\n").append( "A.COL02001, A.COL02002, A.COL02003,	");
					sql.append("\n").append( "A.COL02004, A.COL02005, A.COL02006,	");	
					sql.append("\n").append( "A.COL02007, A.COL02008,             ");		                                      
					sql.append("\n").append( "A.COL03001, A.COL03002, A.COL03003,	");
					sql.append("\n").append( "A.COL03004, A.COL03005, A.COL03006,	");
					sql.append("\n").append( "A.COL03007, A.COL03008,             ");		                               
					sql.append("\n").append( "A.COL04001, A.COL04002, A.COL04003,	");
					sql.append("\n").append( "A.COL04004, A.COL04005, A.COL04006,	");
					sql.append("\n").append( "A.COL04007, A.COL04008,             ");
					sql.append("\n").append( "A.COL05001, A.COL05002, A.COL05003,	");
					sql.append("\n").append( "A.COL05004, A.COL05005, A.COL05006,	");
					sql.append("\n").append( "A.COL05007, A.COL05008,             ");
					sql.append("\n").append( "A.COL06001, A.COL06002, A.COL06003,	");
					sql.append("\n").append( "A.COL06004, A.COL06005, A.COL06006,	");
					sql.append("\n").append( "A.COL06007, A.COL06008,             ");
					sql.append("\n").append( "A.COL07001, A.COL07002, A.COL07003,	");
					sql.append("\n").append( "A.COL07004, A.COL07005, A.COL07006,	");
					sql.append("\n").append( "A.COL07007, A.COL07008,             ");
					sql.append("\n").append( "A.COL08001, A.COL08002, A.COL08003,	");
					sql.append("\n").append( "A.COL08004, A.COL08005, A.COL08006,	");
					sql.append("\n").append( "A.COL08007, A.COL08008,             ");
					sql.append("\n").append( "A.COL09001, A.COL09002, A.COL09003,	");
					sql.append("\n").append( "A.COL09004, A.COL09005, A.COL09006,	");
					sql.append("\n").append( "A.COL09007, A.COL09008,             ");
					sql.append("\n").append( "A.COL10001, A.COL10002, A.COL10003,	");
					sql.append("\n").append( "A.COL10004, A.COL10005, A.COL10006,	");
					sql.append("\n").append( "A.COL10007, A.COL10008,             ");
					sql.append("\n").append( "A.COL11001, A.COL11002, A.COL11003,	");
					sql.append("\n").append( "A.COL11004, A.COL11005, A.COL11006,	");
					sql.append("\n").append( "A.COL11007, A.COL11008,             ");
					sql.append("\n").append( "A.COL12001, A.COL12002, A.COL12003,	");
					sql.append("\n").append( "A.COL12004, A.COL12005, A.COL12006,	");
					sql.append("\n").append( "A.COL12007, A.COL12008,             ");
					sql.append("\n").append( "A.COL13007, A.COL13008,           	");
					sql.append("\n").append( "A.SCOL002,  A.SCOL003,  A.SCOL004,  ");       
					sql.append("\n").append( "A.SCOL005,  A.SCOL006,  A.SCOL007,  ");        
					sql.append("\n").append( "A.SCOL008,                           ");
          sql.append("\n").append( "A.EXC01001, A.EXC01002, A.EXC01003, A.EXC01004,A.EXC01005, ");
					sql.append("\n").append( "A.EXC02001, A.EXC02002, A.EXC02003, A.EXC02004,A.EXC02005, ");
					sql.append("\n").append( "A.EXC03001, A.EXC03002, A.EXC03003, A.EXC03004,A.EXC03005, ");
					sql.append("\n").append( "A.EXC04001, A.EXC04002, A.EXC04003, A.EXC04004,A.EXC04005, ");
					sql.append("\n").append( "A.EXC05001, A.EXC05002, A.EXC05003, A.EXC05004,A.EXC05005, ");
					sql.append("\n").append( "A.EXC06001, A.EXC06002, A.EXC06003, A.EXC06004,A.EXC06005, ");
					sql.append("\n").append( "A.EXC07001, A.EXC07002, A.EXC07003, A.EXC07004,A.EXC07005, ");
					sql.append("\n").append( "A.EXC08001, A.EXC08002, A.EXC08003, A.EXC08004,A.EXC08005, ");
					sql.append("\n").append( "A.EXC09001, A.EXC09002, A.EXC09003, A.EXC09004,A.EXC09005, ");
					sql.append("\n").append( "A.EXC10001, A.EXC10002, A.EXC10003, A.EXC10004,A.EXC10005, ");
					sql.append("\n").append( "A.EXC11001, A.EXC11002, A.EXC11003, A.EXC11004,A.EXC11005, ");
					sql.append("\n").append( "A.EXC12001, A.EXC12002, A.EXC12003, A.EXC12004,A.EXC12005, ");
					sql.append("\n").append( "COALESCE(A.EXC01001,0)+COALESCE(A.EXC02001,0)+COALESCE(A.EXC03001,0)+COALESCE(A.EXC04001,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC05001,0)+COALESCE(A.EXC06001,0)+COALESCE(A.EXC07001,0)+COALESCE(A.EXC08001,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC09001,0)+COALESCE(A.EXC10001,0)+COALESCE(A.EXC11001,0)+COALESCE(A.EXC12001,0) AS SEXC001,");
					sql.append("\n").append( "COALESCE(A.EXC01002,0)+COALESCE(A.EXC02002,0)+COALESCE(A.EXC03002,0)+COALESCE(A.EXC04002,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC05002,0)+COALESCE(A.EXC06002,0)+COALESCE(A.EXC07002,0)+COALESCE(A.EXC08002,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC09002,0)+COALESCE(A.EXC10002,0)+COALESCE(A.EXC11002,0)+COALESCE(A.EXC12002,0) AS SEXC002,");
					sql.append("\n").append( "COALESCE(A.EXC01003,0)+COALESCE(A.EXC02003,0)+COALESCE(A.EXC03003,0)+COALESCE(A.EXC04003,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC05003,0)+COALESCE(A.EXC06003,0)+COALESCE(A.EXC07003,0)+COALESCE(A.EXC08003,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC09003,0)+COALESCE(A.EXC10003,0)+COALESCE(A.EXC11003,0)+COALESCE(A.EXC12003,0) AS SEXC003,");
					sql.append("\n").append( "COALESCE(A.EXC01004,0)+COALESCE(A.EXC02004,0)+COALESCE(A.EXC03004,0)+COALESCE(A.EXC04004,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC05004,0)+COALESCE(A.EXC06004,0)+COALESCE(A.EXC07004,0)+COALESCE(A.EXC08004,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC09004,0)+COALESCE(A.EXC10004,0)+COALESCE(A.EXC11004,0)+COALESCE(A.EXC12004,0) AS SEXC004, ");
					sql.append("\n").append( "COALESCE(A.EXC01005,0)+COALESCE(A.EXC02005,0)+COALESCE(A.EXC03005,0)+COALESCE(A.EXC04005,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC05005,0)+COALESCE(A.EXC06005,0)+COALESCE(A.EXC07005,0)+COALESCE(A.EXC08005,0)+           ");
					sql.append("\n").append( "COALESCE(A.EXC09005,0)+COALESCE(A.EXC10005,0)+COALESCE(A.EXC11005,0)+COALESCE(A.EXC12005,0) AS SEXC005, ");
					sql.append("\n").append( "IFNULL(A.FREYY01,'') AS EXCYY01, IFNULL(A.FREYY02,'') AS EXCYY02, IFNULL(A.FREYY03,'') AS EXCYY03, ");
					sql.append("\n").append( "IFNULL(A.FREYY04,'') AS EXCYY04, IFNULL(A.FREYY05,'') AS EXCYY05, IFNULL(A.FREYY06,'') AS EXCYY06, ");
					sql.append("\n").append( "IFNULL(A.FREYY07,'') AS EXCYY07, IFNULL(A.FREYY08,'') AS EXCYY08, IFNULL(A.FREYY09,'') AS EXCYY09, ");
					sql.append("\n").append( "IFNULL(A.FREYY10,'') AS EXCYY10, IFNULL(A.FREYY11,'') AS EXCYY11, IFNULL(A.FREYY12,'') AS EXCYY12 ");
          **/

					sql.append( " FROM PAYROLL.YCPERCOL A  \n ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					sql.append( " WHERE A.YYYY    = '" + str[0] + "'		 \n ");
				  sql.append( " AND A.DEPTCD  LIKE '" + str[1] + "%'	 \n ");
				  sql.append( " AND A.EMPNMK  LIKE '" + str[2] + "%'	 \n	");
				  //  sql.append("\n").append( " AND A.DEPTCD = B.DEPTCD									");	
					sql.append( " ORDER BY A.EMPNMK \n									 \n ");

					logger.dbg.println(this, sql.toString());
             
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
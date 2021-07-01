package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t14 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			String strFsnbr="";
            int intChk=0;
			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				// 웹페이지에서 조건값을 넘겨받음
				String  str1 = req.getParameter("v_str1");          //지점코드  FDCODE    VARCHAR(2)       
				String  str2 = req.getParameter("v_str2");  		//자산명   ASTNAME VARCHAR(30) 
				String  str3 = req.getParameter("v_str3");         //자산중분류  필수   AST2ND  VARCHAR(2)      
				String  str4 = req.getParameter("v_str4");        //자산소분류  필수  AST3RD   VARCHAR(2)        
				String  str5 = req.getParameter("v_str5");          //계정코드   필수    ATCODE   VARCHAR(7)  
				String  str6 = req.getParameter("v_str6");           //취득일자 	 ASAQSDAT   VARCHAR(8)         
				String  str7 = req.getParameter("v_str7");  		//계산서번호    TAXNBR    VARCHAR(10)     
				String  str8 = req.getParameter("v_str8");  	//회계접수번호   FSNBR     VARCHAR(6)          
				String  str9 = req.getParameter("v_str9");        //담당부서         DEPTCD  VARCHAR(4)       
				String  str10 = req.getParameter("v_str10");           //담당자      EMPNO    VARCHAR(7)      
				String  str11 = req.getParameter("v_str11");   //관리구분      MNGTYPE      VARCHAR(1)         
				String  str12 = req.getParameter("v_str12");   //상태코드        ASTSTAT   VARCHAR(1)          
				String  str13 = req.getParameter("v_str13");  //매출원가구분 ASCOSDIV	VARCHAR(1)   
				String  str14 = req.getParameter("v_str14");   //원가코드    COSTCD	VARCHAR(6)           
				String  str15 = req.getParameter("v_str15");   //취득구분 	ASAQSDIV	VARCHAR(1)                                  
				String  str16 = req.getParameter("v_str16");    //자산구분   GODDIV	VARCHAR(1)   
				String  str17 = req.getParameter("v_str17");    //자산등급   ASTCLASS	VARCHAR(1)   
				String  str18 = req.getParameter("v_str18");    //리스유무   ASTRIS	VARCHAR(1)           
				String  str19 = req.getParameter("v_str19");     //단위      ASTUNIT	VARCHAR(2)           
				String  str20 = req.getParameter("v_str20");     //수량  	ASTQTY	DECIMAL(10,0)    
				String  str21 = req.getParameter("v_str21");      //규격	ASTSTD	VARCHAR(30)          
				String  str22 = req.getParameter("v_str22");   //취득금액    ASTAQAMT	DECIMAL(13,0)
				String  str23 = req.getParameter("v_str23");      //내용년수 ASTYUSE	DECIMAL(3,0)         
				String  str24 = req.getParameter("v_str24");    //재평가일자 ASTVALYMD	VARCHAR(8)   
				String  str25 = req.getParameter("v_str25");     //관리부서 	MNGDPT	VARCHAR(4)   
				String  str26 = req.getParameter("v_str26");    //사용부서   USEDPT	VARCHAR(4)           
				String  str27 = req.getParameter("v_str27");      //설치장소 USELOC	VARCHAR(30)          
				String  str28 = req.getParameter("v_str28");        //구입처 BUYFROM	VARCHAR(13)          
				String  str29 = req.getParameter("v_str29");     //제작처    MAKER	VARCHAR(30)          
				String  str30 = req.getParameter("v_str30");       //비고    ASTNOTE	VARCHAR(50)				

				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE	  = userSet.indexOfColumn("FDCODE");	   
				int idxASTNAME	  = userSet.indexOfColumn("ASTNAME");	   
				int idxAST2ND	  = userSet.indexOfColumn("AST2ND");	   
				int idxAST3RD	  = userSet.indexOfColumn("AST3RD");	   
				int idxATCODE	  = userSet.indexOfColumn("ATCODE");	   
			 						            
				int idxASAQSDAT	  = userSet.indexOfColumn("ASAQSDAT");	   
				int idxTAXNBR	  = userSet.indexOfColumn("TAXNBR");	   
				int idxFSNBR	  = userSet.indexOfColumn("FSNBR");	   
				int idxDEPTCD	  = userSet.indexOfColumn("DEPTCD");	   
				int idxEMPNO	  = userSet.indexOfColumn("EMPNO");	 
				  					            
				int idxMNGTYPE    = userSet.indexOfColumn("MNGTYPE");  
				int idxASTSTAT	  = userSet.indexOfColumn("ASTSTAT");	   
				int idxASCOSDIV	  = userSet.indexOfColumn("ASCOSDIV");	   
				int idxCOSTCD	  = userSet.indexOfColumn("COSTCD");	   
				int idxASAQSDIV	  = userSet.indexOfColumn("ASAQSDIV");	   
				int idxGODDIV	  = userSet.indexOfColumn("GODDIV");	   
		   							            
				int idxASTCLASS	  = userSet.indexOfColumn("ASTCLASS");	   
				int idxASTRIS	  = userSet.indexOfColumn("ASTRIS");	   
				int idxASTUNIT	  = userSet.indexOfColumn("ASTUNIT");	   
				int idxASTQTY	  = userSet.indexOfColumn("ASTQTY");	   
									            
				int idxASTSTD	  = userSet.indexOfColumn("ASTSTD");	 
				int idxASTAQAMT	  = userSet.indexOfColumn("ASTAQAMT");	
				int idxASTYUSE	  = userSet.indexOfColumn("ASTYUSE");	   
				int idxASTVALYMD  = userSet.indexOfColumn("ASTVALYMD");   
				int idxMNGDPT	  = userSet.indexOfColumn("MNGDPT");	   
			   						            
				int idxUSEDPT	  = userSet.indexOfColumn("USEDPT");	   
				int idxUSELOC	  = userSet.indexOfColumn("USELOC");	   
				int idxBUYFROM	  = userSet.indexOfColumn("BUYFROM");	   
				int idxMAKER	  = userSet.indexOfColumn("MAKER");	      
				int idxASTNOTE	  = userSet.indexOfColumn("ASTNOTE");	      
		
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	      
				StringBuffer InsertSql2 = null;       

				if(IsUpdated.equals("2")){

				UpdateSql = new StringBuffer();

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
              }else if (IsUpdated.equals("1")){
//////////////////////////////////////////////////////////		
                          Statement stmt = conn.createStatement();

							String sql = "SELECT COALESCE(MAX(ASTSEQ),0)+1 AS ASTSEQ FROM  ACCOUNT.ASTMST "
					                   + "	WHERE FDCODE = '"+str1+"'"	
									   + "  AND   AST2ND = '"+str3+"'"  
									   + "  AND   AST3RD = '"+str4+"'" ;					
                          
							ResultSet rs = stmt.executeQuery(sql); 

							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}

							int ichk = Integer.parseInt(strFsnbr);
							if(ichk<10) strFsnbr = "0000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="00"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "0"+strFsnbr;


						    if(intChk==0){  
						    InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTMST ( FDCODE,ASTNAME,AST2ND,	AST3RD,	ATCODE,	ASAQSDAT,	TAXNBR,	FSNBR,	DEPTCD,EMPNO, ASTSEQ	)" );
							InsertSql.append( "  VALUES ( '" + str1 + "','" 	
														 + str2 + "','" 	
						                                 + str3 + "','" + str4 + "','" + str5+ "','" 
														 + str6 + "','" + str7 + "','" + str8 + "','" + str9+ "','" 
						                             	 + str10 + "','" + strFsnbr+ "' ) " );
						


							InsertSql2 = new StringBuffer();
							InsertSql2.append( " INSERT INTO ACCOUNT.ASTBASIC ( FDCODE, ASTNAME, AST2ND,	AST3RD,	ATCODE,  " );
							InsertSql2.append( "  MNGTYPE,  ASTSTAT,	ASCOSDIV,	COSTCD,	ASAQSDIV,	GODDIV,	       " );
							InsertSql2.append( "  ASTCLASS,	 ASTRIS,	ASTUNIT,	ASTQTY,		ASTSTD,	ASTAQAMT,	    " );
							InsertSql2.append( "  ASTYUSE,	ASTVALYMD,  MNGDPT,	USEDPT,	USELOC,	BUYFROM,	MAKER,	ASTNOTE, ASTSEQ )" );
							InsertSql2.append( "  VALUES ( '" + str1 + "','" + str2 + "','" 	
								 + str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
								 + str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" 
								 + str11 + "','" + str12 + "','" + str13 + "','" + str14+ "','" 
								 + str15 + "','" + str16 + "','" + str17 + "','" + str18+ "','" 
								 + str19 + "','" + str20 + "','" + str21 + "','" + str22+ "','" 
								 + str23 + "','" + str24 + "','" + str25 + "','" + str26+ "','" 
								 + str27 + "','" + str28 + "','" + str29 + "','" + str30+ "','" 
                            	 + strFsnbr+ "' ) " );

								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 	
                            	 	
								 gsmt.executeUpdate(); 
								 gsmt.close();				
								 

								 GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());	 	
                            	 	
								 gsmt2.executeUpdate(); 
								 gsmt2.close();							
                         
							}
			///////////////////////////			
				}
			
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
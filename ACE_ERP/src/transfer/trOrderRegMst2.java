package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.io.PrintStream;
import java.io.PrintWriter;

public class trOrderRegMst2 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		CallableStatement cstmt = null;
		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=null; }
				String ord_sts = reqGauce.getParameter("gstr2"); 
   				if ( ord_sts==null || ord_sts.trim().length()==0 ) { ord_sts=null; }
				String car_seq_no = null ; 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("CAR");
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("CAR3");

				int idxORDER_NO			= userSet.indexOfColumn("ORDER_NO");
				int idxIN_OUT				= userSet.indexOfColumn("IN_OUT");
				int idxORDER_STS		= userSet.indexOfColumn("ORDER_STS");
				int idxETD_DT				= userSet.indexOfColumn("ETD_DT");
				int idxLINE_PART		= userSet.indexOfColumn("LINE_PART");
				int idxPROJECT			= userSet.indexOfColumn("PROJECT");
				int idxCUST_CD			= userSet.indexOfColumn("CUST_CD");
				int idxCUST_PRSN		= userSet.indexOfColumn("CUST_PRSN");
				int idxCUST_TELNO		= userSet.indexOfColumn("CUST_TELNO");
				int idxCARGO_TYPE		= userSet.indexOfColumn("CARGO_TYPE");
				int idxDLVL_TYPE		= userSet.indexOfColumn("DLVL_TYPE");
				int idxDLVL_DATE		= userSet.indexOfColumn("DLVL_DATE");
				int idxSHIPPER			= userSet.indexOfColumn("SHIPPER");
				int idxSHIPPERPS		= userSet.indexOfColumn("SHIPPERPS");
				int idxSHIPPERTEL		= userSet.indexOfColumn("SHIPPERTEL");
				int idxETA_DT				= userSet.indexOfColumn("ETA_DT");
				int idxORDER_DATE		= userSet.indexOfColumn("ORDER_DATE");
				int idxFEE_IN				= userSet.indexOfColumn("FEE_IN");
				int idxFEE_OUT			= userSet.indexOfColumn("FEE_OUT");
				int idxGORDER_NO		= userSet.indexOfColumn("GORDER_NO");
				int idxRQST_NO			= userSet.indexOfColumn("RQST_NO");
				int idxPL_TYPE			= userSet.indexOfColumn("PL_TYPE");
				int idxPL_SHIPPER		= userSet.indexOfColumn("PL_SHIPPER");
				int idxPL_SHPPRNM		= userSet.indexOfColumn("PL_SHPPRNM");
				int idxPL_CSTM			= userSet.indexOfColumn("PL_CSTM");
				int idxPL_CSTMNM		= userSet.indexOfColumn("PL_CSTMNM");
				int idxPL_BRKR			= userSet.indexOfColumn("PL_BRKR");
				int idxPL_BRKRNM		= userSet.indexOfColumn("PL_BRKRNM");
				int idxRPST_GOODS		= userSet.indexOfColumn("RPST_GOODS");
				int idxTOTAL_CNT		= userSet.indexOfColumn("TOTAL_CNT");
				int idxTOTAL_UNIT		= userSet.indexOfColumn("TOTAL_UNIT");
				int idxTOTAL_WGHT		= userSet.indexOfColumn("TOTAL_WGHT");
				int idxTOTAL_CBM		= userSet.indexOfColumn("TOTAL_CBM");
				int idxCANCLE_DATE	= userSet.indexOfColumn("CANCLE_DATE");
				int idxREMARK				= userSet.indexOfColumn("REMARK");
				int idxPRICETYPE		= userSet.indexOfColumn("PRICETYPE");
				int idxSETTLETYPE		= userSet.indexOfColumn("SETTLETYPE");
				int idxLC_NO				= userSet.indexOfColumn("LC_NO");
				int idxLC_DATE			= userSet.indexOfColumn("LC_DATE");
				int idxLC_BANK			= userSet.indexOfColumn("LC_BANK");
				int idxEXPRT_NO			= userSet.indexOfColumn("EXPRT_NO");
				int idxEXPRT_DATE		= userSet.indexOfColumn("EXPRT_DATE");
				int idxCREATE_USR		= userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_USR		= userSet.indexOfColumn("UPDATE_USR");
				int idxLDCARGO			= userSet.indexOfColumn("LDCARGO"); 
				int idxLDCARGONM		= userSet.indexOfColumn("LDCARGONM");
				int idxOFFCARGO			= userSet.indexOfColumn("OFFCARGO");
				int idxOFFCARGONM		= userSet.indexOfColumn("OFFCARGONM"); 
				int idxCONSIGNEE		= userSet.indexOfColumn("CONSIGNEE"); 
				int idxCUST_HPNO		= userSet.indexOfColumn("CUST_HPNO"); 
				int idxSHIPPERHP		= userSet.indexOfColumn("SHIPPERHP");  	
				int idxDIV_IO				= userSet.indexOfColumn("DIV_IO");
				int idxPL_SHIPADDR	= userSet.indexOfColumn("PL_SHIPADDR");
				int idxPL_SHIPTEL		= userSet.indexOfColumn("PL_SHIPTEL");
				int idxPL_CSTADDR		= userSet.indexOfColumn("PL_CSTADDR");
				int idxPL_CSTTEL		= userSet.indexOfColumn("PL_CSTTEL");
				int idxPL_BRKADDR		= userSet.indexOfColumn("PL_BRKADDR");
				int idxPL_BRKTEL		= userSet.indexOfColumn("PL_BRKTEL");
				int idxPL_SHPADDR2	= userSet.indexOfColumn("PL_SHPADDR2");
				int idxPL_SHPADDR3	= userSet.indexOfColumn("PL_SHPADDR3");
				int idxPL_CSTADDR2	= userSet.indexOfColumn("PL_CSTADDR2");
				int idxPL_CSTADDR3	= userSet.indexOfColumn("PL_CSTADDR3");
				int idxPL_BRKADDR2	= userSet.indexOfColumn("PL_BRKADDR2");
				int idxPL_BRKADDR3	= userSet.indexOfColumn("PL_BRKADDR3");
				int idxPL_CSN				= userSet.indexOfColumn("PL_CSN");
				int idxPL_CSNNM			= userSet.indexOfColumn("PL_CSNNM");
				int idxPL_CSNTEL		= userSet.indexOfColumn("PL_CSNTEL");
				int idxPL_CSNADDR		= userSet.indexOfColumn("PL_CSNADDR");
				int idxPL_CSNADDR2	= userSet.indexOfColumn("PL_CSNADDR2");
				int idxPL_CSNADDR3	= userSet.indexOfColumn("PL_CSNADDR3");
				int idxETD_DT1			= userSet.indexOfColumn("ETD_DT1") ; 
				int idxATT_FILE			= userSet.indexOfColumn("ATT_FILE") ; 
				int idxFAC_PERSON		= userSet.indexOfColumn("FAC_PERSON") ; 
				int idxFAC_PRSTEL		= userSet.indexOfColumn("FAC_PRSTEL") ; 
				int idxATT_FILENM		= userSet.indexOfColumn("ATT_FILENM") ; 
				int idxOBJ_REMK			= userSet.indexOfColumn("OBJ_REMK") ; 
				int idxRECIPIENT		= userSet.indexOfColumn("RECIPIENT") ; 
				int idxRECP_OWN			= userSet.indexOfColumn("RECP_OWN") ; 
				int idxRECP_TEL			= userSet.indexOfColumn("RECP_TEL") ; 
				int idxRECP_ADD			= userSet.indexOfColumn("RECP_ADD") ; 
				int idx2ORDER_NO		= userSet2.indexOfColumn("ORDER_NO");
				int idx2CAR_SEQ_NO	= userSet2.indexOfColumn("CAR_SEQ_NO");
				int idx2CARTYPENO		= userSet2.indexOfColumn("CARTYPENO");
				int idx2CAR_CNT			= userSet2.indexOfColumn("CAR_CNT");
				int idx2LD_CARGO		= userSet2.indexOfColumn("LD_CARGO");
				int idx2LD_CARGONM	= userSet2.indexOfColumn("LD_CARGONM");
				int idx2OFF_CARGO		= userSet2.indexOfColumn("OFF_CARGO");
				int idx2OFF_CARGONM	= userSet2.indexOfColumn("OFF_CARGONM");
				int idx2CUST_CD			= userSet2.indexOfColumn("CUST_CD");
				int idx2CUST_NAME		= userSet2.indexOfColumn("CUST_NAME");
				int idx2CUST_PS			= userSet2.indexOfColumn("CUST_PS");
				int idx2CUST_TEL		= userSet2.indexOfColumn("CUST_TEL");
				int idx2LD_DATE			= userSet2.indexOfColumn("LD_DATE");
				int idx2PERSON_NO		= userSet2.indexOfColumn("PERSON_NO");
				int idx2CAR_TYPE		= userSet2.indexOfColumn("CAR_TYPE");
				int idx2REMARK			= userSet2.indexOfColumn("REMARK");
				int idx2CTN_STDRD		= userSet2.indexOfColumn("CTN_STDRD");
				int idx2EDT_DATE		= userSet2.indexOfColumn("EDT_DATE");
				int idx2LCT_URL			= userSet2.indexOfColumn("LCT_URL");
				int idx2CREATE_USR	= userSet2.indexOfColumn("CREATE_USR");
				int idx2UPDATE_USR	= userSet2.indexOfColumn("UPDATE_USR");
				int idx2LINE_PART		= userSet2.indexOfColumn("LINE_PART") ; 
				int idx2IN_OUT			= userSet2.indexOfColumn("IN_OUT") ; 
				int idx2ETD_DT		= userSet2.indexOfColumn("ETD_DT");
				int idx3ETD_DT		= userSet3.indexOfColumn("ETD_DT");
				int idx3ORDER_NO	= userSet3.indexOfColumn("ORDER_NO");

				GauceDataRow[] rows = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();
				GauceDataRow[] rows3 = userSet3.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer UpdateSqll = null;
				StringBuffer DeleteSql = null;  
				System.out.println("trOrderRegMst2 3");
				//차량정보
				for (int j = 0; j < rows2.length; j++){

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer sql = new StringBuffer();
						/**
						sql.append( " SELECT ") ; 
						sql.append( "			SUBSTR(CHAR(SYSDATE),3,2) || SUBSTR(CHAR(SYSDATE),6,2) ||  ") ; 
						sql.append( "			CASE WHEN MAX(CAR_SEQ_NO) IS NULL THEN '00001'  ") ; 
						sql.append( "			WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 1  ") ; 
						sql.append( "			THEN '0000' || CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( "			WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 2  ") ; 
						sql.append( "			THEN '000' || CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( "			WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 3  ") ; 
						sql.append( "			THEN '00' || CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( "			WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 4  ") ; 
						sql.append( "			THEN '0' || CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( "			ELSE '00001' END AS CAR_SEQ_NO  ") ; 
						sql.append( "	 FROM TRANSFER.LTORDCAR  ") ; 
						sql.append( " WHERE SUBSTR(CAR_SEQ_NO,1,4) =SUBSTR(CHAR(SYSDATE),3,2) || SUBSTR(CHAR(SYSDATE),6,2)  ") ; 
						**/
						
						sql.append( "SELECT TO_CHAR(SYSDATE,'YYMM')||                                                                                                         \n") ;
						sql.append( "       CASE WHEN MAX(CAR_SEQ_NO) IS NULL THEN '00001'                                                                                    \n") ;
						sql.append( "	         WHEN LENGTH(TO_NUMBER(MAX(SUBSTR(CAR_SEQ_NO,5,5)))+1)IN (1,2,3,4) THEN LPAD(TO_NUMBER(MAX(SUBSTR(CAR_SEQ_NO,5,5)))+ 1,5,'0') \n") ;
						sql.append( "       ELSE '00001' END AS CAR_SEQ_NO                                                                                                    \n") ;
						sql.append( "  FROM TRANSFER.LTORDCAR                                                                                                                 \n") ;
						sql.append( " WHERE SUBSTR(CAR_SEQ_NO,1,4) = TO_CHAR(SYSDATE,'YYMM')                                                                                  \n") ;

						Statement stmt = null;
						ResultSet rs = null;

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next()) {
							car_seq_no = rs.getString(1);
						}
						
						stmt.close();
						rs.close();

						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTORDCAR( ") ; 
						InsertSql.append("			ORDER_NO,CAR_SEQ_NO,CARTYPENO,CAR_CNT,") ; 
						InsertSql.append("			LD_CARGO,LD_CARGONM,OFF_CARGO,OFF_CARGONM,") ; 
						InsertSql.append("			CUST_CD,CUST_NAME,CUST_PS,CUST_TEL,LD_DATE,") ; 
						InsertSql.append("			PERSON_NO,CAR_TYPE,REMARK,CTN_STDRD,EDT_DATE,") ; 
						InsertSql.append("			LCT_URL ,CREATE_DT,CREATE_USR ,UPDATE_DT,UPDATE_USR,") ; 
						InsertSql.append("			LINE_PART,IN_OUT )") ; 
						InsertSql.append("	VALUES( ") ; 
						InsertSql.append("			?,?,?,?,") ; 
						InsertSql.append("			?,?,?,?,") ; 
						InsertSql.append("			?,?,?,?,?,") ; 
						InsertSql.append("			?,?,?,?,?,") ; 
						InsertSql.append("			? ,CURRENT_TIMESTAMP,? ,CURRENT_TIMESTAMP, ?   ") ; 
						InsertSql.append("			,?,? ) ") ; 

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows2[j]); 

						gsmt.setString(1, ord_no); 
						gsmt.setString(2, car_seq_no.trim() );
						gsmt.bindColumn(3, idx2CARTYPENO  );
						gsmt.bindColumn(4, idx2CAR_CNT    );
						gsmt.bindColumn(5, idx2LD_CARGO   );
						gsmt.bindColumn(6, idx2LD_CARGONM );
						gsmt.bindColumn(7, idx2OFF_CARGO  );
						gsmt.bindColumn(8, idx2OFF_CARGONM  );
						gsmt.bindColumn(9, idx2CUST_CD    );
						gsmt.bindColumn(10,idx2CUST_NAME  );
						gsmt.bindColumn(11,idx2CUST_PS    );
						gsmt.bindColumn(12,idx2CUST_TEL   );
						gsmt.bindColumn(13,idx2LD_DATE    );
						gsmt.bindColumn(14,idx2PERSON_NO  );
						gsmt.bindColumn(15,idx2CAR_TYPE   );
						gsmt.bindColumn(16,idx2REMARK     );
						gsmt.bindColumn(17,idx2CTN_STDRD  );
						gsmt.bindColumn(18,idx2EDT_DATE   );
						gsmt.bindColumn(19,idx2LCT_URL    );
						gsmt.bindColumn(20,idx2CREATE_USR );
						gsmt.bindColumn(21,idx2UPDATE_USR );
						gsmt.bindColumn(22,idx2LINE_PART );
						gsmt.bindColumn(23,idx2IN_OUT );
	 					gsmt.executeUpdate(); 
						gsmt.close(); 
					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDCAR \n")
								 .append("	  SET CARTYPENO = ?,	CAR_CNT			= ?, \n")
								 .append("		  LD_CARGO	= ?,	LD_CARGONM	= ?,	OFF_CARGO = ?,	OFF_CARGONM = ?, \n")
								 .append("		  CUST_CD		= ?,	CUST_NAME		= ?,	CUST_PS		= ?,	CUST_TEL		= ?,	LD_DATE		= ?, \n")
								 .append("		  PERSON_NO = ?,	CAR_TYPE		= ?,	REMARK		= ?,	CTN_STDRD		= ?,	EDT_DATE	= ?, \n")
								 .append("		  LCT_URL = ?, \n")
								 .append("		  UPDATE_DT = CURRENT_TIMESTAMP,	UPDATE_USR	= ?, \n")
								 .append("		  LINE_PART = ? , IN_OUT			= ?,	ORDER_NO	= ? \n")
								 .append(" WHERE CAR_SEQ_NO = ? ");  
		
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows2[j]);
						
						gsmt.bindColumn(1, idx2CARTYPENO  );
						gsmt.bindColumn(2, idx2CAR_CNT    );
						gsmt.bindColumn(3, idx2LD_CARGO   );
						gsmt.bindColumn(4, idx2LD_CARGONM );
						gsmt.bindColumn(5, idx2OFF_CARGO  );
						gsmt.bindColumn(6, idx2OFF_CARGONM  );
						gsmt.bindColumn(7, idx2CUST_CD    );
						gsmt.bindColumn(8, idx2CUST_NAME  );
						gsmt.bindColumn(9, idx2CUST_PS    );
						gsmt.bindColumn(10,idx2CUST_TEL   );
						gsmt.bindColumn(11,idx2LD_DATE    );
						gsmt.bindColumn(12,idx2PERSON_NO  );
						gsmt.bindColumn(13,idx2CAR_TYPE   );
						gsmt.bindColumn(14,idx2REMARK     );
						gsmt.bindColumn(15,idx2CTN_STDRD  );
						gsmt.bindColumn(16,idx2EDT_DATE   );
						gsmt.bindColumn(17,idx2LCT_URL    );
						gsmt.bindColumn(18,idx2UPDATE_USR );
						gsmt.bindColumn(19,idx2LINE_PART );
						gsmt.bindColumn(20,idx2IN_OUT );
						gsmt.setString(21, ord_no); 
						gsmt.bindColumn(22, idx2CAR_SEQ_NO );
						gsmt.executeUpdate(); 
						gsmt.close();
					}    
				}

				InsertSql = null;
				UpdateSql = null;

				for (int j = 0; j < rows3.length; j++){
					if(rows3[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSqll = new StringBuffer();
						UpdateSqll.append( " UPDATE TRANSFER.LTORDERDTL SET \n" )
								  .append( "        ETD_DT = ? \n" )
								  .append("  WHERE ORDER_NO = '"+ ord_no +"' ");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSqll.toString());
						gsmt.setGauceDataRow(rows3[j]);
							
						gsmt.bindColumn(1, idx3ETD_DT  );
						gsmt.executeUpdate(); 
						gsmt.close();

						//logger.dbg.println(this,"step6-4");
					}    
			    }

				for (int j = 0; j < rows.length; j++){
					String pltype = rows[j].getString(idxPL_TYPE);
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
 
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTORDERMST \n" )
										 .append(" (	ORDER_NO,IN_OUT,ORDER_STS,ETD_DT,LINE_PART, \n" )
										 .append("		PROJECT,CUST_CD,CUST_PRSN,CUST_TELNO, \n" )
										 .append("		CARGO_TYPE,DLVL_TYPE,DLVL_DATE,SHIPPER, \n" )
										 .append("		SHIPPERPS,SHIPPERTEL,ETA_DT,ORDER_DATE, \n" )
										 .append("		FEE_IN,FEE_OUT,GORDER_NO,RQST_NO,PL_TYPE, \n" )
										 .append("		PL_SHIPPER,PL_SHPPRNM,PL_CSTM,PL_CSTMNM,PL_BRKR, \n" )
										 .append("		PL_BRKRNM,RPST_GOODS,TOTAL_CNT,TOTAL_UNIT, \n" )
										 .append("		TOTAL_WGHT,TOTAL_CBM,CANCLE_DATE,REMARK,PRICETYPE, \n" )
										 .append("		SETTLETYPE,LC_NO,LC_DATE,LC_BANK,EXPRT_NO, \n" )
										 .append("		EXPRT_DATE , \n" )
										 .append("		LDCARGO,LDCARGONM,OFFCARGO,OFFCARGONM, \n" )
										 .append("		CREATE_USR,UPDATE_USR,CREATE_DT,UPDATE_DT,CONSIGNEE,CUST_HPNO,SHIPPERHP, \n" )
										 .append("		DIV_IO,PL_SHIPADDR,PL_SHIPTEL,PL_CSTADDR,PL_CSTTEL,PL_BRKADDR,PL_BRKTEL, \n" )
										 .append("		PL_SHPADDR2,PL_SHPADDR3,PL_CSTADDR2,PL_CSTADDR3,PL_BRKADDR2,PL_BRKADDR3, \n" )
										 .append("		PL_CSN,PL_CSNNM,PL_CSNTEL,PL_CSNADDR,PL_CSNADDR2,PL_CSNADDR3,ETD_DT1, \n" )
										 .append("		ATT_FILE, FAC_PERSON, FAC_PRSTEL, ATT_FILENM, \n" )
										 .append("		OBJ_REMK, RECIPIENT, RECP_OWN, RECP_TEL, RECP_ADD \n")
										 .append(" ) \n" )
										 .append(" values \n" )
										 .append(" (?,?,?,?,?, \n" )
										 .append(" ?,?,?,?, \n" )
										 .append(" ?,?,?,?, \n" )
										 .append(" ?,?,?,?, \n" )
										 .append(" ?,?,?,?,?, \n" )
										 .append(" ?,?,?,?,?, \n" )
										 .append(" ?,?,?,?, \n" )
										 .append(" ?,?,?,?,?, \n" )
										 .append(" ?,?,?,?,?, \n" )
										 .append(" ? , \n" )
										 .append(" ?,?,?,?, \n" )
										 .append(" ?,?,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,?,?,?, \n" )
										 .append(" ?,?,?,?,?,?,?, \n" )
										 .append(" ?,?,?,?,?,?, \n" )
										 .append(" ?,?,?,?,?,?,?, \n" )
										 .append(" ?,?,?,?, \n" )
										 .append(" ?,?,?,?,? \n" )
										 .append(" ) ");
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
						gsmt.setString(1, ord_no);
						gsmt.bindColumn(2,  idxIN_OUT  ) ; 
						gsmt.bindColumn(3,  idxORDER_STS  ) ; 
						gsmt.bindColumn(4,  idxETD_DT  ) ; 
						gsmt.bindColumn(5,  idxLINE_PART  ) ; 
						gsmt.bindColumn(6,  idxPROJECT  ) ; 
						gsmt.bindColumn(7,  idxCUST_CD  ) ; 
						gsmt.bindColumn(8,  idxCUST_PRSN  ) ; 
						gsmt.bindColumn(9,  idxCUST_TELNO  ) ; 
						gsmt.bindColumn(10, idxCARGO_TYPE  ) ; 
						gsmt.bindColumn(11, idxDLVL_TYPE  ) ; 
						gsmt.bindColumn(12, idxDLVL_DATE  ) ; 
						gsmt.bindColumn(13, idxSHIPPER  ) ; 
						gsmt.bindColumn(14, idxSHIPPERPS  ) ; 
						gsmt.bindColumn(15, idxSHIPPERTEL  ) ; 
						gsmt.bindColumn(16, idxETA_DT  ) ; 
						gsmt.bindColumn(17, idxORDER_DATE  ) ; 
						gsmt.bindColumn(18, idxFEE_IN  ) ; 
						gsmt.bindColumn(19, idxFEE_OUT  ) ; 
						gsmt.bindColumn(20, idxGORDER_NO  ) ; 
						gsmt.bindColumn(21, idxRQST_NO  ) ; 
						gsmt.bindColumn(22, idxPL_TYPE  ) ; 
						gsmt.bindColumn(23, idxPL_SHIPPER  ) ; 
						gsmt.bindColumn(24, idxPL_SHPPRNM  ) ; 
						gsmt.bindColumn(25, idxPL_CSTM  ) ; 
						gsmt.bindColumn(26, idxPL_CSTMNM  ) ; 
						gsmt.bindColumn(27, idxPL_BRKR  ) ; 
						gsmt.bindColumn(28, idxPL_BRKRNM  ) ; 
						gsmt.bindColumn(29, idxRPST_GOODS  ) ; 
						gsmt.bindColumn(30, idxTOTAL_CNT  ) ; 
						gsmt.bindColumn(31, idxTOTAL_UNIT  ) ; 
						gsmt.bindColumn(32, idxTOTAL_WGHT  ) ; 
						gsmt.bindColumn(33, idxTOTAL_CBM  ) ; 
						gsmt.bindColumn(34, idxCANCLE_DATE  ) ; 
						gsmt.bindColumn(35, idxREMARK  ) ; 
						gsmt.bindColumn(36, idxPRICETYPE  ) ; 
						gsmt.bindColumn(37, idxSETTLETYPE  ) ; 
						gsmt.bindColumn(38, idxLC_NO  ) ; 
						gsmt.bindColumn(39, idxLC_DATE  ) ; 
						gsmt.bindColumn(40, idxLC_BANK  ) ; 
						gsmt.bindColumn(41, idxEXPRT_NO  ) ; 
						gsmt.bindColumn(42, idxEXPRT_DATE   ) ; 
						gsmt.bindColumn(43, idxLDCARGO  ) ; 
						gsmt.bindColumn(44, idxLDCARGONM ) ;  
						gsmt.bindColumn(45, idxOFFCARGO  ) ; 
						gsmt.bindColumn(46, idxOFFCARGONM ) ;  
						gsmt.bindColumn(47, idxCREATE_USR  ) ; 
						gsmt.bindColumn(48, idxUPDATE_USR ) ;  
						gsmt.bindColumn(49, idxCONSIGNEE ) ;
						gsmt.bindColumn(50, idxCUST_HPNO ) ;  
						gsmt.bindColumn(51, idxSHIPPERHP ) ;
						gsmt.bindColumn(52, idxDIV_IO ) ;  
						gsmt.bindColumn(53, idxPL_SHIPADDR  ) ; 
						gsmt.bindColumn(54, idxPL_SHIPTEL ) ;  
						gsmt.bindColumn(55, idxPL_CSTADDR ) ;
						gsmt.bindColumn(56, idxPL_CSTTEL ) ;  
						gsmt.bindColumn(57, idxPL_BRKADDR ) ;
						gsmt.bindColumn(58, idxPL_BRKTEL ) ; 
						gsmt.bindColumn(59, idxPL_SHPADDR2  ) ; 
						gsmt.bindColumn(60, idxPL_SHPADDR3 ) ;  
						gsmt.bindColumn(61, idxPL_CSTADDR2 ) ;
						gsmt.bindColumn(62, idxPL_CSTADDR3 ) ;  
						gsmt.bindColumn(63, idxPL_BRKADDR2 ) ;
						gsmt.bindColumn(64, idxPL_BRKADDR3 ) ;
						gsmt.bindColumn(65, idxPL_CSN ) ;  
						gsmt.bindColumn(66, idxPL_CSNNM ) ;
						gsmt.bindColumn(67, idxPL_CSNTEL ) ;  
						gsmt.bindColumn(68, idxPL_CSNADDR ) ;
						gsmt.bindColumn(69, idxPL_CSNADDR2 ) ;
						gsmt.bindColumn(70, idxPL_CSNADDR3 ) ; 
						gsmt.bindColumn(71,	idxETD_DT1) ; 

						InputStream nst_file = (InputStream) rows[j].getInputStream(idxATT_FILE);
						gsmt.setBinaryStream(72, nst_file, nst_file.available() );	 //첨부파일

						gsmt.bindColumn(73, idxFAC_PERSON ) ; 
						gsmt.bindColumn(74, idxFAC_PRSTEL ) ; 
						gsmt.bindColumn(75, idxATT_FILENM ) ; 
						gsmt.bindColumn(76, idxOBJ_REMK ) ;
						gsmt.bindColumn(77, idxRECIPIENT ) ;
						gsmt.bindColumn(78, idxRECP_OWN ) ;
						gsmt.bindColumn(79, idxRECP_TEL ) ;
						gsmt.bindColumn(80, idxRECP_ADD ) ;

	 					gsmt.executeUpdate(); 
						gsmt.close(); 

						if (pltype.equals("Y"))	{
							
						    //2013.11.04
							//RPG를 변경하기. == > 프로시저 만들기 
							String	query = "CALL TRANSFER.SP_BDPLCI1 (?)" ;  
							cstmt = conn.prepareCall(query);
							cstmt.setString(1, ord_no ); 
							cstmt.execute();
							cstmt.close();
						
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDERMST SET \n")
								 .append("		IN_OUT = ? , \n")
								 .append("		ORDER_STS = ? , ETD_DT = ? , \n")
								 .append("		LINE_PART = ? , PROJECT = ? ,CUST_CD = ? , \n")
								 .append("		CUST_PRSN = ? ,CUST_TELNO = ? , \n")
								 .append("		CARGO_TYPE = ? ,DLVL_TYPE = ? , \n")
								 .append("		DLVL_DATE = ? ,SHIPPER = ? , \n")
								 .append("		SHIPPERPS = ? ,SHIPPERTEL = ? , \n")
								 .append("		ETA_DT = ? ,ORDER_DATE = ? , \n")
								 .append("		FEE_IN = ? ,FEE_OUT = ? , \n")
								 .append("		GORDER_NO = ? ,RQST_NO = ? ,PL_TYPE = ? , \n")
								 .append("		PL_SHIPPER = ? ,PL_SHPPRNM = ? , \n")
								 .append("		PL_CSTM = ? ,PL_CSTMNM = ? ,PL_BRKR = ? , \n")
								 .append("		PL_BRKRNM = ? ,RPST_GOODS = ? , \n")
								 .append("		TOTAL_CNT = ? ,TOTAL_UNIT = ? , \n")
								 .append("		TOTAL_WGHT = ? ,TOTAL_CBM = ? ,CANCLE_DATE = ? ,REMARK = ? ,PRICETYPE = ? , \n")
								 .append("		SETTLETYPE = ? ,LC_NO = ? ,LC_DATE = ? ,LC_BANK = ? ,EXPRT_NO = ? , \n")
								 .append("		EXPRT_DATE  = ? ,   LDCARGO = ? ,LDCARGONM = ? ,OFFCARGO = ? ,OFFCARGONM = ? , \n")
								 .append("		UPDATE_USR = ? , UPDATE_DT  = CURRENT_TIMESTAMP, CONSIGNEE = ? ,CUST_HPNO = ?,SHIPPERHP = ?, \n")
								 .append("		DIV_IO=?,PL_SHIPADDR=?,PL_SHIPTEL=?,PL_CSTADDR=?,PL_CSTTEL=?,PL_BRKADDR=?,PL_BRKTEL =?, \n")
								 .append("		PL_SHPADDR2=?,PL_SHPADDR3=?,PL_CSTADDR2=?,PL_CSTADDR3=?,PL_BRKADDR2=?,PL_BRKADDR3=?, \n")
								 .append("		PL_CSN = ?,PL_CSNNM = ?,PL_CSNTEL = ?,PL_CSNADDR = ?,PL_CSNADDR2 = ?,PL_CSNADDR3 = ?, \n")
								 .append("		ETD_DT1 = ?, FAC_PERSON =?, FAC_PRSTEL = ?, ATT_FILENM = ?, \n")
								 .append("		OBJ_REMK = ?, RECIPIENT =?, RECP_OWN = ?, RECP_TEL = ?, RECP_ADD = ? \n")
								 .append(" WHERE  ORDER_NO  = ? ") ; 
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
 						gsmt.bindColumn(1,  idxIN_OUT  ) ; 
						gsmt.bindColumn(2,  idxORDER_STS  ) ; 
						gsmt.bindColumn(3,  idxETD_DT  ) ; 
						gsmt.bindColumn(4,  idxLINE_PART  ) ; 
						gsmt.bindColumn(5,  idxPROJECT  ) ; 
						gsmt.bindColumn(6,  idxCUST_CD  ) ; 
						gsmt.bindColumn(7,  idxCUST_PRSN  ) ; 
						gsmt.bindColumn(8,  idxCUST_TELNO  ) ; 
						gsmt.bindColumn(9, idxCARGO_TYPE  ) ; 
						gsmt.bindColumn(10, idxDLVL_TYPE  ) ; 
						gsmt.bindColumn(11, idxDLVL_DATE  ) ; 
						gsmt.bindColumn(12, idxSHIPPER  ) ; 
						gsmt.bindColumn(13, idxSHIPPERPS  ) ; 
						gsmt.bindColumn(14, idxSHIPPERTEL  ) ; 
						gsmt.bindColumn(15, idxETA_DT  ) ; 
						gsmt.bindColumn(16, idxORDER_DATE  ) ; 
						gsmt.bindColumn(17, idxFEE_IN  ) ; 
						gsmt.bindColumn(18, idxFEE_OUT  ) ; 
						gsmt.bindColumn(19, idxGORDER_NO  ) ; 
						gsmt.bindColumn(20, idxRQST_NO  ) ; 
						gsmt.bindColumn(21, idxPL_TYPE  ) ; 
						gsmt.bindColumn(22, idxPL_SHIPPER  ) ; 
						gsmt.bindColumn(23, idxPL_SHPPRNM  ) ; 
						gsmt.bindColumn(24, idxPL_CSTM  ) ; 
						gsmt.bindColumn(25, idxPL_CSTMNM  ) ; 
						gsmt.bindColumn(26, idxPL_BRKR  ) ; 
						gsmt.bindColumn(27, idxPL_BRKRNM  ) ; 
						gsmt.bindColumn(28, idxRPST_GOODS  ) ; 
						gsmt.bindColumn(29, idxTOTAL_CNT  ) ; 
						gsmt.bindColumn(30, idxTOTAL_UNIT  ) ; 
						gsmt.bindColumn(31, idxTOTAL_WGHT  ) ; 
						gsmt.bindColumn(32, idxTOTAL_CBM  ) ; 
						gsmt.bindColumn(33, idxCANCLE_DATE  ) ; 
						gsmt.bindColumn(34, idxREMARK  ) ; 
						gsmt.bindColumn(35, idxPRICETYPE  ) ; 
						gsmt.bindColumn(36, idxSETTLETYPE  ) ; 
						gsmt.bindColumn(37, idxLC_NO  ) ; 
						gsmt.bindColumn(38, idxLC_DATE  ) ; 
						gsmt.bindColumn(39, idxLC_BANK  ) ; 
						gsmt.bindColumn(40, idxEXPRT_NO  ) ; 
						gsmt.bindColumn(41, idxEXPRT_DATE   ) ; 
						gsmt.bindColumn(42, idxLDCARGO  ) ; 
						gsmt.bindColumn(43, idxLDCARGONM ) ;  
						gsmt.bindColumn(44, idxOFFCARGO  ) ; 
						gsmt.bindColumn(45, idxOFFCARGONM ) ;  
						gsmt.bindColumn(46, idxUPDATE_USR ) ;
						gsmt.bindColumn(47, idxCONSIGNEE ) ;
						gsmt.bindColumn(48, idxCUST_HPNO ) ;  
						gsmt.bindColumn(49, idxSHIPPERHP ) ;
						gsmt.bindColumn(50, idxDIV_IO ) ;  
						gsmt.bindColumn(51, idxPL_SHIPADDR  ) ; 
						gsmt.bindColumn(52, idxPL_SHIPTEL ) ;  
						gsmt.bindColumn(53, idxPL_CSTADDR ) ;
						gsmt.bindColumn(54, idxPL_CSTTEL ) ;  
						gsmt.bindColumn(55, idxPL_BRKADDR ) ;
						gsmt.bindColumn(56, idxPL_BRKTEL ) ;
						gsmt.bindColumn(57, idxPL_SHPADDR2  ) ; 
						gsmt.bindColumn(58, idxPL_SHPADDR3 ) ;  
						gsmt.bindColumn(59, idxPL_CSTADDR2 ) ;
						gsmt.bindColumn(60, idxPL_CSTADDR3 ) ;  
						gsmt.bindColumn(61, idxPL_BRKADDR2 ) ;
						gsmt.bindColumn(62, idxPL_BRKADDR3 ) ;
						gsmt.bindColumn(63, idxPL_CSN ) ;  
						gsmt.bindColumn(64, idxPL_CSNNM ) ;
						gsmt.bindColumn(65, idxPL_CSNTEL ) ;  
						gsmt.bindColumn(66, idxPL_CSNADDR ) ;
						gsmt.bindColumn(67, idxPL_CSNADDR2 ) ;
						gsmt.bindColumn(68, idxPL_CSNADDR3 ) ; 
						gsmt.bindColumn(69, idxETD_DT1 ) ; 
						gsmt.bindColumn(70, idxFAC_PERSON ) ; 
						gsmt.bindColumn(71, idxFAC_PRSTEL ) ; 
						gsmt.bindColumn(72, idxATT_FILENM ) ; 
						gsmt.bindColumn(73, idxOBJ_REMK ) ;
						gsmt.bindColumn(74, idxRECIPIENT ) ;
						gsmt.bindColumn(75, idxRECP_OWN ) ;
						gsmt.bindColumn(76, idxRECP_TEL ) ;
						gsmt.bindColumn(77, idxRECP_ADD ) ;
						gsmt.setString(78, ord_no);
						gsmt.executeUpdate(); 
 
						UpdateSql = null;
						gsmt.close();
					//if (ord_sts!=null && ord_sts.equals("03")){
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDCAR \n")
								 .append("    SET EDT_DATE = '" + rows[j].getString(idxETD_DT) + "' \n")
								 .append("  WHERE ORDER_NO = '"+ ord_no +"' ");
						//logger.dbg.println(this,"UpdateSql::"+UpdateSql.toString());
						GauceStatement gstmt = conn.getGauceStatement(UpdateSql.toString());
						gstmt.executeUpdate();
						gstmt.close();
				//	}

				    //혼재에서 반출일자만 변경될때 반영 하기 위한 것. 2008.09.04 정영식//////////////////////
						UpdateSql = null;
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDERDTL \n")
								 .append("    SET ETD_DT = '" + rows[j].getString(idxETD_DT) + "' \n")
								 .append("  WHERE ORDER_NO = '"+ ord_no +"' ");
						//logger.dbg.println(this,"UpdateSql::"+UpdateSql.toString());
						gstmt = conn.getGauceStatement(UpdateSql.toString());
						gstmt.executeUpdate();
						gstmt.close();
						////////////////////////////////////////////////////////////////////////////////////////
						
						if (pltype.equals("Y"))	{
							String	query = "CALL TRANSFER.SP_BDPLCI1 (?)" ; 
							cstmt = conn.prepareCall(query);
							cstmt.setString(1, ord_no );
						
							cstmt.execute();
							cstmt.close();
						
						}

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
                        DeleteSql.append(" DELETE FROM TRANSFER.LTORDERMST " )
								 .append("	WHERE ORDER_NO = '" + ord_no + "' " );



						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.executeUpdate();
						gsmt.close();

					}
				}

			
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				//logger.err.println(this,se);
				 logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
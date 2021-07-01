package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trMaster_t01 extends HttpServlet{

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

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String order_no = reqGauce.getParameter("v_str1"); 

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet  = reqGauce.getGauceDataSet("MASTER");
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("DETAIL");
				
				int idxETD_DT       = userSet.indexOfColumn("ETD_DT");
				int idxLINE_PART    = userSet.indexOfColumn("LINE_PART");
				int idxPROJECT      = userSet.indexOfColumn("PROJECT");
				int idxCUST_CD      = userSet.indexOfColumn("CUST_CD");
				int idxCUST_PRSN    = userSet.indexOfColumn("CUST_PRSN");
				int idxCUST_TELNO   = userSet.indexOfColumn("CUST_TELNO");
				int idxCUST_HPNO    = userSet.indexOfColumn("CUST_HPNO");
				int idxSHIPPERHP    = userSet.indexOfColumn("SHIPPERHP");
				int idxSHIPPER      = userSet.indexOfColumn("SHIPPER");
				int idxSHIPPERPS    = userSet.indexOfColumn("SHIPPERPS");
				int idxSHIPPERTEL   = userSet.indexOfColumn("SHIPPERTEL");
				int idxPL_SHIPPER   = userSet.indexOfColumn("PL_SHIPPER");
				int idxPL_SHPPRNM   = userSet.indexOfColumn("PL_SHPPRNM");
				int idxPL_SHIPADDR  = userSet.indexOfColumn("PL_SHIPADDR");
				int idxPL_SHIPTEL   = userSet.indexOfColumn("PL_SHIPTEL");
				int idxPL_CSTM      = userSet.indexOfColumn("PL_CSTM");
				int idxPL_CSTMNM    = userSet.indexOfColumn("PL_CSTMNM");
				int idxPL_CSTADDR   = userSet.indexOfColumn("PL_CSTADDR");
				int idxPL_CSTTEL    = userSet.indexOfColumn("PL_CSTTEL");
				int idxPL_BRKR      = userSet.indexOfColumn("PL_BRKR");
				int idxPL_BRKRNM    = userSet.indexOfColumn("PL_BRKRNM");
				int idxPL_BRKADDR   = userSet.indexOfColumn("PL_BRKADDR");
				int idxPL_BRKTEL    = userSet.indexOfColumn("PL_BRKTEL");
				int idxRPST_GOODS   = userSet.indexOfColumn("RPST_GOODS");
				int idxREMARK       = userSet.indexOfColumn("REMARK");
				int idxPL_SHPADDR2  = userSet.indexOfColumn("PL_SHPADDR2");
				int idxPL_SHPADDR3  = userSet.indexOfColumn("PL_SHPADDR3");
				int idxPL_CSTADDR2  = userSet.indexOfColumn("PL_CSTADDR2");
				int idxPL_CSTADDR3  = userSet.indexOfColumn("PL_CSTADDR3");
				int idxPL_BRKADDR2  = userSet.indexOfColumn("PL_BRKADDR2");
				int idxPL_BRKADDR3  = userSet.indexOfColumn("PL_BRKADDR3");
				int idxPL_CSN       = userSet.indexOfColumn("PL_CSN");
				int idxPL_CSNNM     = userSet.indexOfColumn("PL_CSNNM");
				int idxPL_CSNTEL    = userSet.indexOfColumn("PL_CSNTEL");
				int idxPL_CSNADDR   = userSet.indexOfColumn("PL_CSNADDR");
				int idxPL_CSNADDR2  = userSet.indexOfColumn("PL_CSNADDR2");
				int idxPL_CSNADDR3  = userSet.indexOfColumn("PL_CSNADDR3");
				int idxOBJ_REMK     = userSet.indexOfColumn("OBJ_REMK");
				int idxCREATE_USR   = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_USR   = userSet.indexOfColumn("UPDATE_USR");
				int idxIN_OUT				= userSet.indexOfColumn("IN_OUT");
				int idxORDER_STS		= userSet.indexOfColumn("ORDER_STS");
				int idxDIV_IO				= userSet.indexOfColumn("DIV_IO");
				int idxORDER_NO			= userSet.indexOfColumn("ORDER_NO");

				int idx2ORDER_NO    = userSet2.indexOfColumn("ORDER_NO");
				int idx2ORDER_SEQ   = userSet2.indexOfColumn("ORDER_SEQ");
				int idx2ARTC_CD     = userSet2.indexOfColumn("ARTC_CD");
				int idx2ARTC_NM     = userSet2.indexOfColumn("ARTC_NM");
				int idx2STN_SZ      = userSet2.indexOfColumn("STN_SZ");
				int idx2STN_SZNM    = userSet2.indexOfColumn("STN_SZNM");
				int idx2HSCODE      = userSet2.indexOfColumn("HSCODE");
				int idx2ARTC_CNT    = userSet2.indexOfColumn("ARTC_CNT");
				int idx2ARTC_UNIT   = userSet2.indexOfColumn("ARTC_UNIT");
				int idx2UNIT_PRICE  = userSet2.indexOfColumn("UNIT_PRICE");
				int idx2PRICE       = userSet2.indexOfColumn("PRICE");
				int idx2LDCARGO     = userSet2.indexOfColumn("LDCARGO");
				int idx2LDCARGONM   = userSet2.indexOfColumn("LDCARGONM");
				int idx2OFFCARGO    = userSet2.indexOfColumn("OFFCARGO");
				int idx2OFFCARGONM  = userSet2.indexOfColumn("OFFCARGONM");
				int idx2PUNIT_CNT   = userSet2.indexOfColumn("PUNIT_CNT");
				int idx2PUNIT_UNIT  = userSet2.indexOfColumn("PUNIT_UNIT");
				int idx2PUNIT_WGHT  = userSet2.indexOfColumn("PUNIT_WGHT");
				int idx2PKG_LNGTH   = userSet2.indexOfColumn("PKG_LNGTH");
				int idx2PKG_HEIGHT  = userSet2.indexOfColumn("PKG_HEIGHT");
				int idx2PKG_WIDTH   = userSet2.indexOfColumn("PKG_WIDTH");
				int idx2PKG_CBM     = userSet2.indexOfColumn("PKG_CBM");
				int idx2PKG_CNT     = userSet2.indexOfColumn("PKG_CNT");
				int idx2MIX_OTHERS  = userSet2.indexOfColumn("MIX_OTHERS");
				int idx2SAMEAS      = userSet2.indexOfColumn("SAMEAS");
				int idx2CANCLE_STS  = userSet2.indexOfColumn("CANCLE_STS");
				int idx2CANCLE_DT   = userSet2.indexOfColumn("CANCLE_DT");
				int idx2AUTH_NO     = userSet2.indexOfColumn("AUTH_NO");
				int idx2ORDER_STS   = userSet2.indexOfColumn("ORDER_STS");
				int idx2SETTLE_STS  = userSet2.indexOfColumn("SETTLE_STS");
				int idx2REGFILENAME = userSet2.indexOfColumn("REGFILENAME");
				int idx2CREATE_DT   = userSet2.indexOfColumn("CREATE_DT");
				int idx2CREATE_USR  = userSet2.indexOfColumn("CREATE_USR");
				int idx2UPDATE_DT   = userSet2.indexOfColumn("UPDATE_DT");
				int idx2UPDATE_USR  = userSet2.indexOfColumn("UPDATE_USR");
				int idx2CUR_CODE    = userSet2.indexOfColumn("CUR_CODE");
				int idx2VIN_CODE    = userSet2.indexOfColumn("VIN_CODE");
				int idx2FR_UNTPRCE  = userSet2.indexOfColumn("FR_UNTPRCE");
				int idx2FR_PRICE    = userSet2.indexOfColumn("FR_PRICE");
				int idx2ENG_ARTCNM  = userSet2.indexOfColumn("ENG_ARTCNM");
				int idx2EDI_STS     = userSet2.indexOfColumn("EDI_STS");
				int idx2CAR_NO      = userSet2.indexOfColumn("CAR_NO");
				int idx2CARTYPENO   = userSet2.indexOfColumn("CARTYPENO");
				int idx2CAR_WGHT    = userSet2.indexOfColumn("CAR_WGHT");

				GauceDataRow[] rows = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  

				//주문등록
				for (int j = 0; j < rows.length; j++){
					InsertSql = null;
					UpdateSql = null;
					DeleteSql = null;  

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
 
						InsertSql = new StringBuffer();
            InsertSql.append(" INSERT INTO TRANSFER.JTORDERMST ( \n")
										 .append("		ETD_DT,LINE_PART,PROJECT,CUST_CD,CUST_PRSN, \n")
										 .append("		CUST_TELNO,CUST_HPNO,SHIPPERHP,SHIPPER,SHIPPERPS, \n")
										 .append("		SHIPPERTEL,PL_SHIPPER,PL_SHPPRNM,PL_SHIPADDR,PL_SHIPTEL, \n")
										 .append("		PL_CSTM,PL_CSTMNM,PL_CSTADDR,PL_CSTTEL,PL_BRKR, \n")
										 .append("		PL_BRKRNM,PL_BRKADDR,PL_BRKTEL,RPST_GOODS,REMARK, \n")
										 .append("		PL_SHPADDR2,PL_SHPADDR3,PL_CSTADDR2,PL_CSTADDR3,PL_BRKADDR2, \n")
										 .append("		PL_BRKADDR3,PL_CSN,PL_CSNNM,PL_CSNTEL,PL_CSNADDR, \n")
										 .append("		PL_CSNADDR2,PL_CSNADDR3,OBJ_REMK,CREATE_USR,CREATE_DT, \n")
										 .append("		IN_OUT,ORDER_STS,DIV_IO,ORDER_NO \n")
										 .append(" ) values( \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?, CURRENT TIMESTAMP, ")
										 .append("		?,?,?,'" + order_no + "' ")
										 .append(" ) \n");
												
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]);  
 						
						gsmt.bindColumn(1,idxETD_DT);
						gsmt.bindColumn(2,idxLINE_PART);
						gsmt.bindColumn(3,idxPROJECT);
						gsmt.bindColumn(4,idxCUST_CD);
						gsmt.bindColumn(5,idxCUST_PRSN);
						gsmt.bindColumn(6,idxCUST_TELNO);
						gsmt.bindColumn(7,idxCUST_HPNO);
						gsmt.bindColumn(8,idxSHIPPERHP);
						gsmt.bindColumn(9,idxSHIPPER);
						gsmt.bindColumn(10,idxSHIPPERPS);
						gsmt.bindColumn(11,idxSHIPPERTEL);
						gsmt.bindColumn(12,idxPL_SHIPPER);
						gsmt.bindColumn(13,idxPL_SHPPRNM);
						gsmt.bindColumn(14,idxPL_SHIPADDR);
						gsmt.bindColumn(15,idxPL_SHIPTEL);
						gsmt.bindColumn(16,idxPL_CSTM);
						gsmt.bindColumn(17,idxPL_CSTMNM);
						gsmt.bindColumn(18,idxPL_CSTADDR);
						gsmt.bindColumn(19,idxPL_CSTTEL);
						gsmt.bindColumn(20,idxPL_BRKR);
						gsmt.bindColumn(21,idxPL_BRKRNM);
						gsmt.bindColumn(22,idxPL_BRKADDR);
						gsmt.bindColumn(23,idxPL_BRKTEL);
						gsmt.bindColumn(24,idxRPST_GOODS);
						gsmt.bindColumn(25,idxREMARK);
						gsmt.bindColumn(26,idxPL_SHPADDR2);
						gsmt.bindColumn(27,idxPL_SHPADDR3);
						gsmt.bindColumn(28,idxPL_CSTADDR2);
						gsmt.bindColumn(29,idxPL_CSTADDR3);
						gsmt.bindColumn(30,idxPL_BRKADDR2);
						gsmt.bindColumn(31,idxPL_BRKADDR3);
						gsmt.bindColumn(32,idxPL_CSN);
						gsmt.bindColumn(33,idxPL_CSNNM);
						gsmt.bindColumn(34,idxPL_CSNTEL);
						gsmt.bindColumn(35,idxPL_CSNADDR);
						gsmt.bindColumn(36,idxPL_CSNADDR2);
						gsmt.bindColumn(37,idxPL_CSNADDR3);
						gsmt.bindColumn(38,idxOBJ_REMK);
						gsmt.bindColumn(39,idxCREATE_USR);
						gsmt.bindColumn(40,idxIN_OUT);
						gsmt.bindColumn(41,idxORDER_STS);
						gsmt.bindColumn(42,idxDIV_IO);

	 					gsmt.executeUpdate(); 
						gsmt.close(); 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.JTORDERMST SET \n")
										 .append("		ETD_DT = ?,LINE_PART = ?,PROJECT = ?,CUST_CD = ?,CUST_PRSN = ?, \n")
										 .append("		CUST_TELNO = ?,CUST_HPNO = ?,SHIPPERHP = ?,SHIPPER = ?,SHIPPERPS = ?, \n")
										 .append("		SHIPPERTEL = ?,PL_SHIPPER = ?,PL_SHPPRNM = ?,PL_SHIPADDR = ?,PL_SHIPTEL = ?, \n")
										 .append("		PL_CSTM = ?,PL_CSTMNM = ?,PL_CSTADDR = ?,PL_CSTTEL = ?,PL_BRKR = ?, \n")
										 .append("		PL_BRKRNM = ?,PL_BRKADDR = ?,PL_BRKTEL = ?,RPST_GOODS = ?,REMARK = ?, \n")
										 .append("		PL_SHPADDR2 = ?,PL_SHPADDR3 = ?,PL_CSTADDR2 = ?,PL_CSTADDR3 = ?,PL_BRKADDR2 = ?, \n")
										 .append("		PL_BRKADDR3 = ?,PL_CSN = ?,PL_CSNNM = ?,PL_CSNTEL = ?,PL_CSNADDR = ?, \n")
										 .append("		PL_CSNADDR2 = ?,PL_CSNADDR3 = ?,OBJ_REMK = ?,UPDATE_USR = ?,UPDATE_DT = CURRENT TIMESTAMP, \n")
										 .append("		IN_OUT = ?,ORDER_STS = ?,DIV_IO = ? \n")
										 .append(" WHERE ORDER_NO = ? ");
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 
					
						gsmt.bindColumn(1,idxETD_DT);
						gsmt.bindColumn(2,idxLINE_PART);
						gsmt.bindColumn(3,idxPROJECT);
						gsmt.bindColumn(4,idxCUST_CD);
						gsmt.bindColumn(5,idxCUST_PRSN);
						gsmt.bindColumn(6,idxCUST_TELNO);
						gsmt.bindColumn(7,idxCUST_HPNO);
						gsmt.bindColumn(8,idxSHIPPERHP);
						gsmt.bindColumn(9,idxSHIPPER);
						gsmt.bindColumn(10,idxSHIPPERPS);
						gsmt.bindColumn(11,idxSHIPPERTEL);
						gsmt.bindColumn(12,idxPL_SHIPPER);
						gsmt.bindColumn(13,idxPL_SHPPRNM);
						gsmt.bindColumn(14,idxPL_SHIPADDR);
						gsmt.bindColumn(15,idxPL_SHIPTEL);
						gsmt.bindColumn(16,idxPL_CSTM);
						gsmt.bindColumn(17,idxPL_CSTMNM);
						gsmt.bindColumn(18,idxPL_CSTADDR);
						gsmt.bindColumn(19,idxPL_CSTTEL);
						gsmt.bindColumn(20,idxPL_BRKR);
						gsmt.bindColumn(21,idxPL_BRKRNM);
						gsmt.bindColumn(22,idxPL_BRKADDR);
						gsmt.bindColumn(23,idxPL_BRKTEL);
						gsmt.bindColumn(24,idxRPST_GOODS);
						gsmt.bindColumn(25,idxREMARK);
						gsmt.bindColumn(26,idxPL_SHPADDR2);
						gsmt.bindColumn(27,idxPL_SHPADDR3);
						gsmt.bindColumn(28,idxPL_CSTADDR2);
						gsmt.bindColumn(29,idxPL_CSTADDR3);
						gsmt.bindColumn(30,idxPL_BRKADDR2);
						gsmt.bindColumn(31,idxPL_BRKADDR3);
						gsmt.bindColumn(32,idxPL_CSN);
						gsmt.bindColumn(33,idxPL_CSNNM);
						gsmt.bindColumn(34,idxPL_CSNTEL);
						gsmt.bindColumn(35,idxPL_CSNADDR);
						gsmt.bindColumn(36,idxPL_CSNADDR2);
						gsmt.bindColumn(37,idxPL_CSNADDR3);
						gsmt.bindColumn(38,idxOBJ_REMK);
						gsmt.bindColumn(39,idxUPDATE_USR);
						gsmt.bindColumn(40,idxIN_OUT);
						gsmt.bindColumn(41,idxORDER_STS);
						gsmt.bindColumn(42,idxDIV_IO);
						gsmt.bindColumn(43,idxORDER_NO);

						gsmt.executeUpdate(); 
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						DeleteSql = new StringBuffer();
						DeleteSql.append(" DELETE FROM  TRANSFER.JTORDERMST \n")
										 .append(" WHERE ORDER_NO = ?  ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxORDER_NO);

						gsmt.executeUpdate();
						gsmt.close();
					}
				}

				//물품상세
				for (int j = 0; j < rows2.length; j++){
					InsertSql = null;
					UpdateSql = null;
					DeleteSql = null;  

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
						InsertSql = new StringBuffer();
            InsertSql.append(" INSERT INTO TRANSFER.JTORDERDTL ( \n")
										 .append("		ORDER_NO, ORDER_SEQ, ARTC_CD, ARTC_NM, STN_SZ, \n")
										 .append("		STN_SZNM, HSCODE, ARTC_CNT, ARTC_UNIT, UNIT_PRICE, \n")
										 .append("		PRICE, LDCARGO, LDCARGONM, OFFCARGO, OFFCARGONM, \n")
										 .append("		PUNIT_CNT, PUNIT_UNIT, PUNIT_WGHT, PKG_LNGTH, PKG_HEIGHT, \n")
										 .append("		PKG_WIDTH, PKG_CBM, PKG_CNT, MIX_OTHERS, SAMEAS, \n")
										 .append("		CANCLE_STS, AUTH_NO, ORDER_STS, SETTLE_STS, \n")
										 .append("		REGFILENAME, CREATE_DT, CREATE_USR, CUR_CODE, VIN_CODE, \n")
										 .append("		FR_UNTPRCE, FR_PRICE, ENG_ARTCNM, EDI_STS, CAR_NO, \n")
										 .append("		CARTYPENO, CAR_WGHT \n")
										 .append(" ) values( \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?, \n")
										 .append("		?,CURRENT TIMESTAMP,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,? \n")
										 .append(" ) ");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows2[j]);  

						gsmt.setString(1,order_no );
						gsmt.bindColumn(2,idx2ORDER_SEQ   );
						gsmt.bindColumn(3,idx2ARTC_CD     );
						gsmt.bindColumn(4,idx2ARTC_NM     );
						gsmt.bindColumn(5,idx2STN_SZ      );
						gsmt.bindColumn(6,idx2STN_SZNM    );
						gsmt.bindColumn(7,idx2HSCODE      );
						gsmt.bindColumn(8,idx2ARTC_CNT    );
						gsmt.bindColumn(9,idx2ARTC_UNIT   );
						gsmt.bindColumn(10,idx2UNIT_PRICE  );
						gsmt.bindColumn(11,idx2PRICE       );
						gsmt.bindColumn(12,idx2LDCARGO     );
						gsmt.bindColumn(13,idx2LDCARGONM   );
						gsmt.bindColumn(14,idx2OFFCARGO    );
						gsmt.bindColumn(15,idx2OFFCARGONM  );
						gsmt.bindColumn(16,idx2PUNIT_CNT   );
						gsmt.bindColumn(17,idx2PUNIT_UNIT  );
						gsmt.bindColumn(18,idx2PUNIT_WGHT  );
						gsmt.bindColumn(19,idx2PKG_LNGTH   );
						gsmt.bindColumn(20,idx2PKG_HEIGHT  );
						gsmt.bindColumn(21,idx2PKG_WIDTH   );
						gsmt.bindColumn(22,idx2PKG_CBM     );
						gsmt.bindColumn(23,idx2PKG_CNT     );
						gsmt.bindColumn(24,idx2MIX_OTHERS  );
						gsmt.bindColumn(25,idx2SAMEAS      );
						gsmt.bindColumn(26,idx2CANCLE_STS  );
						gsmt.bindColumn(27,idx2AUTH_NO     );
						gsmt.bindColumn(28,idx2ORDER_STS   );
						gsmt.bindColumn(29,idx2SETTLE_STS  );
						gsmt.bindColumn(30,idx2REGFILENAME );
						gsmt.bindColumn(31,idx2CREATE_USR  );
						gsmt.bindColumn(32,idx2CUR_CODE    );
						gsmt.bindColumn(33,idx2VIN_CODE    );
						gsmt.bindColumn(34,idx2FR_UNTPRCE  );
						gsmt.bindColumn(35,idx2FR_PRICE    );
						gsmt.bindColumn(36,idx2ENG_ARTCNM  );
						gsmt.bindColumn(37,idx2EDI_STS     );
						gsmt.bindColumn(38,idx2CAR_NO      );
						gsmt.bindColumn(39,idx2CARTYPENO   );
						gsmt.bindColumn(40,idx2CAR_WGHT    );

	 					gsmt.executeUpdate(); 
						gsmt.close(); 

					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();
            UpdateSql.append(" UPDATE TRANSFER.JTORDERDTL SET \n")
										 .append("		ARTC_CD = ?,ARTC_NM = ?,STN_SZ = ?,STN_SZNM = ?,HSCODE = ?, \n")
										 .append("		ARTC_CNT = ?,ARTC_UNIT = ?,UNIT_PRICE = ?,PRICE = ?,LDCARGO = ?, \n")
										 .append("		LDCARGONM = ?,OFFCARGO = ?,OFFCARGONM = ?,PUNIT_CNT = ?,PUNIT_UNIT = ?, \n")
										 .append("		PUNIT_WGHT = ?,PKG_LNGTH = ?,PKG_HEIGHT = ?,PKG_WIDTH = ?,PKG_CBM = ?, \n")
										 .append("		PKG_CNT = ?,MIX_OTHERS = ?,SAMEAS = ?,CANCLE_STS = ?,AUTH_NO = ?, \n")
										 .append("		ORDER_STS = ?,SETTLE_STS = ?,REGFILENAME = ?,UPDATE_USR = ?,CUR_CODE = ?, \n")
										 .append("		VIN_CODE = ?,FR_UNTPRCE = ?,FR_PRICE = ?,ENG_ARTCNM = ?,EDI_STS = ?, \n")
										 .append("		CAR_NO = ?,CARTYPENO = ?,CAR_WGHT  = ?, \n")
										 .append("		UPDATE_DT = CURRENT TIMESTAMP \n")
										 .append("  WHERE ORDER_NO = ? \n")
										 .append("    AND ORDER_SEQ = ? ");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString()); 
						gsmt.setGauceDataRow(rows2[j]);  

						gsmt.bindColumn(1,idx2ARTC_CD     );
						gsmt.bindColumn(2,idx2ARTC_NM     );
						gsmt.bindColumn(3,idx2STN_SZ      );
						gsmt.bindColumn(4,idx2STN_SZNM    );
						gsmt.bindColumn(5,idx2HSCODE      );
						gsmt.bindColumn(6,idx2ARTC_CNT    );
						gsmt.bindColumn(7,idx2ARTC_UNIT   );
						gsmt.bindColumn(8,idx2UNIT_PRICE  );
						gsmt.bindColumn(9,idx2PRICE       );
						gsmt.bindColumn(10,idx2LDCARGO     );
						gsmt.bindColumn(11,idx2LDCARGONM   );
						gsmt.bindColumn(12,idx2OFFCARGO    );
						gsmt.bindColumn(13,idx2OFFCARGONM  );
						gsmt.bindColumn(14,idx2PUNIT_CNT   );
						gsmt.bindColumn(15,idx2PUNIT_UNIT  );
						gsmt.bindColumn(16,idx2PUNIT_WGHT  );
						gsmt.bindColumn(17,idx2PKG_LNGTH   );
						gsmt.bindColumn(18,idx2PKG_HEIGHT  );
						gsmt.bindColumn(19,idx2PKG_WIDTH   );
						gsmt.bindColumn(20,idx2PKG_CBM     );
						gsmt.bindColumn(21,idx2PKG_CNT     );
						gsmt.bindColumn(22,idx2MIX_OTHERS  );
						gsmt.bindColumn(23,idx2SAMEAS      );
						gsmt.bindColumn(24,idx2CANCLE_STS  );
						gsmt.bindColumn(25,idx2AUTH_NO     );
						gsmt.bindColumn(26,idx2ORDER_STS   );
						gsmt.bindColumn(27,idx2SETTLE_STS  );
						gsmt.bindColumn(28,idx2REGFILENAME );
						gsmt.bindColumn(29,idx2UPDATE_USR  );
						gsmt.bindColumn(30,idx2CUR_CODE    );
						gsmt.bindColumn(31,idx2VIN_CODE    );
						gsmt.bindColumn(32,idx2FR_UNTPRCE  );
						gsmt.bindColumn(33,idx2FR_PRICE    );
						gsmt.bindColumn(34,idx2ENG_ARTCNM  );
						gsmt.bindColumn(35,idx2EDI_STS     );
						gsmt.bindColumn(36,idx2CAR_NO      );
						gsmt.bindColumn(37,idx2CARTYPENO   );
						gsmt.bindColumn(38,idx2CAR_WGHT    );
						gsmt.bindColumn(39,idx2ORDER_NO    );
						gsmt.bindColumn(40,idx2ORDER_SEQ   );

	 					gsmt.executeUpdate(); 
						gsmt.close(); 

					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						DeleteSql = new StringBuffer();
						DeleteSql.append(" DELETE FROM  TRANSFER.JTORDERDTL \n")
										 .append(" WHERE ORDER_NO  = ?  \n")
										 .append("   AND ORDER_SEQ = ?  ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows2[j]);

						gsmt.bindColumn(1,idx2ORDER_NO);
						gsmt.bindColumn(2,idx2ORDER_SEQ);

						gsmt.executeUpdate();
						gsmt.close();

					}
				}

			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se.toString());
				//logger.err.println(this,se);
				//logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
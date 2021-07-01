package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trOrderRegDtl extends HttpServlet{

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=null; }
				String etd_dt = reqGauce.getParameter("gstr2"); 
   				if ( etd_dt==null || etd_dt.trim().length()==0 ) { etd_dt=null; }
				String pltype = reqGauce.getParameter("gstr3"); 
   				if ( pltype==null || pltype.trim().length()==0 ) { pltype=null; }
                
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				
				int idxORDER_NO= userSet.indexOfColumn("ORDER_NO");
				int idxORDER_SEQ= userSet.indexOfColumn("ORDER_SEQ");
				int idxARTC_CD= userSet.indexOfColumn("ARTC_CD");
				int idxARTC_NM= userSet.indexOfColumn("ARTC_NM");
				int idxSTN_SZ= userSet.indexOfColumn("STN_SZ");
				int idxSTN_SZNM= userSet.indexOfColumn("STN_SZNM");
				int idxHSCODE= userSet.indexOfColumn("HSCODE");
				int idxARTC_CNT= userSet.indexOfColumn("ARTC_CNT");
				int idxARTC_UNIT= userSet.indexOfColumn("ARTC_UNIT");
				int idxUNIT_PRICE= userSet.indexOfColumn("UNIT_PRICE");
				int idxPRICE= userSet.indexOfColumn("PRICE");
				int idxLDCARGO= userSet.indexOfColumn("LDCARGO");
				int idxLDCARGONM= userSet.indexOfColumn("LDCARGONM");
				int idxOFFCARGO= userSet.indexOfColumn("OFFCARGO");
				int idxOFFCARGONM= userSet.indexOfColumn("OFFCARGONM");
				int idxPUNIT_CNT= userSet.indexOfColumn("PUNIT_CNT");
				int idxPUNIT_UNIT= userSet.indexOfColumn("PUNIT_UNIT");
				int idxPUNIT_WGHT= userSet.indexOfColumn("PUNIT_WGHT");
				int idxPKG_LNGTH= userSet.indexOfColumn("PKG_LNGTH");
				int idxPKG_HEIGHT= userSet.indexOfColumn("PKG_HEIGHT");
				int idxPKG_WIDTH= userSet.indexOfColumn("PKG_WIDTH");
				int idxPKG_CBM= userSet.indexOfColumn("PKG_CBM");
				int idxPKG_CNT= userSet.indexOfColumn("PKG_CNT");
				int idxMIX_OTHERS= userSet.indexOfColumn("MIX_OTHERS");
				int idxSAMEAS= userSet.indexOfColumn("SAMEAS");
				int idxSETTLE_STS= userSet.indexOfColumn("SETTLE_STS"); 
				int idxCREATE_USR= userSet.indexOfColumn("CREATE_USR"); 
				int idxUPDATE_USR= userSet.indexOfColumn("UPDATE_USR");
				int idxENG_ARTCNM= userSet.indexOfColumn("ENG_ARTCNM");
				int idxVIN_CODE= userSet.indexOfColumn("VIN_CODE");
				int idxCANCLE_STS= userSet.indexOfColumn("CANCLE_STS");
				int idxETD_DT= userSet.indexOfColumn("ETD_DT");
				int idxING_STS= userSet.indexOfColumn("ING_STS"); //2007.11.22 수정,취소 진행상태 추가

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						String v1 = rows[j].getString(idxORDER_NO);
						int v2 = v1.length();

						if (v2<10){
							String sid = rows[j].getString(idxCREATE_USR);
							String suserid = "";
					
							if (sid==null) sid = "";
							if (sid.equals(""))	{
								String sql = " SELECT NVL(USERID,'') USERID FROM TRANSFER.LTUSER "
										   + "  WHERE REGNO = ( SELECT VEND_ID "
										   + "  				  FROM ACCOUNT.GCZM_VENDER "
										   + "					 WHERE VEND_CD = (SELECT CUST_CD FROM TRANSFER.LTORDERMST WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "')) ";

								Statement stmt = null;
								ResultSet rs = null;

								stmt = conn.createStatement();
								rs = stmt.executeQuery(sql);
								
								int ci = 0;
							//	while(rs.next()){
							//		if (ci==0) suserid = rs.getString(1);
							//		ci++;
							//	}


								stmt.close();
								rs.close();
								InsertSql = new StringBuffer();
								InsertSql.append(" INSERT INTO TRANSFER.LTORDERDTL \n ")
										 .append(" ( \n ")
										 .append("		ORDER_NO,ORDER_SEQ,ARTC_CD,ARTC_NM, \n ")
										 .append("		STN_SZ,STN_SZNM,HSCODE,ARTC_CNT, \n ")
										 .append("		ARTC_UNIT,UNIT_PRICE,PRICE,LDCARGO, \n ")
										 .append("		LDCARGONM,OFFCARGO,OFFCARGONM, \n ") 
										 .append("		PUNIT_CNT,PUNIT_UNIT,PUNIT_WGHT, \n ")
										 .append("		PKG_LNGTH,PKG_HEIGHT,PKG_WIDTH,PKG_CBM, \n ")
										 .append("		PKG_CNT,MIX_OTHERS,SAMEAS,SETTLE_STS, \n ")
										 .append("		CREATE_DT,CREATE_USR,UPDATE_DT, \n ")
										 .append("		UPDATE_USR,ENG_ARTCNM,VIN_CODE,CANCLE_STS, \n ")
										 .append("		ETD_DT, ING_STS \n ")
										 .append(" ) VALUES ( \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		CURRENT_TIMESTAMP,'" + suserid + "',CURRENT_TIMESTAMP, \n ")
										 .append("		?,?,?,?,'" + etd_dt + "',?  ")
										 .append(" ) ");

								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
								gsmt.setGauceDataRow(rows[j]); 
								gsmt.setString(1, ord_no); 
								gsmt.bindColumn(2,idxORDER_SEQ);
								gsmt.bindColumn(3,idxARTC_CD);
								gsmt.bindColumn(4,idxARTC_NM);
								gsmt.bindColumn(5,idxSTN_SZ);
								gsmt.bindColumn(6,idxSTN_SZNM);
								gsmt.bindColumn(7,idxHSCODE);
								gsmt.bindColumn(8,idxARTC_CNT);
								gsmt.bindColumn(9,idxARTC_UNIT);
								gsmt.bindColumn(10,idxUNIT_PRICE);
								gsmt.bindColumn(11,idxPRICE);
								gsmt.bindColumn(12,idxLDCARGO);
								gsmt.bindColumn(13,idxLDCARGONM);
								gsmt.bindColumn(14,idxOFFCARGO);
								gsmt.bindColumn(15,idxOFFCARGONM);
								gsmt.bindColumn(16,idxPUNIT_CNT);
								gsmt.bindColumn(17,idxPUNIT_UNIT);
								gsmt.bindColumn(18,idxPUNIT_WGHT);
								gsmt.bindColumn(19,idxPKG_LNGTH);
								gsmt.bindColumn(20,idxPKG_HEIGHT);
								gsmt.bindColumn(21,idxPKG_WIDTH);
								gsmt.bindColumn(22,idxPKG_CBM);
								gsmt.bindColumn(23,idxPKG_CNT);
								gsmt.bindColumn(24,idxMIX_OTHERS);
								gsmt.bindColumn(25,idxSAMEAS);
								gsmt.bindColumn(26,idxSETTLE_STS);
//								gsmt.bindColumn(27,idxCREATE_USR);
								gsmt.bindColumn(27,idxUPDATE_USR); 
								gsmt.bindColumn(28,idxENG_ARTCNM); 
								gsmt.bindColumn(29,idxVIN_CODE); 
								gsmt.bindColumn(30,idxCANCLE_STS); 
							//	gsmt.setString(31, etd_dt); 
							  gsmt.bindColumn(31,idxING_STS); 
								gsmt.executeUpdate(); 
								gsmt.close();

							} else {
								InsertSql = new StringBuffer();
								InsertSql.append(" INSERT INTO TRANSFER.LTORDERDTL \n ")
										 .append(" ( \n ")
										 .append("		ORDER_NO,ORDER_SEQ,ARTC_CD,ARTC_NM, \n ")
										 .append("		STN_SZ,STN_SZNM,HSCODE,ARTC_CNT, \n ")
										 .append("		ARTC_UNIT,UNIT_PRICE,PRICE,LDCARGO, \n ")
										 .append("		LDCARGONM,OFFCARGO,OFFCARGONM, \n ") 
										 .append("		PUNIT_CNT,PUNIT_UNIT,PUNIT_WGHT, \n ")
										 .append("		PKG_LNGTH,PKG_HEIGHT,PKG_WIDTH,PKG_CBM, \n ")
										 .append("		PKG_CNT,MIX_OTHERS,SAMEAS,SETTLE_STS, \n ")
										 .append("		CREATE_DT,CREATE_USR,UPDATE_DT, \n ")
										 .append("		UPDATE_USR,ENG_ARTCNM,VIN_CODE,CANCLE_STS, \n ")
										 .append("		ETD_DT,ING_STS \n ")
										 .append(" ) VALUES ( \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP, \n ")
										 .append("		?,?,?,?,'" + etd_dt + "',?  ")
										 .append(" ) ");

								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
								gsmt.setGauceDataRow(rows[j]); 
								gsmt.setString(1, ord_no); 
								gsmt.bindColumn(2,idxORDER_SEQ);
								gsmt.bindColumn(3,idxARTC_CD);
								gsmt.bindColumn(4,idxARTC_NM);
								gsmt.bindColumn(5,idxSTN_SZ);
								gsmt.bindColumn(6,idxSTN_SZNM);
								gsmt.bindColumn(7,idxHSCODE);
								gsmt.bindColumn(8,idxARTC_CNT);
								gsmt.bindColumn(9,idxARTC_UNIT);
								gsmt.bindColumn(10,idxUNIT_PRICE);
								gsmt.bindColumn(11,idxPRICE);
								gsmt.bindColumn(12,idxLDCARGO);
								gsmt.bindColumn(13,idxLDCARGONM);
								gsmt.bindColumn(14,idxOFFCARGO);
								gsmt.bindColumn(15,idxOFFCARGONM);
								gsmt.bindColumn(16,idxPUNIT_CNT);
								gsmt.bindColumn(17,idxPUNIT_UNIT);
								gsmt.bindColumn(18,idxPUNIT_WGHT);
								gsmt.bindColumn(19,idxPKG_LNGTH);
								gsmt.bindColumn(20,idxPKG_HEIGHT);
								gsmt.bindColumn(21,idxPKG_WIDTH);
								gsmt.bindColumn(22,idxPKG_CBM);
								gsmt.bindColumn(23,idxPKG_CNT);
								gsmt.bindColumn(24,idxMIX_OTHERS);
								gsmt.bindColumn(25,idxSAMEAS);
								gsmt.bindColumn(26,idxSETTLE_STS);
								gsmt.bindColumn(27,idxCREATE_USR);
								gsmt.bindColumn(28,idxUPDATE_USR); 
								gsmt.bindColumn(29,idxENG_ARTCNM); 
								gsmt.bindColumn(30,idxVIN_CODE); 
								gsmt.bindColumn(31,idxCANCLE_STS); 
								gsmt.bindColumn(32,idxING_STS); 
								gsmt.executeUpdate(); 
								gsmt.close();

							}
						} else {
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTORDERDTL \n ")
											 .append(" SET ARTC_CD		= ?, \n ")
											 .append("		 ARTC_NM		= ?, \n ")
											 .append("		 STN_SZ			= ?, \n ")
											 .append("		 STN_SZNM		= ?, \n ")
											 .append("		 HSCODE			= ?, \n ")
											 .append("		 ARTC_CNT		= ?, \n ")
											 .append("		 ARTC_UNIT	= ?, \n ")
											 .append("		 UNIT_PRICE = ?, \n ")
											 .append("		 PRICE			= ?, \n ")
											 .append("		 LDCARGO		= ?, \n ")
											 .append("		 LDCARGONM	= ?, \n ")
											 .append("		 OFFCARGO		= ?, \n ")
											 .append("		 OFFCARGONM = ?, \n ")
											 .append("		 PUNIT_CNT	= ?, \n ")
											 .append("		 PUNIT_UNIT	= ?, \n ")
											 .append("		 PUNIT_WGHT	= ?, \n ")
											 .append("		 PKG_LNGTH	= ?, \n ")
											 .append("		 PKG_HEIGHT	= ?, \n ")
											 .append("		 PKG_WIDTH	= ?, \n ")
											 .append("		 PKG_CBM		= ?, \n ")
											 .append("		 PKG_CNT		= ?, \n ")
											 .append("		 MIX_OTHERS	= ?, \n ")
											 .append("		 SAMEAS			= ?, \n ")
											 .append("		 SETTLE_STS	= ?, \n ")
											 .append("		 UPDATE_DT	= CURRENT_TIMESTAMP, \n ")
											 .append("		 UPDATE_USR = ?, \n ")
											 .append("		 ENG_ARTCNM = ?, \n ")
											 .append("		 VIN_CODE = ?, \n ")
											 .append("		 CANCLE_STS = ?, \n ")
											 .append("		 ETD_DT = '" + etd_dt + "', \n")
								       .append("		 ING_STS = ? \n ")
											 .append(" WHERE ORDER_NO = ? ")
											 .append("   AND ORDER_SEQ = ?"); 

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							
							gsmt.bindColumn(1,idxARTC_CD);
							gsmt.bindColumn(2,idxARTC_NM);
							gsmt.bindColumn(3,idxSTN_SZ);
							gsmt.bindColumn(4,idxSTN_SZNM);
							gsmt.bindColumn(5,idxHSCODE);
							gsmt.bindColumn(6,idxARTC_CNT);
							gsmt.bindColumn(7,idxARTC_UNIT);
							gsmt.bindColumn(8,idxUNIT_PRICE);
							gsmt.bindColumn(9,idxPRICE);
							gsmt.bindColumn(10,idxLDCARGO);
							gsmt.bindColumn(11,idxLDCARGONM);
							gsmt.bindColumn(12,idxOFFCARGO);
							gsmt.bindColumn(13,idxOFFCARGONM);
							gsmt.bindColumn(14,idxPUNIT_CNT);
							gsmt.bindColumn(15,idxPUNIT_UNIT);
							gsmt.bindColumn(16,idxPUNIT_WGHT);
							gsmt.bindColumn(17,idxPKG_LNGTH);
							gsmt.bindColumn(18,idxPKG_HEIGHT);
							gsmt.bindColumn(19,idxPKG_WIDTH);
							gsmt.bindColumn(20,idxPKG_CBM);
							gsmt.bindColumn(21,idxPKG_CNT);
							gsmt.bindColumn(22,idxMIX_OTHERS);
							gsmt.bindColumn(23,idxSAMEAS);
							gsmt.bindColumn(24,idxSETTLE_STS);
							gsmt.bindColumn(25,idxUPDATE_USR); 
							gsmt.bindColumn(26,idxENG_ARTCNM); 
							gsmt.bindColumn(27,idxVIN_CODE); 
							gsmt.bindColumn(28,idxCANCLE_STS); 
							gsmt.bindColumn(29,idxING_STS); 
							gsmt.setString(30, ord_no); 
							gsmt.bindColumn(31,idxORDER_SEQ);

							gsmt.executeUpdate(); 
							gsmt = null;

							String vchk = rows[j].getString(idxSAMEAS);
							if (vchk.equals("")){
								DeleteSql = new StringBuffer();
								DeleteSql.append( " DELETE FROM TRANSFER.LTCARGOODS \n" )
										 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' \n" )
										 .append( "    AND ORDER_SEQ = '" + rows[j].getString(idxORDER_SEQ) + "' " );

								gsmt = conn.getGauceStatement(DeleteSql.toString());
								gsmt.executeUpdate();
								gsmt.close();
							} else {
								DeleteSql = new StringBuffer();
								DeleteSql.append( " DELETE FROM TRANSFER.LTCARGOODS \n" )
										 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' \n" )
										 .append( "    AND ORDER_SEQ IN (SELECT ORDER_SEQ  \n" )
										 .append( "						   FROM TRANSFER.LTORDERDTL \n" )
										 .append( "						  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "'  \n" )
										 .append( "							AND SAMEAS = '" + rows[j].getString(idxSAMEAS) + "') " );

								gsmt = conn.getGauceStatement(DeleteSql.toString());
								gsmt.executeUpdate();
								gsmt.close();
							}
						}

						if (pltype.equals("Y"))	{
							String	query = "CALL TRANSFER.SP_BDPLCI1 (?)" ; 

							cstmt = conn.prepareCall(query);
							cstmt.setString(1, ord_no ); 

							cstmt.execute();
							cstmt.close();
						}

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDERDTL SET  ") ; 
						UpdateSql.append("		ARTC_CD    = ?, ARTC_NM     = ?,  ") ; 
						UpdateSql.append("		STN_SZ     = ?, STN_SZNM    = ?, HSCODE     = ?, ARTC_CNT   = ?, ") ; 
						UpdateSql.append("		ARTC_UNIT  = ?, UNIT_PRICE  = ?, PRICE      = ?, LDCARGO    = ?, ") ; 
						UpdateSql.append("		LDCARGONM  = ?, OFFCARGO    = ?, OFFCARGONM = ?, ") ; 
						UpdateSql.append("		PUNIT_CNT  = ?, PUNIT_UNIT  = ?, PUNIT_WGHT = ?, ") ; 
						UpdateSql.append("		PKG_LNGTH  = ?, PKG_HEIGHT  = ?, PKG_WIDTH  = ?, PKG_CBM    = ?, ") ; 
						UpdateSql.append("		PKG_CNT    = ?, MIX_OTHERS  = ?, SAMEAS     = ?, SETTLE_STS = ?, ") ; 
						UpdateSql.append("		UPDATE_DT  = CURRENT_TIMESTAMP, ") ; 
						UpdateSql.append("		UPDATE_USR = ?, ENG_ARTCNM = ?, VIN_CODE = ?, CANCLE_STS = ?, ING_STS=?   ") ; 
						UpdateSql.append("  WHERE ORDER_NO = ? AND ORDER_SEQ =?") ; 
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxARTC_CD);
						gsmt.bindColumn(2,idxARTC_NM);
						gsmt.bindColumn(3,idxSTN_SZ);
						gsmt.bindColumn(4,idxSTN_SZNM);
						gsmt.bindColumn(5,idxHSCODE);
						gsmt.bindColumn(6,idxARTC_CNT);
						gsmt.bindColumn(7,idxARTC_UNIT);
						gsmt.bindColumn(8,idxUNIT_PRICE);
						gsmt.bindColumn(9,idxPRICE);
						gsmt.bindColumn(10,idxLDCARGO);
						gsmt.bindColumn(11,idxLDCARGONM);
						gsmt.bindColumn(12,idxOFFCARGO);
						gsmt.bindColumn(13,idxOFFCARGONM);
						gsmt.bindColumn(14,idxPUNIT_CNT);
						gsmt.bindColumn(15,idxPUNIT_UNIT);
						gsmt.bindColumn(16,idxPUNIT_WGHT);
						gsmt.bindColumn(17,idxPKG_LNGTH);
						gsmt.bindColumn(18,idxPKG_HEIGHT);
						gsmt.bindColumn(19,idxPKG_WIDTH);
						gsmt.bindColumn(20,idxPKG_CBM);
						gsmt.bindColumn(21,idxPKG_CNT);
						gsmt.bindColumn(22,idxMIX_OTHERS);
						gsmt.bindColumn(23,idxSAMEAS);
						gsmt.bindColumn(24,idxSETTLE_STS);
					    gsmt.bindColumn(25,idxUPDATE_USR); 
					    gsmt.bindColumn(26,idxENG_ARTCNM); 
					    gsmt.bindColumn(27,idxVIN_CODE); 
					    gsmt.bindColumn(28,idxCANCLE_STS);
						gsmt.bindColumn(29,idxING_STS);
						gsmt.setString(30, ord_no); 
						gsmt.bindColumn(31,idxORDER_SEQ);

						gsmt.executeUpdate(); 
						gsmt.close();         
						if (pltype.equals("Y"))	{
							String	query = "CALL TRANSFER.SP_BDPLCI1 (?)" ; 

							cstmt = conn.prepareCall(query);
							cstmt.setString(1, ord_no ); 

							cstmt.execute();
							cstmt.close();
						}

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						if (ord_no.equals("B")){
							DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE FROM TRANSFER.LTORDERDTL \n" )
									 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
									 .append( "    AND ORDER_SEQ = '" + rows[j].getString(idxORDER_SEQ) + "' " );

							GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.executeUpdate();
							gsmt = null;
							DeleteSql = null;

							DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE FROM TRANSFER.LTCARGOODS \n" )
									 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
									 .append( "    AND ORDER_SEQ = '" + rows[j].getString(idxORDER_SEQ) + "' " );

							gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.executeUpdate();
							gsmt.close();
						} else if (ord_no.equals("A")) {
							Statement stmt = null;
							ResultSet rs = null;

							StringBuffer Select_Bef = null;
							Select_Bef = new StringBuffer();
							Select_Bef.append( " SELECT MIN(ORDER_SEQ), COUNT(*) CNT FROM TRANSFER.LTORDERDTL \n" )
									  .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
									  .append( "    AND ORDER_SEQ != '" + rows[j].getString(idxORDER_SEQ) + "' " )
									  .append( "    AND SAMEAS = '" + rows[j].getString(idxORDER_SEQ) + "' " );

							stmt = conn.createStatement();
							rs = stmt.executeQuery(Select_Bef.toString());
							int icnt = 0;
							int icnt2 = 0;
							while(rs.next()) {
								icnt = rs.getInt(1);
								icnt2 = rs.getInt(2);
							}	

							stmt = null;
							rs = null;

							if (icnt != 0) {

								StringBuffer Update_Bef = new StringBuffer();
								Update_Bef.append( " UPDATE TRANSFER.LTORDERDTL \n" )
										  .append( "    SET SAMEAS		= " + icnt + " \n")
										  .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
										  .append( "    AND SAMEAS = '" + rows[j].getString(idxORDER_SEQ) + "' " );
						
								GauceStatement gsmt = conn.getGauceStatement(Update_Bef.toString());
								gsmt.executeUpdate();
								gsmt = null;
								Update_Bef = null;


								Update_Bef = new StringBuffer();
								Update_Bef.append( " UPDATE TRANSFER.LTORDERDTL \n" )
											.append( "    SET PUNIT_CNT		= " + rows[j].getString(idxPUNIT_CNT) + ", \n")
											.append( "				PUNIT_WGHT	= " + rows[j].getString(idxPUNIT_WGHT) + ", \n")
											.append( "				PKG_LNGTH		= " + rows[j].getString(idxPKG_LNGTH) + ", \n")
											.append( "				PKG_HEIGHT	= " + rows[j].getString(idxPKG_HEIGHT) + ", \n")
											.append( "				PKG_WIDTH		= " + rows[j].getString(idxPKG_WIDTH) + ", \n")
											.append( "				PKG_CBM			= " + rows[j].getString(idxPKG_CBM) + ", \n")
											.append( "				PKG_CNT			= " + rows[j].getString(idxPKG_CNT) + "  \n")
											.append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
											.append( "    AND ORDER_SEQ = '" + icnt + "' " );
								gsmt = conn.getGauceStatement(Update_Bef.toString());
								gsmt.executeUpdate();
								gsmt = null;
								Update_Bef = null;

								Update_Bef = new StringBuffer();
								Update_Bef.append( " UPDATE TRANSFER.LTCARGOODS \n" )
										  .append( "    SET PKG_WGHT	= " + rows[j].getString(idxPUNIT_WGHT) + ", \n")
										  .append( "		PKG_CBM			= " + rows[j].getString(idxPKG_CBM) + ", \n")
										  .append( "		PKG_CNT			= " + rows[j].getString(idxPKG_CNT) + "  \n")
										  .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
									      .append( "    AND ORDER_SEQ = '" + icnt + "' " );

								gsmt = conn.getGauceStatement(Update_Bef.toString());
								gsmt.executeUpdate();
								gsmt = null;

								if (icnt2==1){
									Update_Bef = new StringBuffer();
									Update_Bef.append( " UPDATE TRANSFER.LTORDERDTL \n" )
											  .append( "    SET SAMEAS	= '', \n")
											  .append( "		MIX_OTHERS	= '' \n")
											  .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
											  .append( "    AND ORDER_SEQ = '" + icnt + "' " );

									gsmt = conn.getGauceStatement(Update_Bef.toString());
									gsmt.executeUpdate();
									gsmt = null;
								}

								DeleteSql = new StringBuffer();
								DeleteSql.append( " DELETE FROM TRANSFER.LTORDERDTL \n" )
										 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
										 .append( "    AND ORDER_SEQ = '" + rows[j].getString(idxORDER_SEQ) + "' " );

								gsmt = conn.getGauceStatement(DeleteSql.toString());
								gsmt.executeUpdate();
								gsmt = null;
								DeleteSql	= null;

								DeleteSql = new StringBuffer();
								DeleteSql.append( " DELETE FROM TRANSFER.LTCARGOODS \n" )
										 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' " )
										 .append( "    AND ORDER_SEQ = '" + rows[j].getString(idxORDER_SEQ) + "' " );

								gsmt = conn.getGauceStatement(DeleteSql.toString());
								gsmt.executeUpdate();
								gsmt.close();
							}
						}
					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
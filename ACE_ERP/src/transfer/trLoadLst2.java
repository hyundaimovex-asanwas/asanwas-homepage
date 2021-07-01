package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trLoadLst2 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 

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
				String str1 = reqGauce.getParameter("gstr1"); 
   				if ( str1==null || str1.trim().length()==0 ) { str1=""; }
				String str2 = null ; 
                
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	
		 
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				
				int idxCAR_SEQ_NO     =userSet.indexOfColumn("CAR_SEQ_NO");
				int idxORDER_NO       =userSet.indexOfColumn("ORDER_NO");
				int idxORDER_SEQ      =userSet.indexOfColumn("ORDER_SEQ");
				int idxARTC_CNT       =userSet.indexOfColumn("ARTC_CNT");
				int idxPUNIT_CNT      =userSet.indexOfColumn("PUNIT_CNT");
				int idxPUNIT_WEIGHT   =userSet.indexOfColumn("PUNIT_WEIGHT");
				int idxPKG_LNGTH      =userSet.indexOfColumn("PKG_LNGTH");
				int idxPKG_HEIGHT     =userSet.indexOfColumn("PKG_HEIGHT");
				int idxPKG_WIDTH      =userSet.indexOfColumn("PKG_WIDTH");
				int idxTOTAL_CBM      =userSet.indexOfColumn("TOTAL_CBM");
				int idxTOTAL_WEIGHT   =userSet.indexOfColumn("TOTAL_WEIGHT");
				int idxSTS_CODE       =userSet.indexOfColumn("STS_CODE");
				int idxUPEND_DT       =userSet.indexOfColumn("UPEND_DT");
				int idxUPEND_TIME     =userSet.indexOfColumn("UPEND_TIME");
				int idxREMARK         =userSet.indexOfColumn("REMARK");
				int idxBAECHA_NO      =userSet.indexOfColumn("BAECHA_NO");
				int idxENTER_NO       =userSet.indexOfColumn("ENTER_NO");
				int idxCAR_NO         =userSet.indexOfColumn("CAR_NO"); 
				int idxCREATE_DT			=userSet.indexOfColumn("CREATE_DT"); 
				int idxCREATE_USR     =userSet.indexOfColumn("CREATE_USR"); 
				int idxUPDATE_DT			=userSet.indexOfColumn("UPDATE_DT"); 
				int idxUPDATE_UST     =userSet.indexOfColumn("UPDATE_UST"); 
				int idxARTC_NM				=userSet.indexOfColumn("ARTC_NM"); 
				int idxSTN_SZNM				=userSet.indexOfColumn("STN_SZNM"); 
				int idxVEND_NM				=userSet.indexOfColumn("VEND_NM"); 
				int idxCAR_NO1				=userSet.indexOfColumn("CAR_NO1"); 
				int idxPKG_CNT				=userSet.indexOfColumn("PKG_CNT"); 
				int idxARTC_UNIT			=userSet.indexOfColumn("ARTC_UNIT"); 
				int idxORG_CNT				=userSet.indexOfColumn("ORG_CNT"); 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null ; 

				for (int j = 0; j < rows.length; j++){
					String s_order_no  = rows[j].getString(idxORDER_NO);
					String s_order_seq = rows[j].getString(idxORDER_SEQ);

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//상차예정정보
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTLOADLST( \n ")
										 .append("		CAR_SEQ_NO,ORDER_NO,ORDER_SEQ,ARTC_CNT, \n ")
										 .append("		PUNIT_CNT,PUNIT_WEIGHT,PKG_LNGTH, \n ")
										 .append("		PKG_HEIGHT,PKG_WIDTH,TOTAL_CBM,TOTAL_WEIGHT, \n ")
										 .append("		STS_CODE,UPEND_DT,UPEND_TIME,REMARK,BAECHA_NO, \n ")
										 .append("		ENTER_NO,CAR_NO,CREATE_DT,CREATE_USR, \n ")
										 .append("		UPDATE_DT,UPDATE_UST,PKG_CNT ) \n ")
										 .append(" VALUES( \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,substr(char(current date),1,4)|| substr(char(current date),6,2)|| substr(char(current date),9,2),substr(char(current time),1,2)||substr(char(current time),4,2),?,?, \n ")
										 .append("		?,?,CURRENT TIMESTAMP,?, \n ")
										 .append("		CURRENT TIMESTAMP,?,? )");

						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 

						gsmt.bindColumn(1, idxCAR_SEQ_NO  );
						gsmt.bindColumn(2, idxORDER_NO  );
						gsmt.bindColumn(3, idxORDER_SEQ  );
						gsmt.bindColumn(4, idxARTC_CNT  );
						gsmt.bindColumn(5, idxPUNIT_CNT  );
						gsmt.bindColumn(6, idxPUNIT_WEIGHT  );
						gsmt.bindColumn(7, idxPKG_LNGTH  );
						gsmt.bindColumn(8, idxPKG_HEIGHT );
						gsmt.bindColumn(9, idxPKG_WIDTH );						 
						gsmt.bindColumn(10, idxTOTAL_CBM );
						gsmt.bindColumn(11, idxTOTAL_WEIGHT );
						gsmt.bindColumn(12, idxSTS_CODE );
						gsmt.bindColumn(13, idxREMARK );
						gsmt.bindColumn(14, idxBAECHA_NO );
						gsmt.bindColumn(15, idxENTER_NO );
						gsmt.bindColumn(16, idxCAR_NO );
						gsmt.bindColumn(17, idxCREATE_USR );
						gsmt.bindColumn(18, idxUPDATE_UST );
						gsmt.bindColumn(19, idxPKG_CNT ); 

						gsmt.executeUpdate(); 
						gsmt = null;
						InsertSql = null;

						String s_artc_cnt  = rows[j].getString(idxARTC_CNT);
						if (s_artc_cnt==null || s_artc_cnt=="") s_artc_cnt = "0";
						int i_artc_cnt = 0;
						i_artc_cnt = (int) (Float.parseFloat(s_artc_cnt));

						//재고정보
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTORDSTOCK \n")
										 .append("		( ORDER_NO, ORDER_SEQ, STOCK_SEQ, ETD_DT, LINE_PART, \n")
										 .append("		  CARGO_TYPE, DLVL_TYPE, ARTC_CD, ARTC_NM, OD_ARTCCNT, \n")
										 .append("		  OD_ARTCUNT, OD_UNTPRCE, OD_PRICE, OD_LDCARGO, OD_LDCRGNM, \n")
										 .append("		  OD_OFCARGO, OD_OFCRGNM, OD_PUNTCNT, OD_PUNTUNT, OD_PUNTWGT, \n")
										 .append("		  OD_PKGLNGT, OD_PKGHEGT, OD_PKGWIDT, OD_PKGCBM, OD_PKGCNT, \n")
										 .append("		  ENTER_DATE, ENTER_NO, EN_ARTCCNT, EN_PUNTCNT, EN_PUNTWGT, \n")
										 .append("		  EN_PKGLNGT, EN_PKGHEGT, EN_PKGWIDT, EN_PKGCBM, EN_TOTCBM, \n")
										 .append("		  EN_TOTWGT, EN_PKGCNT, UPEND_DT, LD_ARTCCNT, LD_PUNTCNT, \n")
										 .append("		  LD_PUNTWGT, LD_PKGLNGT, LD_PKGHEGT, LD_PKGWIDT, LD_TOTCBM, \n")
										 .append("		  LD_TOTWGT, LD_PKGCNT, ST_ARTCCNT, ST_PUNTCNT, ST_PUNTWGT, \n")
										 .append("		  ST_PKGLNGT, ST_PKGHEGT, ST_PKGWIDT, ST_TOTCBM, ST_TOTWGT, \n")
										 .append("		  ST_PKGCNT, ORDER_STS, STOCK_STS, CREATE_DT, CREATE_USR, \n")
										 .append("		  UPDATE_DT, UPDATE_USR \n")
										 .append("		) SELECT '" + s_order_no + "', '" + s_order_seq + "', STOCK_SEQ+1, ETD_DT, LINE_PART, \n")
										 .append("				  CARGO_TYPE, DLVL_TYPE, ARTC_CD, ARTC_NM, OD_ARTCCNT, \n")
										 .append("				  OD_ARTCUNT, OD_UNTPRCE, OD_PRICE, OD_LDCARGO, OD_LDCRGNM, \n") 
										 .append("				  OD_OFCARGO, OD_OFCRGNM, OD_PUNTCNT, OD_PUNTUNT, OD_PUNTWGT, \n")
										 .append("				  OD_PKGLNGT, OD_PKGHEGT, OD_PKGWIDT, OD_PKGCBM, OD_PKGCNT, \n")
										 .append("				  ENTER_DATE, ENTER_NO, EN_ARTCCNT, EN_PUNTCNT, EN_PUNTWGT, \n")
										 .append("				  EN_PKGLNGT, EN_PKGHEGT, EN_PKGWIDT, EN_PKGCBM, EN_TOTCBM, \n")
										 .append("				  EN_TOTWGT, EN_PKGCNT, UPEND_DT, LD_ARTCCNT, LD_PUNTCNT, \n")
										 .append("				  LD_PUNTWGT, LD_PKGLNGT, LD_PKGHEGT, LD_PKGWIDT, LD_TOTCBM, \n")
										 .append("				  LD_TOTWGT, LD_PKGCNT, ST_ARTCCNT - " + i_artc_cnt + ", ST_PUNTCNT, ST_PUNTWGT, \n")
										 .append("				  ST_PKGLNGT, ST_PKGHEGT, ST_PKGWIDT, ST_TOTCBM, ST_TOTWGT, \n")
										 .append("				  ST_PKGCNT, ORDER_STS, STOCK_STS, CREATE_DT, CREATE_USR, \n")
										 .append("				  UPDATE_DT, UPDATE_USR \n")
										 .append("			  FROM TRANSFER.LTORDSTOCK \n")
										 .append("			 WHERE ORDER_NO = '" + s_order_no + "' \n")
										 .append("			   AND ORDER_SEQ = '" + s_order_seq + "' ")
										 .append("			   AND STOCK_SEQ = (SELECT MAX(INTEGER(STOCK_SEQ)) \n")
										 .append("														FROM TRANSFER.LTORDSTOCK \n")
										 .append("													 WHERE ORDER_NO = '" + s_order_no + "' \n")
										 .append("														 AND ORDER_SEQ = '" + s_order_seq + "') ");

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate(); 
						gsmt.close();					

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						int iparm1 = rows[j].getInt(idxARTC_CNT);
						int iparm2 = rows[j].getInt(idxORG_CNT);

						//재고정보 유무 검색
						sql = new StringBuffer();
						sql.append(" SELECT IFNULL(MAX(STOCK_SEQ),0) CNT \n")
							 .append("   FROM TRANSFER.LTORDSTOCK \n")
							 .append("  WHERE ORDER_NO = '" + s_order_no + "' \n")
							 .append("    AND ORDER_SEQ = '" + s_order_seq + "'");

						Statement stmt = null;
						ResultSet rs = null;
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						
						int icnt = 0;
						while (rs.next())	{
							icnt = rs.getInt(1);
						}

						stmt.close();
						rs.close();

						int iartc = 0;
						if (icnt>0)	{
							StringBuffer sql2 = new StringBuffer();
							sql2.append(" INSERT INTO TRANSFER.LTORDSTOCK \n")
									.append("		( ORDER_NO, ORDER_SEQ, STOCK_SEQ, ETD_DT, LINE_PART, \n")
									.append("		  CARGO_TYPE, DLVL_TYPE, ARTC_CD, ARTC_NM, OD_ARTCCNT, \n")
									.append("		  OD_ARTCUNT, OD_UNTPRCE, OD_PRICE, OD_LDCARGO, OD_LDCRGNM, \n")
									.append("		  OD_OFCARGO, OD_OFCRGNM, OD_PUNTCNT, OD_PUNTUNT, OD_PUNTWGT, \n")
									.append("		  OD_PKGLNGT, OD_PKGHEGT, OD_PKGWIDT, OD_PKGCBM, OD_PKGCNT, \n")
									.append("		  ENTER_DATE, ENTER_NO, EN_ARTCCNT, EN_PUNTCNT, EN_PUNTWGT, \n")
									.append("		  EN_PKGLNGT, EN_PKGHEGT, EN_PKGWIDT, EN_PKGCBM, EN_TOTCBM, \n")
									.append("		  EN_TOTWGT, EN_PKGCNT, UPEND_DT, LD_ARTCCNT, LD_PUNTCNT, \n")
									.append("		  LD_PUNTWGT, LD_PKGLNGT, LD_PKGHEGT, LD_PKGWIDT, LD_TOTCBM, \n")
									.append("		  LD_TOTWGT, LD_PKGCNT, ST_ARTCCNT, ST_PUNTCNT, ST_PUNTWGT, \n")
									.append("		  ST_PKGLNGT, ST_PKGHEGT, ST_PKGWIDT, ST_TOTCBM, ST_TOTWGT, \n")
									.append("		  ST_PKGCNT, ORDER_STS, STOCK_STS, CREATE_DT, CREATE_USR, \n")
									.append("		  UPDATE_DT, UPDATE_USR \n")
									.append("		) SELECT '" + s_order_no + "', '" + s_order_seq + "', STOCK_SEQ+1, ETD_DT, LINE_PART, \n")
									.append("				  CARGO_TYPE, DLVL_TYPE, ARTC_CD, ARTC_NM, OD_ARTCCNT, \n")
									.append("				  OD_ARTCUNT, OD_UNTPRCE, OD_PRICE, OD_LDCARGO, OD_LDCRGNM, \n") 
									.append("				  OD_OFCARGO, OD_OFCRGNM, OD_PUNTCNT, OD_PUNTUNT, OD_PUNTWGT, \n")
									.append("				  OD_PKGLNGT, OD_PKGHEGT, OD_PKGWIDT, OD_PKGCBM, OD_PKGCNT, \n")
									.append("				  ENTER_DATE, ENTER_NO, EN_ARTCCNT, EN_PUNTCNT, EN_PUNTWGT, \n")
									.append("				  EN_PKGLNGT, EN_PKGHEGT, EN_PKGWIDT, EN_PKGCBM, EN_TOTCBM, \n")
									.append("				  EN_TOTWGT, EN_PKGCNT, UPEND_DT, LD_ARTCCNT, LD_PUNTCNT, \n")
									.append("				  LD_PUNTWGT, LD_PKGLNGT, LD_PKGHEGT, LD_PKGWIDT, LD_TOTCBM, \n")
									.append("				  LD_TOTWGT, LD_PKGCNT, \n");

							int ival = iparm2 - iparm1;
							sql2.append("					" + ival + ", \n");

							sql2.append("					ST_PUNTCNT, ST_PUNTWGT, \n")
									.append("				  ST_PKGLNGT, ST_PKGHEGT, ST_PKGWIDT, ST_TOTCBM, ST_TOTWGT, \n")
									.append("				  ST_PKGCNT, ORDER_STS, STOCK_STS, CREATE_DT, CREATE_USR, \n")
									.append("				  UPDATE_DT, UPDATE_USR \n")
									.append("			  FROM TRANSFER.LTORDSTOCK \n")
									.append("			 WHERE ORDER_NO = '" + s_order_no + "' \n")
									.append("			   AND ORDER_SEQ = '" + s_order_seq + "' ")
									.append("			   AND STOCK_SEQ = (SELECT MAX(INTEGER(STOCK_SEQ)) \n")
									.append("														FROM TRANSFER.LTORDSTOCK \n")
									.append("													 WHERE ORDER_NO = '" + s_order_no + "' \n")
									.append("														 AND ORDER_SEQ = '" + s_order_seq + "') ");

							GauceStatement gstmt = null;
							gstmt = conn.getGauceStatement(sql2.toString());
							gstmt.executeUpdate();
							gstmt.close();

						}

						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTLOADLST  ")
										 .append("		SET ARTC_CNT			= ?, \n")
										 .append("				PUNIT_CNT			= ?, \n")
										 .append("				PUNIT_WEIGHT	= ?, \n")
										 .append("				PKG_LNGTH			= ?, \n")
										 .append("				PKG_HEIGHT		= ?, \n")
										 .append(" 				PKG_WIDTH			= ?, \n")
										 .append(" 				TOTAL_CBM			= ?, \n")
										 .append(" 				TOTAL_WEIGHT	= ?, \n")
										 .append("				STS_CODE			= ?, \n")
										 .append("				UPEND_DT			= substr(char(current date),1,4)|| substr(char(current date),6,2)|| substr(char(current date),9,2), \n")
										 .append("				UPEND_TIME		= substr(char(current time),1,2)||substr(char(current time),4,2), \n")
										 .append("				REMARK				= ?, \n")
										 .append("				BAECHA_NO			= ?, \n")
										 .append("				ENTER_NO			= ?, \n")
										 .append("				CAR_NO				= ?, \n")
										 .append("				UPDATE_DT			= CURRENT TIMESTAMP, \n")
										 .append("				UPDATE_UST		= ?, \n")
										 .append("				PKG_CNT				= ? \n")
										 .append("	WHERE CAR_SEQ_NO		= ? \n")
										 .append("		AND ORDER_NO			= ? \n")
										 .append("		AND ORDER_SEQ			= ? ") ; 

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 
						
						gsmt.bindColumn(1, idxARTC_CNT  );
						gsmt.bindColumn(2, idxPUNIT_CNT  );
						gsmt.bindColumn(3, idxPUNIT_WEIGHT  );
						gsmt.bindColumn(4, idxPKG_LNGTH  );
						gsmt.bindColumn(5, idxPKG_HEIGHT );
						gsmt.bindColumn(6, idxPKG_WIDTH );						 
						gsmt.bindColumn(7, idxTOTAL_CBM );
						gsmt.bindColumn(8, idxTOTAL_WEIGHT );
						gsmt.bindColumn(9, idxSTS_CODE );
						gsmt.bindColumn(10, idxREMARK );
						gsmt.bindColumn(11, idxBAECHA_NO );
						gsmt.bindColumn(12, idxENTER_NO );
						gsmt.bindColumn(13, idxCAR_NO ); 
						gsmt.bindColumn(14, idxUPDATE_UST );
						gsmt.bindColumn(15, idxPKG_CNT ); 
						gsmt.bindColumn(16, idxCAR_SEQ_NO  );
						gsmt.bindColumn(17, idxORDER_NO  );
						gsmt.bindColumn(18, idxORDER_SEQ  );
						gsmt.executeUpdate(); 
						gsmt.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						int iparm2 = rows[j].getInt(idxORG_CNT);

						//재고정보 유무 검색
						sql = new StringBuffer();
						sql.append(" SELECT IFNULL(MAX(STOCK_SEQ),0) CNT \n")
							 .append("   FROM TRANSFER.LTORDSTOCK \n")
							 .append("  WHERE ORDER_NO = '" + s_order_no + "' \n")
							 .append("    AND ORDER_SEQ = '" + s_order_seq + "'");

						Statement stmt = null;
						ResultSet rs = null;
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						
						int icnt = 0;
						while (rs.next())	{
							icnt = rs.getInt(1);
						}

						stmt.close();
						rs.close();

						int iartc = 0;
						if (icnt>0)	{
							StringBuffer sql2 = new StringBuffer();
							sql2.append(" INSERT INTO TRANSFER.LTORDSTOCK \n")
									.append("		( ORDER_NO, ORDER_SEQ, STOCK_SEQ, ETD_DT, LINE_PART, \n")
									.append("		  CARGO_TYPE, DLVL_TYPE, ARTC_CD, ARTC_NM, OD_ARTCCNT, \n")
									.append("		  OD_ARTCUNT, OD_UNTPRCE, OD_PRICE, OD_LDCARGO, OD_LDCRGNM, \n")
									.append("		  OD_OFCARGO, OD_OFCRGNM, OD_PUNTCNT, OD_PUNTUNT, OD_PUNTWGT, \n")
									.append("		  OD_PKGLNGT, OD_PKGHEGT, OD_PKGWIDT, OD_PKGCBM, OD_PKGCNT, \n")
									.append("		  ENTER_DATE, ENTER_NO, EN_ARTCCNT, EN_PUNTCNT, EN_PUNTWGT, \n")
									.append("		  EN_PKGLNGT, EN_PKGHEGT, EN_PKGWIDT, EN_PKGCBM, EN_TOTCBM, \n")
									.append("		  EN_TOTWGT, EN_PKGCNT, UPEND_DT, LD_ARTCCNT, LD_PUNTCNT, \n")
									.append("		  LD_PUNTWGT, LD_PKGLNGT, LD_PKGHEGT, LD_PKGWIDT, LD_TOTCBM, \n")
									.append("		  LD_TOTWGT, LD_PKGCNT, ST_ARTCCNT, ST_PUNTCNT, ST_PUNTWGT, \n")
									.append("		  ST_PKGLNGT, ST_PKGHEGT, ST_PKGWIDT, ST_TOTCBM, ST_TOTWGT, \n")
									.append("		  ST_PKGCNT, ORDER_STS, STOCK_STS, CREATE_DT, CREATE_USR, \n")
									.append("		  UPDATE_DT, UPDATE_USR \n")
									.append("		) SELECT '" + s_order_no + "', '" + s_order_seq + "', STOCK_SEQ+1, ETD_DT, LINE_PART, \n")
									.append("				  CARGO_TYPE, DLVL_TYPE, ARTC_CD, ARTC_NM, OD_ARTCCNT, \n")
									.append("				  OD_ARTCUNT, OD_UNTPRCE, OD_PRICE, OD_LDCARGO, OD_LDCRGNM, \n") 
									.append("				  OD_OFCARGO, OD_OFCRGNM, OD_PUNTCNT, OD_PUNTUNT, OD_PUNTWGT, \n")
									.append("				  OD_PKGLNGT, OD_PKGHEGT, OD_PKGWIDT, OD_PKGCBM, OD_PKGCNT, \n")
									.append("				  ENTER_DATE, ENTER_NO, EN_ARTCCNT, EN_PUNTCNT, EN_PUNTWGT, \n")
									.append("				  EN_PKGLNGT, EN_PKGHEGT, EN_PKGWIDT, EN_PKGCBM, EN_TOTCBM, \n")
									.append("				  EN_TOTWGT, EN_PKGCNT, UPEND_DT, LD_ARTCCNT, LD_PUNTCNT, \n")
									.append("				  LD_PUNTWGT, LD_PKGLNGT, LD_PKGHEGT, LD_PKGWIDT, LD_TOTCBM, \n")
									.append("				  LD_TOTWGT, LD_PKGCNT, " + iparm2 + ", ST_PUNTCNT, ST_PUNTWGT, \n")
									.append("				  ST_PKGLNGT, ST_PKGHEGT, ST_PKGWIDT, ST_TOTCBM, ST_TOTWGT, \n")
									.append("				  ST_PKGCNT, ORDER_STS, STOCK_STS, CREATE_DT, CREATE_USR, \n")
									.append("				  UPDATE_DT, UPDATE_USR \n")
									.append("			  FROM TRANSFER.LTORDSTOCK \n")
									.append("			 WHERE ORDER_NO = '" + s_order_no + "' \n")
									.append("			   AND ORDER_SEQ = '" + s_order_seq + "' ")
									.append("			   AND STOCK_SEQ = (SELECT MAX(INTEGER(STOCK_SEQ)) \n")
									.append("														FROM TRANSFER.LTORDSTOCK \n")
									.append("													 WHERE ORDER_NO = '" + s_order_no + "' \n")
									.append("														 AND ORDER_SEQ = '" + s_order_seq + "') ");

							GauceStatement gstmt = null;
							gstmt = conn.getGauceStatement(sql2.toString());
							gstmt.executeUpdate();
							gstmt.close();

						}

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTLOADLST \n")
										 .append( "	 WHERE CAR_SEQ_NO		= ? \n")
										 .append( "		 AND ORDER_NO			= ? \n")
										 .append( "		 AND ORDER_SEQ			= ? ");

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCAR_SEQ_NO  );
						gsmt.bindColumn(2, idxORDER_NO  );
						gsmt.bindColumn(3, idxORDER_SEQ  );
						gsmt.executeUpdate();
						gsmt.close();
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
			if (gsmt != null) {	try {	gsmt.close();	}	catch (Exception e) {}}
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
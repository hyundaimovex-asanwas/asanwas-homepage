package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00104_edi_t1 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
	  GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 
		GauceStatement gsmt2 = null ; 
		GauceStatement gsmt3 = null ; 
		GauceStatement gsmt4 = null ; 

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			String strcnt1 =""; 
			String strcnt2 =""; 
			String strcnt3 =""; 
			String strcnt4 =""; 

			String strEDI_STS = "";
			String strING_STS = "";
      String strTYPE="";
			
			try {
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				conn.setAutoCommit(false);

//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String porder_no = reqGauce.getParameter("gstr1"); 
   			if ( porder_no==null || porder_no.trim().length()==0 ) { porder_no=null; }
				logger.dbg.println(this,"STEP-1");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet1 = reqGauce.getGauceDataSet("USER1");   //주문MST
        int idxETD_DT_1      = userSet1.indexOfColumn("ETD_DT");     //반출일자
				int idxORDER_NO_1    = userSet1.indexOfColumn("ORDER_NO");   //주문번호
				int idxEDI_STS_1     = userSet1.indexOfColumn("EDI_STS");    //EDI 전송 상태 N-미전송, S-전송 후 택배에서 미수신, R-전송 후 택배에서 수신
				int idxING_STS_1     = userSet1.indexOfColumn("ING_STS");    //주문배정 
				int idxEDI_USR_1     = userSet1.indexOfColumn("EDI_USR");    //사용자 

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");   //주문DTL
        int idxETD_DT_2      = userSet2.indexOfColumn("ETD_DT");     //반출일자
				int idxORDER_NO_2    = userSet2.indexOfColumn("ORDER_NO");   //주문번호
				int idxORDER_SEQ_2   = userSet2.indexOfColumn("ORDER_SEQ");  //주문번호 상세
				int idxEDI_STS_2     = userSet2.indexOfColumn("EDI_STS");    //EDI 전송 상태 N-미전송, S-전송 후 택배에서 미수신, R-전송 후 택배에서 수신
				int idxING_STS_2     = userSet2.indexOfColumn("ING_STS");    //주문배정 
				int idxEDI_USR_2     = userSet2.indexOfColumn("EDI_USR");    //사용자 

				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");   //배정MST
        int idxETD_DT_3      = userSet3.indexOfColumn("ETD_DT");     //반출일자
				int idxCAR_SEQ_NO_3  = userSet3.indexOfColumn("CAR_SEQ_NO"); //배정번호
				int idxEDI_STS_3     = userSet3.indexOfColumn("EDI_STS");    //EDI 전송 상태 N-미전송, S-전송 후 택배에서 미수신, R-전송 후 택배에서 수신
				int idxING_STS_3     = userSet3.indexOfColumn("ING_STS");    //주문배정 
				int idxEDI_USR_3     = userSet3.indexOfColumn("EDI_USR");    //사용자 

				GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");   //배정DTL
				int idxETD_DT_4      = userSet4.indexOfColumn("ETD_DT");     //반출일자
				int idxCAR_SEQ_NO_4  = userSet4.indexOfColumn("CAR_SEQ_NO"); //배정번호
				int idxORDER_NO_4    = userSet4.indexOfColumn("ORDER_NO");   //주문번호
				int idxORDER_SEQ_4   = userSet4.indexOfColumn("ORDER_SEQ");  //주문번호 상세
				int idxEDI_STS_4     = userSet4.indexOfColumn("EDI_STS");    //EDI 전송 상태 N-미전송, S-전송 후 택배에서 미수신, R-전송 후 택배에서 수신
				int idxING_STS_4     = userSet4.indexOfColumn("ING_STS");    //주문배정 데이터 상태  I-신규, U-수정, C-취소 
				int idxEDI_USR_4     = userSet4.indexOfColumn("EDI_USR");    //사용자 

				GauceDataRow[] rows1 = userSet1.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();
				GauceDataRow[] rows3 = userSet3.getDataRows();
				GauceDataRow[] rows4 = userSet4.getDataRows();

				StringBuffer sql1 = null;
				StringBuffer InsertSql1 = null;
				StringBuffer UpdateSql1 = null;
				StringBuffer DeleteSql1 = null;
				Statement stmt1 = null;
				ResultSet rs1 = null;

				StringBuffer sql2 = null;
				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;
 			  Statement stmt2 = null;
				ResultSet rs2 = null;

				StringBuffer sql3 = null;
				StringBuffer InsertSql3 = null;
				StringBuffer UpdateSql3 = null;
				StringBuffer DeleteSql3 = null;

 			  Statement stmt3 = null;
				ResultSet rs3 = null;

				StringBuffer sql4 = null;
				StringBuffer InsertSql4 = null;
				StringBuffer UpdateSql4 = null;
				StringBuffer DeleteSql4 = null;
 			  Statement stmt4 = null;
				ResultSet rs4 = null;

				strTYPE="A";     //A-주문배정, B-배차, C-입고, D-상차
				strEDI_STS ="S"; //S-전송, R-수신		
     
		    logger.dbg.println(this,"STEP-2");
		    /**********************************************************************************************
        1.주문 MST
				***********************************************************************************************/ 

        for (int j = 0; j < rows1.length; j++){
					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            
						logger.dbg.println(this,"STEP-3::주문MST");
						strcnt1="";
      			sql1 = new StringBuffer();
					  stmt1 = conn.createStatement();
						
						//공용DB 주문 MST 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
						sql1.append(" SELECT COUNT(ORDER_NO) FROM HDASAN_EDI.ETORDERMST  ") 
						    .append("  WHERE ORDER_NO = '"+rows1[j].getString(idxORDER_NO_1)+"'"); 
						logger.dbg.println(this,sql1.toString());
        
						rs1 = stmt1.executeQuery(sql1.toString()); 
						if(rs1.next()){
							 strcnt1= rs1.getString(1);
						}
						rs1.close();
 					  stmt1.close();

						if(strcnt1.equals("0")){ //신규 - 전송 주문 MST	
							strEDI_STS ="S";
							if (rows1[j].getString(idxING_STS_1).equals("")) rows1[j].setString(idxING_STS_1,"I");
							//strING_STS ="I";
							logger.dbg.println(this,"STEP-4::주문MST::신규");
						}else{
							//0이 아닐 경우 EDI_STS를 확인 하여 재전송 구분한다.
							sql1 = new StringBuffer();
							stmt1 = conn.createStatement();
							
							//공용DB 주문 MST 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
							sql1.append(" SELECT EDI_STS FROM HDASAN_EDI.ETORDERMST  ") 
								  .append("  WHERE ORDER_NO = '"+rows1[j].getString(idxORDER_NO_1)+"'"); 
							logger.dbg.println(this,sql1.toString());
					
							rs1 = stmt1.executeQuery(sql1.toString()); 
							if(rs1.next()){
								 strEDI_STS= rs1.getString(1);
							}
							rs1.close();
							stmt1.close();

							if(strEDI_STS.equals("Y")){          //전송완료 일경우  재전송함.
                 strEDI_STS = "A" ; 							 						 
							}else if (strEDI_STS.equals("A")){
                 strEDI_STS = "A" ; 
							}else{
                 strEDI_STS = "S" ;
								 if (rows1[j].getString(idxING_STS_1).equals("")) rows1[j].setString(idxING_STS_1,"I");
							}

							logger.dbg.println(this,"STEP-4::주문MST::삭제");

							//재전송건의 경우는 항상 삭제 후 INSERT 한다.//////////////////////
							DeleteSql1 = new StringBuffer();
							DeleteSql1.append( " DELETE FROM HDASAN_EDI.ETORDERMST " );
							DeleteSql1.append( "  WHERE ORDER_NO = ? " );
							gsmt = conn.getGauceStatement(DeleteSql1.toString());
							gsmt.setGauceDataRow(rows1[j]);
							gsmt.bindColumn(1, idxORDER_NO_1);
							gsmt.executeUpdate();
							gsmt.close();
							//////////////////////////////////////////////////////////////////
						}
             
            logger.dbg.println(this,"STEP-5::주문MST::생성");
            //rows1[j].setString(idxEDI_STS_1,strEDI_STS);
						//rows1[j].setSting(idxING_STS_1,strING_STS);

            ///////////////////////////////////////////////////////////////////////////////////////////
						// 주문 MST 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						InsertSql1 = new StringBuffer();
						InsertSql1.append( " INSERT INTO HDASAN_EDI.ETORDERMST  (  " );
						InsertSql1.append( " ORDER_NO,    IN_OUT,      ORDER_STS,   ETD_DT,        LINE_PART,             \n" );
						InsertSql1.append( " PROJECT,     CUST_CD,     CUST_PRSN,   CUST_TELNO,    CARGO_TYPE,            \n" );
						InsertSql1.append( " DLVL_TYPE,   DIV_IO,      DLVL_DATE,   SHIPPER,       SHIPPERPS,             \n" );
						InsertSql1.append( " SHIPPERTEL,  ETA_DT,      ORDER_DATE,  FEE_IN,        FEE_OUT,               \n" );
						InsertSql1.append( " GORDER_NO,   RQST_NO,     PL_TYPE,     PL_SHIPPER,    PL_SHPPRNM,            \n" );
						InsertSql1.append( " PL_SHIPADDR, PL_SHIPTEL,  PL_CSTM,     PL_CSTMNM,     PL_CSTADDR,            \n" );
						InsertSql1.append( " PL_CSTTEL,   PL_BRKR,     PL_BRKRNM,   PL_BRKADDR,    PL_BRKTEL,             \n" );
						InsertSql1.append( " RPST_GOODS,  TOTAL_CNT,   TOTAL_UNIT,  TOTAL_WGHT,    TOTAL_CBM,             \n" );
						InsertSql1.append( " CANCLE_DATE, REMARK,      PRICETYPE,   SETTLETYPE,    LC_NO,                 \n" );
						InsertSql1.append( " LC_DATE,     LC_BANK,     EXPRT_NO,    EXPRT_DATE,    LDCARGO,               \n" );
						InsertSql1.append( " LDCARGONM,   OFFCARGO,    OFFCARGONM,  CONSIGNEE,     CUST_HPNO,             \n" );
						InsertSql1.append( " SHIPPERHP,   PL_SHPADDR2, PL_SHPADDR3, PL_CSTADDR2,   PL_CSTADDR3,           \n" );
						InsertSql1.append( " PL_BRKADDR2, PL_BRKADDR3, PL_NO,       PL_DATE,       PL_CSN,                \n" );
						InsertSql1.append( " PL_CSNNM,    PL_CSNTEL,   PL_CSNADDR,  PL_CSNADDR2,   PL_CSNADDR3,           \n" );
						InsertSql1.append( " ETD_DT1,     FAC_PERSON,  FAC_PRSTEL,  ATT_FILENM,    OBJ_REMK,              \n" );
						InsertSql1.append( " RECIPIENT,   RECP_OWN,    RECP_TEL,    RECP_ADD,      CREATE_DT,             \n" );
						InsertSql1.append( " CREATE_USR,  UPDATE_DT,   UPDATE_USR,  EDI_STS,       ING_STS ,              \n" );
						InsertSql1.append( " EDI_USR,     EDI_DT,      SHIP_ADD1,   SHIP_ADD2,     SHIPPER_NM             \n" );
						InsertSql1.append( " ) \n" );
						InsertSql1.append( " SELECT  \n" );
						InsertSql1.append( " A.ORDER_NO,    A.IN_OUT,      A.ORDER_STS,   A.ETD_DT,        A.LINE_PART,       \n" );
						InsertSql1.append( " A.PROJECT,     A.CUST_CD,     A.CUST_PRSN,   A.CUST_TELNO,    A.CARGO_TYPE,      \n" );
						InsertSql1.append( " A.DLVL_TYPE,   A.DIV_IO,      A.DLVL_DATE,   A.SHIPPER,       A.SHIPPERPS,       \n" );
						InsertSql1.append( " A.SHIPPERTEL,  A.ETA_DT,      A.ORDER_DATE,  A.FEE_IN,        A.FEE_OUT,         \n" );
						InsertSql1.append( " A.GORDER_NO,   A.RQST_NO,     A.PL_TYPE,     A.PL_SHIPPER,    A.PL_SHPPRNM,      \n" );
						InsertSql1.append( " A.PL_SHIPADDR, A.PL_SHIPTEL,  A.PL_CSTM,     A.PL_CSTMNM,     A.PL_CSTADDR,      \n" );
						InsertSql1.append( " A.PL_CSTTEL,   A.PL_BRKR,     A.PL_BRKRNM,   A.PL_BRKADDR,    A.PL_BRKTEL,       \n" );
						InsertSql1.append( " A.RPST_GOODS,  A.TOTAL_CNT,   A.TOTAL_UNIT,  A.TOTAL_WGHT,    A.TOTAL_CBM,       \n" );
						InsertSql1.append( " A.CANCLE_DATE, A.REMARK,      A.PRICETYPE,   A.SETTLETYPE,    A.LC_NO,           \n" );
						InsertSql1.append( " A.LC_DATE,     A.LC_BANK,     A.EXPRT_NO,    A.EXPRT_DATE,    A.LDCARGO,         \n" );
						InsertSql1.append( " A.LDCARGONM,   A.OFFCARGO,    A.OFFCARGONM,  A.CONSIGNEE,     A.CUST_HPNO,       \n" );
						InsertSql1.append( " A.SHIPPERHP,   A.PL_SHPADDR2, A.PL_SHPADDR3, A.PL_CSTADDR2,   A.PL_CSTADDR3,     \n" );
						InsertSql1.append( " A.PL_BRKADDR2, A.PL_BRKADDR3, A.PL_NO,       A.PL_DATE,       A.PL_CSN,          \n" );
						InsertSql1.append( " A.PL_CSNNM,    A.PL_CSNTEL,   A.PL_CSNADDR,  A.PL_CSNADDR2,   A.PL_CSNADDR3,     \n" );
						InsertSql1.append( " A.ETD_DT1,     A.FAC_PERSON,  A.FAC_PRSTEL,  A.ATT_FILENM,    A.OBJ_REMK,        \n" );
						InsertSql1.append( " A.RECIPIENT,   A.RECP_OWN,    A.RECP_TEL,    A.RECP_ADD,      A.CREATE_DT,       \n" );
						InsertSql1.append( " A.CREATE_USR,  A.UPDATE_DT,   A.UPDATE_USR,  '"+strEDI_STS+"', '"+rows1[j].getString(idxING_STS_1)+"',  \n" );
						InsertSql1.append( " '"+rows1[j].getString(idxEDI_USR_1)+"', CURRENT TIMESTAMP , B.ADDRESS1, B.ADDRESS2,    RTRIM(B.VEND_NM) \n" );
						InsertSql1.append( " FROM TRANSFER.LTORDERMST A \n" );
						InsertSql1.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON B.VEND_CD =SHIPPER \n" );
						InsertSql1.append( " WHERE ORDER_NO=?  \n" );

						logger.dbg.println(this, InsertSql1.toString());
						gsmt = conn.getGauceStatement(InsertSql1.toString());
						gsmt.setGauceDataRow(rows1[j]);

						gsmt.bindColumn(1, idxORDER_NO_1);

						gsmt.executeUpdate();
						gsmt.close();

            ///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						/****
						logger.dbg.println(this,"STEP-6::주문MST::LOG");
            InsertSql1 = new StringBuffer();
						InsertSql1.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
						InsertSql1.append( " ORDER_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
						InsertSql1.append( " VALUES ( ?, '"+strTYPE+"', '"+strEDI_STS+"',?, CURRENT TIMESTAMP, ? ) \n" );
				
						logger.dbg.println(this, InsertSql1.toString());
						gsmt = conn.getGauceStatement(InsertSql1.toString());
						gsmt.setGauceDataRow(rows1[j]);
					
						gsmt.bindColumn(1, idxORDER_NO_1);
						gsmt.bindColumn(2, idxING_STS_1);
						gsmt.bindColumn(3, idxEDI_USR_1);
						gsmt.executeUpdate();
						gsmt.close();     
						****/
					}//if
				}//for

        /**********************************************************************************************
        2.주문 DTL
				***********************************************************************************************/
				for (int j = 0; j < rows2.length; j++){
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						logger.dbg.println(this,"STEP-7::주문DTL::");
						strcnt2 ="";
						sql2 = new StringBuffer();
					  stmt2 = conn.createStatement();			
						//공용 주문 DTL 조회 (없으면 모두 INSERT , 존재하면 선별하여 INSERT/UPDATE 
						sql2.append(" SELECT COUNT(*) FROM HDASAN_EDI.ETORDERDTL ") 
						    .append("  WHERE ORDER_NO = '"+rows2[j].getString(idxORDER_NO_2)+"'") 
						    .append("    AND ORDER_SEQ= '"+rows2[j].getString(idxORDER_SEQ_2)+"'"); 
						logger.dbg.println(this,sql2.toString());      
						rs2 = stmt2.executeQuery(sql2.toString()); 
						if(rs2.next()){
							 strcnt2= rs2.getString(1);
						}
						rs2.close();
						stmt2.close();

						logger.dbg.println(this,"strcnt2::::"+strcnt2);
						if(strcnt2.equals("0")){ //신규 - 전송 주문 Dtl	
							strEDI_STS ="S";
							strING_STS ="I";
							logger.dbg.println(this,"STEP-8::주문DTL::신규");
						}else{ // 재전송

						  //0이 아닐 경우 EDI_STS를 확인 하여 재전송 구분한다.
							sql2 = new StringBuffer();
							stmt2 = conn.createStatement(); 
							//공용DB 주문 DTL 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
							sql2.append(" SELECT EDI_STS FROM HDASAN_EDI.ETORDERDTL  ") 
								  .append("  WHERE ORDER_NO = '"+rows2[j].getString(idxORDER_NO_2)+"'") 
						      .append("    AND ORDER_SEQ= '"+rows2[j].getString(idxORDER_SEQ_2)+"'"); 
							logger.dbg.println(this,sql2.toString());
					
							rs2 = stmt2.executeQuery(sql2.toString()); 
							if(rs2.next()){
								 strEDI_STS= rs2.getString(1);
							}
							rs2.close();
							stmt2.close();

							if(strEDI_STS.equals("Y")){          //전송완료 일경우  재전송함.
                 strEDI_STS = "A" ; 
							}else if (strEDI_STS.equals("A")){
                 strEDI_STS = "A" ; 
							}else{
                 strEDI_STS = "S" ;

							}  

							logger.dbg.println(this,"STEP-8::주문DTL::삭제");

							//재전송건의 경우는 항상 삭제 후 INSERT 한다.//////////////////////
							DeleteSql2 = new StringBuffer();
							DeleteSql2.append( " DELETE FROM HDASAN_EDI.ETORDERDTL " )
							          .append( "  WHERE ORDER_NO = ? " )
							          .append("     AND ORDER_SEQ= ? " ); 
							gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
							gsmt2.setGauceDataRow(rows2[j]);
							gsmt2.bindColumn(1, idxORDER_NO_2);
							gsmt2.bindColumn(2, idxORDER_SEQ_2);
							gsmt2.executeUpdate();
							gsmt2.close();
							//////////////////////////////////////////////////////////////////
						}

						logger.dbg.println(this,"STEP-9::주문DTL::생성");

            ///////////////////////////////////////////////////////////////////////////////////////////
						// 주문 DTL 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO HDASAN_EDI.ETORDERDTL  (  " );
						InsertSql2.append( " ORDER_NO,	 ORDER_SEQ,   ARTC_CD,	  ARTC_NM,	  STN_SZ,	     \n" );
						InsertSql2.append( " STN_SZNM,	 HSCODE,	    ARTC_CNT,	  ARTC_UNIT,	UNIT_PRICE,	 \n" );
						InsertSql2.append( " PRICE,	     LDCARGO,	    LDCARGONM,	OFFCARGO,	  OFFCARGONM,	 \n" );
						InsertSql2.append( " PUNIT_CNT,  PUNIT_UNIT,	PUNIT_WGHT,	PKG_LNGTH,	PKG_HEIGHT,	 \n" );
						InsertSql2.append( " PKG_WIDTH,  PKG_CBM,	    PKG_CNT,	  MIX_OTHERS,	SAMEAS,	     \n" );
						InsertSql2.append( " CANCLE_STS, CANCLE_DT,	  AUTH_NO,	  ORDER_STS,	SETTLE_STS,	 \n" );
						InsertSql2.append( " CUR_CODE,	 VIN_CODE,	  FR_UNTPRCE,	FR_PRICE,	  ENG_ARTCNM,	 \n" );
						InsertSql2.append( " ETD_DT,	   CREATE_DT,	  CREATE_USR,	UPDATE_DT,	UPDATE_USR,	 \n" );
						InsertSql2.append( " EDI_STS,	   ING_STS,	    EDI_USR,	  EDI_DT	                 \n" );
						InsertSql2.append( " ) \n" );
						InsertSql2.append( " SELECT  \n" );
						InsertSql2.append( " ORDER_NO,	 ORDER_SEQ,   ARTC_CD,	  ARTC_NM,	  STN_SZ,	     \n" );
						InsertSql2.append( " STN_SZNM,	 HSCODE,	    ARTC_CNT,	  ARTC_UNIT,	UNIT_PRICE,	 \n" );
						InsertSql2.append( " PRICE,	     LDCARGO,	    LDCARGONM,	OFFCARGO,	  OFFCARGONM,	 \n" );
						InsertSql2.append( " PUNIT_CNT,  PUNIT_UNIT,	PUNIT_WGHT,	PKG_LNGTH,	PKG_HEIGHT,	 \n" );
						InsertSql2.append( " PKG_WIDTH,  PKG_CBM,	    PKG_CNT,	  MIX_OTHERS,	SAMEAS,	     \n" );
						InsertSql2.append( " CANCLE_STS, CANCLE_DT,	  AUTH_NO,	  ORDER_STS,	SETTLE_STS,	 \n" );
						InsertSql2.append( " CUR_CODE,	 VIN_CODE,	  FR_UNTPRCE,	FR_PRICE,	  ENG_ARTCNM,	 \n" );
						InsertSql2.append( " ETD_DT,	   CREATE_DT,	  CREATE_USR,	UPDATE_DT,	UPDATE_USR,	 \n" );
						InsertSql2.append( " '"+strEDI_STS+"','"+rows2[j].getString(idxING_STS_2)+"',	 '"+rows2[j].getString(idxEDI_USR_2)+"' ,	CURRENT TIMESTAMP        \n" );
						InsertSql2.append( "  FROM TRANSFER.LTORDERDTL \n" );
						InsertSql2.append( " WHERE ORDER_NO=?  \n" );
						InsertSql2.append( "   AND ORDER_SEQ=?  \n" );
						
						logger.dbg.println(this, InsertSql2.toString());
						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
					
						gsmt2.bindColumn(1, idxORDER_NO_2);
						gsmt2.bindColumn(2, idxORDER_SEQ_2);
						gsmt2.executeUpdate();
						gsmt2.close();

						logger.dbg.println(this,"STEP-10::주문DTL::UPDATE");
     
						//주문상세 EDI_STS에도 'S','A' 넣어줌.
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE TRANSFER.LTORDERDTL  SET  EDI_STS ='"+strEDI_STS+"' \n" );
						UpdateSql2.append( " WHERE ORDER_NO=?  \n" );
						UpdateSql2.append( "   AND ORDER_SEQ=?  \n" );

						logger.dbg.println(this, UpdateSql2.toString());
						gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
					
						gsmt2.bindColumn(1, idxORDER_NO_2);
						gsmt2.bindColumn(2, idxORDER_SEQ_2);
						gsmt2.executeUpdate();
						gsmt2.close();     
					}// if
				} //for

        /**********************************************************************************************
        3.배정 MST
				***********************************************************************************************/
				for (int j = 0; j < rows3.length; j++){
					if(rows3[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						logger.dbg.println(this,"STEP-11::배정MST::");
						strcnt3="";
      			sql3 = new StringBuffer();
					  stmt3 = conn.createStatement();
						
						//공용DB 주문 MST 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
						sql3.append(" SELECT COUNT(ORDER_NO) FROM HDASAN_EDI.ETORDCAR  ") 
						    .append("  WHERE CAR_SEQ_NO = '"+rows3[j].getString(idxCAR_SEQ_NO_3)+"'"); 
						logger.dbg.println(this,sql3.toString());
        
						rs3 = stmt3.executeQuery(sql3.toString()); 
						if(rs3.next()){
							 strcnt3= rs3.getString(1);
						}
						rs3.close();
 					  stmt3.close();

						if(strcnt3.equals("0")){ //신규 - 전송 주문 MST	
							strEDI_STS ="S";
							if (rows3[j].getString(idxING_STS_3).equals("")) rows3[j].setString(idxING_STS_3,"I"); 
							//strING_STS ="I";
							logger.dbg.println(this,"STEP-11::배정MST::신규");
						}else{
							//0이 아닐 경우 EDI_STS를 확인 하여 재전송 구분한다.
							sql3 = new StringBuffer();
							stmt3 = conn.createStatement();
							
							//공용DB 주문 MST 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
							sql3.append(" SELECT EDI_STS FROM HDASAN_EDI.ETORDCAR  ") 
								  .append("  WHERE CAR_SEQ_NO = '"+rows3[j].getString(idxCAR_SEQ_NO_3)+"'"); 
							logger.dbg.println(this,sql1.toString());
					
							rs3 = stmt3.executeQuery(sql3.toString()); 
							if(rs3.next()){
								 strEDI_STS= rs3.getString(1);
							}
							rs3.close();
							stmt3.close();

							if(strEDI_STS.equals("Y")){          //전송완료 일경우  재전송함.
                 strEDI_STS = "A" ; 
							}else if (strEDI_STS.equals("A")){
                 strEDI_STS = "A" ; 
							}else{
                 strEDI_STS = "S" ;
								 if (rows3[j].getString(idxING_STS_3).equals("")) rows3[j].setString(idxING_STS_3,"I"); 
							}
							
							logger.dbg.println(this,"STEP-11::배정MST::삭제");
							//재전송건의 경우는 항상 삭제 후 INSERT 한다.////////////////////////////////////////////
							DeleteSql3 = new StringBuffer();
							DeleteSql3.append( " DELETE FROM HDASAN_EDI.ETORDCAR " );
							DeleteSql3.append( "  WHERE CAR_SEQ_NO = ? " );
							gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
							gsmt3.setGauceDataRow(rows3[j]);
							gsmt3.bindColumn(1, idxCAR_SEQ_NO_3);
							gsmt3.executeUpdate();
							gsmt3.close();
							/////////////////////////////////////////////////////////////////////////////////////////
						}

						logger.dbg.println(this,"STEP-12::배정MST::생성");

            ///////////////////////////////////////////////////////////////////////////////////////////
						// 배정 MST 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO HDASAN_EDI.ETORDCAR  (                               \n" );
						InsertSql3.append( " CAR_SEQ_NO,	ORDER_NO,	  LINE_PART,	CARTYPENO,	 CAR_CNT,	      \n" );
						InsertSql3.append( " LD_CARGO,	  LD_CARGONM,	OFF_CARGO,	OFF_CARGONM, CUST_CD,	      \n" );
						InsertSql3.append( " CUST_NAME,	  CUST_PS,	  CUST_TEL,	  LD_DATE,	   PERSON_NO,	    \n" );
						InsertSql3.append( " CAR_TYPE,	  REMARK,	    CTN_STDRD,	EDT_DATE,	   IN_OUT,	      \n" );
						InsertSql3.append( " CREATE_DT,	  CREATE_USR,	UPDATE_DT,	UPDATE_USR,	                \n" );
						InsertSql3.append( " EDI_STS,	    ING_STS,	  EDI_USR,	  EDI_DT	                    \n" );
						InsertSql3.append( "  ) \n" );
						InsertSql3.append( " SELECT  \n" );
						InsertSql3.append( " CAR_SEQ_NO,	ORDER_NO,	  LINE_PART,	CARTYPENO,	 CAR_CNT,	      \n" );
						InsertSql3.append( " LD_CARGO,	  LD_CARGONM,	OFF_CARGO,	OFF_CARGONM, CUST_CD,	      \n" );
						InsertSql3.append( " CUST_NAME,	  CUST_PS,	  CUST_TEL,	  LD_DATE,	   PERSON_NO,	    \n" );
						InsertSql3.append( " CAR_TYPE,	  REMARK,	    CTN_STDRD,	EDT_DATE,	   IN_OUT,	      \n" );
						InsertSql3.append( " CREATE_DT,	  CREATE_USR,	UPDATE_DT,	UPDATE_USR,	                \n" );
						InsertSql3.append( " '"+strEDI_STS+"','"+rows3[j].getString(idxING_STS_3)+"','"+rows3[j].getString(idxEDI_USR_3)+"',CURRENT TIMESTAMP \n" );
						InsertSql3.append( " FROM TRANSFER.LTORDCAR                                           \n" );
						InsertSql3.append( " WHERE CAR_SEQ_NO=?         \n" );
						
						logger.dbg.println(this, InsertSql3.toString());
						gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows3[j]);
					
						gsmt3.bindColumn(1, idxCAR_SEQ_NO_3);
						gsmt3.executeUpdate();
						gsmt3.close();
					} //if
				}//for

        /**********************************************************************************************
        4.배정 DTL
				***********************************************************************************************/
				for (int j = 0; j < rows4.length; j++){
					if(rows4[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						logger.dbg.println(this,"STEP-13::배정DTL::");
						strcnt4 ="";
						sql4 = new StringBuffer();
					  stmt4 = conn.createStatement();			
						
						//공용 배정 상세 조회 (없으면 모두 INSERT , 존재하면 선별하여 INSERT/UPDATE 
						sql4.append(" SELECT COUNT(*) FROM HDASAN_EDI.ETCARGOODS ") 
						    .append("  WHERE ORDER_NO = '"+rows4[j].getString(idxORDER_NO_4)+"'") 
						    .append("    AND CAR_SEQ_NO= '"+rows4[j].getString(idxCAR_SEQ_NO_4)+"'")
						    .append("    AND ORDER_SEQ= '"+rows4[j].getString(idxORDER_SEQ_4)+"'"); 

						logger.dbg.println(this,sql4.toString());
        
						rs4 = stmt4.executeQuery(sql4.toString()); 
						if(rs4.next()){
							 strcnt4= rs4.getString(1);
						}
						rs4.close();
						stmt4.close();

						logger.dbg.println(this,"strcnt4::::"+strcnt4);

						if(strcnt4.equals("0")){ //신규 - 전송 배정 Dtl	
							strEDI_STS ="S";
							strING_STS ="I";
							if (rows4[j].getString(idxING_STS_4).equals("")) rows4[j].setString(idxING_STS_4,"I");
							logger.dbg.println(this,"STEP-14::배정DTL::신규");
						}else{ // 재전송
						  //0이 아닐 경우 EDI_STS를 확인 하여 재전송 구분한다.
							sql4 = new StringBuffer();
							stmt4 = conn.createStatement(); 
							//공용DB 주문 DTL 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
							sql4.append(" SELECT EDI_STS FROM HDASAN_EDI.ETCARGOODS  ") 
								  .append("  WHERE ORDER_NO = '"+rows4[j].getString(idxORDER_NO_4)+"'") 
									.append("    AND CAR_SEQ_NO= '"+rows4[j].getString(idxCAR_SEQ_NO_4)+"'")
									.append("    AND ORDER_SEQ= '"+rows4[j].getString(idxORDER_SEQ_4)+"'"); 
							logger.dbg.println(this,sql4.toString());
					
							rs4 = stmt4.executeQuery(sql4.toString()); 
							if(rs4.next()){
								 strEDI_STS= rs4.getString(1);
							}
							rs4.close();
							stmt4.close();

							if(strEDI_STS.equals("Y")){          //전송완료 일경우  재전송함.
                 strEDI_STS = "A" ; 
							}else if (strEDI_STS.equals("A")){
                 strEDI_STS = "A" ; 
							}else{
                 strEDI_STS = "S" ;
								 if (rows4[j].getString(idxING_STS_4).equals("")) rows4[j].setString(idxING_STS_4,"I");
							}  

							logger.dbg.println(this,"STEP-14::배정DTL::삭제");

							//재전송건의 경우는 항상 삭제 후 INSERT 한다.//////////////////////
							DeleteSql4 = new StringBuffer();
							DeleteSql4.append( " DELETE FROM HDASAN_EDI.ETCARGOODS " )
							          .append( "  WHERE ORDER_NO = ? " )
								        .append( "    AND CAR_SEQ_NO = ? " )
							          .append("     AND ORDER_SEQ= ? " ); 
							gsmt4 = conn.getGauceStatement(DeleteSql4.toString());
							gsmt4.setGauceDataRow(rows4[j]);
							gsmt4.bindColumn(1, idxORDER_NO_4);
							gsmt4.bindColumn(2, idxCAR_SEQ_NO_4);
							gsmt4.bindColumn(3, idxORDER_SEQ_4);
							gsmt4.executeUpdate();
							gsmt4.close();
							//////////////////////////////////////////////////////////////////
						}

						logger.dbg.println(this,"STEP-15::배정DTL::생성");
						
						InsertSql4 = new StringBuffer();
						InsertSql4.append( " INSERT INTO HDASAN_EDI.ETCARGOODS  (                        \n" );
						InsertSql4.append( " ORDER_NO,  	CAR_SEQ_NO,	ORDER_SEQ,	ARTC_CNT,	ARTC_UNIT,	 \n" );
						InsertSql4.append( " PKG_CNT,	    PKG_UNIT,	  PKG_WGHT,	  PKG_CBM,	CREATE_DT,	 \n" );
						InsertSql4.append( " CREATE_USR,	UPDATE_DT,	UPDATE_USR,	                     	 \n" );
						InsertSql4.append( " EDI_STS,	    ING_STS,	  EDI_USR,	  EDI_DT	             	 \n" );
						InsertSql4.append( " )                                                           \n" );
						InsertSql4.append( " SELECT                                                      \n" );
						InsertSql4.append( " ORDER_NO,  	CAR_SEQ_NO,	ORDER_SEQ,	ARTC_CNT,	ARTC_UNIT,	 \n" );
						InsertSql4.append( " PKG_CNT,	    PKG_UNIT,	  PKG_WGHT,	  PKG_CBM,	CREATE_DT,	 \n" );
						InsertSql4.append( " CREATE_USR,	UPDATE_DT,	UPDATE_USR,	                     	 \n" );
						InsertSql4.append( " '"+strEDI_STS+"','"+rows4[j].getString(idxING_STS_4)+"','"+rows4[j].getString(idxEDI_USR_4)+"',CURRENT TIMESTAMP \n" );
						InsertSql4.append( "  FROM TRANSFER.LTCARGOODS \n" );
						InsertSql4.append( " WHERE ORDER_NO=?    \n" );
						InsertSql4.append( "   AND CAR_SEQ_NO=?  \n" );
						InsertSql4.append( "   AND ORDER_SEQ=?   \n" );
						
						logger.dbg.println(this, InsertSql4.toString());
						gsmt4 = conn.getGauceStatement(InsertSql4.toString());
						gsmt4.setGauceDataRow(rows4[j]);
					
						gsmt4.bindColumn(1, idxORDER_NO_4);
						gsmt4.bindColumn(2, idxCAR_SEQ_NO_4);
						gsmt4.bindColumn(3, idxORDER_SEQ_4);
						gsmt4.executeUpdate();
						gsmt4.close();

  					///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						logger.dbg.println(this,"STEP-99::::LOG");

            InsertSql4 = new StringBuffer();
						InsertSql4.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
						InsertSql4.append( " ORDER_NO, ORDER_SEQ, CAR_SEQ_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
						InsertSql4.append( " VALUES ( ?,?,?, '"+strTYPE+"', '"+strEDI_STS+"',?, CURRENT TIMESTAMP, ? ) \n" );
				
						logger.dbg.println(this, InsertSql4.toString());
						gsmt = conn.getGauceStatement(InsertSql4.toString());
						gsmt.setGauceDataRow(rows4[j]);
											
						gsmt.bindColumn(1, idxORDER_NO_4);
						gsmt.bindColumn(2, idxORDER_SEQ_4);
						gsmt.bindColumn(3, idxCAR_SEQ_NO_4);
						gsmt.bindColumn(4, idxING_STS_4);
						gsmt.bindColumn(5, idxEDI_USR_4);
						gsmt.executeUpdate();
						gsmt.close();     

					}//if
				}//for
			}
		catch(SQLException se){
		  conn.rollback();
			resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
			logger.err.println(this,se.toString());		
		}
      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
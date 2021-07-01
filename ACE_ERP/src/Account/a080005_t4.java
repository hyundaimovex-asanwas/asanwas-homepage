package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080005_t4 extends HttpServlet{
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

      try {
        conn = service.getDBConnection();
        reqGauce = service.getGauceRequest();
        resGauce = service.getGauceResponse();

        GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

        String[] StrArrCN = new String[] {
          "CHK"      ,"BGTRQNO" ,"FDCODE"   ,"BGTYY"    ,"BGTMM"   ,
          "BGTDIV"   ,"BGTDPT"  ,"ATCODE"   ,"FSREFCD"  ,"SATCODE" ,
          "BGTRQST"  ,"ATKORNAM","SATNAM"   ,"DEPTNM"   ,"BGTRQDIV",
          "BGTRQAMT" ,"M_ATCODE","M_FSREFCD","M_SATCODE","BGTFRMON",
          "P_BGTDEPT","P_BGTDIV","DEPTNM2"  ,"EMPNMK"   ,"BGTRQSEQ"
        };
        int[] idx = new int[25];
        for(int i=0;i<StrArrCN.length;i++) {
          idx[i] = userSet.indexOfColumn(StrArrCN[i]);
        }

        GauceDataRow[] rows = userSet.getDataRows();

        StringBuffer UpdateSql1 = null;//BGTRQMST  상태값변경
        StringBuffer UpdateSql2 = null;//BGTRQDTL1 상태값변경
        StringBuffer UpdateSql3 = null;//BGTMST
        StringBuffer UpdateSql4 = null;//BGTDTL
        StringBuffer UpdateSql4_1 = null;
        StringBuffer DeleteSql1 = null;//BGTMST
        StringBuffer DeleteSql2 = null;//BGTDTL

        logger.dbg.println(this,"rows.length :1: "+rows.length);
        for (int j = 0; j < rows.length; j++){
          if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            if(rows[j].getString(idx[0]).equals("T")){
              /*******************************************************************
                BGTRQMST UPDATE 
              ********************************************************************/
              UpdateSql1 = new StringBuffer();
              UpdateSql1.append( " UPDATE ACCOUNT.BGTRQMST SET										\n");
              UpdateSql1.append( "		BGTRQST   = 'C'	/*신청서구분*/							\n");
              UpdateSql1.append( " WHERE FDCODE = '"+rows[j].getString(idx[2])+"'			\n");
              UpdateSql1.append( " AND  BGTRQNO = '"+rows[j].getString(idx[1])+"'			\n");

              GauceStatement gsmt = conn.getGauceStatement(UpdateSql1.toString());

              gsmt.setGauceDataRow(rows[j]);
              gsmt.executeUpdate();
              gsmt.close();
              UpdateSql1 = null;

              /*******************************************************************
                  BGTRQMST UPDATE 
              ********************************************************************/
              UpdateSql2 = new StringBuffer();
              UpdateSql2.append( " UPDATE ACCOUNT.BGTRQDTL1 SET										\n");
              UpdateSql2.append( "		BGTRQST =  'C'	/*신청서구분*/							\n");
              UpdateSql2.append( " WHERE FDCODE = '"+rows[j].getString(idx[2])+"'	\n");
              UpdateSql2.append( " AND  BGTRQNO = '"+rows[j].getString(idx[1])+"'	\n");
              UpdateSql2.append( " AND  BGTRQSEQ = '"+rows[j].getString(idx[24])+"'	\n");

              GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
              gsmt2.setGauceDataRow(rows[j]);
              gsmt2.executeUpdate();
              gsmt2.close();
              UpdateSql2 = null;


              if(rows[j].getString(idx[14]).equals("01")){
                /*******************************************************************
                    BGTMST 
                ********************************************************************/

                int minbgt = 0;
                StringBuffer sql = new StringBuffer();
                sql.append( " SELECT ADDBGT,REALBGT,REALBGT-ADDBGT AS MINBGT      \n")
                   .append( "	FROM ACCOUNT.BGTMST                                 \n")
                   .append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n")
                   .append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n")
                   .append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n")
                   .append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n")
                   .append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n")
                   .append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n")
                   .append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n")
                   .append( "	AND BGTMACT = '01'                                  \n");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql.toString());

                if(rs.next()){
                  minbgt = rs.getInt(3);
                }

                stmt.close();
                rs.close();

                if(minbgt==0){
                  /*******************************************************************
                      BGTMST DELETE 
                  ********************************************************************/
                  DeleteSql1 = new StringBuffer();
                  DeleteSql1.append( " DELETE FROM ACCOUNT.BGTMST                           \n");
                  DeleteSql1.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n");
                  DeleteSql1.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n");
                  DeleteSql1.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n");
                  DeleteSql1.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n");
                  DeleteSql1.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n");
                  DeleteSql1.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n");
                  DeleteSql1.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n");
                  DeleteSql1.append( "	AND BGTMACT = '01'                                  \n");

                  GauceStatement gsmt3 = conn.getGauceStatement(DeleteSql1.toString());
                  gsmt3.setGauceDataRow(rows[j]);
                  gsmt3.executeUpdate();
                  gsmt3.close();
                  DeleteSql1 = null;
                }else{
                  /*******************************************************************
                      BGTMST UPDATE 
                  ********************************************************************/
                  UpdateSql3 = new StringBuffer();
                  UpdateSql3.append( " UPDATE ACCOUNT.BGTMST SET                            \n");
                  UpdateSql3.append( "		REALBGT =  REALBGT-ADDBGT, ADDBGT = 0             \n");
                  UpdateSql3.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n");
                  UpdateSql3.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n");
                  UpdateSql3.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n");
                  UpdateSql3.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n");
                  UpdateSql3.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n");
                  UpdateSql3.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n");
                  UpdateSql3.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n");
                  UpdateSql3.append( "	AND BGTMACT = '01'                                  \n");

                  GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
                  gsmt3.setGauceDataRow(rows[j]);
                  gsmt3.executeUpdate();
                  gsmt3.close();
                  UpdateSql3 = null;
                }

                /*******************************************************************
                    BGTDTL 
                ********************************************************************/

                int minbgt2 = 0;
                StringBuffer sql2 = new StringBuffer();
                sql2.append( " SELECT ADDBGT,REALBGT,REALBGT-ADDBGT AS MINBGT       \n")
                   .append( " FROM ACCOUNT.BGTDTL                                   \n")
                   .append( " WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'    \n")
                   .append( " AND BGTYY = '" + rows[j].getString(idx[3]) + "'       \n")
                   .append( " AND BGTMM = '" + rows[j].getString(idx[4]) + "'       \n")
                   .append( " AND BGTDIV = '" + rows[j].getString(idx[5]) + "'      \n")
                   .append( " AND BGTDPT = '" + rows[j].getString(idx[6]) + "'      \n")
                   .append( " AND ATCODE = '" + rows[j].getString(idx[7]) + "'      \n")
                   .append( " AND FSREFCD = '" + rows[j].getString(idx[8]) + "'     \n")
                   .append( " AND SATCODE = '" + rows[j].getString(idx[9]) + "'     \n")
                   .append( " AND BGTMACT = '01'                                    \n");

                Statement stmt2 = conn.createStatement();
                ResultSet rs2 = stmt2.executeQuery(sql2.toString());

                rs2.next();
                minbgt2 = rs2.getInt(3);
                logger.dbg.println(this,"minbgt2 :9: "+minbgt2);

                stmt2.close();
                rs2.close();

                if(minbgt2==0){
                  /*******************************************************************
                      BGTMST DELETE 
                  ********************************************************************/
                  DeleteSql2 = new StringBuffer();
                  DeleteSql2.append( " DELETE FROM ACCOUNT.BGTDTL										\n");
                  DeleteSql2.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                  DeleteSql2.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                  DeleteSql2.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                  DeleteSql2.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                  DeleteSql2.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                  DeleteSql2.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                  DeleteSql2.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                  DeleteSql2.append( "	AND BGTMACT = '01'                                \n");

                  GauceStatement gsmt4 = conn.getGauceStatement(DeleteSql2.toString());
                  gsmt4.setGauceDataRow(rows[j]);
                  gsmt4.executeUpdate();
                  gsmt4.close();
                  DeleteSql2 = null;
                }else{
                  /*******************************************************************
                      BGTMST UPDATE 
                  ********************************************************************/
                  UpdateSql4 = new StringBuffer();
                  UpdateSql4.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                  UpdateSql4.append( "		REALBGT =  REALBGT-ADDBGT, ADDBGT = 0 \n");
                  UpdateSql4.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                  UpdateSql4.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                  UpdateSql4.append( "	AND BGTMM = '" + rows[j].getString(idx[4]) + "' \n");
                  UpdateSql4.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                  UpdateSql4.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                  UpdateSql4.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                  UpdateSql4.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                  UpdateSql4.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                  UpdateSql4.append( "	AND BGTMACT = '01'                                \n");

                  GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql4.toString());
                  gsmt4.setGauceDataRow(rows[j]);
                  gsmt4.executeUpdate();
                  gsmt4.close();
                  UpdateSql4 = null;
                }
              }
              if(rows[j].getString(idx[14]).equals("02")){

                /*******************************************************************
                    BGTDTL 
                ********************************************************************/

                int minbgt2 = 0;
                StringBuffer sql2 = new StringBuffer();
                sql2.append( " SELECT CHGTBGT,REALBGT,REALBGT-CHGTBGT AS MINBGT       \n")
                   .append( " FROM ACCOUNT.BGTDTL                                   \n")
                   .append( " WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'    \n")
                   .append( " AND BGTYY = '" + rows[j].getString(idx[3]) + "'       \n")
                   .append( " AND BGTMM = '" + rows[j].getString(idx[19]) + "'       \n")
                   .append( " AND BGTDIV = '" + rows[j].getString(idx[5]) + "'      \n")
                   .append( " AND BGTDPT = '" + rows[j].getString(idx[6]) + "'      \n")
                   .append( " AND ATCODE = '" + rows[j].getString(idx[7]) + "'      \n")
                   .append( " AND FSREFCD = '" + rows[j].getString(idx[8]) + "'     \n")
                   .append( " AND SATCODE = '" + rows[j].getString(idx[9]) + "'     \n")
                   .append( " AND BGTMACT = '01'                                    \n");

                Statement stmt2 = conn.createStatement();
                ResultSet rs2 = stmt2.executeQuery(sql2.toString());

                rs2.next();
                minbgt2 = rs2.getInt(3);
                logger.dbg.println(this,"minbgt2 :17: "+minbgt2);

                stmt2.close();
                rs2.close();

                if(minbgt2==0){
                  /*******************************************************************
                      BGTMST DELETE 
                  ********************************************************************/
                  DeleteSql2 = new StringBuffer();
                  DeleteSql2.append( " DELETE FROM ACCOUNT.BGTDTL										\n");
                  DeleteSql2.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                  DeleteSql2.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                  DeleteSql2.append( "  AND BGTMM = '" + rows[j].getString(idx[19]) + "'       \n");
                  DeleteSql2.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                  DeleteSql2.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                  DeleteSql2.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                  DeleteSql2.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                  DeleteSql2.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                  DeleteSql2.append( "	AND BGTMACT = '01'                                \n");

                  GauceStatement gsmt4 = conn.getGauceStatement(DeleteSql2.toString());
                  gsmt4.setGauceDataRow(rows[j]);
                  gsmt4.executeUpdate();
                  gsmt4.close();
                  DeleteSql2 = null;
                }else{
                  /*******************************************************************
                      BGTDTL UPDATE 
                  ********************************************************************/
                  UpdateSql4 = new StringBuffer();
                  UpdateSql4.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                  UpdateSql4.append( "		REALBGT =  REALBGT-CHGTBGT, CHGTBGT = 0 \n");
                  UpdateSql4.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                  UpdateSql4.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                  UpdateSql4.append( "	AND BGTMM = '" + rows[j].getString(idx[19]) + "' \n");
                  UpdateSql4.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                  UpdateSql4.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                  UpdateSql4.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                  UpdateSql4.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                  UpdateSql4.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                  UpdateSql4.append( "	AND BGTMACT = '01'                                \n");

                  GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql4.toString());
                  gsmt4.setGauceDataRow(rows[j]);
                  gsmt4.executeUpdate();
                  gsmt4.close();
                  UpdateSql4 = null;
                }


                /*******************************************************************
                    BGTDTL2 UPDATE 
                ********************************************************************/
                UpdateSql4_1 = new StringBuffer();
                UpdateSql4_1.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                UpdateSql4_1.append( "		REALBGT =  REALBGT+"+rows[j].getString(idx[15])+", CHGTBGT = 0 \n");
                UpdateSql4_1.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                UpdateSql4_1.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                UpdateSql4_1.append( "	AND BGTMM = '" + rows[j].getString(idx[4]) + "' \n");
                UpdateSql4_1.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                UpdateSql4_1.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                UpdateSql4_1.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                UpdateSql4_1.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                UpdateSql4_1.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                UpdateSql4_1.append( "	AND BGTMACT = '01'                                \n");

                GauceStatement gsmt4_1 = conn.getGauceStatement(UpdateSql4_1.toString());
                gsmt4_1.setGauceDataRow(rows[j]);
                gsmt4_1.executeUpdate();
                gsmt4_1.close();
                UpdateSql4_1 = null;


              }
              if(rows[j].getString(idx[14]).equals("03")){
                /*******************************************************************
                    BGTMST 
                ********************************************************************/

                int minbgt = 0;
                StringBuffer sql = new StringBuffer();
                sql.append( " SELECT CHGABGT,REALBGT,REALBGT-CHGABGT AS MINBGT      \n")
                   .append( "	FROM ACCOUNT.BGTMST                                 \n")
                   .append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n")
                   .append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n")
                   .append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n")
                   .append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n")
                   .append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n")
                   .append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n")
                   .append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n")
                   .append( "	AND BGTMACT = '01'                                  \n");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql.toString());

                if(rs.next()){
                  minbgt = rs.getInt(3);
                }
                logger.dbg.println(this,"minbgt :21: "+minbgt);

                stmt.close();
                rs.close();


                  /*******************************************************************
                      BGTMST DELETE 
                  ********************************************************************/


                  /*******************************************************************
                      BGTMST UPDATE 
                  ********************************************************************/
                  UpdateSql3 = new StringBuffer();
                  UpdateSql3.append( " UPDATE ACCOUNT.BGTMST SET                            \n");
                  UpdateSql3.append( "		REALBGT =  REALBGT-CHGABGT, CHGABGT = 0             \n");
                  UpdateSql3.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n");
                  UpdateSql3.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n");
                  UpdateSql3.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n");
                  UpdateSql3.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n");
                  UpdateSql3.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n");
                  UpdateSql3.append( "	-- AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n");
                  UpdateSql3.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n");
                  UpdateSql3.append( "	AND BGTMACT = '01'                                  \n");

                  GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
                  gsmt3.setGauceDataRow(rows[j]);
                  gsmt3.executeUpdate();
                  gsmt3.close();
                  UpdateSql3 = null;


                  /*******************************************************************
                      BGTMST UPDATE 
                 ********************************************************************/
                  UpdateSql4 = new StringBuffer();
                  UpdateSql4.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                  UpdateSql4.append( "		REALBGT =  REALBGT-CHGABGT, CHGABGT = 0 \n");
                  UpdateSql4.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                  UpdateSql4.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                  UpdateSql4.append( "	AND BGTMM = '" + rows[j].getString(idx[4]) + "' \n");
                  UpdateSql4.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                  UpdateSql4.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                  UpdateSql4.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                  UpdateSql4.append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                  UpdateSql4.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                  UpdateSql4.append( "	AND BGTMACT = '01'                                \n");
                  logger.dbg.println(this,"UpdateSql4 :30: "+UpdateSql4.toString());

                  GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql4.toString());
                  gsmt4.setGauceDataRow(rows[j]);
                  gsmt4.executeUpdate();
                  gsmt4.close();
                  UpdateSql4 = null;




                String strDVTFRACT = "";
                String strDVTFRSATCD = "";
                StringBuffer sql2_1 = new StringBuffer();
                sql2_1.append( " SELECT DVTFRACT,DVTFRSATCD       					\n")
                   .append( " FROM ACCOUNT.BGTRQDTL1                                   \n")
                   .append( " WHERE FDCODE = '"+rows[j].getString(idx[2])+"'		\n")
                   .append( " AND  BGTRQNO = '"+rows[j].getString(idx[1])+"'			\n")
                   .append( " AND  BGTRQSEQ = '"+rows[j].getString(idx[24])+"'		\n");

                Statement stmt2_1 = conn.createStatement();

                ResultSet rs2_1 = stmt2_1.executeQuery(sql2_1.toString());

                if(rs2_1.next()){
                  strDVTFRACT = rs2_1.getString(1);
                  strDVTFRSATCD = rs2_1.getString(2);
                }


                stmt2_1.close();
                rs2_1.close();

                /*******************************************************************
                    BGTMST UPDATE 
                ********************************************************************/
                UpdateSql4_1 = new StringBuffer();
                UpdateSql4_1.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                UpdateSql4_1.append( "		REALBGT =  REALBGT-"+rows[j].getString(idx[15])+", CHGABGT = 0 \n");
                UpdateSql4_1.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                UpdateSql4_1.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                UpdateSql4_1.append( "	AND BGTMM = '" + rows[j].getString(idx[4]) + "' \n");
                UpdateSql4_1.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                UpdateSql4_1.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                UpdateSql4_1.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                UpdateSql4_1.append( "	--AND FSREFCD = '" + strDVTFRACT + "' \n");
                UpdateSql4_1.append( "	AND SATCODE = '" + strDVTFRSATCD + "' \n");
                UpdateSql4_1.append( "	AND BGTMACT = '01'                                \n");

                GauceStatement gsmt4_1 = conn.getGauceStatement(UpdateSql4_1.toString());
                gsmt4_1.setGauceDataRow(rows[j]);
                gsmt4_1.executeUpdate();
                gsmt4_1.close();
                UpdateSql4_1 = null;

              }
              if(rows[j].getString(idx[14]).equals("04")){
                /*******************************************************************
                    BGTMST 
                ********************************************************************/

                int minbgt = 0;
                StringBuffer sql = new StringBuffer();
                sql.append( " SELECT DEPTBGT,REALBGT,REALBGT-DEPTBGT AS MINBGT      \n")
                   .append( "	FROM ACCOUNT.BGTMST                                 \n")
                   .append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n")
                   .append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n")
                   .append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n")
                   .append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n")
                   .append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n")
                   .append( "	AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n")
                   .append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n")
                   .append( "	AND BGTMACT = '01'                                  \n");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql.toString());


                if(rs.next()){
                  minbgt = rs.getInt(3);
                }


                stmt.close();
                rs.close();

                  /*******************************************************************
                      BGTMST DELETE 
                  ********************************************************************/

                  /*******************************************************************
                      BGTMST UPDATE 
                  ********************************************************************/
                  UpdateSql3 = new StringBuffer();
                  UpdateSql3.append( " UPDATE ACCOUNT.BGTMST SET                            \n");
                  UpdateSql3.append( "		REALBGT =  REALBGT+DEPTBGT            \n");
                  UpdateSql3.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'  \n");
                  UpdateSql3.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "'     \n");
                  UpdateSql3.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "'    \n");
                  UpdateSql3.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "'    \n");
                  UpdateSql3.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "'    \n");
                  UpdateSql3.append( "	--AND FSREFCD = '" + rows[j].getString(idx[8]) + "'   \n");
                  UpdateSql3.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "'   \n");
                  UpdateSql3.append( "	AND BGTMACT = '01'                                  \n");
                  logger.dbg.println(this,"UpdateSql3 :36: "+UpdateSql3.toString());

                  GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
                  gsmt3.setGauceDataRow(rows[j]);
                  gsmt3.executeUpdate();
                  gsmt3.close();
                  UpdateSql3 = null;


                /*******************************************************************
                    BGTDTL 
                ********************************************************************/

                int minbgt2 = 0;
                StringBuffer sql2 = new StringBuffer();
                sql2.append( " SELECT DEPTBGT,REALBGT,REALBGT-DEPTBGT AS MINBGT       \n")
                   .append( " FROM ACCOUNT.BGTDTL                                   \n")
                   .append( " WHERE FDCODE = '" + rows[j].getString(idx[2]) + "'    \n")
                   .append( " AND BGTYY = '" + rows[j].getString(idx[3]) + "'       \n")
                   .append( " AND BGTMM = '" + rows[j].getString(idx[4]) + "'       \n")
                   .append( " AND BGTDIV = '" + rows[j].getString(idx[5]) + "'      \n")
                   .append( " AND BGTDPT = '" + rows[j].getString(idx[6]) + "'      \n")
                   .append( " AND ATCODE = '" + rows[j].getString(idx[7]) + "'      \n")
                   .append( " --AND FSREFCD = '" + rows[j].getString(idx[8]) + "'     \n")
                   .append( " AND SATCODE = '" + rows[j].getString(idx[9]) + "'     \n")
                   .append( " AND BGTMACT = '01'                                    \n");


                Statement stmt2 = conn.createStatement();
                ResultSet rs2 = stmt2.executeQuery(sql2.toString());

                if(rs2.next()){
                  minbgt2 = rs2.getInt(3);
                }


                stmt2.close();
                rs2.close();


                  /*******************************************************************
                      BGTMST DELETE 
                  ********************************************************************/

                  /*******************************************************************
                      BGTMST UPDATE 
                  ********************************************************************/
                  UpdateSql4 = new StringBuffer();
                  UpdateSql4.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                  UpdateSql4.append( "		REALBGT =  REALBGT+"+rows[j].getString(idx[15])+" \n");
                  UpdateSql4.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                  UpdateSql4.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' \n");
                  UpdateSql4.append( "	AND BGTMM = '" + rows[j].getString(idx[4]) + "' \n");
                  UpdateSql4.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' \n");
                  UpdateSql4.append( "	AND BGTDPT = '" + rows[j].getString(idx[6]) + "' \n");
                  UpdateSql4.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' \n");
                  UpdateSql4.append( "	--AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                  UpdateSql4.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' \n");
                  UpdateSql4.append( "	AND BGTMACT = '01'                                \n");

                  GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql4.toString());
                  gsmt4.setGauceDataRow(rows[j]);
                  gsmt4.executeUpdate();
                  gsmt4.close();
                  UpdateSql4 = null;


                String strBGTFRDEPT = "";
                StringBuffer sql2_1 = new StringBuffer();
                sql2_1.append( " SELECT BGTFRDEPT      \n")
                   .append( " FROM ACCOUNT.BGTRQDTL1                                   \n")
                   .append( " WHERE FDCODE = '"+rows[j].getString(idx[2])+"'	\n")
                   .append( " AND  BGTRQNO = '"+rows[j].getString(idx[1])+"'	\n")
                   .append( " AND  BGTRQSEQ = '"+rows[j].getString(idx[24])+"'	\n");


                Statement stmt2_1 = conn.createStatement();

                ResultSet rs2_1 = stmt2_1.executeQuery(sql2_1.toString());

                if(rs2_1.next()){
                  strBGTFRDEPT = rs2_1.getString(1);
                }


                stmt2_1.close();
                rs2_1.close();

                /*******************************************************************
                    BGTMST UPDATE 
                ********************************************************************/
                UpdateSql4_1 = new StringBuffer();
                UpdateSql4_1.append( " UPDATE ACCOUNT.BGTDTL SET 										\n");
                UpdateSql4_1.append( "		REALBGT =  REALBGT-"+rows[j].getString(idx[15])+", DEPTBGT = 0 \n");
                UpdateSql4_1.append( "	WHERE FDCODE = '" + rows[j].getString(idx[2]) + "' \n");
                UpdateSql4_1.append( "	AND BGTYY = '" + rows[j].getString(idx[3]) + "' 		\n");
                UpdateSql4_1.append( "	AND BGTMM = '" + rows[j].getString(idx[4]) + "' 		\n");
                UpdateSql4_1.append( "	AND BGTDIV = '" + rows[j].getString(idx[5]) + "' 		\n");
                UpdateSql4_1.append( "	AND BGTDPT = '" + strBGTFRDEPT + "' 					\n");
                UpdateSql4_1.append( "	AND ATCODE = '" + rows[j].getString(idx[7]) + "' 		\n");
                UpdateSql4_1.append( "	--AND FSREFCD = '" + rows[j].getString(idx[8]) + "' \n");
                UpdateSql4_1.append( "	AND SATCODE = '" + rows[j].getString(idx[9]) + "' 	\n");
                UpdateSql4_1.append( "	AND BGTMACT = '01'                                			\n");

                GauceStatement gsmt4_1 = conn.getGauceStatement(UpdateSql4_1.toString());
                gsmt4_1.setGauceDataRow(rows[j]);
                gsmt4_1.executeUpdate();
                gsmt4_1.close();
                UpdateSql4_1 = null;
              }
            }
          }
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
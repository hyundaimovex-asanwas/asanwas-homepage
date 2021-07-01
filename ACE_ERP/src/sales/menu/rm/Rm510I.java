package sales.menu.rm;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Rm510I extends SuperServlet {


    public void makeSql(){
      /**
       * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
       **/
       String iParamEmpno = fParamEmpno;
       String iParamIp = fParamIp;

       for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();
      //블럭상태
      arr_sql[0].append ("SELECT                              \n")
                .append ("   '' DETAIL, '전체' DETAIL_NM    \n")
                .append ("FROM SYSIBM.SYSDUMMY1                       \n")
                .append ("UNION ALL                                   \n")
                .append ("SELECT                 \n")
                .append ("      DETAIL,                 \n")
                .append ("      DETAIL DETAIL_NM                 \n")
                .append ("FROM SALES.TSY010            \n")
                .append ("WHERE HEAD    =  'RM010'      \n")
                .append ("   AND DETAIL  >  ' '                  \n")
                .append ("   AND ITEM1   =  'Y'                  \n");

      //객실타입
      arr_sql[11].append (" SELECT                                                     \n") 
			     .append ("        ROOM_TYPE_SID,                                      \n") 
			     .append ("        ROOM_TYPE_CD,                                       \n") 
			     .append ("        ROOM_TYPE_NM,                                       \n") 
			     .append ("        T1.UPJANG_SID,                                      \n") 
			     .append ("        STD_PERSONS,                                        \n") 
			     .append ("        T2.UPJANG_NM,                                       \n") 
			     .append ("        T1.DISPLAY_SEQ                                      \n") 
			     .append ("  FROM  SALES.TRM030 T1                                     \n") 
			     .append ("        JOIN SALES.TRM010 T2 ON T1.UPJANG_SID=T2.UPJANG_SID \n") 
			     .append ("  WHERE T1.USE_YN = 'Y'                                     \n") 
			     .append ("  ORDER BY DISPLAY_SEQ                                      \n");


      //상품정보
      arr_sql[12].append ("SELECT GOODS_SID, GOODS_CD, GOODS_NM      \n")
                 .append ("FROM SALES.TRM200                         \n")
                 .append ("WHERE 1=1 AND USE_YN='Y'                  \n");

   }

   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      //StringUtil.printMsg("# Command","선조회",this);

      /* DataSet */
      GauceDataSet ds1 = null;
      GauceStatement stmt = null;
      ResultSet rs = null;
      ResultSetMetaData rsmd = null;
      String[] columnName = null;

      int v_rowcnt = 0;

      int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

      try{
         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();

            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               switch(dsType){
                  case 1:
                     res.enableFirstRow(ds1);
                     if(gauceName.equals("DS3")){         //객실타입
                        //StringUtil.printMsg("arr_sql[11]",arr_sql[11].toString(),this);
                        stmt = conn.getGauceStatement(arr_sql[11].toString());
                     }
                     if(gauceName.equals("DS4")){         //블록상태
                        //StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
                        stmt = conn.getGauceStatement(arr_sql[0].toString());
                     }
                     if(gauceName.equals("DS5")){         //상품정보
                        //StringUtil.printMsg("arr_sql[12]",arr_sql[12].toString(),this);
                        stmt = conn.getGauceStatement(arr_sql[12].toString());
                     }
                        rs = stmt.executeQuery(); // DataSet set
                        rsmd = rs.getMetaData();
                        columnName = new String[rsmd.getColumnCount()];
                        for(int i=0; i<columnName.length; i++){
                           columnName[i] = rsmd.getColumnName(i+1);
                           if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
                              ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
                           else
                              ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
                        }
                           while ( rs.next()) {
                              GauceDataRow row = ds1.newDataRow();

                              for(int i=0; i<columnName.length; i++) {
                                 if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
                                    row.addColumnValue(rs.getInt(columnName[i]));
                                 else
                                    row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
                              }

                              ds1.addDataRow(row);
                                  v_rowcnt++ ;
                              //StringUtil.printMsg("count",v_rowcnt,this);
                           }//End of while
                           if(rs!=null) rs.close();
                           if(stmt!=null) stmt.close();
                     ds1.flush();
                     break;
               }
            }
         }
      } catch (SQLException sqle){
         res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
         throw sqle;
      } catch (Exception e) {
         res.writeException("ERROR", "", e.toString());
         throw e;
      } finally {
         if(rs!=null) rs.close();
         if(stmt!=null) stmt.close();
      }

   }

   // 조회 method
   public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      /*****************************************************************************
       * Gauce Object 설정
       *****************************************************************************/
      //StringUtil.printMsg("# Command","조회",this);

      /* DataBase */
      GauceDataSet ds1 = null;
      CallableStatement cstmt = null;
      GauceStatement stmt = null;
      ResultSet rs = null;
      ResultSetMetaData rsmd = null;
      String[] columnName = null;
      try {
         // 검색시 조건
         String    sBgnDate   = HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
         String    sEndDate   = HDUtil.nullCheckStr(req.getParameter("sEndDate"));
         String    sBlockStatusCd   = HDUtil.nullCheckStr(req.getParameter("sBlockStatusCd"));
         String    sMBlockSid   = HDUtil.nullCheckStr(req.getParameter("sMBlockSid"));
         String    sClientSid   = HDUtil.nullCheckStr(req.getParameter("sClientSid"));
         String    sAcceptBgnDate   = HDUtil.nullCheckStr(req.getParameter("sAcceptBgnDate"));
         String    sAcceptEndDate   = HDUtil.nullCheckStr(req.getParameter("sAcceptEndDate"));

         //StringUtil.printMsg("sBgnDate",sBgnDate,this);
         //StringUtil.printMsg("sEndDate",sEndDate,this);
         //StringUtil.printMsg("sBlockStatusCd",sBlockStatusCd,this);
         //StringUtil.printMsg("sMBlockSid",sMBlockSid,this);
         //StringUtil.printMsg("sClientSid",sClientSid,this);
         //StringUtil.printMsg("sAcceptBgnDate",sAcceptBgnDate,this);
         //StringUtil.printMsg("sAcceptEndDate",sAcceptEndDate,this);

         // dataset 구분 param
         int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

         Iterator it = req.getGauceDataSetKeys();
         while(it.hasNext()){
            String gauceName = (String)it.next();
            ds1 = req.getGauceDataSet(gauceName);

            if(ds1!=null){
               switch(dsType){
                  case 1:
                     int sCnt1 = 1;
                     res.enableFirstRow(ds1);
                     if ( gauceName.equals("DEFAULT")) {
                        //StringUtil.printMsg("call","SALES.PR_RM510I_01",this);
                        cstmt = conn.prepareCall("{call SALES.PR_RM510I_01(?, ?, ?, ?, ?, ?) }");
                        cstmt.setString(1, sBgnDate);
                        cstmt.setString(2, sEndDate);
                        cstmt.setInt(3, Integer.parseInt(sClientSid));
                        cstmt.setString(4, sBlockStatusCd);
                        cstmt.setString(5, sAcceptBgnDate);
                        cstmt.setString(6, sAcceptEndDate);
                     }

                     if ( gauceName.equals("DS2")) {
                        //StringUtil.printMsg("call","SALES.PR_RM510I_02",this);
                        cstmt = conn.prepareCall("{call SALES.PR_RM510I_02(?) }");
                        //StringUtil.printMsg("Integer.parseInt(sMBlockSid)",Integer.parseInt(sMBlockSid),this);
                        cstmt.setInt(1, Integer.parseInt(sMBlockSid));
                     }
                     rs = cstmt.executeQuery(); // DataSet set
                     rsmd = rs.getMetaData();

                     columnName = new String[rsmd.getColumnCount()];
                     for(int i=0; i<columnName.length; i++){
                        columnName[i] = rsmd.getColumnName(i+1);
                        if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
                           ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
                        else
                           ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
                     }
                     while ( rs.next()) {
                        GauceDataRow row = ds1.newDataRow();
                        for(int i=0; i<columnName.length; i++) {
                           if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
                              row.addColumnValue(rs.getInt(columnName[i]));
                           else
                              row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
                        }
                        ds1.addDataRow(row);
                     }//End of while
                     if(rs!=null) rs.close();
                     if(cstmt!=null) cstmt.close();

                     //StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
                     break;
               }
            }
            ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
         }
      } catch (SQLException sqle){
         res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
         throw sqle;
      } catch (Exception e) {
         res.writeException("ERROR", "", e.toString());
         throw e;
      } finally {
         if(rs!=null) rs.close();
         if(stmt!=null) stmt.close();
         if(cstmt!=null) cstmt.close();
      }
   }

   /**
    * 기능 :
    * @param req
    * @param res
    * @param dsNum = 1
    *
    */
   public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
      GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
      GauceDataSet inputDs2 = req.getGauceDataSet("DS2");
      CallableStatement cstmt = null;
      GauceDataSet blockNoDS = req.getGauceDataSet("blockNoDS");
      GauceDataSet blockSidDS = req.getGauceDataSet("blockSidDS");
      GauceDataSet msgDS = req.getGauceDataSet("msgDS");
      int mBlockSid=0;
      ResultSet rs = null;
      boolean fail=false;

      /**
       * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
       **/
      String iParamEmpno = fParamEmpno;
      String iParamIp = fParamIp;
      try{
         inner: {
         if(inputDs!=null){

            int colNm_MBlockSid    = inputDs.indexOfColumn("M_BLOCK_SID");
            int colNm_BlockNo    = inputDs.indexOfColumn("BLOCK_NO");
            int colNm_GoodsSid    = inputDs.indexOfColumn("GOODS_SID");
            int colNm_DepartDate    = inputDs.indexOfColumn("DEPART_DATE");
            int colNm_ClientSid    = inputDs.indexOfColumn("CLIENT_SID");
            int colNm_GroupNm    = inputDs.indexOfColumn("GROUP_NM");
            int colNm_Remarks    = inputDs.indexOfColumn("REMARKS");

            GauceDataRow[]       rows = inputDs.getDataRows();
            GauceDataColumn[]    cols = inputDs.getDataColumns();

            //블록번호
            res.enableFirstRow(blockNoDS);
            blockNoDS.addDataColumn(new GauceDataColumn("m_block_sid", GauceDataColumn.TB_NUMBER));
            blockNoDS.addDataColumn(new GauceDataColumn("block_no", GauceDataColumn.TB_STRING));
            blockNoDS.addDataColumn(new GauceDataColumn("i_date", GauceDataColumn.TB_STRING));

            //메시지처리
            res.enableFirstRow(msgDS);
            msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));

            for(int i=0; i<rows.length; i++){
               int j=1;
               switch(rows[i].getJobType()){
               case GauceDataRow.TB_JOB_INSERT:
                  //StringUtil.printMsg("call","SALES.PR_RM510I_03-INSERT",this);
                  cstmt = conn.prepareCall("{call SALES.PR_RM510I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) }");

                  //StringUtil.printMsg("colNm_MBlockSid",rows[i].getInt(colNm_MBlockSid),this);
                  //StringUtil.printMsg("colNm_BlockNo",rows[i].getString(colNm_BlockNo),this);
                  //StringUtil.printMsg("colNm_GoodsSid",rows[i].getInt(colNm_GoodsSid),this);
                  //StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
                  //StringUtil.printMsg("colNm_ClientSid",rows[i].getInt(colNm_ClientSid),this);
                  //StringUtil.printMsg("colNm_GroupNm",rows[i].getString(colNm_GroupNm),this);
                  //StringUtil.printMsg("colNm_Remarks",rows[i].getString(colNm_Remarks),this);

                  cstmt.setInt(1, rows[i].getInt(colNm_MBlockSid));
                  cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
                  cstmt.setString(2, rows[i].getString(colNm_BlockNo));
                  cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
                  cstmt.setInt(3, rows[i].getInt(colNm_GoodsSid));
                  cstmt.setString(4, rows[i].getString(colNm_DepartDate));
                  cstmt.setInt(5, rows[i].getInt(colNm_ClientSid));
                  cstmt.setString(6, rows[i].getString(colNm_GroupNm));
                  cstmt.setString(7, rows[i].getString(colNm_Remarks));
                  cstmt.setString(8, iParamEmpno);
                  cstmt.setString(9, iParamIp);
                  cstmt.setString(10, "1");
                  cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);

                  cstmt.executeUpdate();

                  mBlockSid = cstmt.getBigDecimal(1).intValue();
                  //StringUtil.printMsg("마스트블럭SID",mBlockSid,this);
                  GauceDataRow row = blockNoDS.newDataRow();
                  row.addColumnValue(cstmt.getBigDecimal(1).intValue());
                  row.addColumnValue(cstmt.getString(2));
                  row.addColumnValue(cstmt.getString(11));
                  blockNoDS.addDataRow(row);

                  //메시지처리
                  if (cstmt.getString(12).equals("Y") ) {
                     if ( !cstmt.getString(13).equals("0000") ) {
                        //StringUtil.printMsg("성공메시지",cstmt.getString(14),this);
                        GauceDataRow row1 = msgDS.newDataRow();
                        row1.addColumnValue(cstmt.getString(14));
                        msgDS.addDataRow(row1);
                     }
                  } else {
                     //StringUtil.printMsg("실패메시지",cstmt.getString(14),this);
                     conn.rollback();
                     GauceDataRow row1 = msgDS.newDataRow();
                     row1.addColumnValue(cstmt.getString(14));
                     msgDS.addDataRow(row1);
                     fail=true;
                     break inner;
                  }

                  if(cstmt!=null) cstmt.close();
                  break;
               case GauceDataRow.TB_JOB_UPDATE:
                  //StringUtil.printMsg("call","SALES.PR_RM510I_03-UPDATE",this);
                  cstmt = conn.prepareCall("{call SALES.PR_RM510I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

                  cstmt.setInt(1, rows[i].getInt(colNm_MBlockSid));
                  cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
                  cstmt.setString(2, rows[i].getString(colNm_BlockNo));
                  cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
                  cstmt.setInt(3, rows[i].getInt(colNm_GoodsSid));
                  cstmt.setString(4, rows[i].getString(colNm_DepartDate));
                  cstmt.setInt(5, rows[i].getInt(colNm_ClientSid));
                  cstmt.setString(6, rows[i].getString(colNm_GroupNm));
                  cstmt.setString(7, rows[i].getString(colNm_Remarks));
                  cstmt.setString(8, iParamEmpno);
                  cstmt.setString(9, iParamIp);
                  cstmt.setString(10, "3");
                  cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);

                  cstmt.executeUpdate();

                  //메시지처리
                  if (cstmt.getString(12).equals("Y") ) {
                     if ( !cstmt.getString(13).equals("0000") ) {
                        //StringUtil.printMsg("성공메시지",cstmt.getString(14),this);
                        GauceDataRow row1 = msgDS.newDataRow();
                        row1.addColumnValue(cstmt.getString(14));
                        msgDS.addDataRow(row1);
                     }
                  } else {
                     //StringUtil.printMsg("실패메시지",cstmt.getString(14),this);
                     conn.rollback();
                     GauceDataRow row1 = msgDS.newDataRow();
                     row1.addColumnValue(cstmt.getString(14));
                     msgDS.addDataRow(row1);
                     fail=true;
                     break inner;
                  }

                  if(cstmt!=null) cstmt.close();
                  break;
               case GauceDataRow.TB_JOB_DELETE:
                  //StringUtil.printMsg("call","SALES.PR_RM510I_03-DELETE",this);
                  cstmt = conn.prepareCall("call SALES.PR_RM510I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

                  //StringUtil.printMsg("data",rows[i].getInt(colNm_MBlockSid),this);

                  cstmt.setInt(1, rows[i].getInt(colNm_MBlockSid));
                  cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
                  cstmt.setString(2, rows[i].getString(colNm_BlockNo));
                  cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
                  cstmt.setInt(3, rows[i].getInt(colNm_GoodsSid));
                  cstmt.setString(4, rows[i].getString(colNm_DepartDate));
                  cstmt.setInt(5, rows[i].getInt(colNm_ClientSid));
                  cstmt.setString(6, rows[i].getString(colNm_GroupNm));
                  cstmt.setString(7, rows[i].getString(colNm_Remarks));
                  cstmt.setString(8, iParamEmpno);
                  cstmt.setString(9, iParamIp);
                  cstmt.setString(10, "2");
                  cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
                  cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);

                  cstmt.executeUpdate();

                  //메시지처리
                  if (cstmt.getString(12).equals("Y") ) {
                     if ( !cstmt.getString(13).equals("0000") ) {
                        //StringUtil.printMsg("성공메시지",cstmt.getString(14),this);
                        GauceDataRow row1 = msgDS.newDataRow();
                        row1.addColumnValue(cstmt.getString(14));
                        msgDS.addDataRow(row1);
                     }
                  } else {
                     //StringUtil.printMsg("실패메시지",cstmt.getString(14),this);
                     conn.rollback();
                     GauceDataRow row1 = msgDS.newDataRow();
                     row1.addColumnValue(cstmt.getString(14));
                     msgDS.addDataRow(row1);
                     fail=true;
                     break inner;
                  }

                  if(cstmt!=null) cstmt.close();
                  break;
               }
            }
            blockNoDS.flush();
         }
            if(inputDs2!=null){

               try {
                  throw new Exception();
               } catch ( Exception e) {

               }

               int colNm_MBlockSid    = inputDs2.indexOfColumn("M_BLOCK_SID");

               int colNm_BlockSid    = inputDs2.indexOfColumn("BLOCK_SID");
               int colNm_ARoomTypeSid    = inputDs2.indexOfColumn("A_ROOM_TYPE_SID");
               int colNm_ARoomCnt    = inputDs2.indexOfColumn("A_ROOM_CNT");
               int colNm_AcceptPersons    = inputDs2.indexOfColumn("ACCEPT_PERSONS");
               int colNm_ARemarks    = inputDs2.indexOfColumn("A_REMARKS");
               int colNm_BlockStatusCd    = inputDs2.indexOfColumn("BLOCK_STATUS_CD");

               GauceDataRow[] rows = inputDs2.getDataRows();
               GauceDataColumn[] cols = inputDs2.getDataColumns();

               //블록번호
               res.enableFirstRow(blockSidDS);
               blockSidDS.addDataColumn(new GauceDataColumn("block_sid", GauceDataColumn.TB_NUMBER));
               blockSidDS.addDataColumn(new GauceDataColumn("m_block_sid", GauceDataColumn.TB_NUMBER));

               for(int i=0; i<rows.length; i++){
                  int j=1;
                  switch(rows[i].getJobType()){
                  case GauceDataRow.TB_JOB_INSERT:
                     //StringUtil.printMsg("call","SALES.PR_RM510I_04-INSERT",this);
                     cstmt = conn.prepareCall("{call SALES.PR_RM510I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

                     //StringUtil.printMsg("colNm_BlockSid",rows[i].getInt(colNm_BlockSid),this);
                     //StringUtil.printMsg("colNm_MBlockSid", rows[i].getInt(colNm_MBlockSid),this);
                     //StringUtil.printMsg("colNm_ARoomTypeSid",rows[i].getInt(colNm_ARoomTypeSid),this);
                     //StringUtil.printMsg("colNm_ARoomCnt",rows[i].getInt(colNm_ARoomCnt),this);
                     //StringUtil.printMsg("colNm_AcceptPersons",rows[i].getInt(colNm_AcceptPersons),this);
                     //StringUtil.printMsg("colNm_ARemarks",rows[i].getString(colNm_ARemarks),this);
                     //StringUtil.printMsg("colNm_BlockStatusCd",rows[i].getString(colNm_BlockStatusCd),this);


                     cstmt.setInt(1, rows[i].getInt(colNm_BlockSid));
                     cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
                     //StringUtil.printMsg("rows[i].getInt(colNm_MBlockSid)",rows[i].getInt(colNm_MBlockSid),this);
                     //StringUtil.printMsg("mBlockSid",mBlockSid,this);
                     if ( rows[i].getInt(colNm_MBlockSid) == 0 )
                        cstmt.setInt(2, mBlockSid);
                     else
                        cstmt.setInt(2, rows[i].getInt(colNm_MBlockSid));
                     cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
                     cstmt.setInt(3, rows[i].getInt(colNm_ARoomTypeSid));
                     cstmt.setInt(4, rows[i].getInt(colNm_ARoomCnt));
                     cstmt.setInt(5, rows[i].getInt(colNm_AcceptPersons));
                     cstmt.setString(6, rows[i].getString(colNm_ARemarks));
                     cstmt.setString(7, rows[i].getString(colNm_BlockStatusCd));
                     cstmt.setString(8, iParamEmpno);
                     cstmt.setString(9, iParamIp);
                     cstmt.setString(10, "1");
                     cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                     cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
                     cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);

                     cstmt.executeUpdate();

                     GauceDataRow row = blockSidDS.newDataRow();
                     //StringUtil.printMsg("cstmt.getBigDecimal(1).intValue()",cstmt.getBigDecimal(1).intValue(),this);
                     //StringUtil.printMsg("cstmt.getBigDecimal(2).intValue()",rows[i].getInt(colNm_MBlockSid),this);
                     row.addColumnValue(cstmt.getBigDecimal(1).intValue());
                     row.addColumnValue(rows[i].getInt(colNm_MBlockSid));
                     blockSidDS.addDataRow(row);

                     //메시지처리
                     if (cstmt.getString(11).equals("Y") ) {
                        if ( !cstmt.getString(12).equals("0000") ) {
                           //StringUtil.printMsg("성공메시지",cstmt.getString(13),this);
                           GauceDataRow row1 = msgDS.newDataRow();
                           row1.addColumnValue(cstmt.getString(13));
                           msgDS.addDataRow(row1);
                        }
                     } else {
                        //StringUtil.printMsg("실패메시지",cstmt.getString(13),this);
                        conn.rollback();
                        GauceDataRow row1 = msgDS.newDataRow();
                        row1.addColumnValue(cstmt.getString(13));
                        msgDS.addDataRow(row1);
                        fail=true;
                        break inner;
                     }

                     if(cstmt!=null) cstmt.close();
                     break;
                  case GauceDataRow.TB_JOB_UPDATE:
                     //StringUtil.printMsg("call","SALES.PR_RM510I_04-UPDATE",this);
                     cstmt = conn.prepareCall("{call SALES.PR_RM510I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

                     cstmt.setInt(1, rows[i].getInt(colNm_BlockSid));
                     cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
                     cstmt.setInt(2, rows[i].getInt(colNm_MBlockSid));
                     cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
                     cstmt.setInt(3, rows[i].getInt(colNm_ARoomTypeSid));
                     cstmt.setInt(4, rows[i].getInt(colNm_ARoomCnt));
                     cstmt.setInt(5, rows[i].getInt(colNm_AcceptPersons));
                     cstmt.setString(6, rows[i].getString(colNm_ARemarks));
                     cstmt.setString(7, rows[i].getString(colNm_BlockStatusCd));
                     cstmt.setString(8, iParamEmpno);
                     cstmt.setString(9, iParamIp);
                     cstmt.setString(10, "3");
                     cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                     cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
                     cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);

                     cstmt.executeUpdate();

                     //메시지처리
                     if (cstmt.getString(11).equals("Y") ) {
                        if ( !cstmt.getString(12).equals("0000") ) {
                           //StringUtil.printMsg("성공메시지",cstmt.getString(13),this);
                           GauceDataRow row1 = msgDS.newDataRow();
                           row1.addColumnValue(cstmt.getString(13));
                           msgDS.addDataRow(row1);
                        }
                     } else {
                        //StringUtil.printMsg("실패메시지",cstmt.getString(13),this);
                        conn.rollback();
                        GauceDataRow row1 = msgDS.newDataRow();
                        row1.addColumnValue(cstmt.getString(13));
                        msgDS.addDataRow(row1);
                        fail=true;
                        break inner;
                     }

                     if(cstmt!=null) cstmt.close();
                     break;
                  case GauceDataRow.TB_JOB_DELETE:
                     //StringUtil.printMsg("call","SALES.PR_RM510I_04-DELETE",this);
                     cstmt = conn.prepareCall("{call SALES.PR_RM510I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

                     cstmt.setInt(1, rows[i].getInt(colNm_BlockSid));
                     cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
                     cstmt.setInt(2, rows[i].getInt(colNm_MBlockSid));
                     cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
                     cstmt.setInt(3, rows[i].getInt(colNm_ARoomTypeSid));
                     cstmt.setInt(4, rows[i].getInt(colNm_ARoomCnt));
                     cstmt.setInt(5, rows[i].getInt(colNm_AcceptPersons));
                     cstmt.setString(6, rows[i].getString(colNm_ARemarks));
                     cstmt.setString(7, rows[i].getString(colNm_BlockStatusCd));
                     cstmt.setString(8, iParamEmpno);
                     cstmt.setString(9, iParamIp);
                     cstmt.setString(10, "2");
                     cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                     cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
                     cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);

                     cstmt.executeUpdate();

                     //메시지처리
                     if (cstmt.getString(11).equals("Y") ) {
                        if ( !cstmt.getString(12).equals("0000") ) {
                           //StringUtil.printMsg("성공메시지",cstmt.getString(13),this);
                           GauceDataRow row1 = msgDS.newDataRow();
                           row1.addColumnValue(cstmt.getString(13));
                           msgDS.addDataRow(row1);
                        }
                     } else {
                        //StringUtil.printMsg("실패메시지",cstmt.getString(13),this);
                        conn.rollback();
                        GauceDataRow row1 = msgDS.newDataRow();
                        row1.addColumnValue(cstmt.getString(13));
                        msgDS.addDataRow(row1);
                        fail=true;
                        break inner;
                     }

                     if(cstmt!=null) cstmt.close();
                     break;
                  }
               }
               blockSidDS.flush();
            }
         }
         conn.commit();
      } catch (SQLException sqle){
         res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
         throw sqle;
      } finally {
         msgDS.flush();
         if( fail == true ) throw new Exception("");
         if(rs!=null) rs.close();
         if(cstmt!=null) cstmt.close();
      }
   }

}

package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class h050010_t1 extends HttpServlet{

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

			String stryymm="";
			String strEmpno="";
			String strSeq="";
			String strHlno="";

			try {
				
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT   = userSet.indexOfColumn("APPDT");	  //신청일자
				int idxEMPNO   = userSet.indexOfColumn("EMPNO");	  //신청사번
				int idxLAZCD   = userSet.indexOfColumn("LAZCD");	  //근태코드
				int idxFRDT    = userSet.indexOfColumn("FRDT");	    //출발일
				int idxTODT    = userSet.indexOfColumn("TODT");	    //복귀일
				int idxDIVCD   = userSet.indexOfColumn("DIVCD");	  //본부  
				int idxDEPTCD  = userSet.indexOfColumn("DEPTCD");	  //부서  
				int idxPAYGRD  = userSet.indexOfColumn("PAYGRD");	  //직위
				int idxOBJECT  = userSet.indexOfColumn("OBJECT");	  //출장지
				int idxTRIPOBJ = userSet.indexOfColumn("TRIPOBJ");	//출장목적
				int idxCARAMT  = userSet.indexOfColumn("CARAMT");	  //교통비
				int idxOVRATEGB= userSet.indexOfColumn("OVRATEGB");	//환율구분(해외)
				int idxOVDSAMT = userSet.indexOfColumn("OVDSAMT");	//달러금액(해외)
				int idxOVRATE  = userSet.indexOfColumn("OVRATE");	  //환율(해외)
				int idxOVWNAMT = userSet.indexOfColumn("OVWNAMT");	//원화계
				int idxOVETC   = userSet.indexOfColumn("OVETC");	  //비고
				int idxINTRDAY = userSet.indexOfColumn("INTRDAY");	//출장일수
				int idxAPPLYID = userSet.indexOfColumn("APPLYID");	//기안자(신청자사번)
				int idxCLOSYN  = userSet.indexOfColumn("CLOSYN");	  //결재상태
				int idxWRDT    = userSet.indexOfColumn("WRDT");	    //작성일자
				int idxWRID    = userSet.indexOfColumn("WRID");	    //작성ID
				int idxUPDT    = userSet.indexOfColumn("UPDT");	    //수정일자
				int idxUPID    = userSet.indexOfColumn("UPID");	    //수정ID
				int idxORGFRDT = userSet.indexOfColumn("ORGFRDT");  //수정전출발일
				int idxORGTODT = userSet.indexOfColumn("ORGTODT");  //수정전복귀일
				int idxMEMO    = userSet.indexOfColumn("MEMO");     //직위 구분( 0 - 임원 , 20-과장이상, 22- 대리이하)
				int idxOVFDAMT = userSet.indexOfColumn("OVFDAMT");  //식비(해외)
				int idxHLNO    = userSet.indexOfColumn("HLNO");     //출장번호(사번+YYMM+SEQ(2))
				int idxREMARK1 = userSet.indexOfColumn("REMARK1");  //전자결재 비고1
				int idxREMARK2 = userSet.indexOfColumn("REMARK2");  //전자결재 비고2
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;

				StringBuffer InsertSql3 = null;
				StringBuffer DeleteSql3 = null;

				InsertSql = new StringBuffer();
				
				InsertSql.append( " INSERT INTO PAYROLL.HLOTMST(  ");
				InsertSql.append( " APPDT,   EMPNO,    LAZCD,  FRDT,    TODT, ");
				InsertSql.append( " DIVCD,   DEPTCD,   PAYGRD, OBJECT,  TRIPOBJ,  ");
				InsertSql.append( " CARAMT,  OVRATEGB, OVRATE, OVDSAMT, OVWNAMT, OVETC,  ");
				InsertSql.append( " INTRDAY, APPLYID,  CLOSYN, WRDT,    WRID, ");
				InsertSql.append( " UPDT,    UPID,     OVFDAMT,  HLNO, REMARK1, REMARK2  ");
				InsertSql.append( ") VALUES (  ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ? ");
				InsertSql.append( " ) ");


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HLOTMST SET " );
				UpdateSql.append( " TODT =?,    DIVCD = ?,   DEPTCD = ?,  PAYGRD = ?,  OBJECT = ?, ");
				UpdateSql.append( " TRIPOBJ =?, CARAMT = ?,  OVRATEGB =?, OVRATE = ?,  OVDSAMT = ?, OVWNAMT = ?, ");
				UpdateSql.append( " OVETC =?,   INTRDAY = ?, APPLYID =?,  CLOSYN = ?,  UPDT = ?, ");
				UpdateSql.append( " UPID =?,    OVFDAMT=?,   REMARK1=?,   REMARK2=? ");
				UpdateSql.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HLOTMST WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( "DELETE FROM PAYROLL.HLOTDTL WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//전자결재를 위한 키값생성 HLNO ===============================
			      strEmpno=rows[j].getString(idxEMPNO);
						stryymm=rows[j].getString(idxFRDT);
						stryymm=stryymm.substring(2,6);

            Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( " SELECT COALESCE(MAX(SUBSTR(HLNO,13,2)),0)+1 ");
						sql0.append( "	 FROM PAYROLL.HLOTMST "); 
						sql0.append( "	WHERE SUBSTR(HLNO,2,7)='"+strEmpno+"'");
						sql0.append( "	  AND SUBSTR(HLNO,9,4)='"+stryymm+"'"); 
						sql0.append( "	  AND SUBSTR(HLNO,1,1)='A'"); 

						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							 strSeq= rs0.getString(1);
						}
						rs0.close();
						stmt0.close();

						int ichk = Integer.parseInt(strSeq);
						if(ichk<10) strSeq = "0"+strSeq;
						strHlno = "A"+strEmpno+stryymm+strSeq;
						rows[j].setString(idxHLNO,strHlno);
						//==============================================================
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
            
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxLAZCD);
						gsmt.bindColumn(4, idxFRDT);
						gsmt.bindColumn(5, idxTODT);
						gsmt.bindColumn(6, idxDIVCD);
						gsmt.bindColumn(7, idxDEPTCD);
						gsmt.bindColumn(8, idxPAYGRD);
						gsmt.bindColumn(9, idxOBJECT);
						gsmt.bindColumn(10, idxTRIPOBJ);
						gsmt.bindColumn(11, idxCARAMT);
						gsmt.bindColumn(12, idxOVRATEGB);
						gsmt.bindColumn(13, idxOVRATE);
						gsmt.bindColumn(14, idxOVDSAMT);
						gsmt.bindColumn(15, idxOVWNAMT);
						gsmt.bindColumn(16, idxOVETC);
						gsmt.bindColumn(17, idxINTRDAY);
						gsmt.bindColumn(18, idxAPPLYID);
						gsmt.bindColumn(19, idxCLOSYN);
						gsmt.bindColumn(20, idxWRDT);
						gsmt.bindColumn(21, idxWRID);
						gsmt.bindColumn(22, idxUPDT);
						gsmt.bindColumn(23, idxUPID);
						gsmt.bindColumn(24, idxOVFDAMT);
						gsmt.bindColumn(25, idxHLNO);
						gsmt.bindColumn(26, idxREMARK1);
						gsmt.bindColumn(27, idxREMARK2);
					
						gsmt.executeUpdate();
						gsmt.close();

            /////////////////////////////////////////////////////////////////////
            //FROM 일자와 TO일자로 중간의 날짜를 구해서 출장상세에 넣기
						//금액은 총금액/날짜로 하고 마지막날은 총금액-((날짜-1)까지의합)
						//원화금액 계산
						/////////////////////////////////////////////////////////////////////
					  String strFrdt = rows[j].getString(idxFRDT);
						String strTodt = rows[j].getString(idxTODT);
						String strOtdt =""; //출장일
						
						int yyyy = Integer.parseInt(strFrdt.substring(0,4));
						int mm = Integer.parseInt(strFrdt.substring(4,6))-1; //month의 경우 해당월수-1을 해줍니다. 
						int dd = Integer.parseInt(strFrdt.substring(6,8));

						long lngovwnamt =0; //원화금액
						long lngwnsum =0;   //원화금액누적
            long lngovdsamt =0; //달러금액
						long lngdssum =0;   //달러금액누적

						String stryyyy="";
						String strmm="";
						String strdd="";

						Calendar cal2 = Calendar.getInstance ( ); 
						cal2.set ( yyyy, mm, dd ); // 기준일로 설정. 
						 
						for(int i=1;i<=rows[j].getInt(idxINTRDAY);i++){
							if(i==1){ //from일자
								strOtdt=strFrdt;
								lngovwnamt = Math.round(rows[j].getDouble(idxOVWNAMT)/rows[j].getInt(idxINTRDAY));
								lngwnsum+=lngovwnamt;
								lngovdsamt = Math.round(rows[j].getDouble(idxOVDSAMT)/rows[j].getInt(idxINTRDAY));
								lngdssum+=lngovdsamt;
							}else if(i==rows[j].getDouble(idxINTRDAY)){//to일자
								strOtdt=strTodt;
								lngovwnamt = rows[j].getLong(idxOVWNAMT) - lngwnsum;
								lngovdsamt = rows[j].getLong(idxOVDSAMT) - lngdssum;
							}else{ //from일자와 to일자 사이
								cal2.add ( Calendar.DATE, 1 ); // 다음날로 바뀜
								yyyy = cal2.get ( Calendar.YEAR );
								mm = cal2.get ( Calendar.MONTH ) + 1;
								dd = cal2.get ( Calendar.DATE );

								stryyyy = String.valueOf(yyyy);
								if(mm<10) strmm = "0"+ String.valueOf(mm);
								else strmm = String.valueOf(mm);
								if(dd<10) strdd = "0"+ String.valueOf(dd);
								else strdd = String.valueOf(dd);
								strOtdt=stryyyy+strmm+strdd;
								lngovwnamt = Math.round(rows[j].getDouble(idxOVWNAMT)/rows[j].getInt(idxINTRDAY));
								lngwnsum+=lngovwnamt;
								lngovdsamt = Math.round(rows[j].getDouble(idxOVDSAMT)/rows[j].getInt(idxINTRDAY));
								lngdssum+=lngovdsamt;
							}

              //출장 DTL 생성
							InsertSql2 = new StringBuffer();
							InsertSql2.append( " INSERT INTO PAYROLL.HLOTDTL(  ");
							InsertSql2.append( " APPDT,    EMPNO,   LAZCD,   FRDT,    OTDT, ");
							InsertSql2.append( " CARFARE,  OVDSAMT, OVWNAMT,  ");
							InsertSql2.append( " WRDT,     WRID,    UPDT,    UPID ");
							InsertSql2.append( ") VALUES (  ");
							InsertSql2.append( " ?, ?, ?, ?, '"+strOtdt+"', ");
							InsertSql2.append( " 0, "+lngovdsamt+","+lngovwnamt+", ");
							InsertSql2.append( " ?, ?, ?, ? ");
							InsertSql2.append( " ) ");

							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
							gsmt2.setGauceDataRow(rows[j]);
							
							gsmt2.bindColumn(1, idxAPPDT);
							gsmt2.bindColumn(2, idxEMPNO);
							gsmt2.bindColumn(3, idxLAZCD);
							gsmt2.bindColumn(4, idxFRDT);
							gsmt2.bindColumn(5, idxWRDT);
							gsmt2.bindColumn(6, idxWRID);
							gsmt2.bindColumn(7, idxUPDT);
							gsmt2.bindColumn(8, idxUPID);
							
							gsmt2.executeUpdate();
							gsmt2.close();


							//현재일자가 휴일이면 근태Table에 자동생성함.///////////////////////////////////////////////////	
							if(!rows[j].getString(idxMEMO).equals("0")){ //임원이 아닌경우
								StringBuffer sql = new StringBuffer();
								Statement stmt= null;
								ResultSet rs = null;
								String strGubun="";
								int cnt=0;
								long lngamt=0;
								sql.append( " SELECT COUNT(*) CNT, C.LAZCD, C.AMT      ");
								sql.append( "   FROM PAYROLL.HCHOLDAY A                ");
								sql.append( "   LEFT JOIN ( SELECT B.LAZCD, B.AMT      ");
								sql.append( " 							  FROM PAYROLL.HCHOLFEE B  ");
								sql.append( " 						   WHERE LAZCD='S05'         ");
								sql.append( " 					  ) C ON 1=1                   ");
								sql.append( "  WHERE A.HOLDT = '"+strOtdt+"'           ");
								sql.append( "  GROUP BY C.LAZCD, C.AMT                 ");

								stmt = conn.createStatement();
								rs = stmt.executeQuery(sql.toString());
								while(rs.next())	{
									strGubun="1";
									cnt = rs.getInt(1);
									lngamt=rs.getLong(3);
								}//while
								rs.close();
								stmt.close();
								
								//출장이면서, 동시에 휴일근무
								if(cnt>=1){
									if(rows[j].getString(idxMEMO).equals("20")){ //과장이상
										lngamt=40000;
									}else if(rows[j].getString(idxMEMO).equals("22")){ //대리이하
                    lngamt=30000;
									}
									InsertSql3 = new StringBuffer();
									InsertSql3.append( " INSERT INTO PAYROLL.HLDUTY(  ");
									InsertSql3.append( " APPDT,   EMPNO,  LAZCD,   DEPTCD,  PAYSEQ,");
									InsertSql3.append( " FRDT,    TODT,   FRTIME,  TOTIME,  DTYREM,");
									InsertSql3.append( " CLOSYN,  AMT,    OTLAZCD, HLNO ");
									InsertSql3.append( " ) VALUES (  ");
									InsertSql3.append( " ?, ?, 'S05', ?, ?, ");
									InsertSql3.append( " '"+strOtdt+"','', '090000','180000', '해외출장',");
									InsertSql3.append( " 'N',"+lngamt+", ?, '"+strHlno+"' ");
									InsertSql3.append( " ) ");
									
									GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
									gsmt3.setGauceDataRow(rows[j]);
									
									gsmt3.bindColumn(1, idxAPPDT);
									gsmt3.bindColumn(2, idxEMPNO);
									gsmt3.bindColumn(3, idxDEPTCD);
									gsmt3.bindColumn(4, idxPAYGRD); //직위코드이다.
									gsmt3.bindColumn(5, idxLAZCD);  //출장구분코드를 근태테이블에 넣어둔다.(외래키 역할)
								
									gsmt3.executeUpdate();
									gsmt3.close();
								}
							}
							//END - 근태테이블//////////////////////////////////////////////////////////////////////
						}//for
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						//해외출장상세 데이타 삭제/////////////////////////////////////////////////////////////////
						GauceStatement gsmt0 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt0.setGauceDataRow(rows[j]);
						gsmt0.bindColumn(1, idxAPPDT);
						gsmt0.bindColumn(2, idxEMPNO);
						gsmt0.bindColumn(3, idxLAZCD);
						gsmt0.bindColumn(4, idxFRDT);
						gsmt0.executeUpdate();
						gsmt0.close();

						//기존에 생성된 근태정보 삭제/////////////////////////////////////////////////////////////
						//두날짜 차이
						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( "DELETE FROM PAYROLL.HLDUTY " );
						DeleteSql3.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD ='S05' " );
						DeleteSql3.append( "   AND FRDT BETWEEN '"+rows[j].getString(idxORGFRDT)+"' AND '"+rows[j].getString(idxORGTODT)+"' " );
						DeleteSql3.append( "   AND OTLAZCD = ? " );

						GauceStatement gsmt00 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt00.setGauceDataRow(rows[j]);
						gsmt00.bindColumn(1, idxAPPDT);
						gsmt00.bindColumn(2, idxEMPNO);
						gsmt00.bindColumn(3, idxLAZCD);
						gsmt00.executeUpdate();
						gsmt00.close();	  

            //해외출장 MST UPDATE/////////////////////////////////////////////////////////////////////
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxTODT);
						gsmt.bindColumn(2, idxDIVCD);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxPAYGRD);
						gsmt.bindColumn(5, idxOBJECT);
						gsmt.bindColumn(6, idxTRIPOBJ);
						gsmt.bindColumn(7, idxCARAMT);
						gsmt.bindColumn(8, idxOVRATEGB);
						gsmt.bindColumn(9, idxOVRATE);
						gsmt.bindColumn(10, idxOVDSAMT);
						gsmt.bindColumn(11, idxOVWNAMT);
						gsmt.bindColumn(12, idxOVETC);
						gsmt.bindColumn(13, idxINTRDAY);
						gsmt.bindColumn(14, idxAPPLYID);
						gsmt.bindColumn(15, idxCLOSYN);
						gsmt.bindColumn(16, idxUPDT);
						gsmt.bindColumn(17, idxUPID);
						gsmt.bindColumn(18, idxOVFDAMT);
						gsmt.bindColumn(19, idxREMARK1);
						gsmt.bindColumn(20, idxREMARK2);
						gsmt.bindColumn(21, idxAPPDT);
						gsmt.bindColumn(22, idxEMPNO);
						gsmt.bindColumn(23, idxLAZCD);
						gsmt.bindColumn(24, idxFRDT);
						
						gsmt.executeUpdate(); 
						gsmt.close();         

						/////////////////////////////////////////////////////////////////////
            //FROM 일자와 TO일자로 날짜를 구해서 출장상세에 넣기
						//금액은 총금액/날짜로 하고 마지막날은 총금액-((날짜-1)까지의합)
						//원화금액 계산
            //DTL DATA는 삭제후 INSERT함.
						/////////////////////////////////////////////////////////////////////
					  String strFrdt = rows[j].getString(idxFRDT);
						String strTodt = rows[j].getString(idxTODT);
						String strOtdt =""; //출장일
						
						int yyyy = Integer.parseInt(strFrdt.substring(0,4));
						int mm = Integer.parseInt(strFrdt.substring(4,6))-1; //month의 경우 해당월수-1을 해줍니다. 
						int dd = Integer.parseInt(strFrdt.substring(6,8));

						long lngovwnamt =0; //원화금액
						long lngwnsum =0;   //원화금액누적
            long lngovdsamt =0; //달러금액
						long lngdssum =0;   //달러금액누적

						String stryyyy="";
						String strmm="";
						String strdd="";

						Calendar cal2 = Calendar.getInstance ( ); 
						cal2.set ( yyyy, mm, dd ); // 기준일로 설정. 
						 
						for(int i=1;i<=rows[j].getInt(idxINTRDAY);i++){
							if(i==1){
								strOtdt=strFrdt;
								lngovwnamt = Math.round(rows[j].getDouble(idxOVWNAMT)/rows[j].getInt(idxINTRDAY));
								lngwnsum+=lngovwnamt;
								lngovdsamt = Math.round(rows[j].getDouble(idxOVDSAMT)/rows[j].getInt(idxINTRDAY));
								lngdssum+=lngovdsamt;
							}else if(i==rows[j].getDouble(idxINTRDAY)){
								strOtdt=strTodt;
								lngovwnamt = rows[j].getLong(idxOVWNAMT) - lngwnsum;
								lngovdsamt = rows[j].getLong(idxOVDSAMT) - lngdssum;
							}else{
								cal2.add ( Calendar.DATE, 1 ); // 다음날로 바뀜
								yyyy = cal2.get ( Calendar.YEAR );
								mm = cal2.get ( Calendar.MONTH ) + 1;
								dd = cal2.get ( Calendar.DATE );

								stryyyy = String.valueOf(yyyy);
								if(mm<10) strmm = "0"+ String.valueOf(mm);
								else strmm = String.valueOf(mm);
								if(dd<10) strdd = "0"+ String.valueOf(dd);
								else strdd = String.valueOf(dd);
								strOtdt=stryyyy+strmm+strdd;
								lngovwnamt = Math.round(rows[j].getDouble(idxOVWNAMT)/rows[j].getInt(idxINTRDAY));
								lngwnsum+=lngovwnamt;
								lngovdsamt = Math.round(rows[j].getDouble(idxOVDSAMT)/rows[j].getInt(idxINTRDAY));
								lngdssum+=lngovdsamt;
							}

              //해외출장상세 데이타 입력/////////////////////////////////////////////////////////////////
							InsertSql2 = new StringBuffer();
							InsertSql2.append( " INSERT INTO PAYROLL.HLOTDTL(  ");
							InsertSql2.append( " APPDT,    EMPNO,   LAZCD,   FRDT,    OTDT, ");
							InsertSql2.append( " CARFARE,  OVDSAMT, OVWNAMT, ");
							InsertSql2.append( " WRDT,    WRID,    UPDT,    UPID ");
							InsertSql2.append( ") VALUES (  ");
							InsertSql2.append( " ?, ?, ?, ?, '"+strOtdt+"', ");
							InsertSql2.append( " 0, "+lngovdsamt+","+lngovwnamt+", ");
							InsertSql2.append( " ?, ?, ?, ? ");
							InsertSql2.append( " ) ");
							
							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
							gsmt2.setGauceDataRow(rows[j]);
							
							gsmt2.bindColumn(1, idxAPPDT);
							gsmt2.bindColumn(2, idxEMPNO);
							gsmt2.bindColumn(3, idxLAZCD);
							gsmt2.bindColumn(4, idxFRDT);
							gsmt2.bindColumn(5, idxWRDT);
							gsmt2.bindColumn(6, idxWRID);
							gsmt2.bindColumn(7, idxUPDT);
							gsmt2.bindColumn(8, idxUPID);
							
							gsmt2.executeUpdate();
							gsmt2.close();
							////////////////////////////////////////////////////////////////////////////////////////////

						 
							//현재일자가 휴일이면 근태Table에 자동생성함.///////////////////////////////////////////////
							if(!rows[j].getString(idxMEMO).equals("0")){ //임원이 아닌경우
								StringBuffer sql = new StringBuffer();
								Statement stmt= null;
								ResultSet rs = null;
								String strGubun="";
								int cnt=0;
								long lngamt=0;
								sql.append( " SELECT COUNT(*) CNT, C.LAZCD, C.AMT      ");
								sql.append( "   FROM PAYROLL.HCHOLDAY A                ");
								sql.append( "   LEFT JOIN ( SELECT B.LAZCD, B.AMT      ");
								sql.append( " 							  FROM PAYROLL.HCHOLFEE B  ");
								sql.append( " 						   WHERE LAZCD='S05'         ");
								sql.append( " 					  ) C ON 1=1                   ");
								sql.append( "  WHERE A.HOLDT = '"+strOtdt+"'           ");
								sql.append( "  GROUP BY C.LAZCD, C.AMT                 ");

								stmt = conn.createStatement();
								rs = stmt.executeQuery(sql.toString());
								while(rs.next())	{
									strGubun="1";
									cnt = rs.getInt(1);
									lngamt=rs.getLong(3);
								}//while
								rs.close();
								stmt.close();
								
								//출장이면서, 동시에 휴일근무
								if(cnt>=1){
									if(rows[j].getString(idxMEMO).equals("20")){ //과장이상
										lngamt=40000;
									}else if(rows[j].getString(idxMEMO).equals("22")){ //대리이하
                    lngamt=30000;
									}

									InsertSql3 = new StringBuffer();
									InsertSql3.append( " INSERT INTO PAYROLL.HLDUTY(  ");
									InsertSql3.append( " APPDT,    EMPNO,   LAZCD,   DEPTCD,  PAYSEQ, ");
									InsertSql3.append( " FRDT,     TODT,    FRTIME,  TOTIME,  DTYREM,");
									InsertSql3.append( " CLOSYN,  AMT,     OTLAZCD,  HLNO ");
									InsertSql3.append( ") VALUES (  ");
									InsertSql3.append( " ?, ?, 'S05', ?, ?, ");
									InsertSql3.append( " '"+strOtdt+"','', '090000','180000', '해외출장',");
									InsertSql3.append( " 'N',"+lngamt+", ? , '"+ rows[j].getString(idxHLNO)+"' ");
									InsertSql3.append( " ) ");
									
									GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
									gsmt3.setGauceDataRow(rows[j]);
									
									gsmt3.bindColumn(1, idxAPPDT);
									gsmt3.bindColumn(2, idxEMPNO);
									gsmt3.bindColumn(3, idxDEPTCD);
									gsmt3.bindColumn(4, idxPAYGRD); //직위코드이다.
									gsmt3.bindColumn(5, idxLAZCD);  //출장구분코드를 근태테이블에 넣어둔다.(외래키 역할)
								
									gsmt3.executeUpdate();
									gsmt3.close();
								}
							}
							//END - 근태테이블//////////////////////////////////////////////////////////////////////							
						}//for
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxLAZCD);
						gsmt.bindColumn(4, idxFRDT);
						gsmt.executeUpdate();
						gsmt.close();

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idxAPPDT);
						gsmt2.bindColumn(2, idxEMPNO);
						gsmt2.bindColumn(3, idxLAZCD);
						gsmt2.bindColumn(4, idxFRDT);
						gsmt2.executeUpdate();
						gsmt2.close();

						//기존에 생성된 근태정보 삭제/////////////////////////////////////////////////////////////
						//두날짜 차이
						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( "DELETE FROM PAYROLL.HLDUTY " );
						DeleteSql3.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD ='S05' " );
						DeleteSql3.append( "   AND FRDT BETWEEN '"+rows[j].getString(idxORGFRDT)+"' AND '"+rows[j].getString(idxORGTODT)+"' " );
						DeleteSql3.append( "   AND OTLAZCD = ? " );

						GauceStatement gsmt00 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt00.setGauceDataRow(rows[j]);
						gsmt00.bindColumn(1, idxAPPDT);
						gsmt00.bindColumn(2, idxEMPNO);
						gsmt00.bindColumn(3, idxLAZCD);
						gsmt00.executeUpdate();
						gsmt00.close();	  
					}
				}
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

      conn.commit();
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
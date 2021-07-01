/**
 * 
 */
package sales.menu.cu;


import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
 
import oracle.jdbc.OracleTypes;


/**
 * @author 우리집
 *
 */
public class Cu090S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#makeSql()
	 */
	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT 																						\n")
				  .append ("      T4.CLIENT_CD             /* 협력업체코드    */                                        		\n")
				  .append ("     ,T4.CLIENT_NM             /* 협력업체명      */                                        		\n")
				  .append ("     ,T1.CAR_NO                /* 차량등록번호      */                                      		\n")
				  .append ("     ,T1.CAR_NM                /* 차명              */                                      		\n")
				  .append ("     ,T1.CAR_TYPE              /* 차종              */                                      		\n")
				  .append ("     ,T1.CAR_FORM              /* 형식              */                                      		\n")
				  .append ("     ,T1.CAR_YEAR              /* 연식              */                                      		\n")
				  .append ("     ,T1.CAR_CC                /* 배기량            */                                      		\n")
				  .append ("     ,T1.CAR_PERSONS           /* 승차인원          */                                      		\n")
				  .append ("     ,T1.MAX_KG                /* 최대적재량        */                                      		\n")
				  .append ("     ,SALES.FN_DETAIL_NM ( 'CU017',T1.CAR_TYPE_CD) AS CAR_TYPE_CD_NAME                    	\n")
				  .append ("     ,T1.CAR_DNO               /* 차대번호          */                                      		\n")
				  .append ("     ,SALES.FN_DETAIL_NM ( 'CU018',T1.NORTH_YN)    AS NORTH_YN_NAME                       	\n")
				  .append ("     ,T1.NORTH_DATE            /* 최초방문예상일    */                                      		\n")
				  .append ("     ,T3.CUST_NM               /* 운전자            */                                      		\n")
				  .append ("     ,T1.DRIVE_NO              /* 운전면허번호      */                                      		\n")
				  .append ("      ,SALES.FN_SECURE_RETURN(T3.MANAGE_NO,7) AS MANAGE_NO   /* 주민/여권 번호  */          \n")
				  .append ("FROM                                                                                        \n")
				  .append ("      SALES.TCU050 T1                                                                       \n")
				  .append ("     ,SALES.TCU040 T2                                                                       \n")
				  .append ("     ,SALES.TCU010 T3 																	    \n")
				  .append ("	 ,SALES.TCU030 T4																		\n")
				  .append ("WHERE 1 = 1                                                                                 \n")
				  .append ("  AND T1.DRIVE_NO  = T2.DRIVE_NO                                                            \n")
				  .append ("  AND T2.CUST_SID  = T3.CUST_SID                                                            \n")
				  .append ("  AND T1.CLIENT_SID=T4.CLIENT_SID															\n");
	}

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#init(com.gauce.db.GauceDBConnection, com.gauce.io.GauceRequest, com.gauce.io.GauceResponse)
	 */
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    //StringUtil.printMsg("DS TYPE","선조회",this);
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("ds1")){//고객구분
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		//StringUtil.printMsg("DS TYPE","선조회",this);
		    		arr_sql[0].append (" AND T1.CAR_NO = '11111212' ");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
							}
						}
		 	gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	
	}

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#select(com.gauce.db.GauceDBConnection, com.gauce.io.GauceRequest, com.gauce.io.GauceResponse)
	 */
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;

		// 검색시 조건
		String  sClientCd	= HDUtil.nullCheckStr(greq.getParameter("sClientCd")); 	// 매출처
		String	v_car_no	= HDUtil.nullCheckStr(greq.getParameter("v_car_no"));		// 고객구분
		String	sCustNm 	= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));		// 고객구분
		
int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){// || dSets[i].getName().equals("imgDs")){
						/*
						StringUtil.printMsg(" sClientSid ",sClientSid,this);
						StringUtil.printMsg(" sCustGu ",sCustGu,this);
						StringUtil.printMsg(" sCountryGu ",sCountryGu,this);
						StringUtil.printMsg(" sCustNm ",sCustNm,this);
						StringUtil.printMsg(" sManegeNo ",sManegeNo,this);
						StringUtil.printMsg(" sAcceptNo ",sAcceptNo,this);
						*/
						int sCnt1 = 1;
						GauceDataSet ds1 = gis.read("DEFAULT");

				if (!"".equals(sClientCd)) 
					arr_sql[0].append (" AND T4.CLIENT_SID = ? ");
				
				if (!"".equals(v_car_no))
					arr_sql[0].append (" AND T1.CAR_NO LIKE ? ");

				if (!"".equals(sCustNm)) 
					arr_sql[0].append (" AND T3.CUST_NM LIKE ? ");
				
				arr_sql[0].append ("ORDER BY T4.CLIENT_CD, T1.CAR_NO		");

				//StringUtil.printMsg("arr_sql[0].toString() : " + arr_sql[0].toString(), this);

				//쿼리 실행
				cstmt = conn.prepareCall(arr_sql[0].toString());

				if (!"".equals(sClientCd)) 
					cstmt.setString(sCnt1++, sClientCd);
				
				if (!"".equals(v_car_no)) 
					cstmt.setString(sCnt1++, "%"+v_car_no+"%");
				
				if (!"".equals(sCustNm)) 
					cstmt.setString(sCnt1++, sCustNm +"%");

				rs = cstmt.executeQuery(); // DataSet set
				gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
										
			}
			gos.close();
		}
	} catch (SQLException sqle){
		//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
		throw sqle;
	} catch (Exception e) {
		//gres..writeException("ERROR", "", e.toString());
		throw e;
	} finally {
		if(rs!=null) rs.close();
		if(cstmt!=null) cstmt.close();
	}
	}

	/* (non-Javadoc)
	 * @see sales.common.SuperServlet#apply(com.gauce.db.GauceDBConnection, com.gauce.io.GauceRequest, com.gauce.io.GauceResponse)
	 */
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}
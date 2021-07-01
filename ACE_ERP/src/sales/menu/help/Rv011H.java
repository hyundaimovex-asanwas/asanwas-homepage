package sales.menu.help;

import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

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
 
import oracle.jdbc.OracleTypes;

public class Rv011H extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++) {
            arr_sql[i] = new StringBuffer();
        }
		// TODO Auto-generated method stub
		arr_sql[0].append("SELECT T1.ACCEPT_NO                            AS ACCEPT_NO 		\n")		
					.append("			,T2.GOODS_NM                             AS GOODS_NM    	\n")
					.append("			,T2.GOODS_CD                             AS GOODS_CD    	\n")
					.append("			,T1.ACCEPT_DATE                          AS ACCEPT_DATE		\n")
					.append("			,T1.ACCEPT_SID                           AS ACCEPT_SID 		\n")
					.append("			,T1.DEPART_DATE                          AS DEPART_DATE		\n")
					.append("			,(SELECT COALESCE(SUM(USE_AMT), 0) 							\n")
					.append("				FROM SALES.TRV020 T8													\n")
					.append("				,SALES.TRV030 T9																\n")
					.append("				WHERE T8.ACCEPT_SID  = T1.ACCEPT_SID						\n")
					.append("					AND T8.RSV_SID     = T9.RSV_SID										\n")	
					.append("					AND T9.RSV_PAY_YN  =  'Y')           AS A_SAL_AMT   		\n")
					.append("			,(SELECT COALESCE(SUM( SALES.FN_PAY_AMT('3', T8.RSV_SID, 'N') ), 0) 					\n")
					.append("				FROM SALES.TRV020 T8													\n")
					.append("				WHERE T8.ACCEPT_SID  = T1.ACCEPT_SID	) AS PAY_AMT     				\n")
					.append("	FROM SALES.TRV010 T1													\n")
					.append("		,SALES.TRM200 T2															\n")
					.append("WHERE T1.GOODS_SID   = T2.GOODS_SID						\n")
		 			.append("AND T1.CLIENT_SID 		= ? 				\n")
		 			.append("AND T1.DEPART_DATE 	= ? 				\n");						

	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String sDepartDate 	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
		int    sClientSid 	= HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
		String sAcceptNo 	= HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));

		//StringUtil.printMsg("sDepartDate", sDepartDate,this);
		//StringUtil.printMsg("sAcceptNo",sAcceptNo,this);
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int j=0; j<dSets.length;j++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[j].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DS1");
						if ( !sAcceptNo.equals("")) 
							arr_sql[0].append("AND T1.ACCEPT_NO LIKE ? \n");
						arr_sql[0].append("ORDER BY ACCEPT_NO, GOODS_CD		\n");
						
						//StringUtil.printMsg("arr_sql[0].toString()",arr_sql[0].toString(),this);
						cstmt = conn.prepareCall(arr_sql[0].toString());

						cstmt.setInt(1, sClientSid);
						cstmt.setString(2, sDepartDate);	

						if ( !sAcceptNo.equals("")) 
							cstmt.setString(3, "%"+sAcceptNo+"%");
						
						rs = cstmt.executeQuery(); 
			   			gos.write(getDataSet(rs, ds1));// DataSet set
					} 
				}
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
}

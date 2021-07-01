package config.menu.my;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import config.common.HDConstant;
import config.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;
import common.sys.KISA_SHA256;  //2015-04-15 KISA 암호화



public class My510I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		arr_sql[1].append ("{call COMMON.PR_MY510I_01(?,?) }");
		arr_sql[2].append ("{call COMMON.PR_MY510I_02(?,?) }"); //Main 저장
   }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        //I:DS1=ds1
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");        
		//StringUtil.printMsg("iParamEmpno",iParamEmpno, this);			

		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				int colNm_Pwd_New1		= ds1.indexOfColumn("pwd_new1");
				//StringUtil.printMsg("colNm_Pwd_New1",colNm_Pwd_New1, this);
				
				for(int i=0; i<rows.length; i++){
					//20150512 심동현, test by JYS----------------------------------------------------------------
					byte pbData[]   = new byte[0];      //사용자입력 평문
					byte pbCipher[] = new byte[32];     //암호문
					int Plaintext_length=0;  //평문길이 
					String strEncryptPW="";  //암호문
					StringBuffer sb = new StringBuffer();
					String strEncodePW = "";             //암호문이 인코딩 된 상태

					String pwd 	= rows[i].getString(colNm_Pwd_New1); //받아온 새 비번
					
					pbData =  pwd.getBytes();
					Plaintext_length = pwd.length();
										
				    //param///////////////////////////////////////////////////////
					//pbData : 평문
					//Plaintext_length : 평문길이
					//pbCipher : 암호문
					//////////////////////////////////////////////////////////////
				    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
					 sb = new StringBuffer(); 
					 for(int j = 0 ; j < pbCipher.length ; j++){
			                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
			          }
					 //암호문 
					strEncryptPW = sb.toString();
					System.out.println("strEncryptPW::"+strEncryptPW+"::::");	
			        //------------------------------------------------------------------------------------
					
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, strEncryptPW);	
					cstmt.setString (2, fParamEmpno);										//수정사번 
					cstmt.executeUpdate();
				}
			}; //if
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{	
	}
}

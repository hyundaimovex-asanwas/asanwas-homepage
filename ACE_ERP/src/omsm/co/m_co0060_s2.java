package omsm.co;
/***********************************************************************
 * 	OMS 사용자등록
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import omsm.common.HDUtil;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

import java.security.MessageDigest;
import java.security.*;
//import sun.misc.BASE64Encoder";

import omsm.common.KISA_SHA256;

public class m_co0060_s2 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		
		for(int i=0; i<arr_sql.length; i++)	    	
			arr_sql[i] = new StringBuffer();
		    //INSERT
		
		    
		    arr_sql[2].append ("  UPDATE COMMON.GD0080 SET  \n");
			arr_sql[2].append ("  BMILNO=?    \n");
			arr_sql[2].append (" ,BMILNO2=?    \n");
			arr_sql[2].append (" ,U_EMPNO=?   \n");
			arr_sql[2].append (" ,U_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE EMPID =? \n");
			
		
		    /*
		    arr_sql[2].append ("  UPDATE OMS.T_CO0050 SET  \n");
			arr_sql[2].append ("  USER_PW=?     \n");
			arr_sql[2].append (" ,UPDATE_ID=?   \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE USER_ID =? \n");
			*/
		
 	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		conn.setAutoCommit(false);
			
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		
		String strUser_id	= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_USER_ID   = ds1.indexOfColumn("USER_ID");
				int colNm_USER_PW   = ds1.indexOfColumn("USER_PW");
				
				String strBasicPW = "";	 //평문암호
				String strEncryptPW="";  //암호문
				int Plaintext_length=0;  //평문길이 
				
				byte pbData[]   = new byte[0];      //사용자입력 평문
				byte pbCipher[] = new byte[32];     //암호문
				
				StringBuffer sb = new StringBuffer(); 
				
				for(int i=0; i<rows.length; i++){
					//strBasicPW = "abc";
					strBasicPW = rows[i].getString(colNm_USER_ID)+"oms1$";		
					pbData =  strBasicPW.getBytes();
					Plaintext_length = strBasicPW.length();
										
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
					 strEncryptPW = sb.toString();
					 
					 if(strEncryptPW.equals("f6272be04474400722da82ea40793065bba17b6742715d67fa0ad462ee0c7deb")){
						System.out.println("같아여");	
					 }else{
						System.out.println("틀려여"); 
					 }
					
					//System.out.println("strEncryptPW::"+strEncryptPW);	
					//이 함수는 KISA 아닌 순수 자바 건 이용...
					//strEncryptPW =getSHA256(strBasicPW);
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//System.out.println("arr_sql[1].toString()::"+arr_sql[1].toString());	
							cstmt = conn.prepareCall(arr_sql[1].toString());	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							
							//System.out.println("arr_sql[2].toString()::"+arr_sql[2].toString());	
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setString(1, strBasicPW); 
							cstmt.setString(2, strEncryptPW);
							cstmt.setString(3, strUser_id);
							cstmt.setString(4, rows[i].getString(colNm_USER_ID));
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();
						    
							break;
							
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							//System.out.println("arr_sql[1].toString()::"+arr_sql[3].toString());	
							
							cstmt.setString(1,rows[i].getString(colNm_USER_ID));	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							
							break;
							
					}//switch(rows[i].getJobType()){
				}//for
			}//if (ds1 != null) {
				
			gos.close();	
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			conn.rollback();
			throw e;
		} finally {			
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
		
	}
			

	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	
	}
	
	/**
	//암호화 SHA-256
	public static String getSHA256(String str) {
        String rtnSHA = "";
        
        try{
            MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
            sh.update(str.getBytes()); 
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer(); 
            
            for(int i = 0 ; i < byteData.length ; i++){
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            rtnSHA = sb.toString();
            
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace(); 
            rtnSHA = null; 
        }
        return rtnSHA;
    } 
    **/

}

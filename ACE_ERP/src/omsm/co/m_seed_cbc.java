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
import omsm.common.KISA_SEED_CBC;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

import java.security.*;
//import sun.misc.BASE64Encoder";

import omsm.common.KISA_SHA256;

public class m_seed_cbc extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		
		for(int i=0; i<arr_sql.length; i++)	    	
			arr_sql[i] = new StringBuffer();
		    //INSERT
		
		    /*
		    arr_sql[2].append ("  UPDATE COMMON.GD0080 SET  \n");
			arr_sql[2].append ("  BMILNO=?    \n");
			arr_sql[2].append (" ,BMILNO2=?    \n");
			arr_sql[2].append (" ,U_EMPNO=?   \n");
			arr_sql[2].append (" ,U_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE EMPID =? \n");
			*/
		
		    
		    arr_sql[2].append ("  UPDATE OMS.T_CO0050 SET  \n");
			arr_sql[2].append ("  USER_PW=?     \n");
			arr_sql[2].append (" ,UPDATE_ID=?   \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE USER_ID =? \n");
			
		
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
				
				
				/* 암호화 대칭 키 */
				byte pbUserKey[]  = {(byte) 0x1c, (byte) 0x11, (byte) 0x19, (byte) 0x1d, (byte) 0x1f, (byte) 0x16, (byte) 0x12, (byte) 0x18,
						              (byte) 0x11, (byte) 0x19, (byte) 0x1d, (byte) 0x1f, (byte) 0x10, (byte) 0x14, (byte) 0x1b, (byte)0x16};

				
			    /* CBC 대칭 키 */
  			    byte bszIV[] = {(byte)0x27,  (byte)0x28,  (byte)0x27, (byte) 0x6d,  (byte)0x2d, (byte) 0xd5,  (byte)0x4e, 
				                 (byte)0x29,  (byte)0x2c,  (byte)0x56, (byte) 0xf4,  (byte)0x2a,  (byte)0x65,  (byte)0x2a,  (byte)0xae,  (byte)0x08};


  			    byte[] enc = null;
  			    
  			    byte[] enc1 = null;
  			   
  			    sun.misc.BASE64Encoder Enc = new sun.misc.BASE64Encoder();
  			    
  			    sun.misc.BASE64Decoder Dec = new sun.misc.BASE64Decoder();
  			    
  		        //String charset = "euc-kr";
  			    String charset = "UTF-8";
  		        String data="101643252|A1|테스터|8208026|안녕 12345";
  		        
  		        //System.out.println("\n원본 결과=["+data+"]") ;
  		        
  		        //System.out.println("\n bszIV=["+bszIV+"]");

  		        /* Encrypt 테스트 시작 */
  		        enc = KISA_SEED_CBC.SEED_CBC_Encrypt(pbUserKey, bszIV, data.getBytes(charset), 0, data.getBytes(charset).length);
  		        //enc.toString();
  		         //System.out.println("enc.toString::"+enc.toString()) ; 
  		         
  		         //String aaa ="n+cvI1t/Zl6Vhj3SrdPPaMw8gYf51xZm9S+y3gcU0GKiUdySE4buzzXan7FzK53";
  		         
  		         String aaa="";
  		         
  		         //String aaa =Enc.encode(enc);
 		        // System.out.println("\n암호화+encode 결과=["+bbb+"]") ;
  		         System.out.println("aaa::"+aaa) ; 
 		         
  		         //암호화 할때...이렇게 넣어 주면 됨.....
  		         aaa="n+cvI1t/Zl6Vhj3SrdPPaMw8gYf51xZm9S+y3gcU0GKiUdySE4buzzXan7FzK538";
  		         
  		         //복호화 할때도 이렇게 가져오면 됨...
  		         
  		         byte[] encryptbytes = Dec.decodeBuffer(aaa);
  		         //String strData =new String(enc);
  		         //enc1 = strData.getBytes();
  		         
  		         //System.out.println("strData="+strData+":::"+enc1) ;
  		         
  		         /*
  		         //이부분은 내가 임의로 넣음.//////////////////////////////////////////////////////////
  		         StringBuffer sb = new StringBuffer(); 
				 for(int j = 0 ; j < enc.length ; j++){
		                sb.append(Integer.toString((0xff&enc[j]) + 0x100, 16).substring(1));
		         }
				 String strEncryptPW = sb.toString();
				 System.out.println("\n암호화결과=["+strEncryptPW+"]") ;
				 ///////////////////////////////////////////////////////////////////////////////
  		        */
  		        /* Decrypt 테스트 시작 */
  		         
  		        //String str="3001FEB996E04F72971E597240424117D8E99BBAFDE09A8CE5FD14F279668924A618AE2BAEF4139B6118B48936B2BF70";
  		         
  		       
  		         
  		        
  		         //String str="9FE72F235B7F665E95863DD2ADD3CF68CC3C8187F9D71666F52FB2DE0714D062A251DC921386EECF35DA9FB1732B9DFC";
  		         //enc = str.getBytes();
  		        
  		       // enc = "9FE72F235B7F665E95863DD2ADD3CF68CC3C8187F9D71666F52FB2DE0714D062A251DC921386EECF35DA9FB1732B9DFC";
  		        
  		       // enc=rows[0].getString(colNm_USER_PW).getBytes();
  		        
  		        //System.out.println("enc:::["+enc+"]") ;  
  		         
  		        //System.out.println("pbUserKey::"+pbUserKey+"::bszIV::"+bszIV) ;  
  		        
  		        //pbUserKey = byte[[B@2a4c68e2];
  		        /* 
  		        StringBuffer sb = new StringBuffer(); 
				 for(int j = 0 ; j < pbUserKey.length ; j++){
		                sb.append(Integer.toString((0xff&pbUserKey[j]) + 0x100, 16).substring(1));
		         }
				 String strpbUserKeyPW = sb.toString();
				 System.out.println("\nstrpbUserKeyPW=["+strpbUserKeyPW+"]") ;
  		         */
  		        String result = "";
  		        byte[] dec = null;
  		        
  		        
  		        System.out.println("\n bszIV=["+bszIV+"]");
  		        
  		        //dec = KISA_SEED_CBC.SEED_CBC_Decrypt(pbUserKey, bszIV, enc, 0, enc.length);
  		        dec = KISA_SEED_CBC.SEED_CBC_Decrypt(pbUserKey, bszIV, encryptbytes, 0, encryptbytes.length);
  		        System.out.println("dec:::["+dec+"]") ;  
  		        
  		        result = new String(dec, charset);
  		        
  		        System.out.println("\n복호화 결과=["+result+"]");
  		          
  		        
  		        /*실제 저장된 암호화 값으로 복호화하기*/
  		        /*
  		        byte[] enc1 = null;
				byte[] dec1 = null;
				String result1 = ""	;
				
				enc1 =  strEncryptPW.getBytes();
				System.out.println("enc1::"+enc1) ; 
				
  		        dec1 = KISA_SEED_CBC.SEED_CBC_Decrypt(pbUserKey, bszIV, enc, 0, enc.length);
  		        System.out.println("5::"+dec1) ; 
  		        result1 = new String(dec1, charset);
  		        System.out.println("\n복호화 결과1=["+result1+"]") ;  
				*/
  		        
				for(int i=0; i<rows.length; i++){
					//strBasicPW = "abc";
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
							cstmt.setBytes(1, enc);
							cstmt.setString(2, strUser_id);
							cstmt.setString(3, rows[i].getString(colNm_USER_ID));
							
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

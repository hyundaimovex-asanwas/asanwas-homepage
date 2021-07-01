/*
 * 2013-11-20 
 * sales 쪽에서 config로 옮겨온 메뉴
 * 홈>환경설정>ERP>계정 관리>사용자 관리
 * */

package config.menu.sy;

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

import sales.common.HDUtil;
import sales.common.StringUtil;
import config.common.SuperServlet;

import common.sys.KISA_SHA256;  //2015-04-15 KISA 암호화


public class Sy010I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call COMMON.PR_SY010I_01(?,?, ?) }" ); 
	  //계정 사용유무 업데이트
      arr_sql[1].append ("{call COMMON.PR_SY010I_02(?,?,?,?,?,   ?,?,?,?) }" );	
	  
	  //최초 일괄 암호화(2015.05.12 재적용)
	  arr_sql[2].append ("{call COMMON.PR_SY010I_09(?,?) }" );	
      //계정 생성
      arr_sql[3].append ("{call COMMON.PR_SY010I_03(?,?,?,?,?,   ?) }" );
      
      //비번 초기화
      arr_sql[4].append ("{call COMMON.PR_MY510I_02(?,?) }"); //Main 저장      
	  
   }

   public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
   }

   // 조회 method
   public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
           GauceInputStream gis = greq.getGauceInputStream();
           GauceOutputStream gos = gres.getGauceOutputStream();

           //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
           GauceDataSet[] dSets = gis.readAllOutput(); 
           
           // 검색시 조건
           String sEmpno  = HDUtil.nullCheckStr(greq.getParameter("sEmpno"));
           String sStatus = HDUtil.nullCheckStr(greq.getParameter("sStatus"));
           //StringUtil.printMsg(" sEmpno===",sEmpno,this);
           //StringUtil.printMsg(" sStatus===",sStatus,this);
           
           for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//JSP(O:Main=ds1)",
        	   if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("Main");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					  cstmt.setString(1,sEmpno);
					  cstmt.setString(2,sStatus);				  
					  // 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					  cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					  cstmt.executeQuery();
					  rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					
					  gos.write(getDataSet(rs, ds1));
				}
           	

           }

         
      } catch (SQLException sqle){
    	  gres.addException(sqle);
         throw sqle;
      } catch (Exception e) {
    	  gres.addException(e);
         throw e;
      } finally {
         if(rs!=null) rs.close();
         if(cstmt!=null) cstmt.close();
      }
   }


   public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	

		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
       
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");
		GauceDataSet dsResult = gis.read("RESULT");
		
		
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();      

				int colNm_YN_USE                = ds1.indexOfColumn("YN_USE");
				int colNm_EMPID 		        = ds1.indexOfColumn("EMPID");
				int colNm_AED 		        	= ds1.indexOfColumn("AED");
				int colNm_EMPNM                	= ds1.indexOfColumn("EMPNM");
				int colNm_DPT_NM                = ds1.indexOfColumn("DPT_NM");
				int colNm_JOB_NM                = ds1.indexOfColumn("JOB_NM");
				

				for(int i=0; i<rows.length; i++){
					
					StringUtil.printMsg("ds1의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					StringUtil.printMsg("EMPID", rows[i].getString(ds1.indexOfColumn("EMPID")), this);
					
					//20150512 심동현, test by JYS----------------------------------------------------------------
					/*byte pbData[]   = new byte[0];      //사용자입력 평문
					byte pbCipher[] = new byte[32];     //암호문
					int Plaintext_length=0;  //평문길이 
					String strEncryptPW="";  //암호문
					StringBuffer sb = new StringBuffer();
					String strEncodePW = "";             //암호문이 인코딩 된 상태

					String pwd 	= rows[i].getString(ds1.indexOfColumn("BMILNO")); //받아온 기존 비번
					
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
					System.out.println("strEncryptPW::"+strEncryptPW+"::::");*/	
			        //------------------------------------------------------------------------------------
										
					
	                if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE){
						//StringUtil.printMsg("call","업데이트 UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, rows[i].getJobType());	//가우스행 작업 값
						cstmt.setString(2, rows[i].getString(colNm_YN_USE));
						cstmt.setString(3, rows[i].getString(colNm_EMPID));
						cstmt.setString(4, rows[i].getString(colNm_EMPNM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(6, rows[i].getString(colNm_DPT_NM));
						cstmt.setString(7, rows[i].getString(colNm_YN_USE));
						cstmt.setString(8, iParamEmpno);
						cstmt.setString(9, iParamIp );
						cstmt.executeUpdate();
						
						
						//일괄암호화
						/*cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1, rows[i].getString(ds1.indexOfColumn("EMPID")));
						cstmt.setString(2, strEncryptPW );*/
						
						
	                }
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE){
						//StringUtil.printMsg("call","COMMON.PR_141I_02-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, rows[i].getJobType());	//가우스행 작업 값
						cstmt.setString(2, rows[i].getString(colNm_YN_USE));
						cstmt.setString(3, rows[i].getString(colNm_EMPID));
						cstmt.setString(4, rows[i].getString(colNm_EMPNM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(6, rows[i].getString(colNm_DPT_NM));
						cstmt.setString(7, "D");
						cstmt.setString(8, iParamEmpno);
						cstmt.setString(9, iParamIp );
						cstmt.executeUpdate();
					}                      

					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){//계정 최초 생성
						//20150512 심동현, 디폴트 암호 해싱----------------------------------------------------------------
						byte pbData[]   = new byte[0];      //사용자입력 평문
						byte pbCipher[] = new byte[32];     //암호문
						int Plaintext_length=0;  //평문길이 
						String strEncryptPW="";  //암호문
						StringBuffer sb = new StringBuffer();
						String strEncodePW = "";             //암호문이 인코딩 된 상태

						String pwd 	= "hda"+rows[i].getString(colNm_EMPID)+"!"; //디폴트 암호
						
						pbData =  pwd.getBytes();
						Plaintext_length = pwd.length();
						//pbData : 평문
						//Plaintext_length : 평문길이
						//pbCipher : 암호문
					    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
						 sb = new StringBuffer(); 
						 for(int j = 0 ; j < pbCipher.length ; j++){
				                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
				          }
						 //암호문 
						strEncryptPW = sb.toString();
						System.out.println("strEncryptPW::"+strEncryptPW+"::::");
				        //------------------------------------------------------------------------------------
							
						StringUtil.printMsg("call","PR_SY010I_03-INSERT",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setString(1, rows[i].getString(colNm_EMPID));
						cstmt.setString(2, rows[i].getString(colNm_AED));
						cstmt.setString(3, rows[i].getString(colNm_EMPNM));
						cstmt.setString(4, strEncryptPW);
						cstmt.setString(5, iParamEmpno);
						cstmt.setString(6, iParamIp );
						cstmt.executeUpdate();
					}                      

				}//for(int i=0; i<rows.length; i++) the end...
			}//if(ds1!=null) the end...
			if (ds2 != null) {//있던 계정의 비번 초기화
				String sEmpno  = HDUtil.nullCheckStr(greq.getParameter("sEmpno"));
				//StringUtil.printMsg("초기화사번==", sEmpno,this);
				//20150512 심동현, 디폴트 암호 해싱----------------------------------------------------------------
				byte pbData[]   = new byte[0];      //사용자입력 평문
				byte pbCipher[] = new byte[32];     //암호문
				int Plaintext_length=0;  //평문길이 
				String strEncryptPW="";  //암호문
				StringBuffer sb = new StringBuffer();
				String strEncodePW = "";             //암호문이 인코딩 된 상태

				String pwd 	= "hda"+sEmpno+"!"; //디폴트 암호
				
				pbData =  pwd.getBytes();
				Plaintext_length = pwd.length();
				//pbData : 평문
				//Plaintext_length : 평문길이
				//pbCipher : 암호문
			    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
				 sb = new StringBuffer(); 
				 for(int j = 0 ; j < pbCipher.length ; j++){
		                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
		          }
				 //암호문 
				strEncryptPW = sb.toString();
				//StringUtil.printMsg("초기화비번==", strEncryptPW, this);
		        //------------------------------------------------------------------------------------

				cstmt = conn.prepareCall(arr_sql[4].toString());
				cstmt.setString(1, strEncryptPW);	//초기화 비번
				cstmt.setString (2, sEmpno);		//초기화 대상사번 
				cstmt.executeUpdate();
			}
			gos.close();
		} catch (SQLException sqle){
         throw sqle;
		} finally {
         if(cstmt!=null) cstmt.close();
		}
   	}  
}


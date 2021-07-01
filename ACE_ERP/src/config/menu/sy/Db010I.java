/*
 * 2013-11-27 
 * 홈>환경설정>ERP>DB 관리>테이블 정의
 * 커넥션을 파라미터로 받아서 해야 하는데 .. 움.. 
 * */

package config.menu.sy;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sun.misc.BASE64Encoder;
import config.common.SuperServlet;




public class Db010I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
         arr_sql[i] = new StringBuffer();

      //Main 조회
      arr_sql[0].append ("{call COMMON.PR_DB010I_01(?, ?) }" ); //
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
           String v_snm  = HDUtil.nullCheckStr(greq.getParameter("v_snm"));	//스키마
           String v_jnm = HDUtil.nullCheckStr(greq.getParameter("v_jnm"));	//JNDI
           String v_tnm = HDUtil.nullCheckStr(greq.getParameter("v_tnm"));	//table명
           //StringUtil.printMsg(" v_snm===",v_snm,this);
           //StringUtil.printMsg(" v_jnm===",v_jnm,this);
           //StringUtil.printMsg(" v_tnm===",v_tnm,this);
           
           for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//JSP(O:Main=ds1)",
        	   if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					  cstmt.setString(1,v_snm);
					  // 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					  cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					  cstmt.executeQuery();
					  rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					
					  gos.write(getDataSet(rs, ds1));
				}
           	

        	   //sub 쿼리 : 테이블 정보 부를때
        	   if(dSets[i].getName().equals("ds2")){
        		   GauceDataSet ds1 = gis.read("DS2");
				  //Sub 조회
        		   arr_sql[1].append ("{call "+ v_snm +".PR_DB010I_02(?, ?) }" );	//
        		   //커넥션을 변경해보려 했으나 작동하지 않음.. 
        		   //각 스키마에 동일한 프로시저를 다 만드는 걸루..
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1,v_tnm);
					// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	

		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
      
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");
		
		String v_snm  = HDUtil.nullCheckStr(greq.getParameter("v_snm"));	//스키마
		//StringUtil.printMsg(" v_snm===",v_snm,this);
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("ds1의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("COMMENTS", rows[i].getString(ds1.indexOfColumn("COMMENTS")), this);
					//StringUtil.printMsg("TABLE_NAME", rows[i].getString(ds1.indexOfColumn("TABLE_NAME")), this);
					
	                if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE){
						//StringUtil.printMsg("call","업데이트 UPDATE",this);
	                	String tbQry = "COMMENT ON TABLE "+ v_snm +"."+ rows[i].getString(ds1.indexOfColumn("TABLE_NAME")) +" IS '"+ rows[i].getString(ds1.indexOfColumn("COMMENTS")) +"' ";
	                	//StringUtil.printMsg("tbQry==",tbQry,this);
						cstmt = conn.prepareCall(tbQry);
						cstmt.executeUpdate();
	                }
				}//for(int i=0; i<rows.length; i++) the end...
			}//if(ds1!=null) the end...
			if (ds2 != null) {
				GauceDataRow[] 		rows = ds2.getDataRows();
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("ds2의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("COMMENTS", rows[i].getString(ds1.indexOfColumn("COMMENTS")), this);
					//StringUtil.printMsg("TABLE_NAME", rows[i].getString(ds1.indexOfColumn("TABLE_NAME")), this);
					
	                if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE){
						//StringUtil.printMsg("call","업데이트 UPDATE",this);
	                	String colQry = "COMMENT ON COLUMN "+ v_snm +"."+ rows[i].getString(ds2.indexOfColumn("TABLE_NAME")) +"."+ rows[i].getString(ds2.indexOfColumn("COLUMN_NAME")) +" IS '"+ rows[i].getString(ds2.indexOfColumn("COMMENTS")) +"' ";
	                	//StringUtil.printMsg("tbQry==",colQry,this);
						cstmt = conn.prepareCall(colQry);
						cstmt.executeUpdate();
	                }
				}//for(int i=0; i<rows.length; i++) the end...
			}//if(ds2!=null) the end...

			gos.close();
		} catch (SQLException sqle){
        throw sqle;
		} finally {
        if(cstmt!=null) cstmt.close();
		}	   
   }  
}


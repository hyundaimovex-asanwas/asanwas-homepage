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

import sales.common.HDUtil;
import sales.common.StringUtil;
import config.common.SuperServlet;

public class My140I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
      for(int i=0; i<arr_sql.length; i++)
    	  
         arr_sql[i] = new StringBuffer();

      
      //Main 조회
      arr_sql[0].append ("{call COMMON.PR_MY140I_01(?, ?, ?) }" ); //
      
      
      
	  arr_sql[1].append ("{call COMMON.PR_MY140I_03(?, ?) }" );	//권한요청 테이블 검색
	  
	  
	  
	  arr_sql[2].append ("{call COMMON.PR_MY140I_02(?,?,?,?,?,?,?,?) }" );
	  
	  
	  
	  
   }

   public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	   
   }

   
   
   
   // 조회 method
   public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	   
	   
		CallableStatement cstmt = null;
		ResultSet 			rs	= null;

		GauceInputStream gis = greq.getGauceInputStream();
       	GauceOutputStream gos = gres.getGauceOutputStream();
       
		String v_stat 			= HDUtil.nullCheckStr(greq.getParameter("v_stat"));		
       
      try {
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
          GauceDataSet[] dSets = gis.readAllOutput(); 

          
          for(int i=0; i<dSets.length;i++){

        	  
          	if(dSets[i].getName().equals("ds1")){
          		
					GauceDataSet ds1 = gis.read("Main");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					cstmt.setString(1,fParamEmpno);
					cstmt.setString(2,v_stat);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 		
					
					gos.write(getDataSet(rs, ds1));
					
			}
          	
          	
          	if(dSets[i].getName().equals("ds2")){
          		
					GauceDataSet ds1 = gis.read("Sub");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1,fParamEmpno);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 		
					
					gos.write(getDataSet(rs, ds1));
					
					
			}

            if(rs!=null) rs.close();
            if(cstmt!=null) cstmt.close();
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

   
   
   
   /**
    * 기능 :
    * @param req
    * @param res
    *
    */
   public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
      //JSP(I:DS2=ds2,O:RESULT=ds_result)",
		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
       
		/* DataSet */
		GauceDataSet ds2 = gis.read("DS2");
		GauceDataSet dsResult = gis.read("RESULT");
	
		
		
      try{

    	  
			if (ds2 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				
				for(int i=0; i<rows.length; i++){

                    String pEditStatus = "";
                    
              	  	if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
              		  pEditStatus = "1";
                    if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
                  	  pEditStatus = "2";
                    if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
                  	  pEditStatus = "3";
                    
                    
                    cstmt = conn.prepareCall(arr_sql[2].toString());
                         
                    
					//StringUtil.printMsg("상태", rows[i].getString(ds1.indexOfColumn("AUTH_RQ")), this);
					//StringUtil.printMsg("인덱스", rows[i].getString(ds1.indexOfColumn("TREE_IDX")), this);
					//StringUtil.printMsg("로그인 사용자", fParamEmpno, this);
					//StringUtil.printMsg("요청날짜", rows[i].getString(ds1.indexOfColumn("U_DATE")), this);
					//StringUtil.printMsg("pEditStatus", rows[i].getJobType(), this);

                    cstmt.setString(1, 	      rows[i].getString(ds2.indexOfColumn("AUTH_RQ")) );
					cstmt.setString(2, 		  rows[i].getString(ds2.indexOfColumn("TREE_IDX")) );
					cstmt.setString(3,        fParamEmpno);
					cstmt.setString(4,        rows[i].getString(ds2.indexOfColumn("U_DATE")));
					cstmt.setString(5,        pEditStatus);
					cstmt.registerOutParameter(6,   java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7,   java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8,  	java.sql.Types.VARCHAR);
	
					
	                cstmt.executeUpdate();
	                
					//StringUtil.printMsg("요기?", "기본 쿼리 실행 끝", this);
	                
                    String r_s_yn      = cstmt.getString(6);
                    String r_msg_cd    = cstmt.getString(7);
                    String r_msg       = cstmt.getString(8);

                    
                    if(!r_s_yn.equals("Y"))
                    	throw new Exception(r_msg);

                    
                    if(dsResult!=null){
                    	
                            GauceDataRow row1 = dsResult.newDataRow();
                            
                            row1.addColumnValue(r_s_yn);
                            row1.addColumnValue(r_msg_cd);
                            row1.addColumnValue(r_msg);

                            
                            dsResult.addDataRow(row1);
                            
                            
        					//ds.put(columnName[i], HDUtil.nullCheckStr(rs.getString(columnName[i])), rsmd.getColumnDisplaySize(i+1));
        					//ds.heap();//put메소드를 통해 순차적으로 입력된 컬럼의 값을 하나의 행으로 인식하고 GauceDataSet에 적재

			
            		}
				}
			}
		gos.close();
      	} catch (SQLException sqle){
         throw sqle;
      	} finally {
         if(cstmt!=null) cstmt.close();
      	}
   	}  
}
	

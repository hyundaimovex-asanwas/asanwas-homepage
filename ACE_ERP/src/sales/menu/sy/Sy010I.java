package sales.menu.sy;

/*
 * 테이블명 변경, tsy160->tsy011, tsy161->tsy010
 * 필드명 변경 
 * 	1. head_name => head_nm
 *  2. detail_name => detail_nm 
 */

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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Sy010I extends SuperServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//마스터 조회
		arr_sql[0].append ("SELECT 					 \n")
				  .append ("       T1.head		 	\n")
				  .append ("      ,T1.head_nm		\n")
				  .append ("      ,T1.u_empno		\n")
				  .append ("      ,T1.u_ip			\n")
				  .append ("  FROM                              \n")
				  .append ("       SALES.TSY011 T1              	\n")
				  .append (" WHERE 1=1		\n");

		
		//디테일 조회
		arr_sql[1].append ("SELECT 					 \n")
				  .append ("	head, detail, detail_nm, \n") 
				  .append ("	item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, \n")
				  .append ("	u_empno, u_date, u_ip \n")
				  .append ("  FROM SALES.TSY010 \n") 
				  .append (" WHERE head= ? \n");		
		
		
		
		//마스터 apply-입력
		arr_sql[2].append (" INSERT INTO SALES.TSY011 	(head, head_nm, u_empno, u_date,  u_ip ) \n")
				  .append (" VALUES ( ?, ?, ?, SYSTIMESTAMP, ? )  \n");
		
		//마스터 apply-수정
		arr_sql[3].append (" UPDATE SALES.TSY011   \n")
				  .append ("    SET head_nm = ?, u_empno = ?, u_date = SYSTIMESTAMP, u_ip = ?	\n")  
				  .append ("  WHERE head = ?  \n");
				  
		//마스터 apply-삭제
		arr_sql[4].append (" DELETE FROM SALES.TSY011 WHERE head = ?  \n");
		
		
		
		//디테일 apply-입력
		arr_sql[5].append (" INSERT INTO SALES.TSY010 (head, detail, detail_nm,  \n")
				  .append ("  item1, item2, item3, item4, item5, item6, item7, item8, item9, item10,      \n")
				  .append ("  item11, item12, item13, item14, item15,         u_empno, u_date, u_ip )  \n")
				  .append (" VALUES ( ?,?,?,  ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,  ?, SYSTIMESTAMP, ? )  \n");
		
		//디테일 apply-수정
		arr_sql[6].append (" UPDATE SALES.TSY010   \n")
				  .append ("    SET detail_nm=?, item1=?, item2=?, item3=?, item4=?, item5=?, " +
				  		"           item6=?, item7=?, item8=?, item9=?, item10=?, " +
				  		"           item11=?, item12=?, item13=?, item14=?, item15=?, " +
				  		"           u_empno = ?, u_date = SYSTIMESTAMP, u_ip = ?	\n")  
				  .append ("  WHERE head = ? and detail = ?        \n");
				  
		//디테일 apply-삭제
		arr_sql[7].append (" DELETE FROM SALES.TSY010 WHERE head= ? and detail= ?   \n");


   }
	
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		// 검색시 조건
		String  s_Head		= HDUtil.nullCheckStr(greq.getParameter("s_Head"));
		String	s_HeadName 	= HDUtil.nullCheckStr(greq.getParameter("s_HeadName"));
		String  s_Detail	= HDUtil.nullCheckStr(greq.getParameter("s_Detail"));
		//StringUtil.printMsg("s_Head==",s_Head,this);
		//StringUtil.printMsg("s_HeadName==",s_HeadName,this);
		//StringUtil.printMsg("s_Detail==",s_Detail,this);
		
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2)

            	if(dSets[i].getName().equals("ds1")){	//마스터
					GauceDataSet ds1 = gis.read("DS1");

					int sCnt1 = 1;
					whereQuery="";
					
					query = arr_sql[0].toString();
					
					if (!"".equals(s_Head)) {
						whereQuery += " AND head LIKE ? ";
					}					
					if (!"".equals(s_HeadName)) {
						whereQuery 	+= " AND head_nm LIKE ? ";
					}
						whereQuery	+= " ORDER BY head ";
					
					//StringUtil.printMsg(" 조회 쿼리", query+whereQuery,this);
					cstmt = conn.prepareCall(query + whereQuery);
					if (!"".equals(s_Head)) {	
						cstmt.setString(sCnt1++, "%" + s_Head  + "%");
					}					
					if (!"".equals(s_HeadName)) {
						cstmt.setString(sCnt1++, "%" + s_HeadName + "%");
					}


					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds1));// DataSet set
					
				}
            	
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");

					int sCnt2 = 1;
					whereQuery="";
					
					query = arr_sql[1].toString();
					if (!"".equals(s_Detail)) {
						whereQuery 	+= " AND detail= ? ";
					}
						whereQuery	+= " ORDER BY detail ";
					
					cstmt = conn.prepareCall(query + whereQuery);
						cstmt.setString(sCnt2++, s_Head);					
					if (!"".equals(s_Detail)) {
						cstmt.setString(sCnt2++, s_Detail);
					}

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
	
			
			
	// 입력, 수정, 삭제
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* 2013.10.22 심동현
		 * 이렇게 TR을 호출합니다. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	따라서 gis.read로 가져오면 됨.
		 * 
		 * */
	
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");

		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_Head 		= ds1.indexOfColumn("head");		// 분류
				int colNm_HeadName 	= ds1.indexOfColumn("head_nm");		// 분류코드 
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds1의 "+i+"행 작업===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
			
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("ds1--INSERT",arr_sql[2].toString(),this);
						cstmt = conn.prepareCall( arr_sql[2].toString() );
						StringUtil.printMsg("colNm_Head",rows[i].getString(colNm_Head),this);
						StringUtil.printMsg("colNm_HeadName",rows[i].getString(colNm_HeadName),this);
						StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
						StringUtil.printMsg("iParamIp",iParamIp,this);
						cstmt.setString(1, rows[i].getString(colNm_Head));
						cstmt.setString(2, rows[i].getString(colNm_HeadName));
						cstmt.setString(3, iParamEmpno);
						cstmt.setString(4, iParamIp);
						
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();		
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("ds1--","UPDATe",this);
						cstmt = conn.prepareCall( arr_sql[3].toString() );
						
						////StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						cstmt.setString(1, rows[i].getString(colNm_HeadName));
						cstmt.setString(2, iParamEmpno);
						cstmt.setString(3, iParamIp);
						cstmt.setString(4, rows[i].getString(colNm_Head));
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("ds1--","DELETE",this);
						cstmt = conn.prepareCall( arr_sql[4].toString() );
												
						cstmt.setString(1, rows[i].getString(colNm_Head));
						cstmt.executeUpdate();
							
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}
			if (ds2 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				
				int colNm_Head 			= ds2.indexOfColumn("head");		// 분류
				int colNm_Detail 		= ds2.indexOfColumn("detail");			//   
				int colNm_DetailName 	= ds2.indexOfColumn("detail_nm");	//   
				int colNm_Item1 		= ds2.indexOfColumn("item1");			//  
				int colNm_Item2 		= ds2.indexOfColumn("item2");			//  
				int colNm_Item3 		= ds2.indexOfColumn("item3");			//   
				int colNm_Item4 		= ds2.indexOfColumn("item4");			//   
				int colNm_Item5 		= ds2.indexOfColumn("item5");			//   
				int colNm_Item6			= ds2.indexOfColumn("item6");			//   
				int colNm_Item7 		= ds2.indexOfColumn("item7");			//   
				int colNm_Item8 		= ds2.indexOfColumn("item8");			//   
				int colNm_Item9 		= ds2.indexOfColumn("item9");			//   
				int colNm_Item10 		= ds2.indexOfColumn("item10");			//   
				int colNm_Item11		= ds2.indexOfColumn("item11");			//   
				int colNm_Item12 		= ds2.indexOfColumn("item12");			//   
				int colNm_Item13 		= ds2.indexOfColumn("item13");			//   
				int colNm_Item14 		= ds2.indexOfColumn("item14");			//   
				int colNm_Item15 		= ds2.indexOfColumn("item15");			//   
				
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds2의 "+i+"행 작업===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
			
					case GauceDataRow.TB_JOB_INSERT:
								
						cstmt = conn.prepareCall( arr_sql[5].toString() );
						cstmt.setString(1, rows[i].getString(colNm_Head));
						cstmt.setString(2, rows[i].getString(colNm_Detail));
						cstmt.setString(3, rows[i].getString(colNm_DetailName));
						cstmt.setString(4, rows[i].getString(colNm_Item1));
						cstmt.setString(5, rows[i].getString(colNm_Item2));
						cstmt.setString(6, rows[i].getString(colNm_Item3));
						cstmt.setString(7, rows[i].getString(colNm_Item4));
						cstmt.setString(8, rows[i].getString(colNm_Item5));
						cstmt.setString(9, rows[i].getString(colNm_Item6));
						cstmt.setString(10, rows[i].getString(colNm_Item7));
						cstmt.setString(11, rows[i].getString(colNm_Item8));
						cstmt.setString(12, rows[i].getString(colNm_Item9));
						cstmt.setString(13, rows[i].getString(colNm_Item10));
						cstmt.setString(14, rows[i].getString(colNm_Item11));
						cstmt.setString(15, rows[i].getString(colNm_Item12));
						cstmt.setString(16, rows[i].getString(colNm_Item13));
						cstmt.setString(17, rows[i].getString(colNm_Item14));
						cstmt.setString(18, rows[i].getString(colNm_Item15));
						cstmt.setString(19, iParamEmpno);
						cstmt.setString(20, iParamIp);
						
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();		
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
						cstmt = conn.prepareCall( arr_sql[6].toString() );
						
						cstmt.setString(1, rows[i].getString(colNm_DetailName));
						cstmt.setString(2, rows[i].getString(colNm_Item1));
						cstmt.setString(3, rows[i].getString(colNm_Item2));
						cstmt.setString(4, rows[i].getString(colNm_Item3));
						cstmt.setString(5, rows[i].getString(colNm_Item4));
						cstmt.setString(6, rows[i].getString(colNm_Item5));
						cstmt.setString(7, rows[i].getString(colNm_Item6));
						cstmt.setString(8, rows[i].getString(colNm_Item7));
						cstmt.setString(9, rows[i].getString(colNm_Item8));
						cstmt.setString(10, rows[i].getString(colNm_Item9));
						cstmt.setString(11, rows[i].getString(colNm_Item10));
						cstmt.setString(12, rows[i].getString(colNm_Item11));
						cstmt.setString(13, rows[i].getString(colNm_Item12));
						cstmt.setString(14, rows[i].getString(colNm_Item13));
						cstmt.setString(15, rows[i].getString(colNm_Item14));
						cstmt.setString(16, rows[i].getString(colNm_Item15));
						cstmt.setString(17, iParamEmpno);
						cstmt.setString(18, iParamIp);
						cstmt.setString(19, rows[i].getString(colNm_Head));
						cstmt.setString(20, rows[i].getString(colNm_Detail));

						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
						cstmt = conn.prepareCall( arr_sql[7].toString() );
						cstmt.setString(1, rows[i].getString(colNm_Head));
						cstmt.setString(2, rows[i].getString(colNm_Detail));
						cstmt.executeUpdate();
							
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}		
		
	}
	
	
}	
package sales.menu.help;

import java.sql.*;

import javax.servlet.ServletException;

import sales.common.*;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Ac110C extends SuperServlet {

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT HEAD, DETAIL, DETAIL_NM      \n")
				  .append ("FROM   SALES.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND DETAIL = ' ' 					\n");
		
		arr_sql[1].append ("SELECT HEAD, DETAIL, DETAIL_NM, ITEM2      \n")
				  .append ("FROM   SALES.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND Length(rtrim(detail)) > 0		\n");

		arr_sql[2].append ("SELECT '' HEAD, '' DETAIL, '선택' DETAIL_NM, '' AS ITEM2      \n")
				  .append ("FROM   SYSIBM.SYSDUMMY1			                \n")
				  .append ("UNION ALL										\n")
				  .append (arr_sql[1].toString()								);
		
		arr_sql[3].append ("SELECT '' HEAD, '' DETAIL, '전체' DETAIL_NM      \n")
				  .append ("FROM   SYSIBM.SYSDUMMY1			                \n")
				  .append ("UNION ALL										\n")
				  .append ("SELECT HEAD, DETAIL, DETAIL DETAIL_NM      \n")
				  .append ("FROM   SALES.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND Length(rtrim(detail)) > 0		\n");
		
		//dstype=5
		arr_sql[4].append ("SELECT '' HEAD, '' DETAIL, '전체' DETAIL_NM      \n")
				  .append ("FROM   SYSIBM.SYSDUMMY1			                \n")
				  .append ("UNION ALL										\n")
				  .append ("SELECT HEAD, DETAIL, DETAIL_NM AS DETAIL_NM      \n")
				  .append ("FROM   SALES.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND Length(rtrim(detail)) > 0		\n");	
	}
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {

		// TODO Auto-generated method stub
		/* DataBase */
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset(TSY010) 

			// 검색시 조건
			String  s_Head		= HDUtil.nullCheckStr(req.getParameter("s_Head"));
			String	s_Detail	= HDUtil.nullCheckStr(req.getParameter("s_Detail"));
			String  s_DetailNm	= HDUtil.nullCheckStr(req.getParameter("s_DetailNm"));
			String  s_item1 	= HDUtil.nullCheckStr(req.getParameter("s_item1"));
			String  s_item2		= HDUtil.nullCheckStr(req.getParameter("s_item2"));
			String  s_item3		= HDUtil.nullCheckStr(req.getParameter("s_item3"));
			
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			int sCnt1 = 1;
			res.enableFirstRow(ds1);
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					if (!"".equals(s_Head)) 
						arr_sql[0].append (" AND head = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[0].append ("AND (detail_nm LIKE ? or detail LIKE ? ) \n");
//					if (!"".equals(s_DetailNm)) 
//						arr_sql[0].append (" AND detail_nm LIKE ? or detail LIKE ?\n");
					if (!"".equals(s_item1)) 
						arr_sql[0].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[0].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[0].append (" AND item3 = ? \n");
					
					// 쿼리 실행
					stmt = conn.getGauceStatement(arr_sql[0].toString()); 
					//System.out.println(arr_sql[0].toString());
					if (!"".equals(s_Head))	
						stmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
					if (!"".equals(s_DetailNm))	{
						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
					}
					if (!"".equals(s_item1)) 
						stmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						stmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						stmt.setString(sCnt1++, s_item3);
					
					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					break;
				case 2 : //detail이 공백이 아닌 공통코드 검색
					if (!"".equals(s_Head)) 
						arr_sql[1].append (" AND head = ? \n");
//					if (!"".equals(s_Detail))
//						arr_sql[1].append (" AND detail = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[1].append ("AND (detail_nm LIKE ? or detail LIKE ?) \n");
//					if (!"".equals(s_DetailNm)) 
//						arr_sql[1].append (" AND detail_nm LIKE ? or detail LIKE ?\n");
					if (!"".equals(s_item1)) 
						arr_sql[1].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[1].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[1].append (" AND item3 = ? \n");

					// 쿼리 실행
					stmt = conn.getGauceStatement(arr_sql[1].toString()); 
					//System.out.println(arr_sql[1].toString());
					if (!"".equals(s_Head))	
						stmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
//					if (!"".equals(s_DetailNm))	{
//						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//					}
					if (!"".equals(s_item1)) 
						stmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						stmt.setString(sCnt1++, s_item2);
					
					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					break;
				case 3 : //detail이 공백이 아닌 공통코드 검색
					if (!"".equals(s_Head)) 
						arr_sql[2].append (" AND head = ? \n");
//					if (!"".equals(s_Detail))
//						arr_sql[2].append (" AND detail = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[2].append (" AND (detail_nm LIKE ? or detail LIKE ?) \n");
//					if (!"".equals(s_DetailNm)) 
//						arr_sql[2].append (" AND detail_nm LIKE ? or detail LIKE ? \n");
					if (!"".equals(s_item1)) 
						arr_sql[2].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[2].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[2].append (" AND item3 = ? \n");
					
					// 쿼리 실행
					
					stmt = conn.getGauceStatement(arr_sql[2].toString()); 
					//StringUtil.printMsg("item2",s_item2,this);
					//StringUtil.printMsg("취소구분",arr_sql[2].toString(),this);
					if (!"".equals(s_Head))	
						stmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
//					if (!"".equals(s_DetailNm)){	
//						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//					}
					if (!"".equals(s_item1)) 
						stmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						stmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						stmt.setString(sCnt1++, s_item3);

					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					break;
					
				case 4 : //detail이 공백이 아닌 공통코드 검색
					if (!"".equals(s_Head)) 
						arr_sql[3].append (" AND head = ? \n");
//					if (!"".equals(s_Detail))
//						arr_sql[2].append (" AND detail = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[3].append (" AND (detail_nm LIKE ? or detail LIKE ?) \n");
//					if (!"".equals(s_DetailNm)) 
//						arr_sql[2].append (" AND detail_nm LIKE ? or detail LIKE ? \n");
					if (!"".equals(s_item1)) 
						arr_sql[3].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[3].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[3].append (" AND item3 = ? \n");
					
					// 쿼리 실행
					stmt = conn.getGauceStatement(arr_sql[3].toString()); 
					//System.out.println(arr_sql[3].toString());
					if (!"".equals(s_Head))	
						stmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
//					if (!"".equals(s_DetailNm)){	
//						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//						stmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//					}
					if (!"".equals(s_item1)) 
						stmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						stmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						stmt.setString(sCnt1++, s_item3);
					
					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					break;
					
				case 5 : //detail이 공백이 아닌 공통코드 검색
					if (!"".equals(s_Head)) 
						arr_sql[4].append (" AND head = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[4].append (" AND (detail_nm LIKE ? or detail LIKE ?) \n");
					if (!"".equals(s_item1)) 
						arr_sql[4].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[4].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[4].append (" AND item3 = ? \n");
					
					// 쿼리 실행
					stmt = conn.getGauceStatement(arr_sql[4].toString()); 
					if (!"".equals(s_Head))	
						stmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
						stmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
					if (!"".equals(s_item1)) 
						stmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						stmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						stmt.setString(sCnt1++, s_item3);
					
					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					break;					
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}

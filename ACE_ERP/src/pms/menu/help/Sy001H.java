package pms.menu.help;

import java.sql.*;

import javax.servlet.ServletException;
import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;


public class Sy001H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		

		arr_sql[0].append ("SELECT HEAD, DETAIL, DETAIL_NM      \n")
				  .append ("FROM   PMS.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND DETAIL = ' ' 					\n");
		
		arr_sql[1].append ("SELECT HEAD, DETAIL, DETAIL_NM, ITEM2, ITEM15, ITEM4      \n")
				  .append ("FROM   PMS.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND Length(rtrim(detail)) > 0		\n");

		arr_sql[2].append ("SELECT ' ' HEAD, ' ' DETAIL, '선택' DETAIL_NM, ' ' AS ITEM2, ' ' AS ITEM15, ' ' AS ITEM4  \n")
				  .append ("FROM   DUAL \n")
				  .append ("UNION ALL										\n")
				  .append (arr_sql[1].toString()								);
		
		arr_sql[3].append ("SELECT ' ' AS HEAD, ' ' AS DETAIL, '전체' AS DETAIL_NM, ' ' AS ITEM15      \n")
				  .append ("FROM   DUAL \n")
				  .append ("UNION ALL										\n")
				  .append ("SELECT HEAD, DETAIL, DETAIL_NM, ITEM15      \n")
				  .append ("FROM   PMS.TSY010                 \n")
				  .append ("WHERE  Length(rtrim(detail)) > 0		\n");
		
		//dstype=5
		arr_sql[4].append ("SELECT ' ' HEAD, ' ' DETAIL, '전체' DETAIL_NM      \n")
				  .append ("FROM   DUAL \n")
				  .append ("UNION ALL										\n")
				  .append ("SELECT HEAD, DETAIL, DETAIL_NM AS DETAIL_NM      \n")
				  .append ("FROM   PMS.TSY010                 \n")
				  .append ("WHERE 1=1                           \n")
				  .append (" AND Length(rtrim(detail)) > 0		\n");	
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {

	
		/* DataBase */
		//GauceStatement stmt = null;
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		
		/* DataSet */
		GauceDataSet ds1 = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset(TSY010) 

			// 검색시 조건
			String  s_Head		= HDUtil.nullCheckStr(greq.getParameter("s_Head"));
			String	s_Detail	= HDUtil.nullCheckStr(greq.getParameter("s_Detail"));
			String  s_DetailNm	= HDUtil.nullCheckStr(greq.getParameter("s_DetailNm"));
			String  s_item1 	= HDUtil.nullCheckStr(greq.getParameter("s_item1"));
			String  s_item2		= HDUtil.nullCheckStr(greq.getParameter("s_item2"));
			String  s_item3		= HDUtil.nullCheckStr(greq.getParameter("s_item3"));
			String  s_item4		= HDUtil.nullCheckStr(greq.getParameter("s_item4"));
			String  s_item5		= HDUtil.nullCheckStr(greq.getParameter("s_item5"));
			String  s_item6		= HDUtil.nullCheckStr(greq.getParameter("s_item6"));
			String  s_item7		= HDUtil.nullCheckStr(greq.getParameter("s_item7"));
			String  s_item8		= HDUtil.nullCheckStr(greq.getParameter("s_item8"));
			String  s_item9		= HDUtil.nullCheckStr(greq.getParameter("s_item9"));
			String  s_item10	= HDUtil.nullCheckStr(greq.getParameter("s_item10"));
			String  s_item11	= HDUtil.nullCheckStr(greq.getParameter("s_item11"));
			String  s_item12	= HDUtil.nullCheckStr(greq.getParameter("s_item12"));
			String  s_item13	= HDUtil.nullCheckStr(greq.getParameter("s_item13"));
			String  s_item14	= HDUtil.nullCheckStr(greq.getParameter("s_item14"));
			
			/*
			System.out.println("s_Head==========>"+s_Head);
			System.out.println("s_Detail==========>"+s_Detail);
			System.out.println("s_DetailNm==========>"+s_DetailNm);
			System.out.println("s_item1==========>"+s_item1);
			System.out.println("s_item2==========>"+s_item2);
			System.out.println("s_item3==========>"+s_item3);
			System.out.println("s_item4==========>"+s_item4);
			*/
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			int sCnt1 = 1;
			
			//gres.enableFirstRow(ds1);
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
					if (!"".equals(s_item4)) 
						arr_sql[0].append (" AND item4 = ? \n");
					if (!"".equals(s_item5)) 
						arr_sql[0].append (" AND item5 = ? \n");
					if (!"".equals(s_item6)) 
						arr_sql[0].append (" AND item6 = ? \n");
					if (!"".equals(s_item7)) 
						arr_sql[0].append (" AND item7 = ? \n");
					if (!"".equals(s_item8)) 
						arr_sql[0].append (" AND item8 = ? \n");
					if (!"".equals(s_item9)) 
						arr_sql[0].append (" AND item9 = ? \n");
					if (!"".equals(s_item10)) 
						arr_sql[0].append (" AND item10 = ? \n");
					if (!"".equals(s_item11)) 
						arr_sql[0].append (" AND item11 = ? \n");
					if (!"".equals(s_item12)) 
						arr_sql[0].append (" AND item12 = ? \n");
					if (!"".equals(s_item13)) 
						arr_sql[0].append (" AND item13 = ? \n");
					if (!"".equals(s_item14)) 
						arr_sql[0].append (" AND item14 = ? \n");





					
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
					//System.out.println(arr_sql[0].toString());
					
					if (!"".equals(s_Head))	
						cstmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
					/*if (!"".equals(s_DetailNm))	{
						cstmt.setString(sCnt1++, "%" + s_DetailNm + "%");
						cstmt.setString(sCnt1++, "%" + s_DetailNm + "%");
					}*/
					if (!"".equals(s_item1)) 
						cstmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						cstmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						cstmt.setString(sCnt1++, s_item3);
					if (!"".equals(s_item4)) 
						cstmt.setString(sCnt1++, s_item4);
					if (!"".equals(s_item5)) 
						cstmt.setString(sCnt1++, s_item5);
					if (!"".equals(s_item6)) 
						cstmt.setString(sCnt1++, s_item6);
					if (!"".equals(s_item7)) 
						cstmt.setString(sCnt1++, s_item7);
					if (!"".equals(s_item8)) 
						cstmt.setString(sCnt1++, s_item8);
					if (!"".equals(s_item9)) 
						cstmt.setString(sCnt1++, s_item9);
					if (!"".equals(s_item10)) 
						cstmt.setString(sCnt1++, s_item10);
					if (!"".equals(s_item11)) 
						cstmt.setString(sCnt1++, s_item11);
					if (!"".equals(s_item12)) 
						cstmt.setString(sCnt1++, s_item12);
					if (!"".equals(s_item13)) 
						cstmt.setString(sCnt1++, s_item13);
					if (!"".equals(s_item14)) 
						cstmt.setString(sCnt1++, s_item14);

					rs = cstmt.executeQuery(); // DataSet set
					
					//getDataSet(rs, ds1).flush();
					gos.write(getDataSet(rs, ds1));
					break;
					
				case 2 : //detail이 공백이 아닌 공통코드 검색
					//arr_sql[1]=null;
					arr_sql[1].setLength(0);
					//객체를 새로 생성하는 것보다는 길이를 0으로 만드는 것이 좀더 빠르지 않을까 생각이라 함
					arr_sql[1].append ("SELECT HEAD, DETAIL, DETAIL_NM, ITEM2, ITEM15, ITEM4      \n")
					  .append (" FROM   PMS.TSY010                 \n")
					  .append (" WHERE 1=1                           \n")
					  .append (" AND Length(rtrim(detail)) > 0		\n");					
					if (!"".equals(s_Head)) 
						arr_sql[1].append (" AND head = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[1].append ("AND (detail_nm LIKE ? or detail LIKE ?) \n");
					if (!"".equals(s_item1)) 
						arr_sql[1].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[1].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[1].append (" AND item3 = ? \n");
					if (!"".equals(s_item4)) 
						arr_sql[1].append (" AND item4 = ? \n");
					if (!"".equals(s_item5)) 
						arr_sql[1].append (" AND item5 = ? \n");
					if (!"".equals(s_item6)) 
						arr_sql[1].append (" AND item6 = ? \n");
					if (!"".equals(s_item7)) 
						arr_sql[1].append (" AND item7 = ? \n");
					if (!"".equals(s_item8)) 
						arr_sql[1].append (" AND item8 = ? \n");
					if (!"".equals(s_item9)) 
						arr_sql[1].append (" AND item9 = ? \n");
					if (!"".equals(s_item10)) 
						arr_sql[1].append (" AND item10 = ? \n");
					if (!"".equals(s_item11)) 
						arr_sql[1].append (" AND item11 = ? \n");
					if (!"".equals(s_item12)) 
						arr_sql[1].append (" AND item12 = ? \n");
					if (!"".equals(s_item13)) 
						arr_sql[1].append (" AND item13 = ? \n");
					if (!"".equals(s_item14)) 
						arr_sql[1].append (" AND item14 = ? \n");


					//정렬 순서 추가 2008-10-22 심동현
					arr_sql[1].append ("ORDER BY item15 asc \n");
						

					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[1].toString()); 

					
					if (!"".equals(s_Head))	
						cstmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
					if (!"".equals(s_item1)) 
						cstmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						cstmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						cstmt.setString(sCnt1++, s_item3);					
					if (!"".equals(s_item4)) 
						cstmt.setString(sCnt1++, s_item4);
					if (!"".equals(s_item5)) 
						cstmt.setString(sCnt1++, s_item5);
					if (!"".equals(s_item6)) 
						cstmt.setString(sCnt1++, s_item6);
					if (!"".equals(s_item7)) 
						cstmt.setString(sCnt1++, s_item7);
					if (!"".equals(s_item8)) 
						cstmt.setString(sCnt1++, s_item8);
					if (!"".equals(s_item9)) 
						cstmt.setString(sCnt1++, s_item9);
					if (!"".equals(s_item10)) 
						cstmt.setString(sCnt1++, s_item10);
					if (!"".equals(s_item11)) 
						cstmt.setString(sCnt1++, s_item11);
					if (!"".equals(s_item12)) 
						cstmt.setString(sCnt1++, s_item12);
					if (!"".equals(s_item13)) 
						cstmt.setString(sCnt1++, s_item13);
					if (!"".equals(s_item14)) 
						cstmt.setString(sCnt1++, s_item14);

					//System.out.println(arr_sql[1].toString());
					rs = cstmt.executeQuery(); // DataSet set
					//System.out.println(s_Head);
					
					gos.write(getDataSet(rs, ds1));
					break;
				case 3 : //detail이 공백이 아닌 공통코드 검색
					arr_sql[2].setLength(0);//객체를 새로 생성하는 것보다는 길이를 0으로 만드는 것이 좀더 빠르지 않을까 생각이라 함
					arr_sql[2].append ("SELECT ' ' HEAD, ' ' DETAIL, '선택' DETAIL_NM, ' ' AS ITEM2, ' ' AS ITEM15, ' ' AS ITEM4  \n")
					  .append ("FROM   DUAL			                \n")
					  .append ("UNION ALL										\n")
					  .append ("SELECT HEAD, DETAIL, DETAIL_NM, ITEM2, ITEM15, ITEM4      \n")
					  .append ("FROM   PMS.TSY010                 \n")
					  .append ("WHERE 1=1                           \n")
					  .append (" AND Length(rtrim(detail)) > 0		\n");					
					if (!"".equals(s_Head)) 
						arr_sql[2].append (" AND head = ? \n");
					if (!"".equals(s_Detail))
						arr_sql[2].append (" AND (detail_nm LIKE ? or detail LIKE ?) \n");
					if (!"".equals(s_item1)) 
						arr_sql[2].append (" AND item1 = ? \n");
					if (!"".equals(s_item2)) 
						arr_sql[2].append (" AND item2 = ? \n");
					if (!"".equals(s_item3)) 
						arr_sql[2].append (" AND item3 = ? \n");
					if (!"".equals(s_item4)) 
						arr_sql[2].append (" AND item4 = ? \n");
					if (!"".equals(s_item5)) 
						arr_sql[2].append (" AND item5 = ? \n");
					if (!"".equals(s_item6)) 
						arr_sql[2].append (" AND item6 = ? \n");
					if (!"".equals(s_item7)) 
						arr_sql[2].append (" AND item7 = ? \n");
					if (!"".equals(s_item8)) 
						arr_sql[2].append (" AND item8 = ? \n");
					if (!"".equals(s_item9)) 
						arr_sql[2].append (" AND item9 = ? \n");
					if (!"".equals(s_item10)) 
						arr_sql[2].append (" AND item10 = ? \n");
					if (!"".equals(s_item11)) 
						arr_sql[2].append (" AND item11 = ? \n");
					if (!"".equals(s_item12)) 
						arr_sql[2].append (" AND item12 = ? \n");
					if (!"".equals(s_item13)) 
						arr_sql[2].append (" AND item13 = ? \n");
					if (!"".equals(s_item14)) 
						arr_sql[2].append (" AND item14 = ? \n");


					//정렬 순서 추가 2008-10-22 심동현
						arr_sql[2].append ("ORDER BY item15 asc \n");
						
					
					// 쿼리 실행
					
					cstmt = conn.prepareCall(arr_sql[2].toString()); 
					//StringUtil.printMsg("item2",s_item2,this);
					//StringUtil.printMsg("CASE 3",arr_sql[2].toString(),this);
					if (!"".equals(s_Head))	
						cstmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
//					if (!"".equals(s_DetailNm)){	
//						cstmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//						cstmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//					}
					if (!"".equals(s_item1)) 
						cstmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						cstmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						cstmt.setString(sCnt1++, s_item3);
					if (!"".equals(s_item4)) 
						cstmt.setString(sCnt1++, s_item4);
					if (!"".equals(s_item5)) 
						cstmt.setString(sCnt1++, s_item5);
					if (!"".equals(s_item6)) 
						cstmt.setString(sCnt1++, s_item6);
					if (!"".equals(s_item7)) 
						cstmt.setString(sCnt1++, s_item7);
					if (!"".equals(s_item8)) 
						cstmt.setString(sCnt1++, s_item8);
					if (!"".equals(s_item9)) 
						cstmt.setString(sCnt1++, s_item9);
					if (!"".equals(s_item10)) 
						cstmt.setString(sCnt1++, s_item10);
					if (!"".equals(s_item11)) 
						cstmt.setString(sCnt1++, s_item11);
					if (!"".equals(s_item12)) 
						cstmt.setString(sCnt1++, s_item12);
					if (!"".equals(s_item13)) 
						cstmt.setString(sCnt1++, s_item13);
					if (!"".equals(s_item14)) 
						cstmt.setString(sCnt1++, s_item14);


					rs = cstmt.executeQuery(); // DataSet set
					
					gos.write(getDataSet(rs, ds1));
					break;
					
				case 4 : //detail이 공백이 아닌 공통코드 검색
					arr_sql[3].setLength(0);//객체를 새로 생성하는 것보다는 길이를 0으로 만드는 것이 좀더 빠르지 않을까 생각이라 함
					arr_sql[3].append ("SELECT ' ' AS HEAD, ' ' AS DETAIL, '전체' AS DETAIL_NM, ' ' AS ITEM15      \n")
					  .append ("FROM   DUAL \n")
					  .append ("UNION ALL										\n")
					  .append ("SELECT HEAD, DETAIL, DETAIL_NM, ITEM15      \n")
					  .append ("FROM   PMS.TSY010                 \n")
					  .append ("WHERE  Length(rtrim(detail)) > 0		\n");					

					
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
					if (!"".equals(s_item4)) 
						arr_sql[3].append (" AND item4 = ? \n");
					if (!"".equals(s_item5)) 
						arr_sql[3].append (" AND item5 = ? \n");
					if (!"".equals(s_item6)) 
						arr_sql[3].append (" AND item6 = ? \n");
					if (!"".equals(s_item7)) 
						arr_sql[3].append (" AND item7 = ? \n");
					if (!"".equals(s_item8)) 
						arr_sql[3].append (" AND item8 = ? \n");
					if (!"".equals(s_item9)) 
						arr_sql[3].append (" AND item9 = ? \n");
					if (!"".equals(s_item10)) 
						arr_sql[3].append (" AND item10 = ? \n");
					if (!"".equals(s_item11)) 
						arr_sql[3].append (" AND item11 = ? \n");
					if (!"".equals(s_item12)) 
						arr_sql[3].append (" AND item12 = ? \n");
					if (!"".equals(s_item13)) 
						arr_sql[3].append (" AND item13 = ? \n");
					if (!"".equals(s_item14)) 
						arr_sql[3].append (" AND item14 = ? \n");
	
					//정렬 순서 추가 2008-10-22 심동현
					arr_sql[3].append ("ORDER BY item15 asc \n");

					
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[3].toString()); 
					//System.out.println(arr_sql[3].toString());
					//System.out.println(s_Head);
					
					if (!"".equals(s_Head))	
						cstmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
//					if (!"".equals(s_DetailNm)){	
//						cstmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//						cstmt.setString(sCnt1++, "%" + s_DetailNm + "%");
//					}
					if (!"".equals(s_item1)) 
						cstmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						cstmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						cstmt.setString(sCnt1++, s_item3);
					if (!"".equals(s_item4)) 
						cstmt.setString(sCnt1++, s_item4);
					if (!"".equals(s_item5)) 
						cstmt.setString(sCnt1++, s_item5);
					if (!"".equals(s_item6)) 
						cstmt.setString(sCnt1++, s_item6);
					if (!"".equals(s_item7)) 
						cstmt.setString(sCnt1++, s_item7);
					if (!"".equals(s_item8)) 
						cstmt.setString(sCnt1++, s_item8);
					if (!"".equals(s_item9)) 
						cstmt.setString(sCnt1++, s_item9);
					if (!"".equals(s_item10)) 
						cstmt.setString(sCnt1++, s_item10);
					if (!"".equals(s_item11)) 
						cstmt.setString(sCnt1++, s_item11);
					if (!"".equals(s_item12)) 
						cstmt.setString(sCnt1++, s_item12);
					if (!"".equals(s_item13)) 
						cstmt.setString(sCnt1++, s_item13);
					if (!"".equals(s_item14)) 
						cstmt.setString(sCnt1++, s_item14);

					
					rs = cstmt.executeQuery(); // DataSet set
					
					gos.write(getDataSet(rs, ds1));
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
					if (!"".equals(s_item4)) 
						arr_sql[4].append (" AND item4 = ? \n");
					if (!"".equals(s_item5)) 
						arr_sql[4].append (" AND item5 = ? \n");
					if (!"".equals(s_item6)) 
						arr_sql[4].append (" AND item6 = ? \n");
					if (!"".equals(s_item7)) 
						arr_sql[4].append (" AND item7 = ? \n");
					if (!"".equals(s_item8)) 
						arr_sql[4].append (" AND item8 = ? \n");
					if (!"".equals(s_item9)) 
						arr_sql[4].append (" AND item9 = ? \n");
					if (!"".equals(s_item10)) 
						arr_sql[4].append (" AND item10 = ? \n");
					if (!"".equals(s_item11)) 
						arr_sql[4].append (" AND item11 = ? \n");
					if (!"".equals(s_item12)) 
						arr_sql[4].append (" AND item12 = ? \n");
					if (!"".equals(s_item13)) 
						arr_sql[4].append (" AND item13 = ? \n");
					if (!"".equals(s_item14)) 
						arr_sql[4].append (" AND item14 = ? \n");

					
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[4].toString()); 
					if (!"".equals(s_Head))	
						cstmt.setString(sCnt1++, s_Head);
					if (!"".equals(s_Detail)){
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
						cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					}
					if (!"".equals(s_item1)) 
						cstmt.setString(sCnt1++, s_item1);
					if (!"".equals(s_item2)) 
						cstmt.setString(sCnt1++, s_item2);
					if (!"".equals(s_item3)) 
						cstmt.setString(sCnt1++, s_item3);
					if (!"".equals(s_item4)) 
						cstmt.setString(sCnt1++, s_item4);
					if (!"".equals(s_item5)) 
						cstmt.setString(sCnt1++, s_item5);
					if (!"".equals(s_item6)) 
						cstmt.setString(sCnt1++, s_item6);
					if (!"".equals(s_item7)) 
						cstmt.setString(sCnt1++, s_item7);
					if (!"".equals(s_item8)) 
						cstmt.setString(sCnt1++, s_item8);
					if (!"".equals(s_item9)) 
						cstmt.setString(sCnt1++, s_item9);
					if (!"".equals(s_item10)) 
						cstmt.setString(sCnt1++, s_item10);
					if (!"".equals(s_item11)) 
						cstmt.setString(sCnt1++, s_item11);
					if (!"".equals(s_item12)) 
						cstmt.setString(sCnt1++, s_item12);
					if (!"".equals(s_item13)) 
						cstmt.setString(sCnt1++, s_item13);
					if (!"".equals(s_item14)) 
						cstmt.setString(sCnt1++, s_item14);
	
					
					rs = cstmt.executeQuery(); // 쿼리 실행
					
					gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
					break;




				case 6 : //detail이 공백이 아닌 공통코드 검색
					
					// 쿼리 실행
					cstmt = conn.prepareCall("select * from common.menu_auth where userid='6050006' "); 
					
					rs = cstmt.executeQuery(); // DataSet set
					
					//getDataSet(rs, ds1).flush();
					gos.write(getDataSet(rs, ds1));
					break;	
			}
			//gos.close();
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {

	}

}

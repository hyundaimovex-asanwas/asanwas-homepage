/*
 * Created on 2006. 6. 8.
 * 
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.reservation.dao;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.reservation.bean.Price_bean;
 
/** 
 * @author syLee
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PriceInfo  extends DAOHome{

    /**
     * 요금 정보
     * @param 
     * @throws DbException
     * @throws Exception
     * @author syLee
     */
    public Price_bean[] getPriceList(String menu_item1 , String menu_item4, String user_date) throws  Exception{
    	Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Price_bean bean = null;
        Collection list = null; 
        String query = "";
        String subSql =" ";
        String tempPart = "";
        
        if(!menu_item4.equals("30")){  //당일이아니면.....
        	subSql = " AND R1.END_PERSONS <> 1 ";
        }else{ 
        	subSql = "";
        }

       //SQL  
        

		    /*
			.append(" SELECT                                                              \n")
			.append("    B.UPJANG_NM,                                                     \n")
			.append("    B.UPJANG_CD,                                                     \n")
			.append("    A.MENU_ITEM1,MENU_ITEM4,                                         \n")
			.append("    A.MENU_NM,A.END_PERSONS,                                         \n")
			.append("    SUM(CASE WHEN A.MENU_ITEM3 = '1' THEN A.UNIT_AMT END) AS AMT1,   \n")
			.append("    SUM(CASE WHEN A.MENU_ITEM3 = '2' THEN A.UNIT_AMT END) AS AMT2,   \n")
			.append("    SUM(CASE WHEN A.MENU_ITEM3 = '3' THEN A.UNIT_AMT END) AS AMT3,   \n")
			.append("    SUM(CASE WHEN A.MENU_ITEM3 = '4' THEN A.UNIT_AMT END) AS AMT4,   \n")
			.append("    SUM(CASE WHEN A.MENU_ITEM3 = '5' THEN A.UNIT_AMT END) AS AMT5,   \n")
			.append("    SUM(CASE WHEN A.MENU_ITEM3 = '6' THEN A.UNIT_AMT END) AS AMT6    \n")
			.append(" FROM                                                                \n")
			.append(" sales.TRV100 A,sales.TRM010 B                                       \n")
			.append(" WHERE A.UPJANG_SID = B.UPJANG_SID                                   \n")
			.append(" AND B.UPJANG_TYPE='10'                                              \n")
			.append(" AND A.MENU_CD='TU001'                                               \n")
			.append(subSql)
			.append(subSql1)			
			.append(" GROUP BY                                                            \n")
			.append("    B.UPJANG_NM,B.UPJANG_CD, A.MENU_ITEM1,MENU_ITEM4,A.MENU_NM,A.END_PERSONS    ").toString();
            */
        
             /*
			.append(" SELECT \n")
			.append("  R2.UPJANG_NM, \n")
			.append("  R2.UPJANG_CD, \n")
			.append("  R1.ROOM_TYPE_NM,  \n")
			.append("  R1.STD_PERSONS, \n")
			.append("  SALES.FN_USE_ROOM_AMT( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '1' , R1.STD_PERSONS ) AS AMT1 ,  \n")
			.append("  SALES.FN_USE_ROOM_AMT( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '2' , R1.STD_PERSONS ) AS AMT2 ,  \n")
			.append("  SALES.FN_USE_ROOM_AMT( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '3' , R1.STD_PERSONS ) AS AMT3 ,  \n")
			.append("  SALES.FN_USE_ROOM_AMT( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '4' , R1.STD_PERSONS ) AS AMT4 ,  \n")
			.append("  SALES.FN_USE_ROOM_AMT( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '5' , R1.STD_PERSONS ) AS AMT5 ,  \n")
			.append("  SALES.FN_USE_ROOM_AMT( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '6' , R1.STD_PERSONS ) AS AMT6  \n")
			.append(" FROM \n")
			.append("  SALES.TRM030 R1 JOIN SALES.TRM010 R2 ON (R1.UPJANG_SID=R2.UPJANG_SID) \n")
			.append(" WHERE   \n")
			.append("   SALES.FN_USE_ROOM_AMT ( '1' , '"+menu_item1+"' , "+menu_item4+" , R1.ROOM_TYPE_SID , '1' , R1.STD_PERSONS )>0 \n")
			.append("    ORDER BY R2.UPJANG_SID     ").toString();        
        */
             
			String sql = new StringBuffer()
             .append(" SELECT \n")
			 .append(" UPJANG_NM \n")
			 .append(" ,UPJANG_CD \n")
			 .append(" ,MENU_NM \n")
			 .append(" ,BGN_PERSONS || '~' || END_PERSONS AS PERSONS_INFO \n")
			 .append(" ,BGN_PERSONS  \n")
			 .append(" ,UPJANG_SID \n")
			 .append(" , AMT1 \n")
			 .append(" , AMT2 \n")
			 .append(" , AMT3 \n")
			 .append(" , AMT4 \n")
			 .append(" , AMT5 \n")
			 .append(" , AMT6 \n")
			 .append(" FROM \n")
			 .append(" (SELECT  \n")
			 .append(" R2.UPJANG_NM \n")
			 .append(" ,R2.UPJANG_CD \n")
			 .append(" ,R1.MENU_NM \n")
			 .append(" ,R1.BGN_PERSONS \n")
			 .append(" ,R1.END_PERSONS \n")
			 .append(" ,R1.UPJANG_SID \n")
			 .append(" ,SUM(CASE R1.MENU_ITEM3 WHEN '1' THEN R1.UNIT_AMT END) AS AMT1 \n")
			 .append(" ,SUM(CASE R1.MENU_ITEM3 WHEN '2' THEN R1.UNIT_AMT END) AS AMT2 \n")
			 .append(" ,SUM(CASE R1.MENU_ITEM3 WHEN '3' THEN R1.UNIT_AMT END) AS AMT3 \n")
			 .append(" ,SUM(CASE R1.MENU_ITEM3 WHEN '4' THEN R1.UNIT_AMT END) AS AMT4 \n")
			 .append(" ,SUM(CASE R1.MENU_ITEM3 WHEN '5' THEN R1.UNIT_AMT END) AS AMT5 \n")
			 .append(" ,SUM(CASE R1.MENU_ITEM3 WHEN '6' THEN R1.UNIT_AMT END) AS AMT6  \n")
			 .append(" FROM SALES.TRV100 AS R1 JOIN SALES.TRM010 R2 ON (R1.UPJANG_SID=R2.UPJANG_SID) \n")
			 .append(" WHERE R1.MENU_CD='TU001' \n")
			 .append(" AND R1.MENU_ITEM1= '"+menu_item1+"' \n")
			 .append(" AND R1.MENU_ITEM4= '"+menu_item4+"' \n")
			 .append(" AND '"+user_date+"' BETWEEN R1.BGN_DATE AND R1.END_DATE \n")
			 .append(" AND R1.USE_YN='Y'	")
             .append(subSql)
			 .append(" GROUP BY R2.UPJANG_NM,R2.UPJANG_CD,R1.MENU_NM,R1.BGN_PERSONS,R1.END_PERSONS,R1.UPJANG_SID \n")
			 .append(" ) AS TEMP \n")
			 .append(" ORDER BY UPJANG_SID, MENU_NM, BGN_PERSONS, AMT1    ").toString();
             
        try { 
        
            pstmt = dbconn.prepareStatement(sql);
        
            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Price_bean());

            rs.close();
            pstmt.close();
            
            
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Price_bean [])list.toArray(new Price_bean[0]);       
    }
 
}

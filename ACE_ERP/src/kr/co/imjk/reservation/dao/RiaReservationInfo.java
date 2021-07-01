/*
 * Created on 2006. 7. 6.
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
import kr.co.imjk.reservation.bean.RiaReservation_bean;
 
/** 
 * @author �̼ҿ�
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class RiaReservationInfo  extends DAOHome{

	
    /**  
     * ������(�����������) ������ �����´�. </br>
     * @param h_val ȣ���ڵ� 
     * @param r_val �����ڵ�
     * @param ser_date ��������Ʈ
     * @return Reservation_bean[]
     * @throws DbException
     * @author �̼ҿ� 
     */  
 
	public RiaReservation_bean[] getList(RiaReservation_bean date) throws  Exception
	{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        RiaReservation_bean bean = null;
        Collection list = null; 
     	String sql = new String();
        StringBuffer query = new StringBuffer("");
        /*
        query.append("SELECT W.CALN_DATE AS CURR_DATE,                                                                                                                                                                                                               ");
        query.append("       W.UPJANG_SID,                                                                                                                                                                                                                           ");
        query.append("       W.UPJANG_CD,                                                                                                                                                                                                                            ");
        query.append("       W.UPJANG_NM,                                                                                                                                                                                                                            ");
        query.append("       W.ROOM_TYPE_SID,                                                                                                                                                                                                                        ");
        query.append("       W.ROOM_TYPE_CD,                                                                                                                                                                                                                         ");
        query.append("       W.ROOM_TYPE_NM,                                                                                                                                                                                                                         ");
        query.append("       W.ROOM_CNT AS TOTAL,                                                                                                                                                                                                                             ");
        query.append("       W.CNT_1 AS ONE_DAY,                                                                                                                                                                                                                                ");
        query.append("       W.CNT_2 AS TWO_DAY,                                                                                                                                                                                                                                ");
        query.append("       W.RSV_YN,                                                                                                                                                                                                                               ");
        query.append("       MAX(CASE WHEN MENU_ITEM3 = '1' THEN X.UNIT_AMT ELSE 0 END) AS PRICE1,                                                                                                                                                                   ");
        query.append("       MAX(CASE WHEN MENU_ITEM3 = '2' THEN X.UNIT_AMT ELSE 0 END) AS PRICE2,                                                                                                                                                                   ");
        query.append("       MAX(CASE WHEN MENU_ITEM3 = '3' THEN X.UNIT_AMT ELSE 0 END) AS PRICE3,                                                                                                                                                                   ");
        query.append("       MAX(CASE WHEN MENU_ITEM3 = '4' THEN X.UNIT_AMT ELSE 0 END) AS PRICE4,                                                                                                                                                                   ");
        query.append("       MAX(CASE WHEN MENU_ITEM3 = '5' THEN X.UNIT_AMT ELSE 0 END) AS PRICE5,                                                                                                                                                                   ");
        query.append("       MAX(CASE WHEN MENU_ITEM3 = '6' THEN X.UNIT_AMT ELSE 0 END) AS PRICE6                                                                                                                                                                    ");
        query.append("  FROM (SELECT X.CALN_DATE,                                                                                                                                                                                                                    ");
        query.append("               X.UPJANG_SID,                                                                                                                                                                                                                   ");
        query.append("               X.UPJANG_CD,                                                                                                                                                                                                                    ");
        query.append("               X.UPJANG_NM,                                                                                                                                                                                                                    ");
        query.append("               X.UPJANG_ORD,                                                                                                                                                                                                                   ");
        query.append("               X.ROOM_TYPE_SID,                                                                                                                                                                                                                ");
        query.append("               Y.ROOM_TYPE_CD,                                                                                                                                                                                                                 ");
        query.append("               Y.ROOM_TYPE_NM,                                                                                                                                                                                                                 ");
        query.append("               X.ROOM_CNT,                                                                                                                                                                                                                     ");
        query.append("               Y.DISPLAY_SEQ AS ROOM_TYPE_ORD,                                                                                                                                                                                                 ");
        query.append("               X.CNT_1,                                                                                                                                                                                                                        ");
        query.append("               X.CNT_2,                                                                                                                                                                                                                        ");
        query.append("               X.RSV_YN,                                                                                                                                                                                                                       ");
        query.append("               X.RSV_YN1,                                                                                                                                                                                                                      ");
        query.append("               X.RSV_YN2                                                                                                                                                                                                                       ");
        query.append("          FROM (SELECT X.CALN_DATE,                                                                                                                                                                                                            ");
        query.append("                       X.UPJANG_SID,                                                                                                                                                                                                           ");
        query.append("                       Y.UPJANG_CD,                                                                                                                                                                                                            ");
        query.append("                       Y.UPJANG_NM,                                                                                                                                                                                                            ");
        query.append("                       Y.DISPLAY_SEQ AS UPJANG_ORD,                                                                                                                                                                                            ");
        query.append("                       X.ROOM_TYPE_SID,                                                                                                                                                                                                        ");
        query.append("                       X.ROOM_CNT,                                                                                                                                                                                                             ");
        query.append("                       X.CNT_1,                                                                                                                                                                                                                ");
        query.append("                       X.CNT_2,                                                                                                                                                                                                                ");
        query.append("                       X.RSV_YN,                                                                                                                                                                                                               ");
        query.append("                       X.RSV_YN1,                                                                                                                                                                                                              ");
        query.append("                       X.RSV_YN2                                                                                                                                                                                                               ");
        query.append("                  FROM (SELECT CALN_DATE,                                                                                                                                                                                                      ");
        query.append("                               RSV_POS_DATE,                                                                                                                                                                                                   ");
        query.append("                               UPJANG_SID,                                                                                                                                                                                                     ");
        query.append("                               ROOM_TYPE_SID,                                                                                                                                                                                                  ");
        query.append("                               CASE WHEN CALN_DATE < RSV_POS_DATE THEN 0 ELSE ROOM_CNT END AS ROOM_CNT,                                                                                                                                        ");
        query.append("                               CASE WHEN CALN_DATE < RSV_POS_DATE THEN 0 ELSE CNT_1 END AS CNT_1,                                                                                                                                              ");
        query.append("                               CASE WHEN CALN_DATE < RSV_POS_DATE THEN 0 ELSE CNT_2 END AS CNT_2,                                                                                                                                              ");
        query.append("                               CASE WHEN CALN_DATE < RSV_POS_DATE THEN '0'                                                                                                                                                                     ");
        query.append("                               ELSE                                                                                                                                                                                                            ");
        query.append("                                   CASE WHEN CNT_1 > 0 OR CNT_2 > 0 THEN '1' ELSE 0 END                                                                                                                                                        ");
        query.append("                               END AS RSV_YN,                                                                                                                                                                                                  ");
        query.append("                               CASE WHEN CALN_DATE < RSV_POS_DATE THEN '0'                                                                                                                                                                     ");
        query.append("                               ELSE                                                                                                                                                                                                            ");
        query.append("                                   CASE WHEN CNT_1 > 0 THEN '1' ELSE '0' END                                                                                                                                                                   ");
        query.append("                               END AS RSV_YN1,                                                                                                                                                                                                 ");
        query.append("                               CASE WHEN CALN_DATE < RSV_POS_DATE THEN '0'                                                                                                                                                                     ");
        query.append("                               ELSE                                                                                                                                                                                                            ");
        query.append("                                   CASE WHEN CNT_2 > 0 THEN '1' ELSE '0' END                                                                                                                                                                   ");
        query.append("                               END AS RSV_YN2                                                                                                                                                                                                  ");
        query.append("                          FROM (SELECT A.CALN_DATE,                                                                                                                                                                                            ");
        query.append("                                       "+date.getStandard_date()+" AS RSV_POS_DATE,                                                                                                                                                                                      ");
        query.append("                                       B.UPJANG_SID,                                                                                                                                                                                           ");
        query.append("                                       B.ROOM_TYPE_SID,                                                                                                                                                                                        ");
        query.append("                                       B.ROOM_CNT,                                                                                                                                                                                             ");
        query.append("                                       CASE WHEN B.ROOM_TYPE_SID <> 186 THEN                                                                                                                                                                   ");
        query.append("                                           ROOM_CNT - (INVENTORY_CNT + DEFECT_CNT) + OVER_BLOCK_CNT - (PLAN_STAY_CNT + SALES.FN_USE_BLOCK_CNT ('1',B.USE_DATE,0,0,ROOM_TYPE_SID,1) + RSV_BLOCK_CNT + RSV_CNT + INT_RSV_CNT)                    ");
        query.append("                                       ELSE 0 END AS CNT_1,                                                                                                                                                                                    ");
        query.append("                                       CASE WHEN USE_YN2 = 'Y' THEN                                                                                                                                                                            ");
        query.append("                                           ROOM_CNT - (INVENTORY_CNT + DEFECT_CNT) + OVER_BLOCK_CNT - (PLAN_STAY_CNT + SALES.FN_USE_BLOCK_CNT ('1',B.USE_DATE,0,0,ROOM_TYPE_SID,2) + RSV_BLOCK_CNT + RSV_CNT + INT_RSV_CNT)                    ");
        query.append("                                       ELSE 0 END AS CNT_2                                                                                                                                                                                     ");
        query.append("                                  FROM SALES.TSY100 A,                                                                                                                                                                                         ");
        query.append("                                       SALES.TRM050 B                                                                                                                                                                                          ");
        query.append("                                 WHERE A.CALN_DATE BETWEEN "+date.getSer_st_date()+" AND "+date.getSer_ed_date()+"                                                                                                                                                                             ");
        query.append("                                   AND B.USE_DATE = A.CALN_DATE                                                                                                                                                                                ");
        query.append("                                   AND B.SAUP_SID = 1                                                                                                                                                                                          ");
        query.append("                                   AND B.INT_RSV_YN = 'Y') AS X) AS X,                                                                                                                                                                         ");
        query.append("                       SALES.TRM010 Y                                                                                                                                                                                                          ");
        query.append("                 WHERE Y.UPJANG_SID = X.UPJANG_SID                                                                                                                                                                                             ");
        query.append("                   AND Y.USE_YN = 'Y') AS X,                                                                                                                                                                                                   ");
        query.append("               SALES.TRM030 AS Y                                                                                                                                                                                                               ");
        query.append("         WHERE Y.ROOM_TYPE_SID = X.ROOM_TYPE_SID                                                                                                                                                                                               ");
        query.append("           AND Y.USE_YN = 'Y') AS W LEFT JOIN                                                                                                                                                                                                  ");
        query.append("       SALES.TRV100 X                                                                                                                                                                                                                          ");
        query.append("    ON X.MENU_ITEM1 = '10'                                                                                                                                                                                                                     ");
        query.append("   AND X.UPJANG_SID = W.UPJANG_SID                                                                                                                                                                                                             ");
        query.append("   AND X.MENU_ITEM2 = TRIM(CHAR(W.ROOM_TYPE_SID))                                                                                                                                                                                              ");
        query.append(" GROUP BY W.CALN_DATE,W.UPJANG_SID,W.UPJANG_CD,W.UPJANG_NM,W.UPJANG_ORD,W.ROOM_TYPE_SID,W.ROOM_TYPE_CD,W.ROOM_TYPE_NM,W.ROOM_TYPE_ORD,W.ROOM_CNT,W.CNT_1,W.CNT_2,W.RSV_YN,W.RSV_YN1,W.RSV_YN2                                                  ");
        query.append(" ORDER BY W.CALN_DATE,W.UPJANG_ORD,W.ROOM_TYPE_ORD                                                                                                                                                                                             ");        
        */


        query.append("SELECT X.CALN_DATE AS CURR_DATE   "); //--�������ɽ������� : ���� + 15��                                                                                                                                                                                         
        query.append(",X.UPJANG_SID      AS UPJANG_SID  "); //--����SID 
        query.append(",R1.UPJANG_CD      AS UPJANG_CD   "); //-- ����CD
        query.append(",R1.UPJANG_NM      AS UPJANG_NM   "); //-- �����
        query.append(",X.ROOM_TYPE_SID   AS ROOM_TYPE_SID "); //-- ����Ÿ�� SID
        query.append(",R2.ROOM_TYPE_CD   AS ROOM_TYPE_CD  "); //-- ����Ÿ�� CD
        query.append(",R2.ROOM_TYPE_NM   AS ROOM_TYPE_NM  "); //-- ����Ÿ�� ��
        query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_YN1='Y') THEN X.USE_CNT2 ELSE 0 END AS TOTAL    "); //--??? 1�� ������ ���� �س���..�ӽ�
        query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_YN1='Y') THEN X.USE_CNT1 ELSE 0 END AS ONE_DAY  "); //--1�� ������
        query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_YN2='Y') THEN X.USE_CNT2 ELSE 0 END AS TWO_DAY  "); //--2�� ������
        query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE) THEN '1' ELSE '0' END AS RSV_YN  ");	//-- '1'=����, '0'=�Ұ�. 1,2�� �� 1���� �����ϸ� '1'.        
        //query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_CNT1 > 0 AND X.USE_YN1='Y')  "); // 
        //query.append("OR (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_CNT2 > 0 AND X.USE_YN2='Y') THEN '1'  "); //
        //query.append("ELSE '0' END AS RSV_YN   "); //-- '1'=����, '0'=�Ұ�. 1,2�� �� 1���� �����ϸ� '1'.
//        query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_CNT1 > 0 AND X.USE_YN1='Y') THEN '1' "); //
//        query.append("ELSE '0' END AS RSV_YN1  "); //-- '1'=����, '0'=�Ұ�. �¶��ο��� ���ɿ��� (3���� �� �ϳ��� ���� ���ϸ� �ǸźҰ�)
//        query.append(",CASE WHEN (X.CALN_DATE >= X.RSV_POS_DATE AND X.USE_CNT2 > 0 AND X.USE_YN2='Y') THEN '1' "); //
//        query.append("ELSE '0' END AS RSV_YN2  "); //-- '1'=����, '0'=�Ұ�. �¶��ο��� ���ɿ��� (3���� �� �ϳ��� ���� ���ϸ� �ǸźҰ�)
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,27,X.ROOM_TYPE_SID,'1',2) AS PRICE1_1  "); //-- 1�� ���ο��
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,27,X.ROOM_TYPE_SID,'2',2) AS PRICE2_1  "); //-- 1�� ���л�
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,27,X.ROOM_TYPE_SID,'3',2) AS PRICE3_1  "); //-- 1�� �߰��
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,27,X.ROOM_TYPE_SID,'4',2) AS PRICE4_1  "); //-- 1�� �ʵ�
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,27,X.ROOM_TYPE_SID,'5',2) AS PRICE5_1  "); //-- 1�� �Ҿ�
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,27,X.ROOM_TYPE_SID,'6',2) AS PRICE6_1  "); //-- 1�� ����
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,28,X.ROOM_TYPE_SID,'1',2) AS PRICE1  "); //-- 2�� ���ο��
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,28,X.ROOM_TYPE_SID,'2',2) AS PRICE2  "); //-- 2�� ���л�
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,28,X.ROOM_TYPE_SID,'3',2) AS PRICE3  "); //-- 2�� �߰��
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,28,X.ROOM_TYPE_SID,'4',2) AS PRICE4  "); //-- 2�� �ʵ�
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,28,X.ROOM_TYPE_SID,'5',2) AS PRICE5  "); //-- 2�� �Ҿ�
        query.append(",SALES.FN_USE_ROOM_AMT('1',X.CALN_DATE,28,X.ROOM_TYPE_SID,'6',2) AS PRICE6  "); //-- 2�� ����
        query.append("FROM (  "); //
        query.append("SELECT A.CALN_DATE,  "); //                                                                                                                                                                                          
        query.append(" "+date.getStandard_date()+" AS RSV_POS_DATE,    "); //                                                                                                                                                       
        query.append("COALESCE(B.UPJANG_SID,0) AS UPJANG_SID, "); //                                                                                                                                                                                         
        query.append("COALESCE(B.ROOM_TYPE_SID,0) AS ROOM_TYPE_SID, "); //                                                                                                                                                                                      
        query.append("INTEGER((SALES.FN_USE_ROOM_CNT('1', B.USE_DATE, 0, 0, B.ROOM_TYPE_SID, 2)))   AS USE_CNT2, "); // -- ��ĳ���ð��밴�Ǽ�(2��)
        query.append("B.USE_YN2                                                                     AS USE_YN2,  "); //-- ��ĳ���ð��밡��(2��)
        query.append("INTEGER((SALES.FN_USE_ROOM_CNT('1', B.USE_DATE, 0, 0, B.ROOM_TYPE_SID, 1)))   AS USE_CNT1, "); //           -- ����(1��)
        query.append("B.USE_YN1                                                                     AS USE_YN1   "); //          -- ���밡��(1��)
        query.append("FROM SALES.TSY100 AS A LEFT OUTER JOIN SALES.TRM050 AS B "); // 
        query.append("ON ( B.USE_DATE = A.CALN_DATE  "); //
        query.append("AND B.INT_RSV_YN = 'Y'   "); // -- ���ͳ� ���డ���ΰ͸�
        query.append("AND B.SAUP_SID = 1       "); //                                                                                                                                                                                  
        query.append("AND B.UPJANG_SID in (1,2,3,5,6)     "); //-- in (1,2,3,5,6)                                                                                                                                                                           
        query.append(")  "); //
        query.append("WHERE A.CALN_DATE BETWEEN "+date.getSer_st_date()+" AND "+date.getSer_ed_date()+"         "); //
        query.append(") AS X LEFT OUTER JOIN SALES.TRM010 R1 ON (X.UPJANG_SID=R1.UPJANG_SID)  "); //
        query.append("LEFT OUTER JOIN SALES.TRM030 R2 ON (X.ROOM_TYPE_SID=R2.ROOM_TYPE_SID)  "); //
        query.append("ORDER BY X.CALN_DATE, R1.DISPLAY_SEQ, R2.DISPLAY_SEQ       "); //
        
        sql = query.toString();

        ///System.out.println("======================="+sql);

        try 
        {     
            pstmt = dbconn.prepareStatement(sql);

            // ���� ���ε�
            //pstmt.setString(1, date.getStandard_date());
            //pstmt.setString(2, date.getSer_st_date());
            //pstmt.setString(3, date.getSer_ed_date());
            //pstmt.setString(4, date.getStandard_date());

            // ��� ���
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new RiaReservation_bean());

            rs.close();
            pstmt.close();
        } 
        catch (SQLException e) 
        {
            throw new DbException(e.getMessage());
        }
        finally
        {
            release(pstmt);
            freeConnection(dbconn);
        }
        return (RiaReservation_bean [])list.toArray(new RiaReservation_bean[0]);
    }	
	
}


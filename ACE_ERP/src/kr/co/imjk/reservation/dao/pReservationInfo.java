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
import java.util.*;
import java.io.*;
import java.math.BigDecimal;

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.board.dao.CommonBoard;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.util.Util;
import kr.co.imjk.reservation.bean.Reservation_bean;
import kr.co.imjk.reservation.bean.Schedule_bean;

import java.sql.CallableStatement;
/** 
 * @author 이소연
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class pReservationInfo  extends DAOHome{

    /**
     *  나의예약보기 입장(인증)
     * @param board_seq 메인 게시판 일련번호
     * @return Reservation_bean []
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	public Reservation_bean [] getRevUser(String r_mail, String r_pass)  throws DbException , Exception 
{
    Connection dbconn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Collection list = null;

    // SQL
	String query = new StringBuffer()
	.append(" SELECT                            \n")
	.append("    Count(*) AS CNT,               \n")
	.append("    rMail, rPass                   \n")
	.append(" FROM                              \n")
	//.append("   walib.wa_rsvinfo                \n")
    .append("  SALES.TRV070                     \n")
	.append(" WHERE rMail=?                     \n")
	.append("       AND rPass=?                 \n")
	.append(" GROUP BY rMail, rPass               ").toString();
	
    try {         
        pstmt = dbconn.prepareStatement(query);
        // 변수 바인딩
        pstmt.setString(1, r_mail);
        pstmt.setString(2, r_pass);

        // 결과 담기
        rs = pstmt.executeQuery();
        list = Selecter.execute(rs, new Reservation_bean());

        rs.close();
        pstmt.close();
    
    } catch (SQLException e) {
        throw new DbException(e.getMessage());
    }finally{
        release(pstmt);
        freeConnection(dbconn);
    }
    return (Reservation_bean [])list.toArray(new Reservation_bean[0]);
}
	

    /**
     *  회원 예약시(인증)
     * @param 
     * @return Reservation_bean []
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	public Reservation_bean [] getLogin(String id)  throws DbException , Exception 
{
    Connection dbconn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Collection list = null;

    // SQL
	String query = new StringBuffer()
	.append(" SELECT                            \n")
	.append("    PWD AS rPass, EMAIL AS rMail    \n")
	.append(" FROM                              \n")
	.append("   ASAN.MEMBER                    \n")
	.append(" WHERE ID=?                           ").toString();

    try {         
        pstmt = dbconn.prepareStatement(query);
        // 변수 바인딩
        pstmt.setString(1, id);

        // 결과 담기
        rs = pstmt.executeQuery();
        list = Selecter.execute(rs, new Reservation_bean());

        rs.close();
        pstmt.close();
    
    } catch (SQLException e) {
        throw new DbException(e.getMessage());
    }finally{
        release(pstmt);
        freeConnection(dbconn);
    }
    return (Reservation_bean [])list.toArray(new Reservation_bean[0]);
}	


    /**
     * 게시물 전체 총 갯수
     * @param r_mail 검색 이메일
     * @param r_pass 검색 비밀번호
     * @return Reservation_bean []
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	public int getTotalCount(String r_mail, String r_pass ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

		String query = "";
        String subSql =" ";

		int totalCount = 0;

		query = new StringBuffer()
			.append(" SELECT COUNT(*) as TOTAL        \n")
			//.append(" from walib.wa_rsvinfo           \n")
            .append(" from SALES.TRV070           \n")
			.append(" WHERE RMAIL = ? AND RPASS =?    \n")
			.append(subSql).toString(); 

		try {         
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
			pstmt.setString(1, r_mail);  
			pstmt.setString(2, r_pass);
			rs = pstmt.executeQuery();

			if(rs.next()){
				totalCount = rs.getInt("TOTAL");
			}

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return totalCount;

	 }
	
    /**  
     * 예약 리스트 정보를 가져온다. </br>
     * @param rowsPerPage 페이지별 row 수 
     * @param requestedPage 호출 페이지 번호
     * @param part 검색할 디비컬럼
     * @param keyword 검색한 단어
     * @return Reservation_bean[]
     * @throws DbException
     * @author 이소연 
     */  
    
    public Reservation_bean[] getList(int pageSize, int requestedPage,  String r_mail, String r_pass ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Reservation_bean bean = null;
        Collection list = null; 
        String query = "";
        String tempPart = "";
        
        int chk_page = requestedPage-1;
        
        StringBuffer sql = new StringBuffer();
        
        // 페이징 처리
        if(chk_page > 0){      
        	query = new StringBuffer() 
        	.append(" SELECT                                                    \n")
	        .append("    IDX,                                                   \n")
	        .append("    RACCEPT_NO AS ACCEPT_NO,                           \n")
            .append("    RNAME, RPASS, RTEL, RMOB, RMAIL,                       \n")
		    .append("    substr(RSTDT,1,4) concat '-'  concat substr(RSTDT,5,2) concat '-'  concat substr(RSTDT,7,2) concat '' AS RSTDT,  \n")
            .append("    substr(REDT,1,4) concat '-'  concat substr(REDT,5,2) concat '-'  concat substr(REDT,7,2) concat '' AS REDT,  \n")
			.append("    RNAME, RPASS, RTEL, RMOB, RMAIL,                       \n")
            .append("    CASE RSTAT WHEN '1' THEN '정상'                         \n")
			.append("       WHEN '3' THEN '취소'                                 \n")
			.append("     END as RSTAT,                                         \n")			
            .append("    CASE rScod WHEN '27' THEN '1박2일'                 \n")
			.append("       WHEN '28' THEN '2박3일'                         \n")
			.append("     END as DAYNIGHT,                                      \n")
			.append("     (YEAR(REGTIME) concat '-' concat MONTH(REGTIME) concat '-' concat DAY(REGTIME)) as REGDATE,  \n")
			.append("      REGTIME,                                             \n")
            .append("     (YEAR(REGTIME + 3 days) concat '-' concat MONTH(REGTIME + 3 days) concat '-' concat DAY(REGTIME + 3 days) concat '&nbsp08:00:00') as FINAL_TIME,    \n")
            .append(" 	   CASE WHEN REGTIME + 3 days < current timestamp THEN '취소'                                                                      \n")
            .append(" 	   	     WHEN REGTIME + 3 days > current timestamp THEN '정상'                                                                      \n")
            .append(" 		   	 END AS FINAL_TYPE                                                                                                         \n")			
            .append(" FROM SALES.TRV070  WHERE IDX NOT IN                    \n")
	        .append(" ( select IDX from                                         \n")		
            //.append(" 		( select RACCEPT_NO from SALES.TRV070 where RMAIL=? and RPASS = ?           \n")
            .append(" 		( select IDX from SALES.TRV070 where RMAIL=? and RPASS = ?           \n")
	        .append(" 		  order by IDX                                                           \n")
	        .append("         fetch first "+((requestedPage-1) * pageSize)+" rows only  )            \n")
	        .append(" as tmp ) AND                                              \n")
	        .append(" RMAIL=? and RPASS = ?                                     \n")
	        .append(" order by IDX DESC")
	        .append(" fetch first "+pageSize+" rows only                        \n").toString();
			
        }else{         	
        	query = new StringBuffer()
        	.append(" SELECT   \n")
	        .append("    IDX,                                                   \n")
	        .append("    RACCEPT_NO AS ACCEPT_NO,                           \n")
            .append("    RNAME, RPASS, RTEL, RMOB, RMAIL,          \n")
		    .append("    substr(RSTDT,1,4) concat '-'  concat substr(RSTDT,5,2) concat '-'  concat substr(RSTDT,7,2) concat '' AS RSTDT,  \n")
            .append("    substr(REDT,1,4) concat '-'  concat substr(REDT,5,2) concat '-'  concat substr(REDT,7,2) concat '' AS REDT,  \n")
            .append("    CASE RSTAT WHEN '1' THEN '정상'                         \n")
			.append("       WHEN '3' THEN '취소'                                 \n")
			.append("     END as RSTAT,                                         \n")				
            .append("    CASE rScod WHEN '27' THEN '1박2일'                 \n")
			.append("       WHEN '28' THEN '2박3일'                         \n")
			.append("     END as DAYNIGHT,                                      \n")
			.append("     (YEAR(REGTIME) concat '-' concat MONTH(REGTIME) concat '-' concat DAY(REGTIME)) as REGDATE,  \n")
			.append("      REGTIME,                                             \n")
            .append("     (YEAR(REGTIME + 3 days) concat '-' concat MONTH(REGTIME + 3 days) concat '-' concat DAY(REGTIME + 3 days)  concat '&nbsp08:00:00') as FINAL_TIME,    \n")
            .append(" 	   CASE WHEN REGTIME + 3 days < current timestamp THEN '취소'                                                                      \n")
            .append(" 	   	     WHEN REGTIME + 3 days > current timestamp THEN '정상'                                                                      \n")
            .append(" 		   	 END AS FINAL_TYPE                                                                                                         \n")						
            .append(" from SALES.TRV070                                      \n")
        	.append(" where RMAIL=? and RPASS = ?                               \n")
        	.append(" order by IDX DESC                                             \n")
        	.append(" fetch first 10 rows only                                  \n").toString();

        }
        System.out.println("-------"+query);
        try {         
            pstmt = dbconn.prepareStatement(query.toString());
            
            // 변수 바인딩
            if(chk_page > 0){   
	            pstmt.setString(1, r_mail); 
	            pstmt.setString(2, r_pass);
	            pstmt.setString(3, r_mail); 
	            pstmt.setString(4, r_pass);
            }else{
                pstmt.setString(1, r_mail); 
                pstmt.setString(2, r_pass);
            }
        
            
            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Reservation_bean());
           
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Reservation_bean [])list.toArray(new Reservation_bean[0]);

    }	
	
	
    /**
     *   예약 내용 보기
     * @param idx 구분키
     * @return Reservation_bean []
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	public Reservation_bean [] getRevInfo(int idx) 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;

        // SQL
        
        /*.append(" SELECT                                                                                                  \n")
		.append("    A.ACCEPT_SID,                                                                                        \n")
		.append("    substr(B.DEPART_DATE,1,4) concat '년&nbsp;'  concat substr(B.DEPART_DATE,5,2) concat '월&nbsp;'  concat substr(B.DEPART_DATE,7,2) concat '일' AS DEPART_DATE,  \n")
        .append("    substr(B.ARRIVE_DATE,1,4) concat '년&nbsp;'  concat substr(B.ARRIVE_DATE,5,2) concat '월&nbsp;'  concat substr(B.ARRIVE_DATE,7,2) concat '일' AS ARRIVE_DATE,  \n")
		.append("    CASE B.NIGHTS WHEN '0' THEN '1박0일'                                                                  \n")
		.append("     WHEN '1' THEN '1박2일'                                                                               \n")
		.append("     WHEN '2' THEN '2박3일'                                                                               \n")
		.append("    END as NIGHTS,                                                                                       \n")
		.append("    (YEAR(C.REGTIME) concat '-' concat MONTH(C.REGTIME) concat '-' concat DAY(C.REGTIME)) as REGDATE,    \n")
		.append("    (HOUR(C.REGTIME)concat ':' concat MINUTE(C.REGTIME) concat ':' concat SECOND(C.REGTIME)) AS REGTIME, COUNT(*) AS CNT,                                                                           \n")
		.append("    CASE WHEN B.TOT_TOUR_AMT-B.TOT_PAY_AMT = 0 THEN '완납'                                                \n")
		.append("         WHEN B.TOT_PAY_AMT >0 AND B.TOT_TOUR_AMT-B.TOT_PAY_AMT > 0 THEN '분납'                           \n")
		.append("         WHEN B.TOT_PAY_AMT = 0 THEN '미납'                                                               \n")
		.append("    END as RSTAT,                                                                                        \n")
		.append("    B.TOT_TOUR_AMT,B.TOT_PAY_AMT,                                                                        \n")
		.append("    C.RNAME,C.RMAIL,C.RMOB,C.RTEL,                                                                       \n")
        .append("    (YEAR(REGTIME + 3 days) concat '-' concat MONTH(REGTIME + 3 days) concat '-' concat DAY(REGTIME + 3 days) concat '&nbsp08:00:00') as FINAL_TIME,    \n")
        .append("      CASE WHEN REGTIME + 3 days < current timestamp THEN 'F'     \n")
        .append("           WHEN REGTIME + 3 days > current timestamp THEN 'I'     \n")
        .append("      END AS FINAL_TYPE,                                          \n")
        .append("      C.RSCOD,                                                    \n")
		.append("      (SELECT GOODS_CD FROM SALES.TRM200 WHERE GOODS_CD=C.RSCOD) AS GOODS_CD ,                           \n")
		.append("      (SELECT GOODS_NM FROM SALES.TRM200 WHERE GOODS_CD=C.RSCOD) AS GOODS_NM                             \n")
		.append(" FROM                                                                                                    \n")
		.append("     SALES.TRV010 A,                                                                                     \n")
		.append("     SALES.TRV020 B,                                                                                     \n")
		.append("     WALIB.WA_RSVINFO C                                                                                  \n")
		.append(" WHERE                                                                                                   \n")
		.append("     A.ACCEPT_NO IN (                                                                                    \n")
		.append("             SELECT '99000' concat IDX                                                                   \n")
		.append("             FROM WALIB.WA_RSVINFO                                                                       \n")
		.append("             WHERE IDX=?)                                                                                \n")
		.append("     AND                                                                                                 \n")
		.append("     A.ACCEPT_SID=B.ACCEPT_SID                                                                           \n")
		.append("     AND                                                                                                 \n")
		.append("     A.ACCEPT_NO='99000' concat IDX                                                                      \n")
		.append(" GROUP BY                                                                                                \n")
		.append("     A.ACCEPT_SID, B.DEPART_DATE, B.ARRIVE_DATE,NIGHTS,C.REGTIME,B.TOT_TOUR_AMT,                         \n")
		.append("     B.TOT_PAY_AMT,B.TOT_PAY_AMT,C.RNAME,C.RMAIL,C.RMOB,C.RTEL,C.RSCOD                                   \n").toString();*/
        
        /*
		String query = new StringBuffer()
		.append(" SELECT                                                                                                                                                 \n")                                                                                    
		.append("     A.ACCEPT_SID,                                                                                                                                      \n")
		.append("     substr(B.DEPART_DATE,1,4) concat '-'  concat substr(B.DEPART_DATE,5,2) concat '-'  concat substr(B.DEPART_DATE,7,2) concat '' AS DEPART_DATE,      \n")
		.append("     substr(B.ARRIVE_DATE,1,4) concat '-'  concat substr(B.ARRIVE_DATE,5,2) concat '-'  concat substr(B.ARRIVE_DATE,7,2) concat '' AS ARRIVE_DATE,      \n")
		.append("     CASE B.NIGHTS WHEN '0' THEN '1박0일(당일)'                                                                                                           \n")
		.append("      WHEN '1' THEN '1박2일'                                                                                                                             \n")
		.append("      WHEN '2' THEN '2박3일'                                                                                                                             \n")
		.append("     END as NIGHTS,                                                                                                                                     \n")
		.append("     (YEAR(C.REGTIME) concat '-' concat MONTH(C.REGTIME) concat '-' concat DAY(C.REGTIME)) as REGDATE,                                                  \n")
		.append("     (HOUR(C.REGTIME)concat ':' concat MINUTE(C.REGTIME) concat ':' concat SECOND(C.REGTIME)) AS REGTIME,                                               \n")
		.append("     COUNT(*) AS CNT,                                                                                                                                   \n")
		.append("     CASE WHEN D.USE_AMT-SALES.FN_PAY_AMT('3',B.RSV_SID,'N') = 0 THEN '완료'                                                                             \n")
		.append("          WHEN SALES.FN_PAY_AMT('3',B.RSV_SID,'N') >0 AND D.USE_AMT-SALES.FN_PAY_AMT('3',B.RSV_SID,'N')> 0 THEN '진행'                                   \n")
		.append("          WHEN SALES.FN_PAY_AMT('3',B.RSV_SID,'N')= 0 THEN '미납'                                                                                        \n")
		.append("     END as RSTAT,                                                                                                                                      \n")
		.append("     D.USE_AMT AS TOT_TOUR_AMT,SALES.FN_PAY_AMT('3',B.RSV_SID,'N') AS TOT_PAY_AMT,                                                                      \n")
		.append("     C.RNAME,C.RMAIL,C.RMOB,C.RTEL,                                                                                                                     \n")
		.append("     (YEAR(REGTIME + 3 days) concat '-' concat MONTH(REGTIME + 3 days) concat '-' concat DAY(REGTIME + 3 days) concat '&nbsp08:00:00') as FINAL_TIME,   \n") 
		.append("       CASE WHEN REGTIME + 3 days < current timestamp THEN 'F'                                                                                          \n")
		.append("            WHEN REGTIME + 3 days > current timestamp THEN 'I'                                                                                          \n")
		.append("       END AS FINAL_TYPE,                                                                                                                               \n")
		.append("       C.RSCOD                                                                                                                                         \n")
		.append("       ,(SELECT GOODS_CD FROM SALES.TRM200 WHERE GOODS_CD=C.RSCOD) AS GOODS_CD ,                                                                         \n")
		.append("       (SELECT GOODS_NM FROM SALES.TRM200 WHERE GOODS_CD=C.RSCOD) AS GOODS_NM                                                                           \n")
		.append("  FROM                                                                                                                                                  \n")
		.append("      SALES.TRV010 A,                                                                                                                                   \n")
		.append("      SALES.TRV020 B,                                                                                                                                   \n")
		.append("      SALES.TRV070 C,                                                                                                                                   \n")
		.append("      SALES.TRV030 D                                                                                                                                    \n")
		.append("  WHERE                                                                                                                                                 \n")
		.append("      A.ACCEPT_NO IN (                                                                                                                                  \n")
		//.append("              SELECT '99000' concat IDX                                                                                                               \n")
        .append("              SELECT RACCEPT_NO                                                                                                                                \n")
		.append("              FROM SALES.TRV070                                                                                                                         \n")
		.append("              WHERE IDX=?)    AND                                                                                                                       \n")
		.append("      A.ACCEPT_SID=B.ACCEPT_SID    AND                                                                                                                  \n")
		.append("      B.RSV_SID=D.RSV_SID  AND                                                                                                                          \n")
		//.append("      A.ACCEPT_NO='99000' concat IDX                                                                                                                  \n")
        .append("      A.ACCEPT_NO=C.RACCEPT_NO                                                                                                                          \n")
		.append("  GROUP BY                                                                                                                                              \n")
		.append("     A.ACCEPT_SID, B.DEPART_DATE, B.ARRIVE_DATE,NIGHTS,C.REGTIME,                                                                                       \n")
		.append("     C.RNAME,C.RMAIL,C.RMOB,C.RTEL,C.RSCOD, D.USE_AMT, B.RSV_SID                                                                                        ").toString();		
*/
        
		String query = new StringBuffer()
        .append(" SELECT  RACCEPT_NO AS ACCEPT_NO,                                                                                                                             \n")
        .append(" 	   substr(C.RSTDT,1,4) || '-' || substr(C.RSTDT,5,2) || '-' || substr(C.RSTDT,7,2) || '' AS DEPART_DATE                            \n")
        .append(" 	   ,substr(C.REDT,1,4) || '-' || substr(C.REDT,5,2) || '-' || substr(C.REDT,7,2) || '' AS ARRIVE_DATE                              \n")
        .append(" 	   ,CASE C.RSCOD WHEN '28' THEN '2박3일'                                                                                      \n")
        .append(" 	   		WHEN '27' THEN '1박8시'                                                                                               \n")
        .append(" 			END as NIGHTS                                                                                                              \n")
        .append(" 	   ,(YEAR(C.REGTIME) || '-' || MONTH(C.REGTIME) || '-' || DAY(C.REGTIME)) as REGDATE                                               \n")
        .append(" 	   ,(HOUR(C.REGTIME) || ':' || MINUTE(C.REGTIME) || ':' || SECOND(C.REGTIME)) AS REGTIME	                                       \n")
        .append(" 	   ,(SELECT COUNT(CUST_SID) FROM SALES.TRV020 WHERE ACCEPT_SID=B.ACCEPT_SID) AS CNT	                                               \n")
        .append(" 	   ,(SELECT SUM(USE_AMT) FROM SALES.TRV030 WHERE RSV_SID IN                                                                        \n")
        .append(" 	   	(SELECT RSV_SID FROM SALES.TRV020 WHERE ACCEPT_SID=B.ACCEPT_SID) ) AS SUM_PRICE                                         \n")
        .append(" 	   ,CASE WHEN C.REGTIME + 3 days < current timestamp THEN '취소'                                                                      \n")
        .append(" 	   	     WHEN C.REGTIME + 3 days > current timestamp THEN '정상'                                                                      \n")
        .append(" 		   	 END AS FINAL_TYPE                                                                                                         \n")
        .append(" 	   ,(YEAR(REGTIME + 3 days) || '-' || MONTH(REGTIME + 3 days) || '-' || DAY(REGTIME + 3 days) || ' 08:00:00') as FINAL_TIME        \n")
        .append(" 	   ,C.RNAME                                                                                                                        \n")
        .append(" 	   ,C.RMAIL                                                                                                                        \n")
        .append(" 	   ,C.RMOB	                                                                                                                       \n")
        .append(" 	   ,C.RTEL                                                                                                                         \n")
        .append(" 	   ,C.RSCOD                                                                                                                        \n")
        .append(" 	   ,A.UPJANG_SID                                                                                                                   \n")
        .append(" 	   ,A.ROOM_TYPE_SID                                                                                                                \n")
        .append(" 	   ,D.CUST_NM                                                                                                                      \n")
        .append(" 	   ,D.MANAGE_NO                                                                                                                    \n")
        .append(" 	   ,D.ADDRESS1                                                                                                                     \n")
        .append(" 	   ,A.AGE_CD                                                                                                                       \n")
        .append(" 	   ,E.USE_AMT  AS TOT_TOUR_AMT                                                                                                                    \n")
        .append(" 	   ,(SELECT COALESCE(PAY_AMT,0) FROM SALES.TRV200 WHERE RSV_SID=A.RSV_SID) AS PAY_AMT                                              \n")
        .append(" 	   ,(SELECT PAY_YN FROM SALES.TRV200 WHERE RSV_SID=A.RSV_SID) AS PAY_YN                                                            \n")
        .append(" 	   ,(SELECT PAY_MANAGE_NO FROM SALES.TRV200 WHERE RSV_SID=A.RSV_SID) AS PAY_MANAGE_NO	                                           \n")
        .append(" 	   ,A.RSV_SID	                                                                                                                   \n")
        .append(" 	   ,A.CUST_SID	                                                                                                                   \n")
        .append(" 	   ,B.ACCEPT_SID	                                                                                                               \n")
        .append(" FROM SALES.TRV070 AS C JOIN SALES.TRV010 AS B ON (C.RACCEPT_NO=B.ACCEPT_NO)                                                          \n")
        .append("  	 JOIN SALES.TRV020 AS A ON (A.ACCEPT_SID=B.ACCEPT_SID)                                                                             \n")
        .append(" 	 JOIN SALES.TCU010 AS D ON (A.CUST_SID=D.CUST_SID)                                                                                 \n")
        .append(" 	 JOIN SALES.TRV030 AS E ON (A.RSV_SID=E.RSV_SID)                                                                                   \n")
        .append(" WHERE C.IDX=?                                                                                                                        ").toString();	     
        
        try { 

        	System.out.println("------idx---------"+idx);
        	System.out.println("------query---------"+query);
        	
            pstmt = dbconn.prepareStatement(query);
            
            // 변수 바인딩 
            pstmt.setInt(1, idx); 

            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Reservation_bean());
            
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Reservation_bean [])list.toArray(new Reservation_bean[0]);
    } 
	
	
    /**  
     * 관광객정보 리스트 정보를 가져온다. </br>
     * @param accept_sid 신청sid
     * @return Reservation_bean[]
     * @throws DbException
     * @author 이소연 
     */  
    
    public Reservation_bean[] getTourList(int accept_sid ) throws  Exception{
        
    	
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Reservation_bean bean = null;
        Collection list = null; 
     	
        String query = new StringBuffer()
		/*
		.append(" SELECT                                                                                             \n")
		.append("     A.RSV_SID, A.CUST_SID, A.ACCEPT_SID ,                                                          \n")
		.append("     B.CUST_NM,SUBSTR(B.REGI_NO,1,6) concat '-' concat SUBSTR(B.REGI_NO,7,7) AS REGI_NO ,B.REGI_YN, \n")
		.append("     (SELECT UPJANG_NM FROM SALES.TRM010 WHERE UPJANG_SID=A.UPJANG_SID) AS HOTEL_NM,                \n")
		.append("     (SELECT ROOM_TYPE_NM FROM SALES.TRM030 WHERE ROOM_TYPE_SID=A.ROOM_TYPE_SID) AS ROOM_NM,        \n")
		.append("     A.UPJANG_SID,A.ROOM_TYPE_SID,                                                                  \n")
		.append("     A.UPJANG_SID concat A.ROOM_TYPE_SID AS UPJANG_INFO,                                            \n")
		.append("     CASE WHEN A.TOT_TOUR_AMT-A.TOT_PAY_AMT = 0 THEN '완납'                                          \n")
		.append("          WHEN A.TOT_PAY_AMT = 0 THEN '미납'                                                         \n")
		.append("     END as RSTAT, A.TOT_TOUR_AMT,                                                                   \n")
		.append("      CASE WHEN B.TEL_NO = '' OR B.MOBILE_NO = '' OR B.ZIP_CD = '' OR B.ADDRESS1 = '' OR B.ADDRESS2 = '' OR B.COMPANY_NM != '직장명' OR B.POSITIONS != '직위' THEN '완료'          \n")
		.append("           WHEN B.TEL_NO != '' OR B.MOBILE_NO != '' OR B.ZIP_CD != '' OR B.ADDRESS1 != '' OR B.ADDRESS2 != '' OR B.COMPANY_NM = '직장명' OR B.POSITIONS = '직위' THEN '미입력'  \n")
		.append("      END TSTDT                                                                                   \n")
		.append(" FROM SALES.TRV020 A,                                                                             \n")
		.append("      SALES.TCU010 B                                                                              \n")
		.append(" WHERE                                                                                            \n")
		.append("      A.CUST_SID=B.CUST_SID                                                                       \n")
		.append("      AND                                                                                         \n")
		.append("      A.ACCEPT_SID=?                                                                                ").toString();
        */
		
		.append("  SELECT                             \n")                                                                 
		.append("      A.STATUS_CD, A.RSV_SID, A.CUST_SID, A.ACCEPT_SID ,               \n")                                             
		.append("      B.CUST_NM,SUBSTR(B.REGI_NO,1,6) concat '-' concat SUBSTR(B.REGI_NO,7,7) AS REGI_NO ,B.REGI_YN,  \n")
		.append("      (SELECT UPJANG_NM FROM SALES.TRM010 WHERE UPJANG_SID=A.UPJANG_SID) AS HOTEL_NM,                 \n")
		.append("      (SELECT ROOM_TYPE_NM FROM SALES.TRM030 WHERE ROOM_TYPE_SID=A.ROOM_TYPE_SID) AS ROOM_NM,         \n")
		.append("      A.UPJANG_SID,A.ROOM_TYPE_SID,                                                                   \n")
		.append("      A.UPJANG_SID concat A.ROOM_TYPE_SID AS UPJANG_INFO,                                             \n")
		.append("      CASE WHEN D.USE_AMT-SALES.FN_PAY_AMT('3',A.RSV_SID,'N')= 0 THEN '완료'                                           \n")
		.append("           WHEN SALES.FN_PAY_AMT('3',A.RSV_SID,'N')= 0 THEN '미납'     \n")
		.append("      END as RSTAT, D.USE_AMT AS TOT_TOUR_AMT,                                                                    \n")
		.append("       CASE WHEN B.TEL_NO = '' OR B.MOBILE_NO = '' OR B.ZIP_CD = '' OR B.ADDRESS1 = '' OR B.ADDRESS2 = '' OR B.COMPANY_NM != '직장명' OR B.POSITIONS != '직위' THEN '완료'           \n")
		.append("            WHEN B.TEL_NO != '' OR B.MOBILE_NO != '' OR B.ZIP_CD != '' OR B.ADDRESS1 != '' OR B.ADDRESS2 != '' OR B.COMPANY_NM = '직장명' OR B.POSITIONS = '직위' THEN '미입력'   \n")
		.append("       END TSTDT, F.PAY_AMT AS TOT_PAY_AMT, F.PAY_YN                                                                                \n")
		.append("       FROM SALES.TRV020 A                                                                 \n")
		.append("         INNER JOIN SALES.TCU010 B                                                         \n")
		.append("              ON B.CUST_SID = A.CUST_SID                                                   \n")
		.append("         INNER JOIN SALES.TRV030 D                                                         \n")
		.append("              ON D.RSV_SID = A.RSV_SID                                                     \n")
		.append("         LEFT OUTER JOIN  SALES.TRV510 E                                                   \n")
		.append("              ON A.RSV_SID = E.RSV_SID		                                                \n")
		.append("         LEFT OUTER JOIN  SALES.TRV200 F                                                   \n")
		.append("              ON A.RSV_SID = F.RSV_SID		                                                \n")		
		.append("  WHERE                                                                                    \n")
		//.append("       A.CUST_SID=B.CUST_SID  AND                                                                   \n")
        //.append("       D.RSV_SID=A.RSV_SID AND                                                                      \n")
        //.append("       A.RSV_SID=E.RSV_SID AND                                                                      \n")
		.append("       A.ACCEPT_SID=?   ").toString();
        
        try {
        	pstmt = dbconn.prepareStatement(query.toString());

            // 변수 바인딩
            pstmt.setInt(1, accept_sid); 
            
            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Reservation_bean());
           
            rs.close();
            pstmt.close();
            
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Reservation_bean [])list.toArray(new Reservation_bean[0]);

    }	
    
    
     
    /**
     *   관광객 상세 정보 보기
     * @param cust_sid 구분키
     * @return Reservation_bean []
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	public Reservation_bean [] getCustInfo(int cust_sid) throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
        // SQL
        String query = new StringBuffer()
		.append(" SELECT                                       \n")
		.append("   CUST_NM, CUST_SID, MANAGE_NO, REGI_NO,     \n")
		.append("   REGI_YN,                                   \n")
		.append("   CUST_NM,                                   \n")
		.append("   TEL_NO,                                    \n")
		.append("   MOBILE_NO,ZIP_CD,                          \n")
		.append("   ADDRESS1, ADDRESS2,                        \n")
		.append("   COMPANY_NM, POSITIONS                      \n")
		.append(" FROM SALES.TCU010 WHERE CUST_SID=?             ").toString();
        
        //System.out.println("------------"+query);
        //System.out.println("------------"+cust_sid);
        try { 
          
            pstmt = dbconn.prepareStatement(query);
            
            // 변수 바인딩
            pstmt.setInt(1, cust_sid); 
            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Reservation_bean());
            rs.close();
            pstmt.close();

        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Reservation_bean [])list.toArray(new Reservation_bean[0]);
    }  
	
	
	 /**
     *  관광객 정보 수정
     * @param data Reservation_bean
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author 이소연
     */
	 public int getCustUpdate(Reservation_bean data) throws DbException , Exception {
	 	
	 	Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result  = 0;
        
		try {
			
			dbconn.setAutoCommit(false);
	    
			if(data != null){
				
				String query = new StringBuffer()
				.append(" UPDATE SALES.TCU010	SET 	\n")
				.append("        ZIP_CD=?,				\n")
				.append(" 	     ADDRESS1=?,			\n")
				.append(" 	     ADDRESS2=?,			\n")
				.append(" 	     TEL_NO=?,				\n")
                .append(" 	     MOBILE_NO=?,			\n")
                .append(" 	     COMPANY_NM=?,			\n")
                .append(" 	     POSITIONS=?			\n")				
				.append(" WHERE CUST_SID=?				  ").toString(); 
				
				pstmt = dbconn.prepareStatement(query);
				
				// 변수 바인딩
				pstmt.setString(1,data.getZip_cd());
				pstmt.setString(2,data.getAddress1());					
				pstmt.setString(3,data.getAddress2());
				pstmt.setString(4,data.getTel_no());
				pstmt.setString(5,data.getMobile_no()); 
				pstmt.setString(6,data.getCompany_nm());
				pstmt.setString(7,data.getPositions());
				pstmt.setInt(8,data.getCust_sid());
		
				result = pstmt.executeUpdate();
				
				if(result > 0){
					dbconn.commit();
				}else{
					dbconn.rollback();
				}
				
			}else{
				
			}

		} catch (SQLException e) {
        	e.printStackTrace();
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return result;

	 }	


	 /**
	     * 관광객 예약 취소
	     * @param data Reservation_bean
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     * @author 이소연
	     */	 
	 public int getRevCancle(Reservation_bean data) throws DbException , Exception {

	 	Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result  = 0;
        
		try {
			
			dbconn.setAutoCommit(false);
	    
			if(data != null){
				
            	/*------- @ 2006-10-26 추가------- */
            	/*------- 예약취소 프로시저-------*/
            	CallableStatement stpCall;
            	System.out.println("----------START-----------------");
            	String sql = "CALL SALES.PR_RV510I_02 (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            	stpCall = dbconn.prepareCall( sql ); /* con is the connection */
				stpCall.setString( 1, "" );     //-- 관리번호
				stpCall.registerOutParameter( 1, java.sql.Types.VARCHAR);     //-- 관리번호
				stpCall.setInt( 2, 982);    //-- 매출처SID
				stpCall.setString( 3, data.getRegdate());      //-- 신청일
				stpCall.setString( 4, data.getRegtime());      //-- 신청시간
				stpCall.setString( 5, "RR");        //-- 작업상태:RV024
				stpCall.setString( 6, "이소윤");     //-- 담당자
				stpCall.setString( 7, "3669-3724");      //-- 연락처
				stpCall.setString( 8, data.getRstdt());       //-- 출발일
				stpCall.setInt( 9, data.getAccept_sid());      //-- 신청서SID
				stpCall.setInt( 10, data.getRsv_sid());         //-- 예약SID
				stpCall.setString( 11, "");       //-- 공제코드:RV027
				stpCall.setInt( 12, 0);    //-- 표준공제율
				stpCall.setString( 13, "");       //-- 송금은행:AC002
				stpCall.setString( 14, "");       //-- 송금계좌
				stpCall.setString( 15, "");      //-- 예금주
				stpCall.setInt( 16, 0);       //-- 금액(환불/적용)
				stpCall.setString( 17, "사용자취소");    //-- 사유
				stpCall.setString( 18, "");      //-- 처리결과
				stpCall.setString( 19, "2");     //-- 취소환불구분(RV030)
				stpCall.setString( 20, "9900001");      //-- 최종수정자사번
				stpCall.setString( 21, data.getCust_ip());      //-- 최종수정IP
				stpCall.setString( 22, "1");       //-- 편집상태     //1: INSERT, 2: DELETE, 3: UPDATE
				stpCall.registerOutParameter( 23, java.sql.Types.VARCHAR);
				stpCall.registerOutParameter( 24, java.sql.Types.VARCHAR);
				stpCall.registerOutParameter( 25, java.sql.Types.VARCHAR);
				stpCall.execute();		   
				System.out.println("----------END-----------------");
				
        		String pS_YN = null;
        		pS_YN = stpCall.getString(23);
        		
            	System.out.println("----------pS_YN--------------"+pS_YN);
            	if (pS_YN.equals("Y")){
            	    dbconn.commit();    
            	}
            	
	            /*프로시저 호출 종료*/
	            
				
			}else{
				
			}

		} catch (SQLException e) {
			rollback(dbconn);
            result = 0;
            e.printStackTrace(new PrintWriter(System.out));
            //throw new DbException(e.getMessage());
        }finally{
        	release(pstmt);
            freeConnection(dbconn);
            
        }
        return result;

	 }
	 

	 /**
	     *  결제정보 입력 
	     * @param data Reservation_bean
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     * @author 이소연
	     */
		 public int getPayUpdate(Reservation_bean data) throws DbException , Exception {
		 	
		 	Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int result   = 0;
	        int result2  = 0;
	        
			try {
				
				dbconn.setAutoCommit(false);
		      
				if(data != null){
			        
					String query = new StringBuffer()
					.append(" INSERT INTO SALES.TRV240 (PAY_MANAGE_NO, PAY_AMT, ORDER_NM, ORDER_E_MAIL, \n")
					.append("         ORDER_TEL_NO, BUYR_TEL2, RESP_CODE, RES_MSG, VAN_IDX_NO,          \n")
					.append("         CARD_CD, CARD_NAME, APP_TIME, APP_NO,                             \n")
					.append("         QUOTA, SUCCESS, USER_KEY, U_EMPNO, U_IP, U_DATE)                  \n")
					.append(" VALUES                                                                    \n")
					.append("        (?,?,?,?,                                                          \n")
					.append("         ?,?,?,?,?,                                                        \n")
                    .append("         ?,?,?,?,                                                          \n")
					.append("         ?,?,?,?,?,CURRENT TIMESTAMP)                                            ").toString();
					
					pstmt = dbconn.prepareStatement(query);
					
					System.out.println("-----"+query);
					// 변수 바인딩
					pstmt.setString(1,data.getPay_manage_no());
					System.out.println("--data.getPay_manage_no()---"+data.getPay_manage_no());
					pstmt.setInt(2,data.getPay_amt());
					System.out.println("--data.getPay_amt()---"+data.getPay_amt());
					pstmt.setString(3,data.getOrder_nm());
					System.out.println("--data.getOrder_nm()---"+data.getOrder_nm());
					pstmt.setString(4,data.getOrder_e_mail());
					System.out.println("-data.getOrder_e_mail()----"+data.getOrder_e_mail());
					pstmt.setString(5,data.getOrder_tel_no());
					System.out.println("--data.getOrder_tel_no()---"+data.getOrder_tel_no());
					pstmt.setString(6,data.getBuyr_tel2());
					System.out.println("--data.getBuyr_tel2()---"+data.getBuyr_tel2());
					pstmt.setString(7,data.getResp_code());
					System.out.println("--data.getResp_code()---"+data.getResp_code());
					pstmt.setString(8,data.getRes_msg());
					System.out.println("-data.getRes_msg()----"+data.getRes_msg());
					pstmt.setString(9,data.getVan_idx_no());
					System.out.println("--data.getVan_idx_no()---"+data.getVan_idx_no());
					pstmt.setString(10,data.getCard_cd());
					System.out.println("-data.getCard_cd()----"+data.getCard_cd());
					pstmt.setString(11,data.getCard_name());
					System.out.println("--data.getCard_name()---"+data.getCard_name());
					pstmt.setString(12,data.getApp_time());
					System.out.println("-data.getApp_time()----"+data.getApp_time());
					pstmt.setString(13,data.getApp_no());
					System.out.println("--data.getApp_no()---"+data.getApp_no());
					pstmt.setString(14,data.getQuota());
					System.out.println("--data.getQuota()---"+data.getQuota());
					pstmt.setString(15,data.getSuccess());
					System.out.println("-data.getSuccess()----"+data.getSuccess());
					pstmt.setString(16,data.getUser_key());
					System.out.println("---data.getUser_key()--"+data.getUser_key());
					pstmt.setString(17,"9900001");
					System.out.println("--9900001---"+"9900001");
					pstmt.setString(18,data.getCust_ip());
					System.out.println("--data.getCust_ip()---"+data.getCust_ip());
					
					result = pstmt.executeUpdate();
					
					if(result > 0){
						result2 = getPayUpdate2(dbconn, data);
					}else{
						dbconn.rollback();
					}
					
				}else{
					
				}

			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return result;

		 }

		 public int getPayUpdate2(Connection dbconn, Reservation_bean data) throws DbException , Exception {
		 	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int result   = 0;
	        int result2   = 0;
	        
			try {
				
				dbconn.setAutoCommit(false);
		    
				//if(data != null){ // data
					
					/*String query = new StringBuffer()
					.append(" UPDATE SALES.TRV020 SET                 \n")
					.append("    TOT_PAY_AMT = TOT_PAY_AMT + ?        \n")
					.append(" WHERE RSV_SID = ?                       \n").toString();
					
					pstmt = dbconn.prepareStatement(query);
					
					// 변수 바인딩
					pstmt.setInt(1,data.getPay_amt());					
					pstmt.setInt(2,data.getRsv_sid());					
					
					result = pstmt.executeUpdate();*/
					
					//if(result > 0){  // result
					
					//System.out.println("========"+data.getMulti_yn());
				
                      //if(!data.getMulti_yn().equals("N")){ // IF ->단일결제
                      //	System.out.println("-------단일결제 시작--------");
					//		String query2 = new StringBuffer()
					//		.append(" INSERT INTO SALES.TRV200 (RSV_SID, PAY_DATE, PAY_AMT, PAY_YN, \n")
					//		.append("         PAY_CD, PAY_MANAGE_NO, U_EMPNO, U_IP )                               \n")
					//		.append(" VALUES                                                        \n")
					//		.append("        (?,YEAR(CURRENT TIMESTAMP) concat MONTH(CURRENT TIMESTAMP) concat DAY(CURRENT TIMESTAMP),?,'Y',?,?, ?, ?)     ").toString();
					//		pstmt = dbconn.prepareStatement(query2);

					//		// 변수 바인딩
					//		pstmt.setInt(1,Integer.parseInt(data.getRsv_sid_multi()));
					//		pstmt.setInt(2,Integer.parseInt(data.getPay_amt_multi()));
					//		pstmt.setString(3,data.getPay_cd());
					//		pstmt.setString(4,String.valueOf(data.getPay_manage_no()));
					//		pstmt.setString(5,"9900001");
					//		pstmt.setString(6,data.getCust_ip());
							
					//		result2 = pstmt.executeUpdate();
							
                    //  }else{  // IF
                        
                      	    System.out.println("-------결제 시작--------");
                      	    
                      	    //System.out.println("--------"+data.getRsv_sid_multi());
                      	    //System.out.println("--------"+data.getPay_amt());
                      	  
                            //StringTokenizer tokens = new StringTokenizer(data.getRsv_sid_multi(), "|" );  //예약SID
                            //StringTokenizer tokens2 = new StringTokenizer(data.getPay_amt_multi(), "|" );  //결제금액

                            StringTokenizer tokens = new StringTokenizer(String.valueOf(data.getRsv_sid_multi()), "|" );  //예약SID
                            //StringTokenizer tokens2 = new StringTokenizer(String.valueOf(data.getPay_amt()), "|" );  //결제금액
                      	    
                            System.out.println("-----tokens.countTokens()-----------"+tokens.countTokens());
                            
                            
                            if(tokens.countTokens() > 1){
                            	
		                            for( int x = 1; tokens.hasMoreElements(); x++ ){ //FOR
		                            	
		                            	System.out.println("---------x-----"+x);
		    							String query2 = new StringBuffer()
										.append(" INSERT INTO SALES.TRV200 (RSV_SID, PAY_DATE, PAY_AMT, PAY_YN, \n")
										.append("         PAY_CD, PAY_MANAGE_NO, U_EMPNO, U_IP  )                               \n")
										.append(" VALUES                                                        \n")
										.append("        (?,YEAR(CURRENT TIMESTAMP) concat MONTH(CURRENT TIMESTAMP) concat DAY(CURRENT TIMESTAMP),?,'Y',?,?,?,?)        ").toString();
										
										pstmt = dbconn.prepareStatement(query2);
										System.out.println("==query2===="+query2);
										// 변수 바인딩
										pstmt.setInt(1,Integer.parseInt(tokens.nextToken()));
										//pstmt.setInt(2,Integer.parseInt(tokens2.nextToken()));					
										pstmt.setInt(2,data.getPay_amt());
										pstmt.setString(3,data.getPay_cd());
										pstmt.setString(4,String.valueOf(data.getPay_manage_no()));
										pstmt.setString(5,"9900001");
										pstmt.setString(6,data.getCust_ip());
										//query2 = "";
										result2 = pstmt.executeUpdate();
										System.out.println("==result2===="+result2);
		                            } //FOR
		                            
		                            
                            }else{

    							String query2 = new StringBuffer()
								.append(" INSERT INTO SALES.TRV200 (RSV_SID, PAY_DATE, PAY_AMT, PAY_YN, \n")
								.append("         PAY_CD, PAY_MANAGE_NO, U_EMPNO, U_IP )                               \n")
								.append(" VALUES                                                        \n")
								.append("        (?,YEAR(CURRENT TIMESTAMP) concat MONTH(CURRENT TIMESTAMP) concat DAY(CURRENT TIMESTAMP),?,'Y',?,?, ?, ?)     ").toString();
								pstmt = dbconn.prepareStatement(query2);

								// 변수 바인딩
								pstmt.setInt(1,Integer.parseInt(data.getRsv_sid_multi()));
								pstmt.setInt(2,data.getPay_amt());
								pstmt.setString(3,data.getPay_cd());
								pstmt.setString(4,String.valueOf(data.getPay_manage_no()));
								pstmt.setString(5,"9900001");
								pstmt.setString(6,data.getCust_ip());
							
								result2 = pstmt.executeUpdate();
								//System.out.println("======"+result2);
								
                            }
							System.out.println("::::::   END :::::");
                            
                      //}// IF
					
                      
					   

                       if(result2 > 0){  //result2						
							dbconn.commit();
						}else{ //result2
								dbconn.rollback();
						} //result2
							
				    //}else{  // result
					
				    //}  // result
				//} // data
				
			} catch (SQLException e) {
	        	e.printStackTrace();
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return result;

		 }

		 
	    /**
	     * 예약정보입력
	     * @param bean  Reservation_bean
	     * @return exe int 1:성공 , 0:실패
	     * @throws DbException
	     * @throws Exception
	     * @author IMJK R&D 이소연 대리
	     */
		 public String RevInsert(Reservation_bean data) throws DbException , Exception {

		 	Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String Message   = new String();
	        boolean result4 = false;
		        
			try {
				
				dbconn.setAutoCommit(false);
                    
				 /*예약자 정보 입력 시작*/
					String query11 = new StringBuffer()
					.append(" INSERT INTO SALES.TRV070 (RNAME, RTEL, RMOB,           \n")
					.append(" RMAIL, RPASS, REGTIME, REDT, RSTDT,RSCOD, RACCEPT_NO  )\n")
					.append(" VALUES                                                 \n")
					.append(" (?,?,?,                                                \n")
					.append(" ?,?,CURRENT TIMESTAMP,?,?,?,SALES.FN_ACCEPT_NO(982, '9900001', '"+data.getCust_ip()+"') )  ").toString();
					pstmt = dbconn.prepareStatement(query11);

					pstmt.setString(1,data.getRname());
					pstmt.setString(2,data.getRtel());
					pstmt.setString(3,data.getRmob());
					pstmt.setString(4,data.getRmail());
					pstmt.setString(5,data.getRpass());
					pstmt.setString(6,data.getRedt());
					pstmt.setString(7,data.getRstdt());
					pstmt.setString(8,data.getRscod());
					pstmt.executeUpdate();
				/*예약자 정보 입력 끝*/


                /*관광객 정보 입력 시작*/
					String birthDate = new String();
			        String custSex = new String();
			        int idx = 0;
					String raccept_no = new String();
		        	String query1 = new String();
		        	String query3 = new String();
		        	int cnt = 0;
                	int cust_sid = 0;
                	String group_cd = new String();			        
                	String query5 = new String();

                	String regi_no = new String();
                	String cust_nm = new String();
                	String age_cd = new String();
                	
                    StringTokenizer tokens_regi_no = new StringTokenizer( data.getRegi_no(), "," );
                    StringTokenizer tokens_cust_nm = new StringTokenizer( data.getCust_nm(), "," );
                    StringTokenizer tokens_age_cd = new StringTokenizer( data.getAge_cd(), "," );
                    for( int x = 1; tokens_cust_nm.hasMoreElements(); x++ ){  //(1)
                    	
                    	regi_no =  tokens_regi_no.nextToken();
                    	cust_nm =  tokens_cust_nm.nextToken();
                    	age_cd  =  tokens_age_cd.nextToken();
                    	
						        birthDate = data.getRegi_no();
						        if(birthDate != null && !birthDate.equals("")){
						        	birthDate = "19"+birthDate.substring(0,6);
						        }else{
						        	birthDate = "";
						        }
						        custSex = birthDate.substring(5,6);
						        if(custSex != null && custSex.equals("1")){
						        	custSex = "M";
						        }else{
						        	custSex = "F";
						        }
			                	
			                	/*관광객의 금강산 여행 경험 여부를 체크 한다.*/
					        	query1= "SELECT COUNT(1) AS CNT FROM SALES.TCU010 WHERE REGI_NO=?";  
					        	pstmt = dbconn.prepareStatement(query1);
					        	
					        	//pstmt.setString(1,data.getRegi_no());
					        	pstmt.setString(1,regi_no);
					        	rs = pstmt.executeQuery();
					        	while(rs.next()){
					        		cnt=rs.getInt(1);
					        	}
			
					        	if (cnt > 0){ //(2) 관광객의 금강산 여행 경험이 있는 경우...
			
					        		query1 = "";
						        	query1= " SELECT CUST_SID  FROM SALES.TCU010 WHERE REGI_NO=?";  
						        	pstmt = dbconn.prepareStatement(query1);
						        	//pstmt.setString(1,data.getRegi_no());
						        	pstmt.setString(1,regi_no);
						        	rs = pstmt.executeQuery();
						        	while(rs.next()){
				                		cust_sid=rs.getInt(1);
						        	}
						        	
									String query4 = "";
									query4= " SELECT RACCEPT_NO FROM SALES.TRV070 WHERE IDX =(SELECT MAX(IDX) FROM SALES.TRV070)";
				                	pstmt = dbconn.prepareStatement(query4);
				                	rs = pstmt.executeQuery();
				                	
				                	String gtoup_cd = new String();
				                	while(rs.next())
				                	{
				                		group_cd = rs.getString(1);
				                	}
				                	
					        	}else{  //(2) 관광객의 금강산 여행 경험이 없는 경우...
					        		
			    		            query1 = "";
						        	//query1= " SELECT MAX(RACCEPT_NO) FROM SALES.TRV070 ";
			    		            query1 = "SELECT RACCEPT_NO FROM SALES.TRV070 WHERE IDX =(SELECT MAX(IDX) FROM SALES.TRV070)";
						        	pstmt = dbconn.prepareStatement(query1);
						        	rs = pstmt.executeQuery();
						        	while(rs.next()){
						        		raccept_no=rs.getString(1);
						        	}
			
									String query2 = new StringBuffer()
									.append(" INSERT INTO SALES.TCU010 (                  \n")
									.append(" 	GROUP_CD,MANAGE_NO, REGI_NO , REGI_YN,    \n")
									.append(" 	CUST_GU,COUNTRY_GU,SAUP_GU,CUST_TYPE,     \n")
									.append(" 	CUST_NM, LAST_NM, FIRST_NM, COUNTRY_CD, NATION_CD, BIRTHDAY, SEX,                \n")
									.append(" 	ZIP_SID, COMPANY_NM,  POSITIONS, \n")
									.append(" 	NORTH_CNT, CLIENT_SID, EDUC_YN, U_EMPNO, U_IP, ADDRESS1, ADDRESS2)     \n")
									.append("  VALUES (                                                    \n")
									.append("   ?, ?, ?, 'Y',    \n")
									.append(" 	 '1', '10', '10', '010',                                   \n")
									.append(" 	?, 'L_Name', 'F_Name', 'KOR', 'JSN', ?, ?,       \n")
									.append(" 	1111 , '직장명','직위',                 \n")
									.append(" 	0, 982, '1',  '9900001' , ?, '기본주소','상세주소' )                          ").toString();
									pstmt = dbconn.prepareStatement(query2);
									// 변수 바인딩
									pstmt.setString(1,raccept_no);
									//pstmt.setString(2,data.getRegi_no());
									pstmt.setString(2,regi_no);
									//pstmt.setString(3,data.getRegi_no());
									pstmt.setString(3,regi_no);
									//pstmt.setString(4,data.getCust_nm());
									pstmt.setString(4,cust_nm);
									pstmt.setString(5,birthDate);
									pstmt.setString(6,custSex);
									pstmt.setString(7,data.getCust_ip()); //@해당사용자IP
									pstmt.executeUpdate();
									//dbconn.commit();
			
				                	query3= " SELECT CUST_SID, GROUP_CD FROM SALES.TCU010 WHERE CUST_SID =(SELECT MAX(CUST_SID) FROM SALES.TCU010)";
				                	pstmt = dbconn.prepareStatement(query3);
				                	rs = pstmt.executeQuery();
				                	
				                	while(rs.next())
				                	{
				                		cust_sid=rs.getInt(1);
				                		group_cd=rs.getString(2);
				                	}
			                	
					        	}//(2) 
					        	/*관광객 정보 입력 끝*/
					        	
			                    
					        	/* 이번 관광건에 대한 마스터 테이블 입력 시작*/
								String query44 = new StringBuffer()
								.append("  INSERT INTO SALES.TRV010 (                                     \n")
								.append("     ACCEPT_NO, ACCEPT_DATE, CLIENT_SID, PRICE_CALC_YN, I_EMPNO, \n")
								.append("     I_DATE, I_IP)                                               \n")
								.append("  VALUES ( ?, ?, 982, 'N', '9900001',CURRENT TIMESTAMP, ?)   ").toString();
								pstmt = dbconn.prepareStatement(query44);
								
								pstmt.setString(1,group_cd);
								pstmt.setString(2,data.getRstdt());
								pstmt.setString(3,data.getCust_ip());
								//pstmt.executeUpdate();
								/* 이번 관관건에 대한 마시터 테이블 입력 끝*/
								
								/*프로시저 호출 시작*/
			                	query3= " SELECT ACCEPT_SID FROM SALES.TRV010 WHERE ACCEPT_NO='"+group_cd+"'";
			                	pstmt = dbconn.prepareStatement(query3);
			                	rs = pstmt.executeQuery();
			                	String nullStr = null;
			                	int accept_sid=0;
			                	while(rs.next())
			                	{
			                		accept_sid=rs.getInt(1);
			                	}
			                     
			                	String start_time = "0";
			                	int dayNight = 0;
			                	String arrive_time = "0";
			                	
			                	if(data.getRscod().equals("59")){  //2박3일
			                		start_time = "1630";
			                		dayNight = 2;
			                		arrive_time = "1500";
			                	}else{  //1박2일
			                		start_time = "0800";
			                		dayNight = 1;
			                		arrive_time = "1700";
			                	}

			                	CallableStatement stpCall;
			                	String sql = "CALL SALES.PR_RV200I_01 (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			                	stpCall = dbconn.prepareCall( sql ); /* con is the connection */
			                	stpCall.setInt( 1, accept_sid ); //신청서SID
			                	System.out.println("---1.신청서번호(Int)-----"+accept_sid);
			                	stpCall.registerOutParameter( 1, java.sql.Types.DECIMAL);
			                	stpCall.setString( 2, group_cd ); //신청서NO
			                	System.out.println("---2. 신청서NO(String)-----"+group_cd);
			                	stpCall.registerOutParameter( 2, java.sql.Types.DECIMAL);
			                	stpCall.setString( 3, data.getRstdt() ); //출발일자
			                	System.out.println("---3. 출발일자(String)-----"+data.getRstdt());
			                	stpCall.setInt( 4, Integer.parseInt(data.getRscod())); //상품SID
			                	System.out.println("---4. 상품번호(Int)-----"+Integer.parseInt(data.getRscod()));
			                	stpCall.setInt( 5, 982 );
			                	System.out.println("-----5.고정값(Int)----------982");
			                	stpCall.setInt( 6, 0 );
			                	System.out.println("-----6.고정값(Int)----------0");
			                	stpCall.setString( 7, "1" );
			                	System.out.println("-----7.고정값(String)----------1");
			                	stpCall.setInt( 8, 0 );
			                	System.out.println("-----8.고정값(Int)----------0");
			                	stpCall.registerOutParameter( 8, java.sql.Types.DECIMAL);
			                	stpCall.setInt( 9, 0 );
			                	System.out.println("-----9.고정값(Int)----------0");
			                	stpCall.registerOutParameter( 9, java.sql.Types.INTEGER);
			                	stpCall.setInt( 10, data.getRoom_type_sid()); //객실SID
			                	System.out.println("--10. 객실타입SID(Int)------"+data.getRoom_type_sid());
			                	stpCall.setInt( 11, 0 );
			                	System.out.println("-----11.고정값(Int)----------0");
			                	stpCall.registerOutParameter( 11, java.sql.Types.DECIMAL);
			                	stpCall.setInt( 12, 0 );
			                	System.out.println("-----12.고정값(Int)----------0");
			                	stpCall.setString( 13, "2" );
			                	System.out.println("-----13.고정값(Int)----------2");
			                	System.out.println("-------------------------"+start_time);
			                	stpCall.setString( 14, start_time );
			                	System.out.println("-----14.출경시간(String)----------"+start_time);
			                    stpCall.setInt( 15, dayNight); //숙박수
			                    System.out.println("--15. 숙박수(Int)------"+dayNight);
			                	stpCall.setString( 16, data.getRedt() ); //도착일자
			                	System.out.println("--16. 도착일자(String)------"+data.getRedt());
			                	stpCall.setString( 17, arrive_time );
			                	System.out.println("-----17.도착시(String)----------"+arrive_time);
			                	stpCall.setInt( 18, cust_sid );
			                	System.out.println("--18. 고객번호(Int)------"+cust_sid);
			                	stpCall.setString( 19, "1" );
			                	System.out.println("---간--19.고정값(String)----------1");
			                	stpCall.setString( 20, "10" );
			                	System.out.println("-----20.고정값(String)----------10");
			                	stpCall.setString( 21, "010" );
			                	System.out.println("-----21.고정값(String)----------010");
			                	//stpCall.setString( 22, data.getAge_cd() );
			                	stpCall.setString( 22, "1" );
			                	//System.out.println("--22. 연령값(String)------"+data.getAge_cd());
			                	//stpCall.setString( 22, age_cd );
			                	System.out.println("--22. 연령값(String)------"+age_cd);
			                	stpCall.setString( 23, "01" );
			                	System.out.println("-----23.고정값(String)----------01");
			                	stpCall.setString( 24, "" );
			                	System.out.println("-----24.고정값(String)----------");
			                	stpCall.setString( 25, "2" );
			                	System.out.println("-----25.고정값(String)----------2");
			                	stpCall.setString( 26, data.getRname()+"-"+data.getRmob());
			                	System.out.println("--26. 고객정보(String)------"+data.getRname()+"-"+data.getRmob());
			                	stpCall.setString( 27, "9900001" );
			                	System.out.println("-----27.고정값(String)----------9900001");
			                	stpCall.setString( 28, data.getCust_ip());
			                	System.out.println("--28. 접속아이피(String)------"+data.getCust_ip());
			                	stpCall.setString( 29, "1" );
			                	System.out.println("-----29.고정값(String)----------1");
			                	stpCall.setString( 30, "41" );
			                	System.out.println("-----30.고정값(String)----------41");
			                	stpCall.registerOutParameter( 31, java.sql.Types.VARCHAR);
			                	stpCall.registerOutParameter( 32, java.sql.Types.VARCHAR);
			                	stpCall.registerOutParameter( 33, java.sql.Types.VARCHAR);                	
			                	stpCall.execute();
			                	
			                	String pS_YN = null;
			                	pS_YN = stpCall.getString(31);
			                	Message = stpCall.getString(33);
			                	if(Message == null || Message.equals("")){
			                		Message = "예약이 성공하였습니다.";
			                	}else{
			                		Message = stpCall.getString(33);
			                	}
			                	Message = Message+"|"+pS_YN;
			                	//Message = stpCall.getString(33);

			                	System.out.println("----------Message(1)--------------"+Message);
			                	System.out.println("----------pS_YN(1)--------------"+pS_YN);
			                	
			                	if (pS_YN.equals("Y")){
			                		    //dbconn.commit();			                		    
					                	/*------- @ 2006-10-26 추가------- */
					                	/*------- 요금계산 프로시져 호출-------*/
					                	CallableStatement stpCall2;
					                	String sql2 = "CALL SALES.PR_RV200I_06 (?,?,?,?,?,?,?,?,?,?)";
					                	stpCall2 = dbconn.prepareCall( sql2 ); /* con is the connection */
					                	stpCall2.setInt( 1, accept_sid ); //신청서SID
					                	stpCall2.registerOutParameter( 2, java.sql.Types.NUMERIC ); //총관광요금
					                	stpCall2.registerOutParameter( 3, java.sql.Types.NUMERIC ); //총관광인원
					                	stpCall2.setString( 4, "AC110I" ); //보내는ID
					                	stpCall2.setString( 5, "9900001" ); //최종수정자사번
					                	stpCall2.setString( 6, data.getCust_ip() ); //최종수정IP
					                	stpCall2.setString( 7, "3" ); //편집상태     1: INSERT, 2: DELETE, 3: UPDATE
					                	stpCall2.registerOutParameter( 8, java.sql.Types.VARCHAR ); //성공Y/N
					                	stpCall2.registerOutParameter( 9, java.sql.Types.VARCHAR ); //메세지 코드
					                	stpCall2.registerOutParameter( 10, java.sql.Types.VARCHAR ); //메세지
					                	stpCall2.execute();
					                	
				                		String pS_YN2 = null;
				                		pS_YN2 = stpCall2.getString(8);
				                		
				                		//System.out.println("##########################"+stpCall2.getString(2));
				                		//System.out.println("##########################"+stpCall2.getString(3));
				                		
				                		
					                	System.out.println("----------pS_YN(2)--------------"+pS_YN2);
					                	if (pS_YN2.equals("Y")){
					                	    dbconn.commit();    
					                	}

			                	}else{
			                		
			                		break;
			                		
			                	}
			                	
			                	if (Message == null || Message.equals("")){
			                		Message = "온라인예약에 실패하였습니다.|N";
			                	}
			                	
                	            rs.close();
                	            /*프로시저 호출 종료*/

                    }//(1)
                	
                	
			} catch (SQLException e) {
				rollback(dbconn);
				Message = "";
	            e.printStackTrace(new PrintWriter(System.out));
	            //throw new DbException(e.getMessage());
	        }finally{
	        	release(pstmt);
	            freeConnection(dbconn);
	            
	        }
	        
        	if (Message == null || Message.equals("")){
        		Message = "온라인예약에 실패하였습니다.|N";
        	}	        
	        return Message;

		 }
		 
		 
		 public int RevInsert2(Connection dbconn, Reservation_bean data) throws DbException , Exception {
		 	
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int result   = 0;
	        int result2   = 0;
	        int result3   = 0;
	        boolean result4 = false;
	        
	        String birthDate = new String();
	        String custSex = new String();
	        int idx = 0;
	        birthDate = data.getRegi_no();
	        if(birthDate != null && !birthDate.equals("")){
	        	birthDate = "19"+birthDate.substring(0,6);
	        }else{
	        	birthDate = "";
	        }
	        custSex = birthDate.substring(5,6);
	        if(custSex != null && custSex.equals("1")){
	        	custSex = "M";
	        }else{
	        	custSex = "F";
	        }
	        
			try {

				dbconn.setAutoCommit(false);
				if(data != null){ // data

				String raccept_no = new String();
	        	String query1 = new String();
	        	
	        	query1= " SELECT MAX(RACCEPT_NO) FROM SALES.TRV070 ";
	        	pstmt = dbconn.prepareStatement(query1);
	        	rs = pstmt.executeQuery();
	        	while(rs.next()){
	        		raccept_no=rs.getString(1);
	        	}
	        	
				String query2 = new StringBuffer()
				.append(" INSERT INTO SALES.TCU010 (                  \n")
				.append(" 	GROUP_CD,MANAGE_NO, REGI_NO , REGI_YN,    \n")
				.append(" 	CUST_GU,COUNTRY_GU,SAUP_GU,CUST_TYPE,     \n")
				.append(" 	CUST_NM, LAST_NM, FIRST_NM, COUNTRY_CD, NATION_CD, BIRTHDAY, SEX,                \n")
				.append(" 	ZIP_SID, COMPANY_NM,  \n")
				.append(" 	NORTH_CNT, CLIENT_SID, EDUC_YN, U_EMPNO, U_IP)     \n")
				.append("  VALUES (                                                    \n")
				.append("   ?, ?, ?, 'Y',    \n")
				.append(" 	 '1', '10', '10', '010',                                   \n")
				.append(" 	?, 'L_Name', 'F_Name', 'KOR', 'JSN', ?, ?,       \n")
				.append(" 	1111 , '직장명',                 \n")
				.append(" 	0, 982, '1',  '9900001' , ? )                          ").toString();
				pstmt = dbconn.prepareStatement(query2);
				// 변수 바인딩
				pstmt.setString(1,raccept_no);
				pstmt.setString(2,data.getRegi_no());
				pstmt.setString(3,data.getRegi_no());
				pstmt.setString(4,data.getCust_nm());
				pstmt.setString(5,birthDate);
				pstmt.setString(6,custSex);
				pstmt.setString(7,data.getCust_ip()); //@해당사용자IP
				result2 = pstmt.executeUpdate();
				
                if (result2 > 0){
                	
                	String query3 = new String();
                	query3= " SELECT CUST_SID, GROUP_CD FROM SALES.TCU010 WHERE CUST_SID =(SELECT MAX(CUST_SID) FROM SALES.TCU010)";
                	pstmt = dbconn.prepareStatement(query3);
                	rs = pstmt.executeQuery();
                	int cust_sid = 0;
                	String group_cd = new String();
                	while(rs.next())
                	{
                		cust_sid=rs.getInt(1);
                		group_cd=rs.getString(2);
                	}
                	rs.close();
                	
                	System.out.println("----------group_cd----------------------"+group_cd);
                	System.out.println("----------cust_sid----------------------"+cust_sid);
                	
					String query4 = new StringBuffer()
					.append("  INSERT INTO SALES.TRV010 (                                     \n")
					.append("     ACCEPT_NO, ACCEPT_DATE, CLIENT_SID, PRICE_CALC_YN, I_EMPNO, \n")
					.append("     I_DATE, I_IP)                                               \n")
					.append("  VALUES ( ?, ?, 982, 'N', '9900001',                            \n")
					.append("     CURRENT TIMESTAMP, ?)                                         ").toString();
					pstmt = dbconn.prepareStatement(query4);
					// 변수 바인딩
					pstmt.setString(1,group_cd);
					pstmt.setString(2,data.getRstdt());
					pstmt.setString(3,data.getCust_ip());
					result3 = pstmt.executeUpdate();
					
					
					if (result3 > 0){
						
	                	/*프로시저 호출*/
	                	CallableStatement stpCall;
	                	String sql = "CALL SALES.PR_RV200I_01 ((SELECT ACCEPT_SID FROM SALES.TRV010 WHERE ACCEPT_NO = '"+group_cd+"'),?,?,?,?   " ;
	                	sql = sql + "        , '99000', 982, 0, 1, 0, 0             ";
	                	sql = sql + "        , ?, 0, 0, 2, '1630'                   ";
	                	sql = sql + "        , ?, ?, '1500', ?, '1'                 ";
	                	sql = sql + "        , '10', '010', ?, '01, ''           ";
	                	sql = sql + "        , '2', ?, '9900001', ?,'1','41',NULL,NULL,NULL)    ";
	                	
	                	stpCall = dbconn.prepareCall( sql ); /* con is the connection */
	                	stpCall.setString( 1, group_cd );
	                	stpCall.setString( 2, data.getRstdt() ); 
	                	stpCall.setString( 3, data.getRscod() );
	                	stpCall.setInt( 4, data.getUpjang_sid());
	                	stpCall.setInt( 5, data.getRoom_type_sid() );
	                	stpCall.setString( 6, data.getRscod() );
	                	stpCall.setString( 7, data.getRedt() );
	                	stpCall.setInt( 8, cust_sid );
	                	stpCall.setString( 9, data.getAge_cd() );
	                	stpCall.setString( 10, data.getRname()+"-"+data.getRmob());
	                	stpCall.setString( 11, data.getCust_ip());
	                	
	                	result4 = stpCall.execute();
	                	
				     }
	                	/*stpCall.registerOutParameter( 2, Types.DECIMAL, 2 ); 
	                	stpCall.registerOutParameter( 3, Types.INTEGER ); 
	                	stpCall.execute();
	                	variable2 = stpCall.getBigDecimal(2); 
	                	variable3 = stpCall.getInt(3);*/
					
                     pstmt.close();
                }
				
					if(result4 == true){
						dbconn.commit();
					}
					
			    }else{
				
			    }
		
			} catch (SQLException e) {
		    	e.printStackTrace(new PrintWriter(System.out));
//		        throw new DbException(e.getMessage());
		    }finally{
		    	//rollback(dbconn);
		        release(pstmt);
		        freeConnection(dbconn); 
		    }
		    return result;

         }		 
		 

	    /**
	     *   주문번호호출
	     * @param 
	     * @return Reservation_bean []
	     * @throws DbException
	     * @throws Exception
	     * @author 이소연
	     */
		 public String getManageNo() throws DbException , Exception {
		 	
		 	Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        String result   = "";
	        String ManageNo = new String();
			try {
				dbconn.setAutoCommit(false);
				
            	/*프로시저 호출*/
            	CallableStatement stpCall;
            	String sql = "CALL SALES.PR_PAY_MANAGE_NO(?)" ;
            	stpCall = dbconn.prepareCall( sql ); /* con is the connection */
            	stpCall.registerOutParameter( 1, java.sql.Types.VARCHAR );
            	stpCall.execute();
                ManageNo = stpCall.getString(1);
                //result = Integer.parseInt(ManageNo);
                result = ManageNo;
                
			} catch (SQLException e) {
		    	e.printStackTrace(new PrintWriter(System.out));
		    }finally{
		        release(pstmt);
		        freeConnection(dbconn); 
		    }
		    return result;
         }
	
	/**
	 * 주민등록번호로 나이 날아내기
	 * @param jumin_no, foreigner_yn
	 * @return age
	 * @throws DbException
	 * @throws Exception
	 */
	public String getAge(String foreigner_yn,String jumin_no) throws DbException, Exception {
		String age = "";
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
		try {
			if(foreigner_yn.equals("Y")) {
				age = "1";
			} else {
				StringBuffer query = new StringBuffer("");
				
				query.append("SELECT SALES.FN_AGE_CD('"+jumin_no+"') AS AGE_CD ");
				query.append("FROM SYSIBM.SYSDUMMY1");
				
	            pstmt = dbconn.prepareStatement(query.toString());

	            // 결과 담기
	            rs = pstmt.executeQuery();

				if(rs.next()){
					age = rs.getString("AGE_CD");
				}
	            rs.close();
	            pstmt.close();	
			}
			
		} catch (SQLException e) {
	    	e.printStackTrace(new PrintWriter(System.out));
	    }finally{
	        release(pstmt);
	        freeConnection(dbconn); 
	    }
		
		return age;
	}
	
	/**
	 * 주어진 정보로 가격 조회하기
	 * @param param
	 * @return price
	 * @throws DbException
	 * @throws Exception
	 */
	public long getPrice(Reservation_bean param) throws DbException, Exception {
		long price = 0;
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
		try {
			StringBuffer query = new StringBuffer("");
			String goods_sid = param.getGoods_cd();			//상품ID
			String saup_sid = param.getSaup_sid();			//관광지ID
			String upjang_sid = param.getUpjang_sid()+"";	//업장SID		
			String room_type_sid = param.getRoom_type_sid()+"";	//객실SID
			String age_cd = param.getAge_cd();				//나이코드
			String start_ymd = param.getDepart_date();		//출발일자
			String cnt = param.getPerson_cnt();				//객실에 예약한 인원수
			//당일치기
			query.append("SELECT SALES.FN_USE_ROOM_AMT('"+saup_sid+"', '");
			query.append(start_ymd).append("', ").append(goods_sid).append(", ");
			query.append(room_type_sid).append(", '").append(age_cd).append("', "+cnt+") AS PRICE ");
			query.append(" FROM SYSIBM.SYSDUMMY1");
				
			//System.out.println(query.toString());
            pstmt = dbconn.prepareStatement(query.toString());
            
        	// 결과 담기
            rs = pstmt.executeQuery();     
            
			if(rs.next()){
				price = rs.getLong("PRICE");				
			}
			
            rs.close();
            pstmt.close();	
            
		} catch (SQLException e) {
	    	e.printStackTrace(new PrintWriter(System.out));
	    }finally{
	        release(pstmt);
	        freeConnection(dbconn); 
	    }
		return price;
		
	}
	
	/**
	 * 고객의 ID를 알아내오는 쿼리 , 프로시져
	 * @param param
	 * @return
	 * @throws DbException
	 * @throws Exception
	 */
	public String getCustId(Reservation_bean param) throws DbException, Exception {
		String cust_id = "";
		Connection dbconn = getConnection();
		CallableStatement stpCall = null;

		StringBuffer query = new StringBuffer("");
		query.append("CALL SALES.PR_OL_04(?,?,?,?,?,?,?,?)");
				
		try {
			String jumin = param.getRegi_no();			//주민등록번호
			String nm = param.getCust_nm();				//고객명
			String tel = param.getTel_no();				//연락처
			String foreigner_cd = param.getForeigner_cd();	//외국인구분

	    	//쿼리실행
	    	stpCall = dbconn.prepareCall(query.toString());

	    	//국내인
	    	if(foreigner_cd.equals("10")) {
				//System.out.println(jumin);
				//System.out.println(nm);
				//System.out.println(tel);
				//System.out.println("19"+jumin.substring(0,6));
		    	
		    	stpCall.setString(1, jumin);
				//System.out.println("1::"+jumin);
		    	stpCall.setString(2, nm);
				//System.out.println("2::"+nm);
		    	stpCall.setString(3, tel);
				//System.out.println("3::"+tel);
		    	stpCall.setString(4, "Fname");
				//System.out.println("4");
		    	stpCall.setString(5, "Lname");
				//System.out.println("5");
		    	if(jumin.substring(6,7).equals("1") || jumin.substring(6,7).equals("2")) {
		    		stpCall.setString(6, "19"+jumin.substring(0,6));
					//System.out.println("6::"+"19"+jumin.substring(0,6));
		    	} else if (jumin.substring(6,7).equals("3") || jumin.substring(6,7).equals("4")){
		    		stpCall.setString(6, "20"+jumin.substring(0,6));
					//System.out.println("6::"+"20"+jumin.substring(0,6));
		    	}
		    	stpCall.setString(7, "10");
				//System.out.println("7::10");
		    	stpCall.setInt(8, 0);
				stpCall.registerOutParameter( 8, java.sql.Types.DECIMAL);
				//System.out.println("8");
		    	
		    //외국인
	    	} else{
	    		/*
		    	stpCall.setString(1, "ABXXXXXXX");
		    	stpCall.setString(2, "");
		    	stpCall.setString(3, );
		    	stpCall.setString(4, tel);
		    	stpCall.setString(5, tel);
		    	stpCall.setString(6, tel);  
		    	stpCall.setString(7, "40");
		    	*/
	    	}

	    	//결과담기 
	    	stpCall.execute();
	    	cust_id = stpCall.getBigDecimal(8).intValue()+"";
			//_m_rsv_sid  = stpCall.getBigDecimal(9).intValue();
	    	System.out.println(cust_id);
	    	stpCall.close();			
			
		} catch (SQLException e) {
	    	e.printStackTrace(new PrintWriter(System.out));
	    }finally{
	        release(stpCall);
	        freeConnection(dbconn); 
	    }
		return cust_id;
	}
	
	public String[] getTimeInfo(Reservation_bean param) throws DbException, Exception {
		String[] time_info = new String[4];
		Connection dbconn = getConnection();
		CallableStatement stpCall = null;
	    ResultSet rs = null;
	    Collection list = null;
	    
	    StringBuffer query = new StringBuffer("");
	    query.append("CALL SALES.PR_OL_05(?,?)");
	    
		try {
			String start_ymd = param.getDepart_date();	//출발일
			String goods_sid = param.getGoods_cd();		//상품ID

	    	//쿼리실행
	    	stpCall = dbconn.prepareCall(query.toString());

	    	stpCall.setString(1, start_ymd);
	    	stpCall.setInt(2, Integer.parseInt(goods_sid));

	    	//결과담기 
	    	rs = stpCall.executeQuery();
	    	
	    	if(rs.next()) {
	    		time_info[0] = rs.getString("nights");
	    		time_info[1] = rs.getString("depart_time");
	    		time_info[2] = rs.getString("arrive_time");
	    		time_info[3] = rs.getString("arrive_date");
	    	}

	    	rs.close();
	    	stpCall.close();		
		} catch (SQLException e) {
	    	e.printStackTrace(new PrintWriter(System.out));
	    }finally{
	        release(stpCall);
	        freeConnection(dbconn); 
	    }
		return time_info;
	}
	
	/**
	 * DBConn 반환
	 * @return
	 * @throws DbException
	 * @throws Exception
	 */
	public Connection getCon() throws DbException, Exception {
		Connection dbconn = getConnection();
		return dbconn;
	}
	
	public String resvProc(Connection dbconn, CallableStatement stpCall, Reservation_bean param) throws DbException, Exception {
		String returnMsg = "";
		try {
			stpCall.setInt(1, param.getAccept_sid());
			stpCall.registerOutParameter(1, java.sql.Types.DECIMAL);		//신청서SID
			
			stpCall.setString(2, param.getAccept_no());						//신청서번호
			stpCall.registerOutParameter(2, java.sql.Types.VARCHAR);		
			
			stpCall.setString(3, param.getRstdt());							//출발일자
			
			stpCall.setInt(4, Integer.parseInt(param.getGoods_cd()));		//상품SID
			
			stpCall.setInt(5, 982);											//고정값
			stpCall.setInt(6, 0);											//고정값
			stpCall.setString(7, "1");										//고정값
			
			stpCall.setInt(8, 0);											
			stpCall.registerOutParameter(8, java.sql.Types.DECIMAL);		//마스터예약SID
			
			stpCall.setInt(9, param.getRsv_sid());											
			stpCall.registerOutParameter(9, java.sql.Types.DECIMAL);	
			
			stpCall.setInt(10, param.getRoom_type_sid());					//객실 SID
			
			stpCall.setInt(11, 0);											
			stpCall.registerOutParameter(11, java.sql.Types.DECIMAL);		//고정값
			
			stpCall.setInt(12, 0);											//고정값
			stpCall.setString(13,"2");										//고정값
			
			stpCall.setString(14, param.getDepart_time());					//출발시간
			stpCall.setInt(15, Integer.parseInt(param.getDaynight()));		//숙박수
			stpCall.setString(16, param.getArrive_date());					//도착일
			stpCall.setString(17, param.getArrive_time());					//도착시간
			stpCall.setInt(18, param.getCust_sid());						//고객SID
			stpCall.setString(19, "1");										//고정값
			stpCall.setString(20, "10");									//고정값
			stpCall.setString(21, "010");									//고정값
			stpCall.setString(22, param.getAge_cd());						//나이코드
			
			if(param.getRsv_sid() == 0) {
				stpCall.setString(23, "01");								//동숙코드
			} else {
				stpCall.setString(23, "02");								//동숙코드
			}
			stpCall.setString(24, param.getTel_no());						//전화번호
			stpCall.setString(25, "9900001");								//고정값
			stpCall.setString(26, "2");										//고정값
			stpCall.setString(27, "ON"+param.getCust_nm()+"-"+param.getTel_no());
			stpCall.setString(28, "9900001");								//고정값
			stpCall.setString(29, param.getCust_ip());						//아이피
			stpCall.setString(30, "N");										//고정값
			stpCall.setString(31, "N");										//고정값
			stpCall.setString(32, param.getWeekend_yn());					//주말여부
			stpCall.setString(33, "01"); 									//고정값
			stpCall.setString(34, "1");										//고정값
			stpCall.setString(35, "41");									//고정값
			stpCall.registerOutParameter(36, java.sql.Types.VARCHAR);		//고정값
			stpCall.registerOutParameter(37, java.sql.Types.VARCHAR);		//고정값
			stpCall.registerOutParameter(38, java.sql.Types.VARCHAR);		//고정값
			
			stpCall.execute();
			returnMsg = stpCall.getString(36);
		} catch (SQLException e) {
	    	e.printStackTrace(new PrintWriter(System.out));
		} catch (Exception e) {
			
		}
		return returnMsg;
	}
}


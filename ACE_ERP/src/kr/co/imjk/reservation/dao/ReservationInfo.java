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
 * @author �̼ҿ�
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class ReservationInfo  extends DAOHome{

	/**
	 *  ���ǿ��ຸ�� ����(����) - ������ ����
	 * @param  CUST_NM, MANAGE_NO
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �̼ҿ�
	 */
	public Reservation_bean [] getRevCust(String cust_nm, String manage_no)  throws DbException , Exception 
{
	Connection dbconn = getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Collection list = null;
	
	// SQL
	String query = new StringBuffer()
	.append(" SELECT COALESCE(MAX(R1.RSV_SID),0) AS RSV_SID          \n")
	.append("   FROM SALES.TRV020 R1 JOIN SALES.TCU010 C1 ON (R1.CUST_SID=C1.CUST_SID)       \n")
	.append("  WHERE R1.DEPART_DATE='20081111'   \n")
	.append("    AND C1.CUST_NM   = ?			 \n")
	.append("    AND C1.MANAGE_NO = ?			 \n").toString();

	try {         
		pstmt = dbconn.prepareStatement(query);
		// ���� ���ε�
		pstmt.setString(1, cust_nm);
		pstmt.setString(2, manage_no);

		// ��� ���
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
	 *  ���ǿ��ຸ�� ����(����)
	 * @param board_seq ���� �Խ��� �Ϸù�ȣ
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �̼ҿ�
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
		// ���� ���ε�
		pstmt.setString(1, r_mail);
		pstmt.setString(2, r_pass);

		// ��� ���
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
	 *  ȸ�� �����(����)
	 * @param 
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �̼ҿ�
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
		// ���� ���ε�
		pstmt.setString(1, id);

		// ��� ���
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
	 * �Խù� ��ü �� ����
	 * @param r_mail �˻� �̸���
	 * @param r_pass �˻� ��й�ȣ
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �̼ҿ�
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
			// ���� ���ε�
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
	 * ���� ����Ʈ ������ �����´�. </br>
	 * @param rowsPerPage �������� row �� 
	 * @param requestedPage ȣ�� ������ ��ȣ
	 * @param part �˻��� ����÷�
	 * @param keyword �˻��� �ܾ�
	 * @return Reservation_bean[]
	 * @throws DbException
	 * @author �̼ҿ� 
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
        
		// ����¡ ó��
		if(chk_page > 0){      
			query = new StringBuffer() 
			.append(" SELECT                                                    \n")
			.append("    IDX,                                                   \n")
			.append("    RACCEPT_NO AS ACCEPT_NO,                           \n")
			.append("    RSTAT,                           \n")
			.append("    RNAME, RPASS, RTEL, RMOB, RMAIL,                       \n")
			.append("    SUBSTRING(RSTDT,1,4)||'-'||SUBSTRING(RSTDT,5,2)||'-'||SUBSTRING(RSTDT,7,2) AS RSTDT,  \n")
			.append("    SUBSTRING(REDT,1,4)||'-'||SUBSTRING(REDT,5,2)||'-'||SUBSTRING(REDT,7,2) AS REDT,  \n")
			.append("    RNAME, RPASS, RTEL, RMOB, RMAIL,                       \n")
			.append("    SALES.FN_GOODS_NM (INTEGER(rScod),'') AS DAYNIGHT,      \n")
			.append("    SUBSTRING(CHAR(REGTIME),1,10) AS REGDATE,  \n")
			.append("    REGTIME,                                             \n")
			.append("     (YEAR(REGTIME + 3 days) concat '-' concat MONTH(REGTIME + 3 days) concat '-' concat DAY(REGTIME + 3 days) concat '&nbsp08:00:00') as FINAL_TIME,    \n")
			.append(" 	   CASE WHEN REGTIME + 3 days < current timestamp THEN '���'                                                                      \n")
			.append(" 	   	     WHEN REGTIME + 3 days > current timestamp THEN '����'                                                                      \n")
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
			.append("    SUBSTRING(RSTDT,1,4)||'-'||SUBSTRING(RSTDT,5,2)||'-'||SUBSTRING(RSTDT,7,2) AS RSTDT,  \n")
			.append("    SUBSTRING(REDT,1,4)||'-'||SUBSTRING(REDT,5,2)||'-'||SUBSTRING(REDT,7,2) AS REDT,  \n")
			.append("    RSTAT,                                         \n")				
			.append("    SALES.FN_GOODS_NM (INTEGER(rScod),'') AS DAYNIGHT,                                      \n")
			.append("    SUBSTRING(CHAR(REGTIME),1,10) AS REGDATE,  \n")
			.append("      REGTIME,                                             \n")
			.append("     (YEAR(REGTIME + 3 days) concat '-' concat MONTH(REGTIME + 3 days) concat '-' concat DAY(REGTIME + 3 days)  concat '&nbsp08:00:00') as FINAL_TIME,    \n")
			.append(" 	   CASE WHEN REGTIME + 3 days < current timestamp THEN '���'                                                                      \n")
			.append(" 	   	     WHEN REGTIME + 3 days > current timestamp THEN '����'                                                                      \n")
			.append(" 		   	 END AS FINAL_TYPE                                             \n")						
			.append(" from SALES.TRV070                                      \n")
			.append(" where RMAIL=? and RPASS = ?                               \n")
			.append(" order by IDX DESC                                             \n")
			.append(" fetch first 10 rows only                                  \n").toString();

		}
		System.out.println("-------"+query);
		try {         
			pstmt = dbconn.prepareStatement(query.toString());
            
			// ���� ���ε�
			if(chk_page > 0){   
				pstmt.setString(1, r_mail); 
				pstmt.setString(2, r_pass);
				pstmt.setString(3, r_mail); 
				pstmt.setString(4, r_pass);
			}else{
				pstmt.setString(1, r_mail); 
				pstmt.setString(2, r_pass);
			}
        
            
			// ��� ���
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
	 *   ���� ���� ����
	 * @param idx ����Ű
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �ɵ���
	 */
	public Reservation_bean [] getRevInfo(int idx) 
		throws DbException , Exception 
	{
		Connection dbconn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Collection list = null;

		// SQL
        

		String query = new StringBuffer()
		.append(" SELECT  RACCEPT_NO AS ACCEPT_NO,                                                                                                                             \n")
		.append(" 	   SUBSTRING(C.RSTDT,1,4)||'-'||SUBSTRING(C.RSTDT,5,2)||'-'||SUBSTRING(C.RSTDT,7,2) AS DEPART_DATE                            \n")
		.append(" 	   ,SUBSTRING(C.REDT,1,4)||'-'||SUBSTRING(C.REDT,5,2)||'-'||SUBSTRING(C.REDT,7,2) AS ARRIVE_DATE                              \n")
		.append(" 	   ,CASE C.RSCOD WHEN '28' THEN '2��3��'                                                                                      \n")
		.append(" 	   		WHEN '27' THEN '1��8��'                                                                                               \n")
		.append(" 			END as NIGHTS                                                                                                              \n")
		.append(" 	   ,SUBSTRING(CHAR(C.REGTIME),1,10) As REGDATE                                               \n")
		.append(" 	   ,(HOUR(C.REGTIME) || ':' || MINUTE(C.REGTIME) || ':' || SECOND(C.REGTIME)) AS REGTIME	                                       \n")
		.append(" 	   ,(SELECT COUNT(CUST_SID) FROM SALES.TRV020 WHERE ACCEPT_SID=B.ACCEPT_SID) AS CNT	                                               \n")
		.append(" 	   ,(SELECT SUM(USE_AMT) FROM SALES.TRV030 WHERE RSV_SID IN                                                                        \n")
		.append(" 	   	(SELECT RSV_SID FROM SALES.TRV020 WHERE ACCEPT_SID=B.ACCEPT_SID) ) AS SUM_PRICE                                         \n")
		.append(" 	   ,CASE WHEN C.REGTIME + 3 days < current timestamp THEN '���'                                                                      \n")
		.append(" 	   	     WHEN C.REGTIME + 3 days > current timestamp THEN '����'                                                                      \n")
		.append(" 		   	 END AS FINAL_TYPE                                                                                                         \n")
		.append(" 	   ,(YEAR(REGTIME + 3 days) || '-' || MONTH(REGTIME + 3 days) || '-' || DAY(REGTIME + 3 days) || ' 08:00:00') as FINAL_TIME        \n")
		.append(" 	   ,C.RNAME                                                                                                                        \n")
		.append(" 	   ,C.RMAIL                                                                                                                        \n")
		.append(" 	   ,C.RMOB	                                                                                                                       \n")
		.append(" 	   ,C.RTEL                                                                                                                         \n")
		.append(" 	   ,C.RSCOD                                                                                                                        \n")
		.append("      ,SALES.FN_GOODS_NM (INTEGER(C.rScod),'') AS GOODS_NM                                      \n")
		.append(" 	   ,C.RSTAT                                                                                                                        \n")
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
		.append(" 	   ,B.ACCEPT_SID                                                                                                  \n")
		.append(" FROM SALES.TRV070 AS C JOIN SALES.TRV010 AS B ON (C.RACCEPT_NO=B.ACCEPT_NO)                                                          \n")
		.append("  	 JOIN SALES.TRV020 AS A ON (A.ACCEPT_SID=B.ACCEPT_SID)                                                                             \n")
		.append(" 	 JOIN SALES.TCU010 AS D ON (A.CUST_SID=D.CUST_SID)                                                                                 \n")
		.append(" 	 JOIN SALES.TRV030 AS E ON (A.RSV_SID=E.RSV_SID)                                                                                   \n")
		.append(" WHERE C.IDX=?                                                                                                                        ").toString();	     
        
		try { 

			System.out.println("------idx---------"+idx);
			System.out.println("------query---------"+query);
        	
			pstmt = dbconn.prepareStatement(query);
            
			// ���� ���ε� 
			pstmt.setInt(1, idx); 

			// ��� ���
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
	 * ���������� ����Ʈ ������ �����´�. </br>
	 * @param accept_sid ��ûsid
	 * @return Reservation_bean[]
	 * @throws DbException
	 * @author �ɵ��� 
	 */  
    
	public Reservation_bean[] getTourList(int accept_sid ) throws  Exception{
        
    	
		Connection dbconn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Reservation_bean bean = null;
		Collection list = null; 
     	
		String query = new StringBuffer()
		
		.append("  SELECT                             \n")                                                                 
		.append("      A.STATUS_CD, A.RSV_SID, A.CUST_SID, A.ACCEPT_SID , A.M_RSV_SID,       \n")                                             
		.append("      B.CUST_NM,SUBSTRING(B.REGI_NO,1,6)||'-'||SUBSTRING(B.REGI_NO,7,1)||'******' AS REGI_NO ,B.REGI_YN,  \n")
		.append("      (SELECT UPJANG_NM FROM SALES.TRM010 WHERE UPJANG_SID=A.UPJANG_SID) AS HOTEL_NM,                 \n")
		.append("      (SELECT ROOM_TYPE_NM FROM SALES.TRM030 WHERE ROOM_TYPE_SID=A.ROOM_TYPE_SID) AS ROOM_NM,         \n")
		.append("      A.UPJANG_SID,A.ROOM_TYPE_SID,                                                                   \n")
		.append("      A.UPJANG_SID concat A.ROOM_TYPE_SID AS UPJANG_INFO,                                             \n")
		.append("      CASE WHEN D.USE_AMT-SALES.FN_PAY_AMT('3',A.RSV_SID,'N')= 0 THEN '�Ϸ�'                                           \n")
		.append("           WHEN SALES.FN_PAY_AMT('3',A.RSV_SID,'N')= 0 THEN '�̳�'     \n")
		.append("      END as RSTAT, D.USE_AMT AS TOT_TOUR_AMT,                                                                    \n")
		.append("       CASE WHEN B.TEL_NO = '' OR B.MOBILE_NO = '' OR B.ZIP_CD = '' OR B.ADDRESS1 = '' OR B.ADDRESS2 = '' OR B.COMPANY_NM != '�����' OR B.POSITIONS != '����' THEN '�Ϸ�'           \n")
		.append("            WHEN B.TEL_NO != '' OR B.MOBILE_NO != '' OR B.ZIP_CD != '' OR B.ADDRESS1 != '' OR B.ADDRESS2 != '' OR B.COMPANY_NM = '�����' OR B.POSITIONS = '����' THEN '���Է�'   \n")
		.append("       END TSTDT, F.PAY_AMT AS TOT_PAY_AMT, F.PAY_YN                                                                                \n")
		.append("       ,(select van_idx_no from sales.trv240 where pay_manage_no= F.PAY_MANAGE_NO) AS VAN_IDX_NO      \n")
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
		.append("       A.ACCEPT_SID=?   ORDER BY A.M_RSV_SID, A.RSV_SID").toString();
        
		try {
			pstmt = dbconn.prepareStatement(query.toString());

			// ���� ���ε�
			pstmt.setInt(1, accept_sid); 
            
			// ��� ���
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
	 *   ������ �� ���� ����
	 * @param cust_sid ����Ű
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �̼ҿ�
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
            
			// ���� ���ε�
			pstmt.setInt(1, cust_sid); 
			// ��� ���
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
	 *  ������ ���� ����
	 * @param data Reservation_bean
	 * @return exe int 1:���� , 0:����
	 * @throws DbException
	 * @throws Exception
	 * @author �̼ҿ�
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
				
				// ���� ���ε�
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
		 * ������ ���� ���
		 * @param data Reservation_bean
		 * @return exe int 1:���� , 0:����
		 * @throws DbException
		 * @throws Exception
		 * @author �̼ҿ�
		 */	 
	 public int getRevCancle(Reservation_bean data) throws DbException , Exception {

		Connection dbconn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result  = 0;
        
		try {
			
			dbconn.setAutoCommit(false);
	    
			if(data != null){
				
				/*------- @ 2006-10-26 �߰�------- */
				/*------- ������� ���ν���-------*/
				CallableStatement stpCall;
				System.out.println("----------START-----------------");
				String sql = "CALL SALES.PR_RV510I_02 (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				stpCall = dbconn.prepareCall( sql ); /* con is the connection */
				stpCall.setString( 1, "" );     //-- ������ȣ
				stpCall.registerOutParameter( 1, java.sql.Types.VARCHAR);     //-- ������ȣ
				stpCall.setInt( 2, 982);    //-- ����óSID
				stpCall.setString( 3, data.getRegdate());      //-- ��û��
				stpCall.setString( 4, data.getRegtime());      //-- ��û�ð�
				stpCall.setString( 5, "RR");        //-- �۾�����:RV024
				stpCall.setString( 6, "�̼���");     //-- �����
				stpCall.setString( 7, "3669-3724");      //-- ����ó
				stpCall.setString( 8, data.getRstdt());       //-- �����
				stpCall.setInt( 9, data.getAccept_sid());      //-- ��û��SID
				stpCall.setInt( 10, data.getRsv_sid());         //-- ����SID
				stpCall.setString( 11, "");       //-- �����ڵ�:RV027
				stpCall.setInt( 12, 0);    //-- ǥ�ذ�����
				stpCall.setString( 13, "");       //-- �۱�����:AC002
				stpCall.setString( 14, "");       //-- �۱ݰ���
				stpCall.setString( 15, "");      //-- ������
				stpCall.setInt( 16, 0);       //-- �ݾ�(ȯ��/����)
				stpCall.setString( 17, "��������");    //-- ����
				stpCall.setString( 18, "");      //-- ó�����
				stpCall.setString( 19, "2");     //-- ���ȯ�ұ���(RV030)
				stpCall.setString( 20, "9900001");      //-- ���������ڻ��
				stpCall.setString( 21, data.getCust_ip());      //-- ��������IP
				stpCall.setString( 22, "1");       //-- ��������     //1: INSERT, 2: DELETE, 3: UPDATE
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
            	
				/*���ν��� ȣ�� ����*/
	            
				
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
		 *  �������� �Է� 
		 * @param data Reservation_bean
		 * @return exe int 1:���� , 0:����
		 * @throws DbException
		 * @throws Exception
		 * @author �̼ҿ�
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
					.append("         QUOTA, SUCCESS, USER_KEY, U_EMPNO, U_IP, U_DATE)       \n")
					.append(" VALUES                                                                    \n")
					.append("        (?,?,?,?,                                                          \n")
					.append("         ?,?,?,?,?,                                                        \n")
					.append("         ?,?,?,?,                                                          \n")
					.append("         ?,?,?,?,?,CURRENT TIMESTAMP)                                            ").toString();
					
					pstmt = dbconn.prepareStatement(query);
					
					System.out.println("-----"+query);
					// ���� ���ε�
					pstmt.setString(1,data.getPay_manage_no());
					//System.out.println("--data.getPay_manage_no()---"+data.getPay_manage_no());
					pstmt.setInt(2,data.getPay_amt());
					//System.out.println("--data.getPay_amt()---"+data.getPay_amt());
					pstmt.setString(3,data.getOrder_nm());
					//System.out.println("--data.getOrder_nm()---"+data.getOrder_nm());
					pstmt.setString(4,data.getOrder_e_mail());
					//System.out.println("-data.getOrder_e_mail()----"+data.getOrder_e_mail());
					pstmt.setString(5,data.getOrder_tel_no());
					//System.out.println("--data.getOrder_tel_no()---"+data.getOrder_tel_no());
					pstmt.setString(6,data.getBuyr_tel2());
					//System.out.println("--data.getBuyr_tel2()---"+data.getBuyr_tel2());
					pstmt.setString(7,data.getResp_code());
					//System.out.println("--data.getResp_code()---"+data.getResp_code());
					pstmt.setString(8,data.getRes_msg());
					//System.out.println("-data.getRes_msg()----"+data.getRes_msg());
					pstmt.setString(9,data.getVan_idx_no());
					//System.out.println("--data.getVan_idx_no()---"+data.getVan_idx_no());
					pstmt.setString(10,data.getCard_cd());
					//System.out.println("-data.getCard_cd()----"+data.getCard_cd());
					pstmt.setString(11,data.getCard_name());
					//System.out.println("--data.getCard_name()---"+data.getCard_name());
					pstmt.setString(12,data.getApp_time());
					//System.out.println("-data.getApp_time()----"+data.getApp_time());
					pstmt.setString(13,data.getApp_no());
					//System.out.println("--data.getApp_no()---"+data.getApp_no());
					pstmt.setString(14,data.getQuota());
					//System.out.println("--data.getQuota()---"+data.getQuota());
					pstmt.setString(15,data.getSuccess());
					//System.out.println("-data.getSuccess()----"+data.getSuccess());
					pstmt.setString(16,data.getUser_key());
					//System.out.println("---data.getUser_key()--"+data.getUser_key());
					pstmt.setString(17,"9900001");
					//System.out.println("--9900001---"+"9900001");
					pstmt.setString(18,data.getCust_ip());
					//System.out.println("--data.getCust_ip()---"+data.getCust_ip());
					
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
//		   ���԰�� 2010-08-13
		   String client_inflow = data.getClient_nm();
		   int client_sid = 0;
		   String client_uid = new String();
		   
		   if(client_inflow=="military"){						
			   client_sid=2635;
			   client_uid="9900101";
		   }else{
			   client_sid=982;
			   client_uid="9900001";
		   }
					   //System.out.println("-------���� ����--------");
                      	    
					   //System.out.println("--------"+data.getRsv_sid_multi());
					   //System.out.println("--------"+data.getPay_amt());
                      	  
					   //StringTokenizer tokens = new StringTokenizer(data.getRsv_sid_multi(), "|" );  //����SID
					   //StringTokenizer tokens2 = new StringTokenizer(data.getPay_amt_multi(), "|" );  //�����ݾ�

					   StringTokenizer tokens = new StringTokenizer(String.valueOf(data.getRsv_sid_multi()), "|" );  //����SID
					   StringTokenizer tokens2 = new StringTokenizer(String.valueOf(data.getPay_amt_multi()), "|" );  //�����ݾ�
                      	    
					   //System.out.println("-----tokens.countTokens()-----------"+tokens.countTokens());
                            
                            
					   if(tokens.countTokens() > 1){
                            	
							   for( int x = 1; tokens.hasMoreElements(); x++ ){ //FOR
		                            	
								   System.out.println("---------x-----"+x);
								   CallableStatement stpCall;
								   String sql = "CALL SALES.PR_RV310I_02 (?,?,?,?,?,   ?)";
								   stpCall = dbconn.prepareCall( sql ); /* con is the connection */
								   stpCall.setInt(1,Integer.parseInt(tokens.nextToken()));
								   stpCall.setInt(2,Integer.parseInt(tokens2.nextToken()));
								   stpCall.setString(3,data.getPay_cd());
								   stpCall.setString(4,String.valueOf(data.getPay_manage_no()));
								   stpCall.setString(5,client_uid);
								   stpCall.setString(6,data.getCust_ip());
								   stpCall.execute();	

								   System.out.println("----------END-----------------"+x);
				
								   //String pS_YN = null;
								   //pS_YN = stpCall.getString(23);
        		
								   //if (pS_YN.equals("Y")){
									   dbconn.commit();    
								   //}
            																									
							   } //FOR
		                            
		                            
					   }else{
						   //1���� ��
						   CallableStatement stpCall;
						   String sql = "CALL SALES.PR_RV310I_02 (?,?,?,?,?,   ?)";
						   stpCall = dbconn.prepareCall( sql ); /* con is the connection */
						   stpCall.setInt(1,Integer.parseInt(data.getRsv_sid_multi()));
						   stpCall.setInt(2,data.getPay_amt());
						   stpCall.setString(3,data.getPay_cd());
						   stpCall.setString(4,String.valueOf(data.getPay_manage_no()));
						   stpCall.setString(5,client_uid);
						   stpCall.setString(6,data.getCust_ip());
						   stpCall.execute();	
				
						   //String pS_YN = null;
						   //pS_YN = stpCall.getString(23);
        		
						   //if (pS_YN.equals("Y")){
							   dbconn.commit();  
						   /*String query2 = new StringBuffer()
						   .append(" INSERT INTO SALES.TRV200 (RSV_SID, PAY_DATE, PAY_AMT, PAY_YN, \n")
						   .append("         PAY_CD, PAY_MANAGE_NO, U_EMPNO, U_IP, OPTION_YN )                               \n")
						   .append(" VALUES                                                        \n")
						   .append("        (?,REPLACE(CHAR(CURDATE()),'-','') ,?,'Y',?,?,?, ?, 'N')     ").toString();
						   pstmt = dbconn.prepareStatement(query2);

						   pstmt.setInt(1,Integer.parseInt(data.getRsv_sid_multi()));
						   pstmt.setInt(2,data.getPay_amt());
						   pstmt.setString(3,data.getPay_cd());
						   pstmt.setString(4,String.valueOf(data.getPay_manage_no()));
						   pstmt.setString(5,"9900001");
						   pstmt.setString(6,data.getCust_ip());
							
						   result2 = pstmt.executeUpdate();*/
						   //System.out.println("======"+result2);
								
					   }
					   System.out.println("::::::   END :::::");
                            

				   //if(result2 > 0){  //result2						
				   //	dbconn.commit();
				   //}else{ //result2
				   //		dbconn.rollback();
				   //} //result2
							
				
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
		 * ���������Է�
		 * @param bean  Reservation_bean
		 * @return exe int 1:���� , 0:����
		 * @throws DbException
		 * @throws Exception
		 * @author ����ƻ� �ɵ��� 2009-04-22
		 */
		 public String RevInsert(Reservation_bean data) throws DbException , Exception {

			Connection dbconn = getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String Message   = new String();
			boolean result4 = false;
		        
			try {
				
				dbconn.setAutoCommit(false);

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
				String age_cd 	 = new String();
				String mobile_no = new String();
				String join_cd	 = new String();
				String room_type_str = new String();
				int m_rsv_sid = 0;	//����.. ���忹��sid �����ؾ� ��..��_��.. ��..2009-04-22
				                    
				 /*������ ���� �Է� ����*/
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
				/*������ ���� �Է� �� ��û����ȣ ���⼭ ����..~ ����..*/
				System.out.println("�ɵ���:������ ���� �Է� ��");
				
				query1 = "";
				query1 = "SELECT RACCEPT_NO FROM SALES.TRV070 WHERE IDX =(SELECT MAX(IDX) FROM SALES.TRV070)";
				pstmt = dbconn.prepareStatement(query1);
				rs = pstmt.executeQuery();
				while(rs.next()){
					raccept_no=rs.getString(1);
				}//��� �Է��� ��û����ȣ ��������.

				/* ������ ���̺� ������Ʈ*/
				String query44 = new StringBuffer()
				.append(" UPDATE SALES.TRV010              \n")
				.append("    SET DEPART_DATE=?, SAUP_SID=?, GOODS_SID=? \n")
				.append("  WHERE ACCEPT_NO=?     ").toString();
				pstmt = dbconn.prepareStatement(query44);

				pstmt.setString(1,data.getRstdt());
				pstmt.setInt(2,Integer.parseInt(data.getSaup_sid()));
				pstmt.setInt(3,Integer.parseInt(data.getRscod()));
				pstmt.setString(4,raccept_no);
				pstmt.executeUpdate();
				
				/* �̹� �����ǿ� ���� ������ ���̺� �Է� ��*/
				System.out.println("�ɵ���:accept_no=="+raccept_no);
				System.out.println("�ɵ���:trv010 ������Ʈ��");
				
				query3= " SELECT ACCEPT_SID FROM SALES.TRV010 WHERE ACCEPT_NO='"+raccept_no+"'";
				pstmt = dbconn.prepareStatement(query3);
				rs = pstmt.executeQuery();
				String nullStr = null;
				int accept_sid=0;
				while(rs.next()) {
					accept_sid=rs.getInt(1);
				}
				
				
			                    
				/*������ ���� �Է� ����*/
					//�������� ������ �迭�� ����.
					StringTokenizer tokens_regi_no 		= new StringTokenizer( data.getRegi_no(), "," );
					StringTokenizer tokens_cust_nm 		= new StringTokenizer( data.getCust_nm(), "," );
					StringTokenizer tokens_age_cd 		= new StringTokenizer( data.getAge_cd(), "," );
					StringTokenizer tokens_mobile_no	= new StringTokenizer( data.getMobile_no(), "," );
					StringTokenizer tokens_join_cd		= new StringTokenizer( data.getJoin_cd(), "," );
					StringTokenizer tokens_room_type_str= new StringTokenizer( data.getRoom_type_str(), "," );

					for( int x = 1; tokens_cust_nm.hasMoreElements(); x++ ){  //(1)
                    	
						regi_no  =  tokens_regi_no.nextToken();
						cust_nm  =  tokens_cust_nm.nextToken();
						age_cd   =  tokens_age_cd.nextToken();
						mobile_no=  tokens_mobile_no.nextToken();
						join_cd	 =  tokens_join_cd.nextToken();
						room_type_str=  tokens_room_type_str.nextToken();
						

									                	
						/* ������������ ��û����ȣ ������Ʈ*/
						query1= "UPDATE SALES.TCU010 SET GROUP_CD= ? WHERE MANAGE_NO=?";  
						pstmt = dbconn.prepareStatement(query1);
						pstmt.setString(1,raccept_no);
						pstmt.setString(2,regi_no);
						pstmt.executeUpdate();
	
						query3= " SELECT CUST_SID FROM SALES.TCU010 WHERE MANAGE_NO=?";  
						pstmt = dbconn.prepareStatement(query3);
						pstmt.setString(1,regi_no);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							cust_sid=rs.getInt(1);
						}

						//�����ڵ忡 ���� ���忹��sid�� �ٽ� ã�ƿ´�...��..;;
						//���Ͻ�û����ȣ���� ������� �Էµ�(����ū RSV_SID)��..
						query3= " SELECT MAX(RSV_SID) FROM SALES.TRV020 WHERE ACCEPT_SID=?";  
						pstmt = dbconn.prepareStatement(query3);
						pstmt.setInt(1,accept_sid);
						if(join_cd.equals("01")){
							m_rsv_sid=0;
						}else{
							rs = pstmt.executeQuery();
							while(rs.next()) {
								m_rsv_sid=rs.getInt(1);
							}								
						}

						
						
						
						/* ������������ ��û����ȣ ������Ʈ �� */
					        	 
							CallableStatement stpCall;
							String sql = "CALL SALES.PR_RV200I_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?)";
							stpCall = dbconn.prepareCall( sql ); /* con is the connection */
							stpCall.setInt( 1, accept_sid ); //��û��SID
							System.out.println("---1.��û����ȣ(Int)-----"+accept_sid);
							stpCall.registerOutParameter( 1, java.sql.Types.DECIMAL);
							stpCall.setString( 2, raccept_no ); //��û��NO
							System.out.println("---2. ��û��NO(String)-----"+group_cd);
							stpCall.registerOutParameter( 2, java.sql.Types.DECIMAL);
							stpCall.setString( 3, data.getRstdt() ); //�������
							System.out.println("---3. �������(String)-----"+data.getRstdt());
							stpCall.setInt( 4, Integer.parseInt(data.getRscod())); //��ǰSID
							System.out.println("---4. ��ǰ��ȣ(Int)-----"+Integer.parseInt(data.getRscod()));
							stpCall.setInt( 5, 982 );
							System.out.println("-----5.������(Int)----------982");
							stpCall.setInt( 6, 0 );
							System.out.println("-----6.������(Int)----------0");
							stpCall.setString( 7, "1" );
							System.out.println("-----7.������(String)----------1");
							stpCall.setInt( 8, 0 );
							System.out.println("-----8.������(Int) rsv_sid----------0");
							stpCall.registerOutParameter( 8, java.sql.Types.DECIMAL);
							stpCall.setInt( 9, m_rsv_sid );
							System.out.println("-----9.(Int) m_rsv_sid ----------"+ m_rsv_sid);
							stpCall.registerOutParameter( 9, java.sql.Types.INTEGER);
							stpCall.setInt( 10, Integer.parseInt(room_type_str)); //����SID
							System.out.println("--10. ����Ÿ��SID(Int)------"+room_type_str);
							stpCall.setInt( 11, 0 );
							System.out.println("-----11.������(Int) room_sid ----------0");
							stpCall.registerOutParameter( 11, java.sql.Types.DECIMAL);
							stpCall.setInt( 12, 0 );
							System.out.println("-----12.������(Int) block_sid ----------0");
							stpCall.setString( 13, "2" );
							System.out.println("-----13.������(Int) rsv_type ----------2");
							stpCall.setString( 14, data.getDepart_time() );
							System.out.println("-----14.���ð�(String)----------"+data.getDepart_time());
							stpCall.setInt( 15, Integer.parseInt(data.getNights())); //���ڼ�
							System.out.println("--15. ���ڼ�(Int)------"+data.getNights());
							stpCall.setString( 16, data.getRedt() ); //��������
							System.out.println("--16. ��������(String)------"+data.getRedt());
							stpCall.setString( 17, data.getArrive_time() );
							System.out.println("-----17.������(String)----------"+data.getArrive_time());
							stpCall.setInt( 18, cust_sid );
							System.out.println("--18. ������ȣ(Int) cust_sid ------"+cust_sid);
							stpCall.setString( 19, "1" );
							System.out.println("-----19.������(String) cust_gu ----------1");
							stpCall.setString( 20, "10" );
							System.out.println("-----20.������(String) saup_gu ----------10");
							stpCall.setString( 21, "010" );
							System.out.println("-----21.������(String) cust_type ----------010");
							stpCall.setString( 22, age_cd );
							System.out.println("--22. ���ɰ�(String)------"+age_cd);
							stpCall.setString( 23, join_cd );
							System.out.println("-----23.������(String) ����----------"+ join_cd);
							stpCall.setString( 24, mobile_no );
							System.out.println("-----24.������(String) �޴���----------");
							stpCall.setString( 25, "" );
							System.out.println("-----25.��ġ��(String)----------����");
							stpCall.setString( 26, "2" );
							System.out.println("-----26.������(String)rsv_way_cd----------2");
							stpCall.setString( 27, data.getRname()+"-"+data.getRmob());
							System.out.println("--27. remarks------"+data.getRname()+"-"+data.getRmob());
							stpCall.setString( 28, "9900001" );
							System.out.println("-----28.�����ھƵ�(String)----------9900001");
							stpCall.setString( 29, data.getCust_ip());
							System.out.println("--29. ���Ӿ�����(String)------"+data.getCust_ip());
							stpCall.setString( 30, "N" );
							System.out.println("-----30.����(String)----------n");
							stpCall.setString( 31, "N" );
							System.out.println("-----31.����(String)----------n");
							stpCall.setString( 32, "N" );
							System.out.println("-----32.�ָ�(String)----------n");
							stpCall.setString( 33, "" );
							System.out.println("-----33.�׸�(String)----------����");
							stpCall.setInt( 34, 1); //��ǰ����
							System.out.println("--34. ��ǰ����(Int)------1");
							stpCall.setString( 35, "1" );
							System.out.println("-----35.������(String)��������----------1");
							stpCall.setString( 36, "41" );
							System.out.println("-----36.������(String)���ν��� ȣ�� ID----------41");
							stpCall.registerOutParameter( 37, java.sql.Types.VARCHAR);
							stpCall.registerOutParameter( 38, java.sql.Types.VARCHAR);
							stpCall.registerOutParameter( 39, java.sql.Types.VARCHAR);                	
							stpCall.execute();
		                	
							String pS_YN = null;
							pS_YN = stpCall.getString(37);
							Message = stpCall.getString(39);
							if(Message == null || Message.equals("")){
								Message = "������ �����Ͽ����ϴ�.";
							}else{
								Message = stpCall.getString(39);
							}
							Message = Message+"|"+pS_YN;
							//Message = stpCall.getString(33);

							System.out.println("----------Message(1)--------------"+Message);
							System.out.println("----------pS_YN(1)--------------"+pS_YN);
		                	
							if (pS_YN.equals("Y")){
									//dbconn.commit();			                		    
									/*------- @ 2006-10-26 �߰�------- */
									/*------- ��ݰ�� ���ν��� ȣ��-------*/
									CallableStatement stpCall2;
									String sql2 = "CALL SALES.PR_RV200I_06 (?,?,?,?,?,?,?,?,?,?)";
									stpCall2 = dbconn.prepareCall( sql2 ); /* con is the connection */
									stpCall2.setInt( 1, accept_sid ); //��û��SID
									stpCall2.registerOutParameter( 2, java.sql.Types.NUMERIC ); //�Ѱ������
									stpCall2.registerOutParameter( 3, java.sql.Types.NUMERIC ); //�Ѱ����ο�
									stpCall2.setString( 4, "AC110I" ); //������ID
									stpCall2.setString( 5, "9900001" ); //���������ڻ��
									stpCall2.setString( 6, data.getCust_ip() ); //��������IP
									stpCall2.setString( 7, "3" ); //��������     1: INSERT, 2: DELETE, 3: UPDATE
									stpCall2.registerOutParameter( 8, java.sql.Types.VARCHAR ); //����Y/N
									stpCall2.registerOutParameter( 9, java.sql.Types.VARCHAR ); //�޼��� �ڵ�
									stpCall2.registerOutParameter( 10, java.sql.Types.VARCHAR ); //�޼���
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
							System.out.println("�ɵ���:��ݰ��ȣ��  ��");
							if (Message == null || Message.equals("")){
								Message = "�¶��ο��࿡ �����Ͽ����ϴ�.|N";
							}
		                	
							rs.close();
							/*���ν��� ȣ�� ����*/

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
				Message = "�¶��ο��࿡ �����Ͽ����ϴ�.|N";
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
				.append(" 	1111 , '�����',                 \n")
				.append(" 	0, 982, '1',  '9900001' , ? )                          ").toString();
				pstmt = dbconn.prepareStatement(query2);
				// ���� ���ε�
				pstmt.setString(1,raccept_no);
				pstmt.setString(2,data.getRegi_no());
				pstmt.setString(3,data.getRegi_no());
				pstmt.setString(4,data.getCust_nm());
				pstmt.setString(5,birthDate);
				pstmt.setString(6,custSex);
				pstmt.setString(7,data.getCust_ip()); //@�ش�����IP
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
					// ���� ���ε�
					pstmt.setString(1,group_cd);
					pstmt.setString(2,data.getRstdt());
					pstmt.setString(3,data.getCust_ip());
					result3 = pstmt.executeUpdate();
					
					
					if (result3 > 0){
						
						/*���ν��� ȣ��*/
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
//				throw new DbException(e.getMessage());
			}finally{
				//rollback(dbconn);
				release(pstmt);
				freeConnection(dbconn); 
			}
			return result;

		 }		 
		 

		/**
		 *   �ֹ���ȣȣ��
		 * @param 
		 * @return Reservation_bean []
		 * @throws DbException
		 * @throws Exception
		 * @author �̼ҿ�
		 */
		 public String getManageNo() throws DbException , Exception {
		 	
			Connection dbconn = getConnection();
			PreparedStatement pstmt = null;
			String result   = "";
			String ManageNo = new String();
			try {
				dbconn.setAutoCommit(false);
				
				/*���ν��� ȣ��*/
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
	 * �ֹε�Ϲ�ȣ�� ���� ���Ƴ���
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

				// ��� ���
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
	 * �־��� ������ ���� ��ȸ�ϱ�
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
			String goods_sid = param.getGoods_cd();			//��ǰID
			//String saup_sid = param.getSaup_sid();			//������ID
			String upjang_sid = param.getUpjang_sid()+"";	//����SID		
			String room_type_sid = param.getRoom_type_sid()+"";	//����SID
			String age_cd = param.getAge_cd();				//�����ڵ�
			String start_ymd = param.getDepart_date();		//�������
			String cnt = param.getPerson_cnt();				//���ǿ� ������ �ο���
			//����ġ��
			query.append("SELECT SALES.FN_USE_ROOM_AMT('1', '");
			query.append(start_ymd).append("', ").append(goods_sid).append(", ");
			query.append(room_type_sid).append(", '").append(age_cd).append("', "+cnt+") AS PRICE ");
			query.append(" FROM SYSIBM.SYSDUMMY1");
				
			//System.out.println(query.toString());
			pstmt = dbconn.prepareStatement(query.toString());
            
			// ��� ���
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
	 * ������ ID�� �˾Ƴ����� ���� , ���ν���
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
			String jumin = param.getRegi_no();			//�ֹε�Ϲ�ȣ
			String nm = param.getCust_nm();				//������
			String mobile_no = param.getMobile_no();	//����ó
			String foreigner_cd = param.getForeigner_cd();	//�ܱ��α���

			//��������
			stpCall = dbconn.prepareCall(query.toString());

			//������
			if(foreigner_cd.equals("10")) {
				//System.out.println(jumin);
				//System.out.println(nm);
				//System.out.println(tel);
				//System.out.println("19"+jumin.substring(0,6));
		    	
				stpCall.setString(1, jumin);
				//System.out.println("1::"+jumin);
				stpCall.setString(2, nm);
				//System.out.println("2::"+nm);
				stpCall.setString(3, mobile_no);
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
		    	
			//�ܱ���
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

			//������ 
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


	/**
	 * �ش� ������� �ߺ����� Ȯ�� 2009-02-23
	 * @param param
	 * @return dup_yn
	 * @throws DbException
	 * @throws Exception
	 */
	public String getDupYn(Reservation_bean param) throws DbException, Exception {
		String dup_yn = "";
		Connection dbconn = getConnection();
		CallableStatement stpCall = null;

		StringBuffer query = new StringBuffer("");
		query.append("CALL SALES.PR_OL_06(?,?,?,?)");
				
		try {
			String depart_date = param.getDepart_date();	//�������
			String goods_sid = param.getGoods_cd();		//��ǰID
			int cust_sid = param.getCust_sid();			//���� sid
			

			//��������
			stpCall = dbconn.prepareCall(query.toString());

			stpCall.setString(1, depart_date);
			stpCall.setInt(2, Integer.parseInt(goods_sid));
			stpCall.setInt(3, cust_sid);
			stpCall.setString(4, "");
			stpCall.registerOutParameter(4,java.sql.Types.VARCHAR);
			
			
			//������ 
			stpCall.execute();
			dup_yn = stpCall.getString(4);
			System.out.println("�¶����ߺ�����:::"+dup_yn);
			stpCall.close();			
			
		} catch (SQLException e) {
			e.printStackTrace(new PrintWriter(System.out));
		}finally{
			release(stpCall);
			freeConnection(dbconn); 
		}
		return dup_yn;
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
			String start_ymd = param.getDepart_date();	//�����
			String goods_sid = param.getGoods_cd();		//��ǰID

			//��������
			stpCall = dbconn.prepareCall(query.toString());

			stpCall.setString(1, start_ymd);
			stpCall.setInt(2, Integer.parseInt(goods_sid));

			//������ 
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
	 * DBConn ��ȯ
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
			stpCall.registerOutParameter(1, java.sql.Types.DECIMAL);		//��û��SID
			
			stpCall.setString(2, param.getAccept_no());						//��û����ȣ
			stpCall.registerOutParameter(2, java.sql.Types.VARCHAR);		
			
			stpCall.setString(3, param.getRstdt());							//�������
			
			stpCall.setInt(4, Integer.parseInt(param.getGoods_cd()));		//��ǰSID
			
			stpCall.setInt(5, 982);											//������ ����ó
			stpCall.setInt(6, 0);											//������ ��ü��� ev_sid
			stpCall.setString(7, "1");										//������ �۾�����
			
			stpCall.setInt(8, 0);											//RSV_SID
			stpCall.registerOutParameter(8, java.sql.Types.DECIMAL);		//����SID
			
			stpCall.setInt(9, param.getRsv_sid());							//M_RSV_SID	
			stpCall.registerOutParameter(9, java.sql.Types.DECIMAL);		//�����Ϳ���SID
			
			stpCall.setInt(10, param.getRoom_type_sid());					//���� SID
			
			stpCall.setInt(11, 0);											//�� sid		
			stpCall.registerOutParameter(11, java.sql.Types.DECIMAL);		//������
			
			stpCall.setInt(12, 0);											//������ block_sid
			stpCall.setString(13,"2");										//������ ����Ÿ��(2=�Ϲ�)
			
			stpCall.setString(14, param.getDepart_time());					//��߽ð�
			stpCall.setInt(15, Integer.parseInt(param.getNights()));		//���ڼ�
			stpCall.setString(16, param.getArrive_date());					//������
			stpCall.setString(17, param.getArrive_time());					//�����ð�
			stpCall.setInt(18, param.getCust_sid());						//����SID
			stpCall.setString(19, "1");										//������
			stpCall.setString(20, "10");									//������
			stpCall.setString(21, "010");									//������
			stpCall.setString(22, param.getAge_cd());						//�����ڵ�
			
			if(param.getRsv_sid() == 0) {
				stpCall.setString(23, "01");								//�����ڵ�
			} else {
				stpCall.setString(23, "02");								//�����ڵ�
			}
			stpCall.setString(24, param.getTel_no());						//��ȭ��ȣ
			stpCall.setString(25, "9900001");								//������
			stpCall.setString(26, "2");										//������
			stpCall.setString(27, "ON"+param.getCust_nm()+"-"+param.getTel_no());
			stpCall.setString(28, "9900001");								//������
			stpCall.setString(29, param.getCust_ip());						//������
			stpCall.setString(30, "N");										//������
			stpCall.setString(31, "N");										//������
			stpCall.setString(32, param.getWeekend_yn());					//�ָ�����
			stpCall.setString(33, "01"); 									//������
			stpCall.setString(34, "1");										//������
			stpCall.setString(35, "41");									//������
			stpCall.registerOutParameter(36, java.sql.Types.VARCHAR);		//������
			stpCall.registerOutParameter(37, java.sql.Types.VARCHAR);		//������
			stpCall.registerOutParameter(38, java.sql.Types.VARCHAR);		//������
			
			stpCall.execute();
			returnMsg = stpCall.getString(36);
		} catch (SQLException e) {
			e.printStackTrace(new PrintWriter(System.out));
		} catch (Exception e) {
			
		}
		return returnMsg;
	}
	
	
	/**
	 * ����Ȯ���� �̱⳻�� ����
	 * @param rsv_sid
	 * @return Reservation_bean []
	 * @throws DbException
	 * @throws Exception
	 * @author �ɵ���
	 */
	public Reservation_bean [] getRsvConfirm18(int idx) 
		throws DbException , Exception 
	{
		Connection dbconn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Collection list = null;

		// SQL
		String query = new StringBuffer()
		.append("SELECT R2.RSV_SID, C1.CUST_NM, SUBSTRING(C1.MANAGE_NO,1,6)||'-'||SALES.FN_SECURE_RETURN(SUBSTRING(C1.MANAGE_NO,7,7),1) AS REGI_NO                                                               \n")
		.append(",(SELECT GOODS_NM FROM SALES.TRM200 WHERE GOODS_SID=R2.GOODS_SID) AS GOODS_NM                              \n")
		.append(",R1.ACCEPT_NO                                                                                              \n")
		.append(",CASE WHEN SALES.FN_PAY_AMT('3',R2.RSV_SID,'N')= 0 THEN '������(���Ա�)'								\n")
		.append("      ELSE '����Ȯ��(�ԱݿϷ�)' END AS rstat														\n")
		.append(", R2.I_DATE AS regtime                                                               \n")
		.append(",C2.CLIENT_NM,C2.TEL_NO                                                                                    \n")
		.append(",CASE F1.PAY_CD WHEN '050' THEN '�ſ�ī�� �¶��ΰ���'                                                      \n")
		.append("                WHEN '040' THEN '�ſ�ī�� ��ȭ����'                                                        \n")
		.append("                WHEN '020' THEN '������� �Ա�' END AS PAY_CD                                \n")
		.append(",F1.PAY_DATE                                                                                    \n")
		.append(",CASE F1.PAY_CD WHEN '050' THEN (select ORDER_NM from sales.trv240 where pay_manage_no= F1.PAY_MANAGE_NO)  \n")
		.append("                WHEN '040' THEN ''                                                                         \n")
		.append("                WHEN '020' THEN (select ORDER_NM from sales.trv210 where pay_manage_no= F1.PAY_MANAGE_NO)  \n")
		.append("                END  AS ORDER_NM                                                                  \n")
		.append(",F1.PAY_AMT                                                                               \n")
		.append(",F1.PAY_MANAGE_NO                                                                          \n")
		.append(",CASE F1.PAY_CD WHEN '040' THEN (select CARD_NO from sales.trv220 where pay_manage_no= F1.PAY_MANAGE_NO)   \n")
		.append("                ELSE '' END AS CARD_NO                                                           \n")
		.append(",CASE F1.PAY_CD WHEN '040' THEN (select AGREE_NO from sales.trv220 where pay_manage_no= F1.PAY_MANAGE_NO)  \n")
		.append("                ELSE '' END AS AGREE_NO                                                          \n")
		.append("                                                                                                           \n")
		.append(",CASE F1.PAY_CD WHEN '020' THEN (select BANK_NM from sales.trv210 where pay_manage_no= F1.PAY_MANAGE_NO)   \n")
		.append("                ELSE '' END AS BANK_NM                                                              \n")
		.append(",CASE F1.PAY_CD WHEN '020' THEN (select BANK_ACCT from sales.trv210 where pay_manage_no= F1.PAY_MANAGE_NO) \n")
		.append("                ELSE '' END AS BANK_ACCT                                                     \n")
		.append("                                                                                                           \n")
		.append(",CASE F1.PAY_CD WHEN '050' THEN (select van_idx_no from sales.trv240 where pay_manage_no= F1.PAY_MANAGE_NO)\n")
		.append("                ELSE '' END AS VAN_IDX_NO                                                     \n")
		.append(",IFNULL(C3.SPA_YN,'') AS SPA_YN	\n")
		.append("  FROM SALES.TRV020 R2 JOIN SALES.TRV010 R1 ON (R2.ACCEPT_SID=R1.ACCEPT_SID)                               \n")
		.append("  JOIN SALES.TCU010 C1 ON (R2.CUST_SID=C1.CUST_SID)                                                        \n")
		.append("  JOIN SALES.TCU030 C2 ON (R2.CLIENT_SID=C2.CLIENT_SID)                                                    \n")
		.append("       LEFT OUTER JOIN SALES.TRV200 F1 ON (R2.RSV_SID = F1.RSV_SID)                                        \n")
		.append("		LEFT OUTER JOIN SALES.TCU012 C3 ON (C1.CUST_SID = C3.CUST_SID)    \n")
		.append(" WHERE R2.RSV_SID = ?                                                                                      \n").toString();     
        
		try { 

			System.out.println("------idx---------"+idx);
			System.out.println("------query---------"+query);
        	
			pstmt = dbconn.prepareStatement(query);
            
			// ���� ���ε� 
			pstmt.setInt(1, idx); 

			// ��� ���
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
		
	
}

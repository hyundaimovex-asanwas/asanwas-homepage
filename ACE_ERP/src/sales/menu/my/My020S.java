package sales.menu.my;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDCookieManager;
import sales.common.StringUtil;
import sales.common.my.BaseCommand;
import sales.common.my.BaseDataClass;

/*
 * 보낸편지함 
 */
public class My020S extends BaseCommand {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
 		
		//  조회 
		arr_sql[0].append("SELECT * FROM SALES.TMY010 		\n")
				  .append("WHERE  							\n")
				  .append("		DELYN='N' 					\n")
				  .append("		AND OUT_YN='N'				\n")
				  .append("		AND SEND_LOGIN_ID = ?		\n")
				  .append("ORDER BY SEND_DATE DESC 			\n");
		
		//  등록 
		arr_sql[1].append("INSERT INTO SALES.TMY010 (   		\n")
					.append("	BRD_SUBJECT,  					\n")
					.append("	SEND_DATE,  					\n")   
					.append("	BRD_CONTENTS,  					\n")
					.append("	REAL_FILE,  					\n")
					
					.append("	SYS_FILE,  						\n")
					.append("	OUT_LOGIN_ID,  					\n")
					.append("	SEND_LOGIN_ID,  				\n")
					.append("	OUT_YN,  						\n")      
					.append("	DELYN,							\n")
					.append("	SEND_IP  )						\n")
					.append("VALUES	(							\n")
					.append("	?,CURRENT TIMESTAMP,?	, ?,	\n")
					.append("	?,?,?,'N','N', ?)						\n");

        
		//  확인 
		arr_sql[2].append("UPDATE SALES.TMY010 SET OUT_YN='Y' WHERE BRD_NO = ?");
		
		
		//  상세 
		arr_sql[3].append("SELECT * FROM SALES.TMY010 		\n")
				  .append("WHERE 							\n")
				  .append("		 BRD_NO = ?				\n");
				
		//  삭제 
		arr_sql[4].append("UPDATE SALES.TMY010 SET DELYN = 'Y' WHERE BRD_NO = ?");
		
		
	}

	public String select(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 1;
		try {
			
			// 조건 
			HDCookieManager cookie = new HDCookieManager(req,res);
			String user_id = cookie.getCookieValue("user_id",req);
		        
		StringUtil.printMsg("보내는사람", user_id, this );
		
			pstmt = conn.prepareStatement(arr_sql[0].toString());
			
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			 
			/* 데이터 넣기 */
			ArrayList arrBeans = new ArrayList();
			BaseDataClass data = null;
			 
			while(rs.next()) {
				data = new BaseDataClass();
				data.setValues(rs);
				arrBeans.add(data);
			}
			 
			req.setAttribute("DATA",arrBeans);
			 
			rs.close();
			pstmt.close();
			conn.close();
			
			/*
			 * 파라미터를 새로 쓴다
			 */
			req.setAttribute("PARAM",param);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/jsp/error/error.jsp";
		}
		
		return "/Sales/my/my020s.jsp?menu_title=my020s&ut=A&mt=M";
	}

	public String insert(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		//TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		int cnt = 1;
		try {
			// 등록 
			
			pstmt = conn.prepareStatement(arr_sql[1].toString());
			
			pstmt.setString(cnt++, param.get("brd_subject"));
			pstmt.setString(cnt++, param.get("brd_contents"));
			pstmt.setString(cnt++, param.get("real_file"));
			pstmt.setString(cnt++, param.get("sys_file"));
			pstmt.setString(cnt++, param.get("out_login_id"));
			pstmt.setString(cnt++, param.get("send_login_id"));
			pstmt.setString(cnt++, req.getRemoteAddr());
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
			/*
			 * 파라미터를 새로 쓴다
			 */
			req.setAttribute("PARAM",param);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/jsp/error/error.jsp";
		}
		
		return "/servlet/sales.common.my.BaseServlet?actId=my020s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my020s";
	}

	// 확인
	public String update(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		//TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		int cnt = 1;
		try {
			
			// 수정
			pstmt = conn.prepareStatement(arr_sql[2].toString());
			
			pstmt.setInt(cnt++, Integer.parseInt(param.get("brd_no")));
			
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
			/*
			 * 파라미터를 새로 쓴다
			 */
			req.setAttribute("PARAM",param);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/jsp/error/error.jsp";
		}
		
		return "/servlet/sales.common.my.BaseServlet?actId=my020s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my020s";
	}

	public String delete(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 1;
		try {
			
			pstmt = conn.prepareStatement(arr_sql[4].toString());
			pstmt.setInt(1, Integer.parseInt(param.get("brd_no")));
			
			pstmt.executeUpdate();
			 
			pstmt.close();
			conn.close();
			
			/*
			 * 파라미터를 새로 쓴다
			 */
			req.setAttribute("PARAM",param);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/jsp/error/error.jsp";
		}
		
		return "/servlet/sales.common.my.BaseServlet?actId=my020s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my020s";
	}
	
	// 상세 
	public String modify(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 1;
		try {
			
			
			// 조건 
			pstmt = conn.prepareStatement(arr_sql[3].toString());
			pstmt.setInt(1, Integer.parseInt(param.get("brd_no")));
			
			rs = pstmt.executeQuery();
			 
			/* 데이터 넣기 */
			ArrayList arrBeans = new ArrayList();
			BaseDataClass data = null;
			 
			while(rs.next()) {
				data = new BaseDataClass();
				data.setValues(rs);
				arrBeans.add(data);
			}
			 
			req.setAttribute("DATA",data);
			 
			rs.close();
			pstmt.close();
			conn.close();
			
			/*
			 * 파라미터를 새로 쓴다
			 */
			req.setAttribute("PARAM",param);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/jsp/error/error.jsp";
		}
		
		return "/Sales/my/my020v.jsp?menu_title=my020v&ut=A&mt=M";
	}
	
	// 상세 수정 가능한 
	public String edit(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		
		return "";
	}
	
	// 답글 
	public String reply(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		//TODO Auto-generated method stub
		
		return "";
	}
}

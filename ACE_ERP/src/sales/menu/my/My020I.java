package sales.menu.my;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.StringUtil;
import sales.common.my.BaseCommand;
import sales.common.my.BaseDataClass;

public class My020I extends BaseCommand {
 
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//  조회 
		arr_sql[0].append("SELECT * FROM SALES.TMY020 		\n")
				  .append("WHERE BRD_GU = '01' 				\n")
				  .append("		AND DELYN='N' 				\n")
//				  .append("		AND REF_STEP=0				\n")
//				   .append("		AND REF_STEP=0				\n")
				  .append("ORDER BY BRD_CDATE DESC, REF_STEP DESC, REF_LEVEL DESC,REF DESC 	\n");
		
		//  등록 / 답변 등록
		arr_sql[1].append("INSERT INTO SALES.TMY020 (   		\n")
					.append("	BRD_NO, 						\n")
					.append("	BRD_GU,  						\n")
					.append("	BRD_SUBJECT,  					\n")
					.append("	BRD_CREATOR,  					\n")
					.append("	BRD_CDATE,  					\n")   
			
					.append("	BRD_CONTENTS,  					\n")
					.append("	REAL_FILE,  					\n")
					.append("	SYS_FILE,  						\n")
					.append("	BRD_VIEWCNT,  					\n")
					.append("	BRD_PASSWD,  					\n")           
			
					.append("	REF,  							\n")
					.append("	REF_STEP,  						\n")
					.append("	REF_LEVEL,  					\n")
					.append("	DELYN  )						\n")
					.append("VALUES	(							\n")
					.append("	?,'01',?,?,CURRENT TIMESTAMP,	\n")
					.append("	?,?,?,0,?,						\n")
					.append("	0,0,0,'N' )						\n");

		
		//  상세전 HIT 업데이트 
		arr_sql[2].  append(" UPDATE SALES.TMY020 SET 			\n")
				       .append(" BRD_VIEWCNT = BRD_VIEWCNT+1	\n")
				       .append(" WHERE 							\n")
				       .append(" BRD_NO = ? 					\n");
        
		//  상세 
		arr_sql[3].append("SELECT * FROM SALES.TMY020 		\n")
				  .append("WHERE BRD_GU = '01' 				\n")
				  .append("		AND DELYN='N' 				\n")
//				  .append("		AND REF_STEP=0				\n")
				  .append("		AND BRD_NO = ?				\n")
//				  .append("ORDER BY REF DESC, REF_STEP ASC 	\n");
				  .append("ORDER BY REF ASC, REF_STEP DESC 	\n");
				
		//  삭제 
		arr_sql[4].append("UPDATE SALES.TMY020 SET DELYN = 'Y' WHERE BRD_NO = ?");
		
		//  수정 
		arr_sql[5].append("UPDATE SALES.TMY020 SET    				\n")
					.append("	BRD_SUBJECT = ?,  					\n")
					.append("	BRD_CDATE	= CURRENT TIMESTAMP,  	\n")   
					.append("	BRD_CONTENTS = ?,  					\n")
					.append("	REAL_FILE = ?,  					\n")
					.append("	SYS_FILE = ?,  						\n")
			
					.append("	REF = ?,  							\n")
					.append("	REF_STEP = ?,  						\n")
					.append("	REF_LEVEL = ?,  					\n")
					.append("	DELYN = 'N' 						\n")
					.append("WHERE BRD_NO = ?						\n");
		
		//  답글 REF_STEP 업데이트
		arr_sql[6].append("")
				 .append(" UPDATE SALES.TMY020 SET 				\n")
		         .append(" 		REF_STEP = REF_STEP + 1 		\n")
		         .append(" WHERE 								\n")
		         .append(" 		BRD_GU = '01' 					\n")
		         .append(" 		AND REF = ? 					\n")
		         .append(" 		AND REF_STEP > ? 				\n");
//		
		//  등록 / 답변 등록
		arr_sql[7].append("INSERT INTO SALES.TMY020 (   		\n")
					.append("	BRD_NO, 						\n")
					.append("	BRD_GU,  						\n")
					.append("	BRD_SUBJECT,  					\n")
					.append("	BRD_CREATOR,  					\n")
					.append("	BRD_CDATE,  					\n")   
			
					.append("	BRD_CONTENTS,  					\n")
					.append("	REAL_FILE,  					\n")
					.append("	SYS_FILE,  						\n")
					.append("	BRD_VIEWCNT,  					\n")
					.append("	BRD_PASSWD,  					\n")           
			
					.append("	REF,  							\n")
					.append("	REF_STEP,  						\n")
					.append("	REF_LEVEL,  					\n")
					.append("	DELYN  )						\n")
					.append("VALUES	(							\n")
					.append("	?,'01',?,?,CURRENT TIMESTAMP,	\n")
					.append("	?,?,?,0,?,						\n")
					.append("	?,?,?,'N' )						\n");

		
	}

	public String select(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 1;
		try {
			
			// 조건 
		        
			pstmt = conn.prepareStatement(arr_sql[0].toString());
			 
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
		
		return "/Sales/my/my210s.jsp?menu_title=my210s&ut=A&mt=M";
	}

	public String insert(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		//TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		int cnt = 1;
		try {
			
			// MaxConut
			pstmt = conn.prepareStatement("SELECT COALESCE(MAX(BRD_NO),0)+1 BRD_NO FROM SALES.TMY020 ");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt(1); // MaxCount
			}
			
			
			rs.close();
			pstmt.close();
			
			// 등록 
			
			pstmt = conn.prepareStatement(arr_sql[1].toString());
			
			pstmt.setInt(cnt++, count);
			pstmt.setString(cnt++, param.get("brd_subject"));
			pstmt.setString(cnt++, param.get("brd_creator"));
			pstmt.setString(cnt++, param.get("brd_contents"));
			pstmt.setString(cnt++, param.get("real_file"));
			pstmt.setString(cnt++, param.get("sys_file"));
			pstmt.setString(cnt++, param.get("brd_passwd"));

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
		
		return "/servlet/sales.common.my.BaseServlet?actId=my210s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my210s";
	}

	public String update(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		//TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		int cnt = 1;
		try {
			
			// 수정
			pstmt = conn.prepareStatement(arr_sql[5].toString());
			
			pstmt.setString(cnt++, param.get("brd_subject"));
			pstmt.setString(cnt++, param.get("brd_contents"));
			pstmt.setString(cnt++, param.get("real_file"));
			pstmt.setString(cnt++, param.get("sys_file"));
			pstmt.setInt(cnt++, Integer.parseInt(param.get("ref")));
			pstmt.setInt(cnt++, Integer.parseInt(param.get("ref_step")));
			pstmt.setInt(cnt++, Integer.parseInt(param.get("ref_level")));
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
		
		return "/servlet/sales.common.my.BaseServlet?actId=my210s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my210s";
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
		
		return "/servlet/sales.common.my.BaseServlet?actId=my210s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my210s";
	}
	
	// 상세 
	public String modify(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 1;
		try {
			
			// HIT
			
			pstmt = conn.prepareStatement(arr_sql[2].toString());
			
			
			pstmt.setInt(1, Integer.parseInt(param.get("brd_no")));
			
			pstmt.executeUpdate();
			
			pstmt.close();
			
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
		
		return "/Sales/my/my210v.jsp?menu_title=my210v&ut=A&mt=M";
	}
	
	// 상세 수정 가능한 
	public String edit(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 1;
		try {
			
			
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
		
		return "/Sales/my/my210m.jsp?menu_title=my210v&ut=A&mt=M";
	}
	
	// 답글 
	public String reply(Connection conn, HttpServletRequest req,
			HttpServletResponse res, BaseDataClass param) {
		//TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		int cnt = 1;
		try {
			// 답글 ref_step 업데이트 
			pstmt = conn.prepareStatement(arr_sql[6].toString());

			pstmt.setInt(1, Integer.parseInt(param.get("ref")));
			pstmt.setInt(2, Integer.parseInt(param.get("ref_step")));

			pstmt.executeUpdate();
			pstmt.close();
			
			
			// MaxConut
			pstmt = conn.prepareStatement("SELECT COALESCE(MAX(BRD_NO),0)+1 BRD_NO FROM SALES.TMY020 ");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt(1); // MaxCount
			}
			
			
			rs.close();
			pstmt.close();
			
			// 등록 
			
			pstmt = conn.prepareStatement(arr_sql[7].toString());
			
			pstmt.setInt(cnt++, count);
			pstmt.setString(cnt++, param.get("brd_subject"));
			pstmt.setString(cnt++, param.get("brd_creator"));
			pstmt.setString(cnt++, param.get("brd_contents"));
			pstmt.setString(cnt++, param.get("real_file"));
			pstmt.setString(cnt++, param.get("sys_file"));
			pstmt.setString(cnt++, param.get("brd_passwd"));
			pstmt.setString(cnt++, param.get("ref"));
			pstmt.setString(cnt++, param.get("ref_step"));
			pstmt.setString(cnt++, param.get("ref_level"));
			
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
		
		return "/servlet/sales.common.my.BaseServlet?actId=my210s&process_flag="+HDConstant.PROCESS_TYPE_SEARCH+"&ut=A&mt=M&menu_title=my210s";
	}
}

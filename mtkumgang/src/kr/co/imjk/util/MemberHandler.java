package kr.co.imjk.util;

import java.sql.*;
import java.util.*;
import java.io.*;

import kr.co.imjk.lib.db.DBHandler;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.MemberData;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemberHandler extends DAOHome {

    /**
     * 
     * @uml.property name="member"
     * @uml.associationEnd 
     * @uml.property name="member" multiplicity="(1 1)"
     */
    private MemberData member = new MemberData();

	

	public MemberHandler() {}
	
	public void setId(String id) {
		member.setId(id);
	}	

	public MemberData getOne() {
		return this.member;
	}
	 
	public boolean isIdExist() {
		boolean b_id_exist = true; // default true;
		
		if (member.getId()==null) return true;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;	
		

		String query = "select count(user_id) from WS_SAMPI_USER where lower(user_id)=lower(?)";

		try{
			
			conn = getConnection();	
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,member.getId());

			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt == 0) b_id_exist = false;
			}
			pstmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		} finally {
		    release(pstmt);
            freeConnection(conn);
		} // end try catch
	
		return b_id_exist;
	}
	  
	public int addMember(MemberData data) throws Exception{		
		StringBuffer query = new StringBuffer();
		int result =0;
		String hp = "";
		String jumin = "";
		String class_nm = "";
		String grade = "";
		String teach_roll = "";
		String charge_flag = ""; // 담임 선생님 여부.
		
		hp = data.getHp1() + "-" + data.getHp2() + "-" + data.getHp3();
		jumin = data.getJumin1() + "-" + data.getJumin2();
	
		teach_roll = data.getTeach_roll();
		
		//담임일때만 학년과 반이 존재한다.
		if(teach_roll.equals("담임")){
		    if(data.getClass_chk().equals("0")){
		        class_nm = data.getClass0();
		    }else{
		        class_nm = data.getClass1();
		    }
		    grade = data.getGrade();
		    charge_flag = "0"; 
		    
		}else{
		    class_nm = "0";
		    grade = "0";
		    charge_flag = "1";
		}
		
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		
		try{

			conn =  getConnection();		
			
			
			
			pstmt =  conn.prepareStatement("call PROC_SAMPI_USER ( ?,?,?,?,?,?,?,?,?,?,?,?,? )");
			pstmt.setString(1, "insert");
			pstmt.setString(2,data.getId());
			pstmt.setString(3,data.getPassword());
			pstmt.setString(4,data.getName());
			pstmt.setInt(5,data.getSc_code());
			pstmt.setString(6,data.getSc_nm());
			pstmt.setString(7,grade);			
			pstmt.setString(8,class_nm);
			pstmt.setString(9,jumin);
			pstmt.setString(10,hp);
			pstmt.setString(11,data.getEmail());
			pstmt.setString(12,charge_flag);
			pstmt.setString(13,data.getTeach_roll()); // 담임 ||전임교사 ||교장 ||교감 || 기타(사용자 입력)


					
			if ( data.getId().equals("") || data.getPassword().equals("") || data.getName().equals("") || data.getSc_nm().equals("") || grade.equals("") ){
				result = 2;  // 데이타에 공백있음
			}else{
				result = 1;  // insert 성공 
			}	
			
			pstmt.execute();
			pstmt.close();

			
		}catch(SQLException e){
			result = 0;
			throw new SQLException(e.getMessage());
		}finally{
		    release(pstmt);
            freeConnection(conn);
		}
		return result;
	}
	
	public int modMember(MemberData data) throws Exception{		
		StringBuffer query = new StringBuffer();
		int result =0;
		String Hp = new String();
		
		Hp = data.getHp1() + "-" + data.getHp2() + "-" + data.getHp3();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		
		try{
			
			conn = getConnection();			
			
			pstmt =  conn.prepareStatement("call PROC_SAMPI_USER_MODIFY ( ?,?,?,?,?,?,?,?,? )");
			pstmt.setString(1, "modify");
			pstmt.setString(2,data.getId());
			pstmt.setString(3,data.getPassword());			
			pstmt.setString(4,Hp);
			pstmt.setString(5,data.getEmail());			
			pstmt.setString(6,data.getBirth());		
			pstmt.setString(7,data.getBirth_type());		
			pstmt.setString(8,data.getZipcode());		
			pstmt.setString(9,data.getAddr());			
		
			result = 1;
			pstmt.execute();
			pstmt.close();
			
			//System.out.println("mod Member end-------");
			
		}catch(SQLException e){
			result = 0;
			throw new SQLException(e.getMessage());
		}finally{
		    release(pstmt);
            freeConnection(conn);
		}
		return result;
	}
	
	
	
}

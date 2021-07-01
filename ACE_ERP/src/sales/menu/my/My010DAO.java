package sales.menu.my;


import sales.menu.my.My020DTO;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;
import sales.org.util.StringUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class My010DAO  extends CommonDAO {
    public My010DAO() {
        super();
    }

    public ArrayList list(My020DTO entity, String where_sql,Connection conn) throws SQLException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;
        My020DTO dto = new My020DTO();
        System.out.println("받은편지함 리스트");
        System.out.println(dto.getOut_login_id());
        try {
        sql.append(" SELECT "); 
        sql.append(" BRD_NO, BRD_SUBJECT, BRD_CONTENTS, REAL_FILE, SYS_FILE, OUT_LOGIN_ID, SEND_LOGIN_ID, char(date(SEND_DATE),ISO) SEND_DATE, SEND_IP, OUT_YN ");
        sql.append(" FROM SALES.TMY010  ");
        sql.append(" WHERE  out_login_id = ?");

        if(StringUtil.isNotNull(where_sql)){
            sql.append(where_sql);
        }

        sql.append(" ORDER BY BRD_NO DESC ");
        
        	sales.common.StringUtil.printMsg("쿼리",sql.toString(),this);
        	
        pstmt =  new PreparedStatement(conn,sql.toString());
        pstmt.setString(1, entity.getOut_login_id());
        //pstmt.setString(1, "0908nkp");
        rs = pstmt.executeQuery();
        while(rs.next()) {
            data = new BaseDataClass();
            data.setValues(rs);
            arrBeans.add(data);
        }
        //System.out.println(sql.toString());
        pstmt.close();
        }catch (SQLException sqle){
			System.out.println(sqle.getMessage());
        }catch(Exception e){
	    	e.printStackTrace();
	        LogUtil.error(e);
	    }finally{
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	    }

        return arrBeans;
    }

    public My020DTO select(My020DTO entity, Connection conn) {
        PreparedStatement pstmt = null;
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        My020DTO dto = new My020DTO();
System.out.println("select");
        try {
            sql.append(" UPDATE SALES.TMY010 SET ");
            sql.append(" OUT_YN = 'Y'");
            sql.append(" WHERE ");
            sql.append(" BRD_NO = ? ");

            pstmt =  new PreparedStatement(conn,sql.toString());
            pstmt.setLong(1, entity.getBrd_no());

            pstmt.executeUpdate();
            pstmt.close();

            sql.append(" SELECT ");
            sql.append(" BRD_NO, BRD_SUBJECT, BRD_CONTENTS, REAL_FILE, SYS_FILE ");
            sql.append(" OUT_LOGIN_ID, SEND_LOGIN_ID, SEND_DATE, SEND_IP, OUT_YN ");
            sql.append(" FROM SALES.TMY010  ");
            sql.append(" WHERE BRD_NO = ? ");

            pstmt =  new PreparedStatement(conn,sql.toString());
            pstmt.setLong(1, entity.getBrd_no());

            LogUtil.debug(pstmt.toString());
            rs = pstmt.executeQuery();

            if(rs.next()){
                //Setting Line 1
                data = new BaseDataClass();
                data.setValues(rs);
                arrBeans.add(data);
            }
        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs    != null){try{   rs.close();}catch(SQLException e){}}
            if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
        }
        return dto;
    }

    public long insert(My020DTO dto, Connection conn) {
 System.out.println("here");
        PreparedStatement pstmt = null;
        StringBuffer sql = new StringBuffer();
        ResultSet rs = null;
        long ret = 0;
        System.out.println("sssss");
        try {

            sql.append(" INSERT INTO SALES.TMY010 (");
            sql.append("  BRD_SUBJECT, BRD_CONTENTS, REAL_FILE, SYS_FILE, ");
            sql.append(" OUT_LOGIN_ID, SEND_LOGIN_ID, SEND_DATE, SEND_IP, OUT_YN ");
            sql.append(" )VALUES(");
            sql.append("?,?,?,?,?,?,CURRENT TIMESTAMP,");
            sql.append(" ?,'N')");
            
            pstmt = new PreparedStatement(conn, sql.toString());
            System.out.println("번호--------------->"+dto.getBrd_no());
            System.out.println("제목--------------->"+dto.getBrd_subject());
            System.out.println("실제파일------------>"+dto.getBrd_contents());
            System.out.println("파일명-------------->"+dto.getReal_file());
            System.out.println("수신자-------------->"+dto.getOut_login_id());
            System.out.println("발신자-------------->"+dto.getSend_login_id());
            System.out.println("날짜---------------->"+dto.getSend_date());
            System.out.println("IP----------------->"+dto.getSend_ip());
            System.out.println(sql.toString());
            
            pstmt.setString(1,dto.getBrd_subject());
            pstmt.setString(2,dto.getBrd_contents());
            pstmt.setString(3,dto.getReal_file());
            pstmt.setString(4,dto.getSys_file());
            pstmt.setString(5,dto.getOut_login_id());
            pstmt.setString(6,dto.getSend_login_id());
            pstmt.setString(7,dto.getSend_ip());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();
         
            pstmt.close();

        }catch (SQLException sqle){
			System.out.println("에러메시지------"+sqle.getMessage());
        }catch(Exception e){
	    	e.printStackTrace();
	        LogUtil.error(e);
        }finally{
            if(rs        != null){try{       rs.close();}catch(SQLException e){}}
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }
}

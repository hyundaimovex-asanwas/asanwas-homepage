/*******************************************************************************
 * 1.클래스   명 : NoticeDAO.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 백승철
 * 7.작 성 일 자 : 2006-02-09
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2006-02-09      ;
 * @author 백승철
 * @version 1.0 2006-02-09
 ******************************************************************************/

package sales.menu.sy;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;
import sales.org.util.StringUtil;
import sales.menu.sy.HolidayDTO;


public class HolidayDAO extends CommonDAO {
    public HolidayDAO() {
        super();
    }

    public ArrayList list(String where_sql,String view_level_code,long page_num,Connection conn) throws SQLException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;

        sql.append(" SELECT ");
        sql.append(" SUBSTR(trim(DETAIL),5,8) CALN_DATE ");
        sql.append(" FROM SALES.TSY010  ");
        sql.append(" WHERE  HEAD = 'SY004' ");
        sql.append(" AND  DETAIL > ' ' ");

        if(StringUtil.isNotNull(where_sql)){
            sql.append(where_sql);
        }
        sql.append(" UNION ");
        sql.append(" SELECT ");
        sql.append(" trim(DETAIL) CALN_DATE ");
        sql.append(" FROM SALES.TSY010  ");
        sql.append(" WHERE  HEAD = 'SY003' ");
        sql.append(" AND  DETAIL > ' ' ");

        sql.append(" ORDER BY CALN_DATE ");

        pstmt =  new PreparedStatement(conn,sql.toString());
        rs = pstmt.executeQuery();
        while(rs.next()) {
            data = new BaseDataClass();
            data.setValues(rs);
            arrBeans.add(data);
        }
        //System.out.println(sql.toString());
        return arrBeans;
    }

    public HolidayDTO select(HolidayDTO entity, Connection conn) {
        PreparedStatement pstmt = null;


        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        HolidayDTO dto = new HolidayDTO();
        try {
            sql.append("SELECT ");
            sql.append(" * ");
            sql.append("FROM SALES.TSY100  ");
            sql.append("WHERE CALN_DATE = ? ");

            pstmt =  new PreparedStatement(conn,sql.toString());
            pstmt.setString(1, entity.getCaln_date());

            LogUtil.debug(pstmt.toString());
            rs = pstmt.executeQuery();

            if(rs.next()){
                //Setting Line 1
                dto.setCaln_date(      rs.getString(     "CALN_DATE"));
                dto.setYoil_cd(        rs.getString(   "YOIL_CD"));
                dto.setYoil_nm(           rs.getString(   "YOIL_NM"));
                dto.setHoliday_nm(rs.getString(   "HOLIDAY_NM"));
                dto.setU_empno(       rs.getString(   "U_EMPNO"));
                dto.setU_date(       rs.getTimestamp("U_DATE",cal.getCalendar()));
                dto.setU_ip(         rs.getString(   "U_IP"));

            }
        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs    != null){try{   rs.close();}catch(SQLException e){}}
            if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
        }
        return dto;
    }

    public long insert(HolidayDTO dto, Connection conn) {
        PreparedStatement pstmt = null;
        PreparedStatement clopPstmt = null;
        StringBuffer sql = new StringBuffer();
        ResultSet rs = null;
        long ret = 0;

        try {
            /*
            sql.append("INSERT INTO NOTICE(");
            sql.append("NOTICE_NO,SUBJECT,CONT,VIEW_LEVEL_CODE,FILENAME,");
            sql.append("CNT,REG_DATE,REG_ID");
            sql.append(")VALUES(");
            sql.append("?,?,EMPTY_CLOB(),?,?,");
            sql.append("?,?,?)");

            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setString(     1,dto.getCaln_date());
            pstmt.setString(   2,dto.getYoil_cd());
            pstmt.setString(   3,dto.getYoil_nm());
            pstmt.setString(   4,dto.getHoliday_nm());
            pstmt.setTimestamp(5,dto.getU_date());
            pstmt.setString(   6,dto.getU_empno());
            pstmt.setString(   7,dto.getU_ip());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();

            pstmt.close();
            */
        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs        != null){try{       rs.close();}catch(SQLException e){}}
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
            if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }

    public long update(HolidayDTO dto, Connection conn) {
        PreparedStatement pstmt = null;
        PreparedStatement clopPstmt = null;
        StringBuffer sql = new StringBuffer();
        ResultSet rs = null;
        long ret = 0;

        sql.append("UPDATE NOTICE SET ");
        sql.append("SUBJECT = ?,");
        sql.append("CONT = EMPTY_CLOB(),");
        sql.append("VIEW_LEVEL_CODE = ?,");
        sql.append("FILENAME = ?,");
        sql.append("CNT = ?,");
        sql.append("REG_DATE = ?,");
        sql.append("REG_ID = ? ");
        sql.append("WHERE ");
        sql.append("NOTICE_NO = ? ");

        try {
            /*
            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setString(   1,dto.getYoil_cd());
            //pstmt.setString(   2,dto.getCont());
            pstmt.setString(   2,dto.getYoil_nm());
            pstmt.setString(   3,dto.getHoliday_nm());
            pstmt.setTimestamp(4,dto.getU_date());
            pstmt.setString(   5,dto.getU_empno());
            pstmt.setString(     6,dto.getCaln_date());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();
            */
        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs        != null){try{       rs.close();}catch(SQLException e){}}
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
            if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }

    public long delete(HolidayDTO dto, Connection conn)  {
        PreparedStatement pstmt = null;
        StringBuffer sql = new StringBuffer();
        long ret = 0;

        sql.append("DELETE FROM NOTICE ");
        sql.append("WHERE ");
        sql.append("NOTICE_NO = ? ");

        try {

            pstmt = new PreparedStatement(conn, sql.toString());
            /*
            pstmt.setString(1, dto.getCaln_date());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();

            if(ret == 1){
                conn.commit();
            } else {
                conn.rollback();
            }
            */
        }  catch(SQLException e)    {
            LogUtil.error(e);
        }finally{
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }
}
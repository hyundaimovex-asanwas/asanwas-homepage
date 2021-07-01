package sales.menu.sy;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import sales.menu.sy.Sy210DTO;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;
import sales.org.util.StringUtil;


public class Sy210DAO extends CommonDAO {
    public Sy210DAO() {
        super();
    }

    public ArrayList list(Sy210DTO entity, String where_sql,Connection conn) throws SQLException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;

        sql.append(" SELECT ");
        sql.append(" * ");
        sql.append(" FROM SALES.TMY020  ");
        sql.append(" WHERE  BRD_GU = ? ");

        if(StringUtil.isNotNull(where_sql)){
            sql.append(where_sql);
        }

        sql.append(" ORDER BY BRD_NO DESC ");

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

    public Sy210DTO select(Sy210DTO entity, Connection conn) {
        PreparedStatement pstmt = null;
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        Sy210DTO dto = new Sy210DTO();

        try {
            sql.append(" UPDATE FROM TMY020 SET ");
            sql.append(" BRD_VIEW_CNT = BRD_VIEWCNT+1");
            sql.append(" WHERE ");
            sql.append(" BRD_NO = ? ");

            pstmt =  new PreparedStatement(conn,sql.toString());
            pstmt.setLong(1, entity.getBrd_no());

            pstmt.executeUpdate();
            pstmt.close();

            sql.append(" SELECT ");
            sql.append(" BRD_NO, BRD_GU, BRD_SUBJECT, BRD_CREATOR, BRD_CDATE, BRD_CONTENTS, REAL_FILE, SYS_FILE ");
            sql.append(" BRD_VIEWCNT, BRD_PASSWD, REF, REF_STEP, BRD_LEVEL, DELYN ");
            sql.append(" FROM SALES.TMY020  ");
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

    public long insert(Sy210DTO dto, Connection conn) {
        PreparedStatement pstmt = null;
        PreparedStatement clopPstmt = null;
        StringBuffer sql = new StringBuffer();
        ResultSet rs = null;
        long ret = 0;

        try {

            sql.append(" INSERT INTO TMY210 (");
            sql.append(" BRD_GU, BRD_SUBJECT, BRD_CREATOR, BRD_CDATE, BRD_CONTENTS, REAL_FILE, SYS_FILE ");
            sql.append(" BRD_VIEWCNT, BRD_PASSWD, REF, REF_STEP, BRD_LEVEL, DELYN ");
            sql.append(" )VALUES(");
            sql.append(" ?,?,?,TIMESTAMP,?,?,?,");
            sql.append(" ?,?,?,?,?,'N')");

            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setString(1,dto.getBrd_gu());
            pstmt.setString(2,dto.getBrd_subject());
            pstmt.setString(3,dto.getBrd_creator());
            pstmt.setString(4,dto.getBrd_contents());
            pstmt.setString(5,dto.getReal_file());
            pstmt.setString(6,dto.getSys_file());
            pstmt.setLong(7,dto.getBrd_viewcnt());
            pstmt.setString(8,dto.getBrd_passwd());
            pstmt.setLong(9,dto.getRef());
            pstmt.setLong(10,dto.getRef_step());
            pstmt.setLong(11,dto.getRef_level());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();

            pstmt.close();

        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs        != null){try{       rs.close();}catch(SQLException e){}}
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
            if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }

    public long rep_insert(Sy210DTO dto, Connection conn) {
        PreparedStatement pstmt = null;
        PreparedStatement clopPstmt = null;
        StringBuffer sql = new StringBuffer();
        ResultSet rs = null;
        long ret = 0;

        try {
            sql.append(" UPDATE FROM TMY020 SET ");
            sql.append(" REF_STEP = REF_STEP + 1 ");
            sql.append(" WHERE ");
            sql.append(" REF = ? ");
            sql.append(" REF_STEP > ? ");

            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setLong(1,dto.getRef());
            pstmt.setLong(2,dto.getRef_step());

            ret = pstmt.executeUpdate();

            pstmt.close();

            sql.append(" INSERT INTO TMY210 (");
            sql.append(" BRD_GU, BRD_SUBJECT, BRD_CREATOR, BRD_CDATE, BRD_CONTENTS, REAL_FILE, SYS_FILE ");
            sql.append(" BRD_VIEWCNT, BRD_PASSWD, REF, REF_STEP, BRD_LEVEL, DELYN ");
            sql.append(" )VALUES(");
            sql.append(" ?,?,?,TIMESTAMP,?,?,?,");
            sql.append(" ?,?,?,?,?,'N')");

            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setString(1,dto.getBrd_gu());
            pstmt.setString(2,dto.getBrd_subject());
            pstmt.setString(3,dto.getBrd_creator());
            pstmt.setString(4,dto.getBrd_contents());
            pstmt.setString(5,dto.getReal_file());
            pstmt.setString(6,dto.getSys_file());
            pstmt.setLong(7,dto.getBrd_viewcnt());
            pstmt.setString(8,dto.getBrd_passwd());
            pstmt.setLong(9,dto.getRef());
            pstmt.setLong(10,dto.getRef_step() + 1);
            pstmt.setLong(11,dto.getRef_level() + 1);

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();

            pstmt.close();

        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs        != null){try{       rs.close();}catch(SQLException e){}}
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
            if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }

    public long update(Sy210DTO dto, Connection conn) {
        PreparedStatement pstmt = null;
        PreparedStatement clopPstmt = null;
        StringBuffer sql = new StringBuffer();
        ResultSet rs = null;
        long ret = 0;

        try {
            sql.append(" UPDATE FROM TMY020 SET ");
            sql.append(" BRD_SUBJECT = ?,");
            sql.append(" BRD_CONTENTS = ?,");
            sql.append(" REAL_FILE = ?,");
            sql.append(" SYS_FILE = ? ");
            sql.append(" WHERE ");
            sql.append(" BRD_NO = ? ");

            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setString(1,dto.getBrd_subject());
            pstmt.setString(2,dto.getBrd_contents());
            pstmt.setString(3,dto.getReal_file());
            pstmt.setString(4,dto.getSys_file());
            pstmt.setLong(5,dto.getBrd_no());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();

        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs        != null){try{       rs.close();}catch(SQLException e){}}
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
            if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }

    public long delete(Sy210DTO dto, Connection conn)  {
        PreparedStatement pstmt = null;
        StringBuffer sql = new StringBuffer();
        long ret = 0;

        sql.append(" UPDATE FROM TMY020 ");
        sql.append(" DELYN  = 'Y' ");
        sql.append(" WHERE ");
        sql.append(" BRD_NO = ? ");

        try {

            pstmt = new PreparedStatement(conn, sql.toString());

            pstmt.setLong(1, dto.getBrd_no());

            LogUtil.debug(pstmt.toString());

            ret = pstmt.executeUpdate();

            if(ret == 1){
                conn.commit();
            } else {
                conn.rollback();
            }
        }  catch(SQLException e)    {
            LogUtil.error(e);
        }finally{
            if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
        }
        return ret;
    }
}

package sales.common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.util.StringUtil;


public class MenuDAO  extends CommonDAO {
    public MenuDAO() {
        super();
    }

    public ArrayList list(String where_sql,Connection conn) throws SQLException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;

        sql.append(" SELECT ");
        sql.append(" SCODE, SCDNM ");
        sql.append(" FROM COMMON.SYSCODE  ");
        sql.append(" WHERE 1=1 ");

        if(StringUtil.isNotNull(where_sql)){
            sql.append(where_sql);
        }
        sql.append(" ORDER BY SCODE ");

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
}

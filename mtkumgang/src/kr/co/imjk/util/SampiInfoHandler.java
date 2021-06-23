package kr.co.imjk.util;

import java.sql.*;
import java.util.*;
import java.io.*;

import kr.co.imjk.lib.db.DBHandler;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.MemberData;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SampiInfoHandler  extends DAOHome{
	
	private static SampiInfoHandler instance;

    /**
     * 
     * @uml.property name="instance"
     */
    public static synchronized SampiInfoHandler getInstance() {
        if (instance == null) {
            instance = new SampiInfoHandler();
        }
        return instance;
    }

	
	
	
	public MemberData[] getContent(String sampi_id, int class_id) throws DbException , Exception {
		Connection dbconn = getConnection();  	
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
        String SQL = "";

        SQL = new StringBuffer()
		.append(" SELECT s.sc_code, grade, class_nm, sc_nm  ")
		.append(" from ws_sampi_class s, sc c  ")	
		.append(" where s.sc_code = c.sc_code and sampi_id=? and class_id=? ").toString();			
		
	try{
		
        pstmt = dbconn.prepareStatement(SQL);
        pstmt.setString(1, sampi_id);
        pstmt.setInt(2, class_id);
       
        rs = pstmt.executeQuery();
        
        list = Selecter.execute(rs, new MemberData());
        
        rs.close();
        pstmt.close();           
       

    } catch (SQLException e) {
        throw new DbException(e.getMessage());
    }finally{
        release(pstmt);
        freeConnection(dbconn);
    }
    return (MemberData [])list.toArray(new MemberData[0]);
} 
	
}

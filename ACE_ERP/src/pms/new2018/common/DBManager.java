/*
* [ 수정일자 ][수정자] 내용
* [2018-04-17][이동훈] 
*/
package pms.new2018.common;

import java.util.ArrayList;

import pms.new2018.common.DBDAO;
import pms.new2018.common.DBDTO;
import sales.org.application.common.CommonManager;
import sales.org.common.request.SmartRequest;
import sales.org.util.StringUtil;
import sales.common.HDUtil;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DBManager extends CommonManager {	//커넥션정보가 있는 CommonManager를 상속합니다. 
	
    DBDAO dao = null;
   
	Connection conn = null;
	
    public DBManager() { 
    	
        super();
        dao = new DBDAO();
    }

    public ArrayList list(SmartRequest sr) throws SQLException {
    	
        DBDTO entity = new DBDTO();
        
        ArrayList ls = new ArrayList();

        try{

			//conn = UtilDB.getConnection("jdbc/asanhr");
	        //JNDI connection 호출 : import javax.naming.*; 필요

	        Context initContext = (Context) new InitialContext();
	        
	    	DataSource ds = (DataSource) initContext.lookup("CforPMS");
	        
	    	//DataSource ds = (DataSource) initContext.lookup("CforAsnhr");	  

	    	conn = ds.getConnection();
	        //JNDI connection 호출
        	
            String where_sql		= StringUtil.nvl((String)sr.getObject("where_sql"));
			int	requestedPage  		= HDUtil.nullCheckNum((String)sr.getObject("requestedPage"));
			int	pageSize   			= HDUtil.nullCheckNum((String)sr.getObject("pageSize"));			
			String v_login_id  		= StringUtil.nvl((String)sr.getObject("v_login_id"));
			String v_group			= StringUtil.nvl((String)sr.getObject("v_group"));

			System.out.println("@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->" + (String)sr.getObject("pageSize"));
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->" + (String)sr.getObject("v_group"));

            setDTO(sr,entity);
             
            ls = dao.list(entity,where_sql, requestedPage,pageSize ,v_login_id,v_group, conn);
            
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
        	if(conn!=null) conn.close();
            close();
        }
        return ls;
    }


    public void setDTO(SmartRequest sr,DBDTO dto)throws Exception{
    	
		dto.setcost_cd(sr.getString("cost_cd"));
		dto.setplj_nm(sr.getString("plj_nm"));
		dto.setgroup_nm(sr.getString("group_nm"));
		dto.setdpt_nm(sr.getString("dpt_nm"));

    }
    
}

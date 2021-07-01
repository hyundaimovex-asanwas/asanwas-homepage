/*
* [ 수정일자 ][수정자] 내용
* [2012-02-07][심동현] EHR 연결해서 근태현황을 가져오자
*/
package common;

import java.util.ArrayList;

import common.VacDAO;
import common.VacDTO;
import sales.org.application.common.CommonManager;
import sales.org.common.request.SmartRequest;
import sales.org.util.StringUtil;
import sales.common.HDUtil;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class VacManager extends CommonManager {	//커넥션정보가 있는 CommonManager를 상속합니다. 
    VacDAO dao = null;
	Connection conn = null;
	
    public VacManager() { 
        super();
        dao = new VacDAO();
    }

    public ArrayList list(SmartRequest sr) throws SQLException {
        VacDTO entity = new VacDTO();
        ArrayList ls = new ArrayList();

        try{
			//conn = UtilDB.getConnection("jdbc/asanhr");
	        //JNDI connection 호출 : import javax.naming.*; 필요
	        Context initContext = (Context) new InitialContext();
	    	//DataSource ds = (DataSource) initContext.lookup("CforHR");
	    	DataSource ds = (DataSource) initContext.lookup("CforAsnhr");	        
	    	conn = ds.getConnection();
	        //JNDI connection 호출
        	
            String where_sql		= StringUtil.nvl((String)sr.getObject("where_sql"));
			int	requestedPage  		= HDUtil.nullCheckNum((String)sr.getObject("requestedPage"));
			int	pageSize   			= HDUtil.nullCheckNum((String)sr.getObject("pageSize"));			
			String v_login_id  		= StringUtil.nvl((String)sr.getObject("v_login_id"));
			String v_login_deptcd	= StringUtil.nvl((String)sr.getObject("v_login_deptcd"));
			//System.out.println("여기서 조건절? -->" + (String)sr.getObject("where_sql"));

            setDTO(sr,entity);
            ls = dao.list(entity,where_sql, requestedPage,pageSize ,v_login_id,v_login_deptcd, conn);
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
        	if(conn!=null) conn.close();
            close();
        }
        return ls;
    }


    public void setDTO(SmartRequest sr,VacDTO dto)throws Exception{
		dto.setEmpno(sr.getString("eno_no"));
		dto.setEmpnm(sr.getString("eno_nm"));
		dto.setJobcd(sr.getString("job_cd"));
		dto.setJobnm(sr.getString("job_nm"));
		dto.setDptcd(sr.getString("dpt_cd"));
		dto.setDptnm(sr.getString("dpt_nm"));
		dto.setDay  (sr.getString("day"));
		dto.setVac  (sr.getString("vac"));		
		dto.setVac  (sr.getString("dy"));
    }
}

package sales.menu.my;

import java.io.File;
import java.util.ArrayList;

import sales.menu.my.My400DAO;
import sales.menu.my.My400DTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;
import sales.common.HDUtil;

public class My400Manager extends CommonManager {	//커넥션정보가 있는 CommonManager를 상속합니다. 
    My400DAO dao = null;

    public My400Manager() { 
        super();
        dao = new My400DAO();
    }

    public ArrayList list(SmartRequest sr) {
        My400DTO entity = new My400DTO();
        ArrayList ls = new ArrayList();

        try{
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
			int	requestedPage   = HDUtil.nullCheckNum((String)sr.getObject("requestedPage"));
			int	pageSize   		= HDUtil.nullCheckNum((String)sr.getObject("pageSize"));			
			String v_login_id  = StringUtil.nvl((String)sr.getObject("v_login_id"));
			String v_login_name  = StringUtil.nvl((String)sr.getObject("v_login_name"));
			//System.out.println("여기서 조건절? -->" + (String)sr.getObject("where_sql"));

            setDTO(sr,entity);
            ls = dao.list(entity,where_sql, requestedPage,pageSize ,v_login_id,v_login_name,getConnection());
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
            close();
        }
        return ls;
    }


    public void setDTO(SmartRequest sr,My400DTO dto)throws Exception{
        dto.setAp_m_sid(sr.getLong("ap_m_sid"));
        dto.setDoc_gu_nm((String)sr.getObject("doc_gu_nm"));
        dto.setI_empnm(sr.getString("i_empnm"));
        dto.setI_date(sr.getString("i_date"));
        
		
    }
}

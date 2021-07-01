package common;

import java.io.File;
import java.util.ArrayList;

import common.ApDAO;
import common.ApDTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;
import sales.common.HDUtil;

public class ApManager extends CommonManager {	//커넥션정보가 있는 CommonManager를 상속합니다. 
    ApDAO dao = null;

    public ApManager() { 
        super();
        dao = new ApDAO();
    }

    public ArrayList list(SmartRequest sr) {
        ApDTO entity = new ApDTO();
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


    public void setDTO(SmartRequest sr,ApDTO dto)throws Exception{
        dto.setCnt(sr.getInt("cnt"));
        dto.setDetail((String)sr.getObject("detail"));
        dto.setDetailNm(sr.getString("detail_nm"));
		
    }
}

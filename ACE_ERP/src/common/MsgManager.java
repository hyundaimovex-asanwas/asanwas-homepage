package common;

import java.io.File;
import java.util.ArrayList;

import common.MsgDAO;
import common.MsgDTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;
import sales.common.HDUtil;

public class MsgManager extends CommonManager {	//Ŀ�ؼ������� �ִ� CommonManager�� ����մϴ�. 
	
	MsgDAO dao = null;

    public MsgManager() { 
    	
        super();
        
        dao = new MsgDAO();
        
    }

    public ArrayList list(SmartRequest sr) {
    	
    	MsgDTO entity = new MsgDTO();
    	
        ArrayList ls = new ArrayList();

        try{
        	
			//int	requestedPage   = HDUtil.nullCheckNum((String)sr.getObject("requestedPage"));
			//int	pageSize   		= HDUtil.nullCheckNum((String)sr.getObject("pageSize"));			
			String v_login_id   = StringUtil.nvl((String)sr.getObject("v_login_id"));
			
            setDTO(sr,entity);
            
            ls = dao.list(entity, v_login_id, getConnection());
            
            //sr_msg.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
    		//sr_msg.setObject("pageSize",(Object)pageSize);			//������ ������ ����
    		//sr_msg.setObject("v_login_id",(Object)gusrid);			//�α� ���̵� ���� 
            
            
            
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
            close();
        }
        return ls;
    }


    public void setDTO(SmartRequest sr, MsgDTO dto)throws Exception{
    	
        dto.setCnt(sr.getInt("cnt"));
        dto.setDetail((String)sr.getObject("detail"));
        dto.setDetailNm(sr.getString("detail_nm"));        
        
    }
}

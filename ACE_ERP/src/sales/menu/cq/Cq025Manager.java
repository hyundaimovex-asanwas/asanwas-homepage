package sales.menu.cq;

import java.io.File;
import java.util.ArrayList;

import sales.menu.cq.Cq025DAO;
import sales.menu.cq.Cq025DTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;


public class Cq025Manager extends CommonManager {	//커넥션정보가 있는 CommonManager를 상속합니다. 
    Cq025DAO dao = null;

    public Cq025Manager() { 
        super();
        dao = new Cq025DAO();
    }
    
    public ArrayList list(SmartRequest sr) {
        Cq025DTO entity = new Cq025DTO();
        ArrayList ls = new ArrayList();

        try{
            //String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));

            setDTO(sr,entity);
            ls = dao.list(entity,getConnection());
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
            close();
        }
        return ls;
    }

    public void setDTO(SmartRequest sr,Cq025DTO dto)throws Exception{
    	//컬럼값들
    	dto.setCust_nm1((String)sr.getString("cust_nm1"));
        dto.setBirthday((String)sr.getString("birthday"));
        dto.setGender_nm((String)sr.getString("gender_nm"));
        dto.setComp_nm1((String)sr.getString("comp_nm1"));
        dto.setTour_no((String)sr.getString("tour_no"));
        dto.setSn_datetime((String)sr.getString("sn_datetime"));
        dto.setNs_datetime((String)sr.getString("ns_datetime"));
        dto.setAddress1((String)sr.getString("address1"));
        dto.setNorth_purpose((String)sr.getString("north_purpose"));
        dto.setTitle_date((String)sr.getString("title_date"));
        dto.setTitle_class((String)sr.getString("title_class"));
        dto.setManage_no((String)sr.getString("manage_no"));
		dto.setPic_addr((String)sr.getString("pic_addr"));
		
        
        //검색조건
        dto.setsSaupSid((String)sr.getString("sSaupSid"));
        dto.setsDepartDate((String)sr.getString("sDepartDate"));
        dto.setsDepartTime((String)sr.getString("sDepartTime"));
        dto.setsGoodsSid((String)sr.getString("sGoodsSid"));
        dto.setsClass((String)sr.getString("sClass"));
        dto.setsTeams((String)sr.getString("sTeams"));
        dto.setsPageNo((String)sr.getString("sPageNo"));
        dto.setsCustGu((String)sr.getString("sCustGu"));
        
    }
}

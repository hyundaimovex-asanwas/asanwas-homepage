package sales.menu.my;


import sales.menu.my.My010DAO;
import sales.menu.my.My020DTO;
import sales.org.application.common.CommonManager;
import sales.org.common.request.SmartRequest;
import sales.org.util.StringUtil;

import java.util.ArrayList;

public class My010Manager extends CommonManager {
    My010DAO dao = null;

    public My010Manager() {
        super();
        dao = new My010DAO();
    }
 
    public ArrayList list(SmartRequest sr) {
        My020DTO entity = new My020DTO();
        ArrayList ls = new ArrayList();
System.out.println("받은편지 dao list");
        try{
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));

            setDTO(sr,entity);
            ls = dao.list(entity,where_sql,getConnection());
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return ls;
    }

    public My020DTO select(SmartRequest sr){
        My020DTO entity = new My020DTO();
        My020DTO dto = null;

        try{
            setDTO(sr,entity);
            dto = dao.select(entity,getConnection());
            System.out.println("상세 ---------");
            dto.nvl();
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return dto;
    }

    public long insert(SmartRequest sr){
        My020DTO entity = new My020DTO();
        long ret = 0;
System.out.println("insert");
        try{
            setDTO(sr,entity);
            ret = dao.insert(entity, getConnection());
            commit();
        }catch(Exception e){
            System.out.println(e.getStackTrace());
            ret = -1;
        }finally {
            close();
        }
        return ret;
    }

    public void setDTO(SmartRequest sr,My020DTO dto)throws Exception{
        dto.setBrd_no(sr.getLong("brd_no"));
        dto.setBrd_subject(sr.getString("brd_subject"));
        dto.setBrd_contents(sr.getString("brd_contents"));
        dto.setReal_file(sr.getString("real_file"));
        dto.setSys_file(sr.getString("sys_file"));
        dto.setOut_login_id(sr.getString("out_login_id"));
        dto.setSend_login_id((String)sr.getObject("send_login_id"));
        dto.setSend_date(cal.getTimestamp());
        dto.setSend_ip(sr.getString("send_ip"));
        dto.setOut_yn(sr.getString("out_yn"));        
    }
}

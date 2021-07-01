package sales.menu.sy;

import java.io.File;
import java.util.ArrayList;

import sales.menu.sy.Sy210DAO;
import sales.menu.sy.Sy210DTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;


public class Sy210Manager extends CommonManager {
    Sy210DAO dao = null;

    public Sy210Manager() {
        super();
        dao = new Sy210DAO();
    }

    public ArrayList list(SmartRequest sr) {
        Sy210DTO entity = new Sy210DTO();
        ArrayList ls = new ArrayList();

        try{
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
            long page_num     = StringUtil.nvlLong(sr.getString("page_num"),1);

            setDTO(sr,entity);
            ls = dao.list(entity,where_sql,getConnection());
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return ls;
    }

    public Sy210DTO select(SmartRequest sr){
        Sy210DTO entity = new Sy210DTO();
        Sy210DTO dto = null;

        try{
            setDTO(sr,entity);
            dto = dao.select(entity,getConnection());
            dto.nvl();
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return dto;
    }

    public long insert(SmartRequest sr){
        Sy210DTO entity = new Sy210DTO();
        long ret = 0;

        try{
            setDTO(sr,entity);
            ret = dao.insert(entity, getConnection());
            commit();
        }catch(Exception e){
            error(e);
            ret = -1;
        }finally {
            close();
        }
        return ret;
    }

    public long update(SmartRequest sr){
        Sy210DTO entity = new Sy210DTO();
        Sy210DTO dto = null;
        long ret = 0;

        try{
            setDTO(sr,entity);
            ArrayList fnl = (ArrayList)sr.getObject("fnl");
            StringBuffer filename = new StringBuffer();

            for(int i=0; fnl != null && i < fnl.size(); i++){
                filename.append((String)fnl.get(i));
            }

            if(StringUtil.isNotNull(filename.toString())){
                FileUtil.delete(CommonProperty.getRealPath("notice")+File.separator+sr.getString("ori_file_name"));
            }

            dto = dao.select(entity, getConnection());
            dto.setBrd_subject(entity.getBrd_subject());
            ret = dao.update(dto, getConnection());
            commit();
        }catch(Exception e){
            error(e);
            ret =  -1;
        }finally {
            close();
        }
        return ret;
    }

    public long delete(SmartRequest sr){
        Sy210DTO entity = new Sy210DTO();
        long ret = 0;

        try{
            setDTO(sr,entity);
            ret = dao.delete(entity, getConnection());
            commit();
        }catch(Exception e){
            error(e);
            ret =  -1;
        }finally {
            close();
        }
        return ret;
    }

    public void setDTO(SmartRequest sr,Sy210DTO dto)throws Exception{
        dto.setBrd_no(Integer.parseInt(sr.getString("brd_no")));
        dto.setBrd_gu(sr.getString("brd_gu"));
        dto.setBrd_subject(sr.getString("brd_subject"));
        dto.setBrd_creater(sr.getString("brd_creator"));
        dto.setBrd_cdate(cal.getTimestamp());
        dto.setBrd_contents((String)sr.getString("brd_contents"));
        dto.setReal_file((String)sr.getString("real_file"));
        dto.setSys_file((String)sr.getString("sys_file"));
        dto.setBrd_viewcnt(Integer.parseInt(sr.getString("brd_viewcnt")));
        dto.setBrd_passwd((String)sr.getString("brd_passwd"));
        dto.setRef(Integer.parseInt(sr.getString("ref")));
        dto.setRef_step(Integer.parseInt(sr.getString("ref_step")));
        dto.setRef_level(Integer.parseInt(sr.getString("ref_level")));
        dto.setDelyn((String)sr.getString("delyn"));
    }
}

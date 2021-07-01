package sales.menu.my;

import java.io.File;
import java.util.ArrayList;

import sales.menu.my.My210DAO;
import sales.menu.my.My210DTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;
import sales.common.HDUtil;

public class My210Manager extends CommonManager {	//커넥션정보가 있는 CommonManager를 상속합니다. 
    My210DAO dao = null;

    public My210Manager() { 
        super();
        dao = new My210DAO();
    }

    public ArrayList list(SmartRequest sr) {
        My210DTO entity = new My210DTO();
        ArrayList ls = new ArrayList();

        try{
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
			int	requestedPage   = HDUtil.nullCheckNum((String)sr.getObject("requestedPage"));
			int	pageSize   		= HDUtil.nullCheckNum((String)sr.getObject("pageSize"));			
			//System.out.println("여기서 조건절? -->" + (String)sr.getObject("where_sql"));

            setDTO(sr,entity);
            ls = dao.list(entity,where_sql, requestedPage,pageSize ,getConnection());
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
            close();
        }
        return ls;
    }

	public ArrayList alllist(SmartRequest sr) {
		My210DTO entity = new My210DTO();
		ArrayList ls = new ArrayList();

		try{
			String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
			int	requestedPage   = HDUtil.nullCheckNum((String)sr.getObject("requestedPage"));
			int	pageSize   		= HDUtil.nullCheckNum((String)sr.getObject("pageSize"));			

			setDTO(sr,entity);
			ls = dao.alllist(entity,where_sql, requestedPage,pageSize ,getConnection());
		}catch(Exception e){
			e.printStackTrace();
			error(e);
		}finally{
			close();
		}
		return ls;
	}

    public ArrayList mainlist(SmartRequest sr) {
        My210DTO entity = new My210DTO();
        ArrayList ls = new ArrayList();

        try{
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));

            setDTO(sr,entity);
            ls = dao.mainlist(entity,where_sql,getConnection());
        }catch(Exception e){
        	e.printStackTrace();
            error(e);
        }finally{
            close();
        }
        return ls;
    }

    public My210DTO select(SmartRequest sr){
        My210DTO entity = new My210DTO();
        My210DTO dto = null;

        try{
            setDTO(sr,entity);
            dto = dao.select(entity,getConnection());
            //System.out.println("210Manager---상세 ---------");
            dto.nvl();
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return dto;
    }

    public long insert(SmartRequest sr){
        My210DTO entity = new My210DTO();
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

    public long rep_insert(SmartRequest sr){
        My210DTO entity = new My210DTO();
        long ret = 0;

        try{
            setDTO(sr,entity);
            ret = dao.rep_insert(entity, getConnection());
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
        My210DTO entity = new My210DTO();
        My210DTO dto = null;
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

            //dto = dao.select(entity, getConnection());
            //dto.setBrd_subject(entity.getBrd_subject());
            ret = dao.update(entity, getConnection());
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
        My210DTO entity = new My210DTO();
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

    public void setDTO(SmartRequest sr,My210DTO dto)throws Exception{
        dto.setBrd_no(sr.getLong("brd_no"));
        dto.setBrd_gu((String)sr.getObject("brd_gu"));
        dto.setBrd_subject(sr.getString("brd_subject"));
        dto.setBrd_creater(sr.getString("brd_creator"));
        dto.setBrd_cdate(cal.getTimestamp());
        dto.setBrd_contents((String)sr.getString("brd_contents"));
        dto.setReal_file((String)sr.getString("real_file"));
        dto.setSys_file((String)sr.getString("sys_file"));
        dto.setBrd_viewcnt(sr.getLong("brd_viewcnt"));
        dto.setBrd_passwd((String)sr.getString("brd_passwd"));
        dto.setRef(sr.getLong("ref"));
        dto.setRef_step(sr.getLong("ref_step"));
        dto.setRef_level(sr.getLong("ref_level"));
        dto.setDelyn((String)sr.getString("delyn"));
		dto.setRequestedPage((String)sr.getString("requestedPage"));
		dto.setPageSize((String)sr.getString("pageSize"));
        
		
    }
}

/*******************************************************************************
 * 1.클래스   명 : NoticeManager.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 백승철
 * 7.작 성 일 자 : 2006-02-09
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2006-02-09      ;
 * @author 백승철
 * @version 1.0 2006-02-09
 ******************************************************************************/

package sales.menu.sy;

import java.io.File;
import java.util.ArrayList;

import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;
import sales.menu.sy.HolidayDTO;
import sales.menu.sy.HolidayDAO;


public class HolidayManager extends CommonManager {
    HolidayDAO dao = null;

    public HolidayManager() {
        super();
        dao = new HolidayDAO();
    }

    public ArrayList list(SmartRequest sr) {
        HolidayDTO entity = new HolidayDTO();
        ArrayList ls = new ArrayList();

        try{
            String work_flag  = StringUtil.nvl((String)sr.getObject("work_flag"));
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
            String member_id  = StringUtil.nvl((String)sr.getObject("member_id"));
            boolean isAdmin   = StringUtil.parseBoolean((String)sr.getObject("isAdmin"));
            long page_num     = StringUtil.nvlLong(sr.getString("page_num"),1);
            String view_level_code = StringUtil.nvl((String)sr.getObject("view_level_code"),"000");

            setDTO(sr,entity);
            entity.setU_empno(member_id);

            ls = dao.list(where_sql,view_level_code,page_num,getConnection());
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return ls;
    }

    public HolidayDTO select(SmartRequest sr){
        HolidayDTO entity = new HolidayDTO();
        HolidayDTO dto = null;

        try{
            String work_flag  = StringUtil.nvl((String)sr.getObject("work_flag"));
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
            String member_id  = StringUtil.nvl((String)sr.getObject("member_id"));
            boolean isAdmin   = StringUtil.parseBoolean((String)sr.getObject("isAdmin"));
            long page_num     = StringUtil.nvlLong(sr.getString("page_num"),1);
            String view_level_code = StringUtil.nvl((String)sr.getObject("view_level_code"),"000");

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
        HolidayDTO entity = new HolidayDTO();
        long ret = 0;

        try{
            String work_flag  = StringUtil.nvl((String)sr.getObject("work_flag"));
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
            String member_id  = StringUtil.nvl((String)sr.getObject("member_id"));
            boolean isAdmin   = StringUtil.parseBoolean((String)sr.getObject("isAdmin"));
            long page_num     = StringUtil.nvlLong(sr.getString("page_num"),1);
            String view_level_code = StringUtil.nvl((String)sr.getObject("view_level_code"),"000");

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
        HolidayDTO entity = new HolidayDTO();
        HolidayDTO dto = null;
        long ret = 0;

        try{
            String work_flag  = StringUtil.nvl((String)sr.getObject("work_flag"));
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
            String member_id  = StringUtil.nvl((String)sr.getObject("member_id"));
            boolean isAdmin   = StringUtil.parseBoolean((String)sr.getObject("isAdmin"));
            long page_num     = StringUtil.nvlLong(sr.getString("page_num"),1);
            String view_level_code = StringUtil.nvl((String)sr.getObject("view_level_code"),"000");

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
            dto.setYoil_cd(entity.getYoil_cd());
            dto.setYoil_nm(entity.getYoil_nm());
            dto.setHoliday_nm(entity.getHoliday_nm());

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
        HolidayDTO entity = new HolidayDTO();
        long ret = 0;

        try{
            String work_flag  = StringUtil.nvl((String)sr.getObject("work_flag"));
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));
            String member_id  = StringUtil.nvl((String)sr.getObject("member_id"));
            boolean isAdmin   = StringUtil.parseBoolean((String)sr.getObject("isAdmin"));
            long page_num     = StringUtil.nvlLong(sr.getString("page_num"),1);
            String view_level_code = StringUtil.nvl((String)sr.getObject("view_level_code"),"000");

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

    public void setDTO(SmartRequest sr,HolidayDTO dto)throws Exception{
        //어드민여부
        dto.setIsAdmin(StringUtil.parseBoolean((String)sr.getObject("isAdmin")));
        dto.setIsTrendinfo(StringUtil.parseBoolean((String)sr.getObject("isTrendinfo")));
        dto.setIsTemplate(StringUtil.parseBoolean((String)sr.getObject("isTemplate")));
        dto.setIsNewsletter(StringUtil.parseBoolean((String)sr.getObject("isNewsletter")));
        dto.setIsPrivate(StringUtil.parseBoolean((String)sr.getObject("isPrivate")));

        dto.setCaln_date(sr.getString("caln_date"));
        dto.setYoil_cd(        sr.getString(   "yoil_cd"));
        dto.setYoil_nm(           sr.getString(   "yoil_nm"));
        dto.setHoliday_nm(       sr.getString(   "holiday_nm"));
        dto.setU_date(       cal.getTimestamp());
        dto.setU_empno(         sr.getString(   "U_EMPNO"));
        dto.setU_ip(       (String)sr.getObject("U_IP"));
    }
}
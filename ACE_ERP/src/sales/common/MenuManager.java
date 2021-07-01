package sales.common;

import java.util.ArrayList;

import sales.common.MenuDAO;
import sales.org.application.common.CommonManager;
import sales.org.common.request.SmartRequest;
import sales.org.util.StringUtil;


public class MenuManager extends CommonManager {
    MenuDAO dao = null;

    public MenuManager() {
        super();
        dao = new MenuDAO();
    }

    public ArrayList list(SmartRequest sr) {
        //MenuDTO entity = new MenuDTO();
        ArrayList ls = new ArrayList();

        try{
            String where_sql  = StringUtil.nvl((String)sr.getObject("where_sql"));

            ls = dao.list(where_sql,getConnection2());
        }catch(Exception e){
            error(e);
        }finally{
            close();
        }
        return ls;
    }
}

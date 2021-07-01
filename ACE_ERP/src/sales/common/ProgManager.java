package sales.common;

import java.io.File;
import java.util.ArrayList;

import sales.common.ProgDAO;
import sales.common.ProgDTO;
import sales.org.application.common.CommonManager;
import sales.org.common.property.CommonProperty;
import sales.org.common.request.SmartRequest;
import sales.org.util.FileUtil;
import sales.org.util.StringUtil;


public class ProgManager extends CommonManager {
    ProgDAO dao = null;
    public ProgManager() {
        super();
        dao = new ProgDAO();
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

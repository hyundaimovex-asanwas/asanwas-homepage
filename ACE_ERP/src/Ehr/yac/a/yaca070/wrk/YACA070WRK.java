package Ehr.yac.a.yaca070.wrk;

import Ehr.yac.a.yaca070.dao.YACA070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA070WRK {
    private YACA070DAO dao = null;
    private String connectionName = "default";

    /**
     * �۾� ��Ȳ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA070_SHR(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA070DAO(connectionName, p_tr);
        dao.YACA070_SHR(p_box);
    }
    
    /**
     * �۾� ��Ȳ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA070_SHR_142(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA070DAO(connectionName, p_tr);
        dao.YACA070_SHR_142(p_box);
    }    
    
}


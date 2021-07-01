package Ehr.ins.f.insf020.wrk;

import Ehr.ins.f.insf020.dao.INSF020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class INSF020WRK {
	
    private INSF020DAO dao = null;
    
    private String connectionName = "default";

    /**
     * ���ο��� �������� ����Ʈ�� ��ȸ�Ѵ�.
     * @param p_box
     * @param p_tr
     */
    public void INSF020_SHR(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new INSF020DAO(connectionName, p_tr);
        
        dao.INSF020_SHR(p_box);
        
    }
    
}


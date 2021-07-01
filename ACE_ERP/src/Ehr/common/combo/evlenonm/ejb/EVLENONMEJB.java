package common.combo.evlenonm.ejb;

import common.combo.evlenonm.wrk.EVLENONMWRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.combo.evlenonm.wrk.EVLENONMWRK;
import common.menu.login.wrk.LOGINWRK;

public class EVLENONMEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EVLENONMEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
        /** WRK Class ��ü ���� * */
        EVLENONMWRK wrk = new EVLENONMWRK();

        /** �޺��� ���� ������ȸ (SHR:�����ڿ� ���� ���� ��ȸ)�� ���� WRK Class �޼ҵ� ȣ�� * */
        if(box.get("S_MODE").equals("SHR"))
            wrk.EVLENONM_SHR(box, tr);

        return null;
	}

}

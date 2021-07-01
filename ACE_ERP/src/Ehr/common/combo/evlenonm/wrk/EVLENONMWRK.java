package common.combo.evlenonm.wrk;

import common.combo.evlenonm.dao.EVLENONMDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EVLENONMWRK {

    /**
     * �����ڿ� ���� ���� ��ȸ (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void EVLENONM_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ �����ڿ� ���� ���� ��ȸ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		EVLENONMDAO dao = new EVLENONMDAO("default", p_tr);
		dao.EVLENONM_SHR(p_box);

	}

}

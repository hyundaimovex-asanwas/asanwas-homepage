package Ehr.gun.d.gund060.wrk;

import Ehr.gun.d.gund060.dao.GUND060DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND060WRK {

	/**
	 * �����߻����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND060_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUND060DAO dao = new GUND060DAO("default", p_tr);
			
			dao.GUND060_SHR(p_box);

	}

}

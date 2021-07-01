package Ehr.edu.e.edue040.wrk;

import Ehr.edu.e.edue040.dao.EDUE040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE040WRK {

	/**
	 * 근태현황 결재처리 조회 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EDUE040_SHR(CBox p_box, TrBox p_tr) throws CException {

		EDUE040DAO dao = new EDUE040DAO("default", p_tr);

		dao.EDUE040_SHR(p_box);

	}
	
}

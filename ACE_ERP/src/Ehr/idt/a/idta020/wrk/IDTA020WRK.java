package hr.idt.a.idta020.wrk;

import hr.idt.a.idta020.dao.IDTA020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTA020WRK {
	
	/**
	 * 증명서발급현황을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA020_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTA020DAO dao = new IDTA020DAO("default", p_tr);
			 dao.IDTA020_SHR(p_box);
	}
}


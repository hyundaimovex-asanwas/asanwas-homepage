package Ehr.gun.a.guna070.wrk;

import Ehr.gun.a.guna070.dao.GUNA070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA070WRK {

	/**
	 * 근태현황 결재처리 조회 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA070_SHR(CBox p_box, TrBox p_tr) throws CException {

		GUNA070DAO dao = new GUNA070DAO("default", p_tr);
		
		dao.GUNA070_SHR(p_box);

	}
	
	/**
	 * 관리자 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA070_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		
		GUNA070DAO dao = new GUNA070DAO("default", p_tr);
		
		dao.GUNA070_SHR_01(p_box);
		
	}

	
}

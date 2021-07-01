package Ehr.gun.f.gunf040.wrk;

import Ehr.gun.f.gunf040.dao.GUNF040DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF040WRK {

	/**
	 * 일자별 근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF040_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF040DAO dao = new GUNF040DAO("default", p_tr);
			
			dao.GUNF040_SHR(p_box);

	}

	public void GUNF040_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		GUNF040DAO dao = new GUNF040DAO("default", p_tr);
		
		dao.GUNF040_SHR_01(p_box);

	}		
	
	
	public void GUNF040_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF040DAO dao = new GUNF040DAO("default", p_tr);
		
		dao.GUNF040_SHR_DTL(p_box);

	}	
		
	
	
}

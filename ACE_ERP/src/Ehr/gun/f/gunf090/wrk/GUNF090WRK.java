package Ehr.gun.f.gunf090.wrk;

import Ehr.gun.f.gunf090.dao.GUNF090DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF090WRK {

	/**
	 * 일자별 근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF090_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF090DAO dao = new GUNF090DAO("default", p_tr);
			
			dao.GUNF090_SHR(p_box);

	}


	
}

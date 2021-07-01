package Ehr.aid.a.aida020.wrk;

import Ehr.aid.a.aida020.dao.AIDA020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class AIDA020WRK {
	
	/**
	 * 경공조금 지급처리 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA020_SHR(CBox p_box, TrBox p_tr) throws CException {

			AIDA020DAO dao = new AIDA020DAO("default", p_tr);
		
			dao.AIDA020_SHR(p_box);
			
	}
}


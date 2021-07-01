package Ehr.gun.f.gunf030.wrk;

import Ehr.gun.f.gunf030.dao.GUNF030DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF030WRK {

	/**
	 * 일자별 근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF030_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF030DAO dao = new GUNF030DAO("default", p_tr);
			
			dao.GUNF030_SHR(p_box);

	}

	public void GUNF030_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF030DAO dao = new GUNF030DAO("default", p_tr);
		
		dao.GUNF030_SHR_DTL(p_box);

	}	
		
	
	
}

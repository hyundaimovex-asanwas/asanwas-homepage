package Ehr.gun.f.gunf010.wrk;

import Ehr.gun.f.gunf010.dao.GUNF010DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF010WRK {

	/**
	 * 일자별 근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF010_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF010DAO dao = new GUNF010DAO("default", p_tr);
			
			dao.GUNF010_SHR(p_box);

	}

	public void GUNF010_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF010DAO dao = new GUNF010DAO("default", p_tr);
		
		dao.GUNF010_SHR_DTL(p_box);

	}	
	
	public void GUNF010_SHR_WEEK(CBox p_box, TrBox p_tr) throws CException {

		GUNF010DAO dao = new GUNF010DAO("default", p_tr);
		
		dao.GUNF010_SHR_WEEK(p_box);

	}		
	
	
}

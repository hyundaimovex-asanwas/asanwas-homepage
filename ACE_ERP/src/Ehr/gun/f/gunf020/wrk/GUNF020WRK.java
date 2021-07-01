package Ehr.gun.f.gunf020.wrk;

import Ehr.gun.f.gunf020.dao.GUNF020DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF020WRK {

	/**
	 * 일자별 근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF020_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF020DAO dao = new GUNF020DAO("default", p_tr);
			
			dao.GUNF020_SHR(p_box);

	}

	public void GUNF020_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF020DAO dao = new GUNF020DAO("default", p_tr);
		
		dao.GUNF020_SHR_DTL(p_box);

	}	
	
	public void GUNF020_SHR_WEEK(CBox p_box, TrBox p_tr) throws CException {

		GUNF020DAO dao = new GUNF020DAO("default", p_tr);
		
		dao.GUNF020_SHR_WEEK(p_box);

	}		
	
	
}

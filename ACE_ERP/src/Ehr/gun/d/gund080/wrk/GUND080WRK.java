package Ehr.gun.d.gund080.wrk;

import Ehr.gun.d.gund080.dao.GUND080DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND080WRK {

	/**
	 * 연차발생관리 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND080_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUND080DAO dao = new GUND080DAO("default", p_tr);
			
			dao.GUND080_SHR(p_box);

	}

	public void GUND080_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUND080DAO dao = new GUND080DAO("default", p_tr);
		
		dao.GUND080_SHR_DTL(p_box);

}	
	
}

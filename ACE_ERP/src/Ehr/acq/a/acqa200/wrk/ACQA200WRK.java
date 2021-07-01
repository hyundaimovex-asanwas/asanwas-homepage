package Ehr.acq.a.acqa200.wrk;

import Ehr.acq.a.acqa200.dao.ACQA200DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class ACQA200WRK {
	
	/**
	 * 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA200_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA200DAO dao = new ACQA200DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_ACCESS",     dao.ACQA200_SHR(p_box));
	
	}


}


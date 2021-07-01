package Ehr.acq.a.acqa002.wrk;

import Ehr.acq.a.acqa002.dao.ACQA002DAO;

import Ehr.common.util.CommUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class ACQA002WRK {
	
	/**
	 * 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA002_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			//System.out.print("p_box==================" + p_box);
			ACQA002DAO dao = new ACQA002DAO("default", p_tr);	        
	        
			dao.ACQA002_SHR_ACC(p_box);	        
	        
	}
	

	
	
}


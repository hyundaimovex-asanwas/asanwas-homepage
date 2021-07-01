package Ehr.pir.e.pire050.wrk;

import Ehr.pir.e.pire050.dao.PIRE050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class PIRE050WRK {

	/**
	 * 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PIRE050_SHR(CBox p_box, TrBox p_tr) throws CException {
		
			PIRE050DAO dao = new PIRE050DAO("default", p_tr);
			PIRE050DAO dao2 = new PIRE050DAO("default", p_tr);
			
			dao.PIRE050_SHR(p_box);
			
			/** 개인정보처리 접속 기록  **/
			dao2.PIRE050_SHR_ACC(p_box);			
			
	}

}

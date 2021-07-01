package common.popup.achpnt.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.popup.achpnt.dao.ACHPNTDAO;

public class ACHPNTWRK {
	/**
	 * 해당 년도에 대한 달성도배점정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACHPNT_SHR(CBox p_box, TrBox p_tr) throws CException {

		ACHPNTDAO dao = new ACHPNTDAO("default", p_tr);
		dao.ACHPNT_SHR(p_box);
			
	}
}

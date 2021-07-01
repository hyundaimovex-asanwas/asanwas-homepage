package common.popup.empl2.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.empl2.wrk.EMPL2WRK;

public class EMPL2EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EMPL2EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EMPL2WRK wrk = new EMPL2WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//	사원코드/명에 해당하는 부서와 직책을 조회를 위한 WORK메소드 호출
			wrk.EMPL2_SHR_01(box, tr);
		}else if (box.get("S_MODE").equals("SHR_02")) {
			//	사원코드/명에 해당하는 부서와 직책을 조회(퇴사자포함)를 위한 WORK메소드 호출
			wrk.EMPL2_SHR_02(box, tr);
		}else if (box.get("S_MODE").equals("SHR_03")) {
			//	사원코드/명에 해당하는 부서와 직책을 조회(퇴사자포함)를 위한 WORK메소드 호출
			wrk.EMPL2_SHR_03(box, tr);
		}

		return null;
	}

}

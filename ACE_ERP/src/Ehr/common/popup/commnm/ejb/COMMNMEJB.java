package common.popup.commnm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.popup.commnm.wrk.COMMNMWRK;

public class COMMNMEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public COMMNMEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		COMMNMWRK wrk = new COMMNMWRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	공통 정보 조회를 위한 WORK메소드 호출
			wrk.COMMNM_SHR(box, tr);
		}
		else if (box.get("S_MODE").equals("SHR_03")) {//1~2는 이미 사용중
			//	공통 정보 조회를 위한 WORK메소드 호출
			wrk.COMMNM_SHR_03(box, tr);
		}

		return null;
	}

}

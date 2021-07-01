package hr.sag.d.sagd040.ejb;

import hr.sag.d.sagd040.wrk.SAGD040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGD040EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGD040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGD040WRK wrk = new SAGD040WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//개인별 수당 조회를 위한 WORK메소드 호출
			wrk.SAGD040_SHR(box, tr);
		}

		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//개인별 수당을 저장, 수정하기 위한 WORK메소드 호출
			wrk.SAGD040_SAV(box, tr);
		}

        // S_MODE가 삭제인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//개인별 수당을 삭제하기 위한 WORK메소드 호출
			wrk.SAGD040_DEL(box, tr);
		}

		return null;
	}
}

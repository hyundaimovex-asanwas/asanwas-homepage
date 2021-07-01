package hr.but.a.buta070.ejb;

import hr.but.a.buta070.wrk.BUTA070WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA070EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA070EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BUTA070WRK wrk = new BUTA070WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//여비지급기준을 조회를 위한 WORK메소드 호출
			wrk.BUTA070_SHR(box, tr);
		}

		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//여비지급기준을 수정하기 위한 WORK메소드 호출
			wrk.BUTA070_SAV(box, tr);
		}

        // S_MODE가 삭제인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//여비지급기준을 삭제하기 위한 WORK메소드 호출
			wrk.BUTA070_DEL(box, tr);
		}

		return null;
	}

}

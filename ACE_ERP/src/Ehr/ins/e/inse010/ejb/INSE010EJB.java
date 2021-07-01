package hr.ins.e.inse010.ejb;

import hr.ins.e.inse010.wrk.INSE010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class INSE010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public INSE010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		INSE010WRK wrk = new INSE010WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			wrk.INSE010_SHR(box, tr);
		}

		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			wrk.INSE010_SAV(box, tr);
		}
        else if (box.get("S_MODE").equals("ULD")) {
		    wrk.INSE010_ULD(box, tr);
		}
		return null;
	}

}

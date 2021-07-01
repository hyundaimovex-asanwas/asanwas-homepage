package hr.sch.a.scha030.ejb;

import hr.sch.a.scha030.wrk.SCHA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SCHA030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SCHA030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SCHA030WRK wrk = new SCHA030WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	학자금 신청서 처리 정보 조회를 위한 WORK메소드 호출
			wrk.SCHA030_SHR(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			//	학자금금 신청서를 수정하기 위한 WORK메소드 호출
			wrk.SCHA030_SAV(box, tr);
		}
		// S_MODE가 전표처리인 경우
		if (box.get("S_MODE").equals("PROC")) {
			//	학자금금 신청서를 수정하기 위한 WORK메소드 호출
			wrk.SCHA030_PROC(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("APPROVAL")) {
			//	학자금금 신청서를 수정하기 위한 WORK메소드 호출
			wrk.SCHA030_APPROVAL(box, tr);
		}
		return null;
	}

}

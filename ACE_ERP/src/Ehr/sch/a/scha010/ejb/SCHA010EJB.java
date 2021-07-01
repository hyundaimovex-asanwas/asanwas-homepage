package hr.sch.a.scha010.ejb;

import hr.sch.a.scha010.wrk.SCHA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SCHA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public SCHA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SCHA010WRK wrk = new SCHA010WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	경공조금 지급기준 정보 조회를 위한 WORK메소드 호출
			wrk.SCHA010_SHR(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//	사원 정보 조회를 위한 WORK메소드 호출
			wrk.SCHA010_SHR_01(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			//	학자금 신청서를 저장하기 위한 WORK메소드 호출
			wrk.SCHA010_SAV(box, tr);
		}
		// S_MODE가 삭제인 경우
		if (box.get("S_MODE").equals("DEL")) {
			//	학자금 지급기준 정보를 삭제하기 위한 WORK메소드 호출
			wrk.SCHA010_DEL(box, tr);
		}
		
		return null;
	}

}

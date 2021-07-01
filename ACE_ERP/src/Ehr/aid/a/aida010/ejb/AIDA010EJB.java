package hr.aid.a.aida010.ejb;

import hr.aid.a.aida010.wrk.AIDA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class AIDA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public AIDA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		AIDA010WRK wrk = new AIDA010WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	경공조금 지급기준 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//	사원 및 지급내역에 따른 경공조금 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_01(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_02")) {
			//	권한 조회
			wrk.AIDA010_SHR_02(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_03")) {
			//	신청자에 해당하는 지급금액  조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_03(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_04")) {
			//	신청번호(REQ_NO)에 해당하는 신청서  조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_04(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_06")) {
			//	사원 및 지급내역에 따른 경공조금 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_06(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_LSE")) {
		    //	근속년수를 조회해 온다.
		    wrk.AIDA010_SHR_LSE(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			//	경공조금 신청서를 저장하기 위한 WORK메소드 호출
			wrk.AIDA010_SAV(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV_01")) {
			//	경공조금 신청서를 수정하고, 결재정보를 저장하기 위한 WORK메소드 호출
			wrk.AIDA010_SAV_01(box, tr);
		}
		// S_MODE가 삭제인 경우
		if (box.get("S_MODE").equals("DEL")) {
			//	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
			wrk.AIDA010_DEL(box, tr);
		}

		// S_MODE가 전표처리인 경우
		if (box.get("S_MODE").equals("PROC_D")) {
		    //	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
		    wrk.PROC_D(box, tr);
		}
        // S_MODE가 지급처리인 경우
		if (box.get("S_MODE").equals("PROC_E")) {
		    //	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
		    wrk.PROC_E(box, tr);
		}

		return null;
	}

}

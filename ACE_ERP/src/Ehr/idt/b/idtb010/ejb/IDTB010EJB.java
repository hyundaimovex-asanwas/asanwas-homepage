package Ehr.idt.b.idtb010.ejb;

import Ehr.idt.b.idtb010.wrk.IDTB010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTB010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTB010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		IDTB010WRK wrk = new IDTB010WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	증명서신청현황 조회를 위한 WORK메소드 호출
			wrk.IDTB010_SHR(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//	권한 조회를 위한 WORK메소드 호출
			wrk.IDTB010_SHR_01(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_02")) {
			//	사원정보 조회(주소)를 위한 WORK메소드 호출
			wrk.IDTB010_SHR_02(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			//	증명서신청 정보를 수정하기 위한 WORK메소드 호출
			wrk.IDTB010_SAV(box, tr);
		}
		// S_MODE가 삭제인인 경우
		if (box.get("S_MODE").equals("DEL")) {
			//	증명서신청 정보를 삭제하기 위한 WORK메소드 호출
			wrk.IDTB010_DEL(box, tr);
		}
		// S_MODE가 증명서 출력 업데이트인인 경우
		if (box.get("S_MODE").equals("UPT_PRT")) {
		    //	증명서신청 정보를 삭제하기 위한 WORK메소드 호출
		    wrk.IDTB010_UPT_PRT(box, tr);
		}
		return null;
	}

}

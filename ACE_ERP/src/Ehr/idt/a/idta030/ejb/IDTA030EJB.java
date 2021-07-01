package hr.idt.a.idta030.ejb;

import hr.idt.a.idta030.wrk.IDTA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTA030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTA030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		IDTA030WRK wrk = new IDTA030WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	증명서신청현황 조회를 위한 WORK메소드 호출
			wrk.IDTA030_SHR(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//	권한 조회를 위한 WORK메소드 호출
			wrk.IDTA030_SHR_01(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_02")) {
			//	사원정보 조회(주소)를 위한 WORK메소드 호출
			wrk.IDTA030_SHR_02(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			//	증명서신청 정보를 수정하기 위한 WORK메소드 호출
			wrk.IDTA030_SAV(box, tr);
		}
		// S_MODE가 삭제인인 경우
		if (box.get("S_MODE").equals("DEL")) {
			//	증명서신청 정보를 삭제하기 위한 WORK메소드 호출
			wrk.IDTA030_DEL(box, tr);
		}
		// S_MODE가 증명서 출력 업데이트인인 경우
		if (box.get("S_MODE").equals("UPT_PRT")) {
		    //	증명서신청 정보를 삭제하기 위한 WORK메소드 호출
		    wrk.IDTA030_UPT_PRT(box, tr);
		}
		return null;
	}

}

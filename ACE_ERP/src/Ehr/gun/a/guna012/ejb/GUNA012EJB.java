package hr.gun.a.guna012.ejb;

import hr.gun.a.guna012.wrk.GUNA012WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA012EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA012EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA012WRK wrk = new GUNA012WRK();

		// S_MODE가 목록조회인 경우
		if (box.get("S_MODE").equals("SHR_LST")) {
			//	근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA012_SHR_LST(box, tr);
		}
		// S_MODE가 상세조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA012_SHR(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (box.get("S_MODE").equals("SAV")) {
			//	근태 정보를 저장하기 위한 WORK메소드 호출
			wrk.GUNA012_SAV(box, tr);
		}
		// S_MODE가 삭제인인 경우
		if (box.get("S_MODE").equals("DEL")) {
			//	근태 정보를 삭제하기 위한 WORK메소드 호출
			wrk.GUNA012_DEL(box, tr);
		}
		// S_MODE가 연차체크인인 경우
		if (box.get("S_MODE").equals("SHR_YRP")) {
			//	장기근태 정보를 삭제하기 위한 WORK메소드 호출
			wrk.GUNA012_YRP(box, tr);
		}
		return null;
	}

}

package hr.gun.a.guna013.ejb;

import hr.gun.a.guna013.wrk.GUNA013WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA013EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA013EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA013WRK wrk = new GUNA013WRK();
		// S_MODE가 목록조회인 경우
		if (box.get("S_MODE").equals("SHR_LST")) {
			//	장기근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA013_SHR_LST(box, tr);
		}
		// S_MODE가 목록조회인 경우
		if (box.get("S_MODE").equals("SHR_CD")) {
			//	장기근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA013_SHR_CD(box, tr);
		}
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	해당부서의 근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA013_SHR(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//	근태변경신청서를 저장하기 위한 WORK메소드 호출
			wrk.GUNA013_SAV(box, tr);
		}
		// S_MODE가 삭제인인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//	근태변경신청서를 삭제하기 위한 WORK메소드 호출
			wrk.GUNA013_DEL(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_04")) {
			//	해당부서의 근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA013_SHR_04(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_05")) {
			//	신청번호 조회
			wrk.GUNA013_SHR_05(box, tr);
			// S_MODE가 조회인 경우
		}else if (box.get("S_MODE").equals("SHR_06")) {
				//	신청번호 조회
				wrk.GUNA013_SHR_06(box, tr);
			}
		return null;
	}

}

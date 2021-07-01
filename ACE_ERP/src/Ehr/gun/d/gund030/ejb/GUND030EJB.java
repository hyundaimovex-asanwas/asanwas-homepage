package hr.gun.d.gund030.ejb;


import hr.gun.d.gund030.wrk.GUND030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUND030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUND030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUND030WRK wrk = new GUND030WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//연차발생관리를 조회를 위한 WORK메소드 호출
			wrk.GUND030_SHR(box, tr);
		}
		// S_MODE가 일괄생성인 경우
		else if (box.get("S_MODE").equals("INS")) {
			//연차발생관리를 생성하기 위한 WORK메소드 호출
			wrk.GUND030_INS(box, tr);
		}

		// S_MODE가 재생성인 경우
		else if (box.get("S_MODE").equals("UPT")) {
			//연차발생관리를 생성하기 위한 WORK메소드 호출
			wrk.GUND030_UPT(box, tr);
		}

		//저장 미사용
		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//연차발생관리를 수정하기 위한 WORK메소드 호출
			wrk.GUND030_SAV(box, tr);
		}

        // S_MODE가 삭제인 경우
//		else if (box.get("S_MODE").equals("DEL")) {
			//연차발생관리을 삭제하기 위한 WORK메소드 호출
//			wrk.GUND030_DEL(box, tr);
//		}

		return null;
	}
}

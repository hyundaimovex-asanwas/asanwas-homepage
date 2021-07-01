package Ehr.cdp.a.book030.ejb;

import Ehr.cdp.a.book030.wrk.BOOK030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BOOK030WRK wrk = new BOOK030WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//휴일근무휴가신청을 조회를 위한 WORK메소드 호출
			wrk.BOOK030_SHR(box, tr);
		}

		// 디테일 조회
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK030_SHR_02(box, tr);
		}


		// 도서구입현황조회
		else if (box.get("S_MODE").equals("SHR_40")) {
			wrk.BOOK030_SHR_40(box, tr);
		}



		return null;
	}

}

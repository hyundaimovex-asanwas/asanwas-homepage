package Ehr.cdp.a.book010.ejb;

import Ehr.cdp.a.book010.wrk.BOOK010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BOOK010WRK wrk = new BOOK010WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//휴일근무휴가신청을 조회를 위한 WORK메소드 호출
			wrk.BOOK010_SHR(box, tr);
		}

		// 디테일 조회
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK010_SHR_02(box, tr);
		}

		// 신청번호 조회
		else if (box.get("S_MODE").equals("SHR_03")) {
			wrk.BOOK010_SHR_03(box, tr);
		}

		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//도서구입신청을 하기 위한 WORK메소드 호출
			wrk.BOOK010_SAV(box, tr);
		}


		// S_MODE가 저장인 경우 - 상신했을 경우
		else if (box.get("S_MODE").equals("UPT_APP")) {
		    //도서신청을 수정하기 위한 WORK메소드 호출
		    wrk.BOOK010_UPT_APP(box, tr);
		}




		// S_MODE가 결재시 팝업조회인 경우
		else if (box.get("S_MODE").equals("SHR_11")) {
			//도서구입신청 팝업조회를 위한 WORK메소드 호출
			wrk.BOOK010_SHR_11(box, tr);
		}

		// S_MODE가 결재선 조회인 경우
		else if (box.get("S_MODE").equals("SHR_APP")) {
			//도서구입신청 팝업조회를 위한 WORK메소드 호출
			wrk.BOOK010_SHR_APP(box, tr);
		}



        // S_MODE가 삭제인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//휴일근무휴가신청을 삭제하기 위한 WORK메소드 호출
			//wrk.BOOK010_DEL(box, tr);
		}

		return null;
	}

}

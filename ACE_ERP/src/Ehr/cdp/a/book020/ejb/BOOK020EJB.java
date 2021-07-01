package Ehr.cdp.a.book020.ejb;

import Ehr.cdp.a.book020.wrk.BOOK020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BOOK020WRK wrk = new BOOK020WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//도서구입신청을 조회를 위한 WORK메소드 호출
			wrk.BOOK020_SHR(box, tr);
		}

		// 디테일 조회
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK020_SHR_02(box, tr);
		}

		// S_MODE가 휴일근무휴가신청 결재선조회인 경우
		else if (box.get("S_MODE").equals("SHR_01")) {
			//휴일근무휴가신청 결재선조회를 위한 WORK메소드 호출 ==> 순차처리  휴일수당 정산에서 사용
			wrk.BOOK020_SHR_01(box, tr);
		}

		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//도서구입신청을 하기 위한 WORK메소드 호출
			wrk.BOOK020_SAV(box, tr);
		}

		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("UPT_APP")) {
		    //휴일근무휴가신청을 수정하기 위한 WORK메소드 호출
		    wrk.BOOK020_UPT_APP(box, tr);
		}

        // S_MODE가 삭제인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//휴일근무휴가신청을 삭제하기 위한 WORK메소드 호출
			//wrk.BOOK020_DEL(box, tr);
		}



		// 인별 최대 5일/월 여부 조회
		else if (box.get("S_MODE").equals("SHR_03")) {
			wrk.BOOK020_SHR_03(box, tr);
		}
		return null;
	}

}

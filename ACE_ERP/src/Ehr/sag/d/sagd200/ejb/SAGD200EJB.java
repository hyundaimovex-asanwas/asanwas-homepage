package hr.sag.d.sagd200.ejb;

import hr.sag.d.sagd200.wrk.SAGD200WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGD200EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGD200EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGD200WRK wrk = new SAGD200WRK();

		/** 조회 **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGD200_SHR(box, tr);
		}

		/** 소급분 조회 **/
		else if (box.get("S_MODE").equals("SHR_SO")) {
			wrk.SAGD200_SHR_SO(box, tr);
		}

		/** 적용일자 조회 **/
		else if (box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGD200_SHR_01(box, tr);
		}

		/** 적용일자 조회 **/
		else if (box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGD200_SHR_PRINT(box, tr);
		}

		/** 엑셀파일 업로드 **/
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGD200_SHR_02(box, tr);
		}
		/** 저장 **/
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.SAGD200_SAV(box, tr);
		}
		/** 삭제 **/
		else if (box.get("S_MODE").equals("DEL")) {
			wrk.SAGD200_DEL(box, tr);
		}

		return null;
	}

}

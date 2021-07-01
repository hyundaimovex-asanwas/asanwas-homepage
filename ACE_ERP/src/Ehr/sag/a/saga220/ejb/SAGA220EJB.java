package hr.sag.a.saga220.ejb;

import hr.sag.a.saga220.wrk.SAGA220WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA220EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGA220EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGA220WRK wrk = new SAGA220WRK();

		/** 조회 **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGA220_SHR(box, tr);
		}
		/** 적용일자 조회 **/
		else if (box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA220_SHR_01(box, tr);
		}
		/** 엑셀파일 업로드 **/
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGA220_SHR_02(box, tr);
		}
		/** 저장 **/
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.SAGA220_SAV(box, tr);
		}
		/** 삭제 **/
		else if (box.get("S_MODE").equals("DEL")) {
			wrk.SAGA220_DEL(box, tr);
		}

		return null;
	}

}

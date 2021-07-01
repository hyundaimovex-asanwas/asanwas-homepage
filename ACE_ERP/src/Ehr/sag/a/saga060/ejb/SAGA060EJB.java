package hr.sag.a.saga060.ejb;

import hr.sag.a.saga060.wrk.SAGA060WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA060EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGA060EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGA060WRK wrk = new SAGA060WRK();

		/** 조회 **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGA060_SHR(box, tr);
		}

		/** 출력용 조회 **/
		if (box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGA060_SHR_PRINT(box, tr);
		}

		if (box.get("S_MODE").equals("SHR_PRINT_02")) {
			wrk.SAGA060_SHR_PRINT_02(box, tr);
		}

		if (box.get("S_MODE").equals("SHR_PRINT_03")) {
			wrk.SAGA060_SHR_PRINT_03(box, tr);
		}

		return null;
	}

}

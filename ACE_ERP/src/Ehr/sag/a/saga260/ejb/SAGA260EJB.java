package hr.sag.a.saga260.ejb;

import hr.sag.a.saga260.wrk.SAGA260WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA260EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGA260EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;

	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGA260WRK wrk = new SAGA260WRK();

		/** MASTER 조회 **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGA260_SHR(box, tr);
		}
		/** DETAIL 조회 **/
		if (box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA260_SHR_01(box, tr);
		}

		/** DETAIL 조회 **/
		if (box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGA260_SHR_02(box, tr);
		}

		/** DETAIL 조회 **/
		if (box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGA260_SHR_PRINT(box, tr);
		}

		/** MASTER 저장 **/
		if (box.get("S_MODE").equals("SAV")) {
			wrk.SAGA260_SAV(box, tr);
		}

		/** DETAIL 저장 **/
		if (box.get("S_MODE").equals("SAV_01")) {
			wrk.SAGA260_SAV_01(box, tr);
		}
		/** DETAIL 저장 **/
		if (box.get("S_MODE").equals("SAV_DELAY")) {
			wrk.SAGA260_SAV_DELAY(box, tr);
		}

		return null;
	}

}

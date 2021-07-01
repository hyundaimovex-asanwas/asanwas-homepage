package hr.sag.a.saga270.ejb;

import hr.sag.a.saga270.wrk.SAGA270WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA270EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGA270EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;



	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGA270WRK wrk = new SAGA270WRK();

		/** MASTER 조회 **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGA270_SHR(box, tr);
		}
		/** DETAIL 조회 **/
		if (box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA270_SHR_01(box, tr);
		}

		/** DETAIL 조회 **/
		if (box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGA270_SHR_PRINT(box, tr);
		}

		/** MASTER 저장 **/
		if (box.get("S_MODE").equals("SAV")) {
			wrk.SAGA270_SAV(box, tr);
		}

		/** DETAIL 저장 **/
		if (box.get("S_MODE").equals("SAV_01")) {
			wrk.SAGA270_SAV_01(box, tr);
		}

		/** 중도상환 저장 **/
		if (box.get("S_MODE").equals("SAV_REP")) {
			wrk.SAGA270_SAV_REP(box, tr);
		}

		return null;
	}

}

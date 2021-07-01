package hr.sag.e.sage010.ejb;

import hr.sag.e.sage010.wrk.SAGE010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGE010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGE010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGE010WRK wrk = new SAGE010WRK();

		/** 조회 **/
		if (box.get("S_MODE").equals("SHR")) {

			wrk.SAGE010_SHR(box, tr);

		}
		/** 소속 조회 **/
		else if (box.get("S_MODE").equals("SHR_01")) {

			wrk.SAGE010_SHR_01(box, tr);

		}

		/** 저장 **/
		else if (box.get("S_MODE").equals("SAV")) {

			wrk.SAGE010_SAV(box, tr);

		}


		return null;
	}

}

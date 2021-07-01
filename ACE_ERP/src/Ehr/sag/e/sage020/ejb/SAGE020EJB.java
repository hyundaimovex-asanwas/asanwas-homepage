package hr.sag.e.sage020.ejb;

import hr.sag.e.sage020.wrk.SAGE020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGE020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGE020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGE020WRK wrk = new SAGE020WRK();

		/** 조회 **/
		if (box.get("S_MODE").equals("SHR")) {

			wrk.SAGE020_SHR(box, tr);

		}
		/** 일자 조회 **/
		else if (box.get("S_MODE").equals("SHR_01")) {

			wrk.SAGE020_SHR_01(box, tr);

		}

		/** 저장 **/
		else if (box.get("S_MODE").equals("SAV")) {

			wrk.SAGE020_SAV(box, tr);

		}


		return null;
	}

}

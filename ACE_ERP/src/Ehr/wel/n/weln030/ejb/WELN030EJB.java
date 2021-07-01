package hr.wel.n.weln030.ejb;

import hr.wel.n.weln030.wrk.WELN030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class WELN030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public WELN030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		WELN030WRK wrk = new WELN030WRK();


		// S_MODE가 조회, 저장, 수정인 경우
		if (box.get("S_MODE").equals("SHR")) {

			wrk.WELN030_SHR(box, tr);

		}else if (box.get("S_MODE").equals("SAV")) {

			wrk.WELN030_SAV(box, tr);

		}else if (box.get("S_MODE").equals("SAV_01")) {

			wrk.WELN030_SAV_01(box, tr);

		}else if (box.get("S_MODE").equals("SAV_END")) {

			wrk.WELN030_SAV_END(box, tr);

		}else if (box.get("S_MODE").equals("ULD")) {

		    wrk.WELN030_ULD(box, tr);

		}else if (box.get("S_MODE").equals("DEL")) {

		    wrk.WELN030_DEL(box, tr);

		}

		return null;
	}

}

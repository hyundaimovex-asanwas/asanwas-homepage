package Ehr.cdp.a.book011.ejb;

import Ehr.cdp.a.book011.wrk.BOOK011WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK011EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK011EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BOOK011WRK wrk = new BOOK011WRK();

		if(box.get("S_MODE").equals("UPT_APP")) {

			wrk.BOOK011_UPT_APP(box, tr);

		} else if(box.get("S_MODE").equals("UPT_REJ")) {

			wrk.BOOK011_UPT_REJ(box, tr);

		} else if(box.get("S_MODE").equals("UPT_DETAIL")) {

			wrk.BOOK011_UPT_DETAIL(box, tr);

		} else if(box.get("S_MODE").equals("SAV_APP")) {

			wrk.BOOK011_SAV_APP(box, tr);

		}

		return null;
	}

}

package hr.tax.a.taxa010.ejb;

import hr.tax.a.taxa010.wrk.TAXA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class TAXA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public TAXA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		TAXA010WRK wrk = new TAXA010WRK();

		/** 조회 **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.TAXA010_SHR(box, tr);
		}

		return null;
	}

}

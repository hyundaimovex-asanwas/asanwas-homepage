package Ehr.edu.e.edue040.ejb;

import Ehr.edu.e.edue040.wrk.EDUE040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE040EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EDUE040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUE040WRK wrk = new EDUE040WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//근태현황 결재처리 조회를 위한 WORK메소드 호출
			wrk.EDUE040_SHR(box, tr);
		}
		
		return null;
	}

}

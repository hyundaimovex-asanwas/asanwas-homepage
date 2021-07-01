package hr.pir.e.pire050.ejb;

import hr.pir.e.pire050.wrk.PIRE050WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRE050EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public PIRE050EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRE050WRK wrk = new PIRE050WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//휴일근무휴가신청을 조회를 위한 WORK메소드 호출
			wrk.PIRE050_SHR(box, tr);
		}


		return null;
	}

}

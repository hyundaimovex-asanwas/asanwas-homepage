package Ehr.gun.e.gune015.ejb;


import Ehr.gun.e.gune015.wrk.GUNE015WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNE015EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNE015EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNE015WRK wrk = new GUNE015WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//연장근무 현황 조회를 위한 WORK메소드 호출
			wrk.GUNE015_SHR(box, tr);
		}

	

		return null;
	}

}

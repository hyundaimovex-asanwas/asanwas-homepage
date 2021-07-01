package common.popup.worldcity.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.worldcity.wrk.WORLDCITYWRK;

public class WORLDCITYEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public WORLDCITYEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		WORLDCITYWRK wrk = new WORLDCITYWRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("NAT_SHR")) {
			//	평가구조설정내용 조회를 위한 WORK메소드 호출
			wrk.NAT_SHR(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("CITY_SHR")) {
			//	평가구조설정내용 조회를 위한 WORK메소드 호출
			wrk.CITY_SHR(box, tr);
		}
		return null;
	}

}

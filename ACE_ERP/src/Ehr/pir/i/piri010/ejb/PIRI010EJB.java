package hr.pir.i.piri010.ejb;

import hr.pir.i.piri010.wrk.PIRI010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRI010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public PIRI010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRI010WRK wrk = new PIRI010WRK();

		// S_MODE가 조회인 경우(부서 정보 조회를 위한 WORK메소드 호출)
		if (box.get("S_MODE").equals("SHR_01")) {
			wrk.PIRI010_SHR_01(box, tr);
		}
		/// S_MODE가 조회인 경우(사원 정보 조회를 위한 WORK메소드 호출)
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.PIRI010_SHR_02(box, tr);
		}

		return null;
	}

}

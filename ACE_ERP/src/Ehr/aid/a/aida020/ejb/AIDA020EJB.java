package hr.aid.a.aida020.ejb;

import hr.aid.a.aida020.wrk.AIDA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class AIDA020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public AIDA020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		AIDA020WRK wrk = new AIDA020WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	경공조금 지급처리  정보 조회를 위한 WORK메소드 호출
			wrk.AIDA020_SHR(box, tr);
		}
		
		return null;
	}

}

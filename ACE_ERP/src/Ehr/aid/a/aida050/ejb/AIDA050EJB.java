package hr.aid.a.aida050.ejb;

import hr.aid.a.aida050.wrk.AIDA050WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class AIDA050EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public AIDA050EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		AIDA050WRK wrk = new AIDA050WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	경공조금 지급기준 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA050_SHR(box, tr);
		}
		// S_MODE가 저장, 수정인 경우
        else if (box.get("S_MODE").equals("SAV")) {
			//	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
			wrk.AIDA050_SAV(box, tr);
		}
		
		return null;
	}

}

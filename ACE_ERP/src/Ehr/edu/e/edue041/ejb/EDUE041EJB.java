package Ehr.edu.e.edue041.ejb;

import Ehr.edu.e.edue041.wrk.EDUE041WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE041EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EDUE041EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUE041WRK wrk = new EDUE041WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//결재세부사항 조회(변경신청) 조회를 위한 WORK메소드 호출
			wrk.EDUE041_SHR(box, tr);
		}else if (box.get("S_MODE").equals("SAV") ) {
			//결재세부사항 조회(일일근태) 저장을 위한 WORK메소드 호출
			wrk.EDUE041_SAV(box, tr);
		}else if (box.get("S_MODE").equals("SAV01") ) {
			//결재세부사항 조회(일일근태) 저장을 위한 WORK메소드 호출
			wrk.EDUE041_SAV(box, tr);
		}
		return null;
	}

}

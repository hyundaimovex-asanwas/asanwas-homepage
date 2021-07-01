package Ehr.common.popup.education.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.education.wrk.EDUCATIONWRK;

public class EDUCATIONEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EDUCATIONEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUCATIONWRK wrk = new EDUCATIONWRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	과정코드 조회
			wrk.EDUCATION_SHR(box, tr);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {//1~2는 이미 사용중
			//	차수 조회
			wrk.EDUCATION_SHR_01(box, tr);
		}
		else if (box.get("S_MODE").equals("SHR_C")) {
			//	과정코드 조회
			wrk.EDUCATION_SHR_C(box, tr);
		}
		

		return null;
	}
	
}

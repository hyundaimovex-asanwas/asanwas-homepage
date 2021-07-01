package common.popup.codenm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.popup.codenm.wrk.CODENMWRK;

public class CODENMEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public CODENMEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		CODENMWRK wrk = new CODENMWRK();
//		 S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	공통 정보 조회를 위한 WORK메소드 호출
			wrk.CODENM_SHR(box, tr);
		}else if (box.get("S_MODE").equals("SHR_SEL")) {
				//	공통 정보 조회를 위한 WORK메소드 호출
				wrk.CODENM_SHR_SEL(box, tr);			
		}
		
		return null;
	}

}

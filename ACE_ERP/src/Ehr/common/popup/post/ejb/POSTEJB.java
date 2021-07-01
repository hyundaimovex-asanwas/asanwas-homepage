package common.popup.post.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.post.wrk.POSTWRK;

public class POSTEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public POSTEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		POSTWRK wrk = new POSTWRK();
		
//		 S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	우편번호 정보 조회를 위한 WORK메소드 호출
			wrk.POST_SHR(box, tr);
		}
		
		return null;
	}

}

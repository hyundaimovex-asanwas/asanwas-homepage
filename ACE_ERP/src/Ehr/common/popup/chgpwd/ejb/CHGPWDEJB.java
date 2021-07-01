package common.popup.chgpwd.ejb;

import common.popup.chgpwd.wrk.CHGPWDWRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CHGPWDEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public CHGPWDEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** WRK Class 객체 생성 * */
		CHGPWDWRK wrk = new CHGPWDWRK();

        /** 사용자 비밀번호 변경  (SHR:조회, SAV:수정)을 위한 WRK Class 메소드 호출 * */
		if(box.get("S_MODE").equals("SHR"))
			wrk.CHGPWD_SHR(box, tr);
		else if(box.get("S_MODE").equals("SAV"))
			wrk.CHGPWD_SAV(box, tr);
		else if(box.get("S_MODE").equals("CHG"))
			wrk.CHGPWD_CHG(box, tr);
		return null;
	}

}

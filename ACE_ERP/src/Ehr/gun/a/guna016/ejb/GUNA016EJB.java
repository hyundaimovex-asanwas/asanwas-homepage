package hr.gun.a.guna016.ejb;

import hr.gun.a.guna016.wrk.GUNA016WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA016EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA016EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA016WRK wrk = new GUNA016WRK();
		// S_MODE가 목록조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	장기근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA016_SHR(box, tr);
		}
		return null;
	}

}

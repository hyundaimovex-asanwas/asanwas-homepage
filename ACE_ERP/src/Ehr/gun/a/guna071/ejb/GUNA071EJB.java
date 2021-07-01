package hr.gun.a.guna071.ejb;

import hr.gun.a.guna071.wrk.GUNA071WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA071EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA071EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA071WRK wrk = new GUNA071WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//결재세부사항 조회(변경신청) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_01(box, tr);

		}else if (box.get("S_MODE").equals("SHR_02")) {
			//결재세부사항 조회(일일근태) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_02(box, tr);

		}else if (box.get("S_MODE").equals("SHR_PLAN")) {
			//결재세부사항 조회(익월근태) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_PLAN(box, tr);

		}else if (box.get("S_MODE").equals("SHR_ACC")) {
			//결재세부사항 조회(익월근태) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_ACC(box, tr);

		}else if (box.get("S_MODE").equals("SHR_APP")) {
			//공통 결재자  조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_APP(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("C")) ) {
			//결재세부사항 조회(일일근태) 저장을 위한 WORK메소드 호출
			wrk.GUNA071_SAV(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("U")) ) {
		//결재세부사항 조회(변경근태) 저장을 위한 WORK메소드 호출
			wrk.GUNA071_SAV_01(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("P")) ) {
		//결재세부사항 조회(익월근태) 저장를 위한 WORK메소드 호출
			wrk.GUNA071_SAV_02(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("A")) ) {
			//결재세부사항 조회(연차촉진제) 저장를 위한 WORK메소드 호출
			wrk.GUNA071_SAV_03(box, tr);
		}
		return null;
	}

}

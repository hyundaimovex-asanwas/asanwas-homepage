package hr.but.a.buta021.ejb;

import hr.but.a.buta021.wrk.BUTA021WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA021EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA021EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BUTA021WRK wrk = new BUTA021WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//여비지급기준 조회를 위한 WORK메소드 호출
			wrk.BUTA021_SHR_01(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_02")) {
				//직급에 따른 단가명 조회를 위한 WORK메소드 호출
				wrk.BUTA021_SHR_02(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_03")) {
				//직급에 따른 단가명 조회를 위한 WORK메소드 호출
				wrk.BUTA021_SHR_03(box, tr);
		}
		//S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR")) {
				//직급에 따른 단가명 조회를 위한 WORK메소드 호출
				wrk.BUTA021_SHR(box, tr);
		}
		//S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//출장품의 현황 삭제를 위한 WORK메소드 호출
			wrk.BUTA021_SAV(box, tr);
			//S_MODE가 저장인 경우
		}else if (box.get("S_MODE").equals("SHR_04")) {
				//출장품의 현황 삭제를 위한 WORK메소드 호출
				wrk.BUTA021_SHR_04(box, tr);
		}
		return null;
	}

}

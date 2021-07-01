package Ehr.yac.a.yaca030.ejb;

import Ehr.yac.a.yaca030.wrk.YACA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public YACA030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		YACA030WRK wrk = new YACA030WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//의료비공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA030_SHR(box, tr);
		}
		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SHR_FAM")) {
			//의료비공제내역을 저장하기 위한 WORK메소드 호출
			wrk.YACA030_SHR_FAM(box, tr);
		}
		
		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//의료비공제내역을 저장하기 위한 WORK메소드 호출
			wrk.YACA030_SAV(box, tr);
		}

        // S_MODE가 삭제인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//의료비공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA030_DEL(box, tr);
		}
		
		else if (box.get("S_MODE").equals("ACC")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA030_UPT_ACC(box, tr);
		}
		
		return null;
	}
}

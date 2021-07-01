package hr.but.a.buta010.ejb;

import hr.but.a.buta010.wrk.BUTA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BUTA010WRK wrk = new BUTA010WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//출장품의 현황 조회를 위한 WORK메소드 호출
			wrk.BUTA010_SHR(box, tr);
		}

		//S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("DEL")) {
			//출장품의 현황 삭제를 위한 WORK메소드 호출
			wrk.BUTA010_DEL(box, tr);
		}

		//S_MODE가 비용귀속정보 조회인 경우
		else if (box.get("S_MODE").equals("SAP_SHR")) {
		    //출장품의 현황 삭제를 위한 WORK메소드 호출
		    wrk.BUTA010_SAP_SHR(box, tr);
		}
		//S_MODE가 전표인 경우
		else if (box.get("S_MODE").equals("PROC")) {
		    //출장품의 현황 삭제를 위한 WORK메소드 호출
		    wrk.BUTA010_PROC(box, tr);
		}
		//S_MODE가 인사팀확인인 경우
		else if (box.get("S_MODE").equals("UPT_01")) {
		    //출장품의 현황 삭제를 위한 WORK메소드 호출
		    wrk.BUTA010_UPT_01(box, tr);
		}
		return null;
	}

}

package hr.sag.b.sagb060.ejb;

import hr.sag.b.sagb060.wrk.SAGB060WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGB060EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGB060EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGB060WRK wrk = new SAGB060WRK();

		//S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//엑셀파일을 열어 내용을 가져오기 위한 WORK메소드 호출
			wrk.SAGB060_SHR(box, tr);
		}
		// S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV")) {
			//변동지불공제File전송 내용을 저장하기 위한 WORK메소드 호출
			wrk.SAGB060_SAV(box, tr);
		}

		return null;
	}
}

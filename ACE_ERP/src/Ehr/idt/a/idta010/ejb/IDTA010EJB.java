package hr.idt.a.idta010.ejb;

import hr.idt.a.idta010.wrk.IDTA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		IDTA010WRK wrk = new IDTA010WRK();
		
		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			//	증명서발급처리 정보 조회를 위한 WORK메소드 호출(인쇄용)
			wrk.IDTA010_SHR(box, tr);
		}

		if (box.get("S_MODE").equals("SAV")) {
			//	증명서발급처리 정보를 저장하기 위한 WORK메소드 호출
			wrk.IDTA010_SAV_TEMP(box, tr);
		}
		
		if (box.get("S_MODE").equals("PROC")) {
		    //	증명서발급처리 정보를 저장하기 위한 WORK메소드 호출
		    wrk.IDTA010_PROC(box, tr);
		}
		return null;
	}

}

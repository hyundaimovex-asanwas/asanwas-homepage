package hr.pir.a.pira032.ejb;

import hr.pir.a.pira032.wrk.PIRA032WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA032EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA032EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA032WRK wrk = new PIRA032WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 사번생성 탭에서 화면 오픈시 또는 사번 변경시에
			 * 사번생성 데이터를 조회해온다. 
			 */
			wrk.PIRA032_SHR(box, trBox);
		}
		
		return null;
	}

}

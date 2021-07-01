package hr.pir.a.pira030.ejb;

import hr.pir.a.pira030.wrk.PIRA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA030EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA030EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA030WRK wrk = new PIRA030WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 공조부조 탭에서 화면 오픈시 또는 사번 변경시에
			 * 공조부조 데이터를 조회해온다. 
			 */
			wrk.PIRA030_SHR(box, trBox);
		}

		return null;
	}

}

package common.enonm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.enonm.wrk.ENONMWRK;

public class ENONMEJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public ENONMEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		ENONMWRK wrk = new ENONMWRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 사번를 입력하면 해당 사원명을 조회해온다.
			 */
			wrk.ENONM_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {
			/**
			 * 성명를 입력하면 해당 사번을 조회해온다.
			 */
			wrk.ENONM_SHR_01(box, trBox);
		}
		
		return null;
	}

}

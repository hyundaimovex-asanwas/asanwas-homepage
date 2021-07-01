package Ehr.edu.h.eduh032.ejb;

import Ehr.edu.h.eduh032.wrk.EDUH032WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUH032EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUH032EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUH032WRK wrk = new EDUH032WRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SHR")) {
			wrk.EDUH032_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.EDUH032_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_CHASU")) {
		    wrk.EDUH032_SHR_CHASU(box, trBox);
		}
		else if (box.get("S_MODE").equals("NEW")){
			wrk.EDUH032_SHR_NEW(box, trBox);

		}

		return null;
	}

}

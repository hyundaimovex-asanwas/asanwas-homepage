package Ehr.common.empl.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.empl.wrk.EMPLWRK;

public class EMPLEJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EMPLEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
        EMPLWRK wrk = new EMPLWRK();

		if (box.get("S_MODE").equals("SHR")) {
			wrk.EMPL_SHR(box, trBox);
		}
		return null;
	}

}

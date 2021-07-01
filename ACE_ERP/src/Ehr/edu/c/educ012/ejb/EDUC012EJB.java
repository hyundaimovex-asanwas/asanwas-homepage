package Ehr.edu.c.educ012.ejb;

import Ehr.edu.c.educ012.wrk.EDUC012WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUC012EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUC012EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUC012WRK wrk = new EDUC012WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			wrk.EDUC012_SHR(box, trBox);
		}

		return null;
	}

}

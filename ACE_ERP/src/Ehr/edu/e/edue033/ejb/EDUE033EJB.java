package Ehr.edu.e.edue033.ejb;

import Ehr.edu.e.edue033.wrk.EDUE033WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE033EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE033EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUE033WRK wrk = new EDUE033WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SHR")) {
			wrk.EDUE033_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.EDUE033_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("NEW")){
			wrk.EDUE033_SHR_NEW(box, trBox);
		}

		return null;
	}


}

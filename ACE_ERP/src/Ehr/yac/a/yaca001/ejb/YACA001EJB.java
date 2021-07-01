package Ehr.yac.a.yaca011.ejb;

import Ehr.yac.a.yaca011.wrk.YACA011WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA011EJB extends EJB {

	private CBox p_box = null;
	private TrBox p_tr = null;
	
	public YACA011EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.p_box = p_box;
		this.p_tr = p_tr;
	}
	
	public Object process() throws CException {
        String mode = p_box.get("S_MODE");

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA011WRK wrk = new YACA011WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA011_SHR(p_box, p_tr);
        } 
        else if (mode.equals("SAV")) {
            wrk.YACA011_SAV(p_box, p_tr);
        } 
        
        
        return null;
	}

	
	
}

package Ehr.yac.a.yaca023.ejb;

import Ehr.yac.a.yaca023.wrk.YACA023WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA023EJB extends EJB {

	private CBox p_box = null;
	private TrBox p_tr = null;
	
	public YACA023EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.p_box = p_box;
		this.p_tr = p_tr;
	}
	
	public Object process() throws CException {
        String mode = p_box.get("S_MODE");
        
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA023WRK wrk = new YACA023WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA023_SHR_PLA(p_box, p_tr);
        } 
   
        // S_MODE가 저장인 경우
        else if (mode.equals("SAV")) {
            wrk.YACA023_SAV(p_box, p_tr);
        }
        
        
        return null;
	}

}

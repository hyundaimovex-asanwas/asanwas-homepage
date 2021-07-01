package hr.tax.a.taxa040.ejb;

import hr.tax.a.taxa040.wrk.TAXA040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class TAXA040EJB extends EJB {

	private CBox p_box = null;
	private TrBox p_tr = null;
	
	public TAXA040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.p_box = p_box;
		this.p_tr = p_tr;
	}
	
	public Object process() throws CException {
        String mode = p_box.get("S_MODE");
        
        Log.debug.println("S_MODE:"+mode);
        
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        TAXA040WRK wrk = new TAXA040WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.TAXA040_SHR(p_box, p_tr);
        } 
        
        return null;
	}

}

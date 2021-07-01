package Ehr.yac.a.yaca020.ejb;

import Ehr.yac.a.yaca020.wrk.YACA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA020EJB extends EJB {

	private CBox p_box = null;
	private TrBox p_tr = null;
	
	public YACA020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.p_box = p_box;
		this.p_tr = p_tr;
	}
	
	public Object process() throws CException {
        String mode = p_box.get("S_MODE");
        
        //Log.debug.println("S_MODE:"+mode);
        
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA020WRK wrk = new YACA020WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA020_SHR(p_box, p_tr);
        } 
        else if (mode.equals("SHR_01")) {
        	wrk.YACA020_SHR_01(p_box, p_tr);
        } 
        else if (mode.equals("SHR_13")) {

        	wrk.YACA020_SHR_13(p_box, p_tr);
        }         
        else if (mode.equals("SHR_OLD")) {
        	wrk.YACA020_SHR_OLD(p_box, p_tr);
        }         
        // S_MODE가 저장인 경우
        else if (mode.equals("SAV")) {
            wrk.YACA020_SAV(p_box, p_tr);
        }

        else if (mode.equals("SAV_01")) {
        	wrk.YACA020_SAV_01(p_box, p_tr);
        } 

        else if (mode.equals("SAV_CLS")) {
        	wrk.YACA020_SAV_CLS(p_box, p_tr);
        }         
  
        else if (mode.equals("SAV_END")) {
        	wrk.YACA020_SAV_END(p_box, p_tr);
        }           
        
        return null;
	}

}

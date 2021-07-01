package Ehr.yac.a.yaca099.ejb;

import Ehr.yac.a.yaca099.wrk.YACA099WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA099EJB extends EJB {

	private CBox p_box = null;
	private TrBox p_tr = null;

	public YACA099EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.p_box = p_box;
		this.p_tr = p_tr;
	}

	public Object process() throws CException {
        String mode = p_box.get("S_MODE");

        //Log.debug.println("S_MODE:"+mode);

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA099WRK wrk = new YACA099WRK();

       
        return null;
	}

}

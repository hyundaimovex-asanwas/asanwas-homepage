package common.combo.evlenonm.ejb;

import common.combo.evlenonm.wrk.EVLENONMWRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.combo.evlenonm.wrk.EVLENONMWRK;
import common.menu.login.wrk.LOGINWRK;

public class EVLENONMEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EVLENONMEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
        /** WRK Class 객체 생성 * */
        EVLENONMWRK wrk = new EVLENONMWRK();

        /** 콤보를 위한 평가자조회 (SHR:피평가자에 대한 평가자 조회)을 위한 WRK Class 메소드 호출 * */
        if(box.get("S_MODE").equals("SHR"))
            wrk.EVLENONM_SHR(box, tr);

        return null;
	}

}

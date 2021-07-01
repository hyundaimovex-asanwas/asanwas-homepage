package common.yearmonth.ejb;

import common.yearmonth.wrk.YEARMONTHWRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.login.wrk.LOGINWRK;

public class YEARMONTHEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public YEARMONTHEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
        /** WRK Class 객체 생성 * */
        YEARMONTHWRK wrk = new YEARMONTHWRK();

        /** 현재 평가입력기간에 해당하는 년도,회차 정보 (SHR:현재 평가입력기간에 해당하는 년도,회차 정보) 위한 WRK Class 메소드 호출 * */
        if(box.get("S_MODE").equals("SHR"))
            wrk.YEARMONTH_SHR(box, tr);
        else if(box.get("S_MODE").equals("SHR01"))
            wrk.YEARMONTH_SHR01(box, tr);

        return null;
	}

}

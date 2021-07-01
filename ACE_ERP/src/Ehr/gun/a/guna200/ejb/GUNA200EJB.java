package hr.gun.a.guna200.ejb;

import hr.gun.a.guna200.wrk.GUNA200WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA200EJB extends EJB {

    private CBox box = null;
    private TrBox tr = null;

    public GUNA200EJB(CBox p_box, TrBox p_tr ) throws CException {
        this.box = p_box;
        this.tr = p_tr;
    }

    public Object process() throws CException {
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        GUNA200WRK wrk = new GUNA200WRK();

        // S_MODE가 조회인 경우
        if (box.get("S_MODE").equals("SHR")) {
            wrk.GUNA200_SHR(box, tr);
        }
        return null;
    }

}

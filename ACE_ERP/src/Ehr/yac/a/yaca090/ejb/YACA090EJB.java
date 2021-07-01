package hr.tax.a.taxa030.ejb;

import hr.tax.a.taxa030.wrk.TAXA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class TAXA030EJB extends EJB {

    private CBox p_box = null;
    private TrBox p_tr = null;

    public TAXA030EJB(CBox p_box, TrBox p_tr ) throws CException {
        this.p_box = p_box;
        this.p_tr = p_tr;
    }

    public Object process() throws CException {
        String mode = p_box.get("S_MODE");

        Log.debug.println("S_MODE:"+mode);

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        TAXA030WRK wrk = new TAXA030WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.TAXA030_SHR(p_box, p_tr);
        }
        // S_MODE가 미처리자 조회
        else if (mode.equals("SHR_01")) {
        	wrk.TAXA030_SHR_01(p_box, p_tr);
        }
        // S_MODE가 퇴직정산자 조회
        else if (mode.equals("SHR_RET")) {
            wrk.TAXA030_SHR_RET(p_box, p_tr);
        }
        // S_MODE가 대상자선정 인 경우
        else if (mode.equals("PROC1")) {
            wrk.TAXA030_PROC1(p_box, p_tr);
        }
        // S_MODE가 대상추가 인 경우
        else if (mode.equals("PROC2")) {
            wrk.TAXA030_PROC2(p_box, p_tr);
        }
        // S_MODE가 정산계산작업 인 경우
        else if (mode.equals("PROC3")) {
            wrk.TAXA030_PROC3(p_box, p_tr);
        }
        //      S_MODE가 정산계산작업 인 경우
        else if (mode.equals("PROC3A")) {
            wrk.TAXA030_PROC3A(p_box, p_tr);
        }
        // S_MODE가 작업종료 인 경우
        else if (mode.equals("PROC4")) {
            wrk.TAXA030_PROC4(p_box, p_tr);
        }
        // S_MODE가 대상자선정 재작업 인 경우
        else if (mode.equals("PROC5")) {
            wrk.TAXA030_PROC5(p_box, p_tr);
        }
        // S_MODE가 정산계산작업 재작업 인 경우
        else if (mode.equals("PROC6")) {
            wrk.TAXA030_PROC6(p_box, p_tr);
        }

        return null;
    }

}

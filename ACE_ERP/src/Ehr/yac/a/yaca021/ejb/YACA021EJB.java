package Ehr.yac.a.yaca021.ejb;

import Ehr.yac.a.yaca021.wrk.YACA021WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA021EJB extends EJB {

	private CBox p_box = null;
	private TrBox p_tr = null;

	public YACA021EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.p_box = p_box;
		this.p_tr = p_tr;
	}

	public Object process() throws CException {
        String mode = p_box.get("S_MODE");

        //Log.debug.println("S_MODE:"+mode);

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA021WRK wrk = new YACA021WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA021_SHR(p_box, p_tr);
        }
        
        // 2013년도 S_MODE가 상세조회인 경우
        else if (mode.equals("SHR_13")) {
            wrk.YACA021_SHR_13(p_box, p_tr);
        }             
        
        // S_MODE가 상세조회인 경우
        else if (mode.equals("SHR_INFO")) {
            wrk.YACA021_SHR_INFO(p_box, p_tr);
        }

        // S_MODE가 상세조회인 경우
        else if (mode.equals("SHR_PER")) {
            wrk.YACA021_SHR_PER(p_box, p_tr);
        }
        
        // S_MODE가 상세조회인 경우
        else if (mode.equals("SHR_RENT")) {
            wrk.YACA021_SHR_RENT(p_box, p_tr);
        }        
        
        // S_MODE가 입력인 경우
        else if (mode.equals("INS")) {
            wrk.YACA021_INS(p_box, p_tr);
        }
        
        // S_MODE가 입력인 경우
        else if (mode.equals("SAV_PER")) {
            wrk.YACA021_SAV_PER(p_box, p_tr);
        }     
        // S_MODE가 입력인 경우
        else if (mode.equals("SAV_RENT")) {
            wrk.YACA021_SAV_RENT(p_box, p_tr);
        }           
        
        // S_MODE가 수정인 경우
        else if (mode.equals("UPT")) {
            wrk.YACA021_UPT(p_box, p_tr);
        }
        // S_MODE가 삭제인 경우
        else if (mode.equals("DEL")) {
            wrk.YACA021_DEL(p_box, p_tr);
        }
//      S_MODE가 삭제인 경우
        else if (mode.equals("ACC")) {
            wrk.YACA021_ACC(p_box, p_tr);
        }

        return null;
	}

}

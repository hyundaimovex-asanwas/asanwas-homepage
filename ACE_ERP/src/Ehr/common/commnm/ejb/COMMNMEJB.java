package Ehr.common.commnm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.commnm.wrk.COMMNMWRK;

public class COMMNMEJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public COMMNMEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		COMMNMWRK wrk = new COMMNMWRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 공통구분코드와 코드를 입력하면
			 * 해당 공통코드명을 조회해온다.
			 */
			wrk.COMMNM_SHR(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_06")) {
			/**
			 * 콤보박스 코드 변경(인사평가)
			 */
			wrk.COMMNM_SHR_06(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_07")) {
			/**
			 * 해당 소속의 부문을 가져온다
			 */
			wrk.COMMNM_SHR_07(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_00")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_00(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_DPT")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_DPT(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_DPT2")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_DPT2(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_DPT3")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_DPT3(box, trBox);
		}

		return null;
	}

}

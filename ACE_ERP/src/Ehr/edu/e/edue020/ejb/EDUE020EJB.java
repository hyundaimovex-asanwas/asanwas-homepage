package Ehr.edu.e.edue020.ejb;

import Ehr.edu.e.edue020.wrk.EDUE020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE020EJB extends EJB {
	
    public CBox box = null;
    public TrBox trBox = null;
    public EDUE020EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUE020WRK wrk = new EDUE020WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR_00")) {
			/**
			 * 과정개설요청서 화면에서 화면오픈시에
			 * 과정개설요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE020_SHR_00(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {
			/**
			 * 과정개설요청서 화면에서 저장버튼 클릭할 때
			 * 과정개설요청서 마감여부를 조회해온다. 
			 */
			wrk.EDUE020_SHR_01(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 과정개설요청서 화면에서 저장버튼을 클릭할 때,
			 * 과정개설요청서 데이터를 저장한다. 
			 */
			wrk.EDUE020_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("STS")) {
			/**
			 * 과정개설요청서 화면에서 상태를 변경할 때,
			 * 현재 상태를 저장한다. 
			 */
			wrk.EDUE020_UPT_00(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * 과정개설요청서 화면에서 삭제버튼을 클릭할 때,
			 * 과정개설요청서 데이터를 삭제한다. 
			 */
			wrk.EDUE020_DEL(box, trBox);
		}
		else if (box.get("S_MODE").equals("PROC")) {
			/**
			 * 과정개설요청서 화면에서 승인 할 때,
			 * 과정을 개설한다. 
			 */
			wrk.EDUE020_PROC(box, trBox);
		}

		return null;
	}

}

package Ehr.edu.e.edue032.ejb;

import Ehr.edu.e.edue032.wrk.EDUE032WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE032EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE032EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUE032WRK wrk = new EDUE032WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_ED")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_SHR_ED(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_DEL(box, trBox);
		}
		else if (box.get("S_MODE").equals("APP")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_APP(box, trBox);
		}

		return null;
	}


}

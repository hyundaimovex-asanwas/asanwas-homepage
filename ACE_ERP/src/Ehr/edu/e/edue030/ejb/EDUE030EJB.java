package Ehr.edu.e.edue030.ejb;

import Ehr.edu.e.edue030.wrk.EDUE030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE030EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE030EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EDUE030WRK wrk = new EDUE030WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 현재모집과정 화면에서 조회버튼을 클릭할 때,
			 * 현재모집과정 데이터를 조회해온다. 
			 */
			wrk.EDUE030_SHR(box, trBox);
		}

		return null;
	}

}

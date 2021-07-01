package hr.pir.a.pira010.ejb;

import hr.pir.a.pira010.wrk.PIRA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA010EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA010EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA010WRK wrk = new PIRA010WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 인사기록표 화면에서 조회버튼을 클릭할 때,
			 * 인사기록표 데이터를 조회해온다. 
			 */
			wrk.PIRA010_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_02")) {
			/**
			 * 인사기록표 화면에서 신입사원에 대한 저장버튼을 클릭할 때,
			 * 신입사원 정보를 반영하고 재조회해온다. 
			 */
			wrk.PIRA010_SHR_02(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 인사기록표 화면에서 저장버튼을 클릭할 때,
			 * 인사기록표 데이터를 입력 또는 수정한다. 
			 */
			wrk.PIRA010_SAV(box, trBox);
		}

		return null;
	}

}
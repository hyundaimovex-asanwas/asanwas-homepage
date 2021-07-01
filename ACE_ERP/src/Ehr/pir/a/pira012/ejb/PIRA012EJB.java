package hr.pir.a.pira012.ejb;

import hr.pir.a.pira012.wrk.PIRA012WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA012EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA012EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA012WRK wrk = new PIRA012WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 인사기본2 탭에서 화면 오픈시 또는 사번 변경시에
			 * 인사기록표 데이터를 조회해온다. 
			 */
			wrk.PIRA012_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 인사기본2 탭에서 저장버튼을 클릭할 때,
			 * 인사기록표 데이터를 입력 또는 수정한다. 
			 */
			wrk.PIRA012_SAV(box, trBox);
		}

		return null;
	}

}

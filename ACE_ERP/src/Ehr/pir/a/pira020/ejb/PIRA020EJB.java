package hr.pir.a.pira020.ejb;

import hr.pir.a.pira020.wrk.PIRA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA020EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA020EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA020WRK wrk = new PIRA020WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 자격면허 탭에서 화면 오픈시 또는 사번 변경시에
			 * 자격면허 데이터를 조회해온다. 
			 */
			wrk.PIRA020_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 자격면허 화면에서 저장버튼을 클릭할 때,
			 * 자격면허 데이터를 입력 또는 수정한다. 
			 */
			wrk.PIRA020_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * 자격면허 화면에서 삭제버튼을 클릭할 때,
			 * 자격면허 데이터를 삭제한다. 
			 */
			wrk.PIRA020_DEL(box, trBox);
		}

		return null;
	}

}

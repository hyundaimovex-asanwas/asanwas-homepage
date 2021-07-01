package hr.pir.a.pira031.ejb;

import hr.pir.a.pira031.wrk.PIRA031WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA031EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA031EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA031WRK wrk = new PIRA031WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 급여변경 탭에서 화면 오픈시 또는 사번 변경시에
			 * 급여변경 데이터를 조회해온다. 
			 */
			wrk.PIRA031_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_02")) {
			/**
			 * 급여변경 탭에서 테이블적용 버튼 클릭시
			 * 호봉표일자에 해당하는 호봉 자료를 조회해온다. 
			 */
			wrk.PIRA031_SHR_02(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 급여변경 화면에서 저장버튼을 클릭할 때,
			 * 급여변경 데이터를 입력 또는 수정한다. 
			 */
			wrk.PIRA031_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * 급여변경 화면에서 삭제버튼을 클릭할 때,
			 * 급여변경 데이터를 삭제한다. 
			 */
			wrk.PIRA031_DEL(box, trBox);
		}

		return null;
	}

}

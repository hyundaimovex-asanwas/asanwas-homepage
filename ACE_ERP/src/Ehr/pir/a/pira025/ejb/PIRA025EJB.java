package hr.pir.a.pira025.ejb;

import hr.pir.a.pira025.wrk.PIRA025WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA025EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA025EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA025WRK wrk = new PIRA025WRK();

		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) **/
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * 입사후경력 탭에서 화면 오픈시 또는 사번 변경시에
			 * 입사후경력 데이터를 조회해온다.
			 */
			wrk.PIRA025_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * 입사후경력 화면에서 저장버튼을 클릭할 때,
			 * 입사후경력 데이터를 입력 또는 수정한다.
			 */
			wrk.PIRA025_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * 입사후경력 화면에서 삭제버튼을 클릭할 때,
			 * 입사후경력 데이터를 삭제한다.
			 */
			wrk.PIRA025_DEL(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {
			/**
			 * 재입사여부 조회
			 */
			wrk.PIRA025_SHR_01(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV_01")) {
			/**
			 * 기존입사일 반영
			 */
			wrk.PIRA025_SAV_01(box, trBox);
		}

		return null;
	}


}

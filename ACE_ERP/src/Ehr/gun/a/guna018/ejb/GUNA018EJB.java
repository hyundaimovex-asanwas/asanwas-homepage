package hr.gun.a.guna018.ejb;

import hr.gun.a.guna018.wrk.GUNA018WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA018EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public GUNA018EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA018WRK wrk = new GUNA018WRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SHR")) {
			 //개인별 근태 현황을 조회해온다.
			wrk.GUNA018_SHR(box, trBox);
		}

		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SAV")) {
			 //개인별 근태 현황을 조회해온다.
			System.out.println("Next_msg = [1]");

			wrk.GUNA018_UPT(box, trBox);
		}

		return null;
	}

}
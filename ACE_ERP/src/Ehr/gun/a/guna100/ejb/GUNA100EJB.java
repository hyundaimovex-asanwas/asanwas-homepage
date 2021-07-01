package hr.gun.a.guna100.ejb;

import hr.gun.a.guna100.wrk.GUNA100WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA100EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public GUNA100EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA100WRK wrk = new GUNA100WRK();


		/** S_MOD : SHR(조회), SAV(저장) */
		if (box.get("S_MODE").equals("SHR")) {

			 //개인별 근태 집계 현황을 조회해온다.
			wrk.GUNA100_SHR(box, trBox);

		}else if (box.get("S_MODE").equals("SHR_02")) {
			 //개인별 근태 집계 현황 저장
			wrk.GUNA100_SHR_02(box, trBox);

		}else if (box.get("S_MODE").equals("SAV")) {
			 //개인별 근태 집계 현황 저장
			wrk.GUNA100_SAV(box, trBox);

		}

		return null;
	}

}
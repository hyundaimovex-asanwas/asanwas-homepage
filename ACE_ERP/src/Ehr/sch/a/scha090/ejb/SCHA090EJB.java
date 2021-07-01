package hr.sch.a.scha090.ejb;

import hr.sch.a.scha090.wrk.SCHA090WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SCHA090EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public SCHA090EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SCHA090WRK wrk = new SCHA090WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) */
		if (box.get("S_MODE").equals("SHR")) {
			 //학자금 신청기간 설정을 조회해온다. 
			wrk.SCHA090_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			 //학자금 신청기간 설정을 저장한다. 
			wrk.SCHA090_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			 //학자금 신청기간 설정을 삭제한다. 
			wrk.SCHA090_DEL(box, trBox);
		}

		return null;
	}

}
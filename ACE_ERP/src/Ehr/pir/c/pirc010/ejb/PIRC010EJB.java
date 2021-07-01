package hr.pir.c.pirc010.ejb;

import hr.pir.c.pirc010.wrk.PIRC010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRC010EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRC010EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRC010WRK wrk = new PIRC010WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (box.get("S_MODE").equals("SHR")) {
			 //인사기록표 데이터를 조회해온다. 
			wrk.PIRC010_SHR(box, trBox);
		}

		return null;
	}

}
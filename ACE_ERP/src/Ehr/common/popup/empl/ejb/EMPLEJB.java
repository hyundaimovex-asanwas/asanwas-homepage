package Ehr.common.popup.empl.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.empl.wrk.EMPLWRK;

public class EMPLEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EMPLEJB(CBox p_box, TrBox p_tr ) throws CException {		

		this.box = p_box;
		this.tr = p_tr;		

		System.out.println("p_box" + p_box);	
		//System.out.println("p_tr ======= " + p_tr);			
		
		
		EMPLWRK wrk = new EMPLWRK();
		
		if (box.get("S_MODE").equals("SHR")) {
			
			
			//조회를 위한 WORK메소드 호출
			wrk.EMPL_SHR(box, tr);
		}


	}
	
	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		
		EMPLWRK wrk = new EMPLWRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR")) {
			
			//조회를 위한 WORK메소드 호출
			wrk.EMPL_SHR(box, tr);
		}
		
		return null;
	}

}

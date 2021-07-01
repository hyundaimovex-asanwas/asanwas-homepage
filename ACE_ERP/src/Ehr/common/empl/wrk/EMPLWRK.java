package Ehr.common.empl.wrk;

import Ehr.common.empl.dao.EMPLDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class EMPLWRK {

	/**
	 * 성명 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EMPL_SHR(CBox p_box, TrBox p_tr) throws CException {
		
        EMPLDAO dao = new EMPLDAO("default", p_tr);
        
		dao.EMPL_SHR(p_box);
		
	}

	public void EMPL_SHR00(CBox p_box, TrBox p_tr) throws CException {
		
        EMPLDAO dao = new EMPLDAO("default", p_tr);
        
		dao.EMPL_SHR00(p_box);
		
	}		
	
	public void EMPL_SHR01(CBox p_box, TrBox p_tr) throws CException {
		
        EMPLDAO dao = new EMPLDAO("default", p_tr);
        
		dao.EMPL_SHR01(p_box);
		
	}	
	
	
	public void EMPL_SHR_DH(CBox p_box, TrBox p_tr) throws CException {
		
        EMPLDAO dao = new EMPLDAO("default", p_tr);
        
		dao.EMPL_SHR_DH(p_box);
		
	}
	
	public void EMPL_SHR_DPT(CBox p_box, TrBox p_tr) throws CException {
		
        EMPLDAO dao = new EMPLDAO("default", p_tr);
        
		dao.EMPL_SHR_DPT(p_box);
		
	}	
	
	
}

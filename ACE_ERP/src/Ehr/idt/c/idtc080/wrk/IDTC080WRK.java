package Ehr.idt.c.idtc080.wrk;

import Ehr.idt.c.idtc020.dao.IDTC020DAO;
import Ehr.idt.c.idtc080.dao.IDTC080DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTC080WRK {
	
	/**
	 * 주간업무보고 정보를 조회해 오는 WORK메소드.(인쇄용)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC080_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTC080DAO dao = new IDTC080DAO("default", p_tr);
		
		dao.IDTC080_SHR(p_box);
	}	
	
	
	public void IDTC080_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		IDTC080DAO dao = new IDTC080DAO("default", p_tr);
		
		dao.IDTC080_SHR_DTL(p_box);
	}		
	
	public void IDTC080_SHR_ALL(CBox p_box, TrBox p_tr) throws CException {

		IDTC080DAO dao = new IDTC080DAO("default", p_tr);
		
		dao.IDTC080_SHR_ALL(p_box);
	}		
	
 
}


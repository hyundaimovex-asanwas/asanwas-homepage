package Ehr.idt.c.idtc070.wrk;

import Ehr.idt.c.idtc020.dao.IDTC020DAO;
import Ehr.idt.c.idtc070.dao.IDTC070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTC070WRK {
	
	/**
	 * 주간업무보고 정보를 조회해 오는 WORK메소드.(인쇄용)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC070_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTC070DAO dao = new IDTC070DAO("default", p_tr);
		
		dao.IDTC070_SHR(p_box);
	}	
	
	
	public void IDTC070_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		IDTC070DAO dao = new IDTC070DAO("default", p_tr);
		
		dao.IDTC070_SHR_DTL(p_box);
	}		
	
    
	/**
	 * 주간업무보고 처리 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC070_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WF_WORKFORM2");
        
        GauceValueObject vo = null;
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		IDTC070DAO dao = new IDTC070DAO("default", p_tr);
        

        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);    // LIST -> ROW

                /**
                 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
                 *  - 1 : NORMAL
                 *  - 2 : INSERT
                 *  - 3 : UPDATE
                 *  - 4 : DELETE
                 */
    	        switch(vo.getInt("TX_MODE")) {
    		 	    case 1:

                        break;
                        
    			    case 2:

    			    	this.IDTC070_INS(vo, p_box, p_tr);
    			    	break;
    			    	
    			    case 3:

    			    	this.IDTC070_INS(vo, p_box, p_tr);
    				    break;
    				    
    			    case 4:

                        break;
    			}                

                
        }        

	}

	
	public void IDTC070_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		IDTC070DAO dao = new IDTC070DAO("default", p_tr);

		dao.IDTC070_INS(vo, p_box);

	}	
	


}


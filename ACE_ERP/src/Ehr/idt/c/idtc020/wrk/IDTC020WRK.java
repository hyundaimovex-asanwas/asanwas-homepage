package Ehr.idt.c.idtc020.wrk;

import Ehr.idt.c.idtc020.dao.IDTC020DAO;
import Ehr.vlu.o.vluo020.dao.VLUO020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTC020WRK {
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� WORK�޼ҵ�.(�μ��)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC020_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTC020DAO dao = new IDTC020DAO("default", p_tr);
		
		dao.IDTC020_SHR(p_box);
	}	
    
	
	
	/**
	 * ���� ��� ���� ������ ��ȸ�� ���� WORK�޼ҵ�.(�μ��)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC020_SHR_WEEK(CBox p_box, TrBox p_tr) throws CException {

		IDTC020DAO dao = new IDTC020DAO("default", p_tr);
		
		dao.IDTC020_SHR_WEEK(p_box);
	}	
    
	
	
	
	/**
	 * �ְ��������� ó�� ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC020_SAV(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WF_WORKFORM");
        
        GauceValueObject vo = null;

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		IDTC020DAO dao = new IDTC020DAO("default", p_tr);
		
        //�ش� ����� ��� ����Ÿ ����
        //dao.IDTC020_DEL(p_box);

        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);    // LIST -> ROW


                /**
                 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
                 *  - 1 : NORMAL
                 *  - 2 : INSERT
                 *  - 3 : UPDATE
                 *  - 4 : DELETE
                 */
    	        switch(vo.getInt("TX_MODE")) {
    		 	    case 1:

                        break;
                        
    			    case 2:

    			    	this.IDTC020_INS(vo, p_box, p_tr);
    			    	break;
    			    	
    			    case 3:

    			    	this.IDTC020_UPT(vo, p_box, p_tr);
    				    break;
    				    
    			    case 4:

                        break;
    			}                
                
                
                
                
        }
        
	}
	
	
	public void IDTC020_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		IDTC020DAO dao = new IDTC020DAO("default", p_tr);

		dao.IDTC020_INS(vo, p_box);

	}		
	
	public void IDTC020_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		IDTC020DAO dao = new IDTC020DAO("default", p_tr);

		dao.IDTC020_UPT(vo, p_box);

	}		
	

}


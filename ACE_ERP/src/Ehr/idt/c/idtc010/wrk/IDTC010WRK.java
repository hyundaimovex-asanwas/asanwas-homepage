package Ehr.idt.c.idtc010.wrk;

import Ehr.idt.c.idtc010.dao.IDTC010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTC010WRK {
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� WORK�޼ҵ�.(�μ��)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC010_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTC010DAO dao = new IDTC010DAO("default", p_tr);
		
		dao.IDTC010_SHR(p_box);
	}	
    
	/**
	 * �ְ��������� ó�� ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC010_SAV(CBox p_box, TrBox p_tr) throws CException {
		
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WF_WORKFORM");
        GauceValueObject vo = null;
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		IDTC010DAO dao = new IDTC010DAO("default", p_tr);
        
        //�ش� ����� ��� ����Ÿ ����
        dao.IDTC010_DEL_TEMP(p_box);
        
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);    // LIST -> ROW

            //üũ�ڽ��� ���õǾ� ������ ���
            if(vo.get("IS_CHK").equals("T")) {
                dao.IDTC010_INS_TEMP(vo, p_box);
            }
            
        }
        
	}
	
	

}


package Ehr.idt.a.idta010.wrk;

import Ehr.idt.a.idta010.dao.IDTA010DAO;
import Ehr.idt.a.idta030.dao.IDTA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTA010WRK {
	
	/**
	 * �����߱�ó�� ������ ��ȸ�� ���� WORK�޼ҵ�.(�μ��)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTA010DAO dao = new IDTA010DAO("default", p_tr);
		dao.IDTA010_SHR(p_box);
	}	
    
	/**
	 * �����߱� ó�� ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA010_SAV_TEMP(CBox p_box, TrBox p_tr) throws CException {
		
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ID_CEFBOOK");
        GauceValueObject vo = null;
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		IDTA010DAO dao = new IDTA010DAO("default", p_tr);
        
        //�ش� ����� ��� ����Ÿ ����
        dao.IDTA010_DEL_TEMP(p_box);
        
        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);    // LIST -> ROW
            
            //üũ�ڽ��� ���õǾ� ������ ���
            if(vo.get("IS_CHK").equals("T")) {
                dao.IDTA010_INS_TEMP(vo, p_box);
            }
        }
	}
	
	/**
	 * ��û������ �����߱�ó�� ������ ��� �߱޻��·� �����Ų��.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA010_PROC(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ID_CEFBOOK");
        GauceValueObject vo = null;
            
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
        IDTA030DAO dao = new IDTA030DAO("default", p_tr);
        
        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);    // LIST -> ROW
            
            //üũ�ڽ��� ���õǾ� ������ ���
            if(vo.get("IS_CHK").equals("T")) {
                
                vo.set("CEF_STS", "E");                             //�߱�
                vo.set("SPL_YMD", DateUtil.getCurrentDateStr());    //��û��¥
                
                dao.IDTA030_UPT(vo, p_box);
            }
        }
	}
}


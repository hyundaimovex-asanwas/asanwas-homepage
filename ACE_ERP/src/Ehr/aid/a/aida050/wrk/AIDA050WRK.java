package Ehr.aid.a.aida050.wrk;

import Ehr.aid.a.aida050.dao.AIDA050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class AIDA050WRK {
	
	/**
	 * ������� ���ޱ��� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA050_SHR(CBox p_box, TrBox p_tr) throws CException {

			AIDA050DAO dao = new AIDA050DAO("default", p_tr);
			
			dao.AIDA050_SHR(p_box);
			
	}
	
	/**
	 * ������� ���ޱ��� ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA050_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AD_AIDTRF");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		AIDA050DAO dao = new AIDA050DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {
				
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			/** 
				* Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
				case 2:
                    //�űԷ� ���
					dao.AIDA050_INS(vo, p_box);
                    break;
				case 3:
					// ������� ���ޱ��� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.AIDA050_UPT(vo, p_box);
					break;
				case 4:
					// delete;
                    dao.AIDA050_DEL(vo, p_box);
					break;					
			}
		}
	}
}


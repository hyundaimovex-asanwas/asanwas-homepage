package Ehr.vlu.k.vluk040.wrk;

import Ehr.vlu.k.vluk030.dao.VLUK030DAO;
import Ehr.vlu.k.vluk040.dao.VLUK040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK040WRK {

	public void VLUK040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUK040_SHR(p_box);
	}

	public void VLUK040_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

	   dao.VLUK040_SHR_01(p_box);
	}

	public void VLUK040_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUK040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					this.VLUK040_SAV(vo, p_box, p_tr);
					break;
					
				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					break;

				case 4:
					dao.VLUK040_DEL(vo, p_box);
					break;
			}
		}
	}
	
	public void VLUK040_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
		
        //�ʿ��� ���� ����
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

        dao.VLUK040_SAV(vo, p_box);		
		
	}	
	
	
	
}

package Ehr.vlu.l.vlul050.wrk;

import Ehr.vlu.l.vlul050.dao.VLUL050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUL050WRK {

	public void VLUL050_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUL050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUL050_SHR(p_box);
	}

	public void VLUL050_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUL050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

	   dao.VLUL050_SHR_01(p_box);
	}

	public void VLUL050_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUL050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

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
					//dao.VLUL050_SAV(vo, p_box);
					this.VLUL050_SAV(vo, p_box,p_tr);
					break;
				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					break;

				case 4:
					//dao.VLUL050_DEL(vo, p_box);
					this.VLUL050_DEL(vo, p_box,p_tr);					
					break;
			}
		}
	}
	
	public void VLUL050_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

        dao.VLUL050_SAV(vo, p_box);

	}		
	
	public void VLUL050_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

        dao.VLUL050_DEL(vo, p_box);

	}		
	
	
}

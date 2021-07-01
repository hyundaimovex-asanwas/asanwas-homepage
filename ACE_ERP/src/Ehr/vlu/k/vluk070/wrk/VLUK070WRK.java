package Ehr.vlu.k.vluk070.wrk;

import Ehr.vlu.k.vluk070.dao.VLUK070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK070WRK {

	/**
	 * �μ��� �ǰ���� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void VLUK070_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK070DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK070DAO dao = new VLUK070DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUK070_SHR(p_box);

	}

	/**
	 * �μ��� �ǰ���� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void VLUK070_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK070DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK070DAO dao = new VLUK070DAO("default", p_tr);

        /** ���κ�����Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
	   dao.VLUK070_SHR_01(p_box);

	}

	public void VLUK070_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUK070DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK070DAO dao = new VLUK070DAO("default", p_tr);

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
					dao.VLUK070_SAV(vo, p_box);

					break;
				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					break;

				case 4:
					dao.VLUK070_DEL(vo, p_box);
					break;
			}
		}

	}

}

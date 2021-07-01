package Ehr.vlu.k.vluk090.wrk;

import Ehr.vlu.k.vluk090.dao.VLUK090DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK090WRK {


	public void VLUK090_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUK090_SHR(p_box);
	}

	public void VLUK090_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_01(p_box);

	}

	public void VLUK090_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_02(p_box);

	}

	public void VLUK090_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_03(p_box);

	}

	public void VLUK090_SHR_04(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_04(p_box);

	}

	public void VLUK090_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_05(p_box);

	}

	public void VLUK090_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_06(p_box);

	}

	public void VLUK090_SHR_07(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

	   dao.VLUK090_SHR_07(p_box);

	}

	public void VLUK090_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		/** VLUI060DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

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
					break;

				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.VLUK090_SAV(vo, p_box);
					break;

				case 4:
					//dao.VLUK090_DEL(vo, p_box);
					break;
			}
		}

	}

	public void VLUK090_SAV_EXE(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUI060DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

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
					break;

				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.VLUK090_SAV_EXE(vo, p_box);
					break;

				case 4:
					//dao.VLUK090_DEL(vo, p_box);
					break;
			}
		}

	}

	public void VLUK090_SAV_GRD(CBox p_box, TrBox p_tr) throws CException {
		
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_GRADE2");

		/** VLUI060DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK090DAO dao = new VLUK090DAO("default", p_tr);

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
					break;

				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.VLUK090_SAV_GRD(vo, p_box);
					break;

				case 4:
					//dao.VLUK090_DEL(vo, p_box);
					break;
			}
		}

	}
}

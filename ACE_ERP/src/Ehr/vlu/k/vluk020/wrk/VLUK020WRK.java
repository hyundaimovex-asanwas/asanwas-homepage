package Ehr.vlu.k.vluk020.wrk;

import Ehr.vlu.k.vluk020.dao.VLUK020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK020WRK {


	public void VLUK020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

        /** ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUK020_SHR(p_box);

	}

	public void VLUK020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);


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

					//System.out.println(vo);
					//System.out.println(p_box);

					// ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.VLUK020_SAV(vo, p_box);
					break;
				case 3:
					// ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ
					dao.VLUK020_UPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;
				}
			}

	}

	/**
	 * ���ǥ ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK020_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 4:
//				 ���ǥ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
				dao.VLUK020_DEL(vo, p_box);
				break;

		}

		}
	}



	public void VLUK020_SHR_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

        /** ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUK020_SHR_DPT(p_box);

	}

	public void VLUK020_SAV_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);


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

					//System.out.println(vo);
					//System.out.println(p_box);

					// ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.VLUK020_SAV_DPT(vo, p_box);
					break;
				case 3:
					// ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ
					dao.VLUK020_UPT_DPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;
				}
			}

	}

	/**
	 * ���ǥ ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK020_DEL_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 4:
//				 ���ǥ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
				dao.VLUK020_DEL_DPT(vo, p_box);
				break;

		}

		}
	}
	
	
}

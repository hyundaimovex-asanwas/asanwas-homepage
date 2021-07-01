package Ehr.cod.e.code020.wrk;

import Ehr.cod.e.code020.dao.CODE020DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODE020WRK {

	/**
	 * �Ϸù�ȣ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** CODE020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE020DAO dao = new CODE020DAO("default", p_tr);

        /** �Ϸù�ȣ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE020_SHR_01(p_box);

	}

	/**
	 * �������� ������û�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** CODE020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE020DAO dao = new CODE020DAO("default", p_tr);

        /** �������� ������û SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE020_SHR_02(p_box);

	}

	/**
	 * �Ϸù�ȣ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE020_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** CODE020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE020DAO dao = new CODE020DAO("default", p_tr);

        /** �Ϸù�ȣ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE020_SHR_03(p_box);

	}
	/**
	 * �������� ������û�� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODE020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_UPRQST");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		CODE020DAO dao = new CODE020DAO("default", p_tr);

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
					// �������� ������û�� �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					dao.CODE020_INS(vo, p_box);
					break;

				case 3:
					// �������� ������û�� �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.CODE020_UPT(vo, p_box);
					break;

			}
		}
	}

	/**
	 * �������� ������û�� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODE020_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_UPRQST");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		CODE020DAO dao = new CODE020DAO("default", p_tr);


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
				case 4:
					// �������� ������û�� �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.CODE020_DEL(vo, p_box);
					break;

			}
		}

	}


}


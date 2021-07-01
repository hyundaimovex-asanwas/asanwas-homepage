package Ehr.pir.a.pira034.wrk;

import Ehr.pir.a.pira034.dao.PIRA034DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA034WRK {
	/**
	 * ������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA034_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA034DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA034DAO dao = new PIRA034DAO("default", p_tr);

        /** ������� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA034_SHR(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� ������� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA034_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ������� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA034DAO dao = new PIRA034DAO("default", p_tr);

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
					/** ������� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.PIRA034_INS(vo, p_box);
					break;

				case 3:
					/** ������� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA034_UPT(vo, p_box);
					break;

				case 4:
					//delete
					break;
			}
		}
	}

	/**
	 * Ʈ�������� �����Ͽ� ������� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA034_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ������� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA034DAO dao = new PIRA034DAO("default", p_tr);

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
					//insert
					break;

				case 3:
					//update
					break;

				case 4:
					/** ������� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA034_DEL(vo, p_box);
					break;
			}
		}
	}
}

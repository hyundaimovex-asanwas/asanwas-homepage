package Ehr.pir.a.pira031.wrk;

import Ehr.pir.a.pira031.dao.PIRA031DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA031WRK {
	/**
	 * �޿����� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA031_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA031DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA031DAO dao = new PIRA031DAO("default", p_tr);

        /** �޿����� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA031_SHR(p_box);

	}

	/**
	 * ȣ�����̺�  �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA031_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA031DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA031DAO dao = new PIRA031DAO("default", p_tr);

        /** ȣ�����̺� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA031_SHR_02(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� �޿����� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA031_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �޿����� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA031DAO dao = new PIRA031DAO("default", p_tr);

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
					
					/** �޿����� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					if(dao.PIRA031_SHR_COUNT(vo, p_box) >= 1){
						
						dao.PIRA031_UPT2(vo, p_box);	// �������ڼ���
						
					}
					
					dao.PIRA031_INS(vo, p_box);		//���� ���������� ����
					
					dao.PIRA031_UPT3(vo, p_box);	//���ο���, �ǷẸ�� ����
					
					break;

				case 3:
					
					/** �޿����� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA031_UPT3(vo, p_box);	//���ο���, �ǷẸ�� ��뺸�� ����
					
					break;

				case 4:
					//delete
					break;
			}
		}
	}

	/**
	 * Ʈ�������� �����Ͽ� �޿����� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA031_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �޿����� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA031DAO dao = new PIRA031DAO("default", p_tr);

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
					/** �޿����� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA031_DEL(vo, p_box);
					break;
			}
		}
	}
}

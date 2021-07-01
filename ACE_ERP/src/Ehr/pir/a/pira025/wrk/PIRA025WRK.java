package Ehr.pir.a.pira025.wrk;

import Ehr.pir.a.pira025.dao.PIRA025DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA025WRK {
	/**
	 * �Ի��İ�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA025_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA025DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

        /** �Ի��İ�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA025_SHR(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� �Ի��İ�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA025_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �Ի��İ�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);
		PIRA025DAO dao2 = new PIRA025DAO("default", p_tr);
		PIRA025DAO dao3 = new PIRA025DAO("default", p_tr);
		PIRA025DAO dao4 = new PIRA025DAO("default", p_tr);	
		PIRA025DAO dao5 = new PIRA025DAO("default", p_tr);			
		PIRA025DAO dao6 = new PIRA025DAO("default", p_tr);	
		PIRA025DAO dao7 = new PIRA025DAO("default", p_tr);			
		PIRA025DAO dao8 = new PIRA025DAO("default", p_tr);			
		
		//�Ի��İ���� �����Ҷ� �λ��������� ������ �űԻ���(�ӽ����̺��� �������� ���)
		GauceDataSet ds = dao.PIRA025_SHR_02(voList.get(0), p_box);

		if(ds.getDataRowCnt() == 0){
			
			dao2.PIRA025_INS_02(voList.get(0), p_box);//T_CM_PERSON
			
			dao3.PIRA025_INS_03(voList.get(0), p_box);//T_CM_EMPLIST
			
			dao6.PIRA025_INS_04(voList.get(0), p_box);//PAYROLL.HIPSERN 2019.04.18 �̵��� �߰�	
			
			dao7.PIRA025_INS_05(voList.get(0), p_box);//COMMON.GD0080, COMMON.MENU_AUTH 2019.04.18 �̵��� �߰�	
						
			dao8.PIRA025_INS_06(voList.get(0), p_box);//T_DI_MONTHLY_HISTORY 2019.05.02 �̵��� �߰�				
			
		}

		for (int i=voList.size()-1; i>=0; i--) {//�������� �����ؾ���

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
					/** �Ի��İ�� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */

					dao4.PIRA025_INS(vo, p_box);
					
					dao5.PIRA025_INS_01(vo, p_box, "1");

					break;

				case 3:
					/** �Ի��İ�� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					
					dao4.PIRA025_UPT(vo, p_box);
					
					dao5.PIRA025_INS_01(vo, p_box, "2");

					break;

				case 4:
					//delete
					break;
			}
		}
	}

	/**
	 * Ʈ�������� �����Ͽ� �Ի��İ�� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA025_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �Ի��İ�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

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
					/** �Ի��İ�� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA025_INS_01(vo, p_box, "3");
					break;
			}
		}
	}

	/**
	 * ���Ի翩�� ��ȸ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA025_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA025DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

        /** �Ի��İ�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA025_SHR_01(p_box);

	}

	/**
	 * �����Ի��� �ݿ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA025_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

		GauceValueObject vo1 = voList.get(0);	// ���Ի�����
		GauceValueObject vo2 = voList.get(1);	// �����Ի�����

		dao.PIRA025_UPT_01(vo1, vo2, p_box);

	}
}

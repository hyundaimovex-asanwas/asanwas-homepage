package Ehr.edu.g.edug030.wrk;

import Ehr.edu.g.edug030.dao.EDUG030DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUG030WRK {
	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR(p_box);

	}

	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR_01(p_box);

	}

	public void EDUG030_SHR_31(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR_31(p_box);

	}	
	
	public void EDUG030_SHR_32(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR_32(p_box);

	}	
	
	public void EDUG030_SHR_33(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR_33(p_box);

	}	
	
	public void EDUG030_SHR_34(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR_34(p_box);

	}	
	
	public void EDUG030_SHR_35(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG030_SHR_35(p_box);

	}	
	
	/**
	 * Ʈ�������� �����Ͽ� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

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
					dao.EDUG030_INS(vo, p_box);
					break;

				case 3:

					/** UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUG030_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}

	/**
	 * Ʈ�������� �����Ͽ� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_SAV_01( CBox p_box, TrBox p_tr ) throws CException {


		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);
		EDUG030DAO dao2 = new EDUG030DAO("default", p_tr);
		
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
					dao.EDUG030_SUB(vo, p_box);
					dao2.EDUG030_SUB2(vo, p_box);					
					break;

				case 3:

					/** UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					//dao.EDUG030_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}	
	
	/**
	 * Ʈ�������� �����Ͽ� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_SAV_32( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

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
					//dao.EDUG030_INS(vo, p_box);
					break;

				case 3:

					/** UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUG030_UPT2(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}

	
	/**
	 * Ʈ�������� �����Ͽ� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_SAV_33( CBox p_box, TrBox p_tr ) throws CException {


		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);
		EDUG030DAO dao2 = new EDUG030DAO("default", p_tr);
		
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
					dao.EDUG030_ACC(vo, p_box);
					dao2.EDUG030_ACC2(vo, p_box);					
					break;

				case 3:

					/** UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					//dao.EDUG030_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}	
	
	/**
	 * Ʈ�������� �����Ͽ� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG030_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG030DAO dao = new EDUG030DAO("default", p_tr);

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

					/** DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.EDUG030_DEL(vo, p_box);
					break;
			}
		}
	}
	

}

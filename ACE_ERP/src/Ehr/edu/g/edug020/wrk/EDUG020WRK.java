package Ehr.edu.g.edug020.wrk;

import Ehr.edu.g.edug020.dao.EDUG020DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUG020WRK {
	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG020_SHR(p_box);

	}

	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG020_SHR_01(p_box);

	}

	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG020_SHR_21(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG020_SHR_21(p_box);

	}	
	
	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG020_SHR_22(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		p_tr.setOutDataSet("SHR_22",  dao.EDUG020_SHR_22(p_box));

	}		
	
	/**
	 * Ʈ�������� �����Ͽ� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);

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
					dao.EDUG020_INS(vo, p_box);
//					dao.EDUG020_INS_OBJT(vo, p_box);
					break;

				case 3:

					/** ����������û��UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUG020_UPT(vo, p_box);
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
	public void EDUG020_UPT_00( CBox p_box, TrBox p_tr ) throws CException {
		
		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("STS");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);
		
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
				break;
				
			case 3:
				dao.EDUG020_UPT_00(vo, p_box);
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
	public void EDUG020_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG020DAO dao = new EDUG020DAO("default", p_tr);

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
					dao.EDUG020_DEL(vo, p_box);
					break;
			}
		}
	}
	

}

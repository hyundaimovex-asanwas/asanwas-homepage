package Ehr.edu.g.edug010.wrk;

import Ehr.edu.g.edug010.dao.EDUG010DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUG010WRK {
	
	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG010DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUG010DAO dao = new EDUG010DAO("default", p_tr);

        /** ����������û�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUG010_SHR(p_box);

	}


	/**
	 * Ʈ�������� �����Ͽ� ����������û�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ����������û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG010DAO dao = new EDUG010DAO("default", p_tr);

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
					dao.EDUG010_INS(vo, p_box);
					break;

				case 3:

					/** UPDATE�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUG010_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}


	/**
	 * Ʈ�������� �����Ͽ� ����������û�� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUG010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ����������û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUG010DAO dao = new EDUG010DAO("default", p_tr);

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

					/** ����������û�� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.EDUG010_DEL(vo, p_box);
					break;
			}
		}
	}
	

}

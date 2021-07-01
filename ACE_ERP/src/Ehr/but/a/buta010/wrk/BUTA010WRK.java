package Ehr.but.a.buta010.wrk;

import Ehr.but.a.buta010.dao.BUTA010DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class BUTA010WRK {

	/**
	 * ����ǰ�� ��Ȳ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA010_SHR(CBox p_box, TrBox p_tr) throws CException {

			BUTA010DAO dao = new BUTA010DAO("default", p_tr);
			
			dao.BUTA010_SHR(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� ����ǰ�� ��Ȳ���� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BUTA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA010DAO dao = new BUTA010DAO("default", p_tr);
		BUTA010DAO dao2 = new BUTA010DAO("default", p_tr);
		BUTA010DAO dao3 = new BUTA010DAO("default", p_tr);
		BUTA010DAO dao4 = new BUTA010DAO("default", p_tr);
		
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

					//����ǰ�Ǽ� ������ ���� DAO �޼ҵ� ȣ��
					dao.BUTA010_DEL_01(vo, p_box);
					
					//����ǰ�Ǽ� ������Ȳ ������ ���� DAO �޼ҵ� ȣ��
					dao2.BUTA010_DEL_02(vo, p_box);
					
					//�����꼭 ������ ���� DAO �޼ҵ� ȣ��
					dao3.BUTA010_DEL_03(vo, p_box);
					
					//��������� ���� ������ ���� DAO �޼ҵ� ȣ��
					dao4.BUTA010_DEL_04(vo, p_box);

					break;
					
			}
			
		}
		
	}

	

}

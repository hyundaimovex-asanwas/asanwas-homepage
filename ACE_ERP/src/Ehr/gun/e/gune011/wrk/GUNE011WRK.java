package Ehr.gun.e.gune011.wrk;


import Ehr.gun.e.gune011.dao.GUNE011DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUNE011WRK {

	/**
	 * ����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE011_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNE011DAO dao = new GUNE011DAO("default", p_tr);
			
			dao.GUNE011_SHR(p_box);

	}

	/**
	 * Ʈ�������� �����Ͽ� ����ǰ�� ��Ȳ���� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNE011_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNE011DAO dao = new GUNE011DAO("default", p_tr);
		GUNE011DAO dao2 = new GUNE011DAO("default", p_tr);
		GUNE011DAO dao3 = new GUNE011DAO("default", p_tr);
		GUNE011DAO dao4 = new GUNE011DAO("default", p_tr);
		
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

					//����ٹ� ������ ���� DAO �޼ҵ� ȣ��
					dao.GUNE011_DEL_01(vo, p_box);
				
					break;
					
			}
			
		}
		
	}

	

}

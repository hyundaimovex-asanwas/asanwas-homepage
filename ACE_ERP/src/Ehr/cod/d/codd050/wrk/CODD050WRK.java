package Ehr.cod.d.codd050.wrk;

import Ehr.cod.d.codd050.dao.CODD050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODD050WRK {

    /**
     * ��Ȯ�� �޼��� ���� ��ȸ WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void CODD050_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��Ȯ�� �޼��� DAO CLASS �޼��� ȣ�� * */
		CODD050DAO dao = new CODD050DAO("default", p_tr);

		dao.CODD050_SHR(p_box);

	}

	/**
	 * ��Ȯ�� �޼��� Ȯ��ó�� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODD050_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AA_MESSAGE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		CODD050DAO dao = new CODD050DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
				case 2:
					// Ȯ��ó���ϱ� ���� DAO�޼ҵ� ȣ��
					this.CODD050_UPT(vo, p_box, p_tr);					
					break;
				case 3:
					break;
			}
		}
	}	
	
	
	public void CODD050_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODD050DAO dao = new CODD050DAO("default", p_tr);

		dao.CODD050_UPT(vo, p_box);

	}	
	
	
}

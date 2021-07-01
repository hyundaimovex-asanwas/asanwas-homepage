package Ehr.gun.d.gund030.wrk;

import Ehr.gun.d.gund030.dao.GUND030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND030WRK {

	/**
	 * �����߻����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND030_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUND030DAO dao = new GUND030DAO("default", p_tr);
			dao.GUND030_SHR(p_box);

	}

	/**
	 * �����߻����� �ϰ������ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND030_INS(CBox p_box, TrBox p_tr) throws CException {

		GUND030DAO dao = new GUND030DAO("default", p_tr);
		GUND030DAO dao2 = new GUND030DAO("default", p_tr);
		
		//�űԻ���
		dao.GUND030_INS(p_box);

		//��ȸ
		dao2.GUND030_SHR(p_box);

	}

	/**
	 * �����߻����� ������ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND030_UPT(CBox p_box, TrBox p_tr) throws CException {

		GUND030DAO dao = new GUND030DAO("default", p_tr);
		GUND030DAO dao2 = new GUND030DAO("default", p_tr);
		GUND030DAO dao3 = new GUND030DAO("default", p_tr);		
		
		//�űԻ����� ���� ����
		dao.GUND030_DEL(p_box);

		//�űԻ���
		dao2.GUND030_INS(p_box);

		//��ȸ
		dao3.GUND030_SHR(p_box);

	}

	/**
	 * �����߻������� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUND030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_YEARLY");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUND030DAO dao = new GUND030DAO("default", p_tr);

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
					// insert
					break;
				case 3:
					// �����߻������� �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.GUND030_UPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;
				}
			}
	}

}

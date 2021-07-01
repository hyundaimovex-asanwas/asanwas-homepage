package Ehr.sag.e.sage010.wrk;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.sag.e.sage010.dao.SAGE010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class SAGE010WRK {

	/**
	 * ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

		dao.SAGE010_SHR(p_box);

	}

	/**
	 * �Ҽ� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

		dao.SAGE010_SHR_01(p_box);

	}


	/**
	 * ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGE010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SI_DILIGENCE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

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
					// ������Ȳ�� �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.SAGE010_UPT(p_box,vo,p_tr);
					break;
				case 4:
					// delete;
					break;
			}
		}
	}
	
	
	public void SAGE010_UPT(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

		dao.SAGE010_UPT(p_box, vo);

	}			


}

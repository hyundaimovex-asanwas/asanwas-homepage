package Ehr.cod.f.codf010.wrk;

import Ehr.cod.f.codf010.dao.CODF010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODF010WRK {

	/**
	 * Ʈ����ȸ[FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODF010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		CODF010DAO dao = new CODF010DAO("default", p_tr);
		dao.CODF010_SHR(p_box);

	}

	/**
	 * �����ڵ� �� ��ȸ  [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODF010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		CODF010DAO dao = new CODF010DAO("default", p_tr);
		dao.CODF010_SHR_01(p_box);

	}

	/**
	 * ���������� �ϳ��� ������ ȸ�������� �ִ´�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODF010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODF010DAO dao = new CODF010DAO("default", p_tr);

		//���������� �ϳ��� ������ ȸ�������� �ѹ��� �ֱ⶧���� insert�� �ѹ� ���
		dao.CODF010_INS(p_box);

	}

	/**
	 * �����ڵ� ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODF010_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DUTYMST");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODF010DAO dao = new CODF010DAO("default", p_tr);

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
					// insert;
					dao.CODF010_INS_01(p_box, vo);
					//���������� ������������ update�Ѵ�.(���������� �������� �ִٰ� update)
					dao.CODF010_UPT_02(p_box, vo);
					break;
				case 3:
					// update;
					dao.CODF010_UPT_01(p_box, vo);
					break;
				case 4:
					// delete;
					break;
			}
		}

	}
	/**
	 * �����ڵ� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODF010_DEL_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DUTYMST");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODF010DAO dao = new CODF010DAO("default", p_tr);

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
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.CODF010_DEL_01(p_box, vo);
				//���������� ������������ update�Ѵ�.(���������� �������� ���ٰ� update)
				dao.CODF010_UPT_03(p_box, vo);
				break;
			}
		}

	}
}

package hr.cod.a.coda010.wrk;

import hr.cod.a.coda010.dao.CODA010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODA010WRK {

	/**
	 * �������� ��ȸ[FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		CODA010DAO dao = new CODA010DAO("default", p_tr);
		dao.CODA010_SHR(p_box);

	}

	/**
	 * �������� ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODA010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_COMPANY");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODA010DAO dao = new CODA010DAO("default", p_tr);

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
					dao.CODA010_INS(p_box, vo);
					break;
				case 3:
					// update;
					dao.CODA010_UPT(p_box, vo);
					break;
				case 4:
					// delete;
					//dao.CODA010_DEL(p_box, vo);
					break;
			}
		}

	}

}

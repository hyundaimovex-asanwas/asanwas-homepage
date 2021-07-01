package Ehr.edu.h.eduh032.wrk;

import Ehr.edu.h.eduh032.dao.EDUH032DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUH032WRK {
	/**
	 * ������������ �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUH032_SHR(CBox p_box, TrBox p_tr) throws CException {
		EDUH032DAO dao = new EDUH032DAO("default", p_tr);
		dao.EDUH032_SHR(p_box);
	}

    /**
     * ���ο� ������ ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void EDUH032_SHR_CHASU(CBox p_box, TrBox p_tr) throws CException {
	    EDUH032DAO dao = new EDUH032DAO("default", p_tr);
	    //System.out.print(p_box);
	    dao.EDUH032_SHR_CHASU(p_box);
	}


	/**
     * �űԹ�ư Ŭ���� ������ ������ ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void EDUH032_SHR_NEW(CBox p_box, TrBox p_tr) throws CException {
		EDUH032DAO dao = new EDUH032DAO("default", p_tr);
		dao.EDUH032_SHR_NEW(p_box);
	}

	/**
	 * Ʈ�������� �����Ͽ� ������������ �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUH032_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		EDUH032DAO dao = new EDUH032DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
				case 2:
					dao.EDUH032_INS(vo, p_box);
					break;

				case 3:
					dao.EDUH032_UPT(vo, p_box);
					break;
                case 4:
                    dao.EDUH032_DEL(vo, p_box);
                    break;
			}
		}
	}
}

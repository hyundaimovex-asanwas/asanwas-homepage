package Ehr.edu.e.edue033.wrk;

import Ehr.edu.e.edue033.dao.EDUE033DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUE033WRK {
	
	private EDUE033DAO dao = null;
	private String connectionName = "default";   
	
	public void EDUE033_SHR(CBox p_box, TrBox p_tr) throws CException {
		//EDUE033DAO dao = new EDUE033DAO("default", p_tr);
		dao = new EDUE033DAO(connectionName, p_tr);
		dao.EDUE033_SHR(p_box);
	}
	
    /**
     * ���ο� ������ ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	/*public void EDUE033_SHR_CHASU(CBox p_box, TrBox p_tr) throws CException {
	    EDUE033DAO dao = new EDUE033DAO("default", p_tr);
	    dao.EDUE033_SHR_CHASU(p_box);
	}*/


	/**
     * �űԹ�ư Ŭ���� ������ ������ ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void EDUE033_SHR_NEW(CBox p_box, TrBox p_tr) throws CException {
		//EDUE033DAO dao = new EDUE033DAO("default", p_tr);
		dao = new EDUE033DAO(connectionName, p_tr);
		dao.EDUE033_SHR_NEW(p_box);
	}

	/**
	 * Ʈ�������� �����Ͽ� ������������ �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE033_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		//EDUE033DAO dao = new EDUE033DAO("default", p_tr);
		dao = new EDUE033DAO(connectionName, p_tr);

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
					dao.EDUE033_INS(vo, p_box);
					break;

			}
		}
	}
}

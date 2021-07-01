package Ehr.pir.c.pirc011.wrk;

import Ehr.pir.c.pirc011.dao.PIRC011DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRC011WRK {

	/**
	 * �λ���ǥ �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRC011_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC011DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRC011DAO dao = new PIRC011DAO("default", p_tr);

        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRC011_SHR(p_box);

	}
	
}

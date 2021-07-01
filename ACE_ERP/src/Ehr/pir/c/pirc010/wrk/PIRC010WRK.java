package Ehr.pir.c.pirc010.wrk;

import Ehr.pir.c.pirc010.dao.PIRC010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRC010WRK {

	/**
	 * �������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRC010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC010DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRC010DAO dao = new PIRC010DAO("default", p_tr);

        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRC010_SHR(p_box);

	}
	
}


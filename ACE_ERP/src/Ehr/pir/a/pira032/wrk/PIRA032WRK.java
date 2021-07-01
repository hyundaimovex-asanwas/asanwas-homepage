package Ehr.pir.a.pira032.wrk;

import Ehr.pir.a.pira032.dao.PIRA032DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA032WRK {
	/**
	 * �з»��� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA032_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA032DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA032DAO dao = new PIRA032DAO("default", p_tr);

        /** �з»��� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA032_SHR(p_box);

	}
}

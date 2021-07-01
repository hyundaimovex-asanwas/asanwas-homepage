package Ehr.edu.e.edue051.wrk;

import Ehr.edu.e.edue051.dao.EDUE051DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE051WRK {
	/**
	 * �������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE051_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE051DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUE051DAO dao = new EDUE051DAO("default", p_tr);

        /** �������� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUE051_SHR(p_box);

	}
}

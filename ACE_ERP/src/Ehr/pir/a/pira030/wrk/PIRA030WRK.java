package Ehr.pir.a.pira030.wrk;

import Ehr.pir.a.pira030.dao.PIRA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA030WRK {
	/**
	 * �������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA030DAO dao = new PIRA030DAO("default", p_tr);

        /** �������� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA030_SHR(p_box);

	}
}

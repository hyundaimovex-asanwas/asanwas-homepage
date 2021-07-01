package Ehr.edu.e.edue030.wrk;

import Ehr.edu.e.edue030.dao.EDUE030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE030WRK {
	/**
	 * ����������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EDUE030DAO dao = new EDUE030DAO("default", p_tr);

        /** ����������� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EDUE030_SHR(p_box);

	}
}

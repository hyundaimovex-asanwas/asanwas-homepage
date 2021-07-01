package Ehr.pir.a.pira023.wrk;

import Ehr.pir.a.pira023.dao.PIRA023DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA023WRK {
	/**
	 * �ؿ����� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA023_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA023DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA023DAO dao = new PIRA023DAO("default", p_tr);

        /** �ؿ����� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA023_SHR(p_box);

	}
}

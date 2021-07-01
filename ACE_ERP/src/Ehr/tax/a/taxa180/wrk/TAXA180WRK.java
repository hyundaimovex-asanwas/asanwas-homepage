package Ehr.tax.a.taxa180.wrk;

import Ehr.tax.a.taxa180.dao.TAXA180DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class TAXA180WRK {
	/**
	 * �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void TAXA180_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** TAXA180DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		TAXA180DAO dao = new TAXA180DAO("default", p_tr);

		/** ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.TAXA180_SHR(p_box);

	}

	public void TAXA180_SHR2(CBox p_box, TrBox p_tr) throws CException {

		/** TAXA180DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		TAXA180DAO dao = new TAXA180DAO("default", p_tr);

		/** ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.TAXA180_SHR2(p_box);

	}	
	
}

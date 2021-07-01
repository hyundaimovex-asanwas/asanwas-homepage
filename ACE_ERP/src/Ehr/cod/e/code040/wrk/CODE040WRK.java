package Ehr.cod.e.code040.wrk;

import Ehr.cod.e.code040.dao.CODE040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODE040WRK {

	/**
	 * �������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE040DAO dao = new CODE040DAO("default", p_tr);

        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE040_SHR(p_box);
	}

	public void CODE040_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** PIRC090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE040DAO dao = new CODE040DAO("default", p_tr);
		
		dao.CODE040_UPT(p_box, null);

	}
}




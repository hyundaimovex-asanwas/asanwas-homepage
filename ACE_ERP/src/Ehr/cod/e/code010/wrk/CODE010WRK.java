package Ehr.cod.e.code010.wrk;

import Ehr.cod.e.code010.dao.CODE010DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class CODE010WRK {

	/**
	 * �Ϸù�ȣ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE010_SHR_ACC(CBox p_box, TrBox p_tr) throws CException {

		/** CODE010DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE010DAO dao = new CODE010DAO("default", p_tr);

        /** �Ϸù�ȣ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE010_SHR_ACC(p_box);

	}

}


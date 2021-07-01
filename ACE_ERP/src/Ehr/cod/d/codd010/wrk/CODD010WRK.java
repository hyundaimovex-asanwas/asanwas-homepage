package Ehr.cod.d.codd010.wrk;

import Ehr.cod.d.codd010.dao.CODD010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODD010WRK {

    /**
     * ���α׷� ��� �α� ���� ��ȸ WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void CODD010_SHR(CBox p_box, TrBox p_tr) throws CException {

		
        /** DAO Class ��ü ������ ���α׷� ��� �α� ����(��ȸ) DAO CLASS �޼��� ȣ�� * */
		CODD010DAO dao = new CODD010DAO("default", p_tr);

		dao.CODD010_SHR(p_box);

	}

}

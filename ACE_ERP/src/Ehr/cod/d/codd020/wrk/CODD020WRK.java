package Ehr.cod.d.codd020.wrk;

import Ehr.cod.d.codd020.dao.CODD020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODD020WRK {

    /**
     * ���α׷� ��� �α� ���� ��ȸ WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void CODD020_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���α׷� ��� �α� ����(��ȸ) DAO CLASS �޼��� ȣ�� * */
		CODD020DAO dao = new CODD020DAO("default", p_tr);
		
		dao.CODD020_SHR(p_box);

	}

}

package common.menu.accesslog.wrk;

import common.menu.accesslog.dao.ACCESSLOGDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class ACCESSLOGWRK {

    /**
     * ���α׷� ��� �α� ���� ���� WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void ACCESSLOG_SAV(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���α׷� ��� �α� ����(����) DAO CLASS �޼��� ȣ�� * */
		ACCESSLOGDAO dao = new ACCESSLOGDAO("default", p_tr);
		dao.ACCESSLOG_INS(p_box);

	}

	

}

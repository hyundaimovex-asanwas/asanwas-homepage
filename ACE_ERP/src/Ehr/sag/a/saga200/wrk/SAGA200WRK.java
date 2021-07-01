package Ehr.sag.a.saga200.wrk;

import Ehr.sag.a.saga200.dao.SAGA200DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class SAGA200WRK {

	/**
	 * �޿����̺� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA200_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA200DAO dao = new SAGA200DAO("default", p_tr);
		
		dao.SAGA200_SHR(p_box);

	}

	/**
	 * �޿����̺� �������� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA200_SHR_ALL(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA200DAO dao = new SAGA200DAO("default", p_tr);
		
		dao.SAGA200_SHR_ALL(p_box);

	}


}

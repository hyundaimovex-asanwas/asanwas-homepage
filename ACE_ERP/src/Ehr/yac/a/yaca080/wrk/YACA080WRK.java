package Ehr.yac.a.yaca080.wrk;

import Ehr.yac.a.yaca080.dao.YACA080DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA080WRK {

	/**
	 * ����Ÿ��ȿ��üũ ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA080_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		YACA080DAO dao = new YACA080DAO("default", p_tr);
		dao.YACA080_SHR(p_box);

	}
	
	
	/**
	 * ����Ÿ��ȿ��üũ ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA080_SHR_15(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		YACA080DAO dao = new YACA080DAO("default", p_tr);
		dao.YACA080_SHR_15(p_box);

	}

}

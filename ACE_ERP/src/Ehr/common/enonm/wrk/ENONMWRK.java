package Ehr.common.enonm.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.enonm.dao.ENONMDAO;

public class ENONMWRK {
	/**
	 * ���� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ENONM_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUH051DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		ENONMDAO dao = new ENONMDAO("default", p_tr);

        if (p_box.get("GBN").equals("0") || p_box.get("GBN").equals("2")) {
			/** ������ �Ǵ� �İ߻��  SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.ENONM_SHR(p_box);
		}
		else {
            /** EMPLIST(��ü���) SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.ENONM_SHR_02(p_box);
		}

	}
	
	/**
	 * ��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ENONM_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** EDUH051DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		ENONMDAO dao = new ENONMDAO("default", p_tr);

        if (p_box.get("GBN").equals("0") || p_box.get("GBN").equals("2")) {
			/** ������ �Ǵ� �İ߻��  SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.ENONM_SHR_03(p_box);
		}
		else {
            /** EMPLIST(��ü���) SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.ENONM_SHR_04(p_box);
		}

	}
}

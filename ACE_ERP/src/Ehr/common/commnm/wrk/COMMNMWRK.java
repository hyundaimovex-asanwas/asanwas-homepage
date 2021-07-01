package Ehr.common.commnm.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.commnm.dao.COMMNMDAO;

public class COMMNMWRK {
	/**
	 * �����ڵ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUH051DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		COMMNMDAO dao = new COMMNMDAO("default", p_tr);

		if (p_box.get("CD_GBN").equals("A4") || p_box.get("CD_GBN").equals("A6") || p_box.get("CD_GBN").equals("B2")) {
			/** �μ�/��/���θ� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.COMMNM_SHR_02(p_box);
		}
		else if (p_box.get("CD_GBN").equals("DUTY")) {
        	/** �����ڵ� SELECT DAO �޼ҵ� ȣ�� */
        	dao.COMMNM_SHR_03(p_box);
        }
        else if (p_box.get("CD_GBN").equals("DUTY2")) {
        	/** �����ڵ� SELECT DAO �޼ҵ� ȣ�� */
        	dao.COMMNM_SHR_04(p_box);
        }
		else {
            /** �����ڵ�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.COMMNM_SHR(p_box);
		}

	}

	//�޺��ڽ� �ڵ� ����(�λ���)
	public void COMMNM_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);

		//p_box.get("CD_GBN") == B2
		dao.COMMNM_SHR_06(p_box);
	}

	//�ش� �Ҽ��� �ι��� �����´�
	public void COMMNM_SHR_07(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);

		//p_box.get("CD_GBN") == A4
		dao.COMMNM_SHR_07(p_box);
	}

	/**
     * �����ڵ带 ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
	 */
	public void COMMNM_SHR_00(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    //p_box.get("CD_GBN") == A4
	    dao.COMMNM_SHR_00(p_box);
	}

	/**
     * �μ��ڵ带 ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
	 */
	public void COMMNM_SHR_DPT(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    dao.COMMNM_SHR_DPT(p_box);
	}
	public void COMMNM_SHR_DPT2(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    dao.COMMNM_SHR_DPT2(p_box);
	}
	public void COMMNM_SHR_DPT3(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    dao.COMMNM_SHR_DPT3(p_box);
	}
}

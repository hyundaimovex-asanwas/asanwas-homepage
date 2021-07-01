package Ehr.common.commnm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.commnm.wrk.COMMNMWRK;

public class COMMNMEJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public COMMNMEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		COMMNMWRK wrk = new COMMNMWRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ���뱸���ڵ�� �ڵ带 �Է��ϸ�
			 * �ش� �����ڵ���� ��ȸ�ؿ´�.
			 */
			wrk.COMMNM_SHR(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_06")) {
			/**
			 * �޺��ڽ� �ڵ� ����(�λ���)
			 */
			wrk.COMMNM_SHR_06(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_07")) {
			/**
			 * �ش� �Ҽ��� �ι��� �����´�
			 */
			wrk.COMMNM_SHR_07(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_00")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_00(box, trBox);
		}

		else if (box.get("S_MODE").equals("SHR_DPT")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_DPT(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_DPT2")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_DPT2(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_DPT3")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_DPT3(box, trBox);
		}

		return null;
	}

}

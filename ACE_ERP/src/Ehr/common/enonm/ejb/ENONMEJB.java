package common.enonm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.enonm.wrk.ENONMWRK;

public class ENONMEJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public ENONMEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		ENONMWRK wrk = new ENONMWRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ����� �Է��ϸ� �ش� ������� ��ȸ�ؿ´�.
			 */
			wrk.ENONM_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {
			/**
			 * ���� �Է��ϸ� �ش� ����� ��ȸ�ؿ´�.
			 */
			wrk.ENONM_SHR_01(box, trBox);
		}
		
		return null;
	}

}

package Ehr.edu.e.edue021.ejb;

import Ehr.edu.e.edue021.wrk.EDUE021WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE021EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE021EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE021WRK wrk = new EDUE021WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE021_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE021_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE021_DEL(box, trBox);
		}

		return null;
	}


}

package Ehr.edu.e.edue032.ejb;

import Ehr.edu.e.edue032.wrk.EDUE032WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE032EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE032EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE032WRK wrk = new EDUE032WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_ED")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_SHR_ED(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_DEL(box, trBox);
		}
		else if (box.get("S_MODE").equals("APP")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_APP(box, trBox);
		}

		return null;
	}


}

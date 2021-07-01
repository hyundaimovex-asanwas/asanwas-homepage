package Ehr.edu.e.edue051.ejb;

import Ehr.edu.e.edue051.wrk.EDUE051WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE051EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE051EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE051WRK wrk = new EDUE051WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �������� ȭ�鿡�� ȭ����½� 
			 * �������� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE051_SHR(box, trBox);
		}

		return null;
	}

}

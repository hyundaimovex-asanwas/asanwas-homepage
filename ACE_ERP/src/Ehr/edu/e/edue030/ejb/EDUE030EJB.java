package Ehr.edu.e.edue030.ejb;

import Ehr.edu.e.edue030.wrk.EDUE030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE030EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public EDUE030EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE030WRK wrk = new EDUE030WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ����������� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ����������� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE030_SHR(box, trBox);
		}

		return null;
	}

}

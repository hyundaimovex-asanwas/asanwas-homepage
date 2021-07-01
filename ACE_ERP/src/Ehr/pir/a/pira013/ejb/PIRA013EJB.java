package hr.pir.a.pira013.ejb;

import hr.pir.a.pira013.wrk.PIRA013WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA013EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA013EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA013WRK wrk = new PIRA013WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �λ�⺻3 �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �λ���ǥ �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA013_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �λ�⺻3 �ǿ��� �����ư�� Ŭ���� ��,
			 * �λ���ǥ �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA013_SAV(box, trBox);
		}

		return null;
	}

}

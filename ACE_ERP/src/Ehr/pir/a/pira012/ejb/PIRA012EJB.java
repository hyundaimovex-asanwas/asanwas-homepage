package hr.pir.a.pira012.ejb;

import hr.pir.a.pira012.wrk.PIRA012WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA012EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA012EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA012WRK wrk = new PIRA012WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �λ�⺻2 �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �λ���ǥ �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA012_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �λ�⺻2 �ǿ��� �����ư�� Ŭ���� ��,
			 * �λ���ǥ �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA012_SAV(box, trBox);
		}

		return null;
	}

}

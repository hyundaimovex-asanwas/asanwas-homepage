package hr.pir.a.pira015.ejb;

import hr.pir.a.pira015.wrk.PIRA015WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA015EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA015EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA015WRK wrk = new PIRA015WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �λ�⺻5 �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �λ���ǥ �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA015_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �λ�⺻5 �ǿ��� �����ư�� Ŭ���� ��,
			 * �λ���ǥ �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA015_SAV(box, trBox);
		}

		return null;
	}

}

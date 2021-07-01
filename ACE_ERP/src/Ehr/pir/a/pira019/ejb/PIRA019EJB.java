package hr.pir.a.pira019.ejb;

import hr.pir.a.pira019.wrk.PIRA019WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA019EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA019EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA019WRK wrk = new PIRA019WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �ǰ����� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �ǰ����� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA019_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �ǰ����� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * �ǰ����� �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA019_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * �ǰ����� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * �ǰ����� �����͸� �����Ѵ�. 
			 */
			wrk.PIRA019_DEL(box, trBox);
		}

		return null;
	}

}

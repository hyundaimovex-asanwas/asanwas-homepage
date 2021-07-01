package hr.pir.a.pira027.ejb;

import hr.pir.a.pira027.wrk.PIRA027WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA027EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA027EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA027WRK wrk = new PIRA027WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ���м��� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * ���м��� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA027_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * ���м��� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * ���м��� �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA027_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * ���м��� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * ���м��� �����͸� �����Ѵ�. 
			 */
			wrk.PIRA027_DEL(box, trBox);
		}

		return null;
	}

}

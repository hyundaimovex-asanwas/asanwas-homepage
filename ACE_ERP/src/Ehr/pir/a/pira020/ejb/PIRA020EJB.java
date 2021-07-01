package hr.pir.a.pira020.ejb;

import hr.pir.a.pira020.wrk.PIRA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA020EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA020EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA020WRK wrk = new PIRA020WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �ڰݸ��� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �ڰݸ��� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA020_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �ڰݸ��� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * �ڰݸ��� �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA020_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * �ڰݸ��� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * �ڰݸ��� �����͸� �����Ѵ�. 
			 */
			wrk.PIRA020_DEL(box, trBox);
		}

		return null;
	}

}

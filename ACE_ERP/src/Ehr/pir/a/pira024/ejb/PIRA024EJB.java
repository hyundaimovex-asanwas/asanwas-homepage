package hr.pir.a.pira024.ejb;

import hr.pir.a.pira024.wrk.PIRA024WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA024EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA024EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA024WRK wrk = new PIRA024WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �Ի������ �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �Ի������ �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA024_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �Ի������ ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * �Ի������ �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA024_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * �Ի������ ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * �Ի������ �����͸� �����Ѵ�. 
			 */
			wrk.PIRA024_DEL(box, trBox);
		}

		return null;
	}


}

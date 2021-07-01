package hr.sch.a.scha090.ejb;

import hr.sch.a.scha090.wrk.SCHA090WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SCHA090EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public SCHA090EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SCHA090WRK wrk = new SCHA090WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (box.get("S_MODE").equals("SHR")) {
			 //���ڱ� ��û�Ⱓ ������ ��ȸ�ؿ´�. 
			wrk.SCHA090_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			 //���ڱ� ��û�Ⱓ ������ �����Ѵ�. 
			wrk.SCHA090_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			 //���ڱ� ��û�Ⱓ ������ �����Ѵ�. 
			wrk.SCHA090_DEL(box, trBox);
		}

		return null;
	}

}
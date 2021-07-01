package hr.pir.c.pirc080.ejb;

import hr.pir.c.pirc080.wrk.PIRC080WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRC080EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRC080EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRC080WRK wrk = new PIRC080WRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (box.get("S_MODE").equals("SHR")) {
			 //�λ���ǥ �����͸� ��ȸ�ؿ´�.
			wrk.PIRC080_SHR(box, trBox);
		}
		
		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (box.get("S_MODE").equals("SAV")) {
			
		    //�λ���ǥ�� �ҵ漼���ڵ� ������Ʈ.
			wrk.PIRC080_SAV(box, trBox);
		}

		return null;
	}

}
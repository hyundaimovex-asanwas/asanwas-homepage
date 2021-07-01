package hr.pir.c.pirc010.ejb;

import hr.pir.c.pirc010.wrk.PIRC010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRC010EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRC010EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRC010WRK wrk = new PIRC010WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			 //�λ���ǥ �����͸� ��ȸ�ؿ´�. 
			wrk.PIRC010_SHR(box, trBox);
		}

		return null;
	}

}
package hr.pir.a.pira023.ejb;

import hr.pir.a.pira023.wrk.PIRA023WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA023EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA023EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA023WRK wrk = new PIRA023WRK();

		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �ؿ����� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �ؿ����� �����͸� ��ȸ�ؿ´�.
			 */
			wrk.PIRA023_SHR(box, trBox);
		}

		return null;
	}

}

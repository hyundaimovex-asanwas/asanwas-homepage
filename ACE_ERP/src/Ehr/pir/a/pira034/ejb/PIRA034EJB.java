package hr.pir.a.pira034.ejb;

import hr.pir.a.pira034.wrk.PIRA034WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA034EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA034EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA034WRK wrk = new PIRA034WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * ������� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * ������� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA034_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * ������� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * ������� �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA034_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * ������� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * ������� �����͸� �����Ѵ�. 
			 */
			wrk.PIRA034_DEL(box, trBox);
		}

		return null;
	}

}

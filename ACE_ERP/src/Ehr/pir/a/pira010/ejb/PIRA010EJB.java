package hr.pir.a.pira010.ejb;

import hr.pir.a.pira010.wrk.PIRA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA010EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA010EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA010WRK wrk = new PIRA010WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �λ���ǥ ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * �λ���ǥ �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA010_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_02")) {
			/**
			 * �λ���ǥ ȭ�鿡�� ���Ի���� ���� �����ư�� Ŭ���� ��,
			 * ���Ի�� ������ �ݿ��ϰ� ����ȸ�ؿ´�. 
			 */
			wrk.PIRA010_SHR_02(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �λ���ǥ ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * �λ���ǥ �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA010_SAV(box, trBox);
		}

		return null;
	}

}
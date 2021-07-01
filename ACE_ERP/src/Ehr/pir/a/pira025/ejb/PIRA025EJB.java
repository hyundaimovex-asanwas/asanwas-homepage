package hr.pir.a.pira025.ejb;

import hr.pir.a.pira025.wrk.PIRA025WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA025EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA025EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA025WRK wrk = new PIRA025WRK();

		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �Ի��İ�� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �Ի��İ�� �����͸� ��ȸ�ؿ´�.
			 */
			wrk.PIRA025_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �Ի��İ�� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * �Ի��İ�� �����͸� �Է� �Ǵ� �����Ѵ�.
			 */
			wrk.PIRA025_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * �Ի��İ�� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * �Ի��İ�� �����͸� �����Ѵ�.
			 */
			wrk.PIRA025_DEL(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {
			/**
			 * ���Ի翩�� ��ȸ
			 */
			wrk.PIRA025_SHR_01(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV_01")) {
			/**
			 * �����Ի��� �ݿ�
			 */
			wrk.PIRA025_SAV_01(box, trBox);
		}

		return null;
	}


}

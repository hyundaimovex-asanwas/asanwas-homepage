package common.yearmonth.ejb;

import common.yearmonth.wrk.YEARMONTHWRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.login.wrk.LOGINWRK;

public class YEARMONTHEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public YEARMONTHEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
        /** WRK Class ��ü ���� * */
        YEARMONTHWRK wrk = new YEARMONTHWRK();

        /** ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (SHR:���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ����) ���� WRK Class �޼ҵ� ȣ�� * */
        if(box.get("S_MODE").equals("SHR"))
            wrk.YEARMONTH_SHR(box, tr);
        else if(box.get("S_MODE").equals("SHR01"))
            wrk.YEARMONTH_SHR01(box, tr);

        return null;
	}

}

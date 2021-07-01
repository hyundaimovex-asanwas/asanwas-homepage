package common.menu.accesslog.ejb;

import common.menu.accesslog.wrk.ACCESSLOGWRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class ACCESSLOGEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public ACCESSLOGEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
        /** WRK Class ��ü ���� * */
		ACCESSLOGWRK wrk = new ACCESSLOGWRK();

        /** ���α׷� ��� �α� ���� (SAV:����)�� ���� WRK Class �޼ҵ� ȣ�� * */
        if(box.get("S_MODE").equals("SAV"))
            wrk.ACCESSLOG_SAV(box, tr);

        return null;
	}

}

package common.yearmonth.wrk;

import common.yearmonth.dao.YEARMONTHDAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.mediator.AbstractMediator;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YEARMONTHWRK {

    /**
     * ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void YEARMONTH_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (��ȸ) DAO CLASS �޼��� ȣ�� * */
		YEARMONTHDAO dao = new YEARMONTHDAO("default", p_tr);
		dao.YEARMONTH_SHR(p_box);

	}
	public void YEARMONTH_SHR01(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (��ȸ) DAO CLASS �޼��� ȣ�� * */
		YEARMONTHDAO dao = new YEARMONTHDAO("default", p_tr);
		dao.YEARMONTH_SHR01(p_box);

	}

}

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
     * 현재 평가입력기간에 해당하는 년도,회차 정보 (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void YEARMONTH_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 현재 평가입력기간에 해당하는 년도,회차 정보 (조회) DAO CLASS 메서드 호출 * */
		YEARMONTHDAO dao = new YEARMONTHDAO("default", p_tr);
		dao.YEARMONTH_SHR(p_box);

	}
	public void YEARMONTH_SHR01(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 현재 평가입력기간에 해당하는 년도,회차 정보 (조회) DAO CLASS 메서드 호출 * */
		YEARMONTHDAO dao = new YEARMONTHDAO("default", p_tr);
		dao.YEARMONTH_SHR01(p_box);

	}

}

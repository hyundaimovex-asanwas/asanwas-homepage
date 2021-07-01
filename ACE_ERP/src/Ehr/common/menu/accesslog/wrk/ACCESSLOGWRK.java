package common.menu.accesslog.wrk;

import common.menu.accesslog.dao.ACCESSLOGDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class ACCESSLOGWRK {

    /**
     * 프로그램 사용 로그 정보 저장 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void ACCESSLOG_SAV(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 프로그램 사용 로그 정보(저장) DAO CLASS 메서드 호출 * */
		ACCESSLOGDAO dao = new ACCESSLOGDAO("default", p_tr);
		dao.ACCESSLOG_INS(p_box);

	}

	

}

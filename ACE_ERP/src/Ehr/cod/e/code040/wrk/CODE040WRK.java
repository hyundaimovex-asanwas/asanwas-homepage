package Ehr.cod.e.code040.wrk;

import Ehr.cod.e.code040.dao.CODE040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODE040WRK {

	/**
	 * 개인정보 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC090DAO 객체 생성 후 관련 메소드 호출 */
		CODE040DAO dao = new CODE040DAO("default", p_tr);

        /** 인사기록표 SELECT하는 DAO 메소드 호출 */
		dao.CODE040_SHR(p_box);
	}

	public void CODE040_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** PIRC090DAO 객체 생성 후 관련 메소드 호출 */
		CODE040DAO dao = new CODE040DAO("default", p_tr);
		
		dao.CODE040_UPT(p_box, null);

	}
}




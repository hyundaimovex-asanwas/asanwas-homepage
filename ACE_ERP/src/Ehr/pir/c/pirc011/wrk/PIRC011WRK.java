package Ehr.pir.c.pirc011.wrk;

import Ehr.pir.c.pirc011.dao.PIRC011DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRC011WRK {

	/**
	 * 인사기록표 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRC011_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC011DAO 객체 생성 후 관련 메소드 호출 */
		PIRC011DAO dao = new PIRC011DAO("default", p_tr);

        /** 인사기록표 SELECT하는 DAO 메소드 호출 */
		dao.PIRC011_SHR(p_box);

	}
	
}

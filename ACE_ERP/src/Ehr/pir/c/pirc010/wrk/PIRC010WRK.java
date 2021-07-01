package Ehr.pir.c.pirc010.wrk;

import Ehr.pir.c.pirc010.dao.PIRC010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRC010WRK {

	/**
	 * 개인정보 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRC010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC010DAO 객체 생성 후 관련 메소드 호출 */
		PIRC010DAO dao = new PIRC010DAO("default", p_tr);

        /** 인사기록표 SELECT하는 DAO 메소드 호출 */
		dao.PIRC010_SHR(p_box);

	}
	
}


package Ehr.cod.d.codd010.wrk;

import Ehr.cod.d.codd010.dao.CODD010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODD010WRK {

    /**
     * 프로그램 사용 로그 정보 조회 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void CODD010_SHR(CBox p_box, TrBox p_tr) throws CException {

		
        /** DAO Class 객체 생성후 프로그램 사용 로그 정보(조회) DAO CLASS 메서드 호출 * */
		CODD010DAO dao = new CODD010DAO("default", p_tr);

		dao.CODD010_SHR(p_box);

	}

}

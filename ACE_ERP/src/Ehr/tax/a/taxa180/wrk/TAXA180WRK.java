package Ehr.tax.a.taxa180.wrk;

import Ehr.tax.a.taxa180.dao.TAXA180DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class TAXA180WRK {
	/**
	 * 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void TAXA180_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** TAXA180DAO 객체 생성 후 관련 메소드 호출 */
		TAXA180DAO dao = new TAXA180DAO("default", p_tr);

		/** 정보 SELECT하는 DAO 메소드 호출 */
		dao.TAXA180_SHR(p_box);

	}

	public void TAXA180_SHR2(CBox p_box, TrBox p_tr) throws CException {

		/** TAXA180DAO 객체 생성 후 관련 메소드 호출 */
		TAXA180DAO dao = new TAXA180DAO("default", p_tr);

		/** 정보 SELECT하는 DAO 메소드 호출 */
		dao.TAXA180_SHR2(p_box);

	}	
	
}

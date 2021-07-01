package Ehr.cod.e.code061.wrk;

import Ehr.cod.e.code061.dao.CODE061DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE061WRK {

	/**
	 * 기타수당내역
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE061_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC021DAO 객체 생성 후 관련 메소드 호출 */
		CODE061DAO dao = new CODE061DAO("default", p_tr);

        /** 사용자 권한 SELECT하는 DAO 메소드 호출 */
		dao.CODE061_SHR_01(p_box);
	}


	/**
	 * 기타공제내역
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE061_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC021DAO 객체 생성 후 관련 메소드 호출 */
		CODE061DAO dao = new CODE061DAO("default", p_tr);

		/** 사용자 권한 SELECT하는 DAO 메소드 호출 */
		dao.CODE061_SHR_02(p_box);

	}

}

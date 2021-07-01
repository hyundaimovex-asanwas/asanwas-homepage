package Ehr.vlu.k.vluk070.wrk;

import Ehr.vlu.k.vluk070.dao.VLUK070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK070WRK {

	/**
	 * 부서장 피고과자 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void VLUK070_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK070DAO 객체 생성 후 관련 메소드 호출 */
		VLUK070DAO dao = new VLUK070DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUK070_SHR(p_box);

	}

	/**
	 * 부서장 피고과자 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void VLUK070_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK070DAO 객체 생성 후 관련 메소드 호출 */
		VLUK070DAO dao = new VLUK070DAO("default", p_tr);

        /** 본부별평가현황 SELECT하는 DAO 메소드 호출 */
	   dao.VLUK070_SHR_01(p_box);

	}

	public void VLUK070_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUK070DAO 객체 생성 후 관련 메소드 호출 */
		VLUK070DAO dao = new VLUK070DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
				case 2:
    				/** INSERT하는  DAO 메소드 호출 */
					dao.VLUK070_SAV(vo, p_box);

					break;
				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					break;

				case 4:
					dao.VLUK070_DEL(vo, p_box);
					break;
			}
		}

	}

}

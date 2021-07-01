package Ehr.sag.d.sagd040.wrk;

import Ehr.sag.d.sagd040.dao.SAGD040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGD040WRK {

	/**
	 * 개인별 고정지불/공제 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD040_SHR(CBox p_box, TrBox p_tr) throws CException {

			SAGD040DAO dao = new SAGD040DAO("default", p_tr);
			dao.SAGD040_SHR(p_box);

	}

	/**
	 * 개인별 수당 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD040_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CP_NSUDANG");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD040DAO dao = new SAGD040DAO("default", p_tr);

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
					// insert;
					dao.SAGD040_INS(p_box, vo);
					break;
				case 3:
					// update;
					dao.SAGD040_UPT(p_box, vo);
					break;
				case 4:
					// delete;
					dao.SAGD040_DEL(p_box, vo);
					break;
			}
		}

	}

	/**
	 * 개인별 수당 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD040_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CP_NSUDANG");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD040DAO dao = new SAGD040DAO("default", p_tr);

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
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.SAGD040_DEL(p_box, vo);
				break;
			}
		}

	}


}

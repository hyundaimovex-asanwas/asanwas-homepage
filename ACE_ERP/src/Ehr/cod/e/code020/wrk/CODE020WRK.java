package Ehr.cod.e.code020.wrk;

import Ehr.cod.e.code020.dao.CODE020DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODE020WRK {

	/**
	 * 일련번호를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** CODE020DAO 객체 생성 후 관련 메소드 호출 */
		CODE020DAO dao = new CODE020DAO("default", p_tr);

        /** 일련번호 SELECT하는 DAO 메소드 호출 */
		dao.CODE020_SHR_01(p_box);

	}

	/**
	 * 개인정보 수정요청을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** CODE020DAO 객체 생성 후 관련 메소드 호출 */
		CODE020DAO dao = new CODE020DAO("default", p_tr);

        /** 개인정보 수정요청 SELECT하는 DAO 메소드 호출 */
		dao.CODE020_SHR_02(p_box);

	}

	/**
	 * 일련번호를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE020_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** CODE020DAO 객체 생성 후 관련 메소드 호출 */
		CODE020DAO dao = new CODE020DAO("default", p_tr);

        /** 일련번호 SELECT하는 DAO 메소드 호출 */
		dao.CODE020_SHR_03(p_box);

	}
	/**
	 * 개인정보 수정요청을 저장 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODE020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_UPRQST");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		CODE020DAO dao = new CODE020DAO("default", p_tr);

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
					// 개인정보 수정요청을 입력하기 위한 DAO메소드 호출
					dao.CODE020_INS(vo, p_box);
					break;

				case 3:
					// 개인정보 수정요청을 수정하기 위한 DAO메소드 호출
					dao.CODE020_UPT(vo, p_box);
					break;

			}
		}
	}

	/**
	 * 개인정보 수정요청을 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODE020_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_UPRQST");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		CODE020DAO dao = new CODE020DAO("default", p_tr);


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
				case 4:
					// 개인정보 수정요청을 삭제하기 위한 DAO메소드 호출
					dao.CODE020_DEL(vo, p_box);
					break;

			}
		}

	}


}


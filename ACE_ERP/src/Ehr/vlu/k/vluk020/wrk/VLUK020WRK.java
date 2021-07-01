package Ehr.vlu.k.vluk020.wrk;

import Ehr.vlu.k.vluk020.dao.VLUK020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK020WRK {


	public void VLUK020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK020DAO 객체 생성 후 관련 메소드 호출 */
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

        /** 고과표 SELECT하는 DAO 메소드 호출 */
		dao.VLUK020_SHR(p_box);

	}

	public void VLUK020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);


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

					//System.out.println(vo);
					//System.out.println(p_box);

					// 설정 내용을 저장하기 위한 DAO메소드 호출
					dao.VLUK020_SAV(vo, p_box);
					break;
				case 3:
					// 설정 내용을 수정하기 위한 DAO메소드 호
					dao.VLUK020_UPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;
				}
			}

	}

	/**
	 * 고과표 설정을 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK020_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 4:
//				 고과표 설정을 삭제하기 위한 DAO메소드 호출
				dao.VLUK020_DEL(vo, p_box);
				break;

		}

		}
	}



	public void VLUK020_SHR_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK020DAO 객체 생성 후 관련 메소드 호출 */
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

        /** 고과표 SELECT하는 DAO 메소드 호출 */
		dao.VLUK020_SHR_DPT(p_box);

	}

	public void VLUK020_SAV_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);


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

					//System.out.println(vo);
					//System.out.println(p_box);

					// 설정 내용을 저장하기 위한 DAO메소드 호출
					dao.VLUK020_SAV_DPT(vo, p_box);
					break;
				case 3:
					// 설정 내용을 수정하기 위한 DAO메소드 호
					dao.VLUK020_UPT_DPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;
				}
			}

	}

	/**
	 * 고과표 설정을 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK020_DEL_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUK020DAO dao = new VLUK020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 4:
//				 고과표 설정을 삭제하기 위한 DAO메소드 호출
				dao.VLUK020_DEL_DPT(vo, p_box);
				break;

		}

		}
	}
	
	
}

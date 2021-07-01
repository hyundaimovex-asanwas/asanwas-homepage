package Ehr.gun.d.gund030.wrk;

import Ehr.gun.d.gund030.dao.GUND030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND030WRK {

	/**
	 * 연차발생관리 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND030_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUND030DAO dao = new GUND030DAO("default", p_tr);
			dao.GUND030_SHR(p_box);

	}

	/**
	 * 연차발생관리 일괄생성하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND030_INS(CBox p_box, TrBox p_tr) throws CException {

		GUND030DAO dao = new GUND030DAO("default", p_tr);
		GUND030DAO dao2 = new GUND030DAO("default", p_tr);
		
		//신규생성
		dao.GUND030_INS(p_box);

		//조회
		dao2.GUND030_SHR(p_box);

	}

	/**
	 * 연차발생관리 재생성하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND030_UPT(CBox p_box, TrBox p_tr) throws CException {

		GUND030DAO dao = new GUND030DAO("default", p_tr);
		GUND030DAO dao2 = new GUND030DAO("default", p_tr);
		GUND030DAO dao3 = new GUND030DAO("default", p_tr);		
		
		//신규생성을 위해 삭제
		dao.GUND030_DEL(p_box);

		//신규생성
		dao2.GUND030_INS(p_box);

		//조회
		dao3.GUND030_SHR(p_box);

	}

	/**
	 * 연차발생관리를 수정 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUND030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_YEARLY");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUND030DAO dao = new GUND030DAO("default", p_tr);

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
					// insert
					break;
				case 3:
					// 연차발생관리를 수정하기 위한 DAO메소드 호출
					dao.GUND030_UPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;
				}
			}
	}

}

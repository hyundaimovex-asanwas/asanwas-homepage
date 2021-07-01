package Ehr.sag.e.sage010.wrk;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.sag.e.sage010.dao.SAGE010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class SAGE010WRK {

	/**
	 * 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

		dao.SAGE010_SHR(p_box);

	}

	/**
	 * 소속 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

		dao.SAGE010_SHR_01(p_box);

	}


	/**
	 * 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGE010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SI_DILIGENCE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

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
					// 근태현황을 수정하기 위한 DAO메소드 호출
					this.SAGE010_UPT(p_box,vo,p_tr);
					break;
				case 4:
					// delete;
					break;
			}
		}
	}
	
	
	public void SAGE010_UPT(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGE010DAO dao = new SAGE010DAO("default", p_tr);

		dao.SAGE010_UPT(p_box, vo);

	}			


}

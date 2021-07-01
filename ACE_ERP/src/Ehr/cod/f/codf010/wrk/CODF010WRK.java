package Ehr.cod.f.codf010.wrk;

import Ehr.cod.f.codf010.dao.CODF010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODF010WRK {

	/**
	 * 트리조회[FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODF010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		CODF010DAO dao = new CODF010DAO("default", p_tr);
		dao.CODF010_SHR(p_box);

	}

	/**
	 * 직무코드 상세 조회  [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODF010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		CODF010DAO dao = new CODF010DAO("default", p_tr);
		dao.CODF010_SHR_01(p_box);

	}

	/**
	 * 직무정보가 하나도 없으면 회사정보를 넣는다.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODF010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODF010DAO dao = new CODF010DAO("default", p_tr);

		//직무정보가 하나도 없으면 회사정보를 한번만 넣기때문에 insert만 한번 사용
		dao.CODF010_INS(p_box);

	}

	/**
	 * 직무코드 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODF010_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DUTYMST");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODF010DAO dao = new CODF010DAO("default", p_tr);

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
					dao.CODF010_INS_01(p_box, vo);
					//상위직무의 하위직무유무 update한다.(상위직무에 하위직무 있다고 update)
					dao.CODF010_UPT_02(p_box, vo);
					break;
				case 3:
					// update;
					dao.CODF010_UPT_01(p_box, vo);
					break;
				case 4:
					// delete;
					break;
			}
		}

	}
	/**
	 * 직무코드 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODF010_DEL_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DUTYMST");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODF010DAO dao = new CODF010DAO("default", p_tr);

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
				dao.CODF010_DEL_01(p_box, vo);
				//상위직무의 하위직무유무 update한다.(상위직무에 하위직무 없다고 update)
				dao.CODF010_UPT_03(p_box, vo);
				break;
			}
		}

	}
}

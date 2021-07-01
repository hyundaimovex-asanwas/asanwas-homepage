package Ehr.cod.b.codb020.wrk;

import Ehr.cod.b.codb020.dao.CODB020DAO;
import Ehr.yac.a.yaca021.dao.YACA021DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODB020WRK {

	/**
	 * 트리조회[FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODB020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		CODB020DAO dao = new CODB020DAO("default", p_tr);
		dao.CODB020_SHR(p_box);

	}

	/**
	 * 부서코드 상세 조회  [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODB020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		CODB020DAO dao = new CODB020DAO("default", p_tr);
		dao.CODB020_SHR_01(p_box);

	}
	
	/**
	 * HEAD_TAG 코드 상세 조회  [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODB020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		CODB020DAO dao = new CODB020DAO("default", p_tr);
		dao.CODB020_SHR_02(p_box);

	}
	
	/**
	 * 부서정보가 하나도 없으면 회사정보를 넣는다.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODB020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODB020DAO dao = new CODB020DAO("default", p_tr);

		//부서정보가 하나도 없으면 회사정보를 한번만 넣기때문에 insert만 한번 사용
		dao.CODB020_INS(p_box);

	}

	/**
	 * 부서코드 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODB020_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DEPT");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODB020DAO dao = new CODB020DAO("default", p_tr);

		CODB020DAO dao2 = new CODB020DAO("default", p_tr);

        //부양가족 관련 내역을 계산해서 가져온다.
        //voList = dao2.YACA021_SHR_CNT_14(p_box);		
		
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
			//System.out.print(vo);
			//System.out.print("/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/");
			switch (vo.getInt("TX_MODE")) {
			
				case 2:

					// insert;
					dao.CODB020_INS_01(p_box, vo);
					
					//상위부서의 하위부서유무 update한다.(상위부서에 하위부서 있다고 update)
					dao2.CODB020_UPT_02(p_box, vo);
					
					break;
					
				case 3:
					// update;
					dao.CODB020_UPT_01(p_box, vo);
					break;
					
				case 4:
					// delete;
					break;
					
			}
		}

	}

	/**
	 * 부서코드 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODB020_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DEPT");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODB020DAO dao = new CODB020DAO("default", p_tr);

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
				dao.CODB020_DEL_01(p_box, vo);
				//상위부서의 하위부서유무 update한다.(상위부서에 하위부서 없다고 update)
				dao.CODB020_UPT_03(p_box, vo);
				break;
			}
		}

	}
}

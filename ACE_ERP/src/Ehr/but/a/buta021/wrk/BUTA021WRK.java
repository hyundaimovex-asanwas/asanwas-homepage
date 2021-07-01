package Ehr.but.a.buta021.wrk;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.but.a.buta021.dao.BUTA021DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class BUTA021WRK {

	/**
	 * 여비지급기준을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_01(p_box);

	}

	/**
	 * 직급에 따른 단가명을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_02(p_box);

	}

	/**
	 * 식비공제를 위한 휴일을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_03(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_03(p_box);

	}

	/**
	 * 여비계산서를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR(p_box);

	}


	/**
	 * 트랜젝션을 수행하여 여비계산서에 저장,수정,삭제하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BUTA021_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_BASIS");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA021DAO dao = new BUTA021DAO("default", p_tr);


		//삭제후 무조건 insert
		GauceValueObject vo = voList.get(0);
		
		dao.BUTA021_DEL_01(vo, p_box);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			//dao.BUTA021_INS(vo, p_box);


			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					
					//여비계산서를 저장하는 DAO 메소드 호출
					this.BUTA021_INS(vo, p_box, p_tr);
					break;

				case 3:
					
					//여비계산서를 수정하는 DAO 메소드 호출
					this.BUTA021_UPT(vo, p_box, p_tr);
					break;

				case 4:
					
					//여비계산서를 삭제하는 DAO 메소드 호출
					dao.BUTA021_DEL(vo, p_box);
					break;
			}

		}
	}

	
	public void BUTA021_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		BUTA021DAO dao = new BUTA021DAO("default", p_tr);

		dao.BUTA021_INS(vo, p_box);

	}		
	
	public void BUTA021_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		BUTA021DAO dao = new BUTA021DAO("default", p_tr);

		dao.BUTA021_UPT(vo, p_box);

	}		
	
	/**
	 * 출장품의 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_04(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_04(p_box);

	}
}

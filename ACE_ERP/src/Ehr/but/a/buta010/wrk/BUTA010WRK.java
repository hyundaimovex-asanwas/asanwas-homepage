package Ehr.but.a.buta010.wrk;

import Ehr.but.a.buta010.dao.BUTA010DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class BUTA010WRK {

	/**
	 * 출장품의 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA010_SHR(CBox p_box, TrBox p_tr) throws CException {

			BUTA010DAO dao = new BUTA010DAO("default", p_tr);
			
			dao.BUTA010_SHR(p_box);

	}

	/**
	 * 트랜젝션을 수행하여 출장품의 현황에서 삭제하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BUTA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA010DAO dao = new BUTA010DAO("default", p_tr);
		BUTA010DAO dao2 = new BUTA010DAO("default", p_tr);
		BUTA010DAO dao3 = new BUTA010DAO("default", p_tr);
		BUTA010DAO dao4 = new BUTA010DAO("default", p_tr);
		
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
					//insert
					break;

				case 3:
					//update
					break;

				case 4:

					//출장품의서 삭제를 위한 DAO 메소드 호출
					dao.BUTA010_DEL_01(vo, p_box);
					
					//출장품의서 결재현황 삭제를 위한 DAO 메소드 호출
					dao2.BUTA010_DEL_02(vo, p_box);
					
					//여비계산서 삭제를 위한 DAO 메소드 호출
					dao3.BUTA010_DEL_03(vo, p_box);
					
					//출장결재자 정보 삭제를 위한 DAO 메소드 호출
					dao4.BUTA010_DEL_04(vo, p_box);

					break;
					
			}
			
		}
		
	}

	

}

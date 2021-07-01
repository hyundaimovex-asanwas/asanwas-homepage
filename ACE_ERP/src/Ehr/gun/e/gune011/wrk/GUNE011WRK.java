package Ehr.gun.e.gune011.wrk;


import Ehr.gun.e.gune011.dao.GUNE011DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUNE011WRK {

	/**
	 * 연장근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE011_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNE011DAO dao = new GUNE011DAO("default", p_tr);
			
			dao.GUNE011_SHR(p_box);

	}

	/**
	 * 트랜젝션을 수행하여 출장품의 현황에서 삭제하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNE011_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNE011DAO dao = new GUNE011DAO("default", p_tr);
		GUNE011DAO dao2 = new GUNE011DAO("default", p_tr);
		GUNE011DAO dao3 = new GUNE011DAO("default", p_tr);
		GUNE011DAO dao4 = new GUNE011DAO("default", p_tr);
		
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

					//연장근무 삭제를 위한 DAO 메소드 호출
					dao.GUNE011_DEL_01(vo, p_box);
				
					break;
					
			}
			
		}
		
	}

	

}

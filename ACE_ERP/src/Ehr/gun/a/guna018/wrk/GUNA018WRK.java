package Ehr.gun.a.guna018.wrk;

import Ehr.gun.a.guna018.dao.GUNA018DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA018WRK {

	/**
	 * 개인별 근태 현황을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNA018_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC030DAO 객체 생성 후 관련 메소드 호출 */
		GUNA018DAO dao = new GUNA018DAO("default", p_tr);
		GUNA018DAO dao2 = new GUNA018DAO("default", p_tr);
		
        /** 개인별 근태 현황 SELECT하는 DAO 메소드 호출 */
		//dao.PIRC030_SHR(p_box);
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",    dao.GUNA018_SHR(p_box) );
		p_tr.setOutDataSet( "dsT_DI_YEARLY",       dao2.GUNA018_SHR_01(p_box) );
	}


	/**
	 * 개인별 연차갯수를 업데이트하는 WRK 메소드
	 * @param p_box			CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNA018_UPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_YEARLY");

		/** PIRC030DAO 객체 생성 후 관련 메소드 호출 */
		GUNA018DAO dao = new GUNA018DAO("default", p_tr);

		//System.out.println("Next_msg = [2]");

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

			//System.out.println("TX_MODE = " + vo.getInt("TX_MODE") );

			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					// 개인별 연차갯수 정보를 저장하기 위한 DAO메소드 호출
					dao.GUNA018_INS(vo, p_box);
					break;
					
				case 3:
					// 개인별 연차갯수 정보를 수정하기 위한 DAO메소드 호출
					dao.GUNA018_UPT(vo, p_box);
					break;
					
				case 4:
					// delete;

					break;
			}


		}


	}

}


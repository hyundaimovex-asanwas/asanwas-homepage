package Ehr.vlu.k.vluk060.wrk;

import Ehr.vlu.k.vluk060.dao.VLUK060DAO;


import Ehr.vlu.o.vluo060.dao.VLUO060DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK060WRK {

	/**
	 * 해당 년도에 대한 평가구조 설정 내용을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK060_SHR(CBox p_box, TrBox p_tr) throws CException {

			VLUK060DAO dao = new VLUK060DAO("default", p_tr);
			dao.VLUK060_SHR(p_box);

	}

	public void VLUK060_SHR02(CBox p_box, TrBox p_tr) throws CException {

		VLUK060DAO dao = new VLUK060DAO("default", p_tr);
		dao.VLUK060_SHR02(p_box);

}

	/**
	 * 평가구조 설정내용을 저장, 수정 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void VLUK060_SAV( CBox p_box, TrBox p_tr ) throws CException {

		System.out.println(p_box);

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQGROUP");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

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
					// 평가구조 설정 내용을 저장하기 위한 DAO메소드 호출
					this.VLUK060_DEL_01(vo, p_box, p_tr);		
					this.VLUK060_DEL_02(vo, p_box, p_tr);						
					this.VLUK060_INS_01(vo, p_box, p_tr);
					this.VLUK060_INS_02(vo, p_box, p_tr);					
					break;
				case 3:
					// 평가구조 설정 내용을 수정하기 위한 DAO메소드 호
					this.VLUK060_UPT(vo, p_box, p_tr);
					break;
				case 4:
					// delete;

					break;
				}
			}
	}

	
	
	public void VLUK060_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/		
		
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		dao.VLUK060_INS_01(vo, p_box);

	}	
	
	public void VLUK060_INS_02(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/		
		
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		dao.VLUK060_INS_02(vo, p_box);

	}	
	

	public void VLUK060_DEL_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

        dao.VLUK060_DEL_01(vo, p_box);

	}		
	
	public void VLUK060_DEL_02(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

        dao.VLUK060_DEL_02(vo, p_box);

	}		
	
	
	public void VLUK060_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

        dao.VLUK060_UPT(vo, p_box);

	}		
	
	/**
	 * 고과표 설정을 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK060_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 4:
//				 고과표 설정을 삭제하기 위한 DAO메소드 호출
				dao.VLUK060_DEL(vo, p_box);
				break;

		}


		}
	}


}


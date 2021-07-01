package Ehr.gun.a.guna100.wrk;

import Ehr.gun.a.guna100.dao.GUNA100DAO;
import Ehr.ins.a.insa050.dao.INSA050DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA100WRK {

	/**
	 * 개인별 근태 집계 현황을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNA100_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** GUNA100DAO 객체 생성 후 관련 메소드 호출 */
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		dao.GUNA100_SHR(p_box);

	}

	/**
	 * 개인별 연차 현황을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNA100_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** GUNA100DAO 객체 생성 후 관련 메소드 호출 */
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		p_tr.setOutDataSet( "dsT_DI_YEARLY",       dao.GUNA100_SHR_02(p_box) );
		
	}


	/**
	 * 개인별 근태 집계 현황을 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA100_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

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
					this.GUNA100_UPT(vo, p_box, p_tr);
					break;
					
				case 4:
					
					// delete;
					break;
					
			}
			
		}
		
	}


	public void GUNA100_UPT(GauceValueObject vo, CBox p_box,  TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

		dao.GUNA100_UPT(vo, p_box);

	}		
	
}


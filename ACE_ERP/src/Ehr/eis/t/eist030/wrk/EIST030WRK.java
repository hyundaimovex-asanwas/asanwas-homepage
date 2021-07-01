package Ehr.eis.t.eist030.wrk;

import Ehr.eis.t.eist010.dao.EIST010DAO;
import Ehr.eis.t.eist030.dao.EIST030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST030WRK {
	
	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST030DAO 객체 생성 후 관련 메소드 호출 */
		EIST030DAO dao = new EIST030DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST030_SHR(p_box);

	}
	
	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST030_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

		/** EIST030DAO 객체 생성 후 관련 메소드 호출 */
		EIST030DAO dao = new EIST030DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST030_SHR_TEAM(p_box);

	}
	
	
	/**
	 * 저장 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST030_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PROJECT");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST030DAO dao = new EIST030DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {
				
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			System.out.println("vo0========="+vo);
			/** 
				* 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
				case 2:
					// 입력하기 위한 DAO메소드 호출
					this.EIST030_INS(vo, p_box, p_tr);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					this.EIST030_UPT(vo, p_box, p_tr);
					break;
				
			}
		}
	}
	
	public void EIST030_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		EIST030DAO dao = new EIST030DAO("default", p_tr);

		dao.EIST030_INS(vo, p_box);

	}		
	
	public void EIST030_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		
		System.out.println("vo1========="+vo);
		
		EIST030DAO dao = new EIST030DAO("default", p_tr);

		dao.EIST030_UPT(vo, p_box);

	}			
	
	
	/**
	 * 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST030_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST030DAO dao = new EIST030DAO("default", p_tr);
		
				
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
			
				case 4:
					// 삭제하기 위한 DAO메소드 호출
					dao.EIST030_DEL(vo, p_box);
					
					break;
				
			}
		}

	}
	
	
}


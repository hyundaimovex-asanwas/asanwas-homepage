package Ehr.pir.a.pira025.wrk;

import Ehr.pir.a.pira025.dao.PIRA025DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA025WRK {
	/**
	 * 입사후경력 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA025_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA025DAO 객체 생성 후 관련 메소드 호출 */
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

        /** 입사후경력 SELECT하는 DAO 메소드 호출 */
		dao.PIRA025_SHR(p_box);

	}

	/**
	 * 트랜젝션을 수행하여 입사후경력 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA025_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 입사후경력 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);
		PIRA025DAO dao2 = new PIRA025DAO("default", p_tr);
		PIRA025DAO dao3 = new PIRA025DAO("default", p_tr);
		PIRA025DAO dao4 = new PIRA025DAO("default", p_tr);	
		PIRA025DAO dao5 = new PIRA025DAO("default", p_tr);			
		PIRA025DAO dao6 = new PIRA025DAO("default", p_tr);	
		PIRA025DAO dao7 = new PIRA025DAO("default", p_tr);			
		PIRA025DAO dao8 = new PIRA025DAO("default", p_tr);			
		
		//입사후경력을 생성할때 인사기록정보가 없으면 신규생성(임시테이블을 정식으로 등록)
		GauceDataSet ds = dao.PIRA025_SHR_02(voList.get(0), p_box);

		if(ds.getDataRowCnt() == 0){
			
			dao2.PIRA025_INS_02(voList.get(0), p_box);//T_CM_PERSON
			
			dao3.PIRA025_INS_03(voList.get(0), p_box);//T_CM_EMPLIST
			
			dao6.PIRA025_INS_04(voList.get(0), p_box);//PAYROLL.HIPSERN 2019.04.18 이동훈 추가	
			
			dao7.PIRA025_INS_05(voList.get(0), p_box);//COMMON.GD0080, COMMON.MENU_AUTH 2019.04.18 이동훈 추가	
						
			dao8.PIRA025_INS_06(voList.get(0), p_box);//T_DI_MONTHLY_HISTORY 2019.05.02 이동훈 추가				
			
		}

		for (int i=voList.size()-1; i>=0; i--) {//역순으로 저장해야함

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
					/** 입사후경력 INSERT하는  DAO 메소드 호출 */

					dao4.PIRA025_INS(vo, p_box);
					
					dao5.PIRA025_INS_01(vo, p_box, "1");

					break;

				case 3:
					/** 입사후경력 UPDATE하는 DAO 메소드 호출 */
					
					dao4.PIRA025_UPT(vo, p_box);
					
					dao5.PIRA025_INS_01(vo, p_box, "2");

					break;

				case 4:
					//delete
					break;
			}
		}
	}

	/**
	 * 트랜젝션을 수행하여 입사후경력 데이터를 삭제 처리하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA025_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 입사후경력 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

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
					/** 입사후경력 DELETE하는 DAO 메소드 호출 */
					dao.PIRA025_INS_01(vo, p_box, "3");
					break;
			}
		}
	}

	/**
	 * 재입사여부 조회
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA025_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA025DAO 객체 생성 후 관련 메소드 호출 */
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

        /** 입사후경력 SELECT하는 DAO 메소드 호출 */
		dao.PIRA025_SHR_01(p_box);

	}

	/**
	 * 기존입사일 반영
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA025_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA025DAO dao = new PIRA025DAO("default", p_tr);

		GauceValueObject vo1 = voList.get(0);	// 현입사정보
		GauceValueObject vo2 = voList.get(1);	// 기존입사정보

		dao.PIRA025_UPT_01(vo1, vo2, p_box);

	}
}

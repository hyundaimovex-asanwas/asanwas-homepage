package Ehr.eis.t.eist020.wrk;

import Ehr.common.util.JSPUtil;
import Ehr.eis.t.eist020.dao.EIST020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST020WRK {
	
	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO 객체 생성 후 관련 메소드 호출 */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST020_SHR(p_box);

	}
	
	
	/**
	 * 소속 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST020_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO 객체 생성 후 관련 메소드 호출 */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST020_SHR_TEAM(p_box);

	}	
	
	
	/**
	 * 일자별 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST020_SHR_DAY(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO 객체 생성 후 관련 메소드 호출 */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST020_SHR_DAY(p_box);

	}	
	
	/**
	 * 프로젝트별 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST020_SHR_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO 객체 생성 후 관련 메소드 호출 */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST020_SHR_PJT(p_box);

	}	
	
	/**
	 * 직원별 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EIST020_SHR_PER(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO 객체 생성 후 관련 메소드 호출 */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.EIST020_SHR_PER(p_box);

	}		
	
	/**
	 * 저장 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
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
					// 입력하기 위한 DAO메소드 호출
					dao.EIST020_INS(vo, p_box);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
	}
	
	/**
	 * 일자별 승인 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_UPT_DAY(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_DAY_02");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
		// 한큐에 끝내자
		//try {
		//	dao.EIST020_UPT_DAY_01(p_box, voList.get(0));
		//}catch(Exception ex) {
			
		//}		
		

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
					// 입력하기 위한 DAO메소드 호출
					this.EIST020_UPT_DAY_01(vo, p_box, p_tr);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					//dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
		
		
	}	
	
	public void EIST020_UPT_DAY(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_DAY_01(p_box, vo);

	}		
	
	public void EIST020_UPT_DAY_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_DAY_01(p_box, vo);

	}		
	

	/**
	 * 프로젝트별 승인 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_UPT_PJT(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PROJECT_02");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
		// 한큐에 끝내자
		//try {
		//	dao.EIST020_UPT_PJT_01(p_box, voList.get(0));
		//}catch(Exception ex) {
		//	
		//}				
		

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
					// 입력하기 위한 DAO메소드 호출
					this.EIST020_UPT_PJT_01(vo, p_box, p_tr);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					//dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
	}	
	
	public void EIST020_UPT_PJT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/	
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PJT(vo, p_box);

	}			
	
	public void EIST020_UPT_PJT_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/	
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PJT_01(p_box, vo);

	}
	
	/**
	 * 프로젝트별 승인 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_UPT_PER(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PERSON_02");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
		// 한큐에 끝내자
		//try {
		//	dao.EIST020_UPT_PER_01(p_box, voList.get(0));
		//}catch(Exception ex) {
		//	
		//}			
		
		
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
					// 입력하기 위한 DAO메소드 호출
					this.EIST020_UPT_PER_01(vo, p_box, p_tr);
					break;
					
				case 3:
					// 수정하기 위한 DAO메소드 호출
					//dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
	}	
	
	public void EIST020_UPT_PER(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PER(vo, p_box);

	}		
	
	public void EIST020_UPT_PER_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PER_01(p_box, vo);

	}		
	
	/**
	 * 삭제 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
				
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
					dao.EIST020_DEL(vo, p_box);
					
					break;
				
			}
		}

	}
	
	
}


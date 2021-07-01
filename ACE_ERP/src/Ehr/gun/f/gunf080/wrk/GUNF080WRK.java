package Ehr.gun.f.gunf080.wrk;

import Ehr.gun.f.gunf080.dao.GUNF080DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF080WRK {

	/**
	 * 개인별 근무형태 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF080_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF080DAO dao = new GUNF080DAO("default", p_tr);
			
			dao.GUNF080_SHR(p_box);

	}

	
	public void GUNF080_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_01(p_box);

	}		
	
	
	public void GUNF080_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_DTL(p_box);

	}		
	
	public void GUNF080_SHR_APP(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_APP(p_box);

	}			
	
	//월별 상신 결재 번호 채번
	public void GUNF080_SHR_MAX(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_MAX(p_box);

	}		
	
	//개별 상신 결재 번호 채번
	public void GUNF080_SHR_MAX2(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_MAX2(p_box);

	}			
	
	public void GUNF080_SHR_REQ(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_REQ(p_box);

	}	
	
	
	/**
	 * 개인별 근무형태를 저장하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws Exception 
	 */
	public void GUNF080_SAV( CBox p_box, TrBox p_tr ) throws Exception {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSCHEDULE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		
		for (int i=0; i<voList.size(); i++) {

			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
				case 2:
					// insert
					this.GUNF080_DEL(vo, p_box, p_tr);
					this.GUNF080_SAV(vo, p_box, p_tr);								
					break;
				case 3:
					// 개인별 근무형태를 수정하기 위한 DAO메소드 호출
					this.GUNF080_DEL(vo, p_box, p_tr);
					this.GUNF080_UPT(vo, p_box, p_tr);					
					break;
					
				case 4:
					// delete;
					break;
				}

		}

	}

	
	/**
	 * 개인별 근무형태를 월별 상신하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNF080_UPT_APP(CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSCHEDULE");
		
		// 결재선 정보 등록
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");		

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

				/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
				GauceValueObject vo = voList.get(i);	// LIST -> ROW
	
				switch (vo.getInt("TX_MODE")) {
					case 2:
						// insert
						this.GUNF080_UPT_APP(vo, p_box, p_tr);						
						break;
					case 3:				
						break;
					case 4:
						// delete;
						break;
				}
				
		}		
		

		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);
			
			//System.out.println(vo2);
			
			this.GUNF080_UPT_APP_01(vo2, p_box, p_tr) ;

		}
				

	}	
	
	
	/**
	 * 개인별 근무형태를 개별 상신하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_EACH(CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSCHEDULE");

		// 결재선 정보 등록
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");		

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

				/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
				GauceValueObject vo = voList.get(i);	// LIST -> ROW
	
				switch (vo.getInt("TX_MODE")) {
					case 2:
						// insert					
						break;
					case 3:	
						// update
						this.GUNF080_UPT_APP_EACH(vo, p_box, p_tr);
						break;
					case 4:
						// delete;
						break;
				}
				
		}		
		

		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);
			//System.out.println(vo2);
			this.GUNF080_UPT_APP_01_EACH(vo2, p_box, p_tr) ;

		}
				
	}		

	
	public void GUNF080_UPT_APP(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP(vo, p_box);

	}		
	

	public void GUNF080_UPT_APP_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP_01(vo, p_box);

	}		
	
	
	public void GUNF080_UPT_APP_EACH(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP_EACH(vo, p_box);

	}	
	
	
	public void GUNF080_UPT_APP_01_EACH(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP_01_EACH(vo, p_box);

	}			
	
	
	public void GUNF080_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_SAV(vo, p_box);

	}	
	
	
	
	public void GUNF080_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT(vo, p_box);

	}		
	
	
	public void GUNF080_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_DEL(vo, p_box);

	}	
	
	
}

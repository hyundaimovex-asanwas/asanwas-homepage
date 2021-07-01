package Ehr.gun.f.gunf085.wrk;

import Ehr.gun.f.gunf085.dao.GUNF085DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUNF085WRK {

	/**
	 * 연장근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF085_SHR(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsOvertimework = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		

		//작성 내용 조회
		dsOvertimework = dao.GUNF085_SHR(p_box);

		//결재자 정보 조회
		dsDecision = dao2.GUNF085_SHR_01(p_box);
		
		//RESPONSE로 데이터셋을 전송하는 메소드
		p_tr.setOutDataSet("dsT_DI_OVERTIMESCHEDULE", dsOvertimework);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		
	}
	
	/**
	 * 연장근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF085_SHR2(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsOvertimework = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		

		//작성 내용 조회
		dsOvertimework = dao.GUNF085_SHR(p_box);

		//결재자 정보 조회
		dsDecision = dao2.GUNF085_SHR_02(p_box);
		
		//RESPONSE로 데이터셋을 전송하는 메소드
		p_tr.setOutDataSet("dsT_DI_OVERTIMESCHEDULE", dsOvertimework);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		
	}	

	/**
	 * 트랜젝션을 수행하여 한달근무 결재상황, 한달근무 정보 관리 테이블에 상신, 결재, 전결처리내용을 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNF085_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMESCHEDULE_STATE");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		
		//	1. 결재정보 수정
		dao.GUNF085_UPT_01(p_box, vo);

		//  2. T_DI_OVERTIMSCHEDULE에 UPDATE
		dao2.GUNF085_UPT_02(p_box, vo);
		
	}


	
	/**
	 * 트랜젝션을 수행하여 개별근무 결재상황, 한달근무 정보 관리 테이블에 상신, 결재, 전결처리내용을 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNF085_SAV2( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMESCHEDULE_STATE");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		
		//	1. 결재정보 수정
		dao.GUNF085_UPT_03(p_box, vo);

		//  2. T_DI_OVERTIMSCHEDULE에 UPDATE
		dao2.GUNF085_UPT_04(p_box, vo);
		
	}	
	
}

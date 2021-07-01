package Ehr.gun.e.gune015.wrk;


import Ehr.but.a.buta025.dao.BUTA025DAO;
import Ehr.gun.e.gune015.dao.GUNE015DAO;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUNE015WRK {

	/**
	 * 연장근무 현황 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE015_SHR(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsOvertimework = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNE015DAO dao = new GUNE015DAO("default", p_tr);
		GUNE015DAO dao2 = new GUNE015DAO("default", p_tr);
		
		System.out.println("1==================="+p_box);			
		
		//작성 내용 조회
		dsOvertimework = dao.GUNE015_SHR(p_box);
		
		System.out.println("2==================="+p_box);	
		
		//결재자 정보 조회
		dsDecision = dao2.GUNE015_SHR_01(p_box);
		
		
		//RESPONSE로 데이터셋을 전송하는 메소드
		p_tr.setOutDataSet("dsT_DI_OVERTIMEWORK", dsOvertimework);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		
	}

	/**
	 * 트랜젝션을 수행하여 연장근무 결재상황, 연장근무 정보 관리 테이블에 상신, 결재, 전결처리내용을 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNE015_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMEWORK_STATE");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);
		
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNE015DAO dao = new GUNE015DAO("default", p_tr);
		GUNE015DAO dao2 = new GUNE015DAO("default", p_tr);
		


		//	1. 결재정보 수정
		dao.GUNE015_UPT_01(p_box, vo);

		//System.out.println("111111111111111111111111111111111111111");
		
		//  2. T_DI_OVERTIMEWORK에 UPDATE
		dao2.GUNE015_UPT_02(p_box, vo);
		
		
	}

	/**
	 * 트랜젝션을 수행하여 출장품의 결재상황, 출장결재자 정보 관리 테이블에 부결, 반송처리내용을 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNE015_SAV_03( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNE015DAO dao = new GUNE015DAO("default", p_tr);

		//결재내용 저장 (출장 결재자 정보 관리 테이블)
		dao.GUNE015_UPT_01(p_box, vo);

	}

}

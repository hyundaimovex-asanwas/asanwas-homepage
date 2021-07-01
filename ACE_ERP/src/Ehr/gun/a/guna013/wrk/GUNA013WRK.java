package Ehr.gun.a.guna013.wrk;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.a.guna013.dao.GUNA013DAO;


import java.sql.Connection;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.DbManager;
import Ehr.common.util.JSPUtil;

public class GUNA013WRK {

	/**
	 * 목록을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_LST(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_CHANGE",  dao.GUNA013_SHR_LST(p_box) );

	}

	/**
	 * 해당부서의 근태현황을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		GUNA013DAO dao2 = new GUNA013DAO("default", p_tr);		
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",   dao.GUNA013_SHR(p_box) );
		p_tr.setOutDataSet( "dsT_DI_APPROVAL",   dao2.GUNA013_SHR_01(p_box) );
		
	}
	
	/**
	 * 날짜로 근태코드를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_CD(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_CD",   dao.GUNA013_SHR_CD(p_box) );
		
	}
	
	
	/**
	 * 조회시 결재선이 지정되어 있지 않으면 최근 결재선 가져오고 없으면 부서장 자동지정
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_04(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		dao.GUNA013_SHR_04(p_box);
		
	}

	/**
	 * 신청번호 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		dao.GUNA013_SHR_05(p_box);
		
	}

	/**
	 * 신청번호 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_BEFORE",   dao.GUNA013_SHR_06(p_box) );
		
	}
	
	
	/**
	 * 근태변경신청서를 저장,수정 하는 WORK메소드._
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		GUNA013DAO dao2 = new GUNA013DAO("default", p_tr);		
		GUNA013DAO dao3 = new GUNA013DAO("default", p_tr);		
		GUNA013DAO dao4 = new GUNA013DAO("default", p_tr);	
		GUNA013DAO dao5 = new GUNA013DAO("default", p_tr);	
		
		String REQ_NO = "";


		if("".equals(JSPUtil.rns(p_box.get("REQ_NO")))){
			
			REQ_NO = dao.GUNA013_SHR_MAX();
			
		}else{
			
			REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));
			
		}


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
			vo.set("REQ_NO", REQ_NO);
			
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					this.GUNA013_INS(vo, p_box, p_tr);
					break;
					
				case 3:
					this.GUNA013_UPT(vo, p_box, p_tr);

				case 4:
					// delete;
					break;
			}
		}
		

		if(voList2.size() > 0){
			
			GauceValueObject vo2 = voList2.get(0);
			
			vo2.set("REQ_NO", REQ_NO);
			
			dao3.GUNA013_DEL_01(vo2, p_box);
			
		}
		
		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);

			vo2.set("REQ_NO", REQ_NO);
			
			this.GUNA013_INS_01(vo2, p_box, p_tr);

		}		

		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_TEMP",     dao5.GUNA013_SHR_01(REQ_NO) );

	}

	
	public void GUNA013_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		dao.GUNA013_INS(vo, p_box);

	}	
	
	public void GUNA013_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		dao.GUNA013_INS_01(vo, p_box);

	}		
	
	public void GUNA013_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		dao.GUNA013_UPT(vo, p_box);

	}		
	
	
	
	/**
	 * 근태변경신청서를 삭제 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNA013_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		int i = 0;

		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		/** 해당 row를 삭제한다 **/
		// delete;
		dao.GUNA013_DEL(vo, p_box);

	}


}


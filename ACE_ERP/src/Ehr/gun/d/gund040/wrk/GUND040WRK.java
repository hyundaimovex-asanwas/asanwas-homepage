package Ehr.gun.d.gund040.wrk;

import Ehr.gun.d.gund040.dao.GUND040DAO;
import Ehr.pir.a.pira013.dao.PIRA013DAO;
import Ehr.yac.a.yaca020.dao.YACA020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND040WRK {

	/**
	 * 내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** GUND040DAO 객체 생성 후 관련 메소드 호출 */
		GUND040DAO dao = new GUND040DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		dao.GUND040_SHR(p_box);

	}

	/**
	 * 개인별 연차 현황을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUND040_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** GUND040DAO 객체 생성 후 관련 메소드 호출 */
		GUND040DAO dao = new GUND040DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		p_tr.setOutDataSet( "dsT_DI_YEARLY",       dao.GUND040_SHR_02(p_box) );
		
	}
	
	/**
	 * 개인별 연차 현황을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUND040_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** GUND040DAO 객체 생성 후 관련 메소드 호출 */
		GUND040DAO dao = new GUND040DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		p_tr.setOutDataSet( "dsT_DI_CHECK",       dao.GUND040_SHR_03(p_box) );
		
	}	
	
	
	/**
	 * 개인별 근태 집계 현황을 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND040_SAV(CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUND040DAO dao = new GUND040DAO("default", p_tr);
		GUND040DAO dao2 = new GUND040DAO("default", p_tr);
		GUND040DAO dao3 = new GUND040DAO("default", p_tr);
		GUND040DAO dao4 = new GUND040DAO("default", p_tr);
		GUND040DAO dao5 = new GUND040DAO("default", p_tr);
		GUND040DAO dao6 = new GUND040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			if(i==0){
					dao.GUND040_UPT(vo, p_box);	
			}else if(i==1){
					dao2.GUND040_UPT(vo, p_box);	
			}else if(i==2){
					dao3.GUND040_UPT(vo, p_box);	
			}else if(i==3){
					dao4.GUND040_UPT(vo, p_box);	
			}else if(i==4){
					dao5.GUND040_UPT(vo, p_box);	
			}else if(i==5){
					dao6.GUND040_UPT(vo, p_box);				
			}
		}
	}

    public void GUND040_UPT_END(CBox p_box, TrBox p_tr) throws CException {
    	
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		//GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

    	//System.out.println("p_box---"+p_box);
    	
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUND040DAO dao = new GUND040DAO("default", p_tr);
		
		dao.GUND040_UPT_END(p_box);	
        
    }	
	
	

}

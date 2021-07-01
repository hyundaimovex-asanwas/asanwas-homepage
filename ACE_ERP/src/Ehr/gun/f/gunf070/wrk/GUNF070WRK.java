package Ehr.gun.f.gunf070.wrk;

import Ehr.common.util.JSPUtil;
import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.f.gunf030.dao.GUNF030DAO;
import Ehr.gun.f.gunf070.dao.GUNF070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF070WRK {

	/**
	 * 개인별 근무형태 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF070_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF070DAO dao = new GUNF070DAO("default", p_tr);
			
			dao.GUNF070_SHR(p_box);

	}

	
	public void GUNF070_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF070DAO dao = new GUNF070DAO("default", p_tr);
		
		dao.GUNF070_SHR_DTL(p_box);

	}		
	
	
	/**
	 * 개인별 근무형태를 수정 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNF070_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSTYLE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNF070DAO dao = new GUNF070DAO("default", p_tr);
		
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
					// 개인별 근무형태를 수정하기 위한 DAO메소드 호출
					this.GUNF070_UPT(vo, p_box, p_tr);
					this.GUNF070_SAV(vo, p_box, p_tr);					
					break;
					
				case 4:
					// delete;
					break;
				}
			
		}
		
	}
		
	
	public void GUNF070_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF070DAO dao = new GUNF070DAO("default", p_tr);

		dao.GUNF070_SAV(vo, p_box);

	}		
	
	
	public void GUNF070_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNF070DAO dao = new GUNF070DAO("default", p_tr);

		dao.GUNF070_UPT(vo, p_box);

	}		
	
	
	
}

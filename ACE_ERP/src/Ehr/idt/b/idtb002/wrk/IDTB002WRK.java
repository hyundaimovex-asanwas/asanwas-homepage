package Ehr.idt.b.idtb002.wrk;

import Ehr.idt.b.idtb002.dao.IDTB002DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTB002WRK {
	
	
	/**
	 * 문서신청현황을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB002_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTB002DAO dao = new IDTB002DAO("default", p_tr);
		
			 dao.IDTB002_SHR(p_box);
	}
	

	

	
	
	
	/**
	 * 문서신청 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB002_SAV(CBox p_box, TrBox p_tr) throws CException {
	
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_CONTRACT");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		IDTB002DAO dao = new IDTB002DAO("default", p_tr);
		
		//System.out.println("p_box3   =========================================== " + p_box);	
		//System.out.println("p_box"+p_box.toString());	   
		
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
					// 문서 정보를 저장하기 위한 DAO메소드 호출
					dao.IDTB002_INS(vo, p_box);
					break;
					
				case 3:
					// 문서 정보를 수정하기 위한 DAO메소드 호출
					dao.IDTB002_UPT(vo, p_box);
					break;
					
				case 4:
					// delete;
					break;		
					
			}
			
		}
		
	}
	

	/**
	 * 문서 정보를 삭제 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void IDTB002_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		IDTB002DAO dao = new IDTB002DAO("default", p_tr);

		/** 해당 row를 삭제한다 **/
		// delete;
		dao.IDTB002_DEL(p_box);

	}
    

}


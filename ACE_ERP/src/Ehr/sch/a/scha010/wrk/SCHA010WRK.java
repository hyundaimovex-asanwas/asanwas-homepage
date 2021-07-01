package Ehr.sch.a.scha010.wrk;

import Ehr.sch.a.scha010.dao.SCHA010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.FileUtils;
import com.shift.gef.support.vo.GauceValueObject;

public class SCHA010WRK {
	
	/**
	 * 학자금 지급기준 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		SCHA010DAO dao = new SCHA010DAO("default", p_tr);
		SCHA010DAO dao2 = new SCHA010DAO("default", p_tr);		
		
		dao.SCHA010_SHR(p_box);
		
		/** 개인정보처리 접속 기록  **/
		dao2.SCHA010_SHR_ACC(p_box);    	
		
	}
	
	/**
	 * 사원정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA010_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		
		SCHA010DAO dao = new SCHA010DAO("default", p_tr);
		dao.SCHA010_SHR_01(p_box);
	}
	
	/**
	 * 학자금 신청서를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA010_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_SCHLBOOK");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		SCHA010DAO dao = new SCHA010DAO("default", p_tr);
		SCHA010DAO dao2 = new SCHA010DAO("default", p_tr);
		
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
				
                    // 학자금 신청서를 저장하기 위한 DAO메소드 호출
                    dao.SCHA010_INS(vo, p_box);   
                    
        			/** 개인정보처리 접속 기록  **/
        			dao2.SCHA010_INS_ACC(p_box);    	                    
                    
					break;
				case 3:

                    // 학자금 신청서를 수정하기 위한 DAO메소드 호출
                    dao.SCHA010_UPT(vo, p_box);        
                    
        			/** 개인정보처리 접속 기록  **/
        			dao2.SCHA010_UPT_ACC(p_box);    	
        			
					break;
				case 4:
					
					// delete;
					break;					
			}
		}
	}

	/**
	 * 학자금 신청서를 삭제 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SCHA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SCHA010DAO dao = new SCHA010DAO("default", p_tr);

		/** 첨부파일을 삭제한다 **/
		if( p_box.get("FLAG").equals("1")){
			
			// 첨부파일만 삭제
			dao.SCHA010_UPT_01(p_box);
			
			FileUtils.deleteFile(p_box.get("FILE_URL"));
			
		/** 해당 row를 삭제한다 **/
		}else{
			// delete;
			dao.SCHA010_DEL(p_box);
			
			FileUtils.deleteFile(p_box.get("FILE_URL"));
			
		}
		
	}
	
}


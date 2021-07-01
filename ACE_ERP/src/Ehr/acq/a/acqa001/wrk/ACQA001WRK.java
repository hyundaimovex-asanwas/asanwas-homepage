package Ehr.acq.a.acqa001.wrk;

import Ehr.acq.a.acqa001.dao.ACQA001DAO;

import Ehr.common.util.CommUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class ACQA001WRK {
	
	/**
	 * 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA001_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA001DAO dao = new ACQA001DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA001_SHR_01(p_box));

			ACQA001DAO dao2 = new ACQA001DAO("default", p_tr);	        
	        
			dao2.ACQA001_SHR_ACC(p_box);	        
	        
	}
	
	/**
	 * 결재 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA001_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA001DAO dao = new ACQA001DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA001_SHR_APP(p_box));			

	}
	

	/**
	 * 문서를 저장, 수정 하는 WORK메소드. (결재 정보도 같이 처리)
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ACQA001_SAV( CBox p_box, TrBox p_tr ) throws CException {


		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_PLANLIST");

		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");

		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		ACQA001DAO dao  = new ACQA001DAO("default", p_tr);
		ACQA001DAO dao2 = new ACQA001DAO("default", p_tr);


		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//작성 내용을 저장하기 위한 DAO 메소드 호출
					dao.ACQA001_INS(vo, p_box);
					break;
					
				case 3:

					//작성 정보를 수정하기 위한 DAO 메소드 호출
					dao.ACQA001_UPT(vo, p_box);
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

		
		//결재자 정보 전체삭제 시작
		/*
		if(voList1.size() > 0){
			
			//dao2.ACQA001_DEL_APP(vo, p_box);
			
			for (int i=0; i<voList1.size(); i++) {

				
				GauceValueObject vo1 = voList1.get(i);	// LIST -> ROW

				this.ACQA001_INS_APP(vo1, p_box,p_tr);
				
			}
			
		}
		*/
		//결재자 정보 전체삭제 끝
		
	}
	
	
	
	
	
	
	public void ACQA001_INS_APP(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		ACQA001DAO dao = new ACQA001DAO("default", p_tr);

		dao.ACQA001_INS_APP(vo, p_box);

	}	
	
	
	/**
	 * 문서를 저장, 수정 하는 WORK메소드. (결재 정보도 같이 처리)
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ACQA001_SAV_APP( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		ACQA001DAO dao   = new ACQA001DAO("default", p_tr);

		dao.ACQA001_DEL_APP(p_box);		
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//작성 내용을 저장하기 위한 DAO 메소드 호출
					this.ACQA001_INS_APP(vo, p_box,p_tr);
					break;
					
				case 3:
					//작성 정보를 수정하기 위한 DAO 메소드 호출
					//dao.ACQA001_UPT(vo, p_box);
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

	}
	
	
	/**
	 * 문서를 상신 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ACQA001_SAV_SUB( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		ACQA001DAO dao   = new ACQA001DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//작성 내용을 저장하기 위한 DAO 메소드 호출
					this.ACQA001_SUB(vo, p_box,p_tr);
					break;
					
				case 3:
					//작성 정보를 수정하기 위한 DAO 메소드 호출
					//dao.ACQA001_UPT(vo, p_box);
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

	}	
	
	public void ACQA001_SUB(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		ACQA001DAO dao = new ACQA001DAO("default", p_tr);
		
		dao.ACQA001_SUB(vo, p_box);

	}	
	
	/**
	 * 작성 문서를 삭제 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ACQA001_DEL( CBox p_box, TrBox p_tr ) throws CException {

        //필요한 변수 선언
		ACQA001DAO dao  = new ACQA001DAO("default", p_tr);
		ACQA001DAO dao2 = new ACQA001DAO("default", p_tr);
        
        GauceValueObject voList = null;
        GauceValueObject vo = null;

        //정보 등록 자료를 가져옴
        voList = p_tr.getInGauceValueObject("dsT_ACT_PLANLIST");
        
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            /**
                * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
                *  - 1 : NORMAL
                *  - 2 : INSERT
                *  - 3 : UPDATE
                *  - 4 : DELETE
                */
            switch (vo.getInt("TX_MODE")) {
            
                case 4:
                    /** 해당 row를 삭제한다 **/
                    // delete;
                    dao.ACQA001_DEL(vo, p_box);
                    
                    break;
            }
        }

        //결재자 정보 등록 자료를 가져옴
        voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");
        /*
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            switch (vo.getInt("TX_MODE")) {
            
                case 4:
                    dao2.ACQA001_DEL_APP(p_box);
                    break;
                    
            }
            
        }
        */
	}
	
	
}


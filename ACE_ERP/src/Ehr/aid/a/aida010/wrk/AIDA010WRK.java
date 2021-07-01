package Ehr.aid.a.aida010.wrk;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.sql.Connection;

import Ehr.aid.a.aida010.dao.AIDA010DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.DbManager;
import Ehr.common.util.HuniBill;
import Ehr.common.util.JSPUtil;

public class AIDA010WRK {

	/**
	 * 경공조금 지급기준 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR(CBox p_box, TrBox p_tr) throws CException {

			AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
			dao.AIDA010_SHR(p_box);
			
	}
	
	/**
	 * 사원 및 지급내역에 따른 경공조금 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_01(p_box);
		
	}
	/**
	 * 신청목록(A2중심) 2009.12.24 By KHS.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_06(p_box);
		
	}

	/**
	 * 권한 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_02(p_box);
		
	}

	/**
	 * 신청자가 해당하는 지급금액을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_03(p_box);
		
	}

	/**
	 * 신청번호(REQ_NO)에 해당하는 신청서를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_04(CBox p_box, TrBox p_tr) throws CException {
		
		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
		
        p_tr.setOutDataSet("dsT_AD_AIDAPP",     dao.AIDA010_SHR_04(p_box));
        
        p_tr.setOutDataSet("dsT_AD_DECISION",   dao2.AIDA010_SHR_05(p_box));
        
	}

    /**
     * 근속년수를 조회해옴
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void AIDA010_SHR_LSE(CBox p_box, TrBox p_tr) throws CException {
		
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);
	    
	    dao.AIDA010_SHR_LSE(p_box);
	    
	}

    /**
     * 프린트용
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void AIDA010_SHR_PRINT0(CBox p_box, TrBox p_tr) throws CException {
		
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);
	    
	    dao.AIDA010_SHR_PRINT0(p_box);
	    
	}		
	
    /**
     * 프린트용
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void AIDA010_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {
		
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);
	    
	    dao.AIDA010_SHR_PRINT(p_box);
	    
	}	
	
	/**
	 * 경공조금 신청서를 저장, 수정 하는 WORK메소드. (결재자 정보도 같이 처리)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SAV(CBox p_box, TrBox p_tr) throws CException {
	    //필요한 변수 선언
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao3 = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao4 = new AIDA010DAO("default", p_tr);        
        
		GauceValueObject voList = null;
		
        GauceValueObject vo = null;

        String resultMsg = "";


        // 신청 정보 등록 자료를 가져옴
        voList = p_tr.getInGauceValueObject("dsT_AD_AIDAPP");
        
		vo = voList.get(0);	// LIST -> ROW

        // 신청건에 대한 유효성 검증
         resultMsg = dao.PROC_CHK(p_box, vo); //  ===============>  TEST  검증 제외

        // 유효성 검증후 결과 메세지(resultMsg) 가 비어 있으면 검증이 성공했다고 가정하고 신청건을 등록함
        if(resultMsg.equals("")) {

            // 데이타가 이미 들어 있는지 여부를 검증한 후 insert, update를 함
            if(dao2.AIDA010_CHK(vo) == 0)
            	
                dao3.AIDA010_INS(vo, p_box);
            
            else
            	
                dao3.AIDA010_UPT(vo, p_box);

            //결재자 정보 저장
            chagneDecision(dao4, p_box, p_tr);
            
        }

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	/**
	 * 경공조금 신청서를 수정하고, 결재정보를 저장 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao3 = new AIDA010DAO("default", p_tr);
        
        GauceValueObject vo = null;

        //신청 정보 등록 자료를 가져옴
        vo = p_tr.getInGauceValueObject("dsT_AD_AIDAPP").get(0);


        //상신처리할때 기본정보 업데이트 시킴
        if(JSPUtil.rns(vo.get("AID_STS")).equals("S")) {
        	
            dao.AIDA010_UPT_01(vo, p_box);

        //부결일때 결재자 정보를 수정시킴
        }else if(JSPUtil.rns(vo.get("AID_STS")).equals("R")){
        	
        	dao.AIDA010_UPT_01(vo, p_box);
        	
            dao2.AIDA010_UPT_02(vo, p_box);
            
        }
        //결재일때 결재자 정보를 수정시킴
        else if(JSPUtil.rns(vo.get("AID_STS")).equals("O")){
        	
        	dao.AIDA010_UPT_02(vo, p_box);

            // 결재 2명 다 OK 인지 여부 결정
        	// 2020.07.21 인사팀 인원 현황에 따라 결재자 수가 2명이면 2, 3명이면 3
            if(dao2.AIDA010_CHK_02(vo) == 2)
            	
            	dao3.AIDA010_UPT_OK(vo, p_box);
            
            else{

        		dao3.AIDA010_UPT_02_NEXT(vo, p_box);
        		
           }
        }
	}


    /**
     * 결재자 정보가 바뀌었을때 결재자 처리를 해줌
     * @param dao
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    private void chagneDecision(AIDA010DAO dao, CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        //결재자 정보 등록 자료를 가져옴
        voList = p_tr.getInGauceValueObject("dsT_AD_DECISION");

        for(int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            this.AIDA010_INS_01(vo, p_box, p_tr);
            
        }
    }

    
	public void AIDA010_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {

        //필요한 변수 선언
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);

        dao.AIDA010_INS_01(vo, p_box);
        
	}
	
    
    
	/**
	 * 경공조금 신청서를 삭제 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void AIDA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

        //필요한 변수 선언
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
        
        GauceValueObject voList = null;
        GauceValueObject vo = null;

        //신청 정보 등록 자료를 가져옴
        voList = p_tr.getInGauceValueObject("dsT_AD_AIDAPP");
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
                    dao.AIDA010_DEL(vo, p_box);
                    
                    break;
            }
        }

        //결재자 정보 등록 자료를 가져옴
        voList = p_tr.getInGauceValueObject("dsT_AD_DECISION");
        
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
                    dao2.AIDA010_DEL_01(vo, p_box);
                    break;
                    
            }
            
        }

	}

	/**
	 * 경공조금 전표처리 로직
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PROC_D( CBox p_box, TrBox p_tr ) throws CException {
	    /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);

	    //dao.PROC_D(p_box);

		/*
        // 1. 세팅할값조회
        // 2. Huni-Bills 에 저장
        // 3. Procedure 호출
        // 4. 우리쪽 Table에 Update한다
        // 5. 첨부문서를 만들어준다(html)
         */
        try{
	        // 1. 세팅할값 조회
	        GauceDataSet ds = dao.AIDA010_PRC_SHR_01(p_box);
	        if(ds.getDataRowCnt() > 0){

	        	String returnValue = "0";

        		if("0".equals(returnValue)){
            		//4.출장전표Table에 Update
            		p_box.set("WRK_NO1", p_box.get("REQ_NO"));
                    dao.AIDA010_PRC_UPT_01(p_box);  //경조금전표정보 Update

            		//5.html을 생성한다

                    GauceDataSet dsFile = dao.AIDA010_PRC_SHR_02(ds);		// 첨부파일내역 조회
                    GauceDataSet dsDecision = dao.AIDA010_SHR_05(p_box);
            		dao.AIDA010_PRC_MAKE_HTML(p_box, ds, dsDecision, dsFile);
            	}else if("1".equals(returnValue)){
            		throw new CException("SAP을 호출하는중  Error가 발생했습니다 !!");
            	}else if("2".equals(returnValue)){
            		throw new CException("HUNI-BILLS의 Procedure를 수행중 Error가 발생했습니다 !!");
            	}else if("3".equals(returnValue)){
            		throw new CException("SAP, HUNI-BILLS의 Procedure를 수행중 Error가 발생했습니다 !!");
            	}else{

            		//conn.rollback();
            		throw new CException("전표생성중 Error가 발생했습니다 !!");
            	}
        		//conn.commit();

	        }
        }catch(Exception e){
    		throw new CException(e.getMessage());
        }

	}

    /**
     * 경공조금 지급처리 로직
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void PROC_E( CBox p_box, TrBox p_tr ) throws CException {
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);

        dao.PROC_E(p_box);
    }
}

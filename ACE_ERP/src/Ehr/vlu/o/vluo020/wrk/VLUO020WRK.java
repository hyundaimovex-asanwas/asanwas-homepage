package Ehr.vlu.o.vluo020.wrk;

import java.util.Date;

import Ehr.vlu.o.vluo010.dao.VLUO010DAO;
import Ehr.vlu.o.vluo020.dao.VLUO020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;
import Ehr.eis.t.eist020.dao.EIST020DAO;

import java.io.File;
import java.io.IOException;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class VLUO020WRK {

    /**
     * 조회 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO020_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표설정/세부추진계획 (조회) DAO CLASS 메서드 호출 * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);
		
		dao.VLUO020_SHR(p_box);

	}

	/**
     * 조회  WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 개인별평가일정 조회 DAO CLASS 메서드 호출 * */
        VLUO020DAO dao = new VLUO020DAO("default", p_tr);
        
        dao.VLUO020_SHR_01(p_box);

    }




    /**
     * 목표설정 (입력,수정,삭제) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		// 목표설정 전체 삭제 후 저장
		try {
			
			dao.VLUO020_DEL_01(p_box, voList.get(0));
			
		}catch(Exception ex) {
			
		}


		for (int i=0; i<voList.size(); i++) {
			
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:

                    break;
                    
			    case 2:

			    	this.VLUO020_INS(vo, p_box, p_tr);
			    	break;
			    	
			    case 3:

			    	this.VLUO020_INS(vo, p_box, p_tr);
				    break;
				    
			    case 4:

                    break;
			}
		}
	}

	
	public void VLUO020_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_INS(p_box, vo);

	}		
	

	
	  /**
     * 상신처리 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO020_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		for (int i=0; i<voList.size(); i++) {
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:

                    break;
			    case 2:
			    		
			    	// 
			    	this.VLUO020_SAV_01(p_box, vo, p_tr);
			    	break;
			    case 3:

				    break;
			    case 4:

                    break;
			}
		}

		
	}

	public void VLUO020_SAV_01(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/	
		
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_SAV_01(p_box, vo);

	}		
	
	public void VLUO020_SAV_011(CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/	

		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_SAV_011(p_box);

	}		
	
	
    /**
     * 목표설정 (입력,수정,삭제) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO020_UPT(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		// 목표설정 전체 삭제 후 저장
		try {
			
			dao.VLUO020_DEL_01(p_box, voList.get(0));
			
		}catch(Exception ex) {
			
		}


		for (int i=0; i<voList.size(); i++) {
			
			GauceValueObject vo = voList.get(i);

            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:

                    break;
                    
			    case 2:

			    	this.VLUO020_INS2(vo, p_box, p_tr);
			    	break;
			    	
			    case 3:

			    	//this.VLUO020_INS(vo, p_box, p_tr);
				    break;
				    
			    case 4:

                    break;
			}
		}
	}
	
	
	public void VLUO020_INS2(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_INS2(p_box, vo);

	}		
	
    /**
     * 목표설정 (삭제) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO020_DEL(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성 * */
        VLUO020DAO dao = new VLUO020DAO("default", p_tr);
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        for (int i=0; i<voList.size(); i++) {
            GauceValueObject vo = voList.get(i);
            /**
             * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
            switch(vo.getInt("TX_MODE")) {
            case 1:
                break;
                
            case 2:
                break;
                
            case 3:
                break;
                
            case 4:
            	
                dao.VLUO020_DEL(p_box, vo);
                
                break;
                
            }
        }

    }
}

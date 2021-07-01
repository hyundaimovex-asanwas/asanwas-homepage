package Ehr.vlu.o.vluo070.wrk;

import Ehr.vlu.o.vluo070.dao.VLUO070DAO;

import java.util.Date;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;
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

public class VLUO070WRK {

    /**
     * 목표설정 (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO070_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 목표설정/세부추진계획 (조회) DAO CLASS 메서드 호출 * */
		VLUO070DAO dao = new VLUO070DAO("default", p_tr);
		
		dao.VLUO070_SHR(p_box);

	}

	/**
     * 팀  조회  WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO070_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 개인별평가일정 조회 DAO CLASS 메서드 호출 * */
        VLUO070DAO dao = new VLUO070DAO("default", p_tr);
        
        dao.VLUO070_SHR_TEAM(p_box);

    }


	/**
     * FILE 조회  WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void VLUO070_SHR_FILE(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 개인별평가일정 조회 DAO CLASS 메서드 호출 * */
        VLUO070DAO dao = new VLUO070DAO("default", p_tr);
        
        dao.VLUO070_SHR_FILE(p_box);

    }    
    
    /**
     * 목표설정 (입력,수정,삭제) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO070_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO070DAO dao = new VLUO070DAO("default", p_tr);
		
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

			    	this.VLUO070_INS(vo, p_box, p_tr);
			    	break;
			    case 3:

			    	this.VLUO070_INS(vo, p_box, p_tr);
				    //dao.VLUO070_UPT(p_box, vo);
				    break;
			    case 4:

                    break;
			}
		}
	}

	
	public void VLUO070_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/		
		
		VLUO070DAO dao = new VLUO070DAO("default", p_tr);

		dao.VLUO070_INS(p_box, vo);

	}		
	
	
	
    
    /**
     * 파일 입력,수정  WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void VLUO070_SAV_FILE(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		VLUO070DAO dao = new VLUO070DAO("default", p_tr);
		
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
			    	
			    	this.VLUO070_INS_FILE(vo, p_box, p_tr);
			    	break;
			    case 3:

			    	this.VLUO070_UPT_FILE(vo, p_box, p_tr);
				    //dao.VLUO070_UPT(p_box, vo);
				    break;
			    case 4:

                    break;
			}
		}
	}
	
	public void VLUO070_INS_FILE(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/		
		
		VLUO070DAO dao = new VLUO070DAO("default", p_tr);

		dao.VLUO070_INS_FILE(p_box, vo);

	}		

	public void VLUO070_UPT_FILE(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/		
		
		VLUO070DAO dao = new VLUO070DAO("default", p_tr);

		dao.VLUO070_UPT_FILE(p_box, vo);

	}		

}

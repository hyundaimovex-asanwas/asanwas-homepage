package Ehr.cdp.a.book010.wrk;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.cdp.a.book010.dao.BOOK010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK010WRK {

	/**
	 * 도서신청 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	
	private BOOK010DAO dao = null;
	private String connectionName = "default";   
	
	private BOOK010DAO dao2 = null;
	private String connectionName2 = "default";  	
	
	
	public void BOOK010_SHR(CBox p_box, TrBox p_tr) throws CException {
		
			BOOK010DAO dao = new BOOK010DAO("default", p_tr);
			
			dao.BOOK010_SHR(p_box);
			
	}

	/**
	 * DETAIL 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK010_SHR_02(CBox p_box, TrBox p_tr) throws CException {
		
		BOOK010DAO dao = new BOOK010DAO("default", p_tr);
		
		dao.BOOK010_SHR_02(p_box);
		
	}

	/**
	 * 신청번호 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK010_SHR_03(CBox p_box, TrBox p_tr) throws CException {
		
		BOOK010DAO dao = new BOOK010DAO("default", p_tr);
		
		dao.BOOK010_SHR_03(p_box);
		
	}



	/**
	 * 도서구입신청 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BOOK010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = null;
        GauceValueObject vo = null;

		GauceValueObject voList2 = null;
        GauceValueObject vo2 = null;

		GauceValueObject voList3 = null;
        GauceValueObject vo3 = null;

        BOOK010DAO dao = new BOOK010DAO("default", p_tr);        
        
        //dao = new BOOK010DAO(connectionName, p_tr);
        //dao2 = new BOOK010DAO(connectionName2, p_tr); 
      
        /**
         * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

		//도서구입신청건을 등록한다.

        voList = p_tr.getInGauceValueObject("dsT_ED_BOOKMASTER");

		for (int i=0; i<voList.size(); i++) {
			
			vo = voList.get(i);
			
            tx_mode = vo.getInt("TX_MODE");

            if(tx_mode == 2)
                dao.BOOK010_INS(p_box, vo);
            else if(tx_mode == 3)
                dao.BOOK010_UPT(p_box, vo);
            else if(tx_mode == 4)
                dao.BOOK010_DEL(p_box, vo);
            
		}
		

        voList2 = p_tr.getInGauceValueObject("dsT_ED_BOOKDETAIL");

		for (int i=0; i<voList2.size(); i++) {
			
			vo2 = voList2.get(i);
			
            tx_mode = vo2.getInt("TX_MODE");

            if(tx_mode == 2)
            	this.BOOK010_INS_02(p_box, vo2, p_tr);

		}


		//결재선을 처음 저장한다.
		voList3 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		for (int i=0; i<voList3.size(); i++) {
			
			vo3       = voList3.get(i);
			
			tx_mode  = vo3.getInt("TX_MODE");

		    if(!JSPUtil.rns(vo3.getString("ENO_NO")).equals("")&& (tx_mode == 2||tx_mode == 3))
		    	this.BOOK010_SAV_APP1(p_box, vo3, p_tr);
		                
		}
		
	}


	public void BOOK010_INS_02(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		BOOK010DAO dao = new BOOK010DAO("default", p_tr);

		dao.BOOK010_INS_02(p_box, vo);

	}		
	
	public void BOOK010_SAV_APP1(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		BOOK010DAO dao = new BOOK010DAO("default", p_tr);

		dao.BOOK010_SAV_APP1(p_box, vo);

	}	
	
    /**
     * 상신처리한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void BOOK010_UPT_APP(CBox p_box, TrBox p_tr) throws CException {

    	//BOOK010DAO dao = new BOOK010DAO("default", p_tr);
    	dao = new BOOK010DAO(connectionName, p_tr);

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        int tx_mode = 0;

        dao.BOOK010_DEL2(p_box);

		//결재선을 저장한다.
        voList = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		for (int i=0; i<voList.size(); i++) {

			vo       = voList.get(i);
			tx_mode  = vo.getInt("TX_MODE");

            if(!JSPUtil.rns(vo.getString("ENO_NO")).equals("")
                    && (tx_mode == 2||tx_mode == 3))

            	dao = new BOOK010DAO(connectionName, p_tr);
                dao.BOOK010_SAV_APP2(p_box, vo);

		}

		dao = new BOOK010DAO(connectionName, p_tr);
        dao.BOOK010_UPT_MST(p_box);
    }



	/**
	 * 도서구입 팝업 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK010_SHR_11(CBox p_box, TrBox p_tr) throws CException {
		BOOK010DAO dao = new BOOK010DAO("default", p_tr);
		dao.BOOK010_SHR_11(p_box);
	}


	/**
	 * 도서구입 팝업 결재선 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK010_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
		BOOK010DAO dao = new BOOK010DAO("default", p_tr);
		dao.BOOK010_SHR_APP(p_box);
	}


}

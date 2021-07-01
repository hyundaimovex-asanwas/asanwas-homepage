package Ehr.cdp.a.book030.wrk;

import Ehr.cdp.a.book030.dao.BOOK030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK030WRK {

	/**
	 * ������û ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK030_SHR(CBox p_box, TrBox p_tr) throws CException {
			BOOK030DAO dao = new BOOK030DAO("default", p_tr);
			dao.BOOK030_SHR(p_box);
	}

	/**
	 * DETAIL ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK030_SHR_02(CBox p_box, TrBox p_tr) throws CException {
		BOOK030DAO dao = new BOOK030DAO("default", p_tr);
		dao.BOOK030_SHR_02(p_box);
	}

	
	public void BOOK030_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {
		BOOK030DAO dao = new BOOK030DAO("default", p_tr);
		dao.BOOK030_SHR_PRINT(p_box);
	}
	
	public void BOOK030_SHR_PRINT2(CBox p_box, TrBox p_tr) throws CException {
		BOOK030DAO dao = new BOOK030DAO("default", p_tr);
		dao.BOOK030_SHR_PRINT2(p_box);
	}	
	
	
	/**
	 * ��û��ȣ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK030_SHR_03(CBox p_box, TrBox p_tr) throws CException {
		BOOK030DAO dao = new BOOK030DAO("default", p_tr);
		dao.BOOK030_SHR_03(p_box);
	}

	/**
	 * �������Խ�û ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BOOK030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = null;
        GauceValueObject vo = null;

		GauceValueObject voList2 = null;
        GauceValueObject vo2 = null;

		BOOK030DAO dao = new BOOK030DAO("default", p_tr);

        /**
         * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

		//�������Խ�û���� ����Ѵ�.

        voList = p_tr.getInGauceValueObject("dsT_ED_BOOKMASTER");

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);
            tx_mode = vo.getInt("TX_MODE");

            if(tx_mode == 2)
                dao.BOOK030_INS(p_box, vo);
            else if(tx_mode == 3)
                dao.BOOK030_UPT(p_box, vo);
            else if(tx_mode == 4){
                dao.BOOK030_DEL(p_box, vo);
            }
		}

        voList2 = p_tr.getInGauceValueObject("dsT_ED_BOOKDETAIL");

		for (int i=0; i<voList2.size(); i++) {
			vo2 = voList2.get(i);
            tx_mode = vo2.getInt("TX_MODE");

            if(tx_mode == 2)
                dao.BOOK030_INS_02(p_box, vo2);
            //else if(tx_mode == 3)
            //    dao.BOOK030_UPT2(p_box, vo);
            //else if(tx_mode == 4){
            //    dao.BOOK030_DEL2(p_box, vo);

		}
	}


	/**
	 * ���ϱٹ��ް���û ���缱 ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK030_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		BOOK030DAO dao = new BOOK030DAO("default", p_tr);
		dao.BOOK030_SHR_01(p_box);
	}


    /**
     * ������ ������ �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void BOOK030_UPT_APP(CBox p_box, TrBox p_tr) throws CException {

    	BOOK030DAO dao = new BOOK030DAO("default", p_tr);

        GauceValueObject voList = null;
        GauceValueObject vo = null;
        int tx_mode = 0;

        dao.BOOK030_DEL2(p_box);

		//���缱�� �����Ѵ�.
        voList = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		for (int i=0; i<voList.size(); i++) {
			vo       = voList.get(i);
			tx_mode  = vo.getInt("TX_MODE");

            if(!JSPUtil.rns(vo.getString("ENO_NO")).equals("")
                    && (tx_mode == 2
                            ||tx_mode == 3))
                dao.BOOK030_SAV_APP(p_box, vo);
		}

        dao.BOOK030_UPT_HOL(p_box);
    }


	/**
	 * ������Ȳ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK030_SHR_40(CBox p_box, TrBox p_tr) throws CException {
		BOOK030DAO dao = new BOOK030DAO("default", p_tr);
		dao.BOOK030_SHR_40(p_box);
	}

}

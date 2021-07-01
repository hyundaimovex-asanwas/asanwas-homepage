package Ehr.cdp.a.book020.wrk;

import Ehr.cdp.a.book020.dao.BOOK020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK020WRK {

	/**
	 * ������û ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK020_SHR(CBox p_box, TrBox p_tr) throws CException {

			BOOK020DAO dao = new BOOK020DAO("default", p_tr);

			dao.BOOK020_SHR(p_box);

	}


	public void BOOK020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		BOOK020DAO dao = new BOOK020DAO("default", p_tr);

		dao.BOOK020_SHR_02(p_box);

	}


	/**
	 * ���ϱٹ��ް���û ���缱 ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK020_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		BOOK020DAO dao = new BOOK020DAO("default", p_tr);
		dao.BOOK020_SHR_01(p_box);
	}

	/**
	 * �������Խ�û ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BOOK020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = null;
        GauceValueObject vo = null;

		BOOK020DAO dao = new BOOK020DAO("default", p_tr);


		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(p_box);

        /**
         * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

        String GUN_GBN = p_box.getString("GUN_GBN");

		//�������Խ�û���� ����Ѵ�.

        voList = p_tr.getInGauceValueObject("dsT_ED_BOOKMASTER");

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);
            tx_mode = vo.getInt("TX_MODE");

            if(tx_mode == 2)
                dao.BOOK020_INS(p_box, vo);
            else if(tx_mode == 3)
                dao.BOOK020_UPT(p_box, vo);
            else if(tx_mode == 4){
                dao.BOOK020_DEL(p_box, vo);
                if(GUN_GBN.equals("R")){
                dao.BOOK020_DEL2(p_box);
                }
            }
		}

		//���缱�� �����Ѵ�.
/*        voList = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		for (int i=0; i<voList.size(); i++) {
			vo       = voList.get(i);
			tx_mode  = vo.getInt("TX_MODE");

            if(!JSPUtil.rns(vo.getString("ENO_NO")).equals("")
                    && (tx_mode == 2
                            ||tx_mode == 3))
                dao.BOOK020_SAV_APP(p_box, vo);
		}*/
	}

    /**
     * ������ ������ �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void BOOK020_UPT_APP(CBox p_box, TrBox p_tr) throws CException {

    	BOOK020DAO dao = new BOOK020DAO("default", p_tr);

        GauceValueObject voList = null;
        GauceValueObject vo = null;
        int tx_mode = 0;

        dao.BOOK020_DEL2(p_box);

		//���缱�� �����Ѵ�.
        voList = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		for (int i=0; i<voList.size(); i++) {
			vo       = voList.get(i);
			tx_mode  = vo.getInt("TX_MODE");

            if(!JSPUtil.rns(vo.getString("ENO_NO")).equals("")
                    && (tx_mode == 2
                            ||tx_mode == 3))
                dao.BOOK020_SAV_APP(p_box, vo);
		}

        dao.BOOK020_UPT_HOL(p_box);
    }


	/**
	 * DETAIL ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */



	/**
	 * 5�Ͽ��� ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK020_SHR_03(CBox p_box, TrBox p_tr) throws CException {
		BOOK020DAO dao = new BOOK020DAO("default", p_tr);
		dao.BOOK020_SHR_03(p_box);
	}
}

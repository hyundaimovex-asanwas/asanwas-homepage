package Ehr.sag.a.saga260.wrk;

import Ehr.sag.a.saga260.dao.SAGA260DAO;
import Ehr.vlu.l.vlul020.dao.VLUL020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGA260WRK {

	/**
	 * �系 ������Ȳ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR(p_box);

	}


	/**
	 * �系 ������Ȳ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR_01(p_box);

	}


	/**
	 * �系 ������Ȳ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR_02(p_box);

	}

	/**
	 * �系 ������Ȳ PRINT ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR_PRINT(p_box);

	}

	/**
	 * �系 ������Ȳ ����
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SAV(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;


		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);

        /**
         * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

        //voList = p_tr.getInGauceValueObject("dsT_Loan_Temp");

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);
            tx_mode = vo.getInt("TX_MODE");

            if(tx_mode == 2)
                dao.SAGA260_SAV(p_box, vo);

		}

	}


	/**
	 * �系 ������Ȳ ����(��ȯ ����)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SAV_01(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);

        /**
         * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

		for (int i=0; i<voList.size(); i++) {

			vo = voList.get(i);

            tx_mode = vo.getInt("APPCNT");

            if(tx_mode == 1)
                dao.SAGA260_SAV_01_UPT(p_box, vo);

            else
                dao.SAGA260_SAV_01(p_box, vo);

		}

	}

	/**
	 * �系 ���� ��ȯ ����(DETAIL)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SAV_DELAY(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		SAGA260DAO dao2 = new SAGA260DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {

			vo = voList.get(i);


	        int tx_mode = 0;

            tx_mode = vo.getInt("APPCNT");

            if(tx_mode == 1){	     //ó���� �ѹ��� ������~

            dao.SAGA260_SAV_DELAY_DEL(p_box, vo);

            }

            //dao2.SAGA260_SAV_DELAY(p_box, vo);
            this.SAGA260_SAV_DELAY(vo, p_box,p_tr);

		}

	}
	
	
	public void SAGA260_SAV_DELAY(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);

        dao.SAGA260_SAV_DELAY(p_box, vo);

	}		

}

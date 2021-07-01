package Ehr.vlu.k.vluk060.wrk;

import Ehr.vlu.k.vluk060.dao.VLUK060DAO;


import Ehr.vlu.o.vluo060.dao.VLUO060DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK060WRK {

	/**
	 * �ش� �⵵�� ���� �򰡱��� ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK060_SHR(CBox p_box, TrBox p_tr) throws CException {

			VLUK060DAO dao = new VLUK060DAO("default", p_tr);
			dao.VLUK060_SHR(p_box);

	}

	public void VLUK060_SHR02(CBox p_box, TrBox p_tr) throws CException {

		VLUK060DAO dao = new VLUK060DAO("default", p_tr);
		dao.VLUK060_SHR02(p_box);

}

	/**
	 * �򰡱��� ���������� ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void VLUK060_SAV( CBox p_box, TrBox p_tr ) throws CException {

		System.out.println(p_box);

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQGROUP");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
				* Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
				case 2:
					// �򰡱��� ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.VLUK060_DEL_01(vo, p_box, p_tr);		
					this.VLUK060_DEL_02(vo, p_box, p_tr);						
					this.VLUK060_INS_01(vo, p_box, p_tr);
					this.VLUK060_INS_02(vo, p_box, p_tr);					
					break;
				case 3:
					// �򰡱��� ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ
					this.VLUK060_UPT(vo, p_box, p_tr);
					break;
				case 4:
					// delete;

					break;
				}
			}
	}

	
	
	public void VLUK060_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/		
		
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		dao.VLUK060_INS_01(vo, p_box);

	}	
	
	public void VLUK060_INS_02(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/		
		
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		dao.VLUK060_INS_02(vo, p_box);

	}	
	

	public void VLUK060_DEL_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

        dao.VLUK060_DEL_01(vo, p_box);

	}		
	
	public void VLUK060_DEL_02(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

        dao.VLUK060_DEL_02(vo, p_box);

	}		
	
	
	public void VLUK060_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

        dao.VLUK060_UPT(vo, p_box);

	}		
	
	/**
	 * ���ǥ ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void VLUK060_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSHEET");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		VLUK060DAO dao = new VLUK060DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
			case 4:
//				 ���ǥ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
				dao.VLUK060_DEL(vo, p_box);
				break;

		}


		}
	}


}


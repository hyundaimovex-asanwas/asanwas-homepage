package Ehr.but.a.buta021.wrk;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.but.a.buta021.dao.BUTA021DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class BUTA021WRK {

	/**
	 * �������ޱ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_01(p_box);

	}

	/**
	 * ���޿� ���� �ܰ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_02(p_box);

	}

	/**
	 * �ĺ������ ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_03(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_03(p_box);

	}

	/**
	 * �����꼭�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR(p_box);

	}


	/**
	 * Ʈ�������� �����Ͽ� �����꼭�� ����,����,�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BUTA021_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_BASIS");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA021DAO dao = new BUTA021DAO("default", p_tr);


		//������ ������ insert
		GauceValueObject vo = voList.get(0);
		
		dao.BUTA021_DEL_01(vo, p_box);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			//dao.BUTA021_INS(vo, p_box);


			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					
					//�����꼭�� �����ϴ� DAO �޼ҵ� ȣ��
					this.BUTA021_INS(vo, p_box, p_tr);
					break;

				case 3:
					
					//�����꼭�� �����ϴ� DAO �޼ҵ� ȣ��
					this.BUTA021_UPT(vo, p_box, p_tr);
					break;

				case 4:
					
					//�����꼭�� �����ϴ� DAO �޼ҵ� ȣ��
					dao.BUTA021_DEL(vo, p_box);
					break;
			}

		}
	}

	
	public void BUTA021_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		BUTA021DAO dao = new BUTA021DAO("default", p_tr);

		dao.BUTA021_INS(vo, p_box);

	}		
	
	public void BUTA021_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		BUTA021DAO dao = new BUTA021DAO("default", p_tr);

		dao.BUTA021_UPT(vo, p_box);

	}		
	
	/**
	 * ����ǰ�� ��Ȳ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA021_SHR_04(CBox p_box, TrBox p_tr) throws CException {

			BUTA021DAO dao = new BUTA021DAO("default", p_tr);
			dao.BUTA021_SHR_04(p_box);

	}
}

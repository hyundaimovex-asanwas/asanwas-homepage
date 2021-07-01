package Ehr.gun.a.guna100.wrk;

import Ehr.gun.a.guna100.dao.GUNA100DAO;
import Ehr.ins.a.insa050.dao.INSA050DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA100WRK {

	/**
	 * ���κ� ���� ���� ��Ȳ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNA100_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** GUNA100DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

        /** ���κ� ���� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.GUNA100_SHR(p_box);

	}

	/**
	 * ���κ� ���� ��Ȳ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNA100_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** GUNA100DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

        /** ���κ� ���� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		p_tr.setOutDataSet( "dsT_DI_YEARLY",       dao.GUNA100_SHR_02(p_box) );
		
	}


	/**
	 * ���κ� ���� ���� ��Ȳ�� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA100_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

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
					
					// insert
					break;
					
				case 3:
					
					// ������Ȳ�� �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.GUNA100_UPT(vo, p_box, p_tr);
					break;
					
				case 4:
					
					// delete;
					break;
					
			}
			
		}
		
	}


	public void GUNA100_UPT(GauceValueObject vo, CBox p_box,  TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA100DAO dao = new GUNA100DAO("default", p_tr);

		dao.GUNA100_UPT(vo, p_box);

	}		
	
}


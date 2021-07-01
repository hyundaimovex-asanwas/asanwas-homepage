package Ehr.eis.t.eist030.wrk;

import Ehr.eis.t.eist010.dao.EIST010DAO;
import Ehr.eis.t.eist030.dao.EIST030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST030WRK {
	
	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST030DAO dao = new EIST030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST030_SHR(p_box);

	}
	
	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST030_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

		/** EIST030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST030DAO dao = new EIST030DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST030_SHR_TEAM(p_box);

	}
	
	
	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST030_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PROJECT");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST030DAO dao = new EIST030DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {
				
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			System.out.println("vo0========="+vo);
			/** 
				* Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
				case 2:
					// �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					this.EIST030_INS(vo, p_box, p_tr);
					break;
					
				case 3:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.EIST030_UPT(vo, p_box, p_tr);
					break;
				
			}
		}
	}
	
	public void EIST030_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		
		EIST030DAO dao = new EIST030DAO("default", p_tr);

		dao.EIST030_INS(vo, p_box);

	}		
	
	public void EIST030_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		
		System.out.println("vo1========="+vo);
		
		EIST030DAO dao = new EIST030DAO("default", p_tr);

		dao.EIST030_UPT(vo, p_box);

	}			
	
	
	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST030_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST030DAO dao = new EIST030DAO("default", p_tr);
		
				
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
			
				case 4:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.EIST030_DEL(vo, p_box);
					
					break;
				
			}
		}

	}
	
	
}


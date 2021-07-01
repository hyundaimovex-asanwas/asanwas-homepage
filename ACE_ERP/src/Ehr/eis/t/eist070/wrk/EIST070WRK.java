package Ehr.eis.t.eist070.wrk;

import Ehr.eis.t.eist010.dao.EIST010DAO;
import Ehr.eis.t.eist070.dao.EIST070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST070WRK {
	
	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST070_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST070DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST070DAO dao = new EIST070DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST070_SHR(p_box);

	}
	
	
	/**
	 * ������Ʈ ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST070_SHR_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** EIST070DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST070DAO dao = new EIST070DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST070_SHR_PJT(p_box);

	}	

	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST070_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PROJECT");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST070DAO dao = new EIST070DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {
				
			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
			
			//System.out.println("vo0========="+vo);
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
					//this.EIST070_INS(vo, p_box, p_tr);
					break;
					
				case 3:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					//this.EIST070_UPT(vo, p_box, p_tr);
					break;
				
			}
		}
	}
	
	public void EIST070_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		
		EIST070DAO dao = new EIST070DAO("default", p_tr);

		dao.EIST070_INS(vo, p_box);

	}		
	

	public void EIST070_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		EIST070DAO dao = new EIST070DAO("default", p_tr);

		dao.EIST070_UPT(vo, p_box);

	}			
	
	
	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST070_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST070DAO dao = new EIST070DAO("default", p_tr);
		
				
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
					dao.EIST070_DEL(vo, p_box);
					
					break;
				
			}
		}

	}
	
	
}


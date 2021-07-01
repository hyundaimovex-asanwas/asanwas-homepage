package Ehr.sch.a.scha090.wrk;

import Ehr.sch.a.scha090.dao.SCHA090DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SCHA090WRK {
	
	/**
	 * ���ڱ� ��û�Ⱓ ������ ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SCHA090_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** SCHA090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		SCHA090DAO dao = new SCHA090DAO("default", p_tr);

        /** ���ڱ� ��û�Ⱓ ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.SCHA090_SHR(p_box);

	}
	
	public void SCHA090_SHR2(CBox p_box, TrBox p_tr) throws CException {

		/** SCHA090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		SCHA090DAO dao = new SCHA090DAO("default", p_tr);

        /** ���ڱ� ��û�Ⱓ ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.SCHA090_SHR2(p_box);

	}	
	
	/**
	 * ���ڱ� ��û�Ⱓ ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA090_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_RQSTYMD");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		SCHA090DAO dao = new SCHA090DAO("default", p_tr);
		
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
					// ���ڱ� ��û�Ⱓ ������ �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					dao.SCHA090_INS(vo, p_box);
					break;
					
				case 3:
					// ���ڱ� ��û�Ⱓ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.SCHA090_UPT(vo, p_box);
					break;
				
			}
		}
	}
	
	/**
	 * ���ڱ� ��û�Ⱓ ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA090_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_RQSTYMD");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		SCHA090DAO dao = new SCHA090DAO("default", p_tr);
		
				
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
					// ���ڱ� ��û�Ⱓ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.SCHA090_DEL(vo, p_box);
					break;
				
			}
		}

	}
	
	
}


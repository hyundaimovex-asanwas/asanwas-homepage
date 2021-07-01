package Ehr.eis.t.eist020.wrk;

import Ehr.common.util.JSPUtil;
import Ehr.eis.t.eist020.dao.EIST020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST020WRK {
	
	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST020_SHR(p_box);

	}
	
	
	/**
	 * �Ҽ� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST020_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST020_SHR_TEAM(p_box);

	}	
	
	
	/**
	 * ���ں� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST020_SHR_DAY(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST020_SHR_DAY(p_box);

	}	
	
	/**
	 * ������Ʈ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST020_SHR_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST020_SHR_PJT(p_box);

	}	
	
	/**
	 * ������ ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST020_SHR_PER(CBox p_box, TrBox p_tr) throws CException {

		/** EIST020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST020DAO dao = new EIST020DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST020_SHR_PER(p_box);

	}		
	
	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
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
					// �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					dao.EIST020_INS(vo, p_box);
					break;
					
				case 3:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
	}
	
	/**
	 * ���ں� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_UPT_DAY(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_DAY_02");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
		// ��ť�� ������
		//try {
		//	dao.EIST020_UPT_DAY_01(p_box, voList.get(0));
		//}catch(Exception ex) {
			
		//}		
		

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
					// �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					this.EIST020_UPT_DAY_01(vo, p_box, p_tr);
					break;
					
				case 3:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					//dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
		
		
	}	
	
	public void EIST020_UPT_DAY(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_DAY_01(p_box, vo);

	}		
	
	public void EIST020_UPT_DAY_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_DAY_01(p_box, vo);

	}		
	

	/**
	 * ������Ʈ�� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_UPT_PJT(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PROJECT_02");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
		// ��ť�� ������
		//try {
		//	dao.EIST020_UPT_PJT_01(p_box, voList.get(0));
		//}catch(Exception ex) {
		//	
		//}				
		

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
					// �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					this.EIST020_UPT_PJT_01(vo, p_box, p_tr);
					break;
					
				case 3:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					//dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
	}	
	
	public void EIST020_UPT_PJT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/	
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PJT(vo, p_box);

	}			
	
	public void EIST020_UPT_PJT_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/	
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PJT_01(p_box, vo);

	}
	
	/**
	 * ������Ʈ�� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_UPT_PER(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_PERSON_02");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
		// ��ť�� ������
		//try {
		//	dao.EIST020_UPT_PER_01(p_box, voList.get(0));
		//}catch(Exception ex) {
		//	
		//}			
		
		
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
					// �Է��ϱ� ���� DAO�޼ҵ� ȣ��
					this.EIST020_UPT_PER_01(vo, p_box, p_tr);
					break;
					
				case 3:
					// �����ϱ� ���� DAO�޼ҵ� ȣ��
					//dao.EIST020_UPT(vo, p_box);
					break;
				
			}
		}
	}	
	
	public void EIST020_UPT_PER(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PER(vo, p_box);

	}		
	
	public void EIST020_UPT_PER_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);

		dao.EIST020_UPT_PER_01(p_box, vo);

	}		
	
	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST020_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EIS_TIMESHEET");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST020DAO dao = new EIST020DAO("default", p_tr);
		
				
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
					dao.EIST020_DEL(vo, p_box);
					
					break;
				
			}
		}

	}
	
	
}


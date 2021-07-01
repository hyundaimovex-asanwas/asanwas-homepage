package Ehr.gun.f.gunf080.wrk;

import Ehr.gun.f.gunf080.dao.GUNF080DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF080WRK {

	/**
	 * ���κ� �ٹ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF080_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF080DAO dao = new GUNF080DAO("default", p_tr);
			
			dao.GUNF080_SHR(p_box);

	}

	
	public void GUNF080_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_01(p_box);

	}		
	
	
	public void GUNF080_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_DTL(p_box);

	}		
	
	public void GUNF080_SHR_APP(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_APP(p_box);

	}			
	
	//���� ��� ���� ��ȣ ä��
	public void GUNF080_SHR_MAX(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_MAX(p_box);

	}		
	
	//���� ��� ���� ��ȣ ä��
	public void GUNF080_SHR_MAX2(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_MAX2(p_box);

	}			
	
	public void GUNF080_SHR_REQ(CBox p_box, TrBox p_tr) throws CException {

		GUNF080DAO dao = new GUNF080DAO("default", p_tr);
		
		dao.GUNF080_SHR_REQ(p_box);

	}	
	
	
	/**
	 * ���κ� �ٹ����¸� �����ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws Exception 
	 */
	public void GUNF080_SAV( CBox p_box, TrBox p_tr ) throws Exception {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSCHEDULE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		
		for (int i=0; i<voList.size(); i++) {

			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
				case 2:
					// insert
					this.GUNF080_DEL(vo, p_box, p_tr);
					this.GUNF080_SAV(vo, p_box, p_tr);								
					break;
				case 3:
					// ���κ� �ٹ����¸� �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.GUNF080_DEL(vo, p_box, p_tr);
					this.GUNF080_UPT(vo, p_box, p_tr);					
					break;
					
				case 4:
					// delete;
					break;
				}

		}

	}

	
	/**
	 * ���κ� �ٹ����¸� ���� ����ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNF080_UPT_APP(CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSCHEDULE");
		
		// ���缱 ���� ���
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");		

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

				/** ValueObjectList���� ValueObject�� ������ �κ� **/
				GauceValueObject vo = voList.get(i);	// LIST -> ROW
	
				switch (vo.getInt("TX_MODE")) {
					case 2:
						// insert
						this.GUNF080_UPT_APP(vo, p_box, p_tr);						
						break;
					case 3:				
						break;
					case 4:
						// delete;
						break;
				}
				
		}		
		

		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);
			
			//System.out.println(vo2);
			
			this.GUNF080_UPT_APP_01(vo2, p_box, p_tr) ;

		}
				

	}	
	
	
	/**
	 * ���κ� �ٹ����¸� ���� ����ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNF080_UPT_APP_EACH(CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSCHEDULE");

		// ���缱 ���� ���
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");		

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

				/** ValueObjectList���� ValueObject�� ������ �κ� **/
				GauceValueObject vo = voList.get(i);	// LIST -> ROW
	
				switch (vo.getInt("TX_MODE")) {
					case 2:
						// insert					
						break;
					case 3:	
						// update
						this.GUNF080_UPT_APP_EACH(vo, p_box, p_tr);
						break;
					case 4:
						// delete;
						break;
				}
				
		}		
		

		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);
			//System.out.println(vo2);
			this.GUNF080_UPT_APP_01_EACH(vo2, p_box, p_tr) ;

		}
				
	}		

	
	public void GUNF080_UPT_APP(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP(vo, p_box);

	}		
	

	public void GUNF080_UPT_APP_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP_01(vo, p_box);

	}		
	
	
	public void GUNF080_UPT_APP_EACH(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP_EACH(vo, p_box);

	}	
	
	
	public void GUNF080_UPT_APP_01_EACH(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT_APP_01_EACH(vo, p_box);

	}			
	
	
	public void GUNF080_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_SAV(vo, p_box);

	}	
	
	
	
	public void GUNF080_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_UPT(vo, p_box);

	}		
	
	
	public void GUNF080_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF080DAO dao = new GUNF080DAO("default", p_tr);

		dao.GUNF080_DEL(vo, p_box);

	}	
	
	
}

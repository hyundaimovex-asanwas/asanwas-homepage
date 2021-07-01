package Ehr.vlu.o.vluo080.wrk;


import Ehr.vlu.o.vluo080.dao.VLUO080DAO;



import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUO080WRK {


	public void VLUO080_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUO080_SHR(p_box);
	}
	
	public void VLUO080_SHR_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.VLUO080_SHR_PJT(p_box);
	}
	


	public void VLUO080_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_01(p_box);

	}

	public void VLUO080_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_02(p_box);

	}
	
	public void VLUO080_SHR_02_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_02_PJT(p_box);

	}
	


	public void VLUO080_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_03(p_box);

	}

	public void VLUO080_SHR_04(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_04(p_box);

	}
	
	public void VLUO080_SHR_04_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_04_PJT(p_box);

	}
	


	public void VLUO080_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_05(p_box);

	}

	public void VLUO080_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_06(p_box);

	}
	
	public void VLUO080_SHR_06_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_06_PJT(p_box);

	}
	


	public void VLUO080_SHR_07(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_07(p_box);

	}

	public void VLUO080_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		/** VLUI060DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					break;

				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					this.VLUO080_SAV(vo, p_box,p_tr);
					//dao.VLUO080_SAV(vo, p_box);
					break;

				case 4:
					//dao.VLUO080_DEL(vo, p_box);
					break;
			}
		}

	}

	public void VLUO080_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        dao.VLUO080_SAV(vo, p_box);

	}		
	
	
	
	public void VLUO080_SAV_EXE(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUI060DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

		//System.out.println(vo);
		System.out.println(p_box);
		
		
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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					break;

				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					this.VLUO080_SAV_EXE(vo, p_box,p_tr);
					//dao.VLUO080_SAV_EXE(vo, p_box);
					break;

				case 4:
					//dao.VLUO080_DEL(vo, p_box);
					break;
			}
		}

	}

	public void VLUO080_SAV_EXE(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        dao.VLUO080_SAV_EXE(vo, p_box);

	}		
	
	
	
	public void VLUO080_SAV_GRD(CBox p_box, TrBox p_tr) throws CException {


		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_GRADE2");

		/** VLUI060DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					break;

				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					this.VLUO080_SAV_GRD(vo, p_box,p_tr);
					//dao.VLUO080_SAV_GRD(vo, p_box);
					break;

				case 4:
					//dao.VLUO080_DEL(vo, p_box);
					break;
			}
		}

	}
	
	
	public void VLUO080_SAV_GRD(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        dao.VLUO080_SAV_GRD(vo, p_box);

	}		
	
	
	
	
}



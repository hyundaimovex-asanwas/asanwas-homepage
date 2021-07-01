package Ehr.gun.a.guna018.wrk;

import Ehr.gun.a.guna018.dao.GUNA018DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA018WRK {

	/**
	 * ���κ� ���� ��Ȳ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNA018_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUNA018DAO dao = new GUNA018DAO("default", p_tr);
		GUNA018DAO dao2 = new GUNA018DAO("default", p_tr);
		
        /** ���κ� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		//dao.PIRC030_SHR(p_box);
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",    dao.GUNA018_SHR(p_box) );
		p_tr.setOutDataSet( "dsT_DI_YEARLY",       dao2.GUNA018_SHR_01(p_box) );
	}


	/**
	 * ���κ� ���������� ������Ʈ�ϴ� WRK �޼ҵ�
	 * @param p_box			CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNA018_UPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_YEARLY");

		/** PIRC030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUNA018DAO dao = new GUNA018DAO("default", p_tr);

		//System.out.println("Next_msg = [2]");

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

			//System.out.println("TX_MODE = " + vo.getInt("TX_MODE") );

			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					// ���κ� �������� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.GUNA018_INS(vo, p_box);
					break;
					
				case 3:
					// ���κ� �������� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.GUNA018_UPT(vo, p_box);
					break;
					
				case 4:
					// delete;

					break;
			}


		}


	}

}


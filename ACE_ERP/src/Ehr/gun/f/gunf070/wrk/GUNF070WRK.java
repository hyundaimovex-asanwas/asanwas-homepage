package Ehr.gun.f.gunf070.wrk;

import Ehr.common.util.JSPUtil;
import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.f.gunf030.dao.GUNF030DAO;
import Ehr.gun.f.gunf070.dao.GUNF070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF070WRK {

	/**
	 * ���κ� �ٹ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF070_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUNF070DAO dao = new GUNF070DAO("default", p_tr);
			
			dao.GUNF070_SHR(p_box);

	}

	
	public void GUNF070_SHR_DTL(CBox p_box, TrBox p_tr) throws CException {

		GUNF070DAO dao = new GUNF070DAO("default", p_tr);
		
		dao.GUNF070_SHR_DTL(p_box);

	}		
	
	
	/**
	 * ���κ� �ٹ����¸� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNF070_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_WORKSTYLE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF070DAO dao = new GUNF070DAO("default", p_tr);
		
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
					// ���κ� �ٹ����¸� �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.GUNF070_UPT(vo, p_box, p_tr);
					this.GUNF070_SAV(vo, p_box, p_tr);					
					break;
					
				case 4:
					// delete;
					break;
				}
			
		}
		
	}
		
	
	public void GUNF070_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF070DAO dao = new GUNF070DAO("default", p_tr);

		dao.GUNF070_SAV(vo, p_box);

	}		
	
	
	public void GUNF070_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNF070DAO dao = new GUNF070DAO("default", p_tr);

		dao.GUNF070_UPT(vo, p_box);

	}		
	
	
	
}

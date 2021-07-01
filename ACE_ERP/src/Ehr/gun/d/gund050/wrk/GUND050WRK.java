package Ehr.gun.d.gund050.wrk;

import Ehr.gun.d.gund050.dao.GUND050DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND050WRK {

	/**
	 * ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND050_SHR(CBox p_box, TrBox p_tr) throws CException {

		//System.out.println("p_box==="+p_box);
		
		/** GUND040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUND050DAO dao = new GUND050DAO("default", p_tr);

        /** ���κ� ���� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		//dao.GUND050_SHR(p_box);
		p_tr.setOutDataSet( "dsT_DI_ACCELERATE",       dao.GUND050_SHR(p_box) );
		
		
	}


}

package Ehr.cod.e.code050.wrk;

import Ehr.cod.e.code050.dao.CODE050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODE050WRK {

	/**
	 * �������� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE050_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** CODE050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE050DAO dao = new CODE050DAO("default", p_tr);

        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE050_SHR(p_box);
	}

	public void CODE050_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** PIRC090DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE050DAO dao = new CODE050DAO("default", p_tr);
		
		dao.CODE050_UPT(p_box, null);

	}
	
}




package Ehr.cod.e.code061.wrk;

import Ehr.cod.e.code061.dao.CODE061DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE061WRK {

	/**
	 * ��Ÿ���系��
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE061_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC021DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE061DAO dao = new CODE061DAO("default", p_tr);

        /** ����� ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE061_SHR_01(p_box);
	}


	/**
	 * ��Ÿ��������
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE061_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC021DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE061DAO dao = new CODE061DAO("default", p_tr);

		/** ����� ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE061_SHR_02(p_box);

	}

}

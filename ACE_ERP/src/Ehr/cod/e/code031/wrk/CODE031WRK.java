package Ehr.cod.e.code031.wrk;

import Ehr.cod.e.code031.dao.CODE031DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE031WRK {

	/**
	 * ��Ÿ���系��
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE031_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC021DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE031DAO dao = new CODE031DAO("default", p_tr);

        /** ����� ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE031_SHR_01(p_box);
	}


	/**
	 * ��Ÿ��������
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE031_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** PIRC021DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE031DAO dao = new CODE031DAO("default", p_tr);

		/** ����� ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.CODE031_SHR_02(p_box);

	}

}

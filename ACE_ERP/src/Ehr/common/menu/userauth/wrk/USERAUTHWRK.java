package common.menu.userauth.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.userauth.dao.USERAUTHDAO;

public class USERAUTHWRK {
	/**
	/**
	 * ����ڱ���������ȸ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void USERAUTH_SHR_00(CBox p_box, TrBox p_tr) throws CException {

		/** USERAUTHDAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);

        /** ����ڱ���������ȸ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.USERAUTH_SHR_00(p_box);

	}

	/**
	 * ���ѿ� ���� �޴�Ʈ�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�(���λ�ý���)
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void USERAUTH_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** USERAUTHDAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);

		//ù��° �޴��� fav�� ��� ���ã�⸦ �ҷ��´�.
		if(!p_box.get("MENU_ID1").equals("fav")){
			/** ���ѿ� ���� �޴�Ʈ�� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.USERAUTH_SHR_01(p_box);
		}else{
			//���ã��
			dao.USERAUTH_SHR_02(p_box);
		}

	}
	
	/**
	 * ���ѿ� ���� �޴�Ʈ�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�(�濵�����ý���)
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void USERAUTH_SHR_02(CBox p_box, TrBox p_tr) throws CException {
		
		/** USERAUTHDAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
		
		dao.USERAUTH_SHR_01(p_box);
		
	}
    
    /**
     * ����ڰ� ��밡���� ���� �޴��� ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void USERAUTH_SHR_03(CBox p_box, TrBox p_tr) throws CException {
	    
	    /** USERAUTHDAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
	    USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
	    
	    dao.USERAUTH_SHR_03(p_box);
	    
	}
    
    /**
     * EIS���� ��� ������ ���� �޴��� ������ �´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void USERAUTH_SHR_04(CBox p_box, TrBox p_tr) throws CException {
	    
	    /** USERAUTHDAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
	    USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
	    
	    dao.USERAUTH_SHR_04(p_box);
	    
	}
	
	/**
	 * sso
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void USERAUTH_SHR_05(CBox p_box, TrBox p_tr) throws CException {
		
		/** USERAUTHDAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
		
		dao.USERAUTH_SHR_05(p_box);
		
	}
}

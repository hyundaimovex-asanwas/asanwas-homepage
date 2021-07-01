package Ehr.edu.c.educ012.wrk;

import Ehr.edu.c.educ012.dao.EDUC012DAO;
import Ehr.yac.a.yaca050.dao.YACA050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUC012WRK {
	
	/**
	 * �İ��ξ缺��ȹ���  �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	
	//���� �߰� 
	private EDUC012DAO dao = null;
	private String connectionName = "default";   
	
	public void EDUC012_SHR(CBox p_box, TrBox p_tr) throws CException {
		
		/** EDUC012DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		//EDUC012DAO dao = new EDUC012DAO("default", p_tr);
		
		/** ��ȸ�� �����͸� ȭ�鿡 �����ϴ� �κ� **/
		// ����������Ȳ
		dao = new EDUC012DAO(connectionName, p_tr);
		p_tr.setOutDataSet("dsT_CM_EDUCATION_01",  dao.EDUC012_SHR_01(p_box));
		
		// �系�����̷�
		dao = new EDUC012DAO(connectionName, p_tr);
        p_box.set("PLACE_CD", "1");
		p_tr.setOutDataSet("dsT_CM_EDUCATION_02",  dao.EDUC012_SHR_02(p_box));
		
		//��ܱ����̷�
		dao = new EDUC012DAO(connectionName, p_tr);
        p_box.set("PLACE_CD", "2");
        p_tr.setOutDataSet("dsT_CM_EDUCATION_04",  dao.EDUC012_SHR_02(p_box));
        
		// �系�����̷�
        dao = new EDUC012DAO(connectionName, p_tr);
		p_tr.setOutDataSet("dsT_ED_LCTRHIST_03",  dao.EDUC012_SHR_03(p_box));
		
		// �������̷�
		//dao = new EDUC012DAO(connectionName, p_tr);
		//p_tr.setOutDataSet("dsT_ED_EXCEPTER_05",  dao.EDUC012_SHR_05(p_box));

	}
	
}

package Ehr.sch.a.scha030.wrk;

import Ehr.sch.a.scha030.dao.SCHA030DAO;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.sql.Connection;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;
import Ehr.common.util.DbManager;
import Ehr.common.util.HuniBill;

public class SCHA030WRK {

	/**
	 * ���ڱ� ��û�� ó�� ��Ȳ ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA030_SHR(CBox p_box, TrBox p_tr) throws CException {

			SCHA030DAO dao = new SCHA030DAO("default", p_tr);
			SCHA030DAO dao2 = new SCHA030DAO("default", p_tr);
			
			dao.SCHA030_SHR(p_box);
			
			/** ��������ó�� ���� ���  **/
			dao2.SCHA030_SHR_ACC(p_box);    			
			
	}

	/**
	 * ���ڱݱ� ��û���� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA030_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_SCHLBOOK");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		SCHA030DAO dao = new SCHA030DAO("default", p_tr);

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
			
				case 3:
					// ���ڱ� ��û���� �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.SCHA030_UPT(vo, p_box);
					break;
					
			}
		}
	}
	/**
	 * ������Ȳó�� ����
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA030_APPROVAL( CBox p_box, TrBox p_tr ) throws CException {
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_SCHLBOOK");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		SCHA030DAO dao = new SCHA030DAO("default", p_tr);
		GauceDataSet printDs = dao.SCHA030_PRC_SHR_PRINT(p_box);
		String printNo = GauceUtils.nameValue(printDs, 1, "PRINT_NO");
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
			
				case 3:
					
					// ���ڱ� ��û���� �����ϱ� ���� DAO�޼ҵ� ȣ��
					if("T".equals(vo.get("IS_CHK"))){
						
						p_box.set("PRINT_NO", printNo);
						
						dao.SCHA010_PRC_UPT_02(vo, p_box);
					}
					
					break;
			}
		}

		p_tr.setOutDataSet( "dsT_SC_SCHLBOOK_APPROVAL",   printDs );
	}
	

}


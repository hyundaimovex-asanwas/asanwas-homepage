package common.popup.chgpwd.wrk;

import common.popup.chgpwd.dao.CHGPWDDAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.StringUtil;
import com.shift.gef.support.vo.GauceValueObject;

public class CHGPWDWRK {

	/**
	 * ������й�ȣ (��ȸ) WRK �޼ҵ�.
	 *
	 * @param p_box
	 *            CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr
	 *            TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CHGPWD_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ������й�ȣ(��ȸ) DAO CLASS �޼��� ȣ�� * */
		CHGPWDDAO dao = new CHGPWDDAO("default", p_tr);

		String PWD_NO = "";
		GauceDataSet dsResult = new GauceDataSet();
		GauceDataSet dsCHGPWD_SHR = dao.CHGPWD_SHR(p_box);

		if(GauceUtils.nameValue(dsCHGPWD_SHR, 1, "PWD_NO").equals(GauceUtils.nameValue(dsCHGPWD_SHR, 1, "CET_NO").substring(7,14))){
			PWD_NO = StringUtil.encrypt(GauceUtils.nameValue(dsCHGPWD_SHR, 1, "PWD_NO"));
		}else{
			PWD_NO = GauceUtils.nameValue(dsCHGPWD_SHR, 1, "PWD_NO");
		}

		//Į���� ����
		GauceDataColumn gc = null;
		GauceDataColumn[] cols = dsCHGPWD_SHR.getDataColumns();          // Į���� �������� ���ؼ�

		for(int i=0; i<cols.length; i++){
			gc = new GauceDataColumn(cols[i].getColName(), GauceDataColumn.TB_STRING );
			dsResult.addDataColumn(gc);
		}

		GauceDataRow grAdd = new GauceDataRow(dsResult.getDataColCnt());

		grAdd.setString(0, dsCHGPWD_SHR.getDataRow(0).getString(0));
		grAdd.setString(1, PWD_NO);
		grAdd.setString(2, dsCHGPWD_SHR.getDataRow(0).getString(2));

		dsResult.addDataRow(grAdd);

		p_tr.setOutDataSet("dsT_CM_EMPLIST", dsResult);
	}


	public void CHGPWD_CHG(CBox p_box, TrBox p_tr) throws CException {

		String PWD_NO = "";
		GauceDataSet dsResult = new GauceDataSet();

		//Į���� ����
		dsResult.addDataColumn(new GauceDataColumn("PWD_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NEW_PWD_NO", GauceDataColumn.TB_STRING ));

		GauceDataRow grAdd = new GauceDataRow(dsResult.getDataColCnt());

		grAdd.setString(0, StringUtil.encrypt((String)p_box.get("PWD_NO")));
		grAdd.setString(1, StringUtil.encrypt((String)p_box.get("NEW_PWD_NO")));
		dsResult.addDataRow(grAdd);

		p_tr.setOutDataSet("dsT_CM_EMPLIST_01", dsResult);
	}

	/**
	 * ����� ��й�ȣ ���� (����) WRK �޼ҵ�.
	 *
	 * @param p_box
	 *            CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr
	 *            TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CHGPWD_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		CHGPWDDAO dao = new CHGPWDDAO("default", p_tr);
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		for (int i = 0; i < voList.size(); i++) {
			GauceValueObject vo = voList.get(i);
			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����. - 1 : NORMAL - 2 : INSERT -
			 * 3 : UPDATE - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 1:
				break;
			case 2:
				break;
			case 3:
				dao.CHGPWD_UPT(p_box, vo);
				break;
			case 4:
				break;
			}
		}

	}

}

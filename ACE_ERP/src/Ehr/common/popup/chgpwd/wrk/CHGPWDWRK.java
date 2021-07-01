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
	 * 기존비밀번호 (조회) WRK 메소드.
	 *
	 * @param p_box
	 *            CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr
	 *            TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CHGPWD_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 기존비밀번호(조회) DAO CLASS 메서드 호출 * */
		CHGPWDDAO dao = new CHGPWDDAO("default", p_tr);

		String PWD_NO = "";
		GauceDataSet dsResult = new GauceDataSet();
		GauceDataSet dsCHGPWD_SHR = dao.CHGPWD_SHR(p_box);

		if(GauceUtils.nameValue(dsCHGPWD_SHR, 1, "PWD_NO").equals(GauceUtils.nameValue(dsCHGPWD_SHR, 1, "CET_NO").substring(7,14))){
			PWD_NO = StringUtil.encrypt(GauceUtils.nameValue(dsCHGPWD_SHR, 1, "PWD_NO"));
		}else{
			PWD_NO = GauceUtils.nameValue(dsCHGPWD_SHR, 1, "PWD_NO");
		}

		//칼럼명 세팅
		GauceDataColumn gc = null;
		GauceDataColumn[] cols = dsCHGPWD_SHR.getDataColumns();          // 칼럼명 가져오기 위해서

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

		//칼럼명 세팅
		dsResult.addDataColumn(new GauceDataColumn("PWD_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NEW_PWD_NO", GauceDataColumn.TB_STRING ));

		GauceDataRow grAdd = new GauceDataRow(dsResult.getDataColCnt());

		grAdd.setString(0, StringUtil.encrypt((String)p_box.get("PWD_NO")));
		grAdd.setString(1, StringUtil.encrypt((String)p_box.get("NEW_PWD_NO")));
		dsResult.addDataRow(grAdd);

		p_tr.setOutDataSet("dsT_CM_EMPLIST_01", dsResult);
	}

	/**
	 * 사용자 비밀번호 변경 (수정) WRK 메소드.
	 *
	 * @param p_box
	 *            CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr
	 *            TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CHGPWD_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성 * */
		CHGPWDDAO dao = new CHGPWDDAO("default", p_tr);
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		for (int i = 0; i < voList.size(); i++) {
			GauceValueObject vo = voList.get(i);
			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다. - 1 : NORMAL - 2 : INSERT -
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

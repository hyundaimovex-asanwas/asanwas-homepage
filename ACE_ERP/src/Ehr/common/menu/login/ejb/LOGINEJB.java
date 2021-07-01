package common.menu.login.ejb;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.login.wrk.LOGINWRK;

public class LOGINEJB extends EJB {

	private HttpGauceRequest p_req = null;
	private HttpGauceResponse p_res = null;
	private CBox box = null;
	private TrBox tr = null;

	public LOGINEJB(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr ) throws CException {
		this.p_req = p_req;
		this.p_res = p_res;
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** WRK Class 객체 생성 * */
		LOGINWRK wrk = new LOGINWRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_00")) {
	        //sha2 적용 2014.07.09 이동훈
			wrk.LOGIN_SHR_00(p_req, p_res, box, tr);//현재는 eis랑 hrms 따로 구분하지 않았음

		}else if (box.get("S_MODE").equals("SHR_01")) {
	        //eis
			wrk.LOGIN_SHR(p_req, p_res, box, tr);//현재는 eis랑 hrms 따로 구분하지 않았음			
			
		}else if (box.get("S_MODE").equals("SHR_02")) {
	        //eis
			wrk.LOGIN_SHR(p_req, p_res, box, tr);//현재는 eis랑 hrms 따로 구분하지 않았음

		}else if (box.get("S_MODE").equals("SHR_03")) {

			//hrms sso
			if (box.get("SSO_FLAG").equals("gw")) {
				wrk.LOGIN_SHR_03(p_req, p_res, box, tr);
			}
		}



		if (box.get("S_MODE").equals("SHR_05")) {
			wrk.LOGIN_SHR_05(box, tr);
			}


		if (box.get("S_MODE").equals("UPT_05")) {
			wrk.LOGIN_UPT_05(box, tr);
		}


		if (box.get("S_MODE").equals("SHR_06")) {
			wrk.LOGIN_SHR_06(box, tr);
		}

		if (box.get("S_MODE").equals("SHR_07")) {
			wrk.LOGIN_SHR_07(box, tr);
		}

		if (box.get("S_MODE").equals("UPT_06")) {
			wrk.LOGIN_UPT_06(box, tr);
		}
		// 그룹웨어에서 Login한경우
		if (box.get("S_MODE").equals("GROUPWARE_SAV")) {
			wrk.GROUPWARE_SAV(box, tr);
		}
		return null;

     }

}




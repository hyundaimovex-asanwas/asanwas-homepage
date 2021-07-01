package Ehr.sag.d.sagd030.cmd;

import Ehr.sag.d.sagd030.wrk.SAGD030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD030CMD implements AbstractGauceCMD {

	/**
	 *급여계산처리 command class
	 *조회, 저장, 삭제에 사용
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		//EjbProxy.controlTxn(new SAGD030EJB(p_box, p_tr));
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGD030WRK wrk = new SAGD030WRK();

		/** 조회 **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGD030_SHR(p_box, p_tr);
		}

		/** 작업로그 신규저장 (작업 OPEN) **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.SAGD030_SAV(p_box, p_tr);
		}

		/** 대상자 선정 **/
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.SAGD030_SAV_01(p_box, p_tr);
		}

		/** 대상자 초기화 **/
		else if (p_box.get("S_MODE").equals("SAV_02")) {
			wrk.SAGD030_SAV_02(p_box, p_tr);
		}

		/** 금액·세액계산 **/
		else if (p_box.get("S_MODE").equals("SAV_03")) {
			wrk.SAGD030_SAV_03(p_box, p_tr);
		}

		/** 계산 초기화 **/
		else if (p_box.get("S_MODE").equals("SAV_04")) {
			wrk.SAGD030_SAV_04(p_box, p_tr);
		}

		/** 작업CLOSE **/
		else if (p_box.get("S_MODE").equals("SAV_05")) {
			wrk.SAGD030_SAV_05(p_box, p_tr);
		}		
		
		

	}

}

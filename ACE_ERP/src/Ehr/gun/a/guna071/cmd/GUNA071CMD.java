package Ehr.gun.a.guna071.cmd;

import Ehr.gun.a.guna071.wrk.GUNA071WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA071CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA071WRK wrk = new GUNA071WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//결재세부사항 조회(변경신청) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_01(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			//결재세부사항 조회(일일근태) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_02(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_PLAN")) {
			//결재세부사항 조회(익월근태) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_PLAN(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_ACC")) {
			//결재세부사항 조회(연차촉진제) 조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_ACC(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_APP")) {
			//공통 결재자  조회를 위한 WORK메소드 호출
			wrk.GUNA071_SHR_APP(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV") && (p_box.get("GUN_GBN").equals("C")) ) {
			//결재세부사항 조회(일일근태) 저장을 위한 WORK메소드 호출
			wrk.GUNA071_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV") && (p_box.get("GUN_GBN").equals("U")) ) {
		//결재세부사항 조회(변경근태) 저장을 위한 WORK메소드 호출
			wrk.GUNA071_SAV_01(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV") && (p_box.get("GUN_GBN").equals("A")) ) {
			//결재세부사항 조회(연차촉진제) 저장를 위한 WORK메소드 호출
			wrk.GUNA071_SAV_03(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new GUNA071EJB(p_box, p_tr));
	}

}

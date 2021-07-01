package Ehr.cod.f.codf010.cmd;

import Ehr.cod.f.codf010.wrk.CODF010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODF010CMD implements AbstractGauceCMD {

	/**
	 * 직무코드관리 command class
	 * 신규트리 구성, head조회, sub조회, 저장에 사용
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		CODF010WRK wrk = new CODF010WRK();

		/** 트리조회 **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.CODF010_SHR(p_box, p_tr);
		}
		/** 직무코드 상세 조회 **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.CODF010_SHR_01(p_box, p_tr);
		}
		/** 직무정보가 하나도 없으면 회사정보를 넣는다. **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.CODF010_SAV(p_box, p_tr);
		}
		/** 데이터 저장 **/
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.CODF010_SAV_01(p_box, p_tr);
		}
		/** 데이터 삭제 **/
		else if (p_box.get("S_MODE").equals("DEL_01")) {
			wrk.CODF010_DEL_01(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new CODF010EJB(p_box, p_tr));

	}
}

package Ehr.sag.a.saga220.cmd;

import Ehr.sag.a.saga220.wrk.SAGA220WRK;

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

public class SAGA220CMD implements AbstractGauceCMD {

	/**
	 *급여테이블 command class
	 *조회, 저장, 삭제에 사용
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGA220WRK wrk = new SAGA220WRK();

		/** 조회 **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGA220_SHR(p_box, p_tr);
		}
		/** 적용일자 조회 **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA220_SHR_01(p_box, p_tr);
		}
		/** 엑셀파일 업로드 **/
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGA220_SHR_02(p_box, p_tr);
		}
		
		/** 은행용 추가 2018.07.12 이동훈 **/
		else if (p_box.get("S_MODE").equals("SHR_09")) {
			wrk.SAGA220_SHR_09(p_box, p_tr);
		}		
		
		/** 저장 **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.SAGA220_SAV(p_box, p_tr);
		}
		/** 삭제 **/
		else if (p_box.get("S_MODE").equals("DEL")) {
			wrk.SAGA220_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SAGA220EJB(p_box, p_tr));

	}

}

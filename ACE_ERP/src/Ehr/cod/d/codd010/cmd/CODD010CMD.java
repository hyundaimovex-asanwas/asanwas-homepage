package Ehr.cod.d.codd010.cmd;

import Ehr.cod.d.codd010.wrk.CODD010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODD010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

        /** WRK Class 객체 생성 * */
		CODD010WRK wrk = new CODD010WRK();

        /** 프로그램 사용 로그 정보 (SHR:조회)을 위한 WRK Class 메소드 호출 * */
        if(p_box.get("S_MODE").equals("SHR"))

            wrk.CODD010_SHR(p_box, p_tr);		

		}

}

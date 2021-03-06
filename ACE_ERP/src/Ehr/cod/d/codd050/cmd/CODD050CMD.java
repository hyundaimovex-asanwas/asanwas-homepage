package Ehr.cod.d.codd050.cmd;

import Ehr.cod.d.codd050.wrk.CODD050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODD050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

        /** WRK Class 객체 생성 * */
		CODD050WRK wrk = new CODD050WRK();

        /** 미확인 메세지 조회를 위한 WRK Class 메소드 호출 * */
        if(p_box.get("S_MODE").equals("SHR")){

            wrk.CODD050_SHR(p_box, p_tr);		

		} else if(p_box.get("S_MODE").equals("SAV"))

            wrk.CODD050_SAV(p_box, p_tr);	
		}

}

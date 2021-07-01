package Ehr.gun.a.guna013.cmd;

import Ehr.gun.a.guna013.wrk.GUNA013WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA013CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA013WRK wrk = new GUNA013WRK();
		
		// S_MODE가 목록조회인 경우
		if (p_box.get("S_MODE").equals("SHR_LST")) {

			wrk.GUNA013_SHR_LST(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_CD")) {
			
			wrk.GUNA013_SHR_CD(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR")) {

			wrk.GUNA013_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_04")) {

			wrk.GUNA013_SHR_04(p_box, p_tr);
				
		}else if (p_box.get("S_MODE").equals("SHR_05")) {

			wrk.GUNA013_SHR_05(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_06")) {

			wrk.GUNA013_SHR_06(p_box, p_tr);		
		
		// S_MODE가 저장, 수정인 경우
		}else if (p_box.get("S_MODE").equals("SAV")) {
			
			//	근태변경신청서를 저장하기 위한 WORK메소드 호출
			wrk.GUNA013_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("DEL")) {
			
			//	근태변경신청서를 삭제하기 위한 WORK메소드 호출
			wrk.GUNA013_DEL(p_box, p_tr);

		}		
		
		//EjbProxy.controlTxn(new GUNA013EJB(p_box, p_tr));
	}


}
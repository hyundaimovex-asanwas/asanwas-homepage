package Ehr.cod.e.code040.cmd;

import Ehr.cod.e.code040.wrk.CODE040WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODE040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		CODE040WRK wrk = new CODE040WRK();

		//System.out.println("p_box==="+p_box);
		
		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //인사기록표 데이터를 조회해온다.
			wrk.CODE040_SHR(p_box, p_tr);
		}
		
		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SAV")) {
			
		    //인사기록표에 소득세율코드 업데이트.
			wrk.CODE040_SAV(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new CODE040EJB(p_box, p_tr));
	}
}


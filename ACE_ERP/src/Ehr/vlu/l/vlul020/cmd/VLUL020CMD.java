package Ehr.vlu.l.vlul020.cmd;

import Ehr.vlu.l.vlul020.wrk.VLUL020WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUL020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUL020WRK wrk = new VLUL020WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {  //본사
			wrk.VLUL020_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) { //본사
            wrk.VLUL020_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) { //부서장본사
            wrk.VLUL020_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) { //부서장본사외
            wrk.VLUL020_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM")) { //정규 고과상세
            wrk.VLUL020_SHR_ITEM(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM_01")) { //부서장 고과 상세
            wrk.VLUL020_SHR_ITEM_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) { //정규저장
            wrk.VLUL020_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_01")) { //부서장저장
            wrk.VLUL020_SAV_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR")) { //정규보정
            wrk.VLUL020_SAV_COR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("VLUL020_UPT")) { //계약보정
            wrk.VLUL020_SAV_COR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_02")) { //부서장보정
            wrk.VLUL020_SAV_COR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_PJT")) { //PJT보정
            wrk.VLUL020_SAV_COR_PJT(p_box, p_tr);
		}  
        
        
        //EjbProxy.controlTxn(new VLUL010EJB(p_box, p_tr));

	}

}

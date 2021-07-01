package Ehr.idt.a.idta030.cmd;

import Ehr.idt.a.idta030.wrk.IDTA030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTA030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		
		//System.out.println("p_box   =========================================== ");	
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
		//String mode = p_box.get("S_MODE");
        
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	    
    	
        //Log.debug.println("S_MODE:"+mode);
        
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
		IDTA030WRK wrk = new IDTA030WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	증명서신청현황 조회를 위한 WORK메소드 호출
			wrk.IDTA030_SHR(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	권한 조회를 위한 WORK메소드 호출
			wrk.IDTA030_SHR_01(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_02")) {
			//	사원정보 조회(주소)를 위한 WORK메소드 호출
			wrk.IDTA030_SHR_02(p_box, p_tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV")) {
			//	증명서신청 정보를 수정하기 위한 WORK메소드 호출
			wrk.IDTA030_SAV(p_box, p_tr);
		}
		// S_MODE가 삭제인인 경우
		if (p_box.get("S_MODE").equals("DEL")) {
			//	증명서신청 정보를 삭제하기 위한 WORK메소드 호출
			wrk.IDTA030_DEL(p_box, p_tr);
		}
		// S_MODE가 증명서 출력 업데이트인인 경우
		if (p_box.get("S_MODE").equals("UPT_PRT")) {
		    //	증명서신청 정보를 삭제하기 위한 WORK메소드 호출
		    wrk.IDTA030_UPT_PRT(p_box, p_tr);
		}
		
		
		//EjbProxy.controlTxn(new IDTA030EJB(p_box, p_tr));
		
		
		
	}


}
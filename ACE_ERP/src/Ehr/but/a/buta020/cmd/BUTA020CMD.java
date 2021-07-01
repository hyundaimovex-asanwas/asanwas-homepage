package Ehr.but.a.buta020.cmd;

import Ehr.but.a.buta020.wrk.BUTA020WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class BUTA020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BUTA020WRK wrk = new BUTA020WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//품의번호 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_01(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			//교통수단 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_02(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_03")) {
			//출장품의서 작성 내용 및 출장 결재자 정보 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_03(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_05")) {
			//출장품의서 작성 내용 및 출장 결재자 정보 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_05(p_box, p_tr);
		}		
		
		// S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_PER")) {
			//출장품의서 작성 내용 및 출장 결재자 정보 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_PER(p_box, p_tr);
		}	
		
		//S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			//출장품서 작성내용 등록을  위한 WORK메소드 호출
			wrk.BUTA020_SAV_01(p_box, p_tr);
		}
		
		//S_MODE가 상신인 경우
		else if (p_box.get("S_MODE").equals("SAV_01_APP")) {
			//출장품서 작성내용 등록을  위한 WORK메소드 호출
			wrk.BUTA020_SAV_01_APP(p_box, p_tr);
		}
		//S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV_02")) {
			//출장품의 결재현황에 상신, 결재, 전결처리 등록을 위한 WORK메소드 호출
			wrk.BUTA020_SAV_02(p_box, p_tr);
		}
		//S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV_03")) {
			//출장품의 결재현황에 부결, 반송처리 등록을 위한 WORK메소드 호출
			wrk.BUTA020_SAV_03(p_box, p_tr);
		}
		//S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV_DATE")) {
			//인사팀에서 날짜만 변경하기 위한 WORK메소드 호출
			wrk.BUTA020_SAV_DATE(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new BUTA020EJB(p_box, p_tr));
	}

}

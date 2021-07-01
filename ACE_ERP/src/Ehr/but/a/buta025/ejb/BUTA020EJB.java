package hr.but.a.buta020.ejb;

import hr.but.a.buta020.wrk.BUTA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BUTA020WRK wrk = new BUTA020WRK();

		// S_MODE가 조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//품의번호 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_01(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_02")) {
			//교통수단 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_02(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_03")) {
			//출장품의서 작성 내용 및 출장 결재자 정보 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_03(box, tr);
		}
		// S_MODE가 조회인 경우
		else if (box.get("S_MODE").equals("SHR_05")) {
			//출장품의서 작성 내용 및 출장 결재자 정보 조회를 위한 WORK메소드 호출
			wrk.BUTA020_SHR_05(box, tr);
		}		
		//S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV_01")) {
			//출장품서 작성내용 등록을  위한 WORK메소드 호출
			wrk.BUTA020_SAV_01(box, tr);
		}
		//S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV_01_APP")) {
			//출장품서 작성내용 등록을  위한 WORK메소드 호출
			wrk.BUTA020_SAV_01_APP(box, tr);
		}
		//S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV_02")) {
			//출장품의 결재현황에 상신, 결재, 전결처리 등록을 위한 WORK메소드 호출
			wrk.BUTA020_SAV_02(box, tr);
		}
		//S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV_03")) {
			//출장품의 결재현황에 부결, 반송처리 등록을 위한 WORK메소드 호출
			wrk.BUTA020_SAV_03(box, tr);
		}
		//S_MODE가 저장인 경우
		else if (box.get("S_MODE").equals("SAV_DATE")) {
			//인사팀에서 날짜만 변경하기 위한 WORK메소드 호출
			wrk.BUTA020_SAV_DATE(box, tr);
		}
		return null;
	}

}

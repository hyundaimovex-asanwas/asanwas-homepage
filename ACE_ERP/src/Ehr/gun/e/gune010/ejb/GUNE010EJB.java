package Ehr.gun.e.gune010.ejb;

import Ehr.gun.e.gune010.wrk.GUNE010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNE010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNE010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNE010WRK wrk = new GUNE010WRK();

		// S_MODE가 결재선조회인 경우
		if (box.get("S_MODE").equals("SHR_APP")) {
			//	결재선 조회하기 위한 WORK메소드 호출
			wrk.GUNE010_SHR_APP(box, tr);
		}
		// S_MODE가 주차조회인 경우
		if (box.get("S_MODE").equals("SHR_WK")) {
			//	결재선 조회하기 위한 WORK메소드 호출
			wrk.GUNE010_SHR_WK(box, tr);
		}
		// S_MODE가 사원정보조회인 경우
		if (box.get("S_MODE").equals("SHR_01")) {
			//	사원 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNE010_SHR_01(box, tr);
		}
		// S_MODE가 당월 연장근무 누적시간 조회인 경우
		if (box.get("S_MODE").equals("SHR_ACC")) {
			//	당월 연장근무 누적시간을 조회하기 위한 WORK메소드 호출
			wrk.GUNE010_SHR_ACC(box, tr);
		}
		// S_MODE가 당월 연장근무 등록가능일자 조회인 경우
		if (box.get("S_MODE").equals("SHR_OTD")) {
			//	당월 연장근무 등록가능일자를 조회하기 위한 WORK메소드 호출
			wrk.GUNE010_SHR_OTD(box, tr);
		}	
		// S_MODE가 신청번호 조회인 경우
		if (box.get("S_MODE").equals("SHR_MAX")) {
			//	주차 확인을 위한 WORK메소드 호출
			wrk.GUNE010_SHR_MAX(box, tr);
		}
		// S_MODE가 연장근무 내역 저장인 경우
		if (box.get("S_MODE").equals("UPT_APP")) {
			//	당월 연장근무 등록가능일자를 조회하기 위한 WORK메소드 호출
			wrk.GUNE010_UPT_APP(box, tr);
		}			
		
		
		
	

		return null;
	}

}

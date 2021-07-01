package Ehr.edu.c.educ012.wrk;

import Ehr.edu.c.educ012.dao.EDUC012DAO;
import Ehr.yac.a.yaca050.dao.YACA050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUC012WRK {
	
	/**
	 * 후견인양성계획등록  데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	
	//이전 추가 
	private EDUC012DAO dao = null;
	private String connectionName = "default";   
	
	public void EDUC012_SHR(CBox p_box, TrBox p_tr) throws CException {
		
		/** EDUC012DAO 객체 생성 후 관련 메소드 호출 */
		//EDUC012DAO dao = new EDUC012DAO("default", p_tr);
		
		/** 조회한 데이터를 화면에 전송하는 부분 **/
		// 교육점수현황
		dao = new EDUC012DAO(connectionName, p_tr);
		p_tr.setOutDataSet("dsT_CM_EDUCATION_01",  dao.EDUC012_SHR_01(p_box));
		
		// 사내교육이력
		dao = new EDUC012DAO(connectionName, p_tr);
        p_box.set("PLACE_CD", "1");
		p_tr.setOutDataSet("dsT_CM_EDUCATION_02",  dao.EDUC012_SHR_02(p_box));
		
		//사외교육이력
		dao = new EDUC012DAO(connectionName, p_tr);
        p_box.set("PLACE_CD", "2");
        p_tr.setOutDataSet("dsT_CM_EDUCATION_04",  dao.EDUC012_SHR_02(p_box));
        
		// 사내강의이력
        dao = new EDUC012DAO(connectionName, p_tr);
		p_tr.setOutDataSet("dsT_ED_LCTRHIST_03",  dao.EDUC012_SHR_03(p_box));
		
		// 예외자이력
		//dao = new EDUC012DAO(connectionName, p_tr);
		//p_tr.setOutDataSet("dsT_ED_EXCEPTER_05",  dao.EDUC012_SHR_05(p_box));

	}
	
}

package Ehr.edu.e.edue041.wrk;

import Ehr.edu.e.edue041.dao.EDUE041DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.cdp.a.book030.dao.BOOK030DAO;
import Ehr.common.util.DateUtil;
import Ehr.common.util.JSPUtil;

public class EDUE041WRK {

	/**
	 * 결재세부사항 조회(변경신청) 조회 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	
	private EDUE041DAO dao = null;
	private String connectionName = "default";   
	
	
	public void EDUE041_SHR(CBox p_box, TrBox p_tr) throws CException {

			//EDUE041DAO dao = new EDUE041DAO("default", p_tr);
		    dao = new EDUE041DAO(connectionName, p_tr);
		    
		    dao.setAutoCommit(false);
			p_tr.setOutDataSet("SHR", dao.EDUE041_SHR(p_box));
			
			dao = new EDUE041DAO(connectionName, p_tr);
			p_tr.setOutDataSet("dsT_DI_APPROVAL", dao.EDUE041_SHR_01(p_box));
			
			dao.setAutoCommit(false);

	}

	
	public void EDUE041_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {
		
		EDUE041DAO dao = new EDUE041DAO("default", p_tr);
		
		dao.EDUE041_SHR_PRINT(p_box);
		
	}
	
	public void EDUE041_SHR_PRINT2(CBox p_box, TrBox p_tr) throws CException {
		
		EDUE041DAO dao = new EDUE041DAO("default", p_tr);
		
		dao.EDUE041_SHR_PRINT2(p_box);
		
	}		
	
	
	
	/**
	 * 결재정보를 저장 하는 WORK메소드.(개인별 일일근태)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EDUE041_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ED_COURSELIST");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);

		EDUE041DAO dao = new EDUE041DAO("default", p_tr);
		EDUE041DAO dao2 = new EDUE041DAO("default", p_tr);		
		EDUE041DAO dao3 = new EDUE041DAO("default", p_tr);		


		//1. 결재정보 수정
		dao.EDUE041_UPT(p_box,vo);

		
		//2.모두 결재됐는지 Check
		GauceDataSet ds = dao2.EDUE041_CNT(p_box);

		
		String APP_YN = GauceUtils.nameValue(ds, 1, "APP_YN");
		String SHAPE_CD = JSPUtil.rns(vo.get("SHAPE_CD"));
		String EDU_TERM1 = JSPUtil.rns(vo.get("EDU_TERM")).replaceAll("-", "");
		String EDU_TERM2 = EDU_TERM1.replaceAll("~", "");
		String EDU_TERM3 = EDU_TERM2.replaceAll(" ", "");

		String STR_YMD_SHR = EDU_TERM3.substring(0, 8);
		String END_YMD_SHR = EDU_TERM3.substring(8, 16);
		String PIS_YYMMDD = STR_YMD_SHR;

		int DAY = 0;

		//100일이상 교육가진 않겠지 설마..
		for(int i = 0 ; i < 100; i++){
			
			if(Integer.parseInt(PIS_YYMMDD) != Integer.parseInt(END_YMD_SHR)){
				
				PIS_YYMMDD = DateUtil.getAfterDate(PIS_YYMMDD, 0,0,1);
				
				DAY = DAY + 1;
				
			}else if(Integer.parseInt(PIS_YYMMDD) == Integer.parseInt(END_YMD_SHR)){
				
				break;
				
			}
			
		}

		if(!"-".equals(APP_YN) && !"E".equals(APP_YN) && "OS".equals(SHAPE_CD) ){
			
			// 3. 모두 결재됐고, 집체교육일 경우에만 근태에 Update
			dao3.EDUE041_UPT_01(APP_YN, p_box);
			
			for(int j = 0 ; j < DAY; j++){

				this.EDUE041_UPT_02(STR_YMD_SHR, vo, p_box, p_tr);
				
				STR_YMD_SHR = DateUtil.getAfterDate(STR_YMD_SHR, 0,0,1);
				
			}
			
		}
		
	}
	
	public void EDUE041_UPT_02(String PIS_YYMMDD, GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		EDUE041DAO dao = new EDUE041DAO("default", p_tr);
	
		dao.EDUE041_UPT_02(PIS_YYMMDD, vo, p_box);
		
	}
	
		
	
	
	public void EDUE041_SAV01(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ED_COURSELIST");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);

		//EDUE041DAO dao = new EDUE041DAO("default", p_tr);
		dao = new EDUE041DAO(connectionName, p_tr);

		//1. 결재정보 수정
		dao.EDUE041_UPT(p_box,vo);

		//2.모두 결재됐는지 Check
		GauceDataSet ds = dao.EDUE041_CNT(p_box);

		//System.out.println("vo=============="+vo);

		String APP_YN = GauceUtils.nameValue(ds, 1, "APP_YN");
		String SHAPE_CD = JSPUtil.rns(vo.get("SHAPE_CD"));
		String EDU_TERM1 = JSPUtil.rns(vo.get("EDU_TERM")).replaceAll("-", "");
		String EDU_TERM2 = EDU_TERM1.replaceAll("~", "");
		String EDU_TERM3 = EDU_TERM2.replaceAll(" ", "");

		String STR_YMD_SHR = EDU_TERM3.substring(0, 8);
		String END_YMD_SHR = EDU_TERM3.substring(8, 16);
		String PIS_YYMMDD = STR_YMD_SHR;

		int DAY = 0;

		//100일이상 교육가진 않겠지 설마..
		for(int i = 0 ; i < 100; i++){
			if(Integer.parseInt(PIS_YYMMDD) != Integer.parseInt(END_YMD_SHR)){
				PIS_YYMMDD = DateUtil.getAfterDate(PIS_YYMMDD, 0,0,1);
				DAY = DAY + 1;
			}else if(Integer.parseInt(PIS_YYMMDD) == Integer.parseInt(END_YMD_SHR)){
				break;
			}
		}

		if(!"-".equals(APP_YN) && "OS".equals(SHAPE_CD) ){
			// 3. 모두 결재됐고, 집체교육일 경우에만 근태에 Update
			dao = new EDUE041DAO(connectionName, p_tr);
			dao.EDUE041_UPT_01(APP_YN, p_box);
		}
	}
}

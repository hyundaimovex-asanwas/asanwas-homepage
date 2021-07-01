package Ehr.yac.a.yaca001.wrk;

import Ehr.yac.a.yaca001.dao.YACA001DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.DynamicValueObject;
//import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.JSPUtil;
import Ehr.common.util.POIUtil;

public class YACA001WRK {
    //private YACA001DAO dao = null;
    //private String connectionName = "default";   
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR(p_box);
		
}    
	
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_14(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_14(p_box);
		
}   	
	
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_142(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_142(p_box);
		
} 	
	
    /**
     * 연말정산 의료비 현황 조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_MED_14(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_MED_14(p_box);
		
}  	
	
    /**
     * 연말정산 의료비 현황 조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_MED_142(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_MED_142(p_box);
		
}  	
	
    /**
     * 연말정산 기부금 현황 조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_DON_14(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_DON_14(p_box);
		
} 	

	
	 /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_15(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_15(p_box);
		
}   	
	
    /**
     * 연말정산 의료비 현황 조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_MED_15(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_MED_15(p_box);
		
}  	
	
    /**
     * 연말정산 기부금 현황 조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_DON_15(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_DON_15(p_box);
		
} 	


    /**
     * 연말정산 기부금 현황 조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA001_SHR_DON_142(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA001DAO dao = new YACA001DAO("default", p_tr);
		dao.YACA001_SHR_DON_142(p_box);
		
} 

		
		/**
	     * 연말정산
	     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
	     * @param p_box
	     * @return
	     * @throws CException
	     */
	 public DynamicValueObject YACA001_SHR_FILE_01(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		YACA001DAO dao = new YACA001DAO("default");

		DynamicValueObject dvoList = dao.YACA001_SHR_FILE_14_AB(p_box); // A, B만 만들고 C,D,E,F,G는 밑에서 부터 다시 만든다.

		//커넥션이 끊겨서 다시 연결해준다. 문의 해야함.
		dao.close();
			
		dao = new YACA001DAO("default");

		GauceDataSet dsYACA001_SHR_14 = dao.YACA001_SHR_FILE_14_ETC(p_box);		

	    //System.out.println("-----------111111111111111111---------");		
		
		GauceDataSet dsResult = new GauceDataSet();
		
		dsResult.addDataColumn(new GauceDataColumn("REC_TAG", GauceDataColumn.TB_STRING ));

		dsResult.addDataColumn(new GauceDataColumn("TAX_CD", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("COMP_CD", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CNT", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ZIP_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JUSO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JAS_NM", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JAO_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("SALT_AMTS", GauceDataColumn.TB_DECIMAL, 10, 0));

		//dsResult.addDataColumn(new GauceDataColumn("SALT_AMTB", GauceDataColumn.TB_DECIMAL, 10, 0));
		//dsResult.addDataColumn(new GauceDataColumn("JAI_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("SALT_AMTT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("FREE_INCOME", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TAX_INCOME", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("OUTT_AMTS", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MGR_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MNI_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("BADD_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SOU_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("SPSB_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DFM_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GDED_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOL_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOL_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TRB_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TBL_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("WDD_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("ONE_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("HINU_AMT", GauceDataColumn.TB_DECIMAL, 10, 0)); 
		dsResult.addDataColumn(new GauceDataColumn("HINS_AMT", GauceDataColumn.TB_DECIMAL, 10, 0)); 

		dsResult.addDataColumn(new GauceDataColumn("LH1_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH2_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH3_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH4_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH5_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH6_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH7_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH8_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DON_FWD",GauceDataColumn.TB_DECIMAL, 10, 0));	
		dsResult.addDataColumn(new GauceDataColumn("PER_DED",GauceDataColumn.TB_DECIMAL, 10, 0));			
		

		
		dsResult.addDataColumn(new GauceDataColumn("CPC_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("NSE_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INDED_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));

		dsResult.addDataColumn(new GauceDataColumn("CARD_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SAVE_DED",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SAVE1_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("SAVE2_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("SAVE3_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		
		dsResult.addDataColumn(new GauceDataColumn("SAJU_AMT",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("LSS_AMT",GauceDataColumn.TB_DECIMAL, 10, 0)); //		
		dsResult.addDataColumn(new GauceDataColumn("ETC_TOT",GauceDataColumn.TB_DECIMAL, 11, 0)); //	

		dsResult.addDataColumn(new GauceDataColumn("VEN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TTAX_STD", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TAX_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HGR_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("AGE_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));	
		
		dsResult.addDataColumn(new GauceDataColumn("ANN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("ANN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LIN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MIN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("MMA_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MMA_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("EDU_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("GOV1_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV1_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV2_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV2_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("LC1_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("LC1_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LC23_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("LC23_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("MRENT_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		
		
		dsResult.addDataColumn(new GauceDataColumn("TDED_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DGG_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DBW_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DJM_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAL_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAC_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INCM_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CITI_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HIR_YMD", GauceDataColumn.TB_DECIMAL, 8, 0));
		dsResult.addDataColumn(new GauceDataColumn("RET_YMD", GauceDataColumn.TB_DECIMAL, 8, 0));
		dsResult.addDataColumn(new GauceDataColumn("STA_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("NPEN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));

		dsResult.addDataColumn(new GauceDataColumn("SEA_FREE", GauceDataColumn.TB_DECIMAL, 10, 0));
		

		
		dsResult.addDataColumn(new GauceDataColumn("GOV_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("OTX_DED", GauceDataColumn.TB_DECIMAL, 10, 0));

		
		dsResult.addDataColumn(new GauceDataColumn("CASH_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DRE_INTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DRE_CTTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DRE_DFTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HOL_YN", GauceDataColumn.TB_DECIMAL, 1, 0));
		
		
		
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN1", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN2", GauceDataColumn.TB_STRING ));		
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN3", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));					
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		

		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN4", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN5", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));

		//dsResult.addDataColumn(new GauceDataColumn("BASE_VAL1", GauceDataColumn.TB_STRING ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_1", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_1", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_2", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_2", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_3", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_3", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_4", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_4", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_5", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_5", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_6", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_6", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_7", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_7", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_8", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_8", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_9", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_9", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_10", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_10", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_11", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_11", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_12", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_12", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_13", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_13", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_14", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_14", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_15", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_15", GauceDataColumn.TB_DECIMAL ));

			
		
        if(dsYACA001_SHR_14.getDataRowCnt() > 0){

        	int i=0;
        	int j=0;

			GauceDataRow grAdd  = null; // 추가될 row

			String YAC_SEL_KEY = "";                                                      
			String YAC_REC_TAG = "";                                                     
			String YAC_TAX_CD  = "";                                                      
			String YAC_COMP_CD = "";                                                    
			String YAC_CNT     = "";                                                         
			String YAC_NAM_KOR = "";                                                    
			String YAC_CET_NO  = "";                                                      
			String YAC_ZIP_NO  = "";                                                       
			String YAC_JUSO    = "";                                                        
			String YAC_JAS_NM  = "";                                                      
			String YAC_JAO_NO  = "";                                                      
			String YAC_SALT_AMTS  = "";                                                
			String YAC_SALT_AMTT  = "";                                                 
			String YAC_FREE_INCOME  = "";                                             
			String YAC_TAX_INCOME = "";                                               
			String YAC_OUTT_AMTS = "";	                                             
			String YAC_MGR_AMT = "";                                                    
			String YAC_MNI_AMT = "";                                                     
			String YAC_BADD_AMT   = "";                                                
			String YAC_SOU_CNT = "";                                                    
			String YAC_SPSB_AMT   = "";                                                 
			String YAC_DFM_CNT = "";                                                    
			String YAC_GDED_AMT   = "";                                                
			String YAC_GOL_CNT = "";                                                     
			String YAC_GOL_AMT = "";                                                    
                                         
			String YAC_TRB_CNT = "";                                                     
			String YAC_TBL_DED = "";                                                      
			String YAC_WDD_AMT = "";                                                                                                       
			String YAC_ONE_AMT = "";	   
			
                                                  
			String YAC_HINU_AMT = "";                                 
			String YAC_HINS_AMT = "";      
                                                
			String YAC_LH1_AMT = "";                                                   
			String YAC_LH2_AMT = "";                                                 
			String YAC_LH3_AMT = "";                                 
			String YAC_LH4_AMT = "";                                                
			String YAC_LH5_AMT = "";                                                
			String YAC_LH6_AMT = "";                                                
			String YAC_LH7_AMT = "";                                                
			String YAC_LH8_AMT = "";	
			String YAC_DON_FWD = "";	
			String YAC_PER_DED = "";			
                                              
			String YAC_CPC_DED = "";                                                     
			String YAC_NSE_TOT = "";                                                     
			String YAC_INDED_TOT  = "";                                                 
			String YAC_CARD_DED   = "";                                                 
			String YAC_SAVE_DED = "";                                                   
			String YAC_SAVE1_DED = "";                                    
			String YAC_SAVE2_DED = "";                                     
			String YAC_SAVE3_DED = "";     
			String YAC_SAJU_AMT = "";                                      
			String YAC_LSS_AMT = "";  			
			String YAC_ETC_TOT = ""; 	
			String YAC_VEN_DED = "";                                                     
			String YAC_TTAX_STD   = "";                                                  
			String YAC_TAX_AMT = "";                                                     
			String YAC_HGR_DED = "";  
			String YAC_AGE_AMT = "";  	
			
			String YAC_ANN_AMT   = "";                                                  
			String YAC_ANN_DED = "";                                                     
			String YAC_LIN_AMT = "";  
			String YAC_MIN_DED = "";  		
                       
			String YAC_MMA_AMT = "";	                                             
			String YAC_MMA_DED = "";                                                    
			String YAC_EDU_AMT = "";	                                             
			String YAC_EDU_DED = "";     
				
			String YAC_GOV1_AMT   = "";                                                  
			String YAC_GOV1_DED = "";                                                     
			String YAC_GOV2_AMT = "";  
			String YAC_GOV2_DED = "";  		
                       
			String YAC_LC1_AMT = "";	                                             
			String YAC_LC1_DED = "";                                                    
			String YAC_LC23_AMT = "";	                                             
			String YAC_LC23_DED = "";    	
			
			String YAC_MRENT_DED = ""; 			
			
			String YAC_TDED_TOT   = "";                                                 
			String YAC_DGG_TAX = "";                                                    
			String YAC_DBW_TAX = "";                                                    
			String YAC_DJM_TAX = "";                                                     
			String YAC_JAL_AMT = "";                                                      
			String YAC_JAC_AMT = "";                                                     
			String YAC_JAN_AMT = "";                                                     
			String YAC_INCM_TAX   = "";                                                 
			String YAC_CITI_TAX   = "";                                                   
			String EMS_HIR_YMD = "";                                                     
			String EMS_RET_YMD = "";                                                     
			String YAC_STA_TOT = "";                                                     
			String YAC_NPEN_DED   = "";                                                 
                                                   
			String YAC_SEA_FREE   = "";                                                  
			String YAC_GOV_DED = "";                                                    
			String YAC_OTX_DED = "";                                                     
			String YAC_CASH_AMT= "";                                                                                                      
			String YAC_DRE_INTX = "";                                                    
			String YAC_DRE_CTTX = "";                                                   
			String YAC_DRE_DFTX = "";                                                   
			String YAC_HOL_YN = "";                           
			
			String REL_CD1= "";  
			String NAM_KOR1 = "";        
			String CET_NO1 = ""; 
			String BAS_MAN1 = "";        
			String TRB_MAN1 = "";        
			String WCT_MAN1 = "";        
			String GOL_MAN1 = "";        
			String ONE_MAN1 = "";        
			String INV_NTS1 = "";     
			String INV2_NTS1 = ""; 			
			String MED_NTS1 = "";        
			String EDU_NTS1 = "";        
			String CARD_NTS1 = "";      
			String DIR_CARD_NTS1 = "";         
			String CASH_NTS1 = "";       
			String MARKET_NTS1 = "";   
			String PUBLIC_NTS1 = "";    
			String LC3_AMT_NTS1 = ""; 
			String INV_AMT1  = "";    
			String INV2_AMT1  = "";    			
			String MED_AMT1  = "";      
			String EDU_AMT1  = "";      
			String CARD_AMT1 = "";      
			String DIR_CARD_AMT1 = "";        
			String MARKET_AMT1 = "";  
			String PUBLIC_AMT1 = "";   
			String LC3_AMT1 = "";       
			
			
			String REL_CD2 = ""; 
			String NAM_KOR2 = "";        
			String CET_NO2 = ""; 
			String BAS_MAN2 = "";       
			String TRB_MAN2 = "";        
			String WCT_MAN2 = "";        
			String GOL_MAN2 = "";        
			String ONE_MAN2 = "";       
			String INV_NTS2 = "";    
			String INV2_NTS2 = "";			
			String MED_NTS2 = "";       
			String EDU_NTS2 = "";       
			String CARD_NTS2 = "";      
			String DIR_CARD_NTS2 = "";         
			String CASH_NTS2 = "";       
			String MARKET_NTS2 = "";  
			String PUBLIC_NTS2 = "";     
			String LC3_AMT_NTS2 = ""; 
			String INV_AMT2 = "";  
			String INV2_AMT2 = "";  			
			String MED_AMT2 = "";       
			String EDU_AMT2 = "";        
			String CARD_AMT2 = "";      
			String DIR_CARD_AMT2 = "";        
			String MARKET_AMT2 = "";   
			String PUBLIC_AMT2 = "";    
			String LC3_AMT2 = "";        
			
			
			String REL_CD3 = ""; 
			String NAM_KOR3 = "";        
			String CET_NO3 = ""; 
			String BAS_MAN3 = "";       
			String TRB_MAN3 = "";        
			String WCT_MAN3 = "";       
			String GOL_MAN3 = "";        
			String ONE_MAN3 = "";       
			String INV_NTS3 = "";      
			String INV2_NTS3 = ""; 			
			String MED_NTS3 = "";       
			String EDU_NTS3 = "";       
			String CARD_NTS3 = "";      
			String DIR_CARD_NTS3 = "";        
			String CASH_NTS3 = "";      
			String MARKET_NTS3 = "";   
			String PUBLIC_NTS3 = "";    
			String LC3_AMT_NTS3 = ""; 
			String INV_AMT3 = "";
			String INV2_AMT3 = "";			
			String MED_AMT3 = "";       
			String EDU_AMT3 = "";        
			String CARD_AMT3 = "";      
			String DIR_CARD_AMT3 = "";         
			String MARKET_AMT3 = "";  
			String PUBLIC_AMT3 = "";   
			String LC3_AMT3 = "";       
			
			
			String REL_CD4 = ""; 
			String NAM_KOR4 = "";       
			String CET_NO4 = ""; 
			String BAS_MAN4 = "";        
			String TRB_MAN4 = "";       
			String WCT_MAN4 = "";        
			String GOL_MAN4 = "";        
			String ONE_MAN4 = "";       
			String INV_NTS4 = "";   
			String INV2_NTS4 = ""; 			
			String MED_NTS4 = "";        
			String EDU_NTS4 = "";        
			String CARD_NTS4 = "";      
			String DIR_CARD_NTS4 = "";         
			String CASH_NTS4 = "";      
			String MARKET_NTS4 = "";  
			String PUBLIC_NTS4 = "";    
			String LC3_AMT_NTS4 = ""; 
			String INV_AMT4 = ""; 
			String INV2_AMT4 = ""; 			
			String MED_AMT4 = ""; 
			String EDU_AMT4 = "";      
			String CARD_AMT4 = "";   
			String DIR_CARD_AMT4 = "";     
			String MARKET_AMT4 = "";   
			String PUBLIC_AMT4 = "";     
			String LC3_AMT4 = ""; 
			
			
			String REL_CD5 = "";  
			String NAM_KOR5 = ""; 
			String CET_NO5 = "";        
			String BAS_MAN5 = "";      
			String TRB_MAN5 = "";    
			String WCT_MAN5 = "";   
			String GOL_MAN5 = "";  
			String ONE_MAN5 = ""; 
			String INV_NTS5 = ""; 
			String INV2_NTS5 = ""; 			
			String MED_NTS5 = "";  
			String EDU_NTS5 = "";      
			String CARD_NTS5 = "";   
			String DIR_CARD_NTS5  = "";   
			String CASH_NTS5 = "";  
			String MARKET_NTS5 = "";     
			String PUBLIC_NTS5 = "";   
			String LC3_AMT_NTS5 = "";        
			String INV_AMT5 = ""; 
			String INV2_AMT5 = "";  			
			String MED_AMT5 = ""; 
			String EDU_AMT5 = "";      
			String CARD_AMT5 = "";   
			String DIR_CARD_AMT5  = "";     
			String MARKET_AMT5 = "";   
			String PUBLIC_AMT5 = "";    
			String LC3_AMT5 = "";                     
			
			
			
			String PEN_GUBUN_CD_1 = "";                                              
			String ABA_CD_1 = "";                                                           
			String ABA_NM_1 = "";                                                          
			String ACC_NO_1 = "";                                                                                                               
			String AMOUNT_1 = "";                                                           
			String DED_AMT_1 = "";    
			
			
			String PEN_GUBUN_CD_2 = "";                                              
			String ABA_CD_2 = "";                                                           
			String ABA_NM_2 = "";                                                          
			String ACC_NO_2 = "";                                                                                                  
			String AMOUNT_2 = "";                                                           
			String DED_AMT_2 = "";    
			
			
			String PEN_GUBUN_CD_3 = "";                                              
			String ABA_CD_3 = "";                                                           
			String ABA_NM_3 = "";                                                          
			String ACC_NO_3 = "";                                                                      
			String AMOUNT_3 = "";                                                           
			String DED_AMT_3 = "";      
			
			
			String PEN_GUBUN_CD_4 = "";                                              
			String ABA_CD_4 = "";                                                           
			String ABA_NM_4 = "";                                                          
			String ACC_NO_4 = "";                                                                    
			String AMOUNT_4 = "";                                                           
			String DED_AMT_4 = "";    
			
			
			String PEN_GUBUN_CD_5 = "";                                              
			String ABA_CD_5 = "";                                                           
			String ABA_NM_5 = "";                                                          
			String ACC_NO_5 = "";                                                                      
			String AMOUNT_5 = "";                                                           
			String DED_AMT_5 = "";    
			
			
			String PEN_GUBUN_CD_6 = "";                                              
			String ABA_CD_6 = "";                                                           
			String ABA_NM_6 = "";                                                          
			String ACC_NO_6 = "";                                                             
			String AMOUNT_6 = "";                                                           
			String DED_AMT_6 = "";    
			
			
			String PEN_GUBUN_CD_7 = "";                                              
			String ABA_CD_7 = "";                                                           
			String ABA_NM_7 = "";                                                          
			String ACC_NO_7 = "";                                                                
			String AMOUNT_7 = "";                                                           
			String DED_AMT_7 = "";       
			
			
			String PEN_GUBUN_CD_8 = "";                                              
			String ABA_CD_8 = "";                                                           
			String ABA_NM_8 = "";                                                          
			String ACC_NO_8 = "";                                                           
			String AMOUNT_8 = "";                                                           
			String DED_AMT_8 = "";        
			
			
			String PEN_GUBUN_CD_9 = "";                                              
			String ABA_CD_9 = "";                                                           
			String ABA_NM_9 = "";                                                          
			String ACC_NO_9 = "";                                                          
			String AMOUNT_9 = "";                                                           
			String DED_AMT_9 = "";      
			
			
			String PEN_GUBUN_CD_10 = "";                                            
			String ABA_CD_10 = "";                                                         
			String ABA_NM_10 = "";                                                        
			String ACC_NO_10 = "";                                                        
			String AMOUNT_10 = "";                                                         
			String DED_AMT_10 = "";           
			
			
			String PEN_GUBUN_CD_11 = "";                                            
			String ABA_CD_11 = "";                                                         
			String ABA_NM_11 = "";                                                        
			String ACC_NO_11 = "";                                                        
			String AMOUNT_11 = "";                                                         
			String DED_AMT_11 = "";        
			
			
			String PEN_GUBUN_CD_12 = "";                                            
			String ABA_CD_12 = "";                                                         
			String ABA_NM_12 = "";                                                        
			String ACC_NO_12 = "";                                                        
			String AMOUNT_12 = "";                                                         
			String DED_AMT_12 = "";        
			
			
			String PEN_GUBUN_CD_13 = "";                                            
			String ABA_CD_13 = "";                                                         
			String ABA_NM_13 = "";                                                        
			String ACC_NO_13 = "";                                                        
			String AMOUNT_13 = "";                                                         
			String DED_AMT_13 = "";            
			
			
			String PEN_GUBUN_CD_14 = "";                                            
			String ABA_CD_14 = "";                                                         
			String ABA_NM_14 = "";                                                        
			String ACC_NO_14 = "";                                                        
			String AMOUNT_14 = "";                                                         
			String DED_AMT_14 = "";        
			
			
			String PEN_GUBUN_CD_15 = "";                                            
			String ABA_CD_15 = "";                                                         
			String ABA_NM_15 = "";                                                        
			String ACC_NO_15 = "";                                                        
			String AMOUNT_15 = "";                                                         
			String DED_AMT_15 = "";                                    

    	    
	        for(i=1; i<=dsYACA001_SHR_14.getDataRowCnt(); i++){

	    	    YAC_SEL_KEY = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SEL_KEY");
		        YAC_REC_TAG = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_REC_TAG");
		        YAC_TAX_CD  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TAX_CD");
		        YAC_COMP_CD = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_COMP_CD");
		        YAC_CNT     = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CNT");
		        YAC_NAM_KOR = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_NAM_KOR");
		        YAC_CET_NO  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CET_NO");
		        YAC_ZIP_NO  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ZIP_NO");
		        YAC_JUSO    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JUSO");
		        YAC_JAS_NM  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAS_NM");
		        YAC_JAO_NO  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAO_NO");
		        YAC_SALT_AMTS  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SALT_AMTS");		        
		        YAC_SALT_AMTT  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SALT_AMTT"  );
		        YAC_FREE_INCOME= GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_FREE_INCOME");
		        YAC_TAX_INCOME = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TAX_INCOME" );
		        YAC_OUTT_AMTS    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_OUTT_AMTS" );		        
		        YAC_MGR_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MGR_AMT" );
		        YAC_MNI_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MNI_AMT" );
		        YAC_BADD_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_BADD_AMT");
		        YAC_SOU_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SOU_CNT" );
		        YAC_SPSB_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SPSB_AMT");
		        YAC_DFM_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DFM_CNT" );
		        YAC_GDED_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GDED_AMT");
		        YAC_GOL_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOL_CNT" );
		        YAC_GOL_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOL_AMT" );

		        YAC_TRB_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TRB_CNT" );
		        YAC_TBL_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TBL_DED" );
		        YAC_WDD_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_WDD_AMT" );
		        YAC_ONE_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ONE_AMT" );		        

		        YAC_HINU_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HINU_AMT" ); 
		        YAC_HINS_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HINS_AMT" );

		        YAC_LH1_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH1_AMT");
		        YAC_LH2_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH2_AMT");
		        YAC_LH3_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH3_AMT"); 
		        YAC_LH4_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH4_AMT");
		        YAC_LH5_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH5_AMT");
		        YAC_LH6_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH6_AMT");
		        YAC_LH7_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH7_AMT");
		        YAC_LH8_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH8_AMT");		
		        YAC_DON_FWD   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DON_FWD");		
		        YAC_PER_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_PER_DED");			        

		        YAC_CPC_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CPC_DED" );
		        YAC_NSE_TOT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_NSE_TOT" );
		        YAC_INDED_TOT  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_INDED_TOT"  );
		        YAC_CARD_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CARD_DED");
		        YAC_SAVE_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE_DED");
		        YAC_SAVE1_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE1_DED"); 
		        YAC_SAVE2_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE2_DED");
		        YAC_SAVE3_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE3_DED"); 
		        YAC_SAJU_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAJU_AMT");
		        YAC_LSS_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LSS_AMT"); 		        
		        YAC_ETC_TOT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ETC_TOT"); 		        
		        YAC_VEN_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_VEN_DED" );
		        YAC_TTAX_STD   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TTAX_STD");
		        YAC_TAX_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TAX_AMT" );
		        YAC_HGR_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HGR_DED" );
		        YAC_AGE_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_AGE_AMT" );	

		        YAC_ANN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ANN_AMT" );		        
		        YAC_ANN_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ANN_DED" );  			        
		        YAC_LIN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LIN_AMT" );		        
		        YAC_MIN_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MIN_DED" );  		        
		        
				YAC_MMA_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MMA_AMT" );  
				YAC_MMA_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MMA_DED" );		        
				YAC_EDU_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_EDU_AMT" );
				YAC_EDU_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_EDU_DED" );			        
				
				YAC_GOV1_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV1_AMT" );		        
				YAC_GOV1_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV1_DED" );  			        
				YAC_GOV2_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV2_AMT" );		        
				YAC_GOV2_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV2_DED" );  		        
		        
				YAC_LC1_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC1_AMT" );  
				YAC_LC1_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC1_DED" );		        
				YAC_LC23_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC23_AMT" );
				YAC_LC23_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC23_DED" );					

				YAC_MRENT_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MRENT_DED" );  				
				
		        YAC_TDED_TOT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TDED_TOT");
		        YAC_DGG_TAX    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DGG_TAX" );
		        YAC_DBW_TAX    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DBW_TAX" );
		        YAC_DJM_TAX    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DJM_TAX" );
		        YAC_JAL_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAL_AMT" );
		        YAC_JAC_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAC_AMT" );
		        YAC_JAN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAN_AMT" );
		        YAC_INCM_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_INCM_TAX");
		        YAC_CITI_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CITI_TAX");
		        EMS_HIR_YMD    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EMS_HIR_YMD" );
		        EMS_RET_YMD    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EMS_RET_YMD" );
		        YAC_STA_TOT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_STA_TOT" );
		        YAC_NPEN_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_NPEN_DED");

		        YAC_SEA_FREE   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SEA_FREE");
		        YAC_GOV_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV_DED" );
		        YAC_OTX_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_OTX_DED" );
		        YAC_CASH_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CASH_AMT");
		        YAC_DRE_INTX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DRE_INTX");
		        YAC_DRE_CTTX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DRE_CTTX");
		        YAC_DRE_DFTX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DRE_DFTX");
		        YAC_HOL_YN   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HOL_YN");

		        
		        REL_CD1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD1");
		        NAM_KOR1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR1");

			    //System.out.println("-----------1818181818181818---------" +NAM_KOR1);
			    /*				    
			    System.out.println("-----------GauceDataColumn---------" +EDU_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +CARD_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +DIR_CARD_NTS5);			    
			    System.out.println("-----------GauceDataColumn---------" +CASH_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +MARKET_NTS5);			    
			    System.out.println("-----------GauceDataColumn---------" +PUBLIC_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +LC3_AMT_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +INV_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +EDU_AMT5);			        
			    System.out.println("-----------GauceDataColumn---------" +CARD_AMT5);			    
			    System.out.println("-----------GauceDataColumn---------" +DIR_CARD_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +MARKET_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +PUBLIC_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +LC3_AMT5);			        */
		        
		        CET_NO1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO1");
		        BAS_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN1");
		        TRB_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN1");
		        WCT_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN1");
		        GOL_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN1");
		        ONE_MAN1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN1");		      
		        INV_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS1");
		        INV2_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS1");		        
		        MED_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS1");
		        EDU_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS1");
		        CARD_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS1");
		        DIR_CARD_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS1");
		        CASH_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS1");
		        MARKET_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS1");		 
		        PUBLIC_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS1");		 
		        LC3_AMT_NTS1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS1");
		        INV_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT1");
		        INV2_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT1");		        
		        MED_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT1");
		        EDU_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT1");
		        CARD_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT1");
		        DIR_CARD_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT1");
		        MARKET_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT1");		  
		        PUBLIC_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT1");		   
		        LC3_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT1");
		        
		        
		        REL_CD2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD2");
		        NAM_KOR2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR2");
		        CET_NO2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO2");
		        BAS_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN2");
		        TRB_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN2");
		        WCT_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN2");
		        GOL_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN2");
		        ONE_MAN2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN2");		        
		        INV_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS2");
		        INV2_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS2");		        
		        MED_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS2");
		        EDU_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS2");
		        CARD_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS2");
		        DIR_CARD_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS2");
		        CASH_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS2");
		        MARKET_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS2");		
		        PUBLIC_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS2");		        
		        LC3_AMT_NTS2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS2");
		        INV_AMT2        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT2");
		        INV2_AMT2        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT2");		        
		        MED_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT2");
		        EDU_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT2");
		        CARD_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT2");
		        DIR_CARD_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT2");
		        MARKET_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT2");		     
		        PUBLIC_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT2");			       
		        LC3_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT2");
		        
		        
		        REL_CD3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD3");
		        NAM_KOR3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR3");
		        CET_NO3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO3");
		        BAS_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN3");
		        TRB_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN3");
		        WCT_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN3");
		        GOL_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN3");
		        ONE_MAN3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN3");		        
		        INV_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS3");
		        INV2_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS3");		        
		        MED_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS3");
		        EDU_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS3");
		        CARD_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS3");
		        DIR_CARD_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS3");
		        CASH_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS3");
		        MARKET_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS3");		        
		        PUBLIC_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS3");		        
		        LC3_AMT_NTS3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS3");
		        INV_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT3");
		        INV2_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT3");		        
		        MED_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT3");
		        EDU_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT3");
		        CARD_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT3");
		        DIR_CARD_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT3");
		        MARKET_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT3");		        
		        PUBLIC_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT3");			        
		        LC3_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT3");
		        

		        REL_CD4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD4");
		        NAM_KOR4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR4");
		        CET_NO4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO4");
		        BAS_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN4");
		        TRB_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN4");
		        WCT_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN4");
		        GOL_MAN4        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN4");
		        ONE_MAN4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN4");		        
		        INV_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS4");
		        INV2_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS4");		        
		        MED_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS4");
		        EDU_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS4");
		        CARD_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS4");
		        DIR_CARD_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS4");
		        CASH_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS4");
		        MARKET_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS4");		        
		        PUBLIC_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS4");		        
		        LC3_AMT_NTS4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS4");
		        INV_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT4");
		        INV2_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT4");		        
		        MED_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT4");
		        EDU_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT4");
		        CARD_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT4");
		        DIR_CARD_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT4");
		        MARKET_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT4");		        
		        PUBLIC_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT4");			        
		        LC3_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT4");


		        REL_CD5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD5");
		        NAM_KOR5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR5");
		        CET_NO5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO5");
		        BAS_MAN5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN5");
		        TRB_MAN5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN5");
		        WCT_MAN5        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN5");
		        GOL_MAN5        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN5");
		        ONE_MAN5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN5");		        
		        INV_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS5");
		        INV2_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS5");		        
		        MED_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS5");
		        EDU_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS5");
		        CARD_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS5");
		        DIR_CARD_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS5");
		        CASH_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS5");
		        MARKET_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS5");		        
		        PUBLIC_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS5");		        
		        LC3_AMT_NTS5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS5");
		        INV_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT5");
		        INV2_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT5");		        
		        MED_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT5");
		        EDU_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT5");
		        CARD_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT5");
		        DIR_CARD_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT5");
		        MARKET_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT5");		     
		        PUBLIC_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT5");			      
		        LC3_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT5");

			        
		        
		        PEN_GUBUN_CD_1 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_1");
		        ABA_CD_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_1");
		        ABA_NM_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_1");
		        ACC_NO_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_1");
		        AMOUNT_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_1");
		        DED_AMT_1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_1");
		        
		        
		        PEN_GUBUN_CD_2 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_2");
		        ABA_CD_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_2");
		        ABA_NM_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_2");
		        ACC_NO_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_2");
		        AMOUNT_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_2");
		        DED_AMT_2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_2");
		        
		        
		        PEN_GUBUN_CD_3 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_3");
		        ABA_CD_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_3");
		        ABA_NM_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_3");
		        ACC_NO_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_3");
		        AMOUNT_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_3");
		        DED_AMT_3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_3");
		        
		        
		        PEN_GUBUN_CD_4 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_4");
		        ABA_CD_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_4");
		        ABA_NM_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_4");
		        ACC_NO_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_4");
		        AMOUNT_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_4");
		        DED_AMT_4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_4");
		        
		        
		        PEN_GUBUN_CD_5 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_5");
		        ABA_CD_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_5");
		        ABA_NM_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_5");
		        ACC_NO_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_5");
		        AMOUNT_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_5");
		        DED_AMT_5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_5");
		        
		        
		        PEN_GUBUN_CD_6 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_6");
		        ABA_CD_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_6");
		        ABA_NM_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_6");
		        ACC_NO_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_6");
		        AMOUNT_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_6");
		        DED_AMT_6      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_6");
		        
		        
		        PEN_GUBUN_CD_7 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_7");
		        ABA_CD_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_7");
		        ABA_NM_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_7");
		        ACC_NO_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_7");
		        AMOUNT_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_7");
		        DED_AMT_7      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_7");
		        
		        
		        PEN_GUBUN_CD_8 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_8");
		        ABA_CD_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_8");
		        ABA_NM_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_8");
		        ACC_NO_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_8");
		        AMOUNT_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_8");
		        DED_AMT_8      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_8");
		        
		        
		        PEN_GUBUN_CD_9 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_9");
		        ABA_CD_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_9");
		        ABA_NM_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_9");
		        ACC_NO_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_9");
		        AMOUNT_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_9");
		        DED_AMT_9      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_9");
		        
		        
		        PEN_GUBUN_CD_10 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_10");
		        ABA_CD_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_10");
		        ABA_NM_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_10");
		        ACC_NO_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_10");
		        AMOUNT_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_10");
		        DED_AMT_10      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_10");
		        
		        
		        PEN_GUBUN_CD_11 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_11");
		        ABA_CD_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_11");
		        ABA_NM_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_11");
		        ACC_NO_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_11");
		        AMOUNT_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_11");
		        DED_AMT_11      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_11");
		        
		        
		        PEN_GUBUN_CD_12 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_12");
		        ABA_CD_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_12");
		        ABA_NM_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_12");
		        ACC_NO_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_12");
		        AMOUNT_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_12");
		        DED_AMT_12      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_12");
		        
		        
		        PEN_GUBUN_CD_13 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_13");
		        ABA_CD_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_13");
		        ABA_NM_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_13");
		        ACC_NO_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_13");
		        AMOUNT_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_13");
		        DED_AMT_13      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_13");
		        
		        
		        PEN_GUBUN_CD_14 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_14");
		        ABA_CD_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_14");
		        ABA_NM_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_14");
		        ACC_NO_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_14");
		        AMOUNT_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_14");
		        DED_AMT_14      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_14");
		        
		        
		        PEN_GUBUN_CD_15 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_15");
		        ABA_CD_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_15");
		        ABA_NM_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_15");
		        ACC_NO_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_15");
		        AMOUNT_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_15");
		        DED_AMT_15      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_15");


		        
		        /* 기본공제, 추가공제 공제별 전액 기록을 위한 체크부분  -2001.02 */
		        if (YAC_REC_TAG.equals("C") ) {

			         /* 본인공제 */
			         if ((Long.parseLong(JSPUtil.rns3(YAC_BADD_AMT)) == 0) || (Long.parseLong(JSPUtil.rns3(YAC_BADD_AMT)) < 1500000)){
			              YAC_BADD_AMT = "1500000";
			         }

			         /* 배우자공제 */
			         if (JSPUtil.rns3(YAC_SOU_CNT).equals("1")){
			             YAC_SPSB_AMT = "1500000";
			         }

			         /* 부양가족공제 */
			         if (!JSPUtil.rns3(YAC_DFM_CNT).equals("0")  && !JSPUtil.rns3(YAC_DFM_CNT).equals("")){
			             YAC_GDED_AMT = Long.toString( Long.parseLong(YAC_DFM_CNT) * 1500000 );
			         }

			         /* 경로우대공제
			       /*  if (!JSPUtil.rns3(YAC_GOL_CNT65).equals("0") && !JSPUtil.rns3(YAC_GOL_CNT65).equals("")){
			             TMP_GOL_AMT65 = Long.toString( Long.parseLong(YAC_GOL_CNT65) * 1000000);
			         }  
			          	*/
			         if (!JSPUtil.rns3(YAC_GOL_CNT).equals("0") && !JSPUtil.rns3(YAC_GOL_CNT).equals("")){
			        	 YAC_GOL_AMT = Long.toString( Long.parseLong(YAC_GOL_CNT) * 1000000);
			         } 

			         //YAC_GOL_AMT = Long.toString( Long.parseLong(TMP_GOL_AMT65) + Long.parseLong(TMP_GOL_AMT70) );
			          
			         
			         
			         /* 장애자공제액 */
			         if (!JSPUtil.rns3(YAC_TRB_CNT).equals("0") && !JSPUtil.rns3(YAC_TRB_CNT).equals("")){
       		             YAC_TBL_DED = Long.toString( Long.parseLong(YAC_TRB_CNT) * 2000000);
			         }

			         /* 부녀자공제액 */
			         if (!JSPUtil.rns3(YAC_WDD_AMT).equals("0") && (Long.parseLong(JSPUtil.rns3(YAC_WDD_AMT)) < 500000) ){
			        	 YAC_WDD_AMT = "500000";
			         }

		        }

		        j = 0;

		        grAdd = new GauceDataRow(dsResult.getDataColCnt());
		        
		        grAdd.setString(j++, YAC_REC_TAG);
		        grAdd.setString(j++, YAC_TAX_CD);
		        grAdd.setString(j++, YAC_COMP_CD);
		        grAdd.setString(j++, YAC_CNT);
		        grAdd.setString(j++, YAC_NAM_KOR);
		        grAdd.setString(j++, YAC_CET_NO);
		        grAdd.setString(j++, YAC_ZIP_NO);
		        grAdd.setString(j++, YAC_JUSO);
		        grAdd.setString(j++, YAC_JAS_NM);
		        grAdd.setString(j++, YAC_JAO_NO);
		        grAdd.setString(j++, YAC_SALT_AMTS);
		        grAdd.setString(j++, YAC_SALT_AMTT);
		        grAdd.setString(j++, YAC_FREE_INCOME);
		        grAdd.setString(j++, YAC_TAX_INCOME);
		        grAdd.setString(j++, YAC_OUTT_AMTS);		        
		        grAdd.setString(j++, YAC_MGR_AMT);
		        grAdd.setString(j++, YAC_MNI_AMT);
		        grAdd.setString(j++, YAC_BADD_AMT);
		        grAdd.setString(j++, YAC_SOU_CNT);		        
		        grAdd.setString(j++, YAC_SPSB_AMT);
		        grAdd.setString(j++, YAC_DFM_CNT);
		        grAdd.setString(j++, YAC_GDED_AMT);
		        grAdd.setString(j++, YAC_GOL_CNT);
		        grAdd.setString(j++, YAC_GOL_AMT);	        
		        grAdd.setString(j++, YAC_TRB_CNT);
		        grAdd.setString(j++, YAC_TBL_DED);
		        grAdd.setString(j++, YAC_WDD_AMT);
		        grAdd.setString(j++, YAC_ONE_AMT);		     
		        

		        grAdd.setString(j++, YAC_HINU_AMT); //2010, 건강보험료
		        grAdd.setString(j++, YAC_HINS_AMT); //2010, 고용보험료

		        
		        grAdd.setString(j++, YAC_LH1_AMT);//주택자금_주택임차차입금원리금상환액_대출기관
		        grAdd.setString(j++, YAC_LH2_AMT);//주택자금_주택임차차입금원리금상환액_거주자
		        grAdd.setString(j++, YAC_LH3_AMT); //주택자금_월세액
		        grAdd.setString(j++, YAC_LH4_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_15년미만
		       	grAdd.setString(j++, YAC_LH5_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_15년~29년
		        grAdd.setString(j++, YAC_LH6_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_30년이상
		        grAdd.setString(j++, YAC_LH7_AMT);//(2012년 이후 차입분)고정금리비거치 상환 대출
		        grAdd.setString(j++, YAC_LH8_AMT);//(2012년 이후 차입분)기타 대출	
		        grAdd.setString(j++, YAC_DON_FWD);//기부금 이월금  
		        grAdd.setString(j++, YAC_PER_DED);//개인연금저축소득공제  		        
	        
		        grAdd.setString(j++, YAC_CPC_DED);
		        grAdd.setString(j++, YAC_NSE_TOT);
		        grAdd.setString(j++, YAC_INDED_TOT);
		        grAdd.setString(j++, YAC_CARD_DED);
		        grAdd.setString(j++, YAC_SAVE_DED);
		        grAdd.setString(j++, YAC_SAVE1_DED); //청약저축
		        grAdd.setString(j++, YAC_SAVE2_DED); //주택청약종합저축
		        grAdd.setString(j++, YAC_SAVE3_DED); //근로자주택마련저축
		        grAdd.setString(j++, YAC_SAJU_AMT); //우리사주조합 출연금
		        grAdd.setString(j++, YAC_LSS_AMT); //장기집합투자증권저축	   
		        grAdd.setString(j++, YAC_ETC_TOT); //그밖의 소득공제 계 		        
		        grAdd.setString(j++, YAC_VEN_DED);
		        grAdd.setString(j++, YAC_TTAX_STD);
		        grAdd.setString(j++, YAC_TAX_AMT);
		        grAdd.setString(j++, YAC_HGR_DED);
		        grAdd.setString(j++, YAC_AGE_AMT);		    
		        
		        grAdd.setString(j++, YAC_ANN_AMT);
		        grAdd.setString(j++, YAC_ANN_DED);
		        grAdd.setString(j++, YAC_LIN_AMT);
		        grAdd.setString(j++, YAC_MIN_DED);			        

		        grAdd.setString(j++, YAC_MMA_AMT);//의료비 공제금액		      
		        grAdd.setString(j++, YAC_MMA_DED);//의료비세액공제
		        grAdd.setString(j++, YAC_EDU_AMT);//교육비공제금액		        
		        grAdd.setString(j++, YAC_EDU_DED);//교육비 세액공제	        
		        
		        grAdd.setString(j++, YAC_GOV1_AMT);
		        grAdd.setString(j++, YAC_GOV1_DED);
		        grAdd.setString(j++, YAC_GOV2_AMT);
		        grAdd.setString(j++, YAC_GOV2_DED);			        	

		        grAdd.setString(j++, YAC_LC1_AMT);//법정기부금      
		        grAdd.setString(j++, YAC_LC1_DED);//법정기부금
		        grAdd.setString(j++, YAC_LC23_AMT);//지정기부금		        
		        grAdd.setString(j++, YAC_LC23_DED);//지정기부금
		        
		        grAdd.setString(j++, YAC_MRENT_DED);//월세 세액공제	   
		        
		        grAdd.setString(j++, YAC_TDED_TOT);
		        grAdd.setString(j++, YAC_DGG_TAX);
		        grAdd.setString(j++, YAC_DBW_TAX);
		        grAdd.setString(j++, YAC_DJM_TAX);
		        grAdd.setString(j++, YAC_JAL_AMT);
		        grAdd.setString(j++, YAC_JAC_AMT);
		        grAdd.setString(j++, YAC_JAN_AMT);
		        grAdd.setString(j++, YAC_INCM_TAX);
		        grAdd.setString(j++, YAC_CITI_TAX);
		        
	    	    //System.out.println("-----------EMS_HIR_YMD---------"+EMS_HIR_YMD);		        
	    	    //System.out.println("-----------EMS_RET_YMD---------"+EMS_RET_YMD);	
		        
		        grAdd.setString(j++, EMS_HIR_YMD);
		        grAdd.setString(j++, EMS_RET_YMD);
		        grAdd.setString(j++, YAC_STA_TOT);
		        grAdd.setString(j++, YAC_NPEN_DED);

		        grAdd.setString(j++, YAC_SEA_FREE);
		        grAdd.setString(j++, YAC_GOV_DED);
		        grAdd.setString(j++, YAC_OTX_DED);
		        grAdd.setString(j++, YAC_CASH_AMT);
		        grAdd.setString(j++, YAC_DRE_INTX);
		        grAdd.setString(j++, YAC_DRE_CTTX);
		        grAdd.setString(j++, YAC_DRE_DFTX);
		        
	
		        
		        grAdd.setString(j++, YAC_HOL_YN);
	    	    //System.out.println("-----------YAC_HOL_YN---------"+YAC_HOL_YN);		        
	    	    //System.out.println("-----------REL_CD1---------"+REL_CD1);			        
		        
		        grAdd.setString(j++,REL_CD1);	        
		        grAdd.setString(j++,NAM_KOR1);
		        grAdd.setString(j++,CET_NO1);
		        grAdd.setString(j++,BAS_MAN1);
		        grAdd.setString(j++,TRB_MAN1);
		        grAdd.setString(j++,WCT_MAN1);
		        grAdd.setString(j++,GOL_MAN1);
		        grAdd.setString(j++,ONE_MAN1);
		        grAdd.setString(j++,INV_NTS1);
		        grAdd.setString(j++,INV2_NTS1);		        
		        grAdd.setString(j++,MED_NTS1);
		        grAdd.setString(j++,EDU_NTS1);
		        grAdd.setString(j++,CARD_NTS1);
		        grAdd.setString(j++,DIR_CARD_NTS1);
		        grAdd.setString(j++,CASH_NTS1);
		        grAdd.setString(j++,MARKET_NTS1);
		        grAdd.setString(j++,PUBLIC_NTS1);
		        grAdd.setString(j++,LC3_AMT_NTS1);
		        grAdd.setString(j++,INV_AMT1);
		        grAdd.setString(j++,INV2_AMT1);		        
		        grAdd.setString(j++,MED_AMT1);
		        grAdd.setString(j++,EDU_AMT1);
		        grAdd.setString(j++,CARD_AMT1);
		        grAdd.setString(j++,DIR_CARD_AMT1);
		        grAdd.setString(j++,MARKET_AMT1);
		        grAdd.setString(j++,PUBLIC_AMT1);
		        grAdd.setString(j++,LC3_AMT1);
		        

		        grAdd.setString(j++,REL_CD2);
		        grAdd.setString(j++,NAM_KOR2);
		        grAdd.setString(j++,CET_NO2);
		        grAdd.setString(j++,BAS_MAN2);
		        grAdd.setString(j++,TRB_MAN2);
		        grAdd.setString(j++,WCT_MAN2);
		        grAdd.setString(j++,GOL_MAN2);
		        grAdd.setString(j++,ONE_MAN2);
		        grAdd.setString(j++,INV_NTS2);
		        grAdd.setString(j++,INV2_NTS2);		        
		        grAdd.setString(j++,MED_NTS2);
		        grAdd.setString(j++,EDU_NTS2);
		        grAdd.setString(j++,CARD_NTS2);
		        grAdd.setString(j++,DIR_CARD_NTS2);
		        grAdd.setString(j++,CASH_NTS2);
		        grAdd.setString(j++,MARKET_NTS2);
		        grAdd.setString(j++,PUBLIC_NTS2);
		        grAdd.setString(j++,LC3_AMT_NTS2);
		        grAdd.setString(j++,INV_AMT2);
		        grAdd.setString(j++,INV2_AMT2);		        
		        grAdd.setString(j++,MED_AMT2);
		        grAdd.setString(j++,EDU_AMT2);
		        grAdd.setString(j++,CARD_AMT2);
		        grAdd.setString(j++,DIR_CARD_AMT2);
		        grAdd.setString(j++,MARKET_AMT2);
		        grAdd.setString(j++,PUBLIC_AMT2);
		        grAdd.setString(j++,LC3_AMT2);
		        

		        grAdd.setString(j++,REL_CD3);
		        grAdd.setString(j++,NAM_KOR3);
		        grAdd.setString(j++,CET_NO3);
		        grAdd.setString(j++,BAS_MAN3);
		        grAdd.setString(j++,TRB_MAN3);
		        grAdd.setString(j++,WCT_MAN3);
		        grAdd.setString(j++,GOL_MAN3);
		        grAdd.setString(j++,ONE_MAN3);
		        grAdd.setString(j++,INV_NTS3);
		        grAdd.setString(j++,INV2_NTS3);		        
		        grAdd.setString(j++,MED_NTS3);
		        grAdd.setString(j++,EDU_NTS3);
		        grAdd.setString(j++,CARD_NTS3);
		        grAdd.setString(j++,DIR_CARD_NTS3);
		        grAdd.setString(j++,CASH_NTS3);
		        grAdd.setString(j++,MARKET_NTS3);
		        grAdd.setString(j++,PUBLIC_NTS3);
		        grAdd.setString(j++,LC3_AMT_NTS3);
		        grAdd.setString(j++,INV_AMT3);
		        grAdd.setString(j++,INV2_AMT3);		        
		        grAdd.setString(j++,MED_AMT3);
		        grAdd.setString(j++,EDU_AMT3);
		        grAdd.setString(j++,CARD_AMT3);
		        grAdd.setString(j++,DIR_CARD_AMT3);
		        grAdd.setString(j++,MARKET_AMT3);
		        grAdd.setString(j++,PUBLIC_AMT3);
		        grAdd.setString(j++,LC3_AMT3);
		        
	        
		        grAdd.setString(j++,REL_CD4);
		        grAdd.setString(j++,NAM_KOR4);
		        grAdd.setString(j++,CET_NO4);
		        grAdd.setString(j++,BAS_MAN4);
		        grAdd.setString(j++,TRB_MAN4);
		        grAdd.setString(j++,WCT_MAN4);
		        grAdd.setString(j++,GOL_MAN4);
		        grAdd.setString(j++,ONE_MAN4);
		        grAdd.setString(j++,INV_NTS4);
		        grAdd.setString(j++,INV2_NTS4);		        
		        grAdd.setString(j++,MED_NTS4);
		        grAdd.setString(j++,EDU_NTS4);
		        grAdd.setString(j++,CARD_NTS4);
		        grAdd.setString(j++,DIR_CARD_NTS4);
		        grAdd.setString(j++,CASH_NTS4);
		        grAdd.setString(j++,MARKET_NTS4);
		        grAdd.setString(j++,PUBLIC_NTS4);
		        grAdd.setString(j++,LC3_AMT_NTS4);
		        grAdd.setString(j++,INV_AMT4);
		        grAdd.setString(j++,INV2_AMT4);		        
		        grAdd.setString(j++,MED_AMT4);
		        grAdd.setString(j++,EDU_AMT4);
		        grAdd.setString(j++,CARD_AMT4);
		        grAdd.setString(j++,DIR_CARD_AMT4);
		        grAdd.setString(j++,MARKET_AMT4);
		        grAdd.setString(j++,PUBLIC_AMT4);
		        grAdd.setString(j++,LC3_AMT4);
		        

		        grAdd.setString(j++,REL_CD5);
		        grAdd.setString(j++,NAM_KOR5);
		        grAdd.setString(j++,CET_NO5);
		        grAdd.setString(j++,BAS_MAN5);
		        grAdd.setString(j++,TRB_MAN5);
		        grAdd.setString(j++,WCT_MAN5);
		        grAdd.setString(j++,GOL_MAN5);
		        grAdd.setString(j++,ONE_MAN5);
		        grAdd.setString(j++,INV_NTS5);
		        grAdd.setString(j++,INV2_NTS5);		        
		        grAdd.setString(j++,MED_NTS5);
		        grAdd.setString(j++,EDU_NTS5);
		        grAdd.setString(j++,CARD_NTS5);
		        grAdd.setString(j++,DIR_CARD_NTS5);
		        grAdd.setString(j++,CASH_NTS5);
		        grAdd.setString(j++,MARKET_NTS5);
		        grAdd.setString(j++,PUBLIC_NTS5);
		        grAdd.setString(j++,LC3_AMT_NTS5);
		        grAdd.setString(j++,INV_AMT5);
		        grAdd.setString(j++,INV2_AMT5);		        
		        grAdd.setString(j++,MED_AMT5);
		        grAdd.setString(j++,EDU_AMT5);
		        grAdd.setString(j++,CARD_AMT5);
		        grAdd.setString(j++,DIR_CARD_AMT5);
		        grAdd.setString(j++,MARKET_AMT5);
		        grAdd.setString(j++,PUBLIC_AMT5);
		        grAdd.setString(j++,LC3_AMT5);
		        //grAdd.setString(j++, YAC_SEL_KEY);

		        grAdd.setString(j++, PEN_GUBUN_CD_1);
		        grAdd.setString(j++, ABA_CD_1);
		        grAdd.setString(j++, ABA_NM_1);
		        grAdd.setString(j++, ACC_NO_1);
		        grAdd.setString(j++, AMOUNT_1);
		        grAdd.setString(j++, DED_AMT_1);

		        grAdd.setString(j++, PEN_GUBUN_CD_2);
		        grAdd.setString(j++, ABA_CD_2);
		        grAdd.setString(j++, ABA_NM_2);
		        grAdd.setString(j++, ACC_NO_2);
		        grAdd.setString(j++, AMOUNT_2);
		        grAdd.setString(j++, DED_AMT_2);

		        grAdd.setString(j++, PEN_GUBUN_CD_3);
		        grAdd.setString(j++, ABA_CD_3);
		        grAdd.setString(j++, ABA_NM_3);
		        grAdd.setString(j++, ACC_NO_3);
		        grAdd.setString(j++, AMOUNT_3);
		        grAdd.setString(j++, DED_AMT_3);

		        grAdd.setString(j++, PEN_GUBUN_CD_4);
		        grAdd.setString(j++, ABA_CD_4);
		        grAdd.setString(j++, ABA_NM_4);
		        grAdd.setString(j++, ACC_NO_4);
		        grAdd.setString(j++, AMOUNT_4);
		        grAdd.setString(j++, DED_AMT_4);

		        grAdd.setString(j++, PEN_GUBUN_CD_5);
		        grAdd.setString(j++, ABA_CD_5);
		        grAdd.setString(j++, ABA_NM_5);
		        grAdd.setString(j++, ACC_NO_5);
		        grAdd.setString(j++, AMOUNT_5);
		        grAdd.setString(j++, DED_AMT_5);

		        grAdd.setString(j++, PEN_GUBUN_CD_6);
		        grAdd.setString(j++, ABA_CD_6);
		        grAdd.setString(j++, ABA_NM_6);
		        grAdd.setString(j++, ACC_NO_6);
		        grAdd.setString(j++, AMOUNT_6);
		        grAdd.setString(j++, DED_AMT_6);

		        grAdd.setString(j++, PEN_GUBUN_CD_7);
		        grAdd.setString(j++, ABA_CD_7);
		        grAdd.setString(j++, ABA_NM_7);
		        grAdd.setString(j++, ACC_NO_7);
		        grAdd.setString(j++, AMOUNT_7);
		        grAdd.setString(j++, DED_AMT_7);

		        grAdd.setString(j++, PEN_GUBUN_CD_8);
		        grAdd.setString(j++, ABA_CD_8);
		        grAdd.setString(j++, ABA_NM_8);
		        grAdd.setString(j++, ACC_NO_8);
		        grAdd.setString(j++, AMOUNT_8);
		        grAdd.setString(j++, DED_AMT_8);

		        grAdd.setString(j++, PEN_GUBUN_CD_9);
		        grAdd.setString(j++, ABA_CD_9);
		        grAdd.setString(j++, ABA_NM_9);
		        grAdd.setString(j++, ACC_NO_9);
		        grAdd.setString(j++, AMOUNT_9);
		        grAdd.setString(j++, DED_AMT_9);

		        grAdd.setString(j++, PEN_GUBUN_CD_10);
		        grAdd.setString(j++, ABA_CD_10);
		        grAdd.setString(j++, ABA_NM_10);
		        grAdd.setString(j++, ACC_NO_10);
		        grAdd.setString(j++, AMOUNT_10);
		        grAdd.setString(j++, DED_AMT_10);

		        grAdd.setString(j++, PEN_GUBUN_CD_11);
		        grAdd.setString(j++, ABA_CD_11);
		        grAdd.setString(j++, ABA_NM_11);
		        grAdd.setString(j++, ACC_NO_11);
		        grAdd.setString(j++, AMOUNT_11);
		        grAdd.setString(j++, DED_AMT_11);

		        grAdd.setString(j++, PEN_GUBUN_CD_12);
		        grAdd.setString(j++, ABA_CD_12);
		        grAdd.setString(j++, ABA_NM_12);
		        grAdd.setString(j++, ACC_NO_12);
		        grAdd.setString(j++, AMOUNT_12);
		        grAdd.setString(j++, DED_AMT_12);

		        grAdd.setString(j++, PEN_GUBUN_CD_13);
		        grAdd.setString(j++, ABA_CD_13);
		        grAdd.setString(j++, ABA_NM_13);
		        grAdd.setString(j++, ACC_NO_13);
		        grAdd.setString(j++, AMOUNT_13);
		        grAdd.setString(j++, DED_AMT_13);

		        grAdd.setString(j++, PEN_GUBUN_CD_14);
		        grAdd.setString(j++, ABA_CD_14);
		        grAdd.setString(j++, ABA_NM_14);
		        grAdd.setString(j++, ACC_NO_14);
		        grAdd.setString(j++, AMOUNT_14);
		        grAdd.setString(j++, DED_AMT_14);

		        grAdd.setString(j++, PEN_GUBUN_CD_15);
		        grAdd.setString(j++, ABA_CD_15);
		        grAdd.setString(j++, ABA_NM_15);
		        grAdd.setString(j++, ACC_NO_15);
		        grAdd.setString(j++, AMOUNT_15);
		        grAdd.setString(j++, DED_AMT_15);
		        
		        
    		    //System.out.println("-----------grAdd---------" +grAdd.getString(
    		    
    		    
		        dsResult.addDataRow(grAdd);


		        
	        }

	        //dvoList에 출력양식에 맞게 넣는다.
	        int NUM = 3;
	        StringBuffer sbNPN_NO = null;
	        DynamicValueObject dvo = null;

	        String NAME = "";
	        int LN_CNT1 = 0;
	        int LN_CNT2 = 0;
	        int LN_CNT3 = 0;

	        String TMP_YN1 = "";
	        String TMP_YN2 = "";
	        String TMP_YN3 = "";
	        String TMP_YN4 = "";
	        String TMP_YN5 = "";

	        for(i=1; i<=dsResult.getDataRowCnt(); i++){
	        	
	        	sbNPN_NO = new StringBuffer();
	        	
	        	dvo = new DynamicValueObject();

	        	//이름사이에 공백이 있으면 않된다.(전산매체양식 참조)
	        	if(GauceUtils.nameValue(dsResult, i, "NAM_KOR") != null){
	        		
	        		NAME = GauceUtils.nameValue(dsResult, i, "NAM_KOR").replaceAll(" ","");
	        		
	        	}

	        	
    		    //System.out.println("-----------REL_CD1---------" +dsResult.value);	        	
	        	
	        	
        		/**
        		 * 갑근 주(현)근무처 레코드
        		 */
	        	if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("C".toUpperCase())){
	        		LN_CNT1 = LN_CNT1 + 1;
	        		LN_CNT2 = 0;
	        		LN_CNT3 = 0;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CNT"),"0",2));//종(전)근무처 수
	        		sbNPN_NO.append("1");//거주자구분코드
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",2));//거주지국코드
              	    sbNPN_NO.append("2");//외국인단일세율적용
	        		sbNPN_NO.append(JSPUtil.byteRpad(NAME," ",30));//성명
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO").substring(6,7)) < 5 ){//내외국인 구분코드
	        	    	sbNPN_NO.append("1");
               		}else{
               			sbNPN_NO.append("9");
        		    }
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//주민등록번호
	        		
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO").substring(6,7)) < 5 ){
		        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",2)); //2010, 국적코드
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteRpad("CN"," ",2));//2010, 국적코드 
	        		}	        		
		    	    //System.out.println("-----------GauceUtils.nameValue---------"+GauceUtils.nameValue(dsResult, i, "HOL_YN"));	
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HOL_YN")," ",1));//2010, 세대주여부

	        		if(GauceUtils.nameValue(dsResult, i, "RET_YMD").equals("20141231") == true){
	        			sbNPN_NO.append("1"); //계속근로
	        		}
	        		else{
	        			sbNPN_NO.append("2"); //중도퇴직
	        		}
	        		
	        		//근무처별 소득명세- 주(현)근무처
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10)); //2010, 주현근무처-사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad("현대아산주식회사"," ",40)); //2010,주현근무처-근무처명
	        		
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HIR_YMD"),"0",8));//근무기간 시작연월일
	        		//sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5512111331019") == true){
	        			sbNPN_NO.append("20141231"); //근무기간 종료연월일
	        		}
	        		else{
		        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		}	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 종료연월일

	        		//근무처별 소득명세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTS"),"0",11));//급여총액
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//상여총액
	        		
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "OUTT_AMTS"),"0",11));//인정상여   	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//주식매수선택권행사이익

	        		/*
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){
	        			sbNPN_NO.append("00002306524"); //우리사주조합인출금
	        		}
	        		else{
		        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		}	
	        		*/    	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//임원 퇴직소득금액 한도초과액	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",22));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTT"),"0",11));//계

	        		//비과세소득
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세학자금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보수위원수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//경호·승선수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//유아·초중등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고등교육법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연구기관 등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//기업부설연구소
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//H14-보육교사 근무환경개선비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//H15-사립유치원 수석교사 교사의 인건비	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//취재수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//벽지수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//재해관련급여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//정부공공기관  지방이전기관 종사자 이주수당        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국정부등근무자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국주둔군인등
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SEA_FREE"),"0",10));//국외근로100만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로100만원        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로300만원 
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//야간근로수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//출산보육수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//근로장학금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주식매수선택권
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국인기술자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금50%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금75%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//장기미취업자중소기업 취업
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//해저광물자원개발
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//전공의 수련 보조수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//중소기업취업 청년 소득세 감면    		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약상 교직자 감면 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SEA_FREE"),"0",10));//비과세 계
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //감면소득계

	        		//정산명세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TAX_INCOME"),"0",11));//총급여     		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MGR_AMT"),"0",10));//근로소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MNI_AMT"),"0",11));//근로소득금액

	        		//기본공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "BADD_AMT"),"0",8));//본인공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SPSB_AMT"),"0",8));//배우자공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DFM_CNT"),"0",2));//부양가족공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GDED_AMT"),"0",8));//부양가족공제금액

	        		//추가공제
	         		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOL_CNT"),"0",2));//경로우대공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOL_AMT"),"0",8));//경로우대공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TRB_CNT"),"0",2));//장애인공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TBL_DED"),"0",8));//장애인공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "WDD_AMT"),"0",8));//부녀자공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ONE_AMT"),"0",10));//한부모 가족 공제금액	        		

	        		
	        		//연금보험료공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "NPEN_DED"),"0",10));//국민연금보험료공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(공무원)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(군인)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(교직원)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(우체국)

	        		//특별공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HINU_AMT"),"0",10)); //건강보험료
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HINS_AMT"),"0",10)); //고용보험료
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH1_AMT"),"0",8));//주택임차차입금원리금상환액_대출기관	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH2_AMT"),"0",8));//주택임차차입금원리금상환액_거주자
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH3_AMT"),"0",8)); //주택자금_월세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH4_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년미만	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7612201106214") == true){	     
	        			sbNPN_NO.append("01150760"); //(2012년 이후 차입분)고정금리비거치상환 대출      			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH5_AMT"),"0",8));	//주택자금_장기주택저당차입금이자상환액_15년~29년	     		
	        		}	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH5_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년~29년		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH6_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_30년이상	 	
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7612201106214") == true){	     
	        			sbNPN_NO.append("01248553"); //(2012년 이후 차입분)고정금리비거치상환 대출      			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH7_AMT"),"0",8));	//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)고정금리비거치상환 대출      		
	        		}		        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH7_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)고정금리비거치상환 대출 		      
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH8_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)기타 대출	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DON_FWD"),"0",11));//기부금이월분		        		
	        		
	        		/*
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6811231055111") == true){	     
	        			sbNPN_NO.append("03535380"); //주택자금_장기주택저당차입금이자상환액_15년~29년	        		
	        		}else{
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG2_DED"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년~29년
	        			
	        		}	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("7412201347528") == true){	     
	        			sbNPN_NO.append("02011308"); //주택자금_장기주택저당차입금이자상환액_30년이상
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6909141011113") == true){	    	        			
	        			sbNPN_NO.append("02278368"); //주택자금_장기주택저당차입금이자상환액_30년이상	        			
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG3_DED"),"0",8));//주택자금_장기주택저당차입금이자상환액_30년이상	        		
	        		}	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("7412201347528") == true){	     
	        			sbNPN_NO.append("06655992"); //(2012년 이후 차입분)고정금리비거치상환 대출
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6909141011113") == true){	    	        			
	        			sbNPN_NO.append("01617866"); //(2012년 이후 차입분)고정금리비거치상환 대출 	      
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6811231055111") == true){	    	        			
	        			sbNPN_NO.append("00372857"); //(2012년 이후 차입분)고정금리비거치상환 대출	        			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG4_DED"),"0",8));	//(2012년 이후 차입분)고정금리비거치상환 대출        		
	        		}
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG5_DED"),"0",8));//(2012년 이후 차입분)기타 대출
	        		*/
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DON_FWD"),"0",11));  //기부금 이월분        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",20));//공란	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "VEN_DED"),"0",11));//특별소득공제계     		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INDED_TOT"),"0",11));//차감소득금액	        		
	        		
	        		//그 밖의 소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PER_DED"),"0",8));//개인연금저축소득공제	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소기업공제부금소득공제	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE1_DED"),"0",10)); //주택마련저축소득공제_청약저축
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE2_DED"),"0",10)); //주택마련저축소득공제_주택청약종합저축
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE3_DED"),"0",10)); //주택마련저축소득공제_근로자주택마련저축	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//투자좋합출자등소득공제	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_DED"),"0",8));//신용카드등소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAJU_AMT"),"0",10));//우리사주조합 출연금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합 기부금    		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고용유지중소기업근로자소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//목돈안드는전세이자상환액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LSS_AMT"),"0",10));//장기집합투자증권저축        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ETC_TOT"),"0",11));//그 밖의 소득공제계	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//소득공제종합한도 초과액  		  		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TTAX_STD"),"0",11));//종합소득 과세표준
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TAX_AMT"),"0",10));//산출세액	        		
	        		
	        		//세액감면
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소득세법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조특법(-1 제외)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조특법 제30조	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//세액감면계	
	        		
	        		//세액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HGR_DED"),"0",10));//근로소득세액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AGE_AMT"),"0",10));//자녀세액공제        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_과학기술인공제_공제대상금액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_과학기술인공제_세액공제액  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_근로자퇴직급여보장법에따른 퇴직급여_공제대상금액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_근로자퇴직급여보장법에따른 퇴직급여_세액공제액
	        		  		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ANN_AMT"),"0",10));//연금계좌_연금저축_공제대상금액   
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ANN_DED"),"0",10));//연금계좌_연금저축_세액공제액    		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LIN_AMT"),"0",10));  //특별세액공제_보장성보험료_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MIN_DED"),"0",10));  //특별세액공제_보장성보험료_세액공제액
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MMA_AMT"),"0",10));//특별세액공제_의료비_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MMA_DED"),"0",10));//특별세액공제_의료비_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT"),"0",10));//특별세액공제_교육비_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_DED"),"0",10));//특별세액공제_교육비_세액공제액	
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5206111068514") == true){	     
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701071553212") == true){	    	        			
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액        
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6904301380532") == true){	    	        			
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액            			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_AMT"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_공제대상금액       		
	        		}	        		
	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_AMT"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_DED"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV2_AMT"),"0",11));//특별세액공제_기부금_정치자금_10만원초과_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV2_DED"),"0",10));//특별세액공제_기부금_정치자금_10만원초과_세액공제액	
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC1_AMT"),"0",11));//특별세액공제_기부금_법정기부금_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC1_DED"),"0",10));//특별세액공제_기부금_법정기부금_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC23_AMT"),"0",11));//특별세액공제_기부금_지정기부금_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC23_DED"),"0",10));//특별세액공제_기부금_지정기부금_세액공제액      		

	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "NSE_TOT"),"0",10));//특별세액공제계
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "STA_TOT"),"0",10));//표준세액공제
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//납세조합공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주택차입금   		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국납부        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MRENT_DED"),"0",10));//월세 세액공제	        
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TDED_TOT"),"0",10));//세액공제계	        		

	        		//결정세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DGG_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DJM_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DBW_TAX"),"0",10));//농특세

	        		//기납부세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INCM_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CITI_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//농특세	        		
	        		
	        		//납부특례세액
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//농특세	 	        		
	        		
	        		
	        		//차감징수세액
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_INTX")) < 0 ) {//소득세
	        		   sbNPN_NO.append("1");
          			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_INTX"))	* -1),"0",10));
	        		}
	        		else {
	        		   sbNPN_NO.append("0");
	        		   sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_INTX"),"0",10));
	             	}

	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_CTTX")) < 0 ) {//지방소득세
		        	   sbNPN_NO.append("1");
	      			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_CTTX"))	* -1),"0",10));
	        	    }
	        		else {
	        	    	sbNPN_NO.append("0");
	        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_CTTX"),"0",10));
	        		}


	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_DFTX")) < 0 ) {//농특세
		        		sbNPN_NO.append("1");
		      			sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_DFTX")) * -1),"0",10));
	        		}
	        		else {
	        			sbNPN_NO.append("0");
	        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_DFTX"),"0",10));
	        		}

	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",14));	        		
	        		
	        		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	        		
	        		
        		/**
        		 * 갑근 종(전)소득 발생처 레코드
        		 */
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("D".toUpperCase())){
	        		LN_CNT2 = LN_CNT2 + 1;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));//레코드 구분
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));//자료구분+세무서
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));//일련번호

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));//사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",50));//공란

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//소득자주민등록번호

	        		//종(전)근무처	        		
	        		sbNPN_NO.append("2");//2010,납세조합구분, 재경부 문의 확인
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "JAS_NM")," ",40));//법인명(상호)
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "JAO_NO")," ",10));//사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HIR_YMD"),"0",8));//근무기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 종료연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTS"),"0",11));//급여총액
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7606271697813") == true){	     
	        			sbNPN_NO.append("00000750000"); //상여총액    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8104272006217") == true){	    	        			
	        			sbNPN_NO.append("00001000000"); //상여총액        
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7507091227217") == true){	    	        			
	        			sbNPN_NO.append("00001351900"); //상여총액         
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	    	        			
	        			sbNPN_NO.append("00043392600"); //상여총액   	        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAC_AMT"),"0",11));//상여총액		
	        		}		        		
	        		  		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//인정상여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//주식매수선택권행사이익
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	     
	        			sbNPN_NO.append("00002306524"); //우리사주조합인출금        		
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		}	  	        		

	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//임원 퇴직소득금액 한도초과액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",22));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTT"),"0",11));//계

	        		//종전근무지 비과세소득
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세학자금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//무보수위원수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//경호·승선수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//유아·초중등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고등교육법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연구기관 등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//기업부설연구소
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보육교사  근무환경개선비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//사립유치원수석교사교사의 인건비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//취재수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//벽지수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//재해관련급여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//정부공공기관지방이전기관 종사자 이주수당        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국정부등근무자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국주둔군인등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로100만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로300만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로

	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAG_AMT"),"0",10));//야간근로수당 비과세 뭐는 하나 들어가야해서
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//야간근로수당 비과세 뭐는 하나 들어가야해서
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//출산보육수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//근로장학금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주식매수선택권
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국인기술자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금50%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금75%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//장기미취업자중소기업 취업
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//해저광물자원개발
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//전공의 수련 보조수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//중소기업취업 청년 소득세 감면
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약상 교직자 감면      
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAG_AMT"),"0",10));//비과세 계
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세 계
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 감면소득계

	        		//기납부세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INCM_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CITI_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//종근무지 기납부 농특세 (자료 확인요망)
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT2),"0",2));//종(전)근무처일련번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",891));


	        		/**
	        		 * 소득공제명세 레코드
	        		 */
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("E".toUpperCase())){
	        		/*
	    		    System.out.println("-----------REL_CD1---------" +GauceUtils.nameValue(dsResult, i, "REL_CD1"));		        		
	    		    System.out.println("-----------NAM_KOR1---------" +GauceUtils.nameValue(dsResult, i, "NAM_KOR1"));	        		
	    		    System.out.println("-----------CET_NO1---------" +GauceUtils.nameValue(dsResult, i, "CET_NO1"));	    		    
	    		    System.out.println("-----------BAS_MAN1---------" +GauceUtils.nameValue(dsResult, i, "BAS_MAN1"));	        		
	    		    System.out.println("-----------TRB_MAN1---------" +GauceUtils.nameValue(dsResult, i, "TRB_MAN1"));	   	    		    
	        		 */
	    		    

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO1") == null || GauceUtils.nameValue(dsResult, i, "CET_NO1").trim().equals("")){
	        			TMP_YN1 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO1").substring(6,7)) < 5 ){
	        		//	TMP_YN1 = "1";
	        		}else{
	        			TMP_YN1 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2") == null || GauceUtils.nameValue(dsResult, i, "CET_NO2").trim().equals("")){
	        			TMP_YN2 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO2").substring(6,7)) < 5 ){
	        		//	TMP_YN2 = "1";
	        		}else{
	        			TMP_YN2 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO3") == null || GauceUtils.nameValue(dsResult, i, "CET_NO3").trim().equals("")){
	        			TMP_YN3 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO3").substring(6,7)) < 5 ){
	        		//	TMP_YN3 = "1";
	        		}else{
	        			TMP_YN3 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO4") == null || GauceUtils.nameValue(dsResult, i, "CET_NO4").trim().equals("")){
	        			TMP_YN4 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO4").substring(6,7)) < 5 ){
	        		//	TMP_YN4 = "1";
	        		}else{
	        			TMP_YN4 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO5") == null || GauceUtils.nameValue(dsResult, i, "CET_NO5").trim().equals("")){
	        			TMP_YN5 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO5").substring(6,7)) < 5 ){
	        		//	TMP_YN5 = "1";
	        		}else{
	        			TMP_YN5 = "1";
	        		}

	    		    /*	        		
	        		//if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("8702096780193") == true){	     
	        		//	TMP_YN1 = "9";
	        		//}      		
	        		//System.out.println("NPN_NO : "+sbNPN_NO.toString());		
	        		*/
	        		
	        		TMP_YN1 = "1";
	        		TMP_YN2 = "1";
	        		TMP_YN3 = "1";
	        		TMP_YN4 = "1";
	        		TMP_YN5 = "1";
	        		
	        		LN_CNT3 = LN_CNT3 + 1;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));//레코드 구분
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));//자료구분+세무서
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));//일련번호

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));//사업자등록번호

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//소득자 주민등록번호

	        		//소득공제명세1의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD1")," ",1));//관계1
	        		sbNPN_NO.append(TMP_YN1);//내외국인구분코드1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR1")," ",20));//성명1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO1")," ",13));//주민등록번호1		
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN1")," ",1));//기본공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN1")," ",1));//장애인공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN1")," ",1));//부녀자공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN1")," ",1));//경로우대공제1
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN1")," ",1));//한부모1              	

	        		
	        		//소득공제명세1의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS1"),"0",10));//보험료1_건강고용보험
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS1"),"0",10));//보험료1_보장성	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS1"),"0",10));//의료비1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS1"),"0",10));//교육비1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS1"),"0",10));//신용카드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS1"),"0",10));//직불선불카드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS1"),"0",10));//현금영수증1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS1"),"0",10));//전통시장사용액1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS1"),"0",10));//대중교통이용액1	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS1"),"0",13));//기부금1

	        		//소득공제명세1의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT1"),"0",10));//보험료1 외_건강고용보험
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT1"),"0",10));//보험료1 외_보장성	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT1"),"0",10));//의료비1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT1"),"0",10));//교육비1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT1"),"0",10));//신용카드1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT1"),"0",10));//직불선불카드1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT1"),"0",10));//전통시장 사용액1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT1"),"0",10));//대중교통이용액1	 외	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT1"),"0",13));//기부금1 외

	        		//소득공제명세2의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD2")," ",1));//관계2
	        		sbNPN_NO.append(TMP_YN2);//내외국인구분코드2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR2")," ",20));//성명2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO2")," ",13));//주민등록번호2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN2")," ",1));//
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN2")," ",1));//한부모2     
                	
	        		//소득공제명세2의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS2"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS2"),"0",10));//신용카드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS2"),"0",10));//직불선불카드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS2"),"0",10));//현금영수증2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS2"),"0",10));//전통시장사용액2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS2"),"0",10));//대중교통이용액2 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS2"),"0",13));//기부금2


	        		//소득공제명세2의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT2"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT2"),"0",10));//전통시장 사용액2 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT2"),"0",10));//대중교통이용액2	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT2"),"0",13));

	        		//소득공제명세3의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD3")," ",1));
	        		sbNPN_NO.append(TMP_YN3);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR3")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO3")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN3")," ",1));
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN3")," ",1));//한부모3   
                	
	        		//소득공제명세3의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS3"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS3"),"0",10));//전통시장사용액3	  
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS3"),"0",10));//대중교통이용액3		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS3"),"0",13));

	        		//소득공제명세3의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT3"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT3"),"0",10));//전통시장 사용액3 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT3"),"0",10));//대중교통이용액3	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT3"),"0",13));

	        		//소득공제명세4의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD4")," ",1));
	        		sbNPN_NO.append(TMP_YN4);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR4")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO4")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN4")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN4")," ",1));//장애인공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN4")," ",1));//부녀자공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN4")," ",1));//경로우대공제4
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN4")," ",1));//한부모4   
                	
	        		//소득공제명세4의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS4"),"0",10));//보험료4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS4"),"0",10));//보험료4	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS4"),"0",10));//의료비4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS4"),"0",10));//교육비4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS4"),"0",10));//신용카드4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS4"),"0",10));//직불선불카드4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS4"),"0",10));//현금영수증4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS4"),"0",10));//전통시장사용액4	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS4"),"0",10));//대중교통이용액4	  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS4"),"0",13));//기부금4

	        		//소득공제명세4의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT4"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT4"),"0",10));//전통시장 사용액4 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT4"),"0",10));//대중교통이용액4	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT4"),"0",13));//기부금4외

       		
	        		
	        		//소득공제명세5의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD5")," ",1));
	        		sbNPN_NO.append(TMP_YN5);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR5")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO5")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN5")," ",1));
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN5")," ",1));//한부모5   
	 
	        		//소득공제명세5의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS5"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS5"),"0",10));//전통시장사용액5
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS5"),"0",10));//대중교통이용액5  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS5"),"0",13));//기부금5

	        		//소득공제명세5의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT5"),"0",10));        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT5"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT5"),"0",10));//전통시장 사용액5 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT5"),"0",10));//대중교통이용액5	 외	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT5"),"0",13));//기부금5외
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT3),"0",2));
	        		
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",303));
	        		//System.out.println("NPN_NO : "+sbNPN_NO.toString());	
	        		
	        		
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("F".toUpperCase())){

	        		
	        		
	        		
	        		
	        		
	        		
	        		

	        		
	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_1")," ",2));//소득공제구분1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_1")," ",3));//금융기관코드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_1")," ",30));//금융기관상호1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_1")," ",20));//계좌번호(또는 증권번호)	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_1"),"0",10));//납입금액1
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6510151683513") == true){	     //권기환
	        			sbNPN_NO.append("0000336000"); //납입금액1    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6511161785941") == true){	  //최규훈  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액1   	        	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5811151659025") == true){	  //정종국  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액1 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7006171037719") == true){	  //소병진  	        			
	        			sbNPN_NO.append("0000432000"); //납입금액1 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7907191095519") == true){	   //김상수 	        			
	        			sbNPN_NO.append("0000379200"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6711291790211") == true){	   //이종훈	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1         		
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6708301822513") == true){	    //정성학	        			
	        			sbNPN_NO.append("0000144000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7110041836316") == true){	    //이만재	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	    //이영하 	        			
	        			sbNPN_NO.append("0000096000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8209072177411") == true){	   //이래경 	        			
	        			sbNPN_NO.append("0000100800"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7211291535932") == true){	  //이석재  	        			
	        			sbNPN_NO.append("0000396000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7409041810118") == true){	  //박제성 	        			
	        			sbNPN_NO.append("0000364800"); //납입금액1   		        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	  //김종학   	        			
	        			sbNPN_NO.append("0000360000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	  //김창기 	        			
	        			sbNPN_NO.append("0000450000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	   //김안수 	        			
	        			sbNPN_NO.append("0000288000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	  //김태현  	        			
	        			sbNPN_NO.append("0000072000"); //납입금액1   	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	  //김영수  	        			
	        			sbNPN_NO.append("0000288000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	   //권헌영 	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1   	        			        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_1"),"0",10));//소득, 세액공제금액1
	        		}			        		
	        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_2")," ",2));//소득공제구분2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_2")," ",3));//금융기관코드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_2")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_2")," ",20));//계좌번호(또는 증권번호)2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_2"),"0",10));//납입금액2	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6510151683513") == true){	    	//권기환 
	        			sbNPN_NO.append("0000144000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6511161785941") == true){	  //최규훈  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액2   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5811151659025") == true){	  //정종국  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액2	   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7006171037719") == true){	  //소병진  	        			
	        			sbNPN_NO.append("0000048000"); //납입금액2	     	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7907191095519") == true){	 //김상수   	        			
	        			sbNPN_NO.append("0000100800"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6711291790211") == true){	  //이종훈  	        			
	        			sbNPN_NO.append("0000364800"); //납입금액2         		
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6708301822513") == true){	  //정성학	   	      	
	        			sbNPN_NO.append("0000336000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7110041836316") == true){	  //이만재  	        			
	        			sbNPN_NO.append("0000364800"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	  //이영하  	        			
	        			sbNPN_NO.append("0000384000"); //납입금액2  	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8209072177411") == true){	  //이래경 	        			
	        			sbNPN_NO.append("0000379200"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7409041810118") == true){	 //박제성    	        			
	        			sbNPN_NO.append("0000115200"); //납입금액2  		        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	 //김종학   	        			
	        			sbNPN_NO.append("0000120000"); //납입금액2 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	 //김창기   	        			
	        			sbNPN_NO.append("0000030000"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	 //김안수   	        			
	        			sbNPN_NO.append("0000144000"); //납입금액2 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	 //김태현   	        			
	        			sbNPN_NO.append("0000012000"); //납입금액2 		        	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	//김영수    	        			
	        			sbNPN_NO.append("0000144000"); //납입금액2  
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	 //권헌영   	        			
	        			sbNPN_NO.append("0000072000"); //납입금액2   	        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_2"),"0",10));
	        		}			        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_3")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_3")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_3")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_3")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_3"),"0",10));//납입금액3
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	 //김영수
	        			sbNPN_NO.append("0000048000"); //납입금액3   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	  //김종학   	        			
	        			sbNPN_NO.append("0000000000"); //납입금액3 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	  //김창기  	        			
	        			sbNPN_NO.append("0000000000"); //납입금액3
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	   //김안수 	        			
	        			sbNPN_NO.append("0000048000"); //납입금액3 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	   //김태현 	        			
	        			sbNPN_NO.append("0000396000"); //납입금액3			        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	  //권헌영   	        			
	        			sbNPN_NO.append("0000144000"); //납입금액3 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7211291535932") == true){	 //이석재   	        			
	        			sbNPN_NO.append("0000084000"); //납입금액3	        				        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_3"),"0",10));
	        		}			        		
	        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_4")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_4")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_4")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_4")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_4"),"0",10));//납입금액3	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	 //김영수
	        			sbNPN_NO.append("0000000000"); //납입금액4  
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	    //권헌영	        			
	        			sbNPN_NO.append("0000148800"); //납입금액4          			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_4"),"0",10));
	        		}			


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_5")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_5")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_5")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_5")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_5"),"0",10));//납입금액5	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	 //권헌영
	        			sbNPN_NO.append("0000000000"); //납입금액5  
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_5"),"0",10));
	        		}		



	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_6")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_6")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_6")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_6")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_6"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_6"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_7")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_7")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_7")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_7")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_7"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_7"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_8")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_8")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_8")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_8")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_8"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_8"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_9")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_9")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_9")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_9")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_9"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_9"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_10")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_10")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_10")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_10")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_10"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_10"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_11")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_11")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_11")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_11")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_11"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_11"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_12")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_12")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_12")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_12")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_12"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_12"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_13")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_13")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_13")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_13")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_13"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_13"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_14")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_14")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_14")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_14")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_14"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_14"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_15")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_15")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_15")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_15")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_15"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_15"),"0",10));

	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",360));
	        	}

	        	//System.out.println("NUM : "+Integer.toString(NUM++));
	        	//System.out.println("NPN_NO : "+sbNPN_NO.toString());

		        dvo.set("NUM", Integer.toString(NUM++));
		        dvo.set("NPN_NO", sbNPN_NO.toString());
		        dvoList.add(dvo);
	        }

        }

        return dvoList;
    }
	
	 
		/**
	     * 연말정산
	     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
	     * @param p_box
	     * @return
	     * @throws CException
	     */
	 public DynamicValueObject YACA001_SHR_FILE_01_142(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		YACA001DAO dao = new YACA001DAO("default");

		DynamicValueObject dvoList = dao.YACA001_SHR_FILE_14_AB_142(p_box); // A, B만 만들고 C,D,E,F,G는 밑에서 부터 다시 만든다.

		//커넥션이 끊겨서 다시 연결해준다. 문의 해야함.
		dao.close();
			
		dao = new YACA001DAO("default");

		GauceDataSet dsYACA001_SHR_14 = dao.YACA001_SHR_FILE_14_ETC_142(p_box);		

	    //System.out.println("-----------111111111111111111---------");		
		
		GauceDataSet dsResult = new GauceDataSet();
		
		dsResult.addDataColumn(new GauceDataColumn("REC_TAG", GauceDataColumn.TB_STRING ));

		dsResult.addDataColumn(new GauceDataColumn("TAX_CD", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("COMP_CD", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CNT", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ZIP_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JUSO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JAS_NM", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JAO_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("SALT_AMTS", GauceDataColumn.TB_DECIMAL, 10, 0));

		//dsResult.addDataColumn(new GauceDataColumn("SALT_AMTB", GauceDataColumn.TB_DECIMAL, 10, 0));
		//dsResult.addDataColumn(new GauceDataColumn("JAI_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("SALT_AMTT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("FREE_INCOME", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TAX_INCOME", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("OUTT_AMTS", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MGR_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MNI_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("BADD_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SOU_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("SPSB_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DFM_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GDED_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOL_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOL_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TRB_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TBL_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("WDD_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("ONE_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("HINU_AMT", GauceDataColumn.TB_DECIMAL, 10, 0)); 
		dsResult.addDataColumn(new GauceDataColumn("HINS_AMT", GauceDataColumn.TB_DECIMAL, 10, 0)); 

		dsResult.addDataColumn(new GauceDataColumn("LH1_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH2_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH3_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH4_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH5_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH6_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH7_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH8_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DON_FWD",GauceDataColumn.TB_DECIMAL, 10, 0));	
		dsResult.addDataColumn(new GauceDataColumn("PER_DED",GauceDataColumn.TB_DECIMAL, 10, 0));			
		

		
		dsResult.addDataColumn(new GauceDataColumn("CPC_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("NSE_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INDED_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));

		dsResult.addDataColumn(new GauceDataColumn("CARD_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SAVE_DED",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SAVE1_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("SAVE2_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("SAVE3_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		
		dsResult.addDataColumn(new GauceDataColumn("SAJU_AMT",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("LSS_AMT",GauceDataColumn.TB_DECIMAL, 10, 0)); //		
		dsResult.addDataColumn(new GauceDataColumn("ETC_TOT",GauceDataColumn.TB_DECIMAL, 11, 0)); //	

		dsResult.addDataColumn(new GauceDataColumn("VEN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TTAX_STD", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TAX_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HGR_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("CHI_CNT", GauceDataColumn.TB_DECIMAL, 2, 0));			
		dsResult.addDataColumn(new GauceDataColumn("AGE_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));	
		dsResult.addDataColumn(new GauceDataColumn("CHI_RCH", GauceDataColumn.TB_DECIMAL, 2, 0));		
		dsResult.addDataColumn(new GauceDataColumn("AGE_RCH", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CHI_INP", GauceDataColumn.TB_DECIMAL, 2, 0));		
		dsResult.addDataColumn(new GauceDataColumn("AGE_INP", GauceDataColumn.TB_DECIMAL, 10, 0));			
		
		dsResult.addDataColumn(new GauceDataColumn("ANN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("ANN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LIN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MIN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("MMA_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MMA_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("EDU_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("GOV1_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV1_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV2_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV2_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("LC1_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("LC1_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LC23_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("LC23_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("MRENT_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		
		
		dsResult.addDataColumn(new GauceDataColumn("TDED_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DGG_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DBW_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DJM_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAL_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAC_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INCM_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CITI_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HIR_YMD", GauceDataColumn.TB_DECIMAL, 8, 0));
		dsResult.addDataColumn(new GauceDataColumn("RET_YMD", GauceDataColumn.TB_DECIMAL, 8, 0));
		dsResult.addDataColumn(new GauceDataColumn("STA_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("NPEN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));

		dsResult.addDataColumn(new GauceDataColumn("SEA_FREE", GauceDataColumn.TB_DECIMAL, 10, 0));
		

		
		dsResult.addDataColumn(new GauceDataColumn("GOV_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("OTX_DED", GauceDataColumn.TB_DECIMAL, 10, 0));

		
		dsResult.addDataColumn(new GauceDataColumn("CASH_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("REA_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("REB_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("REC_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));		
//		dsResult.addDataColumn(new GauceDataColumn("DRE_INTX", GauceDataColumn.TB_DECIMAL, 10, 0));
//		dsResult.addDataColumn(new GauceDataColumn("DRE_CTTX", GauceDataColumn.TB_DECIMAL, 10, 0));
//		dsResult.addDataColumn(new GauceDataColumn("DRE_DFTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HOL_YN", GauceDataColumn.TB_DECIMAL, 1, 0));
		
		
		
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN1", GauceDataColumn.TB_STRING ));		
		dsResult.addDataColumn(new GauceDataColumn("INP_MAN1", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("RCH_MAN1", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("INP_MAN2", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("RCH_MAN2", GauceDataColumn.TB_STRING ));				
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN3", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("INP_MAN3", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("RCH_MAN3", GauceDataColumn.TB_STRING ));				
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));					
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		

		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN4", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("INP_MAN4", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("RCH_MAN4", GauceDataColumn.TB_STRING ));				
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("INP_MAN5", GauceDataColumn.TB_STRING ));	
		dsResult.addDataColumn(new GauceDataColumn("RCH_MAN5", GauceDataColumn.TB_STRING ));				
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));

		//dsResult.addDataColumn(new GauceDataColumn("BASE_VAL1", GauceDataColumn.TB_STRING ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_1", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_1", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_2", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_2", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_3", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_3", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_4", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_4", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_5", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_5", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_6", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_6", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_7", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_7", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_8", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_8", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_9", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_9", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_10", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_10", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_11", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_11", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_12", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_12", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_13", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_13", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_14", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_14", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_15", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_15", GauceDataColumn.TB_DECIMAL ));

			
		
     if(dsYACA001_SHR_14.getDataRowCnt() > 0){

     	int i=0;
     	int j=0;

			GauceDataRow grAdd  = null; // 추가될 row

			String YAC_SEL_KEY = "";                                                      
			String YAC_REC_TAG = "";                                                     
			String YAC_TAX_CD  = "";                                                      
			String YAC_COMP_CD = "";                                                    
			String YAC_CNT     = "";                                                         
			String YAC_NAM_KOR = "";                                                    
			String YAC_CET_NO  = "";                                                      
			String YAC_ZIP_NO  = "";                                                       
			String YAC_JUSO    = "";                                                        
			String YAC_JAS_NM  = "";                                                      
			String YAC_JAO_NO  = "";                                                      
			String YAC_SALT_AMTS  = "";                                                
			String YAC_SALT_AMTT  = "";                                                 
			String YAC_FREE_INCOME  = "";                                             
			String YAC_TAX_INCOME = "";                                               
			String YAC_OUTT_AMTS = "";	                                             
			String YAC_MGR_AMT = "";                                                    
			String YAC_MNI_AMT = "";                                                     
			String YAC_BADD_AMT   = "";                                                
			String YAC_SOU_CNT = "";                                                    
			String YAC_SPSB_AMT   = "";                                                 
			String YAC_DFM_CNT = "";                                                    
			String YAC_GDED_AMT   = "";                                                
			String YAC_GOL_CNT = "";                                                     
			String YAC_GOL_AMT = "";                                                    
                                      
			String YAC_TRB_CNT = "";                                                     
			String YAC_TBL_DED = "";                                                      
			String YAC_WDD_AMT = "";                                                                                                       
			String YAC_ONE_AMT = "";	   
			
                                               
			String YAC_HINU_AMT = "";                                 
			String YAC_HINS_AMT = "";      
                                             
			String YAC_LH1_AMT = "";                                                   
			String YAC_LH2_AMT = "";                                                 
			String YAC_LH3_AMT = "";                                 
			String YAC_LH4_AMT = "";                                                
			String YAC_LH5_AMT = "";                                                
			String YAC_LH6_AMT = "";                                                
			String YAC_LH7_AMT = "";                                                
			String YAC_LH8_AMT = "";	
			String YAC_DON_FWD = "";	
			String YAC_PER_DED = "";			
                                           
			String YAC_CPC_DED = "";                                                     
			String YAC_NSE_TOT = "";                                                     
			String YAC_INDED_TOT  = "";                                                 
			String YAC_CARD_DED   = "";                                                 
			String YAC_SAVE_DED = "";                                                   
			String YAC_SAVE1_DED = "";                                    
			String YAC_SAVE2_DED = "";                                     
			String YAC_SAVE3_DED = "";     
			String YAC_SAJU_AMT = "";                                      
			String YAC_LSS_AMT = "";  			
			String YAC_ETC_TOT = ""; 	
			String YAC_VEN_DED = "";                                                     
			String YAC_TTAX_STD   = "";                                                  
			String YAC_TAX_AMT = "";                                                     
			String YAC_HGR_DED = "";  
			
			String YAC_CHI_CNT = "";  	
			String YAC_AGE_AMT = ""; 
			String YAC_CHI_RCH = ""; 
			String YAC_AGE_RCH = "";  	
			String YAC_CHI_INP = ""; 
			String YAC_AGE_INP = ""; 			
			
			String YAC_ANN_AMT   = "";                                                  
			String YAC_ANN_DED = "";                                                     
			String YAC_LIN_AMT = "";  
			String YAC_MIN_DED = "";  		
                    
			String YAC_MMA_AMT = "";	                                             
			String YAC_MMA_DED = "";                                                    
			String YAC_EDU_AMT = "";	                                             
			String YAC_EDU_DED = "";     
				
			String YAC_GOV1_AMT   = "";                                                  
			String YAC_GOV1_DED = "";                                                     
			String YAC_GOV2_AMT = "";  
			String YAC_GOV2_DED = "";  		
                    
			String YAC_LC1_AMT = "";	                                             
			String YAC_LC1_DED = "";                                                    
			String YAC_LC23_AMT = "";	                                             
			String YAC_LC23_DED = "";    	
			
			String YAC_MRENT_DED = ""; 			
			
			String YAC_TDED_TOT   = "";                                                 
			String YAC_DGG_TAX = "";                                                    
			String YAC_DBW_TAX = "";                                                    
			String YAC_DJM_TAX = "";                                                     
			String YAC_JAL_AMT = "";                                                      
			String YAC_JAC_AMT = "";                                                     
			String YAC_JAN_AMT = "";                                                     
			String YAC_INCM_TAX   = "";                                                 
			String YAC_CITI_TAX   = "";                                                   
			String EMS_HIR_YMD = "";                                                     
			String EMS_RET_YMD = "";                                                     
			String YAC_STA_TOT = "";                                                     
			String YAC_NPEN_DED   = "";                                                 
                                                
			String YAC_SEA_FREE   = "";                                                  
			String YAC_GOV_DED = "";                                                    
			String YAC_OTX_DED = "";                                                     
			String YAC_CASH_AMT= "";     
    		String YAC_REA_TAX = "";                                                    
			String YAC_REB_TAX = "";                                                   
			String YAC_REC_TAX = "";			
    		//String YAC_DRE_INTX = "";                                                    
			//String YAC_DRE_CTTX = "";                                                   
			//String YAC_DRE_DFTX = "";                                                   
			String YAC_HOL_YN = "";                           
			
			String REL_CD1= "";  
			String NAM_KOR1 = "";        
			String CET_NO1 = ""; 
			String BAS_MAN1 = "";        
			String TRB_MAN1 = "";        
			String WCT_MAN1 = "";        
			String GOL_MAN1 = "";        
			String ONE_MAN1 = "";        
			String INP_MAN1 = "";  
			String RCH_MAN1 = "";  			
			String INV_NTS1 = "";     
			String INV2_NTS1 = ""; 			
			String MED_NTS1 = "";        
			String EDU_NTS1 = "";        
			String CARD_NTS1 = "";      
			String DIR_CARD_NTS1 = "";         
			String CASH_NTS1 = "";       
			String MARKET_NTS1 = "";   
			String PUBLIC_NTS1 = "";    
			String LC3_AMT_NTS1 = ""; 
			String INV_AMT1  = "";    
			String INV2_AMT1  = "";    			
			String MED_AMT1  = "";      
			String EDU_AMT1  = "";      
			String CARD_AMT1 = "";      
			String DIR_CARD_AMT1 = "";        
			String MARKET_AMT1 = "";  
			String PUBLIC_AMT1 = "";   
			String LC3_AMT1 = "";       
			
			
			String REL_CD2 = ""; 
			String NAM_KOR2 = "";        
			String CET_NO2 = ""; 
			String BAS_MAN2 = "";       
			String TRB_MAN2 = "";        
			String WCT_MAN2 = "";        
			String GOL_MAN2 = "";        
			String ONE_MAN2 = "";     
			String INP_MAN2 = "";  
			String RCH_MAN2 = "";  				
			String INV_NTS2 = "";    
			String INV2_NTS2 = "";			
			String MED_NTS2 = "";       
			String EDU_NTS2 = "";       
			String CARD_NTS2 = "";      
			String DIR_CARD_NTS2 = "";         
			String CASH_NTS2 = "";       
			String MARKET_NTS2 = "";  
			String PUBLIC_NTS2 = "";     
			String LC3_AMT_NTS2 = ""; 
			String INV_AMT2 = "";  
			String INV2_AMT2 = "";  			
			String MED_AMT2 = "";       
			String EDU_AMT2 = "";        
			String CARD_AMT2 = "";      
			String DIR_CARD_AMT2 = "";        
			String MARKET_AMT2 = "";   
			String PUBLIC_AMT2 = "";    
			String LC3_AMT2 = "";        
			
			
			String REL_CD3 = ""; 
			String NAM_KOR3 = "";        
			String CET_NO3 = ""; 
			String BAS_MAN3 = "";       
			String TRB_MAN3 = "";        
			String WCT_MAN3 = "";       
			String GOL_MAN3 = "";        
			String ONE_MAN3 = "";       
			String INP_MAN3 = "";  
			String RCH_MAN3 = "";  				
			String INV_NTS3 = "";      
			String INV2_NTS3 = ""; 			
			String MED_NTS3 = "";       
			String EDU_NTS3 = "";       
			String CARD_NTS3 = "";      
			String DIR_CARD_NTS3 = "";        
			String CASH_NTS3 = "";      
			String MARKET_NTS3 = "";   
			String PUBLIC_NTS3 = "";    
			String LC3_AMT_NTS3 = ""; 
			String INV_AMT3 = "";
			String INV2_AMT3 = "";			
			String MED_AMT3 = "";       
			String EDU_AMT3 = "";        
			String CARD_AMT3 = "";      
			String DIR_CARD_AMT3 = "";         
			String MARKET_AMT3 = "";  
			String PUBLIC_AMT3 = "";   
			String LC3_AMT3 = "";       
			
			
			String REL_CD4 = ""; 
			String NAM_KOR4 = "";       
			String CET_NO4 = ""; 
			String BAS_MAN4 = "";        
			String TRB_MAN4 = "";       
			String WCT_MAN4 = "";        
			String GOL_MAN4 = "";        
			String ONE_MAN4 = ""; 
			String INP_MAN4 = "";  
			String RCH_MAN4 = "";  				
			String INV_NTS4 = "";   
			String INV2_NTS4 = ""; 			
			String MED_NTS4 = "";        
			String EDU_NTS4 = "";        
			String CARD_NTS4 = "";      
			String DIR_CARD_NTS4 = "";         
			String CASH_NTS4 = "";      
			String MARKET_NTS4 = "";  
			String PUBLIC_NTS4 = "";    
			String LC3_AMT_NTS4 = ""; 
			String INV_AMT4 = ""; 
			String INV2_AMT4 = ""; 			
			String MED_AMT4 = ""; 
			String EDU_AMT4 = "";      
			String CARD_AMT4 = "";   
			String DIR_CARD_AMT4 = "";     
			String MARKET_AMT4 = "";   
			String PUBLIC_AMT4 = "";     
			String LC3_AMT4 = ""; 
			
			
			String REL_CD5 = "";  
			String NAM_KOR5 = ""; 
			String CET_NO5 = "";        
			String BAS_MAN5 = "";      
			String TRB_MAN5 = "";    
			String WCT_MAN5 = "";   
			String GOL_MAN5 = "";  
			String ONE_MAN5 = ""; 
			String INP_MAN5 = "";  
			String RCH_MAN5 = "";  				
			String INV_NTS5 = ""; 
			String INV2_NTS5 = ""; 			
			String MED_NTS5 = "";  
			String EDU_NTS5 = "";      
			String CARD_NTS5 = "";   
			String DIR_CARD_NTS5  = "";   
			String CASH_NTS5 = "";  
			String MARKET_NTS5 = "";     
			String PUBLIC_NTS5 = "";   
			String LC3_AMT_NTS5 = "";        
			String INV_AMT5 = ""; 
			String INV2_AMT5 = "";  			
			String MED_AMT5 = ""; 
			String EDU_AMT5 = "";      
			String CARD_AMT5 = "";   
			String DIR_CARD_AMT5  = "";     
			String MARKET_AMT5 = "";   
			String PUBLIC_AMT5 = "";    
			String LC3_AMT5 = "";                     
			
			
			
			String PEN_GUBUN_CD_1 = "";                                              
			String ABA_CD_1 = "";                                                           
			String ABA_NM_1 = "";                                                          
			String ACC_NO_1 = "";                                                                                                               
			String AMOUNT_1 = "";                                                           
			String DED_AMT_1 = "";    
			
			
			String PEN_GUBUN_CD_2 = "";                                              
			String ABA_CD_2 = "";                                                           
			String ABA_NM_2 = "";                                                          
			String ACC_NO_2 = "";                                                                                                  
			String AMOUNT_2 = "";                                                           
			String DED_AMT_2 = "";    
			
			
			String PEN_GUBUN_CD_3 = "";                                              
			String ABA_CD_3 = "";                                                           
			String ABA_NM_3 = "";                                                          
			String ACC_NO_3 = "";                                                                      
			String AMOUNT_3 = "";                                                           
			String DED_AMT_3 = "";      
			
			
			String PEN_GUBUN_CD_4 = "";                                              
			String ABA_CD_4 = "";                                                           
			String ABA_NM_4 = "";                                                          
			String ACC_NO_4 = "";                                                                    
			String AMOUNT_4 = "";                                                           
			String DED_AMT_4 = "";    
			
			
			String PEN_GUBUN_CD_5 = "";                                              
			String ABA_CD_5 = "";                                                           
			String ABA_NM_5 = "";                                                          
			String ACC_NO_5 = "";                                                                      
			String AMOUNT_5 = "";                                                           
			String DED_AMT_5 = "";    
			
			
			String PEN_GUBUN_CD_6 = "";                                              
			String ABA_CD_6 = "";                                                           
			String ABA_NM_6 = "";                                                          
			String ACC_NO_6 = "";                                                             
			String AMOUNT_6 = "";                                                           
			String DED_AMT_6 = "";    
			
			
			String PEN_GUBUN_CD_7 = "";                                              
			String ABA_CD_7 = "";                                                           
			String ABA_NM_7 = "";                                                          
			String ACC_NO_7 = "";                                                                
			String AMOUNT_7 = "";                                                           
			String DED_AMT_7 = "";       
			
			
			String PEN_GUBUN_CD_8 = "";                                              
			String ABA_CD_8 = "";                                                           
			String ABA_NM_8 = "";                                                          
			String ACC_NO_8 = "";                                                           
			String AMOUNT_8 = "";                                                           
			String DED_AMT_8 = "";        
			
			
			String PEN_GUBUN_CD_9 = "";                                              
			String ABA_CD_9 = "";                                                           
			String ABA_NM_9 = "";                                                          
			String ACC_NO_9 = "";                                                          
			String AMOUNT_9 = "";                                                           
			String DED_AMT_9 = "";      
			
			
			String PEN_GUBUN_CD_10 = "";                                            
			String ABA_CD_10 = "";                                                         
			String ABA_NM_10 = "";                                                        
			String ACC_NO_10 = "";                                                        
			String AMOUNT_10 = "";                                                         
			String DED_AMT_10 = "";           
			
			
			String PEN_GUBUN_CD_11 = "";                                            
			String ABA_CD_11 = "";                                                         
			String ABA_NM_11 = "";                                                        
			String ACC_NO_11 = "";                                                        
			String AMOUNT_11 = "";                                                         
			String DED_AMT_11 = "";        
			
			
			String PEN_GUBUN_CD_12 = "";                                            
			String ABA_CD_12 = "";                                                         
			String ABA_NM_12 = "";                                                        
			String ACC_NO_12 = "";                                                        
			String AMOUNT_12 = "";                                                         
			String DED_AMT_12 = "";        
			
			
			String PEN_GUBUN_CD_13 = "";                                            
			String ABA_CD_13 = "";                                                         
			String ABA_NM_13 = "";                                                        
			String ACC_NO_13 = "";                                                        
			String AMOUNT_13 = "";                                                         
			String DED_AMT_13 = "";            
			
			
			String PEN_GUBUN_CD_14 = "";                                            
			String ABA_CD_14 = "";                                                         
			String ABA_NM_14 = "";                                                        
			String ACC_NO_14 = "";                                                        
			String AMOUNT_14 = "";                                                         
			String DED_AMT_14 = "";        
			
			
			String PEN_GUBUN_CD_15 = "";                                            
			String ABA_CD_15 = "";                                                         
			String ABA_NM_15 = "";                                                        
			String ACC_NO_15 = "";                                                        
			String AMOUNT_15 = "";                                                         
			String DED_AMT_15 = "";                                    

 	    
	        for(i=1; i<=dsYACA001_SHR_14.getDataRowCnt(); i++){

	    	    YAC_SEL_KEY = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SEL_KEY");
		        YAC_REC_TAG = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_REC_TAG");
		        YAC_TAX_CD  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TAX_CD");
		        YAC_COMP_CD = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_COMP_CD");
		        YAC_CNT     = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CNT");
		        YAC_NAM_KOR = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_NAM_KOR");
		        YAC_CET_NO  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CET_NO");
		        YAC_ZIP_NO  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ZIP_NO");
		        YAC_JUSO    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JUSO");
		        YAC_JAS_NM  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAS_NM");
		        YAC_JAO_NO  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAO_NO");
		        YAC_SALT_AMTS  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SALT_AMTS");		        
		        YAC_SALT_AMTT  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SALT_AMTT"  );
		        YAC_FREE_INCOME= GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_FREE_INCOME");
		        YAC_TAX_INCOME = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TAX_INCOME" );
		        YAC_OUTT_AMTS    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_OUTT_AMTS" );		        
		        YAC_MGR_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MGR_AMT" );
		        YAC_MNI_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MNI_AMT" );
		        YAC_BADD_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_BADD_AMT");
		        YAC_SOU_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SOU_CNT" );
		        YAC_SPSB_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SPSB_AMT");
		        YAC_DFM_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DFM_CNT" );
		        YAC_GDED_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GDED_AMT");
		        YAC_GOL_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOL_CNT" );
		        YAC_GOL_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOL_AMT" );

		        YAC_TRB_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TRB_CNT" );
		        YAC_TBL_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TBL_DED" );
		        YAC_WDD_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_WDD_AMT" );
		        YAC_ONE_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ONE_AMT" );		        

		        YAC_HINU_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HINU_AMT" ); 
		        YAC_HINS_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HINS_AMT" );

		        YAC_LH1_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH1_AMT");
		        YAC_LH2_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH2_AMT");
		        YAC_LH3_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH3_AMT"); 
		        YAC_LH4_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH4_AMT");
		        YAC_LH5_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH5_AMT");
		        YAC_LH6_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH6_AMT");
		        YAC_LH7_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH7_AMT");
		        YAC_LH8_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LH8_AMT");		
		        YAC_DON_FWD   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DON_FWD");		
		        YAC_PER_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_PER_DED");			        

		        YAC_CPC_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CPC_DED" );
		        YAC_NSE_TOT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_NSE_TOT" );
		        YAC_INDED_TOT  = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_INDED_TOT"  );
		        YAC_CARD_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CARD_DED");
		        YAC_SAVE_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE_DED");
		        YAC_SAVE1_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE1_DED"); 
		        YAC_SAVE2_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE2_DED");
		        YAC_SAVE3_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAVE3_DED"); 
		        YAC_SAJU_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SAJU_AMT");
		        YAC_LSS_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LSS_AMT"); 		        
		        YAC_ETC_TOT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ETC_TOT"); 		        
		        YAC_VEN_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_VEN_DED" );
		        YAC_TTAX_STD   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TTAX_STD");
		        YAC_TAX_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TAX_AMT" );
		        YAC_HGR_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HGR_DED" );
		        
		        YAC_CHI_CNT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CHI_CNT" );	
		        YAC_AGE_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_AGE_AMT" );
		        YAC_CHI_RCH    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CHI_RCH" );	
		        YAC_AGE_RCH    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_AGE_RCH" );		        
		        YAC_CHI_INP    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CHI_INP" );	
		        YAC_AGE_INP    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_AGE_INP" );
		        
		        YAC_ANN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ANN_AMT" );		        
		        YAC_ANN_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_ANN_DED" );  			        
		        YAC_LIN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LIN_AMT" );		        
		        YAC_MIN_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MIN_DED" );  		        
		        
				YAC_MMA_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MMA_AMT" );  
				YAC_MMA_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MMA_DED" );		        
				YAC_EDU_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_EDU_AMT" );
				YAC_EDU_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_EDU_DED" );			        
				
				YAC_GOV1_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV1_AMT" );		        
				YAC_GOV1_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV1_DED" );  			        
				YAC_GOV2_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV2_AMT" );		        
				YAC_GOV2_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV2_DED" );  		        
		        
				YAC_LC1_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC1_AMT" );  
				YAC_LC1_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC1_DED" );		        
				YAC_LC23_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC23_AMT" );
				YAC_LC23_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_LC23_DED" );					

				YAC_MRENT_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_MRENT_DED" );  				
				
		        YAC_TDED_TOT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_TDED_TOT");
		        YAC_DGG_TAX    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DGG_TAX" );
		        YAC_DBW_TAX    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DBW_TAX" );
		        YAC_DJM_TAX    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DJM_TAX" );
		        YAC_JAL_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAL_AMT" );
		        YAC_JAC_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAC_AMT" );
		        YAC_JAN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_JAN_AMT" );
		        YAC_INCM_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_INCM_TAX");
		        YAC_CITI_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CITI_TAX");
		        EMS_HIR_YMD    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EMS_HIR_YMD" );
		        EMS_RET_YMD    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EMS_RET_YMD" );
		        YAC_STA_TOT    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_STA_TOT" );
		        YAC_NPEN_DED   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_NPEN_DED");

		        YAC_SEA_FREE   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_SEA_FREE");
		        YAC_GOV_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_GOV_DED" );
		        YAC_OTX_DED    = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_OTX_DED" );
		        YAC_CASH_AMT   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_CASH_AMT");
		        YAC_REA_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_REA_TAX");
		        YAC_REB_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_REB_TAX");
		        YAC_REC_TAX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_REC_TAX");		        
		        //YAC_DRE_INTX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DRE_INTX");
		        //YAC_DRE_CTTX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DRE_CTTX");
		        //YAC_DRE_DFTX   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_DRE_DFTX");
		        YAC_HOL_YN   = GauceUtils.nameValue(dsYACA001_SHR_14, i, "YAC_HOL_YN");

		        
		        REL_CD1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD1");
		        NAM_KOR1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR1");

			    //System.out.println("-----------1818181818181818---------" +NAM_KOR1);
			    /*				    
			    System.out.println("-----------GauceDataColumn---------" +EDU_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +CARD_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +DIR_CARD_NTS5);			    
			    System.out.println("-----------GauceDataColumn---------" +CASH_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +MARKET_NTS5);			    
			    System.out.println("-----------GauceDataColumn---------" +PUBLIC_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +LC3_AMT_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +INV_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +EDU_AMT5);			        
			    System.out.println("-----------GauceDataColumn---------" +CARD_AMT5);			    
			    System.out.println("-----------GauceDataColumn---------" +DIR_CARD_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +MARKET_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +PUBLIC_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +LC3_AMT5);			        */
		        
		        CET_NO1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO1");
		        BAS_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN1");
		        TRB_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN1");
		        WCT_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN1");
		        GOL_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN1");
		        ONE_MAN1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN1");		
		        INP_MAN1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INP_MAN1");
		        RCH_MAN1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "RCH_MAN1");		        
		        INV_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS1");
		        INV2_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS1");		        
		        MED_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS1");
		        EDU_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS1");
		        CARD_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS1");
		        DIR_CARD_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS1");
		        CASH_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS1");
		        MARKET_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS1");		 
		        PUBLIC_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS1");		 
		        LC3_AMT_NTS1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS1");
		        INV_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT1");
		        INV2_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT1");		        
		        MED_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT1");
		        EDU_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT1");
		        CARD_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT1");
		        DIR_CARD_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT1");
		        MARKET_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT1");		  
		        PUBLIC_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT1");		   
		        LC3_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT1");
		        
		        
		        REL_CD2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD2");
		        NAM_KOR2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR2");
		        CET_NO2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO2");
		        BAS_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN2");
		        TRB_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN2");
		        WCT_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN2");
		        GOL_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN2");
		        ONE_MAN2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN2");		 
		        INP_MAN2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INP_MAN2");
		        RCH_MAN2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "RCH_MAN2");				        
		        INV_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS2");
		        INV2_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS2");		        
		        MED_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS2");
		        EDU_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS2");
		        CARD_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS2");
		        DIR_CARD_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS2");
		        CASH_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS2");
		        MARKET_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS2");		
		        PUBLIC_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS2");		        
		        LC3_AMT_NTS2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS2");
		        INV_AMT2        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT2");
		        INV2_AMT2        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT2");		        
		        MED_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT2");
		        EDU_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT2");
		        CARD_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT2");
		        DIR_CARD_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT2");
		        MARKET_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT2");		     
		        PUBLIC_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT2");			       
		        LC3_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT2");
		        
		        
		        REL_CD3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD3");
		        NAM_KOR3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR3");
		        CET_NO3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO3");
		        BAS_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN3");
		        TRB_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN3");
		        WCT_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN3");
		        GOL_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN3");
		        ONE_MAN3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN3");		 
		        INP_MAN3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INP_MAN3");
		        RCH_MAN3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "RCH_MAN3");				        
		        INV_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS3");
		        INV2_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS3");		        
		        MED_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS3");
		        EDU_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS3");
		        CARD_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS3");
		        DIR_CARD_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS3");
		        CASH_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS3");
		        MARKET_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS3");		        
		        PUBLIC_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS3");		        
		        LC3_AMT_NTS3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS3");
		        INV_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT3");
		        INV2_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT3");		        
		        MED_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT3");
		        EDU_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT3");
		        CARD_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT3");
		        DIR_CARD_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT3");
		        MARKET_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT3");		        
		        PUBLIC_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT3");			        
		        LC3_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT3");
		        

		        REL_CD4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD4");
		        NAM_KOR4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR4");
		        CET_NO4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO4");
		        BAS_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN4");
		        TRB_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN4");
		        WCT_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN4");
		        GOL_MAN4        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN4");
		        ONE_MAN4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN4");	
		        INP_MAN4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INP_MAN4");
		        RCH_MAN4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "RCH_MAN4");				        
		        INV_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS4");
		        INV2_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS4");		        
		        MED_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS4");
		        EDU_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS4");
		        CARD_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS4");
		        DIR_CARD_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS4");
		        CASH_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS4");
		        MARKET_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS4");		        
		        PUBLIC_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS4");		        
		        LC3_AMT_NTS4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS4");
		        INV_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT4");
		        INV2_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT4");		        
		        MED_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT4");
		        EDU_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT4");
		        CARD_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT4");
		        DIR_CARD_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT4");
		        MARKET_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT4");		        
		        PUBLIC_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT4");			        
		        LC3_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT4");


		        REL_CD5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "REL_CD5");
		        NAM_KOR5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "NAM_KOR5");
		        CET_NO5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CET_NO5");
		        BAS_MAN5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "BAS_MAN5");
		        TRB_MAN5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "TRB_MAN5");
		        WCT_MAN5        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "WCT_MAN5");
		        GOL_MAN5        = GauceUtils.nameValue(dsYACA001_SHR_14, i, "GOL_MAN5");
		        ONE_MAN5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ONE_MAN5");		
		        INP_MAN5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INP_MAN5");
		        RCH_MAN5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "RCH_MAN5");				        
		        INV_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_NTS5");
		        INV2_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_NTS5");		        
		        MED_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_NTS5");
		        EDU_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_NTS5");
		        CARD_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_NTS5");
		        DIR_CARD_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_NTS5");
		        CASH_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CASH_NTS5");
		        MARKET_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_NTS5");		        
		        PUBLIC_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_NTS5");		        
		        LC3_AMT_NTS5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT_NTS5");
		        INV_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV_AMT5");
		        INV2_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "INV2_AMT5");		        
		        MED_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MED_AMT5");
		        EDU_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "EDU_AMT5");
		        CARD_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "CARD_AMT5");
		        DIR_CARD_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DIR_CARD_AMT5");
		        MARKET_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "MARKET_AMT5");		     
		        PUBLIC_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PUBLIC_AMT5");			      
		        LC3_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "LC3_AMT5");

			        
		        
		        PEN_GUBUN_CD_1 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_1");
		        ABA_CD_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_1");
		        ABA_NM_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_1");
		        ACC_NO_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_1");
		        AMOUNT_1       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_1");
		        DED_AMT_1      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_1");
		        
		        
		        PEN_GUBUN_CD_2 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_2");
		        ABA_CD_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_2");
		        ABA_NM_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_2");
		        ACC_NO_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_2");
		        AMOUNT_2       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_2");
		        DED_AMT_2      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_2");
		        
		        
		        PEN_GUBUN_CD_3 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_3");
		        ABA_CD_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_3");
		        ABA_NM_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_3");
		        ACC_NO_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_3");
		        AMOUNT_3       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_3");
		        DED_AMT_3      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_3");
		        
		        
		        PEN_GUBUN_CD_4 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_4");
		        ABA_CD_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_4");
		        ABA_NM_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_4");
		        ACC_NO_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_4");
		        AMOUNT_4       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_4");
		        DED_AMT_4      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_4");
		        
		        
		        PEN_GUBUN_CD_5 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_5");
		        ABA_CD_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_5");
		        ABA_NM_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_5");
		        ACC_NO_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_5");
		        AMOUNT_5       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_5");
		        DED_AMT_5      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_5");
		        
		        
		        PEN_GUBUN_CD_6 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_6");
		        ABA_CD_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_6");
		        ABA_NM_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_6");
		        ACC_NO_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_6");
		        AMOUNT_6       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_6");
		        DED_AMT_6      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_6");
		        
		        
		        PEN_GUBUN_CD_7 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_7");
		        ABA_CD_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_7");
		        ABA_NM_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_7");
		        ACC_NO_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_7");
		        AMOUNT_7       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_7");
		        DED_AMT_7      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_7");
		        
		        
		        PEN_GUBUN_CD_8 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_8");
		        ABA_CD_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_8");
		        ABA_NM_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_8");
		        ACC_NO_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_8");
		        AMOUNT_8       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_8");
		        DED_AMT_8      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_8");
		        
		        
		        PEN_GUBUN_CD_9 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_9");
		        ABA_CD_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_9");
		        ABA_NM_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_9");
		        ACC_NO_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_9");
		        AMOUNT_9       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_9");
		        DED_AMT_9      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_9");
		        
		        
		        PEN_GUBUN_CD_10 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_10");
		        ABA_CD_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_10");
		        ABA_NM_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_10");
		        ACC_NO_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_10");
		        AMOUNT_10       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_10");
		        DED_AMT_10      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_10");
		        
		        
		        PEN_GUBUN_CD_11 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_11");
		        ABA_CD_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_11");
		        ABA_NM_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_11");
		        ACC_NO_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_11");
		        AMOUNT_11       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_11");
		        DED_AMT_11      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_11");
		        
		        
		        PEN_GUBUN_CD_12 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_12");
		        ABA_CD_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_12");
		        ABA_NM_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_12");
		        ACC_NO_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_12");
		        AMOUNT_12       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_12");
		        DED_AMT_12      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_12");
		        
		        
		        PEN_GUBUN_CD_13 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_13");
		        ABA_CD_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_13");
		        ABA_NM_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_13");
		        ACC_NO_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_13");
		        AMOUNT_13       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_13");
		        DED_AMT_13      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_13");
		        
		        
		        PEN_GUBUN_CD_14 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_14");
		        ABA_CD_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_14");
		        ABA_NM_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_14");
		        ACC_NO_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_14");
		        AMOUNT_14       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_14");
		        DED_AMT_14      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_14");
		        
		        
		        PEN_GUBUN_CD_15 = GauceUtils.nameValue(dsYACA001_SHR_14, i, "PEN_GUBUN_CD_15");
		        ABA_CD_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_CD_15");
		        ABA_NM_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ABA_NM_15");
		        ACC_NO_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "ACC_NO_15");
		        AMOUNT_15       = GauceUtils.nameValue(dsYACA001_SHR_14, i, "AMOUNT_15");
		        DED_AMT_15      = GauceUtils.nameValue(dsYACA001_SHR_14, i, "DED_AMT_15");


		        
		        /* 기본공제, 추가공제 공제별 전액 기록을 위한 체크부분  -2001.02 */
		        if (YAC_REC_TAG.equals("C") ) {

			         /* 본인공제 */
			         if ((Long.parseLong(JSPUtil.rns3(YAC_BADD_AMT)) == 0) || (Long.parseLong(JSPUtil.rns3(YAC_BADD_AMT)) < 1500000)){
			              YAC_BADD_AMT = "1500000";
			         }

			         /* 배우자공제 */
			         if (JSPUtil.rns3(YAC_SOU_CNT).equals("1")){
			             YAC_SPSB_AMT = "1500000";
			         }

			         /* 부양가족공제 */
			         if (!JSPUtil.rns3(YAC_DFM_CNT).equals("0")  && !JSPUtil.rns3(YAC_DFM_CNT).equals("")){
			             YAC_GDED_AMT = Long.toString( Long.parseLong(YAC_DFM_CNT) * 1500000 );
			         }

			         /* 경로우대공제
			       /*  if (!JSPUtil.rns3(YAC_GOL_CNT65).equals("0") && !JSPUtil.rns3(YAC_GOL_CNT65).equals("")){
			             TMP_GOL_AMT65 = Long.toString( Long.parseLong(YAC_GOL_CNT65) * 1000000);
			         }  
			          	*/
			         if (!JSPUtil.rns3(YAC_GOL_CNT).equals("0") && !JSPUtil.rns3(YAC_GOL_CNT).equals("")){
			        	 YAC_GOL_AMT = Long.toString( Long.parseLong(YAC_GOL_CNT) * 1000000);
			         } 

			         //YAC_GOL_AMT = Long.toString( Long.parseLong(TMP_GOL_AMT65) + Long.parseLong(TMP_GOL_AMT70) );
			          
			         
			         
			         /* 장애자공제액 */
			         if (!JSPUtil.rns3(YAC_TRB_CNT).equals("0") && !JSPUtil.rns3(YAC_TRB_CNT).equals("")){
    		             YAC_TBL_DED = Long.toString( Long.parseLong(YAC_TRB_CNT) * 2000000);
			         }

			         /* 부녀자공제액 */
			         if (!JSPUtil.rns3(YAC_WDD_AMT).equals("0") && (Long.parseLong(JSPUtil.rns3(YAC_WDD_AMT)) < 500000) ){
			        	 YAC_WDD_AMT = "500000";
			         }

		        }

		        j = 0;

		        grAdd = new GauceDataRow(dsResult.getDataColCnt());
		        
		        grAdd.setString(j++, YAC_REC_TAG);
		        grAdd.setString(j++, YAC_TAX_CD);
		        grAdd.setString(j++, YAC_COMP_CD);
		        grAdd.setString(j++, YAC_CNT);
		        grAdd.setString(j++, YAC_NAM_KOR);
		        grAdd.setString(j++, YAC_CET_NO);
		        grAdd.setString(j++, YAC_ZIP_NO);
		        grAdd.setString(j++, YAC_JUSO);
		        grAdd.setString(j++, YAC_JAS_NM);
		        grAdd.setString(j++, YAC_JAO_NO);
		        grAdd.setString(j++, YAC_SALT_AMTS);
		        grAdd.setString(j++, YAC_SALT_AMTT);
		        grAdd.setString(j++, YAC_FREE_INCOME);
		        grAdd.setString(j++, YAC_TAX_INCOME);
		        grAdd.setString(j++, YAC_OUTT_AMTS);		        
		        grAdd.setString(j++, YAC_MGR_AMT);
		        grAdd.setString(j++, YAC_MNI_AMT);
		        grAdd.setString(j++, YAC_BADD_AMT);
		        grAdd.setString(j++, YAC_SOU_CNT);		        
		        grAdd.setString(j++, YAC_SPSB_AMT);
		        grAdd.setString(j++, YAC_DFM_CNT);
		        grAdd.setString(j++, YAC_GDED_AMT);
		        grAdd.setString(j++, YAC_GOL_CNT);
		        grAdd.setString(j++, YAC_GOL_AMT);	        
		        grAdd.setString(j++, YAC_TRB_CNT);
		        grAdd.setString(j++, YAC_TBL_DED);
		        grAdd.setString(j++, YAC_WDD_AMT);
		        grAdd.setString(j++, YAC_ONE_AMT);		     
		        

		        grAdd.setString(j++, YAC_HINU_AMT); //2010, 건강보험료
		        grAdd.setString(j++, YAC_HINS_AMT); //2010, 고용보험료

		        
		        grAdd.setString(j++, YAC_LH1_AMT);//주택자금_주택임차차입금원리금상환액_대출기관
		        grAdd.setString(j++, YAC_LH2_AMT);//주택자금_주택임차차입금원리금상환액_거주자
		        grAdd.setString(j++, YAC_LH3_AMT); //주택자금_월세액
		        grAdd.setString(j++, YAC_LH4_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_15년미만
		       	grAdd.setString(j++, YAC_LH5_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_15년~29년
		        grAdd.setString(j++, YAC_LH6_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_30년이상
		        grAdd.setString(j++, YAC_LH7_AMT);//(2012년 이후 차입분)고정금리비거치 상환 대출
		        grAdd.setString(j++, YAC_LH8_AMT);//(2012년 이후 차입분)기타 대출	
		        grAdd.setString(j++, YAC_DON_FWD);//기부금 이월금  
		        grAdd.setString(j++, YAC_PER_DED);//개인연금저축소득공제  		        
	        
		        grAdd.setString(j++, YAC_CPC_DED);
		        grAdd.setString(j++, YAC_NSE_TOT);
		        grAdd.setString(j++, YAC_INDED_TOT);
		        grAdd.setString(j++, YAC_CARD_DED);
		        grAdd.setString(j++, YAC_SAVE_DED);
		        grAdd.setString(j++, YAC_SAVE1_DED); //청약저축
		        grAdd.setString(j++, YAC_SAVE2_DED); //주택청약종합저축
		        grAdd.setString(j++, YAC_SAVE3_DED); //근로자주택마련저축
		        grAdd.setString(j++, YAC_SAJU_AMT); //우리사주조합 출연금
		        grAdd.setString(j++, YAC_LSS_AMT); //장기집합투자증권저축	   
		        grAdd.setString(j++, YAC_ETC_TOT); //그밖의 소득공제 계 		        
		        grAdd.setString(j++, YAC_VEN_DED);
		        grAdd.setString(j++, YAC_TTAX_STD);
		        grAdd.setString(j++, YAC_TAX_AMT);
		        grAdd.setString(j++, YAC_HGR_DED);
		        
		        grAdd.setString(j++, YAC_CHI_CNT);		    
		        grAdd.setString(j++, YAC_AGE_AMT);
		        grAdd.setString(j++, YAC_CHI_RCH);		        
		        grAdd.setString(j++, YAC_AGE_RCH);		    
		        grAdd.setString(j++, YAC_CHI_INP);
		        grAdd.setString(j++, YAC_AGE_INP);		        
		        
		        grAdd.setString(j++, YAC_ANN_AMT);
		        grAdd.setString(j++, YAC_ANN_DED);
		        grAdd.setString(j++, YAC_LIN_AMT);
		        grAdd.setString(j++, YAC_MIN_DED);			        

		        grAdd.setString(j++, YAC_MMA_AMT);//의료비 공제금액		      
		        grAdd.setString(j++, YAC_MMA_DED);//의료비세액공제
		        grAdd.setString(j++, YAC_EDU_AMT);//교육비공제금액		        
		        grAdd.setString(j++, YAC_EDU_DED);//교육비 세액공제	        
		        
		        grAdd.setString(j++, YAC_GOV1_AMT);
		        grAdd.setString(j++, YAC_GOV1_DED);
		        grAdd.setString(j++, YAC_GOV2_AMT);
		        grAdd.setString(j++, YAC_GOV2_DED);			        	

		        grAdd.setString(j++, YAC_LC1_AMT);//법정기부금      
		        grAdd.setString(j++, YAC_LC1_DED);//법정기부금
		        grAdd.setString(j++, YAC_LC23_AMT);//지정기부금		        
		        grAdd.setString(j++, YAC_LC23_DED);//지정기부금
		        
		        grAdd.setString(j++, YAC_MRENT_DED);//월세 세액공제	   
		        
		        grAdd.setString(j++, YAC_TDED_TOT);
		        grAdd.setString(j++, YAC_DGG_TAX);
		        grAdd.setString(j++, YAC_DBW_TAX);
		        grAdd.setString(j++, YAC_DJM_TAX);
		        grAdd.setString(j++, YAC_JAL_AMT);
		        grAdd.setString(j++, YAC_JAC_AMT);
		        grAdd.setString(j++, YAC_JAN_AMT);
		        grAdd.setString(j++, YAC_INCM_TAX);
		        grAdd.setString(j++, YAC_CITI_TAX);
		        
	    	    //System.out.println("-----------EMS_HIR_YMD---------"+EMS_HIR_YMD);		        
	    	    //System.out.println("-----------EMS_RET_YMD---------"+EMS_RET_YMD);	
		        
		        grAdd.setString(j++, EMS_HIR_YMD);
		        grAdd.setString(j++, EMS_RET_YMD);
		        grAdd.setString(j++, YAC_STA_TOT);
		        grAdd.setString(j++, YAC_NPEN_DED);

		        grAdd.setString(j++, YAC_SEA_FREE);
		        grAdd.setString(j++, YAC_GOV_DED);
		        grAdd.setString(j++, YAC_OTX_DED);
		        grAdd.setString(j++, YAC_CASH_AMT);
		        grAdd.setString(j++, YAC_REA_TAX);
		        grAdd.setString(j++, YAC_REB_TAX);
		        grAdd.setString(j++, YAC_REC_TAX);		        
		        //grAdd.setString(j++, YAC_DRE_INTX);
		        //grAdd.setString(j++, YAC_DRE_CTTX);
		        //grAdd.setString(j++, YAC_DRE_DFTX);
		        
	
		        
		        grAdd.setString(j++, YAC_HOL_YN);
	    	    //System.out.println("-----------YAC_HOL_YN---------"+YAC_HOL_YN);		        
	    	    //System.out.println("-----------REL_CD1---------"+REL_CD1);			        
		        
		        grAdd.setString(j++,REL_CD1);	        
		        grAdd.setString(j++,NAM_KOR1);
		        grAdd.setString(j++,CET_NO1);
		        grAdd.setString(j++,BAS_MAN1);
		        grAdd.setString(j++,TRB_MAN1);
		        grAdd.setString(j++,WCT_MAN1);
		        grAdd.setString(j++,GOL_MAN1);
		        grAdd.setString(j++,ONE_MAN1);
		        grAdd.setString(j++,INP_MAN1);		        
		        grAdd.setString(j++,RCH_MAN1);		        
		        grAdd.setString(j++,INV_NTS1);
		        grAdd.setString(j++,INV2_NTS1);		        
		        grAdd.setString(j++,MED_NTS1);
		        grAdd.setString(j++,EDU_NTS1);
		        grAdd.setString(j++,CARD_NTS1);
		        grAdd.setString(j++,DIR_CARD_NTS1);
		        grAdd.setString(j++,CASH_NTS1);
		        grAdd.setString(j++,MARKET_NTS1);
		        grAdd.setString(j++,PUBLIC_NTS1);
		        grAdd.setString(j++,LC3_AMT_NTS1);
		        grAdd.setString(j++,INV_AMT1);
		        grAdd.setString(j++,INV2_AMT1);		        
		        grAdd.setString(j++,MED_AMT1);
		        grAdd.setString(j++,EDU_AMT1);
		        grAdd.setString(j++,CARD_AMT1);
		        grAdd.setString(j++,DIR_CARD_AMT1);
		        grAdd.setString(j++,MARKET_AMT1);
		        grAdd.setString(j++,PUBLIC_AMT1);
		        grAdd.setString(j++,LC3_AMT1);
		        

		        grAdd.setString(j++,REL_CD2);
		        grAdd.setString(j++,NAM_KOR2);
		        grAdd.setString(j++,CET_NO2);
		        grAdd.setString(j++,BAS_MAN2);
		        grAdd.setString(j++,TRB_MAN2);
		        grAdd.setString(j++,WCT_MAN2);
		        grAdd.setString(j++,GOL_MAN2);
		        grAdd.setString(j++,ONE_MAN2);
		        grAdd.setString(j++,INP_MAN2);		        
		        grAdd.setString(j++,RCH_MAN2);			        
		        grAdd.setString(j++,INV_NTS2);
		        grAdd.setString(j++,INV2_NTS2);		        
		        grAdd.setString(j++,MED_NTS2);
		        grAdd.setString(j++,EDU_NTS2);
		        grAdd.setString(j++,CARD_NTS2);
		        grAdd.setString(j++,DIR_CARD_NTS2);
		        grAdd.setString(j++,CASH_NTS2);
		        grAdd.setString(j++,MARKET_NTS2);
		        grAdd.setString(j++,PUBLIC_NTS2);
		        grAdd.setString(j++,LC3_AMT_NTS2);
		        grAdd.setString(j++,INV_AMT2);
		        grAdd.setString(j++,INV2_AMT2);		        
		        grAdd.setString(j++,MED_AMT2);
		        grAdd.setString(j++,EDU_AMT2);
		        grAdd.setString(j++,CARD_AMT2);
		        grAdd.setString(j++,DIR_CARD_AMT2);
		        grAdd.setString(j++,MARKET_AMT2);
		        grAdd.setString(j++,PUBLIC_AMT2);
		        grAdd.setString(j++,LC3_AMT2);
		        

		        grAdd.setString(j++,REL_CD3);
		        grAdd.setString(j++,NAM_KOR3);
		        grAdd.setString(j++,CET_NO3);
		        grAdd.setString(j++,BAS_MAN3);
		        grAdd.setString(j++,TRB_MAN3);
		        grAdd.setString(j++,WCT_MAN3);
		        grAdd.setString(j++,GOL_MAN3);
		        grAdd.setString(j++,ONE_MAN3);
		        grAdd.setString(j++,INP_MAN3);		        
		        grAdd.setString(j++,RCH_MAN3);			        
		        grAdd.setString(j++,INV_NTS3);
		        grAdd.setString(j++,INV2_NTS3);		        
		        grAdd.setString(j++,MED_NTS3);
		        grAdd.setString(j++,EDU_NTS3);
		        grAdd.setString(j++,CARD_NTS3);
		        grAdd.setString(j++,DIR_CARD_NTS3);
		        grAdd.setString(j++,CASH_NTS3);
		        grAdd.setString(j++,MARKET_NTS3);
		        grAdd.setString(j++,PUBLIC_NTS3);
		        grAdd.setString(j++,LC3_AMT_NTS3);
		        grAdd.setString(j++,INV_AMT3);
		        grAdd.setString(j++,INV2_AMT3);		        
		        grAdd.setString(j++,MED_AMT3);
		        grAdd.setString(j++,EDU_AMT3);
		        grAdd.setString(j++,CARD_AMT3);
		        grAdd.setString(j++,DIR_CARD_AMT3);
		        grAdd.setString(j++,MARKET_AMT3);
		        grAdd.setString(j++,PUBLIC_AMT3);
		        grAdd.setString(j++,LC3_AMT3);
		        
	        
		        grAdd.setString(j++,REL_CD4);
		        grAdd.setString(j++,NAM_KOR4);
		        grAdd.setString(j++,CET_NO4);
		        grAdd.setString(j++,BAS_MAN4);
		        grAdd.setString(j++,TRB_MAN4);
		        grAdd.setString(j++,WCT_MAN4);
		        grAdd.setString(j++,GOL_MAN4);
		        grAdd.setString(j++,ONE_MAN4);
		        grAdd.setString(j++,INP_MAN4);		        
		        grAdd.setString(j++,RCH_MAN4);			        
		        grAdd.setString(j++,INV_NTS4);
		        grAdd.setString(j++,INV2_NTS4);		        
		        grAdd.setString(j++,MED_NTS4);
		        grAdd.setString(j++,EDU_NTS4);
		        grAdd.setString(j++,CARD_NTS4);
		        grAdd.setString(j++,DIR_CARD_NTS4);
		        grAdd.setString(j++,CASH_NTS4);
		        grAdd.setString(j++,MARKET_NTS4);
		        grAdd.setString(j++,PUBLIC_NTS4);
		        grAdd.setString(j++,LC3_AMT_NTS4);
		        grAdd.setString(j++,INV_AMT4);
		        grAdd.setString(j++,INV2_AMT4);		        
		        grAdd.setString(j++,MED_AMT4);
		        grAdd.setString(j++,EDU_AMT4);
		        grAdd.setString(j++,CARD_AMT4);
		        grAdd.setString(j++,DIR_CARD_AMT4);
		        grAdd.setString(j++,MARKET_AMT4);
		        grAdd.setString(j++,PUBLIC_AMT4);
		        grAdd.setString(j++,LC3_AMT4);
		        

		        grAdd.setString(j++,REL_CD5);
		        grAdd.setString(j++,NAM_KOR5);
		        grAdd.setString(j++,CET_NO5);
		        grAdd.setString(j++,BAS_MAN5);
		        grAdd.setString(j++,TRB_MAN5);
		        grAdd.setString(j++,WCT_MAN5);
		        grAdd.setString(j++,GOL_MAN5);
		        grAdd.setString(j++,ONE_MAN5);
		        grAdd.setString(j++,INP_MAN5);		        
		        grAdd.setString(j++,RCH_MAN5);			        
		        grAdd.setString(j++,INV_NTS5);
		        grAdd.setString(j++,INV2_NTS5);		        
		        grAdd.setString(j++,MED_NTS5);
		        grAdd.setString(j++,EDU_NTS5);
		        grAdd.setString(j++,CARD_NTS5);
		        grAdd.setString(j++,DIR_CARD_NTS5);
		        grAdd.setString(j++,CASH_NTS5);
		        grAdd.setString(j++,MARKET_NTS5);
		        grAdd.setString(j++,PUBLIC_NTS5);
		        grAdd.setString(j++,LC3_AMT_NTS5);
		        grAdd.setString(j++,INV_AMT5);
		        grAdd.setString(j++,INV2_AMT5);		        
		        grAdd.setString(j++,MED_AMT5);
		        grAdd.setString(j++,EDU_AMT5);
		        grAdd.setString(j++,CARD_AMT5);
		        grAdd.setString(j++,DIR_CARD_AMT5);
		        grAdd.setString(j++,MARKET_AMT5);
		        grAdd.setString(j++,PUBLIC_AMT5);
		        grAdd.setString(j++,LC3_AMT5);
		        //grAdd.setString(j++, YAC_SEL_KEY);

		        grAdd.setString(j++, PEN_GUBUN_CD_1);
		        grAdd.setString(j++, ABA_CD_1);
		        grAdd.setString(j++, ABA_NM_1);
		        grAdd.setString(j++, ACC_NO_1);
		        grAdd.setString(j++, AMOUNT_1);
		        grAdd.setString(j++, DED_AMT_1);

		        grAdd.setString(j++, PEN_GUBUN_CD_2);
		        grAdd.setString(j++, ABA_CD_2);
		        grAdd.setString(j++, ABA_NM_2);
		        grAdd.setString(j++, ACC_NO_2);
		        grAdd.setString(j++, AMOUNT_2);
		        grAdd.setString(j++, DED_AMT_2);

		        grAdd.setString(j++, PEN_GUBUN_CD_3);
		        grAdd.setString(j++, ABA_CD_3);
		        grAdd.setString(j++, ABA_NM_3);
		        grAdd.setString(j++, ACC_NO_3);
		        grAdd.setString(j++, AMOUNT_3);
		        grAdd.setString(j++, DED_AMT_3);

		        grAdd.setString(j++, PEN_GUBUN_CD_4);
		        grAdd.setString(j++, ABA_CD_4);
		        grAdd.setString(j++, ABA_NM_4);
		        grAdd.setString(j++, ACC_NO_4);
		        grAdd.setString(j++, AMOUNT_4);
		        grAdd.setString(j++, DED_AMT_4);

		        grAdd.setString(j++, PEN_GUBUN_CD_5);
		        grAdd.setString(j++, ABA_CD_5);
		        grAdd.setString(j++, ABA_NM_5);
		        grAdd.setString(j++, ACC_NO_5);
		        grAdd.setString(j++, AMOUNT_5);
		        grAdd.setString(j++, DED_AMT_5);

		        grAdd.setString(j++, PEN_GUBUN_CD_6);
		        grAdd.setString(j++, ABA_CD_6);
		        grAdd.setString(j++, ABA_NM_6);
		        grAdd.setString(j++, ACC_NO_6);
		        grAdd.setString(j++, AMOUNT_6);
		        grAdd.setString(j++, DED_AMT_6);

		        grAdd.setString(j++, PEN_GUBUN_CD_7);
		        grAdd.setString(j++, ABA_CD_7);
		        grAdd.setString(j++, ABA_NM_7);
		        grAdd.setString(j++, ACC_NO_7);
		        grAdd.setString(j++, AMOUNT_7);
		        grAdd.setString(j++, DED_AMT_7);

		        grAdd.setString(j++, PEN_GUBUN_CD_8);
		        grAdd.setString(j++, ABA_CD_8);
		        grAdd.setString(j++, ABA_NM_8);
		        grAdd.setString(j++, ACC_NO_8);
		        grAdd.setString(j++, AMOUNT_8);
		        grAdd.setString(j++, DED_AMT_8);

		        grAdd.setString(j++, PEN_GUBUN_CD_9);
		        grAdd.setString(j++, ABA_CD_9);
		        grAdd.setString(j++, ABA_NM_9);
		        grAdd.setString(j++, ACC_NO_9);
		        grAdd.setString(j++, AMOUNT_9);
		        grAdd.setString(j++, DED_AMT_9);

		        grAdd.setString(j++, PEN_GUBUN_CD_10);
		        grAdd.setString(j++, ABA_CD_10);
		        grAdd.setString(j++, ABA_NM_10);
		        grAdd.setString(j++, ACC_NO_10);
		        grAdd.setString(j++, AMOUNT_10);
		        grAdd.setString(j++, DED_AMT_10);

		        grAdd.setString(j++, PEN_GUBUN_CD_11);
		        grAdd.setString(j++, ABA_CD_11);
		        grAdd.setString(j++, ABA_NM_11);
		        grAdd.setString(j++, ACC_NO_11);
		        grAdd.setString(j++, AMOUNT_11);
		        grAdd.setString(j++, DED_AMT_11);

		        grAdd.setString(j++, PEN_GUBUN_CD_12);
		        grAdd.setString(j++, ABA_CD_12);
		        grAdd.setString(j++, ABA_NM_12);
		        grAdd.setString(j++, ACC_NO_12);
		        grAdd.setString(j++, AMOUNT_12);
		        grAdd.setString(j++, DED_AMT_12);

		        grAdd.setString(j++, PEN_GUBUN_CD_13);
		        grAdd.setString(j++, ABA_CD_13);
		        grAdd.setString(j++, ABA_NM_13);
		        grAdd.setString(j++, ACC_NO_13);
		        grAdd.setString(j++, AMOUNT_13);
		        grAdd.setString(j++, DED_AMT_13);

		        grAdd.setString(j++, PEN_GUBUN_CD_14);
		        grAdd.setString(j++, ABA_CD_14);
		        grAdd.setString(j++, ABA_NM_14);
		        grAdd.setString(j++, ACC_NO_14);
		        grAdd.setString(j++, AMOUNT_14);
		        grAdd.setString(j++, DED_AMT_14);

		        grAdd.setString(j++, PEN_GUBUN_CD_15);
		        grAdd.setString(j++, ABA_CD_15);
		        grAdd.setString(j++, ABA_NM_15);
		        grAdd.setString(j++, ACC_NO_15);
		        grAdd.setString(j++, AMOUNT_15);
		        grAdd.setString(j++, DED_AMT_15);
		        
		        
 		    //System.out.println("-----------grAdd---------" +grAdd.getString(
 		    
 		    
		        dsResult.addDataRow(grAdd);


		        
	        }

	        //dvoList에 출력양식에 맞게 넣는다.
	        int NUM = 3;
	        StringBuffer sbNPN_NO = null;
	        DynamicValueObject dvo = null;

	        String NAME = "";
	        int LN_CNT1 = 0;
	        int LN_CNT2 = 0;
	        int LN_CNT3 = 0;

	        String TMP_YN1 = "";
	        String TMP_YN2 = "";
	        String TMP_YN3 = "";
	        String TMP_YN4 = "";
	        String TMP_YN5 = "";

	        for(i=1; i<=dsResult.getDataRowCnt(); i++){
	        	
	        	sbNPN_NO = new StringBuffer();
	        	
	        	dvo = new DynamicValueObject();

	        	//이름사이에 공백이 있으면 않된다.(전산매체양식 참조)
	        	if(GauceUtils.nameValue(dsResult, i, "NAM_KOR") != null){
	        		
	        		NAME = GauceUtils.nameValue(dsResult, i, "NAM_KOR").replaceAll(" ","");
	        		
	        	}

	        	
 		    //System.out.println("-----------REL_CD1---------" +dsResult.value);	        	
	        	
	        	
     		/**
     		 * 갑근 주(현)근무처 레코드
     		 */
	        	if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("C".toUpperCase())){
	        		LN_CNT1 = LN_CNT1 + 1;
	        		LN_CNT2 = 0;
	        		LN_CNT3 = 0;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CNT"),"0",2));//종(전)근무처 수
	        		sbNPN_NO.append("1");//거주자구분코드
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",2));//거주지국코드
           	    sbNPN_NO.append("2");//외국인단일세율적용
	        		sbNPN_NO.append(JSPUtil.byteRpad(NAME," ",30));//성명
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO").substring(6,7)) < 5 ){//내외국인 구분코드
	        	    	sbNPN_NO.append("1");
            		}else{
            			sbNPN_NO.append("9");
     		    }
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//주민등록번호
	        		
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO").substring(6,7)) < 5 ){
		        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",2)); //2010, 국적코드
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteRpad("CN"," ",2));//2010, 국적코드 
	        		}	        		
		    	    //System.out.println("-----------GauceUtils.nameValue---------"+GauceUtils.nameValue(dsResult, i, "HOL_YN"));	
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HOL_YN")," ",1));//2010, 세대주여부

	        		if(GauceUtils.nameValue(dsResult, i, "RET_YMD").equals("20141231") == true){
	        			sbNPN_NO.append("1"); //계속근로
	        		}
	        		else{
	        			sbNPN_NO.append("2"); //중도퇴직
	        		}
	        		
	        		//근무처별 소득명세- 주(현)근무처
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10)); //2010, 주현근무처-사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad("현대아산주식회사"," ",40)); //2010,주현근무처-근무처명
	        		
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HIR_YMD"),"0",8));//근무기간 시작연월일
	        		//sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5512111331019") == true){
	        			sbNPN_NO.append("20141231"); //근무기간 종료연월일
	        		}
	        		else{
		        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		}	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 종료연월일

	        		//근무처별 소득명세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTS"),"0",11));//급여총액
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//상여총액
	        		
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "OUTT_AMTS"),"0",11));//인정상여   	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//주식매수선택권행사이익

	        		/*
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){
	        			sbNPN_NO.append("00002306524"); //우리사주조합인출금
	        		}
	        		else{
		        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		}	
	        		*/    	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//임원 퇴직소득금액 한도초과액	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",22));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTT"),"0",11));//계

	        		//비과세소득
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세학자금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보수위원수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//경호·승선수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//유아·초중등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고등교육법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연구기관 등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//기업부설연구소
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//H14-보육교사 근무환경개선비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//H15-사립유치원 수석교사 교사의 인건비	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//취재수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//벽지수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//재해관련급여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//정부공공기관  지방이전기관 종사자 이주수당        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국정부등근무자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국주둔군인등
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SEA_FREE"),"0",10));//국외근로100만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로100만원        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로300만원 
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//야간근로수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//출산보육수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//근로장학금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주식매수선택권
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국인기술자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금50%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금75%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//장기미취업자중소기업 취업
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//해저광물자원개발
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//전공의 수련 보조수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//중소기업취업 청년 소득세 감면    		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약상 교직자 감면 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SEA_FREE"),"0",10));//비과세 계
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //감면소득계

	        		//정산명세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TAX_INCOME"),"0",11));//총급여     		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MGR_AMT"),"0",10));//근로소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MNI_AMT"),"0",11));//근로소득금액

	        		//기본공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "BADD_AMT"),"0",8));//본인공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SPSB_AMT"),"0",8));//배우자공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DFM_CNT"),"0",2));//부양가족공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GDED_AMT"),"0",8));//부양가족공제금액

	        		//추가공제
	         		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOL_CNT"),"0",2));//경로우대공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOL_AMT"),"0",8));//경로우대공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TRB_CNT"),"0",2));//장애인공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TBL_DED"),"0",8));//장애인공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "WDD_AMT"),"0",8));//부녀자공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ONE_AMT"),"0",10));//한부모 가족 공제금액	        		

	        		
	        		//연금보험료공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "NPEN_DED"),"0",10));//국민연금보험료공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(공무원)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(군인)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(교직원)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(우체국)

	        		//특별공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HINU_AMT"),"0",10)); //건강보험료
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HINS_AMT"),"0",10)); //고용보험료
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH1_AMT"),"0",8));//주택임차차입금원리금상환액_대출기관	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH2_AMT"),"0",8));//주택임차차입금원리금상환액_거주자
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH3_AMT"),"0",8)); //주택자금_월세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH4_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년미만	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7612201106214") == true){	     
	        			sbNPN_NO.append("01150760"); //(2012년 이후 차입분)고정금리비거치상환 대출      			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH5_AMT"),"0",8));	//주택자금_장기주택저당차입금이자상환액_15년~29년	     		
	        		}	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH5_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년~29년		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH6_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_30년이상	 	
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7612201106214") == true){	     
	        			sbNPN_NO.append("01248553"); //(2012년 이후 차입분)고정금리비거치상환 대출      			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH7_AMT"),"0",8));	//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)고정금리비거치상환 대출      		
	        		}		        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH7_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)고정금리비거치상환 대출 		      
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH8_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)기타 대출	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DON_FWD"),"0",11));//기부금이월분		        		
	        		
	        		/*
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6811231055111") == true){	     
	        			sbNPN_NO.append("03535380"); //주택자금_장기주택저당차입금이자상환액_15년~29년	        		
	        		}else{
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG2_DED"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년~29년
	        			
	        		}	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("7412201347528") == true){	     
	        			sbNPN_NO.append("02011308"); //주택자금_장기주택저당차입금이자상환액_30년이상
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6909141011113") == true){	    	        			
	        			sbNPN_NO.append("02278368"); //주택자금_장기주택저당차입금이자상환액_30년이상	        			
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG3_DED"),"0",8));//주택자금_장기주택저당차입금이자상환액_30년이상	        		
	        		}	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("7412201347528") == true){	     
	        			sbNPN_NO.append("06655992"); //(2012년 이후 차입분)고정금리비거치상환 대출
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6909141011113") == true){	    	        			
	        			sbNPN_NO.append("01617866"); //(2012년 이후 차입분)고정금리비거치상환 대출 	      
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6811231055111") == true){	    	        			
	        			sbNPN_NO.append("00372857"); //(2012년 이후 차입분)고정금리비거치상환 대출	        			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG4_DED"),"0",8));	//(2012년 이후 차입분)고정금리비거치상환 대출        		
	        		}
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG5_DED"),"0",8));//(2012년 이후 차입분)기타 대출
	        		*/
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DON_FWD"),"0",11));  //기부금 이월분        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",20));//공란	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "VEN_DED"),"0",11));//특별소득공제계     		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INDED_TOT"),"0",11));//차감소득금액	        		
	        		
	        		//그 밖의 소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PER_DED"),"0",8));//개인연금저축소득공제	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소기업공제부금소득공제	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE1_DED"),"0",10)); //주택마련저축소득공제_청약저축
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE2_DED"),"0",10)); //주택마련저축소득공제_주택청약종합저축
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE3_DED"),"0",10)); //주택마련저축소득공제_근로자주택마련저축	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//투자좋합출자등소득공제	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_DED"),"0",8));//신용카드등소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAJU_AMT"),"0",10));//우리사주조합 출연금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합 기부금    		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고용유지중소기업근로자소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//목돈안드는전세이자상환액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LSS_AMT"),"0",10));//장기집합투자증권저축        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ETC_TOT"),"0",11));//그 밖의 소득공제계	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//소득공제종합한도 초과액  		  		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TTAX_STD"),"0",11));//종합소득 과세표준
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TAX_AMT"),"0",10));//산출세액	        		
	        		
	        		//세액감면
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소득세법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조특법(-1 제외)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조특법 제30조	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//세액감면계	
	        		
	        		//세액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HGR_DED"),"0",10));//근로소득세액공제
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CHI_CNT"),"0",2));//자녀수        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AGE_AMT"),"0",10));//자녀세액공제 
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CHI_RCH"),"0",2));//6세이하자녀수 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AGE_RCH"),"0",10));//6세이하자녀공제        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CHI_INP"),"0",2));//출생입양자녀수 
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AGE_INP"),"0",10));//출생입양자녀수공제 	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_과학기술인공제_공제대상금액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_과학기술인공제_세액공제액  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_근로자퇴직급여보장법에따른 퇴직급여_공제대상금액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_근로자퇴직급여보장법에따른 퇴직급여_세액공제액
	        		  		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ANN_AMT"),"0",10));//연금계좌_연금저축_공제대상금액   
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ANN_DED"),"0",10));//연금계좌_연금저축_세액공제액    		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LIN_AMT"),"0",10));  //특별세액공제_보장성보험료_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MIN_DED"),"0",10));  //특별세액공제_보장성보험료_세액공제액
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별세액공제_장애인 전용보험료_공제대상금액   		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별세액공제_장애인 전용보험료_세액공제액
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "MMA_DED").equals("0") == true){	     
	        			sbNPN_NO.append("0000000000"); //특별세액공제_의료비_공제대상금액            			
	        		}else{	        		
	        			//sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REC_TAX")) * -1),"0",10));
	        			sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "MMA_DED"))  *100 /15 ),"0",10));//특별세액공제_의료비_공제대상금액       		
	        		}	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MMA_AMT"),"0",10));//특별세액공제_의료비_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MMA_DED"),"0",10));//특별세액공제_의료비_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT"),"0",10));//특별세액공제_교육비_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_DED"),"0",10));//특별세액공제_교육비_세액공제액	
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5206111068514") == true){	     
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701071553212") == true){	    	        			
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액        
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6904301380532") == true){	    	        			
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액            			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_AMT"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_공제대상금액       		
	        		}	        		
	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_AMT"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_DED"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV2_AMT"),"0",11));//특별세액공제_기부금_정치자금_10만원초과_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV2_DED"),"0",10));//특별세액공제_기부금_정치자금_10만원초과_세액공제액	
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC1_AMT"),"0",11));//특별세액공제_기부금_법정기부금_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC1_DED"),"0",10));//특별세액공제_기부금_법정기부금_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC23_AMT"),"0",11));//특별세액공제_기부금_지정기부금_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC23_DED"),"0",10));//특별세액공제_기부금_지정기부금_세액공제액      		

	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "NSE_TOT"),"0",10));//특별세액공제계
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "STA_TOT"),"0",10));//표준세액공제
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//납세조합공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주택차입금   		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국납부        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MRENT_DED"),"0",10));//월세 세액공제	        
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TDED_TOT"),"0",10));//세액공제계	        		

	        		//결정세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DGG_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DJM_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DBW_TAX"),"0",10));//농특세

	        		//기납부세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INCM_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CITI_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//농특세	        		
	        		
	        		//납부특례세액
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//농특세	 	        		
	        		
	        		
	        		//차감징수세액
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REA_TAX")) < 0 ) {//소득세
		        		   sbNPN_NO.append("1");
	       			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REA_TAX"))	* -1),"0",10));
		        		}
		        		else {
		        		   sbNPN_NO.append("0");
		        		   sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "REA_TAX"),"0",10));
		             	}

		        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REB_TAX")) < 0 ) {//지방소득세
			        	   sbNPN_NO.append("1");
		      			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REB_TAX"))	* -1),"0",10));
		        	    }
		        		else {
		        	    	sbNPN_NO.append("0");
		        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "REB_TAX"),"0",10));
		        		}


		        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REC_TAX")) < 0 ) {//농특세
			        		sbNPN_NO.append("1");
			      			sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "REC_TAX")) * -1),"0",10));
		        		}
		        		else {
		        			sbNPN_NO.append("0");
		        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "REC_TAX"),"0",10));
		        		}	    
		        		/*	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "REA_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "REB_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "REC_TAX"),"0",10));//	        		
	        		
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_INTX")) < 0 ) {//소득세
	        		   sbNPN_NO.append("1");
       			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_INTX"))	* -1),"0",10));
	        		}
	        		else {
	        		   sbNPN_NO.append("0");
	        		   sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_INTX"),"0",10));
	             	}

	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_CTTX")) < 0 ) {//지방소득세
		        	   sbNPN_NO.append("1");
	      			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_CTTX"))	* -1),"0",10));
	        	    }
	        		else {
	        	    	sbNPN_NO.append("0");
	        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_CTTX"),"0",10));
	        		}


	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_DFTX")) < 0 ) {//농특세
		        		sbNPN_NO.append("1");
		      			sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_DFTX")) * -1),"0",10));
	        		}
	        		else {
	        			sbNPN_NO.append("0");
	        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_DFTX"),"0",10));
	        		}
	        		 */
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",28));	        		
	        		
	        		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	        		
	        		
     		/**
     		 * 갑근 종(전)소득 발생처 레코드
     		 */
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("D".toUpperCase())){
	        		LN_CNT2 = LN_CNT2 + 1;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));//레코드 구분
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));//자료구분+세무서
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));//일련번호

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));//사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",50));//공란

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//소득자주민등록번호

	        		//종(전)근무처	        		
	        		sbNPN_NO.append("2");//2010,납세조합구분, 재경부 문의 확인
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "JAS_NM")," ",40));//법인명(상호)
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "JAO_NO")," ",10));//사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HIR_YMD"),"0",8));//근무기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 종료연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTS"),"0",11));//급여총액
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7606271697813") == true){	     
	        			sbNPN_NO.append("00000750000"); //상여총액    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8104272006217") == true){	    	        			
	        			sbNPN_NO.append("00001000000"); //상여총액        
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7507091227217") == true){	    	        			
	        			sbNPN_NO.append("00001351900"); //상여총액         
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	    	        			
	        			sbNPN_NO.append("00043392600"); //상여총액   	        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAC_AMT"),"0",11));//상여총액		
	        		}		        		
	        		  		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//인정상여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//주식매수선택권행사이익
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	     
	        			sbNPN_NO.append("00002306524"); //우리사주조합인출금        		
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		}	  	        		

	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//임원 퇴직소득금액 한도초과액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",22));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTT"),"0",11));//계

	        		//종전근무지 비과세소득
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세학자금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//무보수위원수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//경호·승선수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//유아·초중등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고등교육법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연구기관 등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//기업부설연구소
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보육교사  근무환경개선비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//사립유치원수석교사교사의 인건비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//취재수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//벽지수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//재해관련급여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//정부공공기관지방이전기관 종사자 이주수당        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국정부등근무자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국주둔군인등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로100만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로300만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로

	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAG_AMT"),"0",10));//야간근로수당 비과세 뭐는 하나 들어가야해서
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//야간근로수당 비과세 뭐는 하나 들어가야해서
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//출산보육수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//근로장학금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주식매수선택권
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국인기술자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금50%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금75%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//장기미취업자중소기업 취업
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//해저광물자원개발
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//전공의 수련 보조수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//중소기업취업 청년 소득세 감면
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약상 교직자 감면      
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAG_AMT"),"0",10));//비과세 계
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세 계
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 감면소득계

	        		//기납부세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INCM_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CITI_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//종근무지 기납부 농특세 (자료 확인요망)
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT2),"0",2));//종(전)근무처일련번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",951));


	        		/**
	        		 * 소득공제명세 레코드
	        		 */
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("E".toUpperCase())){
	        		/*
	    		    System.out.println("-----------REL_CD1---------" +GauceUtils.nameValue(dsResult, i, "REL_CD1"));		        		
	    		    System.out.println("-----------NAM_KOR1---------" +GauceUtils.nameValue(dsResult, i, "NAM_KOR1"));	        		
	    		    System.out.println("-----------CET_NO1---------" +GauceUtils.nameValue(dsResult, i, "CET_NO1"));	    		    
	    		    System.out.println("-----------BAS_MAN1---------" +GauceUtils.nameValue(dsResult, i, "BAS_MAN1"));	        		
	    		    System.out.println("-----------TRB_MAN1---------" +GauceUtils.nameValue(dsResult, i, "TRB_MAN1"));	   	    		    
	        		 */
	    		    

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO1") == null || GauceUtils.nameValue(dsResult, i, "CET_NO1").trim().equals("")){
	        			TMP_YN1 = " ";
	        		}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO1").substring(6,7)) < 5 ){
	        			TMP_YN1 = "1";
	        		//}else{
	        		//	TMP_YN1 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2") == null || GauceUtils.nameValue(dsResult, i, "CET_NO2").trim().equals("")){
	        			TMP_YN2 = " ";
	        		}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO2").substring(6,7)) < 5 ){
	        			TMP_YN2 = "1";
	        		//}else{
	        		//	TMP_YN2 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO3") == null || GauceUtils.nameValue(dsResult, i, "CET_NO3").trim().equals("")){
	        			TMP_YN3 = " ";
	        		}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO3").substring(6,7)) < 5 ){
	        			TMP_YN3 = "1";
	        		//}else{
	        		//	TMP_YN3 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO4") == null || GauceUtils.nameValue(dsResult, i, "CET_NO4").trim().equals("")){
	        			TMP_YN4 = " ";
	        		}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO4").substring(6,7)) < 5 ){
	        			TMP_YN4 = "1";
	        		//}else{
	        		//	TMP_YN4 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO5") == null || GauceUtils.nameValue(dsResult, i, "CET_NO5").trim().equals("")){
	        			TMP_YN5 = " ";
	        		}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO5").substring(6,7)) < 5 ){
	        			TMP_YN5 = "1";
	        		//}else{
	        		//	TMP_YN5 = "1";
	        		}

	    		    /*	        		
	        		//if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("8702096780193") == true){	     
	        		//	TMP_YN1 = "9";
	        		//}      		
	        		//System.out.println("NPN_NO : "+sbNPN_NO.toString());		
	        		*/
	        		
	        		//TMP_YN1 = "1";
	        		//TMP_YN2 = "1";
	        		//TMP_YN3 = "1";
	        		//TMP_YN4 = "1";
	        		//TMP_YN5 = "1";
	        		
	        		LN_CNT3 = LN_CNT3 + 1;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));//레코드 구분
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));//자료구분+세무서
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));//일련번호

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));//사업자등록번호

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//소득자 주민등록번호

	        		//소득공제명세1의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD1")," ",1));//관계1
	        		sbNPN_NO.append(TMP_YN1);//내외국인구분코드1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR1")," ",20));//성명1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO1")," ",13));//주민등록번호1		
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN1")," ",1));//기본공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN1")," ",1));//장애인공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN1")," ",1));//부녀자공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN1")," ",1));//경로우대공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN1")," ",1));//한부모1              	
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "INP_MAN1")," ",1));//출산입양1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RCH_MAN1")," ",1));//6세이하1  
	        		
	        		//소득공제명세1의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS1"),"0",10));//보험료1_건강고용보험
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS1"),"0",10));//보험료1_보장성	  
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS1"),"0",10));//의료비1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS1"),"0",10));//교육비1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS1"),"0",10));//신용카드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS1"),"0",10));//직불선불카드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS1"),"0",10));//현금영수증1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS1"),"0",10));//전통시장사용액1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS1"),"0",10));//대중교통이용액1	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS1"),"0",13));//기부금1

	        		//소득공제명세1의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT1"),"0",10));//보험료1 외_건강고용보험
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT1"),"0",10));//보험료1 외_보장성
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT1"),"0",10));//의료비1 외        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT1"),"0",10));//교육비1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT1"),"0",10));//신용카드1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT1"),"0",10));//직불선불카드1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT1"),"0",10));//전통시장 사용액1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT1"),"0",10));//대중교통이용액1	 외	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT1"),"0",13));//기부금1 외

	        		//소득공제명세2의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD2")," ",1));//관계2
	        		sbNPN_NO.append(TMP_YN2);//내외국인구분코드2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR2")," ",20));//성명2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO2")," ",13));//주민등록번호2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN2")," ",1));//한부모2     
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "INP_MAN2")," ",1));//출산입양2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RCH_MAN2")," ",1));//6세이하2               	
	        		
	        		//소득공제명세2의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS2"),"0",10));//신용카드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS2"),"0",10));//직불선불카드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS2"),"0",10));//현금영수증2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS2"),"0",10));//전통시장사용액2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS2"),"0",10));//대중교통이용액2 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS2"),"0",13));//기부금2


	        		//소득공제명세2의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT2"),"0",10));	
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT2"),"0",10));//전통시장 사용액2 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT2"),"0",10));//대중교통이용액2	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT2"),"0",13));

	        		//소득공제명세3의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD3")," ",1));
	        		sbNPN_NO.append(TMP_YN3);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR3")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO3")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN3")," ",1));//한부모3   
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "INP_MAN3")," ",1));//출산입양3
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RCH_MAN3")," ",1));//6세이하3               	
	        		
	        		//소득공제명세3의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS3"),"0",10));//전통시장사용액3	  
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS3"),"0",10));//대중교통이용액3		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS3"),"0",13));

	        		//소득공제명세3의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT3"),"0",10));	 
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT3"),"0",10));//전통시장 사용액3 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT3"),"0",10));//대중교통이용액3	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT3"),"0",13));

	        		//소득공제명세4의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD4")," ",1));
	        		sbNPN_NO.append(TMP_YN4);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR4")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO4")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN4")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN4")," ",1));//장애인공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN4")," ",1));//부녀자공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN4")," ",1));//경로우대공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN4")," ",1));//한부모4   
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "INP_MAN4")," ",1));//출산입양4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RCH_MAN4")," ",1));//6세이하4               	
	        		
	        		//소득공제명세4의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS4"),"0",10));//보험료4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS4"),"0",10));//보험료4	 
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS4"),"0",10));//의료비4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS4"),"0",10));//교육비4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS4"),"0",10));//신용카드4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS4"),"0",10));//직불선불카드4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS4"),"0",10));//현금영수증4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS4"),"0",10));//전통시장사용액4	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS4"),"0",10));//대중교통이용액4	  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS4"),"0",13));//기부금4

	        		//소득공제명세4의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT4"),"0",10));	  
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT4"),"0",10));//전통시장 사용액4 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT4"),"0",10));//대중교통이용액4	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT4"),"0",13));//기부금4외

    		
	        		
	        		//소득공제명세5의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD5")," ",1));
	        		sbNPN_NO.append(TMP_YN5);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR5")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO5")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN5")," ",1));//한부모5   
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "INP_MAN5")," ",1));//출산입양5
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RCH_MAN5")," ",1));//6세이하5  	 
	        		
	        		//소득공제명세5의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS5"),"0",10));	  
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS5"),"0",10));//전통시장사용액5
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS5"),"0",10));//대중교통이용액5  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS5"),"0",13));//기부금5

	        		//소득공제명세5의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT5"),"0",10));        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT5"),"0",10));	    
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보험료1_장애인 전용 보장성		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT5"),"0",10));//전통시장 사용액5 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT5"),"0",10));//대중교통이용액5	 외	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT5"),"0",13));//기부금5외
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT3),"0",2));
	        		
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",253));
	        		//System.out.println("NPN_NO : "+sbNPN_NO.toString());	
	        		
	        		
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("F".toUpperCase())){

	        		
	        		
	        		
	        		
	        		
	        		
	        		

	        		
	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_1")," ",2));//소득공제구분1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_1")," ",3));//금융기관코드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_1")," ",50));//금융기관상호1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_1")," ",20));//계좌번호(또는 증권번호)	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_1"),"0",10));//납입금액1
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6510151683513") == true){	     //권기환
	        			sbNPN_NO.append("0000336000"); //납입금액1    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6511161785941") == true){	  //최규훈  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액1   	        	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5811151659025") == true){	  //정종국  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액1 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7006171037719") == true){	  //소병진  	        			
	        			sbNPN_NO.append("0000432000"); //납입금액1 	        			
	        		//}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7907191095519") == true){	   //김상수 	        			
	        		//	sbNPN_NO.append("0000540000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6711291790211") == true){	   //이종훈	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1         		
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6708301822513") == true){	    //정성학	        			
	        			sbNPN_NO.append("0000144000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7110041836316") == true){	    //이만재	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	    //이영하 	        			
	        			sbNPN_NO.append("0000096000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8209072177411") == true){	   //이래경 	        			
	        			sbNPN_NO.append("0000126000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7211291535932") == true){	  //이석재  	        			
	        			sbNPN_NO.append("0000396000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7409041810118") == true){	  //박제성 	        			
	        			sbNPN_NO.append("0000364800"); //납입금액1   		        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	  //김종학   	        			
	        			sbNPN_NO.append("0000360000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	  //김창기 	        			
	        			sbNPN_NO.append("0000450000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	   //김안수 	        			
	        			sbNPN_NO.append("0000288000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	  //김태현  	        			
	        			sbNPN_NO.append("0000144000"); //납입금액1   	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	  //김영수  	        			
	        			sbNPN_NO.append("0000288000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	   //권헌영 	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1   	        			        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_1"),"0",10));//소득, 세액공제금액1
	        		}			        		
	        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_2")," ",2));//소득공제구분2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_2")," ",3));//금융기관코드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_2")," ",50));//금융기관상호2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_2")," ",20));//계좌번호(또는 증권번호)2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_2"),"0",10));//납입금액2	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6510151683513") == true){	    	//권기환 
	        			sbNPN_NO.append("0000144000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6511161785941") == true){	  //최규훈  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액2   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5811151659025") == true){	  //정종국  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액2	   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7006171037719") == true){	  //소병진  	        			
	        			sbNPN_NO.append("0000048000"); //납입금액2	     	        			
	        		//}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7907191095519") == true){	 //김상수   	        			
	        		//	sbNPN_NO.append("0000060000"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6711291790211") == true){	  //이종훈  	        			
	        			sbNPN_NO.append("0000364800"); //납입금액2         		
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6708301822513") == true){	  //정성학	   	      	
	        			sbNPN_NO.append("0000336000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7110041836316") == true){	  //이만재  	        			
	        			sbNPN_NO.append("0000364800"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	  //이영하  	        			
	        			sbNPN_NO.append("0000384000"); //납입금액2  	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8209072177411") == true){	  //이래경 	        			
	        			sbNPN_NO.append("0000474000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7409041810118") == true){	 //박제성    	        			
	        			sbNPN_NO.append("0000115200"); //납입금액2  		        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	 //김종학   	        			
	        			sbNPN_NO.append("0000120000"); //납입금액2 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	 //김창기   	        			
	        			sbNPN_NO.append("0000030000"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	 //김안수   	        			
	        			sbNPN_NO.append("0000144000"); //납입금액2 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	 //김태현   	        			
	        			sbNPN_NO.append("0000015000"); //납입금액2 		        	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	//김영수    	        			
	        			sbNPN_NO.append("0000144000"); //납입금액2  
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	 //권헌영   	        			
	        			sbNPN_NO.append("0000072000"); //납입금액2   	        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_2"),"0",10));
	        		}			        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_3")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_3")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_3")," ",50));//금융기관상호3
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_3")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_3"),"0",10));//납입금액3
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	 //김영수
	        			sbNPN_NO.append("0000048000"); //납입금액3   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	  //김종학   	        			
	        			sbNPN_NO.append("0000000000"); //납입금액3 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	  //김창기  	        			
	        			sbNPN_NO.append("0000000000"); //납입금액3
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	   //김안수 	        			
	        			sbNPN_NO.append("0000048000"); //납입금액3 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	   //김태현 	        			
	        			sbNPN_NO.append("0000441000"); //납입금액3			        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	  //권헌영   	        			
	        			sbNPN_NO.append("0000144000"); //납입금액3 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7211291535932") == true){	 //이석재   	        			
	        			sbNPN_NO.append("0000084000"); //납입금액3	        				        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_3"),"0",10));
	        		}			        		
	        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_4")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_4")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_4")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_4")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_4"),"0",10));//납입금액3	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	 //김영수
	        			sbNPN_NO.append("0000000000"); //납입금액4  
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	    //권헌영	        			
	        			sbNPN_NO.append("0000148800"); //납입금액4          			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_4"),"0",10));
	        		}			


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_5")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_5")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_5")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_5")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_5"),"0",10));//납입금액5	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	 //권헌영
	        			sbNPN_NO.append("0000000000"); //납입금액5  
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_5"),"0",10));
	        		}		



	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_6")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_6")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_6")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_6")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_6"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_6"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_7")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_7")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_7")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_7")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_7"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_7"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_8")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_8")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_8")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_8")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_8"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_8"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_9")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_9")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_9")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_9")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_9"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_9"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_10")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_10")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_10")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_10")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_10"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_10"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_11")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_11")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_11")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_11")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_11"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_11"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_12")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_12")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_12")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_12")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_12"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_12"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_13")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_13")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_13")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_13")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_13"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_13"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_14")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_14")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_14")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_14")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_14"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_14"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_15")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_15")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_15")," ",50));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_15")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_15"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_15"),"0",10));

	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",120));
	        	}

	        	//System.out.println("NUM : "+Integer.toString(NUM++));
	        	//System.out.println("NPN_NO : "+sbNPN_NO.toString());

		        dvo.set("NUM", Integer.toString(NUM++));
		        dvo.set("NPN_NO", sbNPN_NO.toString());
		        dvoList.add(dvo);
	        }

     }

     return dvoList;
 }	 
	 
	 
	 
	 
	/**
     * 의료비
     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
     * @param p_box
     * @return
     * @throws CException
     */
    public DynamicValueObject YACA001_SHR_FILE_02(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
    	YACA001DAO dao = new YACA001DAO("default");

        return dao.YACA001_SHR_FILE_02(p_box);
    }
    
	/**
     * 의료비
     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
     * @param p_box
     * @return
     * @throws CException
     */
    public DynamicValueObject YACA001_SHR_FILE_02_142(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
    	YACA001DAO dao = new YACA001DAO("default");

        return dao.YACA001_SHR_FILE_02_142(p_box);
    }    
    
	/**
     * 기부금
     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
     * @param p_box
     * @return
     * @throws CException
     */
    public DynamicValueObject YACA001_SHR_FILE_03(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
    	YACA001DAO dao = new YACA001DAO("default");

        return dao.YACA001_SHR_FILE_03(p_box);
    }    
	
    public DynamicValueObject YACA001_SHR_FILE_01_15(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		YACA001DAO dao = new YACA001DAO("default");

		DynamicValueObject dvoList = dao.YACA001_SHR_FILE_15_AB(p_box); // A, B만 만들고 C,D,E,F,G는 밑에서 부터 다시 만든다.

		//커넥션이 끊겨서 다시 연결해준다. 문의 해야함.
		dao.close();
			
		dao = new YACA001DAO("default");

		GauceDataSet dsYACA001_SHR_15 = dao.YACA001_SHR_FILE_15_ETC(p_box);		

	    //System.out.println("-----------111111111111111111---------");		
		
		GauceDataSet dsResult = new GauceDataSet();
		
		dsResult.addDataColumn(new GauceDataColumn("REC_TAG", GauceDataColumn.TB_STRING ));

		dsResult.addDataColumn(new GauceDataColumn("TAX_CD", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("COMP_CD", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CNT", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ZIP_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JUSO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JAS_NM", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("JAO_NO", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("SALT_AMTS", GauceDataColumn.TB_DECIMAL, 10, 0));

		//dsResult.addDataColumn(new GauceDataColumn("SALT_AMTB", GauceDataColumn.TB_DECIMAL, 10, 0));
		//dsResult.addDataColumn(new GauceDataColumn("JAI_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("SALT_AMTT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("FREE_INCOME", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TAX_INCOME", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("OUTT_AMTS", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MGR_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MNI_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("BADD_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SOU_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("SPSB_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DFM_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GDED_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOL_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOL_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TRB_CNT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TBL_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("WDD_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("ONE_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("HINU_AMT", GauceDataColumn.TB_DECIMAL, 10, 0)); 
		dsResult.addDataColumn(new GauceDataColumn("HINS_AMT", GauceDataColumn.TB_DECIMAL, 10, 0)); 

		dsResult.addDataColumn(new GauceDataColumn("LH1_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH2_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH3_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH4_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH5_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH6_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH7_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LH8_AMT",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DON_FWD",GauceDataColumn.TB_DECIMAL, 10, 0));	
		dsResult.addDataColumn(new GauceDataColumn("PER_DED",GauceDataColumn.TB_DECIMAL, 10, 0));			
		

		
		dsResult.addDataColumn(new GauceDataColumn("CPC_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("NSE_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INDED_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));

		dsResult.addDataColumn(new GauceDataColumn("CARD_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SAVE_DED",GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("SAVE1_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("SAVE2_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("SAVE3_DED",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		
		dsResult.addDataColumn(new GauceDataColumn("SAJU_AMT",GauceDataColumn.TB_DECIMAL, 10, 0)); //
		dsResult.addDataColumn(new GauceDataColumn("LSS_AMT",GauceDataColumn.TB_DECIMAL, 10, 0)); //		
		dsResult.addDataColumn(new GauceDataColumn("ETC_TOT",GauceDataColumn.TB_DECIMAL, 11, 0)); //	

		dsResult.addDataColumn(new GauceDataColumn("VEN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TTAX_STD", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("TAX_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HGR_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("AGE_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));	
		
		dsResult.addDataColumn(new GauceDataColumn("ANN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("ANN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LIN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MIN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("MMA_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MMA_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("EDU_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("GOV1_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV1_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV2_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("GOV2_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("LC1_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("LC1_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("LC23_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("LC23_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		

		dsResult.addDataColumn(new GauceDataColumn("MRENT_DED", GauceDataColumn.TB_DECIMAL, 10, 0));		
		
		dsResult.addDataColumn(new GauceDataColumn("TDED_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DGG_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DBW_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DJM_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAL_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAC_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("JAN_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INCM_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CITI_TAX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HIR_YMD", GauceDataColumn.TB_DECIMAL, 8, 0));
		dsResult.addDataColumn(new GauceDataColumn("RET_YMD", GauceDataColumn.TB_DECIMAL, 8, 0));
		dsResult.addDataColumn(new GauceDataColumn("STA_TOT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("NPEN_DED", GauceDataColumn.TB_DECIMAL, 10, 0));

		dsResult.addDataColumn(new GauceDataColumn("SEA_FREE", GauceDataColumn.TB_DECIMAL, 10, 0));
		

		
		dsResult.addDataColumn(new GauceDataColumn("GOV_DED", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("OTX_DED", GauceDataColumn.TB_DECIMAL, 10, 0));

		
		dsResult.addDataColumn(new GauceDataColumn("CASH_AMT", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DRE_INTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DRE_CTTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DRE_DFTX", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("HOL_YN", GauceDataColumn.TB_DECIMAL, 1, 0));
		
		
		
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN1", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT1", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN2", GauceDataColumn.TB_STRING ));		
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT2", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN3", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));					
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT3", GauceDataColumn.TB_DECIMAL, 10, 0));
		

		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN4", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT4", GauceDataColumn.TB_DECIMAL, 10, 0));
		
		
		dsResult.addDataColumn(new GauceDataColumn("REL_CD5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("NAM_KOR5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("CET_NO5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("BAS_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("TRB_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("WCT_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("GOL_MAN5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ONE_MAN5", GauceDataColumn.TB_STRING ));			
		dsResult.addDataColumn(new GauceDataColumn("INV_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CASH_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));				
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT_NTS5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("INV2_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));		
		dsResult.addDataColumn(new GauceDataColumn("MED_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("EDU_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("CARD_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("DIR_CARD_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("MARKET_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));
		dsResult.addDataColumn(new GauceDataColumn("PUBLIC_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));			
		dsResult.addDataColumn(new GauceDataColumn("LC3_AMT5", GauceDataColumn.TB_DECIMAL, 10, 0));

		//dsResult.addDataColumn(new GauceDataColumn("BASE_VAL1", GauceDataColumn.TB_STRING ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_1", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_1", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_1", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_2", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_2", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_2", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_3", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_3", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_3", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_4", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_4", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_4", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_5", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_5", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_5", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_6", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_6", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_6", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_7", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_7", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_7", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_8", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_8", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_8", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_9", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_9", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_9", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_10", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_10", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_10", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_11", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_11", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_11", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_12", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_12", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_12", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_13", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_13", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_13", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_14", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_14", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_14", GauceDataColumn.TB_DECIMAL ));
		
		dsResult.addDataColumn(new GauceDataColumn("PEN_GUBUN_CD_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_CD_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ABA_NM_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("ACC_NO_15", GauceDataColumn.TB_STRING ));
		dsResult.addDataColumn(new GauceDataColumn("AMOUNT_15", GauceDataColumn.TB_DECIMAL ));
		dsResult.addDataColumn(new GauceDataColumn("DED_AMT_15", GauceDataColumn.TB_DECIMAL ));

			
		
        if(dsYACA001_SHR_15.getDataRowCnt() > 0){

        	int i=0;
        	int j=0;

			GauceDataRow grAdd  = null; // 추가될 row

			String YAC_SEL_KEY = "";                                                      
			String YAC_REC_TAG = "";                                                     
			String YAC_TAX_CD  = "";                                                      
			String YAC_COMP_CD = "";                                                    
			String YAC_CNT     = "";                                                         
			String YAC_NAM_KOR = "";                                                    
			String YAC_CET_NO  = "";                                                      
			String YAC_ZIP_NO  = "";                                                       
			String YAC_JUSO    = "";                                                        
			String YAC_JAS_NM  = "";                                                      
			String YAC_JAO_NO  = "";                                                      
			String YAC_SALT_AMTS  = "";                                                
			String YAC_SALT_AMTT  = "";                                                 
			String YAC_FREE_INCOME  = "";                                             
			String YAC_TAX_INCOME = "";                                               
			String YAC_OUTT_AMTS = "";	                                             
			String YAC_MGR_AMT = "";                                                    
			String YAC_MNI_AMT = "";                                                     
			String YAC_BADD_AMT   = "";                                                
			String YAC_SOU_CNT = "";                                                    
			String YAC_SPSB_AMT   = "";                                                 
			String YAC_DFM_CNT = "";                                                    
			String YAC_GDED_AMT   = "";                                                
			String YAC_GOL_CNT = "";                                                     
			String YAC_GOL_AMT = "";                                                    
                                         
			String YAC_TRB_CNT = "";                                                     
			String YAC_TBL_DED = "";                                                      
			String YAC_WDD_AMT = "";                                                                                                       
			String YAC_ONE_AMT = "";	   
			
                                                  
			String YAC_HINU_AMT = "";                                 
			String YAC_HINS_AMT = "";      
                                                
			String YAC_LH1_AMT = "";                                                   
			String YAC_LH2_AMT = "";                                                 
			String YAC_LH3_AMT = "";                                 
			String YAC_LH4_AMT = "";                                                
			String YAC_LH5_AMT = "";                                                
			String YAC_LH6_AMT = "";                                                
			String YAC_LH7_AMT = "";                                                
			String YAC_LH8_AMT = "";	
			String YAC_DON_FWD = "";	
			String YAC_PER_DED = "";			
                                              
			String YAC_CPC_DED = "";                                                     
			String YAC_NSE_TOT = "";                                                     
			String YAC_INDED_TOT  = "";                                                 
			String YAC_CARD_DED   = "";                                                 
			String YAC_SAVE_DED = "";                                                   
			String YAC_SAVE1_DED = "";                                    
			String YAC_SAVE2_DED = "";                                     
			String YAC_SAVE3_DED = "";     
			String YAC_SAJU_AMT = "";                                      
			String YAC_LSS_AMT = "";  			
			String YAC_ETC_TOT = ""; 	
			String YAC_VEN_DED = "";                                                     
			String YAC_TTAX_STD   = "";                                                  
			String YAC_TAX_AMT = "";                                                     
			String YAC_HGR_DED = "";  
			String YAC_AGE_AMT = "";  	
			
			String YAC_ANN_AMT   = "";                                                  
			String YAC_ANN_DED = "";                                                     
			String YAC_LIN_AMT = "";  
			String YAC_MIN_DED = "";  		
                       
			String YAC_MMA_AMT = "";	                                             
			String YAC_MMA_DED = "";                                                    
			String YAC_EDU_AMT = "";	                                             
			String YAC_EDU_DED = "";     
				
			String YAC_GOV1_AMT   = "";                                                  
			String YAC_GOV1_DED = "";                                                     
			String YAC_GOV2_AMT = "";  
			String YAC_GOV2_DED = "";  		
                       
			String YAC_LC1_AMT = "";	                                             
			String YAC_LC1_DED = "";                                                    
			String YAC_LC23_AMT = "";	                                             
			String YAC_LC23_DED = "";    	
			
			String YAC_MRENT_DED = ""; 			
			
			String YAC_TDED_TOT   = "";                                                 
			String YAC_DGG_TAX = "";                                                    
			String YAC_DBW_TAX = "";                                                    
			String YAC_DJM_TAX = "";                                                     
			String YAC_JAL_AMT = "";                                                      
			String YAC_JAC_AMT = "";                                                     
			String YAC_JAN_AMT = "";                                                     
			String YAC_INCM_TAX   = "";                                                 
			String YAC_CITI_TAX   = "";                                                   
			String EMS_HIR_YMD = "";                                                     
			String EMS_RET_YMD = "";                                                     
			String YAC_STA_TOT = "";                                                     
			String YAC_NPEN_DED   = "";                                                 
                                                   
			String YAC_SEA_FREE   = "";                                                  
			String YAC_GOV_DED = "";                                                    
			String YAC_OTX_DED = "";                                                     
			String YAC_CASH_AMT= "";                                                                                                      
			String YAC_DRE_INTX = "";                                                    
			String YAC_DRE_CTTX = "";                                                   
			String YAC_DRE_DFTX = "";                                                   
			String YAC_HOL_YN = "";                           
			
			String REL_CD1= "";  
			String NAM_KOR1 = "";        
			String CET_NO1 = ""; 
			String BAS_MAN1 = "";        
			String TRB_MAN1 = "";        
			String WCT_MAN1 = "";        
			String GOL_MAN1 = "";        
			String ONE_MAN1 = "";        
			String INV_NTS1 = "";     
			String INV2_NTS1 = ""; 			
			String MED_NTS1 = "";        
			String EDU_NTS1 = "";        
			String CARD_NTS1 = "";      
			String DIR_CARD_NTS1 = "";         
			String CASH_NTS1 = "";       
			String MARKET_NTS1 = "";   
			String PUBLIC_NTS1 = "";    
			String LC3_AMT_NTS1 = ""; 
			String INV_AMT1  = "";    
			String INV2_AMT1  = "";    			
			String MED_AMT1  = "";      
			String EDU_AMT1  = "";      
			String CARD_AMT1 = "";      
			String DIR_CARD_AMT1 = "";        
			String MARKET_AMT1 = "";  
			String PUBLIC_AMT1 = "";   
			String LC3_AMT1 = "";       
			
			
			String REL_CD2 = ""; 
			String NAM_KOR2 = "";        
			String CET_NO2 = ""; 
			String BAS_MAN2 = "";       
			String TRB_MAN2 = "";        
			String WCT_MAN2 = "";        
			String GOL_MAN2 = "";        
			String ONE_MAN2 = "";       
			String INV_NTS2 = "";    
			String INV2_NTS2 = "";			
			String MED_NTS2 = "";       
			String EDU_NTS2 = "";       
			String CARD_NTS2 = "";      
			String DIR_CARD_NTS2 = "";         
			String CASH_NTS2 = "";       
			String MARKET_NTS2 = "";  
			String PUBLIC_NTS2 = "";     
			String LC3_AMT_NTS2 = ""; 
			String INV_AMT2 = "";  
			String INV2_AMT2 = "";  			
			String MED_AMT2 = "";       
			String EDU_AMT2 = "";        
			String CARD_AMT2 = "";      
			String DIR_CARD_AMT2 = "";        
			String MARKET_AMT2 = "";   
			String PUBLIC_AMT2 = "";    
			String LC3_AMT2 = "";        
			
			
			String REL_CD3 = ""; 
			String NAM_KOR3 = "";        
			String CET_NO3 = ""; 
			String BAS_MAN3 = "";       
			String TRB_MAN3 = "";        
			String WCT_MAN3 = "";       
			String GOL_MAN3 = "";        
			String ONE_MAN3 = "";       
			String INV_NTS3 = "";      
			String INV2_NTS3 = ""; 			
			String MED_NTS3 = "";       
			String EDU_NTS3 = "";       
			String CARD_NTS3 = "";      
			String DIR_CARD_NTS3 = "";        
			String CASH_NTS3 = "";      
			String MARKET_NTS3 = "";   
			String PUBLIC_NTS3 = "";    
			String LC3_AMT_NTS3 = ""; 
			String INV_AMT3 = "";
			String INV2_AMT3 = "";			
			String MED_AMT3 = "";       
			String EDU_AMT3 = "";        
			String CARD_AMT3 = "";      
			String DIR_CARD_AMT3 = "";         
			String MARKET_AMT3 = "";  
			String PUBLIC_AMT3 = "";   
			String LC3_AMT3 = "";       
			
			
			String REL_CD4 = ""; 
			String NAM_KOR4 = "";       
			String CET_NO4 = ""; 
			String BAS_MAN4 = "";        
			String TRB_MAN4 = "";       
			String WCT_MAN4 = "";        
			String GOL_MAN4 = "";        
			String ONE_MAN4 = "";       
			String INV_NTS4 = "";   
			String INV2_NTS4 = ""; 			
			String MED_NTS4 = "";        
			String EDU_NTS4 = "";        
			String CARD_NTS4 = "";      
			String DIR_CARD_NTS4 = "";         
			String CASH_NTS4 = "";      
			String MARKET_NTS4 = "";  
			String PUBLIC_NTS4 = "";    
			String LC3_AMT_NTS4 = ""; 
			String INV_AMT4 = ""; 
			String INV2_AMT4 = ""; 			
			String MED_AMT4 = ""; 
			String EDU_AMT4 = "";      
			String CARD_AMT4 = "";   
			String DIR_CARD_AMT4 = "";     
			String MARKET_AMT4 = "";   
			String PUBLIC_AMT4 = "";     
			String LC3_AMT4 = ""; 
			
			
			String REL_CD5 = "";  
			String NAM_KOR5 = ""; 
			String CET_NO5 = "";        
			String BAS_MAN5 = "";      
			String TRB_MAN5 = "";    
			String WCT_MAN5 = "";   
			String GOL_MAN5 = "";  
			String ONE_MAN5 = ""; 
			String INV_NTS5 = ""; 
			String INV2_NTS5 = ""; 			
			String MED_NTS5 = "";  
			String EDU_NTS5 = "";      
			String CARD_NTS5 = "";   
			String DIR_CARD_NTS5  = "";   
			String CASH_NTS5 = "";  
			String MARKET_NTS5 = "";     
			String PUBLIC_NTS5 = "";   
			String LC3_AMT_NTS5 = "";        
			String INV_AMT5 = ""; 
			String INV2_AMT5 = "";  			
			String MED_AMT5 = ""; 
			String EDU_AMT5 = "";      
			String CARD_AMT5 = "";   
			String DIR_CARD_AMT5  = "";     
			String MARKET_AMT5 = "";   
			String PUBLIC_AMT5 = "";    
			String LC3_AMT5 = "";                     
			
			
			
			String PEN_GUBUN_CD_1 = "";                                              
			String ABA_CD_1 = "";                                                           
			String ABA_NM_1 = "";                                                          
			String ACC_NO_1 = "";                                                                                                               
			String AMOUNT_1 = "";                                                           
			String DED_AMT_1 = "";    
			
			
			String PEN_GUBUN_CD_2 = "";                                              
			String ABA_CD_2 = "";                                                           
			String ABA_NM_2 = "";                                                          
			String ACC_NO_2 = "";                                                                                                  
			String AMOUNT_2 = "";                                                           
			String DED_AMT_2 = "";    
			
			
			String PEN_GUBUN_CD_3 = "";                                              
			String ABA_CD_3 = "";                                                           
			String ABA_NM_3 = "";                                                          
			String ACC_NO_3 = "";                                                                      
			String AMOUNT_3 = "";                                                           
			String DED_AMT_3 = "";      
			
			
			String PEN_GUBUN_CD_4 = "";                                              
			String ABA_CD_4 = "";                                                           
			String ABA_NM_4 = "";                                                          
			String ACC_NO_4 = "";                                                                    
			String AMOUNT_4 = "";                                                           
			String DED_AMT_4 = "";    
			
			
			String PEN_GUBUN_CD_5 = "";                                              
			String ABA_CD_5 = "";                                                           
			String ABA_NM_5 = "";                                                          
			String ACC_NO_5 = "";                                                                      
			String AMOUNT_5 = "";                                                           
			String DED_AMT_5 = "";    
			
			
			String PEN_GUBUN_CD_6 = "";                                              
			String ABA_CD_6 = "";                                                           
			String ABA_NM_6 = "";                                                          
			String ACC_NO_6 = "";                                                             
			String AMOUNT_6 = "";                                                           
			String DED_AMT_6 = "";    
			
			
			String PEN_GUBUN_CD_7 = "";                                              
			String ABA_CD_7 = "";                                                           
			String ABA_NM_7 = "";                                                          
			String ACC_NO_7 = "";                                                                
			String AMOUNT_7 = "";                                                           
			String DED_AMT_7 = "";       
			
			
			String PEN_GUBUN_CD_8 = "";                                              
			String ABA_CD_8 = "";                                                           
			String ABA_NM_8 = "";                                                          
			String ACC_NO_8 = "";                                                           
			String AMOUNT_8 = "";                                                           
			String DED_AMT_8 = "";        
			
			
			String PEN_GUBUN_CD_9 = "";                                              
			String ABA_CD_9 = "";                                                           
			String ABA_NM_9 = "";                                                          
			String ACC_NO_9 = "";                                                          
			String AMOUNT_9 = "";                                                           
			String DED_AMT_9 = "";      
			
			
			String PEN_GUBUN_CD_10 = "";                                            
			String ABA_CD_10 = "";                                                         
			String ABA_NM_10 = "";                                                        
			String ACC_NO_10 = "";                                                        
			String AMOUNT_10 = "";                                                         
			String DED_AMT_10 = "";           
			
			
			String PEN_GUBUN_CD_11 = "";                                            
			String ABA_CD_11 = "";                                                         
			String ABA_NM_11 = "";                                                        
			String ACC_NO_11 = "";                                                        
			String AMOUNT_11 = "";                                                         
			String DED_AMT_11 = "";        
			
			
			String PEN_GUBUN_CD_12 = "";                                            
			String ABA_CD_12 = "";                                                         
			String ABA_NM_12 = "";                                                        
			String ACC_NO_12 = "";                                                        
			String AMOUNT_12 = "";                                                         
			String DED_AMT_12 = "";        
			
			
			String PEN_GUBUN_CD_13 = "";                                            
			String ABA_CD_13 = "";                                                         
			String ABA_NM_13 = "";                                                        
			String ACC_NO_13 = "";                                                        
			String AMOUNT_13 = "";                                                         
			String DED_AMT_13 = "";            
			
			
			String PEN_GUBUN_CD_14 = "";                                            
			String ABA_CD_14 = "";                                                         
			String ABA_NM_14 = "";                                                        
			String ACC_NO_14 = "";                                                        
			String AMOUNT_14 = "";                                                         
			String DED_AMT_14 = "";        
			
			
			String PEN_GUBUN_CD_15 = "";                                            
			String ABA_CD_15 = "";                                                         
			String ABA_NM_15 = "";                                                        
			String ACC_NO_15 = "";                                                        
			String AMOUNT_15 = "";                                                         
			String DED_AMT_15 = "";                                    

    	    
	        for(i=1; i<=dsYACA001_SHR_15.getDataRowCnt(); i++){

	    	    YAC_SEL_KEY = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SEL_KEY");
		        YAC_REC_TAG = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_REC_TAG");
		        YAC_TAX_CD  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TAX_CD");
		        YAC_COMP_CD = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_COMP_CD");
		        YAC_CNT     = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_CNT");
		        YAC_NAM_KOR = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_NAM_KOR");
		        YAC_CET_NO  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_CET_NO");
		        YAC_ZIP_NO  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_ZIP_NO");
		        YAC_JUSO    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_JUSO");
		        YAC_JAS_NM  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_JAS_NM");
		        YAC_JAO_NO  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_JAO_NO");
		        YAC_SALT_AMTS  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SALT_AMTS");		        
		        YAC_SALT_AMTT  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SALT_AMTT"  );
		        YAC_FREE_INCOME= GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_FREE_INCOME");
		        YAC_TAX_INCOME = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TAX_INCOME" );
		        YAC_OUTT_AMTS    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_OUTT_AMTS" );		        
		        YAC_MGR_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_MGR_AMT" );
		        YAC_MNI_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_MNI_AMT" );
		        YAC_BADD_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_BADD_AMT");
		        YAC_SOU_CNT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SOU_CNT" );
		        YAC_SPSB_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SPSB_AMT");
		        YAC_DFM_CNT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DFM_CNT" );
		        YAC_GDED_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GDED_AMT");
		        YAC_GOL_CNT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOL_CNT" );
		        YAC_GOL_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOL_AMT" );

		        YAC_TRB_CNT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TRB_CNT" );
		        YAC_TBL_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TBL_DED" );
		        YAC_WDD_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_WDD_AMT" );
		        YAC_ONE_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_ONE_AMT" );		        

		        YAC_HINU_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_HINU_AMT" ); 
		        YAC_HINS_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_HINS_AMT" );

		        YAC_LH1_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH1_AMT");
		        YAC_LH2_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH2_AMT");
		        YAC_LH3_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH3_AMT"); 
		        YAC_LH4_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH4_AMT");
		        YAC_LH5_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH5_AMT");
		        YAC_LH6_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH6_AMT");
		        YAC_LH7_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH7_AMT");
		        YAC_LH8_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LH8_AMT");		
		        YAC_DON_FWD   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DON_FWD");		
		        YAC_PER_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_PER_DED");			        

		        YAC_CPC_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_CPC_DED" );
		        YAC_NSE_TOT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_NSE_TOT" );
		        YAC_INDED_TOT  = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_INDED_TOT"  );
		        YAC_CARD_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_CARD_DED");
		        YAC_SAVE_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SAVE_DED");
		        YAC_SAVE1_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SAVE1_DED"); 
		        YAC_SAVE2_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SAVE2_DED");
		        YAC_SAVE3_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SAVE3_DED"); 
		        YAC_SAJU_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SAJU_AMT");
		        YAC_LSS_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LSS_AMT"); 		        
		        YAC_ETC_TOT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_ETC_TOT"); 		        
		        YAC_VEN_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_VEN_DED" );
		        YAC_TTAX_STD   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TTAX_STD");
		        YAC_TAX_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TAX_AMT" );
		        YAC_HGR_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_HGR_DED" );
		        YAC_AGE_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_AGE_AMT" );	

		        YAC_ANN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_ANN_AMT" );		        
		        YAC_ANN_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_ANN_DED" );  			        
		        YAC_LIN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LIN_AMT" );		        
		        YAC_MIN_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_MIN_DED" );  		        
		        
				YAC_MMA_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_MMA_AMT" );  
				YAC_MMA_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_MMA_DED" );		        
				YAC_EDU_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_EDU_AMT" );
				YAC_EDU_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_EDU_DED" );			        
				
				YAC_GOV1_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOV1_AMT" );		        
				YAC_GOV1_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOV1_DED" );  			        
				YAC_GOV2_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOV2_AMT" );		        
				YAC_GOV2_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOV2_DED" );  		        
		        
				YAC_LC1_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LC1_AMT" );  
				YAC_LC1_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LC1_DED" );		        
				YAC_LC23_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LC23_AMT" );
				YAC_LC23_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_LC23_DED" );					

				YAC_MRENT_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_MRENT_DED" );  				
				
		        YAC_TDED_TOT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_TDED_TOT");
		        YAC_DGG_TAX    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DGG_TAX" );
		        YAC_DBW_TAX    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DBW_TAX" );
		        YAC_DJM_TAX    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DJM_TAX" );
		        YAC_JAL_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_JAL_AMT" );
		        YAC_JAC_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_JAC_AMT" );
		        YAC_JAN_AMT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_JAN_AMT" );
		        YAC_INCM_TAX   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_INCM_TAX");
		        YAC_CITI_TAX   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_CITI_TAX");
		        EMS_HIR_YMD    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EMS_HIR_YMD" );
		        EMS_RET_YMD    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EMS_RET_YMD" );
		        YAC_STA_TOT    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_STA_TOT" );
		        YAC_NPEN_DED   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_NPEN_DED");

		        YAC_SEA_FREE   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_SEA_FREE");
		        YAC_GOV_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_GOV_DED" );
		        YAC_OTX_DED    = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_OTX_DED" );
		        YAC_CASH_AMT   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_CASH_AMT");
		        YAC_DRE_INTX   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DRE_INTX");
		        YAC_DRE_CTTX   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DRE_CTTX");
		        YAC_DRE_DFTX   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_DRE_DFTX");
		        YAC_HOL_YN   = GauceUtils.nameValue(dsYACA001_SHR_15, i, "YAC_HOL_YN");

		        
		        REL_CD1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "REL_CD1");
		        NAM_KOR1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "NAM_KOR1");

			    //System.out.println("-----------1818181818181818---------" +NAM_KOR1);
			    /*				    
			    System.out.println("-----------GauceDataColumn---------" +EDU_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +CARD_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +DIR_CARD_NTS5);			    
			    System.out.println("-----------GauceDataColumn---------" +CASH_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +MARKET_NTS5);			    
			    System.out.println("-----------GauceDataColumn---------" +PUBLIC_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +LC3_AMT_NTS5);
			    System.out.println("-----------GauceDataColumn---------" +INV_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +EDU_AMT5);			        
			    System.out.println("-----------GauceDataColumn---------" +CARD_AMT5);			    
			    System.out.println("-----------GauceDataColumn---------" +DIR_CARD_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +MARKET_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +PUBLIC_AMT5);
			    System.out.println("-----------GauceDataColumn---------" +LC3_AMT5);			        */
		        
		        CET_NO1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CET_NO1");
		        BAS_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "BAS_MAN1");
		        TRB_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "TRB_MAN1");
		        WCT_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "WCT_MAN1");
		        GOL_MAN1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "GOL_MAN1");
		        ONE_MAN1      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ONE_MAN1");		      
		        INV_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_NTS1");
		        INV2_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_NTS1");		        
		        MED_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_NTS1");
		        EDU_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_NTS1");
		        CARD_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_NTS1");
		        DIR_CARD_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_NTS1");
		        CASH_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CASH_NTS1");
		        MARKET_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_NTS1");		 
		        PUBLIC_NTS1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_NTS1");		 
		        LC3_AMT_NTS1      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT_NTS1");
		        INV_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_AMT1");
		        INV2_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_AMT1");		        
		        MED_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_AMT1");
		        EDU_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_AMT1");
		        CARD_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_AMT1");
		        DIR_CARD_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_AMT1");
		        MARKET_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_AMT1");		  
		        PUBLIC_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_AMT1");		   
		        LC3_AMT1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT1");
		        
		        
		        REL_CD2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "REL_CD2");
		        NAM_KOR2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "NAM_KOR2");
		        CET_NO2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CET_NO2");
		        BAS_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "BAS_MAN2");
		        TRB_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "TRB_MAN2");
		        WCT_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "WCT_MAN2");
		        GOL_MAN2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "GOL_MAN2");
		        ONE_MAN2      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ONE_MAN2");		        
		        INV_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_NTS2");
		        INV2_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_NTS2");		        
		        MED_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_NTS2");
		        EDU_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_NTS2");
		        CARD_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_NTS2");
		        DIR_CARD_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_NTS2");
		        CASH_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CASH_NTS2");
		        MARKET_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_NTS2");		
		        PUBLIC_NTS2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_NTS2");		        
		        LC3_AMT_NTS2      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT_NTS2");
		        INV_AMT2        = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_AMT2");
		        INV2_AMT2        = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_AMT2");		        
		        MED_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_AMT2");
		        EDU_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_AMT2");
		        CARD_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_AMT2");
		        DIR_CARD_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_AMT2");
		        MARKET_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_AMT2");		     
		        PUBLIC_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_AMT2");			       
		        LC3_AMT2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT2");
		        
		        
		        REL_CD3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "REL_CD3");
		        NAM_KOR3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "NAM_KOR3");
		        CET_NO3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CET_NO3");
		        BAS_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "BAS_MAN3");
		        TRB_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "TRB_MAN3");
		        WCT_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "WCT_MAN3");
		        GOL_MAN3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "GOL_MAN3");
		        ONE_MAN3      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ONE_MAN3");		        
		        INV_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_NTS3");
		        INV2_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_NTS3");		        
		        MED_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_NTS3");
		        EDU_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_NTS3");
		        CARD_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_NTS3");
		        DIR_CARD_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_NTS3");
		        CASH_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CASH_NTS3");
		        MARKET_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_NTS3");		        
		        PUBLIC_NTS3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_NTS3");		        
		        LC3_AMT_NTS3      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT_NTS3");
		        INV_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_AMT3");
		        INV2_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_AMT3");		        
		        MED_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_AMT3");
		        EDU_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_AMT3");
		        CARD_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_AMT3");
		        DIR_CARD_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_AMT3");
		        MARKET_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_AMT3");		        
		        PUBLIC_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_AMT3");			        
		        LC3_AMT3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT3");
		        

		        REL_CD4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "REL_CD4");
		        NAM_KOR4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "NAM_KOR4");
		        CET_NO4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CET_NO4");
		        BAS_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "BAS_MAN4");
		        TRB_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "TRB_MAN4");
		        WCT_MAN4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "WCT_MAN4");
		        GOL_MAN4        = GauceUtils.nameValue(dsYACA001_SHR_15, i, "GOL_MAN4");
		        ONE_MAN4      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ONE_MAN4");		        
		        INV_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_NTS4");
		        INV2_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_NTS4");		        
		        MED_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_NTS4");
		        EDU_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_NTS4");
		        CARD_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_NTS4");
		        DIR_CARD_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_NTS4");
		        CASH_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CASH_NTS4");
		        MARKET_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_NTS4");		        
		        PUBLIC_NTS4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_NTS4");		        
		        LC3_AMT_NTS4      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT_NTS4");
		        INV_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_AMT4");
		        INV2_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_AMT4");		        
		        MED_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_AMT4");
		        EDU_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_AMT4");
		        CARD_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_AMT4");
		        DIR_CARD_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_AMT4");
		        MARKET_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_AMT4");		        
		        PUBLIC_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_AMT4");			        
		        LC3_AMT4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT4");


		        REL_CD5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "REL_CD5");
		        NAM_KOR5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "NAM_KOR5");
		        CET_NO5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CET_NO5");
		        BAS_MAN5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "BAS_MAN5");
		        TRB_MAN5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "TRB_MAN5");
		        WCT_MAN5        = GauceUtils.nameValue(dsYACA001_SHR_15, i, "WCT_MAN5");
		        GOL_MAN5        = GauceUtils.nameValue(dsYACA001_SHR_15, i, "GOL_MAN5");
		        ONE_MAN5      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ONE_MAN5");		        
		        INV_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_NTS5");
		        INV2_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_NTS5");		        
		        MED_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_NTS5");
		        EDU_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_NTS5");
		        CARD_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_NTS5");
		        DIR_CARD_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_NTS5");
		        CASH_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CASH_NTS5");
		        MARKET_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_NTS5");		        
		        PUBLIC_NTS5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_NTS5");		        
		        LC3_AMT_NTS5      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT_NTS5");
		        INV_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV_AMT5");
		        INV2_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "INV2_AMT5");		        
		        MED_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MED_AMT5");
		        EDU_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "EDU_AMT5");
		        CARD_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "CARD_AMT5");
		        DIR_CARD_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DIR_CARD_AMT5");
		        MARKET_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "MARKET_AMT5");		     
		        PUBLIC_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PUBLIC_AMT5");			      
		        LC3_AMT5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "LC3_AMT5");

			        
		        
		        PEN_GUBUN_CD_1 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_1");
		        ABA_CD_1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_1");
		        ABA_NM_1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_1");
		        ACC_NO_1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_1");
		        AMOUNT_1       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_1");
		        DED_AMT_1      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_1");
		        
		        
		        PEN_GUBUN_CD_2 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_2");
		        ABA_CD_2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_2");
		        ABA_NM_2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_2");
		        ACC_NO_2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_2");
		        AMOUNT_2       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_2");
		        DED_AMT_2      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_2");
		        
		        
		        PEN_GUBUN_CD_3 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_3");
		        ABA_CD_3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_3");
		        ABA_NM_3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_3");
		        ACC_NO_3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_3");
		        AMOUNT_3       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_3");
		        DED_AMT_3      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_3");
		        
		        
		        PEN_GUBUN_CD_4 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_4");
		        ABA_CD_4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_4");
		        ABA_NM_4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_4");
		        ACC_NO_4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_4");
		        AMOUNT_4       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_4");
		        DED_AMT_4      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_4");
		        
		        
		        PEN_GUBUN_CD_5 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_5");
		        ABA_CD_5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_5");
		        ABA_NM_5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_5");
		        ACC_NO_5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_5");
		        AMOUNT_5       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_5");
		        DED_AMT_5      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_5");
		        
		        
		        PEN_GUBUN_CD_6 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_6");
		        ABA_CD_6       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_6");
		        ABA_NM_6       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_6");
		        ACC_NO_6       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_6");
		        AMOUNT_6       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_6");
		        DED_AMT_6      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_6");
		        
		        
		        PEN_GUBUN_CD_7 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_7");
		        ABA_CD_7       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_7");
		        ABA_NM_7       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_7");
		        ACC_NO_7       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_7");
		        AMOUNT_7       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_7");
		        DED_AMT_7      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_7");
		        
		        
		        PEN_GUBUN_CD_8 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_8");
		        ABA_CD_8       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_8");
		        ABA_NM_8       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_8");
		        ACC_NO_8       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_8");
		        AMOUNT_8       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_8");
		        DED_AMT_8      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_8");
		        
		        
		        PEN_GUBUN_CD_9 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_9");
		        ABA_CD_9       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_9");
		        ABA_NM_9       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_9");
		        ACC_NO_9       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_9");
		        AMOUNT_9       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_9");
		        DED_AMT_9      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_9");
		        
		        
		        PEN_GUBUN_CD_10 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_10");
		        ABA_CD_10       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_10");
		        ABA_NM_10       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_10");
		        ACC_NO_10       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_10");
		        AMOUNT_10       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_10");
		        DED_AMT_10      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_10");
		        
		        
		        PEN_GUBUN_CD_11 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_11");
		        ABA_CD_11       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_11");
		        ABA_NM_11       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_11");
		        ACC_NO_11       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_11");
		        AMOUNT_11       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_11");
		        DED_AMT_11      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_11");
		        
		        
		        PEN_GUBUN_CD_12 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_12");
		        ABA_CD_12       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_12");
		        ABA_NM_12       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_12");
		        ACC_NO_12       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_12");
		        AMOUNT_12       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_12");
		        DED_AMT_12      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_12");
		        
		        
		        PEN_GUBUN_CD_13 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_13");
		        ABA_CD_13       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_13");
		        ABA_NM_13       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_13");
		        ACC_NO_13       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_13");
		        AMOUNT_13       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_13");
		        DED_AMT_13      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_13");
		        
		        
		        PEN_GUBUN_CD_14 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_14");
		        ABA_CD_14       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_14");
		        ABA_NM_14       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_14");
		        ACC_NO_14       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_14");
		        AMOUNT_14       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_14");
		        DED_AMT_14      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_14");
		        
		        
		        PEN_GUBUN_CD_15 = GauceUtils.nameValue(dsYACA001_SHR_15, i, "PEN_GUBUN_CD_15");
		        ABA_CD_15       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_CD_15");
		        ABA_NM_15       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ABA_NM_15");
		        ACC_NO_15       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "ACC_NO_15");
		        AMOUNT_15       = GauceUtils.nameValue(dsYACA001_SHR_15, i, "AMOUNT_15");
		        DED_AMT_15      = GauceUtils.nameValue(dsYACA001_SHR_15, i, "DED_AMT_15");


		        
		        /* 기본공제, 추가공제 공제별 전액 기록을 위한 체크부분  -2001.02 */
		        if (YAC_REC_TAG.equals("C") ) {

			         /* 본인공제 */
			         if ((Long.parseLong(JSPUtil.rns3(YAC_BADD_AMT)) == 0) || (Long.parseLong(JSPUtil.rns3(YAC_BADD_AMT)) < 1500000)){
			              YAC_BADD_AMT = "1500000";
			         }

			         /* 배우자공제 */
			         if (JSPUtil.rns3(YAC_SOU_CNT).equals("1")){
			             YAC_SPSB_AMT = "1500000";
			         }

			         /* 부양가족공제 */
			         if (!JSPUtil.rns3(YAC_DFM_CNT).equals("0")  && !JSPUtil.rns3(YAC_DFM_CNT).equals("")){
			             YAC_GDED_AMT = Long.toString( Long.parseLong(YAC_DFM_CNT) * 1500000 );
			         }

			         /* 경로우대공제
			       /*  if (!JSPUtil.rns3(YAC_GOL_CNT65).equals("0") && !JSPUtil.rns3(YAC_GOL_CNT65).equals("")){
			             TMP_GOL_AMT65 = Long.toString( Long.parseLong(YAC_GOL_CNT65) * 1000000);
			         }  
			          	*/
			         if (!JSPUtil.rns3(YAC_GOL_CNT).equals("0") && !JSPUtil.rns3(YAC_GOL_CNT).equals("")){
			        	 YAC_GOL_AMT = Long.toString( Long.parseLong(YAC_GOL_CNT) * 1000000);
			         } 

			         //YAC_GOL_AMT = Long.toString( Long.parseLong(TMP_GOL_AMT65) + Long.parseLong(TMP_GOL_AMT70) );
			          
			         
			         
			         /* 장애자공제액 */
			         if (!JSPUtil.rns3(YAC_TRB_CNT).equals("0") && !JSPUtil.rns3(YAC_TRB_CNT).equals("")){
       		             YAC_TBL_DED = Long.toString( Long.parseLong(YAC_TRB_CNT) * 2000000);
			         }

			         /* 부녀자공제액 */
			         if (!JSPUtil.rns3(YAC_WDD_AMT).equals("0") && (Long.parseLong(JSPUtil.rns3(YAC_WDD_AMT)) < 500000) ){
			        	 YAC_WDD_AMT = "500000";
			         }

		        }

		        j = 0;

		        grAdd = new GauceDataRow(dsResult.getDataColCnt());
		        
		        grAdd.setString(j++, YAC_REC_TAG);
		        grAdd.setString(j++, YAC_TAX_CD);
		        grAdd.setString(j++, YAC_COMP_CD);
		        grAdd.setString(j++, YAC_CNT);
		        grAdd.setString(j++, YAC_NAM_KOR);
		        grAdd.setString(j++, YAC_CET_NO);
		        grAdd.setString(j++, YAC_ZIP_NO);
		        grAdd.setString(j++, YAC_JUSO);
		        grAdd.setString(j++, YAC_JAS_NM);
		        grAdd.setString(j++, YAC_JAO_NO);
		        grAdd.setString(j++, YAC_SALT_AMTS);
		        grAdd.setString(j++, YAC_SALT_AMTT);
		        grAdd.setString(j++, YAC_FREE_INCOME);
		        grAdd.setString(j++, YAC_TAX_INCOME);
		        grAdd.setString(j++, YAC_OUTT_AMTS);		        
		        grAdd.setString(j++, YAC_MGR_AMT);
		        grAdd.setString(j++, YAC_MNI_AMT);
		        grAdd.setString(j++, YAC_BADD_AMT);
		        grAdd.setString(j++, YAC_SOU_CNT);		        
		        grAdd.setString(j++, YAC_SPSB_AMT);
		        grAdd.setString(j++, YAC_DFM_CNT);
		        grAdd.setString(j++, YAC_GDED_AMT);
		        grAdd.setString(j++, YAC_GOL_CNT);
		        grAdd.setString(j++, YAC_GOL_AMT);	        
		        grAdd.setString(j++, YAC_TRB_CNT);
		        grAdd.setString(j++, YAC_TBL_DED);
		        grAdd.setString(j++, YAC_WDD_AMT);
		        grAdd.setString(j++, YAC_ONE_AMT);		     
		        

		        grAdd.setString(j++, YAC_HINU_AMT); //2010, 건강보험료
		        grAdd.setString(j++, YAC_HINS_AMT); //2010, 고용보험료

		        
		        grAdd.setString(j++, YAC_LH1_AMT);//주택자금_주택임차차입금원리금상환액_대출기관
		        grAdd.setString(j++, YAC_LH2_AMT);//주택자금_주택임차차입금원리금상환액_거주자
		        grAdd.setString(j++, YAC_LH3_AMT); //주택자금_월세액
		        grAdd.setString(j++, YAC_LH4_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_15년미만
		       	grAdd.setString(j++, YAC_LH5_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_15년~29년
		        grAdd.setString(j++, YAC_LH6_AMT);//(2011년 이전 차입분) 주택자금_장기주택저당차입금이자상환액_30년이상
		        grAdd.setString(j++, YAC_LH7_AMT);//(2012년 이후 차입분)고정금리비거치 상환 대출
		        grAdd.setString(j++, YAC_LH8_AMT);//(2012년 이후 차입분)기타 대출	
		        grAdd.setString(j++, YAC_DON_FWD);//기부금 이월금  
		        grAdd.setString(j++, YAC_PER_DED);//개인연금저축소득공제  		        
	        
		        grAdd.setString(j++, YAC_CPC_DED);
		        grAdd.setString(j++, YAC_NSE_TOT);
		        grAdd.setString(j++, YAC_INDED_TOT);
		        grAdd.setString(j++, YAC_CARD_DED);
		        grAdd.setString(j++, YAC_SAVE_DED);
		        grAdd.setString(j++, YAC_SAVE1_DED); //청약저축
		        grAdd.setString(j++, YAC_SAVE2_DED); //주택청약종합저축
		        grAdd.setString(j++, YAC_SAVE3_DED); //근로자주택마련저축
		        grAdd.setString(j++, YAC_SAJU_AMT); //우리사주조합 출연금
		        grAdd.setString(j++, YAC_LSS_AMT); //장기집합투자증권저축	   
		        grAdd.setString(j++, YAC_ETC_TOT); //그밖의 소득공제 계 		        
		        grAdd.setString(j++, YAC_VEN_DED);
		        grAdd.setString(j++, YAC_TTAX_STD);
		        grAdd.setString(j++, YAC_TAX_AMT);
		        grAdd.setString(j++, YAC_HGR_DED);
		        grAdd.setString(j++, YAC_AGE_AMT);		    
		        
		        grAdd.setString(j++, YAC_ANN_AMT);
		        grAdd.setString(j++, YAC_ANN_DED);
		        grAdd.setString(j++, YAC_LIN_AMT);
		        grAdd.setString(j++, YAC_MIN_DED);			        

		        grAdd.setString(j++, YAC_MMA_AMT);//의료비 공제금액		      
		        grAdd.setString(j++, YAC_MMA_DED);//의료비세액공제
		        grAdd.setString(j++, YAC_EDU_AMT);//교육비공제금액		        
		        grAdd.setString(j++, YAC_EDU_DED);//교육비 세액공제	        
		        
		        grAdd.setString(j++, YAC_GOV1_AMT);
		        grAdd.setString(j++, YAC_GOV1_DED);
		        grAdd.setString(j++, YAC_GOV2_AMT);
		        grAdd.setString(j++, YAC_GOV2_DED);			        	

		        grAdd.setString(j++, YAC_LC1_AMT);//법정기부금      
		        grAdd.setString(j++, YAC_LC1_DED);//법정기부금
		        grAdd.setString(j++, YAC_LC23_AMT);//지정기부금		        
		        grAdd.setString(j++, YAC_LC23_DED);//지정기부금
		        
		        grAdd.setString(j++, YAC_MRENT_DED);//월세 세액공제	   
		        
		        grAdd.setString(j++, YAC_TDED_TOT);
		        grAdd.setString(j++, YAC_DGG_TAX);
		        grAdd.setString(j++, YAC_DBW_TAX);
		        grAdd.setString(j++, YAC_DJM_TAX);
		        grAdd.setString(j++, YAC_JAL_AMT);
		        grAdd.setString(j++, YAC_JAC_AMT);
		        grAdd.setString(j++, YAC_JAN_AMT);
		        grAdd.setString(j++, YAC_INCM_TAX);
		        grAdd.setString(j++, YAC_CITI_TAX);
		        
	    	    //System.out.println("-----------EMS_HIR_YMD---------"+EMS_HIR_YMD);		        
	    	    //System.out.println("-----------EMS_RET_YMD---------"+EMS_RET_YMD);	
		        
		        grAdd.setString(j++, EMS_HIR_YMD);
		        grAdd.setString(j++, EMS_RET_YMD);
		        grAdd.setString(j++, YAC_STA_TOT);
		        grAdd.setString(j++, YAC_NPEN_DED);

		        grAdd.setString(j++, YAC_SEA_FREE);
		        grAdd.setString(j++, YAC_GOV_DED);
		        grAdd.setString(j++, YAC_OTX_DED);
		        grAdd.setString(j++, YAC_CASH_AMT);
		        grAdd.setString(j++, YAC_DRE_INTX);
		        grAdd.setString(j++, YAC_DRE_CTTX);
		        grAdd.setString(j++, YAC_DRE_DFTX);
		        
	
		        
		        grAdd.setString(j++, YAC_HOL_YN);
	    	    //System.out.println("-----------YAC_HOL_YN---------"+YAC_HOL_YN);		        
	    	    //System.out.println("-----------REL_CD1---------"+REL_CD1);			        
		        
		        grAdd.setString(j++,REL_CD1);	        
		        grAdd.setString(j++,NAM_KOR1);
		        grAdd.setString(j++,CET_NO1);
		        grAdd.setString(j++,BAS_MAN1);
		        grAdd.setString(j++,TRB_MAN1);
		        grAdd.setString(j++,WCT_MAN1);
		        grAdd.setString(j++,GOL_MAN1);
		        grAdd.setString(j++,ONE_MAN1);
		        grAdd.setString(j++,INV_NTS1);
		        grAdd.setString(j++,INV2_NTS1);		        
		        grAdd.setString(j++,MED_NTS1);
		        grAdd.setString(j++,EDU_NTS1);
		        grAdd.setString(j++,CARD_NTS1);
		        grAdd.setString(j++,DIR_CARD_NTS1);
		        grAdd.setString(j++,CASH_NTS1);
		        grAdd.setString(j++,MARKET_NTS1);
		        grAdd.setString(j++,PUBLIC_NTS1);
		        grAdd.setString(j++,LC3_AMT_NTS1);
		        grAdd.setString(j++,INV_AMT1);
		        grAdd.setString(j++,INV2_AMT1);		        
		        grAdd.setString(j++,MED_AMT1);
		        grAdd.setString(j++,EDU_AMT1);
		        grAdd.setString(j++,CARD_AMT1);
		        grAdd.setString(j++,DIR_CARD_AMT1);
		        grAdd.setString(j++,MARKET_AMT1);
		        grAdd.setString(j++,PUBLIC_AMT1);
		        grAdd.setString(j++,LC3_AMT1);
		        

		        grAdd.setString(j++,REL_CD2);
		        grAdd.setString(j++,NAM_KOR2);
		        grAdd.setString(j++,CET_NO2);
		        grAdd.setString(j++,BAS_MAN2);
		        grAdd.setString(j++,TRB_MAN2);
		        grAdd.setString(j++,WCT_MAN2);
		        grAdd.setString(j++,GOL_MAN2);
		        grAdd.setString(j++,ONE_MAN2);
		        grAdd.setString(j++,INV_NTS2);
		        grAdd.setString(j++,INV2_NTS2);		        
		        grAdd.setString(j++,MED_NTS2);
		        grAdd.setString(j++,EDU_NTS2);
		        grAdd.setString(j++,CARD_NTS2);
		        grAdd.setString(j++,DIR_CARD_NTS2);
		        grAdd.setString(j++,CASH_NTS2);
		        grAdd.setString(j++,MARKET_NTS2);
		        grAdd.setString(j++,PUBLIC_NTS2);
		        grAdd.setString(j++,LC3_AMT_NTS2);
		        grAdd.setString(j++,INV_AMT2);
		        grAdd.setString(j++,INV2_AMT2);		        
		        grAdd.setString(j++,MED_AMT2);
		        grAdd.setString(j++,EDU_AMT2);
		        grAdd.setString(j++,CARD_AMT2);
		        grAdd.setString(j++,DIR_CARD_AMT2);
		        grAdd.setString(j++,MARKET_AMT2);
		        grAdd.setString(j++,PUBLIC_AMT2);
		        grAdd.setString(j++,LC3_AMT2);
		        

		        grAdd.setString(j++,REL_CD3);
		        grAdd.setString(j++,NAM_KOR3);
		        grAdd.setString(j++,CET_NO3);
		        grAdd.setString(j++,BAS_MAN3);
		        grAdd.setString(j++,TRB_MAN3);
		        grAdd.setString(j++,WCT_MAN3);
		        grAdd.setString(j++,GOL_MAN3);
		        grAdd.setString(j++,ONE_MAN3);
		        grAdd.setString(j++,INV_NTS3);
		        grAdd.setString(j++,INV2_NTS3);		        
		        grAdd.setString(j++,MED_NTS3);
		        grAdd.setString(j++,EDU_NTS3);
		        grAdd.setString(j++,CARD_NTS3);
		        grAdd.setString(j++,DIR_CARD_NTS3);
		        grAdd.setString(j++,CASH_NTS3);
		        grAdd.setString(j++,MARKET_NTS3);
		        grAdd.setString(j++,PUBLIC_NTS3);
		        grAdd.setString(j++,LC3_AMT_NTS3);
		        grAdd.setString(j++,INV_AMT3);
		        grAdd.setString(j++,INV2_AMT3);		        
		        grAdd.setString(j++,MED_AMT3);
		        grAdd.setString(j++,EDU_AMT3);
		        grAdd.setString(j++,CARD_AMT3);
		        grAdd.setString(j++,DIR_CARD_AMT3);
		        grAdd.setString(j++,MARKET_AMT3);
		        grAdd.setString(j++,PUBLIC_AMT3);
		        grAdd.setString(j++,LC3_AMT3);
		        
	        
		        grAdd.setString(j++,REL_CD4);
		        grAdd.setString(j++,NAM_KOR4);
		        grAdd.setString(j++,CET_NO4);
		        grAdd.setString(j++,BAS_MAN4);
		        grAdd.setString(j++,TRB_MAN4);
		        grAdd.setString(j++,WCT_MAN4);
		        grAdd.setString(j++,GOL_MAN4);
		        grAdd.setString(j++,ONE_MAN4);
		        grAdd.setString(j++,INV_NTS4);
		        grAdd.setString(j++,INV2_NTS4);		        
		        grAdd.setString(j++,MED_NTS4);
		        grAdd.setString(j++,EDU_NTS4);
		        grAdd.setString(j++,CARD_NTS4);
		        grAdd.setString(j++,DIR_CARD_NTS4);
		        grAdd.setString(j++,CASH_NTS4);
		        grAdd.setString(j++,MARKET_NTS4);
		        grAdd.setString(j++,PUBLIC_NTS4);
		        grAdd.setString(j++,LC3_AMT_NTS4);
		        grAdd.setString(j++,INV_AMT4);
		        grAdd.setString(j++,INV2_AMT4);		        
		        grAdd.setString(j++,MED_AMT4);
		        grAdd.setString(j++,EDU_AMT4);
		        grAdd.setString(j++,CARD_AMT4);
		        grAdd.setString(j++,DIR_CARD_AMT4);
		        grAdd.setString(j++,MARKET_AMT4);
		        grAdd.setString(j++,PUBLIC_AMT4);
		        grAdd.setString(j++,LC3_AMT4);
		        

		        grAdd.setString(j++,REL_CD5);
		        grAdd.setString(j++,NAM_KOR5);
		        grAdd.setString(j++,CET_NO5);
		        grAdd.setString(j++,BAS_MAN5);
		        grAdd.setString(j++,TRB_MAN5);
		        grAdd.setString(j++,WCT_MAN5);
		        grAdd.setString(j++,GOL_MAN5);
		        grAdd.setString(j++,ONE_MAN5);
		        grAdd.setString(j++,INV_NTS5);
		        grAdd.setString(j++,INV2_NTS5);		        
		        grAdd.setString(j++,MED_NTS5);
		        grAdd.setString(j++,EDU_NTS5);
		        grAdd.setString(j++,CARD_NTS5);
		        grAdd.setString(j++,DIR_CARD_NTS5);
		        grAdd.setString(j++,CASH_NTS5);
		        grAdd.setString(j++,MARKET_NTS5);
		        grAdd.setString(j++,PUBLIC_NTS5);
		        grAdd.setString(j++,LC3_AMT_NTS5);
		        grAdd.setString(j++,INV_AMT5);
		        grAdd.setString(j++,INV2_AMT5);		        
		        grAdd.setString(j++,MED_AMT5);
		        grAdd.setString(j++,EDU_AMT5);
		        grAdd.setString(j++,CARD_AMT5);
		        grAdd.setString(j++,DIR_CARD_AMT5);
		        grAdd.setString(j++,MARKET_AMT5);
		        grAdd.setString(j++,PUBLIC_AMT5);
		        grAdd.setString(j++,LC3_AMT5);
		        //grAdd.setString(j++, YAC_SEL_KEY);

		        grAdd.setString(j++, PEN_GUBUN_CD_1);
		        grAdd.setString(j++, ABA_CD_1);
		        grAdd.setString(j++, ABA_NM_1);
		        grAdd.setString(j++, ACC_NO_1);
		        grAdd.setString(j++, AMOUNT_1);
		        grAdd.setString(j++, DED_AMT_1);

		        grAdd.setString(j++, PEN_GUBUN_CD_2);
		        grAdd.setString(j++, ABA_CD_2);
		        grAdd.setString(j++, ABA_NM_2);
		        grAdd.setString(j++, ACC_NO_2);
		        grAdd.setString(j++, AMOUNT_2);
		        grAdd.setString(j++, DED_AMT_2);

		        grAdd.setString(j++, PEN_GUBUN_CD_3);
		        grAdd.setString(j++, ABA_CD_3);
		        grAdd.setString(j++, ABA_NM_3);
		        grAdd.setString(j++, ACC_NO_3);
		        grAdd.setString(j++, AMOUNT_3);
		        grAdd.setString(j++, DED_AMT_3);

		        grAdd.setString(j++, PEN_GUBUN_CD_4);
		        grAdd.setString(j++, ABA_CD_4);
		        grAdd.setString(j++, ABA_NM_4);
		        grAdd.setString(j++, ACC_NO_4);
		        grAdd.setString(j++, AMOUNT_4);
		        grAdd.setString(j++, DED_AMT_4);

		        grAdd.setString(j++, PEN_GUBUN_CD_5);
		        grAdd.setString(j++, ABA_CD_5);
		        grAdd.setString(j++, ABA_NM_5);
		        grAdd.setString(j++, ACC_NO_5);
		        grAdd.setString(j++, AMOUNT_5);
		        grAdd.setString(j++, DED_AMT_5);

		        grAdd.setString(j++, PEN_GUBUN_CD_6);
		        grAdd.setString(j++, ABA_CD_6);
		        grAdd.setString(j++, ABA_NM_6);
		        grAdd.setString(j++, ACC_NO_6);
		        grAdd.setString(j++, AMOUNT_6);
		        grAdd.setString(j++, DED_AMT_6);

		        grAdd.setString(j++, PEN_GUBUN_CD_7);
		        grAdd.setString(j++, ABA_CD_7);
		        grAdd.setString(j++, ABA_NM_7);
		        grAdd.setString(j++, ACC_NO_7);
		        grAdd.setString(j++, AMOUNT_7);
		        grAdd.setString(j++, DED_AMT_7);

		        grAdd.setString(j++, PEN_GUBUN_CD_8);
		        grAdd.setString(j++, ABA_CD_8);
		        grAdd.setString(j++, ABA_NM_8);
		        grAdd.setString(j++, ACC_NO_8);
		        grAdd.setString(j++, AMOUNT_8);
		        grAdd.setString(j++, DED_AMT_8);

		        grAdd.setString(j++, PEN_GUBUN_CD_9);
		        grAdd.setString(j++, ABA_CD_9);
		        grAdd.setString(j++, ABA_NM_9);
		        grAdd.setString(j++, ACC_NO_9);
		        grAdd.setString(j++, AMOUNT_9);
		        grAdd.setString(j++, DED_AMT_9);

		        grAdd.setString(j++, PEN_GUBUN_CD_10);
		        grAdd.setString(j++, ABA_CD_10);
		        grAdd.setString(j++, ABA_NM_10);
		        grAdd.setString(j++, ACC_NO_10);
		        grAdd.setString(j++, AMOUNT_10);
		        grAdd.setString(j++, DED_AMT_10);

		        grAdd.setString(j++, PEN_GUBUN_CD_11);
		        grAdd.setString(j++, ABA_CD_11);
		        grAdd.setString(j++, ABA_NM_11);
		        grAdd.setString(j++, ACC_NO_11);
		        grAdd.setString(j++, AMOUNT_11);
		        grAdd.setString(j++, DED_AMT_11);

		        grAdd.setString(j++, PEN_GUBUN_CD_12);
		        grAdd.setString(j++, ABA_CD_12);
		        grAdd.setString(j++, ABA_NM_12);
		        grAdd.setString(j++, ACC_NO_12);
		        grAdd.setString(j++, AMOUNT_12);
		        grAdd.setString(j++, DED_AMT_12);

		        grAdd.setString(j++, PEN_GUBUN_CD_13);
		        grAdd.setString(j++, ABA_CD_13);
		        grAdd.setString(j++, ABA_NM_13);
		        grAdd.setString(j++, ACC_NO_13);
		        grAdd.setString(j++, AMOUNT_13);
		        grAdd.setString(j++, DED_AMT_13);

		        grAdd.setString(j++, PEN_GUBUN_CD_14);
		        grAdd.setString(j++, ABA_CD_14);
		        grAdd.setString(j++, ABA_NM_14);
		        grAdd.setString(j++, ACC_NO_14);
		        grAdd.setString(j++, AMOUNT_14);
		        grAdd.setString(j++, DED_AMT_14);

		        grAdd.setString(j++, PEN_GUBUN_CD_15);
		        grAdd.setString(j++, ABA_CD_15);
		        grAdd.setString(j++, ABA_NM_15);
		        grAdd.setString(j++, ACC_NO_15);
		        grAdd.setString(j++, AMOUNT_15);
		        grAdd.setString(j++, DED_AMT_15);
		        
		        
    		    //System.out.println("-----------grAdd---------" +grAdd.getString(
    		    
    		    
		        dsResult.addDataRow(grAdd);


		        
	        }

	        //dvoList에 출력양식에 맞게 넣는다.
	        int NUM = 3;
	        StringBuffer sbNPN_NO = null;
	        DynamicValueObject dvo = null;

	        String NAME = "";
	        int LN_CNT1 = 0;
	        int LN_CNT2 = 0;
	        int LN_CNT3 = 0;

	        String TMP_YN1 = "";
	        String TMP_YN2 = "";
	        String TMP_YN3 = "";
	        String TMP_YN4 = "";
	        String TMP_YN5 = "";

	        for(i=1; i<=dsResult.getDataRowCnt(); i++){
	        	
	        	sbNPN_NO = new StringBuffer();
	        	
	        	dvo = new DynamicValueObject();

	        	//이름사이에 공백이 있으면 않된다.(전산매체양식 참조)
	        	if(GauceUtils.nameValue(dsResult, i, "NAM_KOR") != null){
	        		
	        		NAME = GauceUtils.nameValue(dsResult, i, "NAM_KOR").replaceAll(" ","");
	        		
	        	}

	        	
    		    //System.out.println("-----------REL_CD1---------" +dsResult.value);	        	
	        	
	        	
        		/**
        		 * 갑근 주(현)근무처 레코드
        		 */
	        	if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("C".toUpperCase())){
	        		LN_CNT1 = LN_CNT1 + 1;
	        		LN_CNT2 = 0;
	        		LN_CNT3 = 0;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CNT"),"0",2));//종(전)근무처 수
	        		sbNPN_NO.append("1");//거주자구분코드
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",2));//거주지국코드
              	    sbNPN_NO.append("2");//외국인단일세율적용
	        		sbNPN_NO.append(JSPUtil.byteRpad(NAME," ",30));//성명
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO").substring(6,7)) < 5 ){//내외국인 구분코드
	        	    	sbNPN_NO.append("1");
               		}else{
               			sbNPN_NO.append("9");
        		    }
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//주민등록번호
	        		
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO").substring(6,7)) < 5 ){
		        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",2)); //2010, 국적코드
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteRpad("CN"," ",2));//2010, 국적코드 
	        		}	        		
		    	    //System.out.println("-----------GauceUtils.nameValue---------"+GauceUtils.nameValue(dsResult, i, "HOL_YN"));	
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HOL_YN")," ",1));//2010, 세대주여부

	        		if(GauceUtils.nameValue(dsResult, i, "RET_YMD").equals("20151231") == true){
	        			sbNPN_NO.append("1"); //계속근로
	        		}
	        		else{
	        			sbNPN_NO.append("2"); //중도퇴직
	        		}
	        		
	        		//근무처별 소득명세- 주(현)근무처
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10)); //2010, 주현근무처-사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad("현대아산주식회사"," ",40)); //2010,주현근무처-근무처명
	        		
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HIR_YMD"),"0",8));//근무기간 시작연월일
	        		//sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5512111331019") == true){
	        			sbNPN_NO.append("20151231"); //근무기간 종료연월일
	        		}
	        		else{
		        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		}	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 종료연월일

	        		//근무처별 소득명세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTS"),"0",11));//급여총액
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//상여총액
	        		
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "OUTT_AMTS"),"0",11));//인정상여   	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//주식매수선택권행사이익

	        		/*
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){
	        			sbNPN_NO.append("00002306524"); //우리사주조합인출금
	        		}
	        		else{
		        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		}	
	        		*/    	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//임원 퇴직소득금액 한도초과액	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",22));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTT"),"0",11));//계

	        		//비과세소득
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세학자금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보수위원수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//경호·승선수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//유아·초중등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고등교육법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연구기관 등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//기업부설연구소
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//H14-보육교사 근무환경개선비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//H15-사립유치원 수석교사 교사의 인건비	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//취재수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//벽지수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//재해관련급여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//정부공공기관  지방이전기관 종사자 이주수당        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국정부등근무자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국주둔군인등
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SEA_FREE"),"0",10));//국외근로100만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로100만원        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로300만원 
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//야간근로수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//출산보육수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//근로장학금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주식매수선택권
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국인기술자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금50%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금75%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//장기미취업자중소기업 취업
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//해저광물자원개발
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//전공의 수련 보조수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//중소기업취업 청년 소득세 감면    		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약상 교직자 감면 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SEA_FREE"),"0",10));//비과세 계
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //감면소득계

	        		//정산명세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TAX_INCOME"),"0",11));//총급여     		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MGR_AMT"),"0",10));//근로소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MNI_AMT"),"0",11));//근로소득금액

	        		//기본공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "BADD_AMT"),"0",8));//본인공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SPSB_AMT"),"0",8));//배우자공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DFM_CNT"),"0",2));//부양가족공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GDED_AMT"),"0",8));//부양가족공제금액

	        		//추가공제
	         		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOL_CNT"),"0",2));//경로우대공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOL_AMT"),"0",8));//경로우대공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TRB_CNT"),"0",2));//장애인공제인원
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TBL_DED"),"0",8));//장애인공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "WDD_AMT"),"0",8));//부녀자공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ONE_AMT"),"0",10));//한부모 가족 공제금액	        		

	        		
	        		//연금보험료공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "NPEN_DED"),"0",10));//국민연금보험료공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(공무원)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(군인)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(교직원)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 기타연금(우체국)

	        		//특별공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HINU_AMT"),"0",10)); //건강보험료
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HINS_AMT"),"0",10)); //고용보험료
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH1_AMT"),"0",8));//주택임차차입금원리금상환액_대출기관	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH2_AMT"),"0",8));//주택임차차입금원리금상환액_거주자
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH3_AMT"),"0",8)); //주택자금_월세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH4_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년미만	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7612201106214") == true){	     
	        			sbNPN_NO.append("01150760"); //(2012년 이후 차입분)고정금리비거치상환 대출      			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH5_AMT"),"0",8));	//주택자금_장기주택저당차입금이자상환액_15년~29년	     		
	        		}	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH5_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년~29년		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH6_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_30년이상	 	
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7612201106214") == true){	     
	        			sbNPN_NO.append("01248553"); //(2012년 이후 차입분)고정금리비거치상환 대출      			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH7_AMT"),"0",8));	//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)고정금리비거치상환 대출      		
	        		}		        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH7_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)고정금리비거치상환 대출 		      
	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LH8_AMT"),"0",8));//주택자금_장기주택저당차입금이자상환액_(2012년 이후 차입분)기타 대출	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DON_FWD"),"0",11));//기부금이월분		        		
	        		
	        		/*
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6811231055111") == true){	     
	        			sbNPN_NO.append("03535380"); //주택자금_장기주택저당차입금이자상환액_15년~29년	        		
	        		}else{
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG2_DED"),"0",8));//주택자금_장기주택저당차입금이자상환액_15년~29년
	        			
	        		}	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("7412201347528") == true){	     
	        			sbNPN_NO.append("02011308"); //주택자금_장기주택저당차입금이자상환액_30년이상
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6909141011113") == true){	    	        			
	        			sbNPN_NO.append("02278368"); //주택자금_장기주택저당차입금이자상환액_30년이상	        			
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG3_DED"),"0",8));//주택자금_장기주택저당차입금이자상환액_30년이상	        		
	        		}	        		
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("7412201347528") == true){	     
	        			sbNPN_NO.append("06655992"); //(2012년 이후 차입분)고정금리비거치상환 대출
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6909141011113") == true){	    	        			
	        			sbNPN_NO.append("01617866"); //(2012년 이후 차입분)고정금리비거치상환 대출 	      
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("6811231055111") == true){	    	        			
	        			sbNPN_NO.append("00372857"); //(2012년 이후 차입분)고정금리비거치상환 대출	        			
	        		}else{	        		
	        			sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG4_DED"),"0",8));	//(2012년 이후 차입분)고정금리비거치상환 대출        		
	        		}
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LONG5_DED"),"0",8));//(2012년 이후 차입분)기타 대출
	        		*/
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DON_FWD"),"0",11));  //기부금 이월분        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",20));//공란	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "VEN_DED"),"0",11));//특별소득공제계     		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INDED_TOT"),"0",11));//차감소득금액	        		
	        		
	        		//그 밖의 소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PER_DED"),"0",8));//개인연금저축소득공제	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소기업공제부금소득공제	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE1_DED"),"0",10)); //주택마련저축소득공제_청약저축
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE2_DED"),"0",10)); //주택마련저축소득공제_주택청약종합저축
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAVE3_DED"),"0",10)); //주택마련저축소득공제_근로자주택마련저축	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//투자좋합출자등소득공제	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_DED"),"0",8));//신용카드등소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SAJU_AMT"),"0",10));//우리사주조합 출연금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합 기부금    		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고용유지중소기업근로자소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//목돈안드는전세이자상환액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LSS_AMT"),"0",10));//장기집합투자증권저축        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ETC_TOT"),"0",11));//그 밖의 소득공제계	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//소득공제종합한도 초과액  		  		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TTAX_STD"),"0",11));//종합소득 과세표준
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TAX_AMT"),"0",10));//산출세액	        		
	        		
	        		//세액감면
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소득세법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조특법(-1 제외)
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조특법 제30조	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//세액감면계	
	        		
	        		//세액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "HGR_DED"),"0",10));//근로소득세액공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AGE_AMT"),"0",10));//자녀세액공제        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_과학기술인공제_공제대상금액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_과학기술인공제_세액공제액  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_근로자퇴직급여보장법에따른 퇴직급여_공제대상금액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연금계좌_근로자퇴직급여보장법에따른 퇴직급여_세액공제액
	        		  		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ANN_AMT"),"0",10));//연금계좌_연금저축_공제대상금액   
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ANN_DED"),"0",10));//연금계좌_연금저축_세액공제액    		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LIN_AMT"),"0",10));  //특별세액공제_보장성보험료_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MIN_DED"),"0",10));  //특별세액공제_보장성보험료_세액공제액
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MMA_AMT"),"0",10));//특별세액공제_의료비_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MMA_DED"),"0",10));//특별세액공제_의료비_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT"),"0",10));//특별세액공제_교육비_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_DED"),"0",10));//특별세액공제_교육비_세액공제액	
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5206111068514") == true){	     
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701071553212") == true){	    	        			
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액        
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6904301380532") == true){	    	        			
	        			sbNPN_NO.append("0000100000"); //특별세액공제_기부금_정치자금_10만원이하_공제대상금액            			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_AMT"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_공제대상금액       		
	        		}	        		
	        		
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_AMT"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV1_DED"),"0",10));//특별세액공제_기부금_정치자금_10만원이하_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV2_AMT"),"0",11));//특별세액공제_기부금_정치자금_10만원초과_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "GOV2_DED"),"0",10));//특별세액공제_기부금_정치자금_10만원초과_세액공제액	
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC1_AMT"),"0",11));//특별세액공제_기부금_법정기부금_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC1_DED"),"0",10));//특별세액공제_기부금_법정기부금_세액공제액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC23_AMT"),"0",11));//특별세액공제_기부금_지정기부금_공제대상금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC23_DED"),"0",10));//특별세액공제_기부금_지정기부금_세액공제액      		

	        		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "NSE_TOT"),"0",10));//특별세액공제계
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "STA_TOT"),"0",10));//표준세액공제
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//납세조합공제
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주택차입금   		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국납부        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MRENT_DED"),"0",10));//월세 세액공제	        
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "TDED_TOT"),"0",10));//세액공제계	        		

	        		//결정세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DGG_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DJM_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DBW_TAX"),"0",10));//농특세

	        		//기납부세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INCM_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CITI_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//농특세	        		
	        		
	        		//납부특례세액
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//농특세	 	        		
	        		
	        		
	        		//차감징수세액
	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_INTX")) < 0 ) {//소득세
	        		   sbNPN_NO.append("1");
          			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_INTX"))	* -1),"0",10));
	        		}
	        		else {
	        		   sbNPN_NO.append("0");
	        		   sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_INTX"),"0",10));
	             	}

	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_CTTX")) < 0 ) {//지방소득세
		        	   sbNPN_NO.append("1");
	      			   sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_CTTX"))	* -1),"0",10));
	        	    }
	        		else {
	        	    	sbNPN_NO.append("0");
	        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_CTTX"),"0",10));
	        		}


	        		if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_DFTX")) < 0 ) {//농특세
		        		sbNPN_NO.append("1");
		      			sbNPN_NO.append(JSPUtil.byteLpad(Long.toString(Long.parseLong(GauceUtils.nameValue(dsResult, i, "DRE_DFTX")) * -1),"0",10));
	        		}
	        		else {
	        			sbNPN_NO.append("0");
	        		    sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DRE_DFTX"),"0",10));
	        		}

	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",14));	        		
	        		
	        		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	        		
	        		
        		/**
        		 * 갑근 종(전)소득 발생처 레코드
        		 */
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("D".toUpperCase())){
	        		LN_CNT2 = LN_CNT2 + 1;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));//레코드 구분
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));//자료구분+세무서
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));//일련번호

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));//사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",50));//공란

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//소득자주민등록번호

	        		//종(전)근무처	        		
	        		sbNPN_NO.append("2");//2010,납세조합구분, 재경부 문의 확인
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "JAS_NM")," ",40));//법인명(상호)
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "JAO_NO")," ",10));//사업자등록번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "HIR_YMD"),"0",8));//근무기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "RET_YMD"),"0",8));//근무기간 종료연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 시작연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",8));//감면기간 종료연월일
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTS"),"0",11));//급여총액
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7606271697813") == true){	     
	        			sbNPN_NO.append("00000750000"); //상여총액    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8104272006217") == true){	    	        			
	        			sbNPN_NO.append("00001000000"); //상여총액        
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7507091227217") == true){	    	        			
	        			sbNPN_NO.append("00001351900"); //상여총액         
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	    	        			
	        			sbNPN_NO.append("00043392600"); //상여총액   	        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAC_AMT"),"0",11));//상여총액		
	        		}		        		
	        		  		
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//인정상여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//주식매수선택권행사이익
	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	     
	        			sbNPN_NO.append("00002306524"); //우리사주조합인출금        		
	        		}else{
	        			sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//우리사주조합인출금
	        		}	  	        		

	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",11));//임원 퇴직소득금액 한도초과액        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",22));//공란
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "SALT_AMTT"),"0",11));//계

	        		//종전근무지 비과세소득
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세학자금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//무보수위원수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//경호·승선수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//유아·초중등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//고등교육법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//특별법
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//연구기관 등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//기업부설연구소
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//보육교사  근무환경개선비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//사립유치원수석교사교사의 인건비
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//취재수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//벽지수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//재해관련급여
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//정부공공기관지방이전기관 종사자 이주수당        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국정부등근무자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국주둔군인등
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로100만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로300만원
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//국외근로

	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAG_AMT"),"0",10));//야간근로수당 비과세 뭐는 하나 들어가야해서
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//야간근로수당 비과세 뭐는 하나 들어가야해서
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//출산보육수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//근로장학금
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//주식매수선택권
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//외국인기술자
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금50%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//우리사주조합인출금75%
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//장기미취업자중소기업 취업
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//해저광물자원개발
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//전공의 수련 보조수당
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//중소기업취업 청년 소득세 감면
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//조세조약상 교직자 감면      
	        		
	        		//sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "JAG_AMT"),"0",10));//비과세 계
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//비과세 계
	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10)); //2010, 감면소득계

	        		//기납부세액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INCM_TAX"),"0",10));//소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CITI_TAX"),"0",10));//지방소득세
	        		sbNPN_NO.append(JSPUtil.byteLpad("0","0",10));//종근무지 기납부 농특세 (자료 확인요망)
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT2),"0",2));//종(전)근무처일련번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",891));


	        		/**
	        		 * 소득공제명세 레코드
	        		 */
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("E".toUpperCase())){
	        		/*
	    		    System.out.println("-----------REL_CD1---------" +GauceUtils.nameValue(dsResult, i, "REL_CD1"));		        		
	    		    System.out.println("-----------NAM_KOR1---------" +GauceUtils.nameValue(dsResult, i, "NAM_KOR1"));	        		
	    		    System.out.println("-----------CET_NO1---------" +GauceUtils.nameValue(dsResult, i, "CET_NO1"));	    		    
	    		    System.out.println("-----------BAS_MAN1---------" +GauceUtils.nameValue(dsResult, i, "BAS_MAN1"));	        		
	    		    System.out.println("-----------TRB_MAN1---------" +GauceUtils.nameValue(dsResult, i, "TRB_MAN1"));	   	    		    
	        		 */
	    		    

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO1") == null || GauceUtils.nameValue(dsResult, i, "CET_NO1").trim().equals("")){
	        			TMP_YN1 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO1").substring(6,7)) < 5 ){
	        		//	TMP_YN1 = "1";
	        		}else{
	        			TMP_YN1 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO2") == null || GauceUtils.nameValue(dsResult, i, "CET_NO2").trim().equals("")){
	        			TMP_YN2 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO2").substring(6,7)) < 5 ){
	        		//	TMP_YN2 = "1";
	        		}else{
	        			TMP_YN2 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO3") == null || GauceUtils.nameValue(dsResult, i, "CET_NO3").trim().equals("")){
	        			TMP_YN3 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO3").substring(6,7)) < 5 ){
	        		//	TMP_YN3 = "1";
	        		}else{
	        			TMP_YN3 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO4") == null || GauceUtils.nameValue(dsResult, i, "CET_NO4").trim().equals("")){
	        			TMP_YN4 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO4").substring(6,7)) < 5 ){
	        		//	TMP_YN4 = "1";
	        		}else{
	        			TMP_YN4 = "1";
	        		}

	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO5") == null || GauceUtils.nameValue(dsResult, i, "CET_NO5").trim().equals("")){
	        			TMP_YN5 = " ";
	        		//}else if(Long.parseLong(GauceUtils.nameValue(dsResult, i, "CET_NO5").substring(6,7)) < 5 ){
	        		//	TMP_YN5 = "1";
	        		}else{
	        			TMP_YN5 = "1";
	        		}

	    		    /*	        		
	        		//if(GauceUtils.nameValue(dsResult, i, "CET_NO2").equals("8702096780193") == true){	     
	        		//	TMP_YN1 = "9";
	        		//}      		
	        		//System.out.println("NPN_NO : "+sbNPN_NO.toString());		
	        		*/
	        		
	        		TMP_YN1 = "1";
	        		TMP_YN2 = "1";
	        		TMP_YN3 = "1";
	        		TMP_YN4 = "1";
	        		TMP_YN5 = "1";
	        		
	        		LN_CNT3 = LN_CNT3 + 1;

	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));//레코드 구분
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));//자료구분+세무서
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));//일련번호

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));//사업자등록번호

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));//소득자 주민등록번호

	        		//소득공제명세1의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD1")," ",1));//관계1
	        		sbNPN_NO.append(TMP_YN1);//내외국인구분코드1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR1")," ",20));//성명1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO1")," ",13));//주민등록번호1		
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN1")," ",1));//기본공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN1")," ",1));//장애인공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN1")," ",1));//부녀자공제1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN1")," ",1));//경로우대공제1
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN1")," ",1));//한부모1              	

	        		
	        		//소득공제명세1의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS1"),"0",10));//보험료1_건강고용보험
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS1"),"0",10));//보험료1_보장성	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS1"),"0",10));//의료비1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS1"),"0",10));//교육비1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS1"),"0",10));//신용카드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS1"),"0",10));//직불선불카드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS1"),"0",10));//현금영수증1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS1"),"0",10));//전통시장사용액1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS1"),"0",10));//대중교통이용액1	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS1"),"0",13));//기부금1

	        		//소득공제명세1의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT1"),"0",10));//보험료1 외_건강고용보험
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT1"),"0",10));//보험료1 외_보장성	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT1"),"0",10));//의료비1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT1"),"0",10));//교육비1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT1"),"0",10));//신용카드1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT1"),"0",10));//직불선불카드1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT1"),"0",10));//전통시장 사용액1 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT1"),"0",10));//대중교통이용액1	 외	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT1"),"0",13));//기부금1 외

	        		//소득공제명세2의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD2")," ",1));//관계2
	        		sbNPN_NO.append(TMP_YN2);//내외국인구분코드2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR2")," ",20));//성명2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO2")," ",13));//주민등록번호2
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN2")," ",1));//
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN2")," ",1));//
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN2")," ",1));//한부모2     
                	
	        		//소득공제명세2의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS2"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS2"),"0",10));//신용카드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS2"),"0",10));//직불선불카드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS2"),"0",10));//현금영수증2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS2"),"0",10));//전통시장사용액2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS2"),"0",10));//대중교통이용액2 	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS2"),"0",13));//기부금2


	        		//소득공제명세2의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT2"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT2"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT2"),"0",10));//전통시장 사용액2 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT2"),"0",10));//대중교통이용액2	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT2"),"0",13));

	        		//소득공제명세3의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD3")," ",1));
	        		sbNPN_NO.append(TMP_YN3);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR3")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO3")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN3")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN3")," ",1));
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN3")," ",1));//한부모3   
                	
	        		//소득공제명세3의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS3"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS3"),"0",10));//전통시장사용액3	  
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS3"),"0",10));//대중교통이용액3		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS3"),"0",13));

	        		//소득공제명세3의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT3"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT3"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT3"),"0",10));//전통시장 사용액3 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT3"),"0",10));//대중교통이용액3	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT3"),"0",13));

	        		//소득공제명세4의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD4")," ",1));
	        		sbNPN_NO.append(TMP_YN4);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR4")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO4")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN4")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN4")," ",1));//장애인공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN4")," ",1));//부녀자공제4
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN4")," ",1));//경로우대공제4
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN4")," ",1));//한부모4   
                	
	        		//소득공제명세4의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS4"),"0",10));//보험료4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS4"),"0",10));//보험료4	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS4"),"0",10));//의료비4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS4"),"0",10));//교육비4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS4"),"0",10));//신용카드4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS4"),"0",10));//직불선불카드4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS4"),"0",10));//현금영수증4
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS4"),"0",10));//전통시장사용액4	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS4"),"0",10));//대중교통이용액4	  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS4"),"0",13));//기부금4

	        		//소득공제명세4의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT4"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT4"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT4"),"0",10));//전통시장 사용액4 외
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT4"),"0",10));//대중교통이용액4	 외		        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT4"),"0",13));//기부금4외

       		
	        		
	        		//소득공제명세5의 인적사항
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REL_CD5")," ",1));
	        		sbNPN_NO.append(TMP_YN5);
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "NAM_KOR5")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO5")," ",13));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "BAS_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TRB_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "WCT_MAN5")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "GOL_MAN5")," ",1));
                	sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ONE_MAN5")," ",1));//한부모5   
	 
	        		//소득공제명세5의 국세청자료 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_NTS5"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CASH_NTS5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_NTS5"),"0",10));//전통시장사용액5
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_NTS5"),"0",10));//대중교통이용액5  	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT_NTS5"),"0",13));//기부금5

	        		//소득공제명세5의 국세청자료 이외의 공제금액
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV_AMT5"),"0",10));        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "INV2_AMT5"),"0",10));	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MED_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "EDU_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "CARD_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DIR_CARD_AMT5"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "MARKET_AMT5"),"0",10));//전통시장 사용액5 외	
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PUBLIC_AMT5"),"0",10));//대중교통이용액5	 외	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "LC3_AMT5"),"0",13));//기부금5외
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT3),"0",2));
	        		
	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",303));
	        		//System.out.println("NPN_NO : "+sbNPN_NO.toString());	
	        		
	        		
	        	}else if(GauceUtils.nameValue(dsResult, i, "REC_TAG").equals("F".toUpperCase())){

	        		
	        		
	        		
	        		
	        		
	        		
	        		

	        		
	        		//자료관리번호
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "REC_TAG")," ",1));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "TAX_CD")," ",5));
	        		sbNPN_NO.append(JSPUtil.byteLpad(Integer.toString(LN_CNT1),"0",6));

	        		//원천징수의무자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "COMP_CD")," ",10));

	        		//소득자
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "CET_NO")," ",13));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_1")," ",2));//소득공제구분1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_1")," ",3));//금융기관코드1
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_1")," ",30));//금융기관상호1
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_1")," ",20));//계좌번호(또는 증권번호)	        		
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_1"),"0",10));//납입금액1
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6510151683513") == true){	     //권기환
	        			sbNPN_NO.append("0000336000"); //납입금액1    
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6511161785941") == true){	  //최규훈  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액1   	        	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5811151659025") == true){	  //정종국  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액1 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7006171037719") == true){	  //소병진  	        			
	        			sbNPN_NO.append("0000432000"); //납입금액1 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7907191095519") == true){	   //김상수 	        			
	        			sbNPN_NO.append("0000379200"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6711291790211") == true){	   //이종훈	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1         		
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6708301822513") == true){	    //정성학	        			
	        			sbNPN_NO.append("0000144000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7110041836316") == true){	    //이만재	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	    //이영하 	        			
	        			sbNPN_NO.append("0000096000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8209072177411") == true){	   //이래경 	        			
	        			sbNPN_NO.append("0000100800"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7211291535932") == true){	  //이석재  	        			
	        			sbNPN_NO.append("0000396000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7409041810118") == true){	  //박제성 	        			
	        			sbNPN_NO.append("0000364800"); //납입금액1   		        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	  //김종학   	        			
	        			sbNPN_NO.append("0000360000"); //납입금액1   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	  //김창기 	        			
	        			sbNPN_NO.append("0000450000"); //납입금액1 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	   //김안수 	        			
	        			sbNPN_NO.append("0000288000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	  //김태현  	        			
	        			sbNPN_NO.append("0000072000"); //납입금액1   	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	  //김영수  	        			
	        			sbNPN_NO.append("0000288000"); //납입금액1   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	   //권헌영 	        			
	        			sbNPN_NO.append("0000115200"); //납입금액1   	        			        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_1"),"0",10));//소득, 세액공제금액1
	        		}			        		
	        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_2")," ",2));//소득공제구분2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_2")," ",3));//금융기관코드2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_2")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_2")," ",20));//계좌번호(또는 증권번호)2
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_2"),"0",10));//납입금액2	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6510151683513") == true){	    	//권기환 
	        			sbNPN_NO.append("0000144000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6511161785941") == true){	  //최규훈  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액2   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("5811151659025") == true){	  //정종국  	        			
	        			sbNPN_NO.append("0000240000"); //납입금액2	   	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7006171037719") == true){	  //소병진  	        			
	        			sbNPN_NO.append("0000048000"); //납입금액2	     	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7907191095519") == true){	 //김상수   	        			
	        			sbNPN_NO.append("0000100800"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6711291790211") == true){	  //이종훈  	        			
	        			sbNPN_NO.append("0000364800"); //납입금액2         		
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6708301822513") == true){	  //정성학	   	      	
	        			sbNPN_NO.append("0000336000"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7110041836316") == true){	  //이만재  	        			
	        			sbNPN_NO.append("0000364800"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6507291056414") == true){	  //이영하  	        			
	        			sbNPN_NO.append("0000384000"); //납입금액2  	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("8209072177411") == true){	  //이래경 	        			
	        			sbNPN_NO.append("0000379200"); //납입금액2   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7409041810118") == true){	 //박제성    	        			
	        			sbNPN_NO.append("0000115200"); //납입금액2  		        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	 //김종학   	        			
	        			sbNPN_NO.append("0000120000"); //납입금액2 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	 //김창기   	        			
	        			sbNPN_NO.append("0000030000"); //납입금액2
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	 //김안수   	        			
	        			sbNPN_NO.append("0000144000"); //납입금액2 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	 //김태현   	        			
	        			sbNPN_NO.append("0000012000"); //납입금액2 		        	
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	//김영수    	        			
	        			sbNPN_NO.append("0000144000"); //납입금액2  
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	 //권헌영   	        			
	        			sbNPN_NO.append("0000072000"); //납입금액2   	        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_2"),"0",10));
	        		}			        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_3")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_3")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_3")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_3")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_3"),"0",10));//납입금액3
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	 //김영수
	        			sbNPN_NO.append("0000048000"); //납입금액3   
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("4811231047816") == true){	  //김종학   	        			
	        			sbNPN_NO.append("0000000000"); //납입금액3 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6502151690514") == true){	  //김창기  	        			
	        			sbNPN_NO.append("0000000000"); //납입금액3
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6407221467211") == true){	   //김안수 	        			
	        			sbNPN_NO.append("0000048000"); //납입금액3 	        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7701091026015") == true){	   //김태현 	        			
	        			sbNPN_NO.append("0000396000"); //납입금액3			        			
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	  //권헌영   	        			
	        			sbNPN_NO.append("0000144000"); //납입금액3 
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7211291535932") == true){	 //이석재   	        			
	        			sbNPN_NO.append("0000084000"); //납입금액3	        				        			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_3"),"0",10));
	        		}			        		
	        		


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_4")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_4")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_4")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_4")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_4"),"0",10));//납입금액3	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("6210021345421") == true){	 //김영수
	        			sbNPN_NO.append("0000000000"); //납입금액4  
	        		}else if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	    //권헌영	        			
	        			sbNPN_NO.append("0000148800"); //납입금액4          			
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_4"),"0",10));
	        		}			


	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_5")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_5")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_5")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_5")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_5"),"0",10));//납입금액5	        		
	        		if(GauceUtils.nameValue(dsResult, i, "CET_NO").equals("7104061813011") == true){	 //권헌영
	        			sbNPN_NO.append("0000000000"); //납입금액5  
	        		}else{	        		
		        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_5"),"0",10));
	        		}		



	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_6")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_6")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_6")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_6")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_6"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_6"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_7")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_7")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_7")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_7")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_7"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_7"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_8")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_8")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_8")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_8")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_8"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_8"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_9")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_9")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_9")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_9")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_9"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_9"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_10")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_10")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_10")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_10")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_10"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_10"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_11")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_11")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_11")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_11")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_11"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_11"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_12")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_12")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_12")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_12")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_12"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_12"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_13")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_13")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_13")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_13")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_13"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_13"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_14")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_14")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_14")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_14")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_14"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_14"),"0",10));

	        		//연금저축소득공제
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "PEN_GUBUN_CD_15")," ",2));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_CD_15")," ",3));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "ABA_NM_15")," ",30));
	        		sbNPN_NO.append(JSPUtil.byteRpad(GauceUtils.nameValue(dsResult, i, "ACC_NO_15")," ",20));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "AMOUNT_15"),"0",10));
	        		sbNPN_NO.append(JSPUtil.byteLpad(GauceUtils.nameValue(dsResult, i, "DED_AMT_15"),"0",10));

	        		sbNPN_NO.append(JSPUtil.byteRpad(" "," ",360));
	        	}

	        	//System.out.println("NUM : "+Integer.toString(NUM++));
	        	//System.out.println("NPN_NO : "+sbNPN_NO.toString());

		        dvo.set("NUM", Integer.toString(NUM++));
		        dvo.set("NPN_NO", sbNPN_NO.toString());
		        dvoList.add(dvo);
	        }

        }

        return dvoList;
    }
	
	/**
     * 의료비
     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
     * @param p_box
     * @return
     * @throws CException
     */
    public DynamicValueObject YACA001_SHR_FILE_02_15(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
    	YACA001DAO dao = new YACA001DAO("default");

        return dao.YACA001_SHR_FILE_02_15(p_box);
    }
    
	/**
     * 기부금
     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
     * @param p_box
     * @return
     * @throws CException
     */
    public DynamicValueObject YACA001_SHR_FILE_03_15(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
    	YACA001DAO dao = new YACA001DAO("default");

        return dao.YACA001_SHR_FILE_03_15(p_box);
    }    
	
    
	/**
     * 기부금
     * (값을 DataSet이 아니라 DynamicValueObject로 가져온다.)
     * @param p_box
     * @return
     * @throws CException
     */
    public DynamicValueObject YACA001_SHR_FILE_03_142(CBox p_box) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
    	YACA001DAO dao = new YACA001DAO("default");

        return dao.YACA001_SHR_FILE_03_142(p_box);
    }      
    
}


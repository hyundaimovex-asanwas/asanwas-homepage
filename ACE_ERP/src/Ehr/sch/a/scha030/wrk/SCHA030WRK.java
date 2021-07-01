package Ehr.sch.a.scha030.wrk;

import Ehr.sch.a.scha030.dao.SCHA030DAO;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.sql.Connection;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;
import Ehr.common.util.DbManager;
import Ehr.common.util.HuniBill;

public class SCHA030WRK {

	/**
	 * 학자금 신청서 처리 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA030_SHR(CBox p_box, TrBox p_tr) throws CException {

			SCHA030DAO dao = new SCHA030DAO("default", p_tr);
			SCHA030DAO dao2 = new SCHA030DAO("default", p_tr);
			
			dao.SCHA030_SHR(p_box);
			
			/** 개인정보처리 접속 기록  **/
			dao2.SCHA030_SHR_ACC(p_box);    			
			
	}

	/**
	 * 학자금금 신청서를 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA030_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_SCHLBOOK");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		SCHA030DAO dao = new SCHA030DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
				* 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
			
				case 3:
					// 학자금 신청서를 수정하기 위한 DAO메소드 호출
					dao.SCHA030_UPT(vo, p_box);
					break;
					
			}
		}
	}
	/**
	 * 결재현황처리 로직
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA030_APPROVAL( CBox p_box, TrBox p_tr ) throws CException {
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_SCHLBOOK");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		SCHA030DAO dao = new SCHA030DAO("default", p_tr);
		GauceDataSet printDs = dao.SCHA030_PRC_SHR_PRINT(p_box);
		String printNo = GauceUtils.nameValue(printDs, 1, "PRINT_NO");
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
				* 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
			
				case 3:
					
					// 학자금 신청서를 수정하기 위한 DAO메소드 호출
					if("T".equals(vo.get("IS_CHK"))){
						
						p_box.set("PRINT_NO", printNo);
						
						dao.SCHA010_PRC_UPT_02(vo, p_box);
					}
					
					break;
			}
		}

		p_tr.setOutDataSet( "dsT_SC_SCHLBOOK_APPROVAL",   printDs );
	}
	

}


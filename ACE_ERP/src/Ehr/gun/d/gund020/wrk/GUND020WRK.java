package Ehr.gun.d.gund020.wrk;

import Ehr.gun.d.gund020.dao.GUND020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUND020WRK {

	/**
	 * 연차발생관리 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND020_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUND020DAO dao = new GUND020DAO("default", p_tr);

			/**조회한 근태휴일날짜  Dataset을 "dsT_DI_HOLIDAY" Alias Name으로 반환  **/
			p_tr.setOutDataSet("dsT_DI_HOLIDAY", dao.GUND020_SHR_01(p_box));

			p_tr.setOutDataSet("dsT_DI_ACCELERATE", dao.GUND020_SHR_02(p_box));
//          6.결재선조회
            p_tr.setOutDataSet( "dsT_DI_APPROVAL", dao.GUND020_SHR_05(p_box) );
	}
	/**
	 * 근태부서  조회해 오는 WORK메소드.
	 */
	public void GUND020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			GUND020DAO dao = new GUND020DAO("default", p_tr);

	        /** 인사기록표 SELECT하는 DAO 메소드 호출 */
			dao.GUND020_SHR_07(p_box);


	}
	/**
	 * 연차발생관리를 수정 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUND020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_ACCELERATE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUND020DAO dao = new GUND020DAO("default", p_tr);

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);




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
				case 2:
					// insert
					break;
				case 3:
					for(int j= Integer.parseInt(mm1); j<= Integer.parseInt(mm3); j++){
						// 연차휴가사용촉진제를 수정하기 위한 DAO메소드 호출
						dao.GUND020_DEL(vo, p_box, j);
						dao.GUND020_INS(vo, p_box, j);
					}
					break;
				case 4:
					// delete;
					break;
				}
			}
	}

	/**
	 * 결재선 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND020_REP(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		// 결재선 정보 등록 수정
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUND020DAO dao = new GUND020DAO("default", p_tr);
		String REQ_NO = "";
		if(voList2.size() > 0){
			GauceValueObject voRegNo = voList2.get(0);
			REQ_NO = JSPUtil.rns(voRegNo.get("REQ_NO"));
			if("".equals(REQ_NO)){
		        REQ_NO = dao.GUND020_SHR_MAX();
			}

		}else{
			if(voList2.size() > 0){
				GauceValueObject voRegNo = voList2.get(0);
				REQ_NO = JSPUtil.rns(voRegNo.get("REQ_NO"));
			}
		}

		if(voList2.size() > 0){
			GauceValueObject vo2 = voList2.get(0);
			vo2.set("REQ_NO", REQ_NO);
			dao.GUND020_DEL_01(vo2, p_box);
		}

		for(int i = 0; i < voList2.size(); i++){
			GauceValueObject vo2 = voList2.get(i);
			vo2.set("REQ_NO", REQ_NO);

			dao.GUND020_INS_01(vo2, p_box);
		}
		GauceDataSet ds = dao.GUND020_SHR_06(p_box);
		for(int i = 1; i <= ds.getDataRowCnt(); i++){
			String PIS_YY = GauceUtils.nameValue(ds, i, 	"PIS_YY");
			String PIS_MM = GauceUtils.nameValue(ds, i, 	"PIS_MM");
			String ENO_NO = GauceUtils.nameValue(ds, i, 	"ENO_NO");
			dao.GUND020_INS_02(PIS_YY, PIS_MM, ENO_NO, REQ_NO);
		}
	}
}

package Ehr.gun.a.guna012.wrk;

import java.sql.Connection;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.but.a.buta020.dao.BUTA020DAO;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.DbManager;
import Ehr.common.util.JSPUtil;

public class GUNA012WRK {


	/**
	 * 목록을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA012_SHR_LST(CBox p_box, TrBox p_tr) throws CException {

		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",  dao.GUNA012_SHR_LST(p_box) );

	}

	/**
	 * 상세 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA012_SHR(CBox p_box, TrBox p_tr) throws CException {

		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		GUNA012DAO dao2 = new GUNA012DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",     dao.GUNA012_SHR(p_box) );
		
		p_tr.setOutDataSet( "dsT_DI_APPROVAL",      dao2.GUNA012_SHR_02(p_box) );

	}

	/**
	 * 개인별근태 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA012_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");
		
		// 결재선 정보 등록 수정
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		GUNA012DAO dao2 = new GUNA012DAO("default", p_tr);
		GUNA012DAO dao3 = new GUNA012DAO("default", p_tr);
		
		GauceDataSet ds = null;//등록된 장기근태 일자를 가져오기 위한 데이터셋

		int pis_yymmdd_vo = 0;
		int pis_yymmdd = 0;
		
		String reg_no_vo = "";
		String msg = "";
		String REQ_NO = "";
		
		if(voList.size() > 0){
			
			GauceValueObject voRegNo = voList.get(0);
			
			REQ_NO = JSPUtil.rns(voRegNo.get("REQ_NO"));
			
			if("".equals(REQ_NO)){
				
		        REQ_NO = dao.GUNA012_SHR_MAX();
		        
			}

		}else{
			
			if(voList2.size() > 0){
				
				GauceValueObject voRegNo = voList2.get(0);
				
				REQ_NO = JSPUtil.rns(voRegNo.get("REQ_NO"));
				
			}
			
		}


		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			pis_yymmdd_vo = Integer.parseInt(vo.get("PIS_YYMMDD").replaceAll("-", ""));
			
			reg_no_vo = vo.get("REQ_NO").replaceAll("-", "");
			
			ds = this.GUNA012_SHR_01(vo, p_tr);

			for(int j=1;j<=ds.getDataRowCnt();j++){

				pis_yymmdd = Integer.parseInt(GauceUtils.nameValue(ds, j, "PIS_YYMMDD"));

					if(pis_yymmdd_vo == pis_yymmdd ){
						
						if(vo.getInt("TX_MODE") == 2){
							
							msg = vo.get("ENO_NM")+"("+vo.get("ENO_NO")+")의 데이터가\n";
							
							msg = msg + "현재 저장되어 있는 자료와 중복된 기간을 포함하고 있습니다.\n";
							
							msg = msg + "확인 후 다시 저장해 주세요!";

							throw new BizException(msg);
							
						}

					}

			}

			/**
				* 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					
					vo.set("REQ_NO", REQ_NO);
					
					// 장기근태 정보를 저장하기 위한 DAO메소드 호출
					this.GUNA012_INS(vo, p_box, p_tr);
					
					break;
					
				case 3:
					
					// 장기근태 정보를 수정하기 위한 DAO메소드 호출
					
					dao3.GUNA012_UPT(vo, p_box);
					
					break;
					
				case 4:
					
					// delete;

					break;
			}
			
		}

		//결재선 하나로 수정
		
		GUNA012DAO dao4 = new GUNA012DAO("default", p_tr);
		GUNA012DAO dao5 = new GUNA012DAO("default", p_tr);
		
		if(voList2.size() > 0){
			
			GauceValueObject vo2 = voList2.get(0);
			
			vo2.set("REQ_NO", REQ_NO);
			
			dao4.GUNA012_DEL_01(vo2, p_box);
			
		}
		

		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);
			
			vo2.set("REQ_NO", REQ_NO);
			
			this.GUNA012_INS_01(vo2, p_box, p_tr);

		}

		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_TEMP",     dao5.GUNA012_SHR(REQ_NO) );

		try{
			

			
		}catch(Exception e){e.printStackTrace();}

	}

	public GauceDataSet GUNA012_SHR_01(GauceValueObject vo, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);

		return dao.GUNA012_SHR_01(vo);

	}		
	
	public void GUNA012_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);

		dao.GUNA012_INS(vo, p_box);

	}			

	public void GUNA012_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);

		dao.GUNA012_INS_01(vo, p_box);

	}	
	
	

	
	/**
	 * 개인근태 정보를 삭제 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void GUNA012_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");
		
		if(voList.size() > 0){
			
			GauceValueObject vo = voList.get(0);
			
			String REQ_NO = JSPUtil.rns(vo.get("REQ_NO"));

			/** 해당 row를 삭제한다 **/
			// delete;
			dao.GUNA012_DEL(vo, p_box);
			
		}


	}
	
	
	/**
	 * 연차정보 조회하기
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA012_YRP(CBox p_box, TrBox p_tr) throws CException {

		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		
		GauceDataSet ds = dao.GUNA012_YRP(p_box);
		
		p_tr.setOutDataSet( "dsT_DI_YEARLY",     ds );
		
	}
	
}



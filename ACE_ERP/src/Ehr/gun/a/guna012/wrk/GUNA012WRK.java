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
	 * ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA012_SHR_LST(CBox p_box, TrBox p_tr) throws CException {

		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",  dao.GUNA012_SHR_LST(p_box) );

	}

	/**
	 * �� ������ ��ȸ�� ���� WORK�޼ҵ�.
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
	 * ���κ����� ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA012_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");
		
		// ���缱 ���� ��� ����
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		GUNA012DAO dao2 = new GUNA012DAO("default", p_tr);
		GUNA012DAO dao3 = new GUNA012DAO("default", p_tr);
		
		GauceDataSet ds = null;//��ϵ� ������ ���ڸ� �������� ���� �����ͼ�

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

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			pis_yymmdd_vo = Integer.parseInt(vo.get("PIS_YYMMDD").replaceAll("-", ""));
			
			reg_no_vo = vo.get("REQ_NO").replaceAll("-", "");
			
			ds = this.GUNA012_SHR_01(vo, p_tr);

			for(int j=1;j<=ds.getDataRowCnt();j++){

				pis_yymmdd = Integer.parseInt(GauceUtils.nameValue(ds, j, "PIS_YYMMDD"));

					if(pis_yymmdd_vo == pis_yymmdd ){
						
						if(vo.getInt("TX_MODE") == 2){
							
							msg = vo.get("ENO_NM")+"("+vo.get("ENO_NO")+")�� �����Ͱ�\n";
							
							msg = msg + "���� ����Ǿ� �ִ� �ڷ�� �ߺ��� �Ⱓ�� �����ϰ� �ֽ��ϴ�.\n";
							
							msg = msg + "Ȯ�� �� �ٽ� ������ �ּ���!";

							throw new BizException(msg);
							
						}

					}

			}

			/**
				* Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
				*  - 1 : NORMAL
				*  - 2 : INSERT
				*  - 3 : UPDATE
				*  - 4 : DELETE
				*/
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					
					vo.set("REQ_NO", REQ_NO);
					
					// ������ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					this.GUNA012_INS(vo, p_box, p_tr);
					
					break;
					
				case 3:
					
					// ������ ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					
					dao3.GUNA012_UPT(vo, p_box);
					
					break;
					
				case 4:
					
					// delete;

					break;
			}
			
		}

		//���缱 �ϳ��� ����
		
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

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);

		return dao.GUNA012_SHR_01(vo);

	}		
	
	public void GUNA012_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);

		dao.GUNA012_INS(vo, p_box);

	}			

	public void GUNA012_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);

		dao.GUNA012_INS_01(vo, p_box);

	}	
	
	

	
	/**
	 * ���α��� ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNA012_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA012DAO dao = new GUNA012DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");
		
		if(voList.size() > 0){
			
			GauceValueObject vo = voList.get(0);
			
			String REQ_NO = JSPUtil.rns(vo.get("REQ_NO"));

			/** �ش� row�� �����Ѵ� **/
			// delete;
			dao.GUNA012_DEL(vo, p_box);
			
		}


	}
	
	
	/**
	 * �������� ��ȸ�ϱ�
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



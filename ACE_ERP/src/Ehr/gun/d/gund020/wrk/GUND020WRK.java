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
	 * �����߻����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND020_SHR(CBox p_box, TrBox p_tr) throws CException {

			GUND020DAO dao = new GUND020DAO("default", p_tr);

			/**��ȸ�� �������ϳ�¥  Dataset�� "dsT_DI_HOLIDAY" Alias Name���� ��ȯ  **/
			p_tr.setOutDataSet("dsT_DI_HOLIDAY", dao.GUND020_SHR_01(p_box));

			p_tr.setOutDataSet("dsT_DI_ACCELERATE", dao.GUND020_SHR_02(p_box));
//          6.���缱��ȸ
            p_tr.setOutDataSet( "dsT_DI_APPROVAL", dao.GUND020_SHR_05(p_box) );
	}
	/**
	 * ���ºμ�  ��ȸ�� ���� WORK�޼ҵ�.
	 */
	public void GUND020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			GUND020DAO dao = new GUND020DAO("default", p_tr);

	        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao.GUND020_SHR_07(p_box);


	}
	/**
	 * �����߻������� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUND020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_ACCELERATE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUND020DAO dao = new GUND020DAO("default", p_tr);

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);




		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
				* Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
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
						// �����ް������������ �����ϱ� ���� DAO�޼ҵ� ȣ��
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
	 * ���缱 ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND020_REP(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		// ���缱 ���� ��� ����
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
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

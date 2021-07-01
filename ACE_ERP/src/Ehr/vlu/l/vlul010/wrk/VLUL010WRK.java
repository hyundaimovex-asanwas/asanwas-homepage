package Ehr.vlu.l.vlul010.wrk;

import Ehr.vlu.l.vlul010.dao.VLUL010DAO;
import Ehr.yac.a.yaca040.dao.YACA040DAO;
//import hr.vlu.i.vlui110.dao.VLUI110DAO;
//import hr.vlu.i.vlui120.dao.VLUI120DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUL010WRK {


	public void VLUL010_SHR(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsHWORKMST = new GauceDataSet();

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

		dsHWORKMST = dao.VLUL010_SHR(p_box);

		p_tr.setOutDataSet("dsT_EV_HWORKMST", dsHWORKMST);

	}

	public void VLUL010_SHR_00(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsABLRST = new GauceDataSet();

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

		dsABLRST = dao.VLUL010_SHR_00(p_box);

		p_tr.setOutDataSet("dsT_EV_ABLRST", dsABLRST);

	}

	public void VLUL010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsHWORKDTL = new GauceDataSet();

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

		dsHWORKDTL = dao.VLUL010_SHR_01(p_box);

		p_tr.setOutDataSet("dsT_EV_HWORKDTL", dsHWORKDTL);

	}

	public void VLUL010_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsHWORKDTL = new GauceDataSet();

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

		dsHWORKDTL = dao.VLUL010_SHR_02(p_box);

		p_tr.setOutDataSet("dsT_EV_HWORKDTL_CP", dsHWORKDTL);

	}
	
	public void VLUL010_SHR_CHK(CBox p_box, TrBox p_tr) throws CException {

		/** VLUI110DAO 객체 생성 후 관련 메소드 호출 */
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUL010_SHR_CHK(p_box);

	}

	public void VLUL010_SHR_TERM(CBox p_box, TrBox p_tr) throws CException {

		/** VLUI110DAO 객체 생성 후 관련 메소드 호출 */
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUL010_SHR_TERM(p_box);

	}

	public void VLUL010_SHR_LENGTH(CBox p_box, TrBox p_tr) throws CException {

		/** VLUI110DAO 객체 생성 후 관련 메소드 호출 */
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUL010_SHR_LENGTH(p_box);

	}

	public void VLUL010_SHR_SUB(CBox p_box, TrBox p_tr) throws CException {

		/** VLUI110DAO 객체 생성 후 관련 메소드 호출 */
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		//dao.VLUL010_SHR_SUB(p_box);
		p_tr.setOutDataSet( "dsT_EV_HWORKMST",       dao.VLUL010_SHR_SUB(p_box) );
		
		
	}	
	

	public void VLUL010_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_HWORKMST");
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_EV_HWORKDTL");

		VLUL010DAO dao = new VLUL010DAO("default", p_tr);
		VLUL010DAO dao2 = new VLUL010DAO("default", p_tr);
		VLUL010DAO dao3 = new VLUL010DAO("default", p_tr);		

		
		for (int i=0; i<voList.size(); i++) {

			GauceValueObject vo = voList.get(i);

			String EVAYM = vo.get("EVAYM") ;
			String EMPNO = vo.get("EMPNO") ;

			GauceDataSet dsCNT = new GauceDataSet();

			dsCNT= dao.VLUL010_SHR_CNT(EVAYM,EMPNO);

			String CNT = GauceUtils.nameValue(dsCNT, 1, "CNT");

			if("0".equals(CNT)){
				
				dao2.VLUL010_SAV_MST(vo, p_box);
				
			}else if("1".equals(CNT)){
				
				dao2.VLUL010_UPT_MST(vo, p_box);
				
			}

			dao3.VLUL010_DEL(vo, p_box);	

		}

	
		
		for (int i=0; i<voList1.size(); i++) {

			GauceValueObject vo1 = voList1.get(i);

			switch (vo1.getInt("TX_MODE")) {
			
			case 2:
				
				this.VLUL010_SAV_DTL(vo1, p_box,p_tr);
				//dao4.VLUL010_SAV_DTL(vo1, p_box);
				break;
				
			case 3:
				
				//dao.VLUL010_SAV_DTL(vo1, p_box);
				//dao.VLUL010_UPT_DTL(vo1, p_box);
				break;
			case 4:
				//dao.VLUL010_DEL_DTL(vo1, p_box);
				break;
			}

		}

	}

	
	public void VLUL010_SAV_DTL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL010DAO dao = new VLUL010DAO("default", p_tr);

		dao.VLUL010_SAV_DTL(vo, p_box);

	}			
	
	
}

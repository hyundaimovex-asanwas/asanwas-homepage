package Ehr.sag.d.sagd030.wrk;

import Ehr.sag.d.sagd030.dao.SAGD030DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGD030WRK {

	/**
	 * 급여계산처리 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		dao.SAGD030_SHR(p_box);

	}

	/**
	 * 작업로그 신규저장 (작업 OPEN)
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);

		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_INS(p_box, vo);

	}

	/**
	 * 대상자 선정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD030_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		//프로시져 대상자 선정
		dao.SAGD030_INS_01(p_box, vo);

		//작업 LOG 수정(처리인원)
		dao2.SAGD030_UPT_02(p_box, vo);

	}



	/**
	 * 대상자 초기화
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD030_SAV_02( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao3 = new SAGD030DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/

		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_UPT_03(p_box, vo);//작업로그 대상자 선정 전 상태로 변경

		dao2.SAGD030_DEL(p_box, vo);//T_CP_PAYMASTER 삭제

		dao3.SAGD030_DEL_01(p_box, vo);//T_CP_PAYMASTER_OFFICE 삭제

	}

	/**
	 * 금액·세액계산
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD030_SAV_03( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		//프로시져 사용 금액·세액계산 일괄 처리

		dao.SAGD030_INS_03(p_box, vo);

		//작업 LOG 수정(처리인원)
		//dao2.SAGD030_UPT_02(p_box, vo);		
		
	}

	/**
	 * 계산 초기화
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD030_SAV_04( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao3 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao4 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao5 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao6 = new SAGD030DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_UPT_04(p_box, vo);//작업로그 금액, 세액 계산 전 상태로 변경

		dao2.SAGD030_UPT_05(p_box, vo);//T_CP_PAYMASTER 계산금액 0으로 초기화

		dao3.SAGD030_DEL_02(p_box, vo);//T_CP_NCHANGE 계산 전으로 초기화 = 삭제

		dao4.SAGD030_DEL_03(p_box, vo);//T_AC_LOAN(대출금/출자금) 계산 전으로 초기화

		dao5.SAGD030_UPT_06(p_box, vo);//T_SV_SAVELIST(저축금관리목록) 계산 전으로 초기화

		dao6.SAGD030_DEL_04(p_box, vo);//T_SV_SAVEBOOK(저축금납입관리) 계산 전으로 초기화
	}

	/**
	 * 작업CLOSE
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD030_SAV_05( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);

		int i=0;

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_UPT_04(p_box, vo);//작업로그 작업CLOSE 상태로 변경


	}

}


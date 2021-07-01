package Ehr.sag.d.sagd010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGD010DAO extends AbstractDAO {

	/**
	 * SAGD010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 급여테이블 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_SHR");

		//System.out.print(">>>>>>>>>>>>>>>>>>  PIS_YY_SHR = " +p_box.get("PIS_YY_SHR"));
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),
		};

		prop.add("P01_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P02_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P03_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P04_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P05_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAL_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 적용일자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 급여테이블 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),


				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk

				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 급여테이블 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_UPT2(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_UPT2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {


				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk

				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 급여테이블 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_UPT3(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_UPT3");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {


				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	/**
	 * 급여테이블 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_UPT");

        int sum;

        //System.out.print(">>>>>>>>>>>>>>>>>>  P01_AMT = " +Integer.parseInt(vo.get("P01_AMT")));

        
        sum = Integer.parseInt(vo.get("P01_AMT")) +
		        Integer.parseInt(vo.get("P02_AMT")) +
		        Integer.parseInt(vo.get("P03_AMT")) +
		        Integer.parseInt(vo.get("P04_AMT")) +
		        Integer.parseInt(vo.get("P05_AMT"));

        //System.out.print(">>>>>>>>>>>>>>>>>>  sum = " +sum);        
        
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns3(vo.get("P01_AMT")),
				JSPUtil.rns3(vo.get("P02_AMT")),
				JSPUtil.rns3(vo.get("P03_AMT")),
				JSPUtil.rns3(vo.get("P04_AMT")),
				JSPUtil.rns3(vo.get("P05_AMT")),
				Integer.toString(sum),
				JSPUtil.rns(p_box.get("vusrid")),//수정자
				JSPUtil.rns3(vo.get("ENO_NO")),//
				JSPUtil.rns3(vo.get("PIS_YY")),//
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 급여테이블 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("HOB_CD")),//pk
				JSPUtil.rns(vo.get("APY_YMD").replaceAll("-", "")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 급여테이블 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_DEL_01(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("sag", "SAGD010_DEL_01");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("OCC_CD")),//pk
	            JSPUtil.rns(p_box.get("APY_YMD").replaceAll("-", "")),//pk
	    };

	    /** DELETE메소드 호출  **/
	    deleteProcess(sql, bind);
	}

}

package Ehr.sag.d.sagd040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGD040DAO extends AbstractDAO {

	/**
	 * SAGB040DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 개인별 고정지불/공제 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD040_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_SHR");

		/** 조회 조건(사원번호/급여항목)에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();
		if (p_box.get("GBN").equals("ENO_NO")) {
			sb.append("AND A.ENO_NO LIKE '%"+p_box.get("ENO_NO")+"%'");
		}else if (p_box.get("GBN").equals("SAL_CD")) {
			sb.append("AND A.SAL_CD LIKE '%"+p_box.get("SAL_CD")+"%'");
		}


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").replaceAll("-", ""),						//
				p_box.get("PIS_YM").replaceAll("-", ""),						//				
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SAL_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("END_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);


		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 개인별 고정지불/공제 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD040_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				"1",												//직종 CODE
				vo.get("ENO_NO"),						//사원번호
				vo.get("SAL_CD"),						//수당항목
				vo.get("STR_YMD").replaceAll("-", ""),	//시작일
				vo.get("END_YMD").replaceAll("-", ""),	//종료일
				vo.get("AD_TAG"),						//지불/공제구분
				vo.get("AMOUNT"),						//금액
				p_box.get("vusrid"),						//입력자
				p_box.get("vusrid")						//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 개인별 수당 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD040_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("END_YMD").replaceAll("-", ""),	//종료일
				vo.get("AD_TAG"),						//지불/공제구분
				vo.get("AMOUNT"),						//금액
				p_box.get("vusrid"),				//수정자
				vo.get("OCC_CD"),						//직종 CODE
				vo.get("ENO_NO"),						//사원번호
				vo.get("SAL_CD"),						//수당항목
				vo.get("STR_YMD").replaceAll("-", ""),	//시작일
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 개인별 수당 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD040_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),								//직종 CODE
				vo.get("ENO_NO"),								//사원번호
				vo.get("SAL_CD"),								//급여항목
				vo.get("STR_YMD").replaceAll("-", ""),			//시작일
				vo.get("AD_TAG"),								//구분
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

}

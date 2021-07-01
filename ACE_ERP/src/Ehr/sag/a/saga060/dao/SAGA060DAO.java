package Ehr.sag.a.saga060.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA060DAO extends AbstractDAO {

	/**
	 * SAGA060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGA060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 급상여지급현황 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA060_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				//p_box.get("STR_YYMM_SHR").replaceAll("-", ""),
				p_box.get("END_YYMM_SHR").replaceAll("-", ""),
		};

		//prop.add("PERSONS_NUM", ColumnProp.COLUMN_TYPE_DECIMAL, 5.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("BAS_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 12.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("DUTY_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 12.0, ColumnProp.CONSTRAINT_TB_NORMAL);



		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}



	/**
	 *출력물 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA060_SHR_PRINT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_PRINT");

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {

		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);
		String pre_mm  = p_box.get("STR_YYMM_SHR").substring(5, 7);
		String now_mm = p_box.get("END_YYMM_SHR").substring(5, 7);
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("STR_YYMM_SHR").substring(0, 4),
				p_box.get("STR_YYMM_SHR").substring(5, 7),
				p_box.get("END_YYMM_SHR").substring(0, 4),
				p_box.get("END_YYMM_SHR").substring(5, 7),
				p_box.get("vcurdate"),
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				p_box.get("STR_YYMM_SHR").replaceAll("-", ""),
				p_box.get("END_YYMM_SHR").replaceAll("-", ""),

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void SAGA060_SHR_PRINT_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_PRINT_02");
		String pre_mm  = p_box.get("STR_YYMM_SHR").substring(5, 7);
		String now_mm = p_box.get("END_YYMM_SHR").substring(5, 7);
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {

		};
		
		//System.out.print(">>>>>>>>>>>>>>>>>>  p_box = " +p_box);
		
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("STR_YYMM_SHR").substring(0, 4),
				p_box.get("STR_YYMM_SHR").substring(5, 7),
				p_box.get("END_YYMM_SHR").substring(0, 4),
				p_box.get("END_YYMM_SHR").substring(5, 7),
				p_box.get("vcurdate"),
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				p_box.get("STR_YYMM_SHR").replaceAll("-", ""),
				p_box.get("END_YYMM_SHR").replaceAll("-", ""),

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void SAGA060_SHR_PRINT_03(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_PRINT_03");
		
		String pre_mm  = p_box.get("STR_YYMM_SHR").substring(5, 7);
		String now_mm = p_box.get("END_YYMM_SHR").substring(5, 7);
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {

		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("STR_YYMM_SHR").substring(0, 4),
				p_box.get("STR_YYMM_SHR").substring(5, 7),
				p_box.get("END_YYMM_SHR").substring(0, 4),
				p_box.get("END_YYMM_SHR").substring(5, 7),
				p_box.get("vcurdate"),
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				pre_mm,  now_mm,
				p_box.get("STR_YYMM_SHR").replaceAll("-", ""),
				p_box.get("END_YYMM_SHR").replaceAll("-", ""),

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}

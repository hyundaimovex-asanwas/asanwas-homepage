package Ehr.gun.a.guna016.dao;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA016DAO extends AbstractDAO {
	/**
	 * GUNA013DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA016DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}
	/**
	 * 목록를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA016_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA016_SHR");

		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR").replaceAll("-", ""));
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR").replaceAll("-", ""));
		String ENO_NO_SHR   = JSPUtil.rns(p_box.get("ENO_NO_SHR"));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,
				ENO_NO_SHR,
				STR_YMD_SHR,
				END_YMD_SHR,
				ENO_NO_SHR,
				ENO_NO_SHR,
				STR_YMD_SHR,
				END_YMD_SHR,
        };
		prop.add("REQ_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("OLD_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("OLD_GUN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("NEW_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("NEW_GUN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);
	}


}

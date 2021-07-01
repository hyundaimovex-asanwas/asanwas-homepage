package Ehr.yac.a.yaca080.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA080DAO extends AbstractDAO {

	/**
	 * YACA080DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA080DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 연말정산 개인별조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA080_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA080_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("DPT_CD_SHR"),
				p_box.get("ENO_NO_SHR"),				
		};

		prop.add("SALT_AMTT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		
		prop.add("FREE_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		
		//prop.add("MGR_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	/**
	 * 연말정산 개인별조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA080_SHR_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA080_SHR_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("DPT_CD_SHR"),
				p_box.get("ENO_NO_SHR"),				
		};

		prop.add("SALT_AMTT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		
		prop.add("FREE_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		
		//prop.add("MGR_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

}

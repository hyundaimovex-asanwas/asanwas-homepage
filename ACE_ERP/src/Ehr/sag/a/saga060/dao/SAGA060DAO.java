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
	 * SAGA060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGA060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �޻�������Ȳ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA060_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				//p_box.get("STR_YYMM_SHR").replaceAll("-", ""),
				p_box.get("END_YYMM_SHR").replaceAll("-", ""),
		};

		//prop.add("PERSONS_NUM", ColumnProp.COLUMN_TYPE_DECIMAL, 5.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("BAS_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 12.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("DUTY_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 12.0, ColumnProp.CONSTRAINT_TB_NORMAL);



		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}



	/**
	 *��¹� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA060_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_PRINT");

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {

		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);
		String pre_mm  = p_box.get("STR_YYMM_SHR").substring(5, 7);
		String now_mm = p_box.get("END_YYMM_SHR").substring(5, 7);
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void SAGA060_SHR_PRINT_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_PRINT_02");
		String pre_mm  = p_box.get("STR_YYMM_SHR").substring(5, 7);
		String now_mm = p_box.get("END_YYMM_SHR").substring(5, 7);
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {

		};
		
		//System.out.print(">>>>>>>>>>>>>>>>>>  p_box = " +p_box);
		
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void SAGA060_SHR_PRINT_03(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_PRINT_03");
		
		String pre_mm  = p_box.get("STR_YYMM_SHR").substring(5, 7);
		String now_mm = p_box.get("END_YYMM_SHR").substring(5, 7);
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {

		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}

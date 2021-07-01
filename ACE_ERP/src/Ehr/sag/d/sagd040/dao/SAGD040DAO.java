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
	 * SAGB040DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ���κ� ��������/���� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD040_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_SHR");

		/** ��ȸ ����(�����ȣ/�޿��׸�)�� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();
		if (p_box.get("GBN").equals("ENO_NO")) {
			sb.append("AND A.ENO_NO LIKE '%"+p_box.get("ENO_NO")+"%'");
		}else if (p_box.get("GBN").equals("SAL_CD")) {
			sb.append("AND A.SAL_CD LIKE '%"+p_box.get("SAL_CD")+"%'");
		}


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").replaceAll("-", ""),						//
				p_box.get("PIS_YM").replaceAll("-", ""),						//				
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SAL_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("END_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);


		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���κ� ��������/���� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD040_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				"1",												//���� CODE
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("SAL_CD"),						//�����׸�
				vo.get("STR_YMD").replaceAll("-", ""),	//������
				vo.get("END_YMD").replaceAll("-", ""),	//������
				vo.get("AD_TAG"),						//����/��������
				vo.get("AMOUNT"),						//�ݾ�
				p_box.get("vusrid"),						//�Է���
				p_box.get("vusrid")						//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ���κ� ���� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD040_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("END_YMD").replaceAll("-", ""),	//������
				vo.get("AD_TAG"),						//����/��������
				vo.get("AMOUNT"),						//�ݾ�
				p_box.get("vusrid"),				//������
				vo.get("OCC_CD"),						//���� CODE
				vo.get("ENO_NO"),						//�����ȣ
				vo.get("SAL_CD"),						//�����׸�
				vo.get("STR_YMD").replaceAll("-", ""),	//������
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���κ� ���� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD040_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD040_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),								//���� CODE
				vo.get("ENO_NO"),								//�����ȣ
				vo.get("SAL_CD"),								//�޿��׸�
				vo.get("STR_YMD").replaceAll("-", ""),			//������
				vo.get("AD_TAG"),								//����
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

}

package Ehr.gun.d.gund030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND030DAO extends AbstractDAO {
	/**
	 * GUND030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUND030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �����߻�����  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUND030_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),

		};
		
        prop.add("YRP_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AYRP_CNT"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TOT_YRP"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		

	}

	/**
	 * �����߻����� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUND030_INS(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ��������� ����� �о�鿩 �򰡴���� �����͸� �ϰ� �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("vusrid"),       					// ���
				p_box.get("vusrid"),       					// ���
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
				p_box.get("PIS_YY"),                        // �ϰ�ó���⵵
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
     * ����ǰ�Ǽ� ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void GUND030_DEL(CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_DEL");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),                         // �⵵
		};

		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	/**
	 * �����߻����� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUND030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �򰡴���� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND030_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("YRP_M1"),                          // 1�� ����
				vo.get("YRP_M2"),                          // 2�� ����
				vo.get("YRP_M3"),                          // 3�� ����
				vo.get("YRP_M4"),                          // 4�� ����
				vo.get("YRP_M5"),                          // 5�� ����
				vo.get("YRP_M6"),                          // 6�� ����
				vo.get("YRP_M7"),                          // 7�� ����
				vo.get("YRP_M8"),                          // 8�� ����
				vo.get("YRP_M9"),                          // 9�� ����
				vo.get("YRP_M10"),                        // 10�� ����
				vo.get("YRP_M11"),                        // 11�� ����
				vo.get("YRP_M12"),                        // 12�� ����
				vo.get("AYRP_M1"),                        // 1�� ������
				vo.get("AYRP_M2"),                        // 2�� ������
				vo.get("AYRP_M3"),                        // 3�� ������
				vo.get("AYRP_M4"),                        // 4�� ������
				vo.get("AYRP_M5"),                        // 5�� ������
				vo.get("AYRP_M6"),                        // 6�� ������
				vo.get("AYRP_M7"),                        // 7�� ������
				vo.get("AYRP_M8"),                        // 8�� ������
				vo.get("AYRP_M9"),                        // 9�� ������
				vo.get("AYRP_M10"),                      // 10�� ������
				vo.get("AYRP_M11"),                      // 11�� ������
				vo.get("AYRP_M12"),                      // 12�� ������
				vo.get("YRP_CNT"),                        // ������
				vo.get("AYRP_CNT"),                      // ��������
				p_box.get("vusrid"),     						// ������
				vo.get("PIS_YY"),                           // �⵵
				vo.get("ENO_NO")                          // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
}

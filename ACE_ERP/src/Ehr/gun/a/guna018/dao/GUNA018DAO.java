package Ehr.gun.a.guna018.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA018DAO extends AbstractDAO {
	/**
	 * GUNA018DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA018DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ���κ� ���� ��Ȳ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA018_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ� ���� ��Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    			// �ش��
				p_box.get("PIS_MM_STR"),	    		// �ش��(����)
				p_box.get("PIS_MM_END"),				// �ش��(����)
				p_box.get("ENO_NO"),					// ���
				p_box.get("PIS_YY"),	    			// �ش��
				p_box.get("PIS_MM_STR"),	    		// �ش��(����)
				p_box.get("PIS_MM_END"),				// �ش��(����)
				p_box.get("ENO_NO"),					// ���
		};

        prop.add("YRP_CNT"   	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MPH_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ���κ��ް������Ȳ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA018_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ��ް������Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    			// �⵵
				p_box.get("ENO_NO"),					// ���
 		
		};

        prop.add("YRP_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_ATT_H"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_YRP"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MPH_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("UMPH_CNT"     ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LMPH_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		/** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ���ο��������� ���� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA018_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			p_box.get("PIS_YY"),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("YRP_CNT"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ���ο��������� ������Ʈ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA018_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA018_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

			JSPUtil.rns(vo.get("YRP_CNT")),
			p_box.get("PIS_YY"),
			JSPUtil.rns(vo.get("ENO_NO"))

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

}

package Ehr.edu.e.edue041.dao;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.DateUtil;
import Ehr.common.util.JSPUtil;

public class EDUE041DAO extends AbstractDAO {

	/**
	 * GUNA071DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE041DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ���缼�λ��� ��ȸ(�����û) ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE041_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * ��������
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE041_SHR_01(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_APPROVAL_SHR");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
        Object[] bind = new Object[] {
        	p_box.get("REQ_NO")                     
        };

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}

	
	
	public void EDUE041_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_SHR_PRINT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	public void EDUE041_SHR_PRINT2(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_SHR_PRINT2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	
	
	
	/**
	 * ���� ó�������� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void EDUE041_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("APP_YN"),
				JSPUtil.rns(vo.get("CPT_TAG")),				//��� -> �ʵ�����  Container ����
				p_box.get("vusrid"),
				p_box.get("SEQ_NO"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���� ��Ϲ�ȣ�� �����Ѱ�������(���� T_DI_DILIGENCE)(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet EDUE041_CNT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_CNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return selectProcess(sql, bind);
	}
	/**
	 * T_DI_DILIGENCE �� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void EDUE041_UPT_01(String APP_YN, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_UPT_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * T_DI_DILIGENCE �� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void EDUE041_UPT_02(String PIS_YYMMDD, GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_UPT_02");

		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";

		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +" = 'F',");


		Object[] sqlParam = new Object[] {
				sb.toString(),

		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				JSPUtil.rns(vo.get("ENO_NO")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

}


package Ehr.but.a.buta021.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BUTA021DAO extends AbstractDAO {

	/**
	 * BUTA021DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA021DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �����꼭 ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR");



		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * �������ޱ��� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_01");



		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���޿� ���� �ܰ��� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_02");

		/** �����ο� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();
		if (!p_box.get("COM_CD1").equals("")) {
			sb.append("UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD1")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD2").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD2")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD3").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD3")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD4").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD4")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD5").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD5")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				"A2",
				p_box.get("JOB_CD")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �ĺ������ ���� ���� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_03");



		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("BUT_FR_YMD").replaceAll("-", ""),
				p_box.get("BUT_TO_YMD").replaceAll("-", "")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * ����ǰ�� ��Ȳ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	


	/**
	 * �����꼭�� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA021_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
			JSPUtil.rns(vo.get("GBN_CD")),				//���������ڵ�
			JSPUtil.rns(vo.get("SQN_NO")),				//�Ϸù�ȣ
			JSPUtil.rns(vo.get("ENO_NO")),				//���
			JSPUtil.rns(vo.get("NAM_KOR")),				//����
			JSPUtil.rns(vo.get("DPT_CD")),				//�μ��ڵ�
			JSPUtil.rns(vo.get("JOB_CD")),				//�����ڵ�
			JSPUtil.rns(vo.get("CITY_DPT")),			//���屸�������
			JSPUtil.rns(vo.get("CITY_AVR")),			//���屸��������
			JSPUtil.rns3(vo.get("PRICE_AMT")),			//�ܰ�
			JSPUtil.rns3(vo.get("BAS_CNT")),			//����
			JSPUtil.rns3(vo.get("COST_AMT")),			//�ҿ�ݾ�
			JSPUtil.rns(vo.get("REMARK")),				//���

			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �����꼭 ����  DAO �޼���
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA021_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("CITY_DPT")),			//���屸�������
				JSPUtil.rns(vo.get("CITY_AVR")),			//���屸��������
				JSPUtil.rns3(vo.get("PRICE_AMT")),			//�ܰ�
				JSPUtil.rns3(vo.get("BAS_CNT")),			//����
				JSPUtil.rns3(vo.get("COST_AMT")),			//�ҿ�ݾ�
				JSPUtil.rns(vo.get("REMARK")),				//���
				JSPUtil.rns3(vo.get("DESC_AMT")),			//�ĺ������
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("ORD_NO")),				//ǰ�ǹ�ȣ
				JSPUtil.rns(vo.get("GBN_CD")),				//���������ڵ�
				JSPUtil.rns(vo.get("SQN_NO")),				//�Ϸù�ȣ
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
     * �����꼭 ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA021_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_DEL");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),				//ǰ�ǹ�ȣ
				vo.get("GBN_CD"),				//���������ڵ�
				vo.get("SQN_NO"),				//�Ϸù�ȣ
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	/**
	 * �����꼭 ��ü ���� DAO �޼���
	 * @param p_box CBox
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BUTA021_DEL_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_DEL_01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),				//ǰ�ǹ�ȣ
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

}


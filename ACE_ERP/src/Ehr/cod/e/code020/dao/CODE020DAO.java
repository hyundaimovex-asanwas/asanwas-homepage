package Ehr.cod.e.code020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODE020DAO extends AbstractDAO {
	/**
	 * PIRA060DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �Ϸù�ȣ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE020_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �Ϸù�ȣ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("vusrid")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �������� ������û SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE020_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������û ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_SHR_02");

		/** ��ȸ ����(��ȸ�Ⱓ)�� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();
		if (!p_box.get("STR_YMD").equals("")) {
			sb.append("AND    TO_CHAR(A.IPT_YMD, 'YYYY-MM-DD') >= '"+p_box.get("STR_YMD")+"' \n");
		}
		if (!p_box.get("END_YMD").equals("")) {
			sb.append("	AND    TO_CHAR(A.IPT_YMD, 'YYYY-MM-DD') <= '"+p_box.get("END_YMD")+"' \n");
		}

		String sts_gbn1 = "STS_GBN = '0'";
		String sts_gbn2 = "STS_GBN = '0'";
		String sts_gbn3 = "STS_GBN = '0'";

		if(p_box.get("STS_GBN1").equals("1")){
			sts_gbn1 = "STS_GBN = '1'";
		}
		if(p_box.get("STS_GBN2").equals("2")){
			sts_gbn2 = "STS_GBN = '2'";
		}
		if(p_box.get("STS_GBN3").equals("3")){
			sts_gbn3 = "STS_GBN = '3'";
		}

		/** ��ȸ ����(ó���ܰ�)�� ���� ó�� #2 **/
		StringBuffer sb1 = new StringBuffer();

		sb1.append("AND    ( "+sts_gbn1+" OR "+sts_gbn2+" OR "+sts_gbn3+" ) \n");


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb1.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),				// ���

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �Ϸù�ȣ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE020_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� �Ϸù�ȣ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("SEQ_ENO_NO")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
     * �������� ������û ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void CODE020_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� �������� ������û (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("SEQ_NO")),			//�Ϸù�ȣ
				JSPUtil.rns(vo.get("ENO_NO")),			//�����ȣ
				JSPUtil.rns(vo.get("UPDATE_TXT")),		//��������
				JSPUtil.rns(vo.get("WORK_GBN")),		//��������
				JSPUtil.rns(vo.get("STS_GBN")),			//ó����Ȳ
				JSPUtil.rns(vo.get("REPLY_TXT")),		//�ѹ��� ���
				p_box.get("vusrid"),
				p_box.get("vusrid")
		};


		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}

	/**
     * �������� ������û ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void CODE020_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML������������ ������û (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_UPT");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("UPDATE_TXT")),		//��������
				JSPUtil.rns(vo.get("WORK_GBN")),		//��������
				JSPUtil.rns(vo.get("STS_GBN")),			//ó����Ȳ
				JSPUtil.rns(vo.get("REPLY_TXT")),		//�ѹ��� ���
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("SEQ_NO")),			//�Ϸù�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))			//�����ȣ
		};


		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}

	/**
     * �������� ������û ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void CODE020_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� �������� ������û (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE020_DEL");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("SEQ_NO")),			//�Ϸù�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))			//�����ȣ
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}


}

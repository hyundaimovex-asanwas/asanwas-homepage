package Ehr.cod.b.codb020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODB020DAO extends AbstractDAO {

	/**
	 * CODB010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODB020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * Ʈ�������� ���� �μ� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODB020_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���� �μ��ڵ忡 ���� ���� �μ��ڵ� �� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODB020_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("COUNT_REM"),
				p_box.get("COUNT_REM")+"%"
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	/**
	 * HEAD_TAG ��� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODB020_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �μ������� �ϳ��� ������ ȸ�������� �ִ´�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB020_INS(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid")),//������

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �μ����� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB020_INS_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("DPT_CD")),//pk

				JSPUtil.rns(vo.get("DPT_NM")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("UPDPT_CD")),

				JSPUtil.rns(vo.get("DPT_LBL")),
				JSPUtil.rns(vo.get("SORT_NO")),
				JSPUtil.rns3(vo.get("COUNT_REM")),
				JSPUtil.rns3(vo.get("GBN2_TAG")),

				JSPUtil.rns3(vo.get("PART_CD")),
				JSPUtil.rns3(vo.get("REMARK")),
				JSPUtil.rns3(vo.get("REMARK2")),
				JSPUtil.rns3(vo.get("REMARK3")),
				JSPUtil.rns3(vo.get("HEAD_CD")),
				JSPUtil.rns3(vo.get("GBN_CD")),
				JSPUtil.rns3(vo.get("OFFICE")),
				JSPUtil.rns3(vo.get("HEAD_TAG")),
				JSPUtil.rns3(vo.get("REG_CD")),
				JSPUtil.rns3(vo.get("COM_NO")),

				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �μ����� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB020_UPT_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_UPT_01");
		
		System.out.print(vo);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("DPT_NM")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("UPDPT_CD")),

				JSPUtil.rns(vo.get("DPT_LBL")),
				JSPUtil.rns(vo.get("SORT_NO")),
                JSPUtil.rns(vo.get("COUNT_REM")),
                JSPUtil.rns(vo.get("GBN2_TAG")),

                JSPUtil.rns(vo.get("PART_CD")),
                JSPUtil.rns(vo.get("REMARK")),
                JSPUtil.rns(vo.get("REMARK2")),
                JSPUtil.rns(vo.get("REMARK3")),
                JSPUtil.rns(vo.get("HEAD_CD")),
                JSPUtil.rns(vo.get("GBN_CD")),
                JSPUtil.rns(vo.get("OFFICE")),
                JSPUtil.rns(vo.get("HEAD_TAG")),
                JSPUtil.rns(vo.get("REG_CD")),
                JSPUtil.rns(vo.get("COM_NO")),

				JSPUtil.rns(p_box.get("vusrid")),//������

				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("DPT_CD")),//pk
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}

	/**
	 * �����μ��� �����μ����� update�Ѵ�.(�����μ��� �����μ� �ִٰ� update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB020_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_UPT_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(Integer.toString(Integer.parseInt(vo.get("DPT_LBL"))-1)),//��������
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//���� countremark
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}

	/**
	 * �����μ��� �����μ����� update�Ѵ�.(�����μ��� �����μ� ���ٰ� update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB020_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_UPT_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//���� countremark
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)+"%"),//���� countremark
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		//updateProcess(sql, bind);
		deleteProcess(sql, bind);//������Ʈ�Ǵ� row�� 0�̾ ������ �ǰ� �ϱ����� deleteProcess�� ���
	}

	/**
	 * �μ����� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB020_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("DPT_CD")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

}

package Ehr.cod.b.codb010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODB010DAO extends AbstractDAO {

	/**
	 * CODB010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODB010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �ڵ�,�ڵ�� ���� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODB010_SHR(CBox p_box) throws CException {

		//System.out.println("p_box=================="+p_box);

		//System.out.println("COMM_CD=================="+p_box.getString("COMM_CD"));			
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_SHR");  			

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
	    
			 JSPUtil.rns(p_box.getString("COMM_CD")),
			 JSPUtil.rns(p_box.getString("COMM_CD"))	        

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �ڵ忡 ���� �����ڵ� �� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODB010_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("COMM_CD")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �����ڵ� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("COMM_CD")),//pk
				JSPUtil.rns(vo.get("COMM_NM")),
				JSPUtil.rns(vo.get("COMM_NM2")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns3(vo.get("SORT_NO")),
				JSPUtil.rns3(vo.get("GBN2_TAG")),
				JSPUtil.rns(vo.get("EXT_01")),
				JSPUtil.rns(vo.get("EXT_02")),
				JSPUtil.rns(vo.get("EXT_03")),
				JSPUtil.rns(vo.get("EXT_04")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(vo.get("REMARK2")),
				JSPUtil.rns(vo.get("REMARK3")),
				JSPUtil.rns(vo.get("OTH_DEC")),
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �����ڵ� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("COMM_NM")),
				JSPUtil.rns(vo.get("COMM_NM2")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns3(vo.get("SORT_NO")),
				JSPUtil.rns3(vo.get("GBN2_TAG")),
				JSPUtil.rns(vo.get("EXT_01")),
				JSPUtil.rns(vo.get("EXT_02")),
				JSPUtil.rns(vo.get("EXT_03")),
				JSPUtil.rns(vo.get("EXT_04")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(vo.get("REMARK2")),
				JSPUtil.rns(vo.get("REMARK3")),
				JSPUtil.rns(vo.get("OTH_DEC")),
				JSPUtil.rns(p_box.get("vusrid")),//������
				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("COMM_CD"))//pk
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * �����ڵ� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB010_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("COMM_CD"))//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

}
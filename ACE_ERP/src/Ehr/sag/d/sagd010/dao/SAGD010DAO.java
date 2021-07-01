package Ehr.sag.d.sagd010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGD010DAO extends AbstractDAO {

	/**
	 * SAGD010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �޿����̺� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_SHR");

		//System.out.print(">>>>>>>>>>>>>>>>>>  PIS_YY_SHR = " +p_box.get("PIS_YY_SHR"));
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),
		};

		prop.add("P01_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P02_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P03_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P04_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("P05_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAL_AMT", ColumnProp.COLUMN_TYPE_INTEGER, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD010_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),


				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk

				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_UPT2(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_UPT2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {


				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk

				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_UPT3(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_UPT3");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {


				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	/**
	 * �޿����̺� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_UPT");

        int sum;

        //System.out.print(">>>>>>>>>>>>>>>>>>  P01_AMT = " +Integer.parseInt(vo.get("P01_AMT")));

        
        sum = Integer.parseInt(vo.get("P01_AMT")) +
		        Integer.parseInt(vo.get("P02_AMT")) +
		        Integer.parseInt(vo.get("P03_AMT")) +
		        Integer.parseInt(vo.get("P04_AMT")) +
		        Integer.parseInt(vo.get("P05_AMT"));

        //System.out.print(">>>>>>>>>>>>>>>>>>  sum = " +sum);        
        
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns3(vo.get("P01_AMT")),
				JSPUtil.rns3(vo.get("P02_AMT")),
				JSPUtil.rns3(vo.get("P03_AMT")),
				JSPUtil.rns3(vo.get("P04_AMT")),
				JSPUtil.rns3(vo.get("P05_AMT")),
				Integer.toString(sum),
				JSPUtil.rns(p_box.get("vusrid")),//������
				JSPUtil.rns3(vo.get("ENO_NO")),//
				JSPUtil.rns3(vo.get("PIS_YY")),//
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * �޿����̺� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("HOB_CD")),//pk
				JSPUtil.rns(vo.get("APY_YMD").replaceAll("-", "")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * �޿����̺� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD010_DEL_01(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("sag", "SAGD010_DEL_01");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("OCC_CD")),//pk
	            JSPUtil.rns(p_box.get("APY_YMD").replaceAll("-", "")),//pk
	    };

	    /** DELETE�޼ҵ� ȣ��  **/
	    deleteProcess(sql, bind);
	}

}

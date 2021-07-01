package Ehr.sag.d.sagd030.dao;

//import oracle.jdbc.driver.OracleTypes;
import oracle.jdbc.OracleTypes;

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
import Ehr.common.util.JSPUtil;

public class SAGD030DAO extends AbstractDAO {

	/**
	 * SAGD030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �޿����ó�� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD030_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("SEQ_SHR"),
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PIS_MM", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SEQ", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PRO_STS", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PAY_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("WOM_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 6.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APY_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BPAY_PCT", ColumnProp.COLUMN_TYPE_DECIMAL, 4.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BYY_PCT", ColumnProp.COLUMN_TYPE_DECIMAL, 4.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BBYY_PCT", ColumnProp.COLUMN_TYPE_DECIMAL, 4.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PRO_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 5.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ERR_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 5.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("RET_TAG", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �۾��α� �ű����� (�۾� OPEN)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),		//pk
				JSPUtil.rns(vo.get("PIS_MM")),		//pk
				"A",
				"0",
				JSPUtil.rns(vo.get("SEQ")),				//pk
				JSPUtil.rns(vo.get("PRO_STS")),		//1
				JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),
				JSPUtil.rns3(vo.get("WOM_AMT")),
				JSPUtil.rns(vo.get("APY_YMD").replaceAll("-", "")),
				"0",							//��������(��)
				"0",							//���������(��)
				"0",							//�����޻���(��)
				"",								//REMARK
				"",								//RET_TAG
				JSPUtil.rns(p_box.get("vusrid")),		//�Է���
				JSPUtil.rns(p_box.get("vusrid"))			//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}



	/**
	 * ����� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_INS_01(CBox p_box, GauceValueObject vo) throws CException {

		/** ����� ���� ��Ű�� ����  **/
		String sql = "{ call ASNHR.PKG_XF_SAGD200_INS_00.SF_INS_T_CP_NPAYMASTER(?, ?, ?, ?, ?, ?, ?, ?, ?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", 			"", 						"A", 														""						},//����
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_YY")), 					""						},//��
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_MM")), 					""						},//��
				{"IN", 			"", 						"0", 														""						},//
				{"IN",				"", 						JSPUtil.rns(p_box.get("vusrid")),					""						},//�۾���
				{"IN/OUT", 		"PRO_CNT", 			JSPUtil.rns(vo.get("PRO_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//ó���ο�
				{"IN/OUT", 		"ERR_CNT", 				JSPUtil.rns(vo.get("ERR_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//�����ο�
				{"IN/OUT", 		"PRO_STS", 			JSPUtil.rns(vo.get("PRO_STS")), 					String.valueOf(OracleTypes.VARCHAR)},//�۾��ܰ�
				{"IN/OUT", 		"PRO_STS_MSG", 		"MSG", 													String.valueOf(OracleTypes.VARCHAR)} //�۾��Ϸ�޼���
		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		CBox box = (CBox)this.executeProcedure(sql, bind, null);

	}


	/**
	 * �ݾס����װ��
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_INS_03(CBox p_box, GauceValueObject vo) throws CException {

		/** �ݾס����װ�� ��Ű�� ����  **/
		String sql = "{ call ASNHR.PKG_XF_SAGD200_INS_01.SF_INS_T_CP_NPAYMASTER(?, ?, ?, ?, ?, ?, ?, ?, ?) }";

		//System.out.print(">>>>>>>>>>>>>>>>>>  PKG_XF_SAGD200_INS_01\n");		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", 			"", 						"A", 														""						},//����
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_YY")), 					""						},//��
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_MM")), 					""						},//��
				{"IN", 			"", 						"0", 														""						},//
				{"IN",				"", 						JSPUtil.rns(p_box.get("vusrid")),					""						},//�۾���
				{"IN/OUT", 		"PRO_CNT", 			JSPUtil.rns(vo.get("PRO_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//ó���ο�
				{"IN/OUT", 		"ERR_CNT", 				JSPUtil.rns(vo.get("ERR_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//�����ο�
				{"IN/OUT", 		"PRO_STS", 			JSPUtil.rns(vo.get("PRO_STS")), 					String.valueOf(OracleTypes.VARCHAR)},//�۾��ܰ�
				{"IN/OUT", 		"PRO_STS_MSG", 		"MSG", 													String.valueOf(OracleTypes.VARCHAR)} //�۾��Ϸ�޼���
		};

		//System.out.print(">>>>>>>>>>>>>>>>>>  PKG_XF_SAGD200_INS_02\n");	
		
		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		CBox box = (CBox)this.executeProcedure(sql, bind, null);

	}



	/**
	 * ����� ����(�۾� LOG ����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("WOM_AMT")),//������ȸ��
				JSPUtil.rns(p_box.get("vusrid")),//������
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ����� �ʱ�ȭ - �۾��α� ����� ���� ���� ���·� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PRO_STS")),//1
				"0",//PRO_CNT
				"0",//ERR_CNT
				JSPUtil.rns(p_box.get("vusrid")),//����
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	/**
	 * PRO_STS : 2, ��� �ʱ�ȭ( �ݾ�, ���� ������� ����) - �۾��α� �ݾ�, ���� ��� ���� ���·� ����
	 * PRO_STS : 6, �۾��α� �۾�CLOSE ���·� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_04(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PRO_STS")),				//2
				JSPUtil.rns(p_box.get("vusrid")),	//����
				JSPUtil.rns(vo.get("PIS_YY")),	//pk
				JSPUtil.rns(vo.get("PIS_MM")),	//pk
				JSPUtil.rns(vo.get("SEQ")),		//pk
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ��� �ʱ�ȭ( �ݾ�, ���� ������� ����) - T_CP_PAYMASTER ���ݾ� 0���� �ʱ�ȭ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_05(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//����
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ��� �ʱ�ȭ( �ݾ�, ���� ������� ����) - T_SV_SAVELIST(����ݰ������) ��� ������ �ʱ�ȭ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_06(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//����
				JSPUtil.rns(vo.get("PIS_YY")+vo.get("PIS_MM")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	/**
	 * ����� �ʱ�ȭ - T_CP_PAYMASTER ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * ����� �ʱ�ȭ - T_CP_PAYMASTER_OFFICE ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * ��� �ʱ�ȭ( �ݾ�, ���� ������� ����) - T_CP_CHANGE ��� ������ �ʱ�ȭ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * ��� �ʱ�ȭ( �ݾ�, ���� ������� ����) - T_AC_LOAN(�����/���ڱ�) ��� ������ �ʱ�ȭ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_03(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}



	/**
	 * ��� �ʱ�ȭ( �ݾ�, ���� ������� ����) - T_SV_SAVEBOOK(����ݳ��԰���) ��� ������ �ʱ�ȭ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_04(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")+vo.get("PIS_MM")),
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}


}

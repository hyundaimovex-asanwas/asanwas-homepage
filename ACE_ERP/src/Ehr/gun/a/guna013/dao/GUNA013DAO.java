package Ehr.gun.a.guna013.dao;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA013DAO extends AbstractDAO {
	/**
	 * GUNA013DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA013DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}
	/**
	 * ��ϸ� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_LST(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_LST");

		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR").replaceAll("-", ""));
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR").replaceAll("-", ""));
		String GUN_CD_SHR  = JSPUtil.rns(p_box.get("GUN_CD_SHR"));
		String ENO_NO_SHR = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		
		if("0".equals(GUN_CD_SHR)){
			GUN_CD_SHR = "";
		}

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,

				STR_YMD_SHR,
				END_YMD_SHR,
				ENO_NO_SHR
        };
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_A_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_Y_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_N_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * ������ ������Ȳ�� ��ȸ�ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_00");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO_SHR"))
		};
		prop.add("BF_REMARK", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BF_YMD", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BF_GUN_CD", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BF_GUN_NM", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("AF_GUN_NM", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("AF_REMARK", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;

	}
	
	/**
	 * ��¥�� �����ڵ带 ��ȸ�ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_CD(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_CD");
		String PIS_YYMMDD = JSPUtil.rns(p_box.get("PIS_YYMMDD"));
		String YYYY = PIS_YYMMDD.substring(0,4);
		String MM = PIS_YYMMDD.substring(4,6);
		String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));


		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD AS GUN_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME );

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY,
				MM,
				ENO_NO,
				PIS_YYMMDD.substring(6,8)

		};
		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		prop.add("GUN_CD", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		return gs;

	}
	
	/**
	 * ���缱�� ��ȸ �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ���� CHECK ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_01");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO_SHR"))
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}

	/**
	 * ���缱�� ��ȸ �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_01(String REQ_NO) throws CException {

		/** �ܺ� XML���� ��ȸ���� CHECK ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}

	/**
	 * ���º����û���� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("REQ_NO")),

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("BF_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("BF_GUN_CD")),
				JSPUtil.rns(vo.get("BF_REMARK")),
				JSPUtil.rns(vo.get("AF_GUN_CD")),
				"",
				JSPUtil.rns(vo.get("AF_REMARK")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ���缱�� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �ش�μ��� ������Ȳ�� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_UPT(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_UPT");

		StringBuffer sb = new StringBuffer();

		Object[] sqlParam = new Object[] {};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		Object[] bind = new Object[] {

			JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),
			JSPUtil.rns(vo.get("AF_GUN_CD")),
			JSPUtil.rns(vo.get("AF_REMARK")),
			JSPUtil.rns(p_box.get("vusrid")),

			JSPUtil.rns(p_box.get("REQ_NO")),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("BF_YMD")).replaceAll("-", "")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���º����û���� �����ϴ�  DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void GUNA013_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO")),                        //��û��ȣ
				JSPUtil.rns(p_box.get("ENO_NO")),                        //�����ȣ
				JSPUtil.rns(p_box.get("REQ_YMD")).replaceAll("-", ""),   //��û����
				JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),      //�����û��
		};

		/** DELETE�޼ҵ� ȣ�� **/
		deleteProcess(sql, bind);
	}

    /**
     * ���°����� ���� DAO�޼ҵ�
     * @param vo
     * @param p_box
     * @throws CException
     */
 	public void GUNA013_DEL_02(GauceValueObject vo, CBox p_box) throws CException {


		/**�ܺ� XML���� SQL�� �о�´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_DEL_02");

        /** SQL�� ���ε� �� ���� ���������� �־��ش� **/
        Object[] bind = new Object[] {
        		JSPUtil.rns(p_box.get("REQ_NO")),                         //��û��ȣ
        };

        /** DELETE�޼ҵ� ȣ�� **/
        deleteProcess(sql, bind);
	}



	/**
	 * ���缱�� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_UPT_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(p_box.get("vusrid")),

				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("GUN_DPT")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("PENO_NO")),

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	//�ΰῩ�� ��ȸ
	public GauceDataSet GUNA013_SHR_02(GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("GUN_DPT")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("PENO_NO")),
		};

		return this.selectProcess(sql, bind, prop);
	}

	//��û��ȣ ����
	public GauceDataSet GUNA013_SHR_03(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(p_box.get("REQ_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ��ȸ�� ���缱�� �����Ǿ� ���� ������ �ֱ� ���缱 �������� ������ �μ��� �ڵ�����
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA013_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� ��ȸ���� CHECK ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_04");

		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR"));
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR"));
		String ENO_NO_SHR  = JSPUtil.rns(p_box.get("ENO_NO_SHR"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,
				STR_YMD_SHR,
				END_YMD_SHR
		};


        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���缱 ����
	 * @param vo
	 * @throws CException
	 */
	public void GUNA013_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * ��û��ȣ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA013_SHR_05(CBox p_box) throws CException {
		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String ENO_NO_SHR  = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,
				STR_YMD_SHR,
				END_YMD_SHR
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��Ϲ�ȣ�� MaxPlusOne �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public String GUNA013_SHR_MAX() throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_REG_MAX");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		GauceDataSet ds = selectProcess(sql, bind);
		String reg_no = GauceUtils.nameValue(ds, 1, "REQ_NO");
		return reg_no;
	}

	/**
	 * ���� ���»����� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_06(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_06");

		String ENO_NO_SHR = JSPUtil.rns(p_box.get("ENO_NO"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				ENO_NO_SHR
        };
		prop.add("PIS_YMD", ColumnProp.COLUMN_TYPE_STRING, 8, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUN_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);
	}
}

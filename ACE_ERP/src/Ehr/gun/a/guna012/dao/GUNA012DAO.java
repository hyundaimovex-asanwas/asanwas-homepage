package Ehr.gun.a.guna012.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class GUNA012DAO extends AbstractDAO {
	/**
	 * GUNA012DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA012DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}


	/**
	 * ��ϸ� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA012_SHR_LST(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_SHR_LST");

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
				ENO_NO_SHR,
				GUN_CD_SHR
        };
		
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_A_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_Y_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_N_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		return this.selectProcess(sql, bind, prop);
		
	}
	/**
	 * ���α��� �������� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA012_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_SHR");

		String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				REQ_NO
        };

		prop.add("GUN_STS", ColumnProp.COLUMN_TYPE_STRING, 8, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}


	/**
	 * ���α��� �������� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA012_SHR(String REQ_NO) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				REQ_NO
        };
		prop.add("ENO_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUN_STS", ColumnProp.COLUMN_TYPE_STRING, 8, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}



	/**
	 * ���缱 ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA012_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
    			JSPUtil.rns(p_box.get("REQ_NO"))
		};

		return this.selectProcess(sql, bind, prop);
	}



	/**
	 * ���α��� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA012_SHR_01(GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO")
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ���α��� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA012_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("REQ_NO")),
			JSPUtil.rns(vo.get("PIS_YYMMDD").replaceAll("-", "")),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("DPT_CD")),
			JSPUtil.rns(vo.get("GUN_CD")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(vo.get("REMARK"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ���α��� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA012_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("GUN_CD")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("REMARK")),

				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("PIS_YYMMDD").replaceAll("-", "")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���α��� ������ �����ϴ�  DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void GUNA012_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(vo.get("PIS_YYMMDD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("ENO_NO"))
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

    /**
     * ���缱�� �����ϴ� DAO�޼ҵ�
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
    public void GUNA012_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

        /** �ܺ� XML���� �����޹ݿ� (����) SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA012_DEL_01");

        /** ���� ���� Mapping(PrepareStatement ) **/
        Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),
        };
        /** DELETE�޼ҵ� ȣ��  **/
        deleteProcess(sql, bind);

    }

	/**
	 * ���缱�� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA012_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_INS_01");

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
	 * ��Ϲ�ȣ�� MaxPlusOne �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public String GUNA012_SHR_MAX() throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_REG_MAX");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		GauceDataSet ds = selectProcess(sql, bind);
		String reg_no = GauceUtils.nameValue(ds, 1, "REQ_NO");
		return reg_no;
	}
	/**
	 * ���� ��Ϲ�ȣ�� �����Ѱ�������(���� T_DI_DILIGENCE)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet GUNA012_CNT(String REQ_NO) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_CNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				REQ_NO,
				"C"
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return selectProcess(sql, bind);
	}

	/**
	 * ����üũ ��ȸ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet GUNA012_YRP(CBox p_box) throws CException {

		String YYYY  	= JSPUtil.rns(p_box.get("YYYY").replaceAll("-", ""));
		String ENO_NO  	= JSPUtil.rns(p_box.get("ENO_NO"));

		/** �ܺ� XML���� ���κ��ް������Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA012_YRP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				YYYY,
				ENO_NO,
				YYYY,
				ENO_NO,
				ENO_NO,				
				ENO_NO
		};

        prop.add("NET_YRP_CNT"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("AYRP_CNT"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_USE"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("NOT_YRP_CNT"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		/** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);

	}

}

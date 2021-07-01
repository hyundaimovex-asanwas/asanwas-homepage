package Ehr.gun.a.guna071.dao;

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

public class GUNA071DAO extends AbstractDAO {

	/**
	 * GUNA071DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA071DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ���缼�λ��� ��ȸ(�����û) ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA071_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���缼�λ��� ��ȸ(���ϱ���) ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA071_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};


		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * ���缼�λ��� ��ȸ(�Ϳ�����) ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_PLAN(CBox p_box) throws CException {


        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;

        String str_ym_val   = REQ_NO.substring(0,6)+"01";
        
        String str_ymd      = DateUtil.getAfterDate(str_ym_val, 0,1,0).substring(0,4) + "-" + DateUtil.getAfterDate(str_ym_val, 0,1,0).substring(4,6);


        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sqlCnt = XmlSqlUtils.getSQL("gun", "GUNB020_SHR_PLAN_04");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bindCnt = new Object[] {
                str_ym_val  ,str_ym_val
        };

        GauceDataSet gs = this.selectProcess(sqlCnt, bindCnt, prop);

        String day_val     = "";
        String month_val = "";
        StringBuffer sb    = new StringBuffer();
        GauceDataRow grRead = null; // ��ȸ�� row

        for ( int i = 0; i < gs.getDataRowCnt(); i++) {
            grRead  = gs.getDataRow(i);     // fetch �� row
            month_val = grRead.getString(0).substring(0,2);
            day_val = grRead.getString(0).substring(2,4);
            if ( grRead.getString(0).substring(2,3).equals("0") ){
                day_val = grRead.getString(0).substring(3,4);
            }
            sb.append(", MAX(DECODE(PIS_MM,"+month_val+",AT"+day_val+"_CD))");
        }


        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_PLAN_01");

        Object[] sqlParam = new Object[] {
                  sb.toString()
        };

            /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
            sql = SqlUtils.replaceQuery(sql, sqlParam);
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		str_ymd,

                str_ymd,
                str_ymd,
                str_ymd,
                str_ymd,

                str_ymd,
                str_ymd,

        		REQ_NO
        };
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("NYRP_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);

        /** SELECT�޼ҵ� ȣ�� **/
        return this.selectProcess(sql, bind, prop);

	}

    /**
     * �ް���ȹ ���� ���̺��� �̿��� �ش� ���� ���� �� �ް��� ���� �հ踦 ���ؿ´�
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA071_SHR_PLAN_01(CBox p_box) throws CException {
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String str_ymd_val  = REQ_NO.substring(0,4) + REQ_NO.substring(4,6)+"01";

        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNB020_SHR_PLAN_04");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                  str_ymd_val
                , str_ymd_val
        };

        /** SELECT�޼ҵ� ȣ�� **/
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        prop.add("HOL_YN", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        return gs;
    }



	/**
	 * ���� ó�������� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("APP_YN"),
				JSPUtil.rns(vo.get("APP_CMT")),				//��� -> �ʵ�����  Container ����
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
	public GauceDataSet GUNA071_CNT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_CNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
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
	public void GUNA071_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * ���ϱ������������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		
		return gs;
		
	}


	
	
	/**
	 * ���浥���� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_05(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("PENO_NO")
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}

	/**
	 * �����Ѱ踦 �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA071_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}

		if("A".equals(GUN_CD)) COLNAME="ATT_A";
		else if("B".equals(GUN_CD)) COLNAME="ATT_B";
		else if(GUN_CD.equals("C")) COLNAME="ATT_C";
		else if(GUN_CD.equals("D")) COLNAME="ATT_D";
		else if(GUN_CD.equals("E")) COLNAME="ATT_E";
		else if(GUN_CD.equals("F")) COLNAME="ATT_F";
		else if(GUN_CD.equals("G")) COLNAME="ATT_G";
		else if(GUN_CD.equals("H")) COLNAME="ATT_H";
		else if(GUN_CD.equals("I")) COLNAME="ATT_I";
		else if(GUN_CD.equals("J")) COLNAME="ATT_J";
		else if(GUN_CD.equals("K")) COLNAME="ATT_K";
		else if(GUN_CD.equals("L")) COLNAME="ATT_L";
		else if(GUN_CD.equals("M")) COLNAME="ATT_M";
		else if(GUN_CD.equals("N")) COLNAME="ATT_N";
		else if(GUN_CD.equals("O")) COLNAME="ATT_O";
		else if(GUN_CD.equals("P")) COLNAME="ATT_P";
		else if(GUN_CD.equals("Q")) COLNAME="ATT_Q";
		else if(GUN_CD.equals("R")) COLNAME="ATT_R";
		else if(GUN_CD.equals("S")) COLNAME="ATT_S";
		else if(GUN_CD.equals("U")) COLNAME="ATT_U";
		else if(GUN_CD.equals("V")) COLNAME="ATT_V";
		else if(GUN_CD.equals("X")) COLNAME="ATT_X";
		else if(GUN_CD.equals("Z")) COLNAME="ATT_Z";
		else if(GUN_CD.equals("W")) COLNAME="ATW_CNT";
		else if(GUN_CD.equals("Y")) COLNAME="HOL_CNT";
		else if(GUN_CD.equals("T")) COLNAME="HOW_CNT";

		if("".equals(COLNAME))
			return;


		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= DECODE("+COLNAME+", null, 0, 0, 0, "+COLNAME+"-1),");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		//System.out.println("�Ѱ� ���ϴ� ���̳ʽ� sql [" + sql + "]");
		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �����Ѱ踦 �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA071_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}
		
		if(GUN_CD.equals("E")) COLNAME="ATT_E";
		else if(GUN_CD.equals("F")) COLNAME="ATT_F";
		else if(GUN_CD.equals("G")) COLNAME="ATT_G";
		else if(GUN_CD.equals("H")) COLNAME="ATT_H";
		else if(GUN_CD.equals("I")) COLNAME="ATT_I";
		else if(GUN_CD.equals("M")) COLNAME="ATT_M";
		else if(GUN_CD.equals("P")) COLNAME="ATT_P";
		else if(GUN_CD.equals("R")) COLNAME="ATT_R";
		else if(GUN_CD.equals("W")) COLNAME="ATW_CNT";
		else if(GUN_CD.equals("Y")) COLNAME="HOL_CNT";
		else if(GUN_CD.equals("T")) COLNAME="HOW_CNT";

		if("".equals(COLNAME))
			return;

		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= DECODE("+COLNAME+", null, 0, "+COLNAME+"+1),");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	
	
	
	/**
	 * T_DI_MONTHLY �� �ݿ�
	 */
	public void GUNA071_UPT_05(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				
				ENO_NO
				
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	
	
	/**
	 * T_DI_MONTHLY_HISTORY �� �ݿ�
	 */
	public void GUNA071_UPT_06(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {

				ENO_NO,
				PIS_YYMMDD,
				ENO_NO,
				
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	
	
	
	
	
	
	/**
	 * T_DI_DILIGENCE_IND �� �ݿ�
	 */
	public void GUNA071_UPT_0400(CBox p_box, String APP_YN) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0400");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
				p_box.get("PENO_NO")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	
	
	
	
	/**
	 * T_DI_CHANGE �� �ݿ�
	 */
	public void GUNA071_UPT_0401(CBox p_box, String APP_YN) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0401");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
				p_box.get("PENO_NO")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	/**
	 *T_DI_PLAN �� �ݿ�

	 */
	public void GUNA071_UPT_0402(CBox p_box, String APP_YN) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0402");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	/**
	 * T_DI_ACCELERATE �� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT_0403(CBox p_box, String APP_YN) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0403");

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
	 * T_DI_DILIGENCE �� ���µ����͸� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_01(CBox p_box, String PIS_YYMMDD) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				PIS_YYMMDD.substring(0,4),
				p_box.get("PENO_NO"),
				p_box.get("DPT_CD"),
				PIS_YYMMDD.substring(0,4),
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0,4),
				p_box.get("PENO_NO"),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}
	/**
	 * T_DI_DILIGENCE_DTL �� INSERT OR UPDATE �����͸� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_02(String PIS_YYMMDD, String ENO_NO, String REMARK, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				Integer.parseInt(PIS_YYMMDD.substring(6))+"",
				ENO_NO,
				REMARK,
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				Integer.parseInt(PIS_YYMMDD.substring(6))+"",
				ENO_NO,
				REMARK,
				p_box.get("vusrid"),
				p_box.get("vusrid"),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �Ϳ����¿��� T_DI_DILIGENCE�� �ݿ��� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_PLAN_02(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMM = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
        String YYYY   = YYYYMM.substring(0,4);
        String MM     = YYYYMM.substring(4,6);
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_PLAN_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY,
				MM,
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}
	/**
	 * �Ϳ����¿��� T_DI_DILIGENCE�� �ݿ��� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_PLAN_03(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMM = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
        String YYYY   = YYYYMM.substring(0,4);
        String MM     = YYYYMM.substring(4,6);
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_PLAN_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY,
				MM,
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}
	/**
	 * T_DI_DILIGENCE �� ���µ����͸� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_PLAN_01(String eno_no, String dpt_cd, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_01");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMMDD = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				YYYYMMDD.substring(0,4),
				eno_no,
				dpt_cd,
				YYYYMMDD.substring(0,4),
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				YYYYMMDD.substring(0,4),
				eno_no,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}
	/**
	 * T_DI_DILIGENCE �� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT_PLAN_01(String PIS_YY, String PIS_MM, String DD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "AT"+Integer.parseInt(DD)+"_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YY,
				PIS_MM,
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	/**
	 * �����Ѱ踦 �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA071_UPT_PLAN_02(String PIS_YY, String PIS_MM, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}
		if(GUN_CD.equals("A")) COLNAME="ATT_A";
		else if(GUN_CD.equals("B")) COLNAME="ATT_B";
		else if(GUN_CD.equals("C")) COLNAME="ATT_C";
		else if(GUN_CD.equals("D")) COLNAME="ATT_D";
		else if(GUN_CD.equals("E")) COLNAME="ATT_E";
		else if(GUN_CD.equals("F")) COLNAME="ATT_F";
		else if(GUN_CD.equals("G")) COLNAME="ATT_G";
		else if(GUN_CD.equals("H")) COLNAME="ATT_H";
		else if(GUN_CD.equals("I")) COLNAME="ATT_I";
		else if(GUN_CD.equals("J")) COLNAME="ATT_J";
		else if(GUN_CD.equals("K")) COLNAME="ATT_K";
		else if(GUN_CD.equals("L")) COLNAME="ATT_L";
		else if(GUN_CD.equals("M")) COLNAME="ATT_M";
		else if(GUN_CD.equals("N")) COLNAME="ATT_N";
		else if(GUN_CD.equals("O")) COLNAME="ATT_O";
		else if(GUN_CD.equals("P")) COLNAME="ATT_P";
		else if(GUN_CD.equals("Q")) COLNAME="ATT_Q";
		else if(GUN_CD.equals("R")) COLNAME="ATT_R";
		else if(GUN_CD.equals("S")) COLNAME="ATT_S";
		else if(GUN_CD.equals("U")) COLNAME="ATT_U";
		else if(GUN_CD.equals("V")) COLNAME="ATT_V";
		else if(GUN_CD.equals("X")) COLNAME="ATT_X";
		else if(GUN_CD.equals("Z")) COLNAME="ATT_Z";
		else if(GUN_CD.equals("W")) COLNAME="ATW_CNT";
		else if(GUN_CD.equals("Y")) COLNAME="HOL_CNT";
		else if(GUN_CD.equals("T")) COLNAME="HOW_CNT";

		if("".equals(COLNAME))
			return;

		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= DECODE("+COLNAME+", null, 0, "+COLNAME+"+1),");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YY,
				PIS_MM,
				ENO_NO,
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	/**
	 *�����ް����������  ��ȸ��  DAO�޼ҵ�(��ü)
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND071_SHR_ACC_01(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_03");
		
		String eno_no = JSPUtil.rns(p_box.get("ENO_NO"));
		String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));
		String YYYY   = REQ_NO.substring(0,4);

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY,
				YYYY,
				"",
				YYYY,
				YYYY,
				mm1,
				REQ_NO,//p_box.get("REQ_GBN"),//��ü�� ������ ��
				YYYY,
				mm2,
				REQ_NO,//p_box.get("REQ_GBN"),//��ü�� ������ ��
				YYYY,
				mm3,
				REQ_NO,//p_box.get("REQ_GBN"),//��ü�� ������ ��
		};

		prop.add("END_TAG", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YRP_REM", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REM_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_OCT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_NOV", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_DEC", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);

	}
	/*
	 *�������ϳ�¥  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND071_SHR_ACC_02(CBox p_box) throws CException {
		String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));
		String YYYY   = REQ_NO.substring(0,4);
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_01");

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY+mm1+"01",
				YYYY+mm3+"31"
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);

	}
	/**
	 * �������������� T_DI_DILIGENCE�� �ݿ��� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_ACC_03(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMM = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
        String YYYY   = YYYYMM.substring(0,4);
        String MM     = YYYYMM.substring(4,6);
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_ACC_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY,
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}



	/**
	 * T_DI_DILIGENCE �� ���µ����͸� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_ACC_01(String eno_no, String dpt_cd, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_01");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYY = REQ_NO.substring(0,4);
		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				YYYY,
				eno_no,
				dpt_cd,
				YYYY,
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				YYYY,
				eno_no
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}
	/**
	 * �ް����������� T_DI_DILIGENCE�� �ݿ��� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_ACC_02(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYY   = REQ_NO.substring(0,4);
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_ACC_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YYYY,
				REQ_NO
		};

		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}
	/**
	 * ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA071_SHR_APP(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};



		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

}


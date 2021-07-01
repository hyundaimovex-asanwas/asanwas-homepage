package Ehr.gun.d.gund020.dao;

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

public class GUND020DAO extends AbstractDAO {
	/**
	 * GUND020DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUND020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 *�������ϳ�¥  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND020_SHR_01(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_01");

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY")+mm1+"01",
				p_box.get("PIS_YY")+mm3+"31"
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);

	}

	/**
	 *�����ް����������  ��ȸ��  DAO�޼ҵ�(��ü)
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND020_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_02");
		String eno_no = JSPUtil.rns(p_box.get("ENO_NO"));
		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
//		String gbn_cd = JSPUtil.rns(p_box.get("GBN_CD"));
		String team_cd = JSPUtil.rns(p_box.get("SESSION_TEAMCD"));
		//���ε��Ҷ� �־��� ���� ����

		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		StringBuffer sb3 = new StringBuffer();
		StringBuffer sb4 = new StringBuffer();

		if(p_box.get("SESSION_ENONO").equals("2040011")){
			sb.append("AND TEAM_CD = 'I151' \n");
		}

		if(p_box.get("SESSION_ENONO").equals("2050004")){
			sb2.append("AND GBN_CD != '3' AND GBN_CD != '5' AND NVL(TEAM_CD,' ') != 'I222' \n");
		}else if(p_box.get("SESSION_ENONO").equals("2070029")){
			sb2.append("AND GBN_CD != '3' AND GBN_CD != '5' AND NVL(TEAM_CD,' ') != 'I222' \n");
		}else if(p_box.get("SESSION_ENONO").equals("2120007")){
			sb2.append("AND GUN_DPT = 'I100' \n");
		}

		if((!p_box.get("SESSION_GBN_CD").equals("1"))&& (!p_box.get("SESSION_TEAM_CD").equals(""))){
			sb3.append("AND TEAM_CD = '"+team_cd+"' \n");
		}

		if(p_box.get("REQ_GBN").equals("0")){
			sb4.append("");
		}else if(p_box.get("REQ_GBN").equals("1")){
			sb4.append("WHERE NVL(REQ_GBN,' ') = 'Y'  \n");
		}else if(p_box.get("REQ_GBN").equals("2")){
			sb4.append("WHERE NVL(REQ_GBN,' ') <> 'Y' \n");
		}

		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb2.toString(),
				sb3.toString(),
				sb4.toString()
		};

		//p_box.set("DPT_CD", "1111");

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("SESSION_ENONO"),// �����ڿ���
				p_box.get("PIS_YY"),



				p_box.get("DPT_CD"),
				p_box.get("DPT_CD"),




				eno_no,
				p_box.get("PIS_YY"),
				mm1,
				p_box.get("PIS_YY"),
				mm1,
				"",//p_box.get("REQ_GBN"),//��ü�� ������ ��
				mm2,
				p_box.get("PIS_YY"),
				mm2,
				"",//p_box.get("REQ_GBN"),//��ü�� ������ ��
				mm3,
				p_box.get("PIS_YY"),
				mm3,
				"",//p_box.get("REQ_GBN"),//��ü�� ������ ��
		};

		prop.add("YRP_REM", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REM_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_OCT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_NOV", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_DEC", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);

	}


	/**
	 *�����ް���������� ������  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND020_SHR_04(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY")
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);

	}


	/**
	 *�����ް���������� ������  ������  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUND020_INS(GauceValueObject vo, CBox p_box, int mm) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_INS");

		String month = "";
		String md_dsp = "";
		String end_tag = "";

		String  mm1 = Integer.toString(mm);

		if (mm1.length() == 1) {
			mm1 = "0"+mm1;
		}

		if( mm == 1 || mm == 4 || mm == 7 || mm == 10 ) {
			month = "OCT";
			md_dsp = "31";
		}else if(mm == 2 || mm == 5 || mm == 8 || mm == 11){
			month = "NOV";
			md_dsp = "31";
		}else if(mm == 3 || mm == 6 || mm == 9 || mm == 12){
			month = "DEC";
			md_dsp = "31";
		}

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),                          		// �⵵
				mm1,                         	// ��
				vo.get("ENO_NO"),                          		// ���
				vo.get("DPT_CD"),								// �μ�
				md_dsp,                                         // �����ϼ�
				vo.get("AT1_"+month),                          	// 1�� ����
				vo.get("AT2_"+month),                          	// 2�� ����
				vo.get("AT3_"+month),                          	// 3�� ����
				vo.get("AT4_"+month),                          	// 4�� ����
				vo.get("AT5_"+month),                          	// 5�� ����
				vo.get("AT6_"+month),                          	// 6�� ����
				vo.get("AT7_"+month),                          	// 7�� ����
				vo.get("AT8_"+month),                          	// 8�� ����
				vo.get("AT9_"+month),                          	// 9�� ����
				vo.get("AT10_"+month),                        	// 10�� ����
				vo.get("AT11_"+month),                        	// 11�� ����
				vo.get("AT12_"+month),                        	// 12�� ����
				vo.get("AT13_"+month),                        	// 13�� ����
				vo.get("AT14_"+month),                        	// 14�� ����
				vo.get("AT15_"+month),                        	// 15�� ����
				vo.get("AT16_"+month),                        	// 16�� ����
				vo.get("AT17_"+month),                        	// 17�� ����
				vo.get("AT18_"+month),                        	// 18�� ����
				vo.get("AT19_"+month),                        	// 19�� ����
				vo.get("AT20_"+month),                        	// 20�� ����
				vo.get("AT21_"+month),                        	// 21�� ����
				vo.get("AT22_"+month),                        	// 22�� ����
				vo.get("AT23_"+month),                        	// 23�� ����
				vo.get("AT24_"+month),                        	// 24�� ����
				vo.get("AT25_"+month),                        	// 25�� ����
				vo.get("AT26_"+month),                        	// 26�� ����
				vo.get("AT27_"+month),                        	// 27�� ����
				vo.get("AT28_"+month),                        	// 28�� ����
				vo.get("AT29_"+month),                        	// 29�� ����
				vo.get("AT30_"+month),                        	// 30�� ����
				vo.get("AT31_"+month),                        	// 31�� ����
				vo.get("ATT_"+month),                         	// �հ�(����)
				"1",                            	// ��û����
				"", 		                            	// �����Է¿Ϸ�
				p_box.get("SESSION_ENONO"),     		// ������
				p_box.get("SESSION_ENONO"),     		// ������
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		this.insertProcess(sql, bind);

	}

	/**
	 *�����ް���������� ������  ������  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUND020_DEL(GauceValueObject vo, CBox p_box, int mm) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_DEL");

		String  mm1 = Integer.toString(mm);

		if (mm1.length() == 1) {
			mm1 = "0"+mm1;
		}
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),                           		// �⵵
				mm1,                           	// ��
				vo.get("ENO_NO"),                          		// ���

		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		this.deleteProcess(sql, bind);

	}
	/**
	 * ���缱 ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND020_SHR_05(CBox p_box) throws CException {

        String pis_yy = JSPUtil.rns(p_box.get("PIS_YY").replaceAll("-", "")) ;
        String pis_mm = pis_yy + JSPUtil.rns(p_box.get("PIS_MM").substring(0,2) ) ;
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_05");

		//if(p_box.get("SESSION_ENONO").equals("3100006")){

		//	p_box.set("DPT_CD", "I800");

		//}
        String dpt_cd  = p_box.get("DPT_CD");
        String team_cd = JSPUtil.rns(p_box.get("SESSION_TEAMCD"));

        StringBuffer sb = new StringBuffer();


		if(!p_box.get("SESSION_GBN_CD").equals("1")){
			sb.append("  WHERE NVL(GUN_DPT, TEAM_CD) IN  '"+team_cd+"' \n");
		}else if  (p_box.get("SESSION_GBN_CD").equals("1")){
			sb.append("WHERE NVL(GUN_DPT, DPT_CD) IN  '"+dpt_cd+"' \n");
		}


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		Object[] bind = new Object[] {
    			pis_yy,
    			pis_mm
		};

		return this.selectProcess(sql, bind, prop);
	}




	/**
	 * ��Ϲ�ȣ�� MaxPlusOne �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public String GUND020_SHR_MAX() throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNB020_REG_MAX");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		GauceDataSet ds = selectProcess(sql, bind);
		String reg_no = GauceUtils.nameValue(ds, 1, "REQ_NO");

		return reg_no;
	}
    /**
     * ���缱�� �����ϴ� DAO�޼ҵ�
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
    public void GUND020_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

        /** �ܺ� XML���� �����޹ݿ� (����) SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUND020_DEL_01");

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
	public void GUND020_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(p_box.get("SESSION_ENONO")),
				JSPUtil.rns(p_box.get("SESSION_ENONO")),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	/**
	 * �����ް������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND020_SHR_06(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String pis_yy = JSPUtil.rns(p_box.get("PIS_YY").replaceAll("-", "")) ;
		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
    			dpt_cd,
    			pis_yy,
    			mm1,
    			mm2,
    			mm3,
		};

		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * �����ް������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public  void GUND020_SHR_07(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_07");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_ENONO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * ���缱�� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUND020_INS_02(String PIS_YY, String PIS_MM, String ENO_NO, String REQ_NO ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_INS_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(REQ_NO),

                JSPUtil.rns(PIS_YY),
                JSPUtil.rns(PIS_MM),
                JSPUtil.rns(ENO_NO)
		};

		/** INSERT�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
}

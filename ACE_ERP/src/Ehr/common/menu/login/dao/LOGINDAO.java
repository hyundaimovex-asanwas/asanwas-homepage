package common.menu.login.dao;

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
import common.util.JSPUtil;


public class LOGINDAO extends AbstractDAO {
    /**
     * LOGINDAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public LOGINDAO(String p_conn, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_conn, p_tr);
	}

    /**
     * LOGIN DAO �޼���[GauceDataSet�� ��ȯ]
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet LOGIN_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� �������� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "LOGIN_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),
                p_box.get("KS_ID"),

		};

		this.prop.add("PWD_NO", ColumnProp.COLUMN_TYPE_STRING, 100, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		/**Query  ���� �� ��ȸ�� ����� ���콺 �����ͼ����� ��ȯ  **/
		return this.selectProcess(sql, bind, this.prop);

	}
	public GauceDataSet LOGIN_SHR_02(CBox p_box ) throws CException {

		/** �ܺ� XML���� �������� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "LOGIN_SHR_02");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),
                p_box.get("KS_ID"),

		};

		this.prop.add("PWD_NO", ColumnProp.COLUMN_TYPE_STRING, 100, ColumnProp.CONSTRAINT_TB_NORMAL);				
		
		/**Query  ���� �� ��ȸ�� ����� ���콺 �����ͼ����� ��ȯ  **/
		return this.selectProcess(sql, bind, this.prop);

	}

	/**
	 * ��й�ȣ ���� ī���� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void LOGIN_UPT(CBox p_box, String PWD_HLC_CNT) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "LOGIN_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				Integer.toString(Integer.parseInt(PWD_HLC_CNT)+1),
				p_box.get("GUBUN"),
                p_box.get("KS_ID"),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ��й�ȣ ���� ī���� �ʱ�ȭ
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void LOGIN_UPT_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "LOGIN_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				"0",
				p_box.get("GUBUN"),
				p_box.get("KS_ID"),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}





    public  GauceDataSet LOGIN_SHR_05(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("common", "LOGIN_SHR_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				  p_box.get("ENO_NO"),

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		 //updateProcess(sql, bind);

		 return this.selectProcess(sql, bind, this.prop);

	}




    public void LOGIN_UPT_05(CBox p_box) throws CException  {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("common", "LOGIN_UPT_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				 p_box.get("ENO_NO"),
		};


		updateProcess(sql, bind);
    }



    public void LOGIN_INS_05(CBox p_box) throws CException  {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("common", "LOGIN_INS_05");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				 p_box.get("ENO_NO"),
				 p_box.get("ENO_NO"),
				 p_box.get("ENO_NO"),
		};


		 insertProcess(sql, bind);
    }

    public  GauceDataSet LOGIN_SHR_06(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("common", "LOGIN_SHR_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				  p_box.get("ENO_NO").substring(3,10),

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		 //updateProcess(sql, bind);

		 return this.selectProcess(sql, bind, this.prop);

	}

    public  GauceDataSet LOGIN_SHR_07(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("common", "LOGIN_SHR_07");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				  p_box.get("ENO_NO").substring(3,10),

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		 //updateProcess(sql, bind);

		 return this.selectProcess(sql, bind, this.prop);

	}

    public void LOGIN_UPT_06(CBox p_box) throws CException  {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("common", "LOGIN_UPT_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				 p_box.get("ENO_NO").substring(3,10),
		};

		updateProcess(sql, bind);
   }

	/**
	 * GROUPWARE ���»����� ���� �ϴ� DAO�޼ҵ�(���� ������� ����)
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GROUPWARE_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA015_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(p_box.get("ENO_NO")),
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ���� ���� üũ�Ͽ� 'Y'�� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GROUPWARE_UPT_01(CBox p_box) throws CException {

		int cnt = 0;
		String sqlSHR = "";
		String preYYMM = "";
		String COLNAME = "";
		String sqlUPT = "";
		String GUN_YMD = JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "");

		GauceDataSet gsSHR = null;

		//�����ޱ��� ���� ��ȸ
		String   sql_05 = XmlSqlUtils.getSQL("gun", "GUNA010_SHR_05");
		Object[] bind_05 = new Object[] {
				GUN_YMD.substring(0,6),
				GUN_YMD.substring(0,6),
				GUN_YMD,
		};

		GauceDataSet gs = this.selectProcess(sql_05, bind_05, prop);

		//������
		if(gs.getDataRowCnt() > 0 && !GUN_YMD.substring(0,6).equals(gs.getDataRow(0).getString(0).substring(0,6))){

			//������ ���� ���� üũ
			sqlSHR = "SELECT ENO_NO FROM T_DI_DILIGENCE   \n";
			sqlSHR += "WHERE   PIS_YY = '"+gs.getDataRow(0).getString(0).substring(0,4)+"'  \n";
			sqlSHR += "AND     PIS_MM = '"+gs.getDataRow(0).getString(0).substring(4,6)+"'  \n";

			for(int i=0; i<gs.getDataRowCnt(); i++){
				if(i != 0 && !preYYMM.equals(gs.getDataRow(i).getString(0).substring(0,6))){
					break;
				}else if(i == 0){
					sqlSHR += "AND (  \n";
				}else{
					sqlSHR += "OR   ";
				}

				sqlSHR += "AT"+gs.getDataRow(i).getString(1)+"_CD IS NULL   \n";

				cnt++;
				preYYMM = gs.getDataRow(i).getString(0).substring(0,6);
			}

			sqlSHR += ")  \n";

			gsSHR = this.selectProcess(sqlSHR, new Object[]{}, prop);

			//������ �����ʵ忡 Y�� ǥ��
			if(gsSHR.getDataRowCnt() > 0){
				sqlUPT = "UPDATE  T_DI_DILIGENCE SET \n";

				for(int i=0; i<cnt; i++){

					COLNAME = "AT"+gs.getDataRow(i).getString(1)+"_CD";
					sqlUPT += COLNAME+ " = DECODE("+COLNAME+", NULL, 'Y', "+COLNAME+")   \n";

					if(i != cnt-1){
						sqlUPT += ",";
					}
				}
				sqlUPT += "WHERE   PIS_YY = '"+gs.getDataRow(0).getString(0).substring(0,4)+"'  \n";
				sqlUPT += "AND     PIS_MM = '"+gs.getDataRow(0).getString(0).substring(4,6)+"'  \n";

				updateProcess(sqlUPT, new Object[] {});
			}

		}

		//���ó�¥ ���� �����
		if(gs.getDataRowCnt() > cnt && GUN_YMD.substring(0,6).equals(gs.getDataRow(cnt).getString(0).substring(0,6))){

			//����� ���� ���� üũ
			sqlSHR = "SELECT ENO_NO FROM T_DI_DILIGENCE   \n";
			sqlSHR += "WHERE   PIS_YY = '"+gs.getDataRow(cnt).getString(0).substring(0,4)+"'  \n";
			sqlSHR += "AND     PIS_MM = '"+gs.getDataRow(cnt).getString(0).substring(4,6)+"'  \n";

			for(int i=cnt; i<gs.getDataRowCnt(); i++){
				if(i == cnt){
					sqlSHR += "AND (  \n";
				}else{
					sqlSHR += "OR   ";
				}

				sqlSHR += "AT"+gs.getDataRow(i).getString(1)+"_CD IS NULL   \n";
			}

			sqlSHR += ")  \n";

			gsSHR = this.selectProcess(sqlSHR, new Object[]{}, prop);

			//����� �����ʵ忡 Y�� ǥ��
			if(gsSHR.getDataRowCnt() > 0){
				sqlUPT = "UPDATE  T_DI_DILIGENCE SET \n";

				for(int i=cnt; i<gs.getDataRowCnt(); i++){

					COLNAME = "AT"+gs.getDataRow(i).getString(1)+"_CD";
					sqlUPT += COLNAME+ " = DECODE("+COLNAME+", NULL, 'Y', "+COLNAME+")   \n";

					if(i != gs.getDataRowCnt()-1){
						sqlUPT += ",";
					}
				}
				sqlUPT += "WHERE   PIS_YY = '"+gs.getDataRow(cnt).getString(0).substring(0,4)+"'  \n";
				sqlUPT += "AND     PIS_MM = '"+gs.getDataRow(cnt).getString(0).substring(4,6)+"'  \n";

				updateProcess(sqlUPT, new Object[] {});
			}

		}

	}
	/**
	 * T_DI_DILIGENCE �� ���µ����͸� �ݿ�
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GROUPWARE_INS_01(CBox p_box, String PIS_YYMMDD, String DPT_CD) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA015_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				PIS_YYMMDD.substring(0,4),
				p_box.get("ENO_NO"),
				DPT_CD,
				PIS_YYMMDD.substring(0,4),
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				PIS_YYMMDD.substring(0,4),
				p_box.get("ENO_NO"),
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
	public void GROUPWARE_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {
		String GUN_YMD = PIS_YYMMDD.replaceAll("-", "");
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");


		String COLNAME = "AT"+Integer.parseInt(GUN_YMD.substring(6,8))+"_CD = DECODE(AT"+Integer.parseInt(GUN_YMD.substring(6,8))+"_CD, null,'" + GUN_CD + "', AT"+Integer.parseInt(GUN_YMD.substring(6,8))+"_CD),";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME);

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				ENO_NO,
				GUN_YMD.substring(0, 4),
				GUN_YMD.substring(4, 6),
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
	public void GROUPWARE_UPT_02(String PIS_YYYYMMDD, String ENO_NO, CBox p_box) throws CException {

		String GUN_YMD = PIS_YYYYMMDD.replaceAll("-", "");

		// �� ī��Ʈ update
		String sqlSUM = XmlSqlUtils.getSQL("gun", "GUNA015_SHR_01");
		Object[] bindSUM = new Object[] {
			GUN_YMD.substring(0,4),
			GUN_YMD.substring(4,6),
			ENO_NO,
		};

		GauceDataSet gsSUM = this.selectProcess(sqlSUM, bindSUM, prop);

		GauceDataRow grRead = null;
		String sql = XmlSqlUtils.getSQL("gun", "GUNA010_UPT_02");//���º����û��Ȳ ���� ���

		for(int i=0; i<gsSUM.getDataRowCnt(); i++){
			grRead = gsSUM.getDataRow(i);
			ENO_NO = grRead.getString(0);

			int ATT_A     = 0;			int ATT_B     = 0;			int ATT_C     = 0;			int ATT_D     = 0;
			int ATT_E     = 0;			int ATT_F     = 0;			int ATT_G     = 0;			int ATT_H     = 0;
			int ATT_I     = 0;			int ATT_J     = 0;			int ATT_K     = 0;			int ATT_L     = 0;
			int ATT_M     = 0;			int ATT_N     = 0;			int ATT_O     = 0;			int ATT_P     = 0;
			int ATT_Q     = 0;			int ATT_R     = 0;			int ATT_S     = 0;			int ATT_U     = 0;
			int ATT_V     = 0;			int ATT_X     = 0;			int ATT_Z     = 0;			int ATW_CNT   = 0;
			int HOL_CNT   = 0;			int HOW_CNT   = 0;

			for(int j=1; j<gsSUM.getDataColCnt(); j++){
				if(grRead.getString(j) != null ){
					if(grRead.getString(j).equals("A")) ATT_A++;
					else if(grRead.getString(j).equals("B")) ATT_B++;
					else if(grRead.getString(j).equals("C")) ATT_C++;
					else if(grRead.getString(j).equals("D")) ATT_D++;
					else if(grRead.getString(j).equals("E")) ATT_E++;
					else if(grRead.getString(j).equals("F")) ATT_F++;
					else if(grRead.getString(j).equals("G")) ATT_G++;
					else if(grRead.getString(j).equals("H")) ATT_H++;
					else if(grRead.getString(j).equals("I")) ATT_I++;
					else if(grRead.getString(j).equals("J")) ATT_J++;
					else if(grRead.getString(j).equals("K")) ATT_K++;
					else if(grRead.getString(j).equals("L")) ATT_L++;
					else if(grRead.getString(j).equals("M")) ATT_M++;
					else if(grRead.getString(j).equals("N")) ATT_N++;
					else if(grRead.getString(j).equals("O")) ATT_O++;
					else if(grRead.getString(j).equals("P")) ATT_P++;
					else if(grRead.getString(j).equals("Q")) ATT_Q++;
					else if(grRead.getString(j).equals("R")) ATT_R++;
					else if(grRead.getString(j).equals("S")) ATT_S++;
					else if(grRead.getString(j).equals("U")) ATT_U++;
					else if(grRead.getString(j).equals("V")) ATT_V++;
					else if(grRead.getString(j).equals("X")) ATT_X++;
					else if(grRead.getString(j).equals("Z")) ATT_Z++;
					else if(grRead.getString(j).equals("W")) ATW_CNT++;
					else if(grRead.getString(j).equals("Y")) HOL_CNT++;
					else if(grRead.getString(j).equals("T")) HOW_CNT++;
				}
			}

			Object[] bind = new Object[] {
					ATT_A+"",
					ATT_B+"",
					ATT_C+"",
					ATT_D+"",
					ATT_E+"",
					ATT_F+"",
					ATT_G+"",
					ATT_H+"",
					ATT_I+"",
					ATT_J+"",
					ATT_K+"",
					ATT_L+"",
					ATT_M+"",
					ATT_N+"",
					ATT_O+"",
					ATT_P+"",
					ATT_Q+"",
					ATT_R+"",
					ATT_S+"",
					ATT_U+"",
					ATT_V+"",
					ATT_X+"",
					ATT_Z+"",
					ATW_CNT+"",
					HOL_CNT+"",
					HOW_CNT+"",
					ENO_NO,
					GUN_YMD.substring(0,4),
					GUN_YMD.substring(4,6),
					ENO_NO,
			};

			/** UPDATE�޼ҵ� ȣ��  **/
			updateProcess(sql, bind);
		}
	}
    public  GauceDataSet GROUPWARE_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("gun", "GUNA015_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				  p_box.get("ENO_NO"),

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		 //updateProcess(sql, bind);

		 return this.selectProcess(sql, bind, this.prop);

	}
}